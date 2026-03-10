#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-B: JRA-VAN (218列) + JRDB (116列) 統合データセット作成スクリプト（自動SQL生成版）

【目的】
- PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv からSQL自動生成
- PostgreSQL (pckeiba) から JRA-VAN + JRDB データを取得
- 334カラムに統合して CSV 出力
- 期間: 2016-2025年（確定レースのみ、race_shikonen < 260201）
- 出力行数: 約460,424行

【出力先】
E:\\anonymous-keiba-ai-JRA\\phase7\\results\\phase7b_roi\\jravan_jrdb_merged_334cols_2016_2025.csv

【実行方法】
cd E:\\anonymous-keiba-ai-JRA\\phase7\\scripts\\phase7b
python create_merged_dataset_334cols.py

【予想処理時間】
約10-15分（データ量460,424行 × 334列 ≈ 125.5 MB）
"""

import os
import sys
import psycopg2
import pandas as pd
from datetime import datetime
from collections import defaultdict

# ====================
# 設定
# ====================
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

INPUT_CSV = r'E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv'
OUTPUT_DIR = r'E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi'
OUTPUT_FILE = 'jravan_jrdb_merged_334cols_2016_2025.csv'
OUTPUT_PATH = os.path.join(OUTPUT_DIR, OUTPUT_FILE)

# ====================
# SQL自動生成関数
# ====================
def generate_sql_from_csv(csv_path):
    """
    CSVファイルから334カラムのSELECT文を自動生成
    """
    print("🔧 SQL自動生成中...")
    
    # CSV読み込み
    df = pd.read_csv(csv_path, encoding='utf-8-sig')
    
    # テーブル別にカラムをグループ化
    table_columns = defaultdict(list)
    
    for _, row in df.iterrows():
        table_name = row['table_name']
        column_name = row['column_name']
        japanese_name = row.get('japanese_name', '')
        
        table_columns[table_name].append({
            'column': column_name,
            'japanese': japanese_name
        })
    
    # テーブル別カラム数表示
    print("\n【テーブル別カラム数】")
    print("-" * 80)
    total_cols = 0
    for table, cols in sorted(table_columns.items()):
        print(f"  {table:20s} : {len(cols):3d} カラム")
        total_cols += len(cols)
    print("-" * 80)
    print(f"  {'合計':20s} : {total_cols:3d} カラム\n")
    
    # テーブル定義
    jvd_se_cols = table_columns.get('jvd_se', [])
    
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
    
    jrdb_tables = {
        'jrd_kyi': 'kyi',
        'jrd_cyb': 'cyb',
        'jrd_sed': 'sed',
        'jrd_joa': 'joa',
        'jrd_bac': 'bac'
    }
    
    # SQL構築
    sql_lines = []
    sql_lines.append("SELECT")
    sql_lines.append("    -- 主キー（3列）")
    sql_lines.append("    se.race_id,")
    sql_lines.append("    se.umaban,")
    sql_lines.append("    se.kaisai_tsukihi,")
    sql_lines.append("")
    
    # jvd_se の残りカラム（主キー以外）
    sql_lines.append("    -- JRA-VAN: jvd_se")
    for col_info in jvd_se_cols:
        col = col_info['column']
        if col in ['race_id', 'umaban', 'kaisai_tsukihi']:
            continue
        sql_lines.append(f"    se.{col},")
    sql_lines.append("")
    
    # その他JRA-VANテーブル
    for table_full, alias in jvd_tables.items():
        cols = table_columns.get(table_full, [])
        if not cols:
            continue
        
        sql_lines.append(f"    -- JRA-VAN: {table_full}")
        for col_info in cols:
            col = col_info['column']
            sql_lines.append(f"    {alias}.{col},")
        sql_lines.append("")
    
    # JRDBテーブル
    for idx, (table_full, alias) in enumerate(jrdb_tables.items()):
        cols = table_columns.get(table_full, [])
        if not cols:
            continue
        
        sql_lines.append(f"    -- JRDB: {table_full}")
        
        is_last_table = (idx == len(jrdb_tables) - 1)
        
        for i, col_info in enumerate(cols):
            col = col_info['column']
            is_last_col = (i == len(cols) - 1)
            
            # 最後のテーブルの最後のカラムはカンマなし
            if is_last_table and is_last_col:
                sql_lines.append(f"    {alias}.{col}")
            else:
                sql_lines.append(f"    {alias}.{col},")
        
        sql_lines.append("")
    
    # FROM句とJOIN句
    sql_lines.append("FROM jvd_se AS se")
    
    for table_full, alias in jvd_tables.items():
        if table_full in table_columns:
            sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id")
    
    for table_full, alias in jrdb_tables.items():
        if table_full in table_columns:
            if table_full == 'jrd_bac':
                sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id")
            else:
                sql_lines.append(f"LEFT JOIN {table_full} AS {alias} ON se.race_id = {alias}.race_id AND se.umaban = {alias}.umaban")
    
    # WHERE句
    sql_lines.append("WHERE kyi.race_shikonen ~ '^[0-9]+$'")
    sql_lines.append("  AND CAST(kyi.race_shikonen AS INTEGER) < 260201")
    sql_lines.append("ORDER BY se.race_id, se.umaban;")
    
    sql_text = "\n".join(sql_lines)
    
    print("   ✅ SQL自動生成完了")
    print(f"   総行数: {len(sql_lines)} 行")
    print()
    
    return sql_text

# ====================
# メイン処理
# ====================
def main():
    print("=" * 80)
    print("Phase 7-B: JRA-VAN + JRDB 統合データセット作成（自動SQL生成版）")
    print(f"実行時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 80)
    print()
    
    # 1. 出力ディレクトリ作成
    print(f"📂 出力ディレクトリ作成: {OUTPUT_DIR}")
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    print("   ✅ 完了\n")
    
    # 2. CSV確認
    print(f"📄 CSV確認: {INPUT_CSV}")
    if not os.path.exists(INPUT_CSV):
        print(f"   ❌ ファイルが見つかりません: {INPUT_CSV}")
        sys.exit(1)
    print("   ✅ 確認完了\n")
    
    # 3. SQL自動生成
    try:
        sql = generate_sql_from_csv(INPUT_CSV)
    except Exception as e:
        print(f"   ❌ SQL生成失敗: {e}")
        sys.exit(1)
    
    # 4. PostgreSQL接続
    print("🔌 PostgreSQL接続中...")
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("   ✅ 接続成功\n")
    except Exception as e:
        print(f"   ❌ 接続失敗: {e}")
        sys.exit(1)
    
    # 5. データ取得
    print("📊 データ取得中（約10-15分かかる可能性があります）...")
    print("   対象期間: 2016-2025年（確定レースのみ）")
    print("   予想行数: 約460,424行\n")
    
    try:
        df = pd.read_sql(sql, conn)
        print(f"   ✅ 取得完了: {len(df):,} 行 × {len(df.columns)} 列\n")
    except Exception as e:
        print(f"   ❌ 取得失敗: {e}")
        conn.close()
        sys.exit(1)
    
    conn.close()
    
    # 6. 基本統計情報
    print("=" * 80)
    print("📈 データ概要")
    print("=" * 80)
    print(f"行数: {len(df):,}")
    print(f"列数: {len(df.columns)}")
    print(f"メモリ使用量: {df.memory_usage(deep=True).sum() / 1024**2:.1f} MB\n")
    
    print("【最初の5行】")
    print(df.head())
    print()
    
    print("【欠損値サマリー】")
    missing = df.isnull().sum()
    missing_pct = (missing / len(df) * 100).round(2)
    missing_df = pd.DataFrame({
        'カラム': missing.index,
        '欠損数': missing.values,
        '欠損率(%)': missing_pct.values
    })
    missing_df = missing_df[missing_df['欠損数'] > 0].sort_values('欠損数', ascending=False)
    
    if len(missing_df) > 0:
        print(missing_df.head(20).to_string(index=False))
        if len(missing_df) > 20:
            print(f"\n... (残り {len(missing_df) - 20} カラム)")
    else:
        print("✅ 欠損値なし（すべて100%充填）")
    print()
    
    # 7. CSV保存
    print("=" * 80)
    print("💾 CSV保存中...")
    print("=" * 80)
    print(f"保存先: {OUTPUT_PATH}\n")
    
    try:
        df.to_csv(OUTPUT_PATH, index=False, encoding='utf-8-sig')
        file_size_mb = os.path.getsize(OUTPUT_PATH) / 1024**2
        print(f"   ✅ 保存完了")
        print(f"   ファイルサイズ: {file_size_mb:.1f} MB\n")
    except Exception as e:
        print(f"   ❌ 保存失敗: {e}")
        sys.exit(1)
    
    # 8. 完了メッセージ
    print("=" * 80)
    print("🎉 Phase 7-B 統合データセット作成完了！")
    print("=" * 80)
    print()
    print("【次のステップ】")
    print("1. 単一カラムROI分析スクリプト実行")
    print("   → python single_column_roi_analysis.py")
    print()
    print("2. Top 100カラム選定")
    print("   → ROI ≥ 105%のカラムを抽出")
    print()
    print(f"完了時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 80)

if __name__ == '__main__':
    main()
