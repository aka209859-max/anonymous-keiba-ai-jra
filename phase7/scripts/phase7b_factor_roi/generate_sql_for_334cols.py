#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-B: 334カラムSQL自動生成スクリプト

【目的】
- PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv を読み込み
- JRA-VAN 218列 + JRDB 116列の完全なSELECT文を自動生成
- 生成したSQLを create_merged_dataset_334cols.py にコピペで使用可能

【入力ファイル】
E:\\anonymous-keiba-ai-JRA\\docs\\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv

【出力ファイル】
E:\\anonymous-keiba-ai-JRA\\phase7\\scripts\\phase7b\\generated_sql_334cols.sql

【実行方法】
cd E:\\anonymous-keiba-ai-JRA\\phase7\\scripts\\phase7b
python generate_sql_for_334cols.py
"""

import os
import pandas as pd
from collections import defaultdict

# ====================
# 設定
# ====================
INPUT_CSV = r'E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv'
OUTPUT_SQL = r'E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi\generated_sql_334cols.sql'

# ====================
# メイン処理
# ====================
def main():
    print("=" * 80)
    print("Phase 7-B: 334カラムSQL自動生成スクリプト")
    print("=" * 80)
    print()
    
    # 1. CSV読み込み
    print(f"📂 CSV読み込み中: {INPUT_CSV}")
    try:
        df = pd.read_csv(INPUT_CSV, encoding='utf-8-sig')
        print(f"   ✅ 完了: {len(df)} 行読み込み")
    except Exception as e:
        print(f"   ❌ エラー: {e}")
        return
    print()
    
    # 2. テーブル別にカラムをグループ化
    print("📊 テーブル別カラム整理中...")
    table_columns = defaultdict(list)
    
    for _, row in df.iterrows():
        table_name = row['table_name']
        column_name = row['column_name']
        japanese_name = row.get('japanese_name', '')
        
        table_columns[table_name].append({
            'column': column_name,
            'japanese': japanese_name
        })
    
    print(f"   ✅ {len(table_columns)} テーブル検出")
    print()
    
    # 3. テーブル別にカラム数を表示
    print("【テーブル別カラム数】")
    print("-" * 80)
    total_cols = 0
    for table, cols in sorted(table_columns.items()):
        print(f"  {table:20s} : {len(cols):3d} カラム")
        total_cols += len(cols)
    print("-" * 80)
    print(f"  {'合計':20s} : {total_cols:3d} カラム")
    print()
    
    # 4. SQL生成（LEFT JOINベース）
    print("🔧 SQL生成中...")
    
    # 4-1. JRA-VANメインテーブル（jvd_se）のカラム
    jvd_se_cols = table_columns.get('jvd_se', [])
    
    # 4-2. その他JRA-VANテーブルのカラム
    jvd_tables = {
        'jvd_ra': 'ra',
        'jvd_ck': 'ck',
        'jvd_um': 'um',
        'jvd_hr': 'hr',
        'jvd_h1': 'h1',
        'jvd_h6': 'h6',
        'jvd_dm': 'dm',
        'jvd_bt': 'bt',
        'jvd_wc': 'wc',
        'jvd_hc': 'hc',
        'jvd_ch': 'ch',
        'jvd_hn': 'hn',
        'jvd_br': 'br',
        'jvd_jg': 'jg',
        'jvd_sk': 'sk'
    }
    
    # 4-3. JRDBテーブルのカラム
    jrdb_tables = {
        'jrd_kyi': 'kyi',
        'jrd_cyb': 'cyb',
        'jrd_sed': 'sed',
        'jrd_joa': 'joa',
        'jrd_bac': 'bac'
    }
    
    # SQL文を構築
    sql_lines = []
    sql_lines.append("SELECT")
    sql_lines.append("    -- ========================================")
    sql_lines.append("    -- 主キー（3列）")
    sql_lines.append("    -- ========================================")
    sql_lines.append("    se.race_id,")
    sql_lines.append("    se.umaban,")
    sql_lines.append("    se.kaisai_tsukihi,")
    sql_lines.append("")
    
    # jvd_se の残りカラム（主キー以外）
    sql_lines.append("    -- ========================================")
    sql_lines.append("    -- JRA-VAN: jvd_se（レース成績）")
    sql_lines.append("    -- ========================================")
    
    for i, col_info in enumerate(jvd_se_cols):
        col = col_info['column']
        jp = col_info['japanese']
        
        # 主キー3列はスキップ
        if col in ['race_id', 'umaban', 'kaisai_tsukihi']:
            continue
        
        comment = f" -- {jp}" if jp else ""
        comma = "," if i < len(jvd_se_cols) - 1 or len(jvd_tables) > 0 or len(jrdb_tables) > 0 else ""
        sql_lines.append(f"    se.{col}{comma}{comment}")
    
    sql_lines.append("")
    
    # その他JRA-VANテーブル
    for table_full, alias in jvd_tables.items():
        cols = table_columns.get(table_full, [])
        if not cols:
            continue
        
        sql_lines.append(f"    -- ========================================")
        sql_lines.append(f"    -- JRA-VAN: {table_full} ({len(cols)}列)")
        sql_lines.append(f"    -- ========================================")
        
        for i, col_info in enumerate(cols):
            col = col_info['column']
            jp = col_info['japanese']
            comment = f" -- {jp}" if jp else ""
            comma = ","
            sql_lines.append(f"    {alias}.{col}{comma}{comment}")
        
        sql_lines.append("")
    
    # JRDBテーブル
    for table_full, alias in jrdb_tables.items():
        cols = table_columns.get(table_full, [])
        if not cols:
            continue
        
        sql_lines.append(f"    -- ========================================")
        sql_lines.append(f"    -- JRDB: {table_full} ({len(cols)}列)")
        sql_lines.append(f"    -- ========================================")
        
        for i, col_info in enumerate(cols):
            col = col_info['column']
            jp = col_info['japanese']
            comment = f" -- {jp}" if jp else ""
            
            # 最後のテーブルの最後のカラムはカンマなし
            is_last_table = (table_full == list(jrdb_tables.keys())[-1])
            is_last_col = (i == len(cols) - 1)
            comma = "" if (is_last_table and is_last_col) else ","
            
            sql_lines.append(f"    {alias}.{col}{comma}{comment}")
        
        sql_lines.append("")
    
    # FROM句とJOIN句
    sql_lines.append("FROM jvd_se AS se")
    
    # JRA-VAN テーブル JOIN
    for table_full, alias in jvd_tables.items():
        if table_full in table_columns:
            sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id")
    
    # JRDB テーブル JOIN
    for table_full, alias in jrdb_tables.items():
        if table_full in table_columns:
            if table_full == 'jrd_bac':
                # jrd_bac はレース単位（umaban不要）
                sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id")
            else:
                # その他は馬単位（umaban必要）
                sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id AND se.umaban = {alias}.umaban")
    
    # WHERE句
    sql_lines.append("WHERE kyi.race_shikonen ~ '^[0-9]+$'")
    sql_lines.append("  AND CAST(kyi.race_shikonen AS INTEGER) < 260201")
    sql_lines.append("ORDER BY se.race_id, se.umaban;")
    
    # SQL文字列化
    sql_text = "\n".join(sql_lines)
    
    print("   ✅ 完了")
    print()
    
    # 5. SQL保存
    print(f"💾 SQL保存中: {OUTPUT_SQL}")
    try:
        with open(OUTPUT_SQL, 'w', encoding='utf-8') as f:
            f.write(sql_text)
        print(f"   ✅ 保存完了")
        print(f"   ファイルサイズ: {len(sql_text):,} バイト")
    except Exception as e:
        print(f"   ❌ エラー: {e}")
        return
    print()
    
    # 6. プレビュー表示
    print("=" * 80)
    print("📋 生成SQL（最初の50行）")
    print("=" * 80)
    for i, line in enumerate(sql_lines[:50], 1):
        print(f"{i:3d} | {line}")
    
    if len(sql_lines) > 50:
        print(f"... (残り {len(sql_lines) - 50} 行)")
    print()
    
    # 7. 完了メッセージ
    print("=" * 80)
    print("🎉 SQL自動生成完了！")
    print("=" * 80)
    print()
    print("【次のステップ】")
    print(f"1. 生成されたSQLファイルを確認:")
    print(f"   → notepad {OUTPUT_SQL}")
    print()
    print(f"2. create_merged_dataset_334cols.py の sql 変数に貼り付け")
    print()
    print(f"3. データセット作成スクリプト実行:")
    print(f"   → python create_merged_dataset_334cols.py")
    print()

if __name__ == '__main__':
    main()
