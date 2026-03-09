#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-B Step 3: JRDB データ結合（48列化）

目的: 基本データ（41列）と過去走データ（7列）を結合して48列データセットを作成
入力: 
  - data/raw/jrdb_basic_41cols.csv (481,627件 × 46列)
  - data/raw/jrdb_past_7cols.csv (481,627件 × 12列)
出力: data/raw/jrdb_48cols.csv (481,627件 × 53列)
"""

import pandas as pd
from pathlib import Path
import logging
from datetime import datetime
import sys

# ログ設定
log_dir = Path("logs")
log_dir.mkdir(exist_ok=True)
log_file = log_dir / "phase1b_step3_merge.log"

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

def main():
    start_time = datetime.now()
    logging.info("=" * 70)
    logging.info("Phase 1-B Step 3: JRDB データ結合開始")
    logging.info("=" * 70)
    
    # データ読み込み
    data_dir = Path("data/raw")
    basic_file = data_dir / "jrdb_basic_41cols.csv"
    past_file = data_dir / "jrdb_past_7cols.csv"
    
    logging.info(f"📖 基本データ読み込み: {basic_file}")
    df_basic = pd.read_csv(basic_file, encoding='utf-8-sig')
    logging.info(f"  {len(df_basic):,} 件 × {len(df_basic.columns)} 列")
    
    logging.info(f"📖 過去走データ読み込み: {past_file}")
    df_past = pd.read_csv(past_file, encoding='utf-8-sig')
    logging.info(f"  {len(df_past):,} 件 × {len(df_past.columns)} 列")
    
    # 結合キー
    merge_keys = ['ketto_toroku_bango', 'keibajo_code', 'race_shikonen', 
                  'kaisai_kai', 'kaisai_nichime']
    
    logging.info(f"\n🔗 データ結合中（キー: {merge_keys}）...")
    df_merged = pd.merge(
        df_basic,
        df_past,
        on=merge_keys,
        how='left'
    )
    
    logging.info(f"✓ 結合完了: {len(df_merged):,} 件 × {len(df_merged.columns)} 列")
    
    # 欠損値統計
    null_counts = df_merged[['prev1_pace', 'prev1_deokure', 'prev1_furi', 
                             'prev1_furi_1', 'prev1_furi_2', 'prev1_furi_3', 
                             'prev1_batai_code']].isnull().sum()
    total_nulls = null_counts.sum()
    null_rows = df_merged[['prev1_pace']].isnull().sum()[0]
    
    logging.info(f"\n📊 過去走データ欠損: {null_rows:,} 件 ({null_rows/len(df_merged)*100:.1f}%)")
    
    # 出力
    output_file = data_dir / "jrdb_48cols.csv"
    logging.info(f"\n💾 CSV出力中: {output_file}")
    df_merged.to_csv(output_file, index=False, encoding='utf-8-sig')
    
    file_size = output_file.stat().st_size / (1024 * 1024)
    elapsed = datetime.now() - start_time
    
    logging.info("\n" + "=" * 70)
    logging.info("✅ Phase 1-B Step 3 完了")
    logging.info("=" * 70)
    logging.info(f"出力ファイル: {output_file}")
    logging.info(f"ファイルサイズ: {file_size:.1f} MB")
    logging.info(f"総レコード数: {len(df_merged):,} 件")
    logging.info(f"列数: {len(df_merged.columns)} 列")
    logging.info(f"実行時間: {elapsed}")
    logging.info("\n📋 最終列一覧 (1-{}):")
    for i, col in enumerate(df_merged.columns, 1):
        logging.info(f"  {i}. {col}")
    logging.info("=" * 70)

if __name__ == "__main__":
    main()
