#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRDB マージキー検証スクリプト（シンプル版）
"""
import psycopg2
import pandas as pd
import yaml

# DB設定読み込み
with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

conn_jravan = psycopg2.connect(**config['jravan'])
conn_jrdb = psycopg2.connect(**config['jrdb'])

# JRA-VAN キー取得
df_jv = pd.read_sql_query("""
    SELECT DISTINCT kaisai_nen, keibajo_code, kaisai_kai, kaisai_nichime, race_bango, umaban
    FROM jvd_se
    WHERE keibajo_code = '01' AND kaisai_nen = '2023'
    ORDER BY kaisai_kai, kaisai_nichime, race_bango, umaban
    LIMIT 10
""", conn_jravan)

# JRDB キー取得（変換済み）
df_jrdb = pd.read_sql_query("""
    SELECT 
        '20' || race_shikonen AS kaisai_nen,
        keibajo_code,
        kaisai_kai,
        kaisai_nichime,
        race_bango,
        umaban
    FROM jrd_kyi
    WHERE keibajo_code = '01' AND race_shikonen = '23'
    LIMIT 10
""", conn_jrdb)

# ゼロパディング適用
df_jrdb['kaisai_kai'] = df_jrdb['kaisai_kai'].astype(str).str.zfill(2)
df_jrdb['kaisai_nichime'] = df_jrdb['kaisai_nichime'].astype(str).str.zfill(2)

print("="*80)
print("【1】JRA-VAN キー")
print("="*80)
print(df_jv.head())

print("\n" + "="*80)
print("【2】JRDB キー（ゼロパディング後）")
print("="*80)
print(df_jrdb.head())

# マージテスト
merge_keys = ['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']
merged = df_jv.merge(df_jrdb, on=merge_keys, how='left', indicator=True)

print("\n" + "="*80)
print("【3】マージ結果")
print("="*80)
print(f"JRA-VAN行数: {len(df_jv)}")
print(f"JRDB行数: {len(df_jrdb)}")
print(f"マッチ件数: {(merged['_merge'] == 'both').sum()}")
print(f"未マッチ件数: {(merged['_merge'] == 'left_only').sum()}")

if (merged['_merge'] == 'both').sum() > 0:
    print("\n✅ マージ成功！")
else:
    print("\n❌ マージ失敗！キー不一致")
    print("\nJRA-VAN側の最初の2行:")
    print(df_jv[merge_keys].head(2))
    print("\nJRDB側の最初の2行:")
    print(df_jrdb[merge_keys].head(2))

conn_jravan.close()
conn_jrdb.close()
