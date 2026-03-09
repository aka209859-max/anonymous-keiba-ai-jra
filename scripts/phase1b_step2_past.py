#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-B Step 2: JRDB 過去走データ抽出（7列）

目的: JRDBデータベースから過去走データ（7列）を年別バッチ処理で抽出
期間: 2016-2025年
出力: data/raw/jrdb_past_7cols.csv
"""

import pandas as pd
import yaml
from sqlalchemy import create_engine, text
from pathlib import Path
import logging
from datetime import datetime
import sys

# ログ設定
log_dir = Path("logs")
log_dir.mkdir(exist_ok=True)
log_file = log_dir / "phase1b_step2_past.log"

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    if not config_path.exists():
        config_path = Path("db_config.yaml")
    
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config['jrdb']

def create_db_engine(config):
    """PostgreSQLエンジンを作成"""
    connection_string = (
        f"postgresql://{config['user']}:{config['password']}"
        f"@{config['host']}:{config['port']}/{config['database']}"
        f"?options=-c%20work_mem=128MB%20-c%20temp_file_limit=51200MB"
    )
    return create_engine(connection_string)

def extract_year_data(engine, year):
    """指定年のJRDB過去走データを抽出"""
    race_shikonen = str(year - 2000).zfill(2)  # 2016 -> "16"
    
    sql = text(f"""
    WITH past_races AS (
        SELECT
            kyi.ketto_toroku_bango,
            kyi.keibajo_code,
            kyi.race_shikonen,
            kyi.kaisai_kai,
            kyi.kaisai_nichime,
            sed.pace AS prev1_pace,
            sed.deokure AS prev1_deokure,
            sed.furi AS prev1_furi,
            sed.furi_1 AS prev1_furi_1,
            sed.furi_2 AS prev1_furi_2,
            sed.furi_3 AS prev1_furi_3,
            sed.batai_code AS prev1_batai_code,
            ROW_NUMBER() OVER (
                PARTITION BY kyi.ketto_toroku_bango, kyi.keibajo_code, 
                             kyi.race_shikonen, kyi.kaisai_kai, kyi.kaisai_nichime
                ORDER BY sed.kaisai_nen DESC, sed.kaisai_tsukihi DESC, sed.race_bango DESC
            ) AS rn
        FROM jrd_kyi kyi
        LEFT JOIN jrd_sed sed
            ON sed.ketto_toroku_bango = kyi.ketto_toroku_bango
            AND sed.kakutei_chakujun ~ '^[0-9]+$'
            AND (
                sed.kaisai_nen::INTEGER < {year}
                OR (
                    sed.kaisai_nen::INTEGER = {year}
                    AND (
                        sed.kaisai_tsukihi < LPAD(kyi.kaisai_kai::TEXT, 2, '0') || LPAD(kyi.kaisai_nichime::TEXT, 2, '0')
                    )
                )
            )
        WHERE kyi.race_shikonen = '{race_shikonen}'
    )
    SELECT
        ketto_toroku_bango,
        keibajo_code,
        race_shikonen,
        kaisai_kai,
        kaisai_nichime,
        prev1_pace,
        prev1_deokure,
        prev1_furi,
        prev1_furi_1,
        prev1_furi_2,
        prev1_furi_3,
        prev1_batai_code
    FROM past_races
    WHERE rn = 1
    ORDER BY keibajo_code, kaisai_kai, kaisai_nichime
    """)
    
    df = pd.read_sql(sql, engine)
    logging.info(f"  {year}年: {len(df):,} 件 × {len(df.columns)} 列")
    return df

def main():
    start_time = datetime.now()
    logging.info("=" * 70)
    logging.info("Phase 1-B Step 2: JRDB 過去走データ抽出開始")
    logging.info("=" * 70)
    
    # データベース接続
    config = load_db_config()
    engine = create_db_engine(config)
    logging.info("✓ JRDBデータベース接続完了")
    
    # 年別抽出
    all_data = []
    for year in range(2016, 2026):
        logging.info(f"📊 {year}年 JRDB過去走データ抽出中...")
        df_year = extract_year_data(engine, year)
        all_data.append(df_year)
    
    # 結合
    logging.info("\n📦 全年データ結合中...")
    df_all = pd.concat(all_data, ignore_index=True)
    logging.info(f"✓ 結合完了: {len(df_all):,} 件 × {len(df_all.columns)} 列")
    
    # 出力
    output_dir = Path("data/raw")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_file = output_dir / "jrdb_past_7cols.csv"
    
    logging.info(f"\n💾 CSV出力中: {output_file}")
    df_all.to_csv(output_file, index=False, encoding='utf-8-sig')
    
    file_size = output_file.stat().st_size / (1024 * 1024)
    elapsed = datetime.now() - start_time
    
    logging.info("\n" + "=" * 70)
    logging.info("✅ Phase 1-B Step 2 完了")
    logging.info("=" * 70)
    logging.info(f"出力ファイル: {output_file}")
    logging.info(f"ファイルサイズ: {file_size:.1f} MB")
    logging.info(f"総レコード数: {len(df_all):,} 件")
    logging.info(f"列数: {len(df_all.columns)} 列")
    logging.info(f"実行時間: {elapsed}")
    logging.info("=" * 70)

if __name__ == "__main__":
    main()
