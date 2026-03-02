#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
jrd_sed テーブル診断スクリプト
"""
import psycopg2
import yaml

with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

conn = psycopg2.connect(**config['jrdb'])
cursor = conn.cursor()

print("="*80)
print("【1】jrd_sed テーブル基本情報")
print("="*80)

# 総件数
cursor.execute('SELECT COUNT(*) FROM jrd_sed;')
total_count = cursor.fetchone()[0]
print(f'総件数: {total_count:,}件')

# カラム一覧
cursor.execute("""
    SELECT column_name 
    FROM information_schema.columns 
    WHERE table_name = 'jrd_sed' 
    ORDER BY ordinal_position;
""")
columns = [row[0] for row in cursor.fetchall()]
print(f'カラム数: {len(columns)}列')
print(f'主要カラム: {", ".join(columns[:20])}')

print("\n" + "="*80)
print("【2】2023年札幌のデータ確認")
print("="*80)

# kaisai_nen を使った検索
try:
    cursor.execute("""
        SELECT COUNT(*) FROM jrd_sed 
        WHERE keibajo_code = '01' 
          AND kaisai_nen = '2023';
    """)
    count_2023 = cursor.fetchone()[0]
    print(f'kaisai_nen = "2023" の件数: {count_2023:,}件')
except Exception as e:
    print(f'kaisai_nen での検索エラー: {e}')
    count_2023 = 0

# race_shikonen を使った検索
try:
    cursor.execute("""
        SELECT COUNT(*) FROM jrd_sed 
        WHERE keibajo_code = '01' 
          AND race_shikonen = '23';
    """)
    count_shikonen = cursor.fetchone()[0]
    print(f'race_shikonen = "23" の件数: {count_shikonen:,}件')
except Exception as e:
    print(f'race_shikonen での検索エラー: {e}')
    count_shikonen = 0

print("\n" + "="*80)
print("【3】サンプルデータ")
print("="*80)

# データがある方でサンプル取得
if count_shikonen > 0:
    cursor.execute("""
        SELECT kaisai_nen, kaisai_tsukihi, keibajo_code, kaisai_kai, 
               kaisai_nichime, race_bango, umaban, ketto_toroku_bango,
               pace, deokure, furi, furi_1, furi_2, furi_3, batai_code
        FROM jrd_sed 
        WHERE keibajo_code = '01' AND race_shikonen = '23'
        ORDER BY kaisai_nen, kaisai_tsukihi, race_bango, umaban
        LIMIT 5;
    """)
    print("race_shikonen = '23' のサンプル:")
    for row in cursor.fetchall():
        print(row)
elif count_2023 > 0:
    cursor.execute("""
        SELECT kaisai_nen, kaisai_tsukihi, keibajo_code, kaisai_kai, 
               kaisai_nichime, race_bango, umaban, ketto_toroku_bango,
               pace, deokure, furi, furi_1, furi_2, furi_3, batai_code
        FROM jrd_sed 
        WHERE keibajo_code = '01' AND kaisai_nen = '2023'
        ORDER BY kaisai_nen, kaisai_tsukihi, race_bango, umaban
        LIMIT 5;
    """)
    print("kaisai_nen = '2023' のサンプル:")
    for row in cursor.fetchall():
        print(row)
else:
    print("⚠️ 2023年札幌のデータが見つかりません")
    # 任意の1件を取得
    cursor.execute("""
        SELECT kaisai_nen, kaisai_tsukihi, keibajo_code, kaisai_kai, 
               kaisai_nichime, race_bango, umaban, ketto_toroku_bango,
               pace, deokure, furi, furi_1, furi_2, furi_3, batai_code
        FROM jrd_sed 
        LIMIT 5;
    """)
    print("任意のサンプルデータ:")
    for row in cursor.fetchall():
        print(row)

print("\n" + "="*80)
print("【4】キー構造の確認")
print("="*80)

# 年度カラムの確認
cursor.execute("""
    SELECT DISTINCT 
        CASE 
            WHEN kaisai_nen IS NOT NULL THEN '4桁年 (kaisai_nen)'
            WHEN race_shikonen IS NOT NULL THEN '2桁年 (race_shikonen)'
            ELSE '不明'
        END AS year_column_type
    FROM jrd_sed
    LIMIT 1;
""")
year_type = cursor.fetchone()
if year_type:
    print(f"年度カラム: {year_type[0]}")

conn.close()
print("\n" + "="*80)
print("診断完了")
print("="*80)
