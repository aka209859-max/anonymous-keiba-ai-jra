#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
デバッグスクリプト: JRA-VAN と JRDB のマージキー検証
"""

import psycopg2
import pandas as pd
import yaml
import sys

def main():
    # DB設定読み込み
    with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    # JRA-VAN接続
    conn_jravan = psycopg2.connect(**config['jravan'])
    conn_jrdb = psycopg2.connect(**config['jrdb'])
    
    print("="*80)
    print("【1】JRA-VAN (jvd_se) のキー構造")
    print("="*80)
    
    query_jravan = """
        SELECT DISTINCT
            kaisai_nen, keibajo_code, kaisai_kai, kaisai_nichime, race_bango, umaban
        FROM jvd_se
        WHERE keibajo_code = '01' AND kaisai_nen = '2023'
        ORDER BY kaisai_kai, kaisai_nichime, race_bango, umaban
        LIMIT 10
    """
    df_jravan = pd.read_sql_query(query_jravan, conn_jravan)
    print(df_jravan)
    print(f"\nデータ型:")
    print(df_jravan.dtypes)
    
    print("\n" + "="*80)
    print("【2】JRDB (jrd_kyi) のキー構造（変換前）")
    print("="*80)
    
    query_jrdb_raw = """
        SELECT 
            race_shikonen, keibajo_code, kaisai_kai, kaisai_nichime, race_bango, umaban
        FROM jrd_kyi
        WHERE keibajo_code = '01' AND race_shikonen = '23'
        ORDER BY kaisai_kai, kaisai_nichime, race_bango, umaban
        LIMIT 10
    """
    df_jrdb_raw = pd.read_sql_query(query_jrdb_raw, conn_jrdb)
    print(df_jrdb_raw)
    print(f"\nデータ型:")
    print(df_jrdb_raw.dtypes)
    
    print("\n" + "="*80)
    print("【3】JRDB キーを変換後（スクリプトの処理を再現）")
    print("="*80)
    
    query_jrdb_converted = """
        SELECT 
            '20' || race_shikonen AS kaisai_nen,
            keibajo_code,
            race_shikonen,
            kaisai_kai,
            kaisai_nichime,
            race_bango,
            umaban
        FROM jrd_kyi
        WHERE keibajo_code = '01' AND race_shikonen = '23'
        LIMIT 10
    """
    df_jrdb_converted = pd.read_sql_query(query_jrdb_converted, conn_jrdb)
    
    # ゼロパディング処理（スクリプトと同じ）
    df_jrdb_converted['kaisai_kai'] = df_jrdb_converted['kaisai_kai'].astype(str).str.zfill(2)
    df_jrdb_converted['kaisai_nichime'] = df_jrdb_converted['kaisai_nichime'].astype(str).str.zfill(2)
    
    print(df_jrdb_converted[['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']])
    print(f"\nデータ型:")
    print(df_jrdb_converted.dtypes)
    
    print("\n" + "="*80)
    print("【4】マージテスト")
    print("="*80)
    
    merge_keys = ['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']
    
    # サンプルマージ
    merged = df_jravan.merge(
        df_jrdb_converted[merge_keys + ['race_shikonen']], 
        on=merge_keys, 
        how='left',
        indicator=True
    )
    
    print(f"JRA-VAN行数: {len(df_jravan)}")
    print(f"JRDB行数: {len(df_jrdb_converted)}")
    print(f"マージ後行数: {len(merged)}")
    print(f"\nマージ結果統計:")
    print(merged['_merge'].value_counts())
    
    print("\n最初の5行:")
    print(merged.head())
    
    # マッチしなかった行を表示
    unmatched = merged[merged['_merge'] == 'left_only']
    if len(unmatched) > 0:
        print(f"\n⚠️ マッチしなかった行: {len(unmatched)}件")
        print("最初の5件:")
        print(unmatched[merge_keys].head())
        
        print("\nJRDB側の最初の5件（比較用）:")
        print(df_jrdb_converted[merge_keys].head())
    else:
        print("\n✅ 全ての行がマッチしました！")
    
    conn_jravan.close()
    conn_jrdb.close()

if __name__ == '__main__':
    main()
