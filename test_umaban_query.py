#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
PostgreSQLのse.umabanカラムのデータ型とフィルター動作を確認
"""

import psycopg2
import yaml

# DB設定を読み込み
with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

db_config = config['jravan'].copy()
db_config['database'] = 'pckeiba'

# 接続
conn = psycopg2.connect(
    host=db_config['host'],
    port=db_config['port'],
    database=db_config['database'],
    user=db_config['user'],
    password=db_config['password']
)

cur = conn.cursor()

print("="*80)
print("PostgreSQL jvd_se.umaban カラム調査")
print("="*80)

# 1. データ型確認
print("\n1. umabanカラムのデータ型:")
cur.execute("""
    SELECT column_name, data_type, character_maximum_length
    FROM information_schema.columns
    WHERE table_name = 'jvd_se' AND column_name = 'umaban'
""")
result = cur.fetchone()
if result:
    print(f"   列名: {result[0]}")
    print(f"   型: {result[1]}")
    print(f"   最大長: {result[2]}")
else:
    print("   ❌ umabanカラムが見つかりません")

# 2. 馬番99の存在確認（東京・2016-2025）
print("\n2. 馬番99のレコード数（東京・2016-2025）:")
cur.execute("""
    SELECT COUNT(*)
    FROM jvd_se se
    WHERE se.keibajo_code = '05'
      AND CAST(se.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
      AND se.umaban = '99'
""")
count_str = cur.fetchone()[0]
print(f"   umaban = '99' (文字列比較): {count_str}件")

cur.execute("""
    SELECT COUNT(*)
    FROM jvd_se se
    WHERE se.keibajo_code = '05'
      AND CAST(se.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
      AND CAST(se.umaban AS INTEGER) = 99
""")
count_int = cur.fetchone()[0]
print(f"   CAST(umaban AS INTEGER) = 99: {count_int}件")

# 3. フィルター動作確認
print("\n3. フィルター動作テスト:")

# 3-1. フィルターなし
cur.execute("""
    SELECT COUNT(*)
    FROM jvd_se se
    WHERE se.keibajo_code = '05'
      AND CAST(se.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
""")
total_no_filter = cur.fetchone()[0]
print(f"   フィルターなし: {total_no_filter}件")

# 3-2. フィルターあり（CAST）
cur.execute("""
    SELECT COUNT(*)
    FROM jvd_se se
    WHERE se.keibajo_code = '05'
      AND CAST(se.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
      AND CAST(se.umaban AS INTEGER) <= 18
""")
total_with_filter = cur.fetchone()[0]
print(f"   CAST(umaban AS INTEGER) <= 18: {total_with_filter}件")
print(f"   差分（除外された件数）: {total_no_filter - total_with_filter}件")

# 4. 馬番99の詳細
print("\n4. 馬番99の詳細（先頭5件）:")
cur.execute("""
    SELECT kaisai_nen, kaisai_tsukihi, race_bango, umaban, ketto_toroku_bango
    FROM jvd_se se
    WHERE se.keibajo_code = '05'
      AND CAST(se.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
      AND se.umaban = '99'
    ORDER BY kaisai_nen, kaisai_tsukihi, race_bango
    LIMIT 5
""")
for row in cur.fetchall():
    print(f"   {row[0]}-{row[1]} R{row[2]} 馬番{row[3]} 血統{row[4]}")

# 5. jvd_raとのJOIN後のカウント
print("\n5. jvd_raとJOIN後のカウント:")
cur.execute("""
    SELECT COUNT(*)
    FROM jvd_ra ra
    INNER JOIN jvd_se se ON (
        ra.kaisai_nen = se.kaisai_nen
        AND ra.kaisai_tsukihi = se.kaisai_tsukihi
        AND ra.keibajo_code = se.keibajo_code
        AND ra.kaisai_kai = se.kaisai_kai
        AND ra.kaisai_nichime = se.kaisai_nichime
        AND ra.race_bango = se.race_bango
    )
    WHERE ra.keibajo_code = '05'
      AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
""")
join_no_filter = cur.fetchone()[0]
print(f"   フィルターなし: {join_no_filter}件")

cur.execute("""
    SELECT COUNT(*)
    FROM jvd_ra ra
    INNER JOIN jvd_se se ON (
        ra.kaisai_nen = se.kaisai_nen
        AND ra.kaisai_tsukihi = se.kaisai_tsukihi
        AND ra.keibajo_code = se.keibajo_code
        AND ra.kaisai_kai = se.kaisai_kai
        AND ra.kaisai_nichime = se.kaisai_nichime
        AND ra.race_bango = se.race_bango
    )
    WHERE ra.keibajo_code = '05'
      AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN 2016 AND 2025
      AND CAST(se.umaban AS INTEGER) <= 18
""")
join_with_filter = cur.fetchone()[0]
print(f"   CAST(umaban AS INTEGER) <= 18: {join_with_filter}件")
print(f"   差分: {join_no_filter - join_with_filter}件")

cur.close()
conn.close()

print("\n" + "="*80)
print("調査完了")
print("="*80)

