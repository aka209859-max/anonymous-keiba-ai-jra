#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-B Step 1: JRDB 基本データ抽出（41列）

目的: JRDBデータベースから基本データ（41列）を年別バッチ処理で抽出
期間: 2016-2025年
出力: data/raw/jrdb_basic_41cols.csv
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
log_file = log_dir / "phase1b_step1_basic.log"

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
    """指定年のJRDB基本データを抽出"""
    race_shikonen = str(year - 2000).zfill(2)  # 2016 -> "16"
    
    sql = text(f"""
    SELECT
        -- キー列（7列）
        kyi.keibajo_code,
        kyi.race_shikonen,
        kyi.kaisai_kai,
        kyi.kaisai_nichime,
        kyi.race_bango,
        kyi.umaban,
        kyi.ketto_toroku_bango,
        
        -- 予測指数（13列）#99-#111
        kyi.idm,
        kyi.kishu_shisu,
        kyi.joho_shisu,
        kyi.sogo_shisu,
        kyi.chokyo_shisu,
        kyi.kyusha_shisu,
        kyi.gekiso_shisu,
        kyi.ninki_shisu,
        kyi.ten_shisu,
        kyi.pace_shisu,
        kyi.agari_shisu,
        kyi.ichi_shisu,
        kyi.manken_shisu,
        
        -- 調教・厩舎評価（5列）#112-#116
        kyi.chokyo_yajirushi_code,
        kyi.kyusha_hyoka_code,
        kyi.kishu_kitai_rentai_ritsu,
        joa.shiage_shisu,
        joa.chokyo_hyoka,
        
        -- 馬適性・状態（6列）#117-#122
        kyi.kyakushitsu_code,
        kyi.kyori_tekisei_code,
        kyi.joshodo_code,
        kyi.tekisei_code_omo,
        kyi.hizume_code,
        kyi.class_code,
        
        -- 展開予測（2列）#123-#124
        kyi.pace_yoso,
        kyi.uma_deokure_ritsu,
        
        -- ランク・その他（6列）#125-#130
        kyi.rotation,
        kyi.hobokusaki_rank,
        kyi.kyusha_rank,
        cyb.bataiju,
        cyb.bataiju_zogen,
        kyi.uma_start_shisu,
        
        -- CID/LS指数（7列）#131-#137
        joa.cid,
        joa.ls_shisu,
        joa.ls_hyoka,
        joa.em,
        joa.kyusha_bb_shirushi,
        joa.kishu_bb_shirushi,
        joa.kyusha_bb_nijumaru_tansho_kaishuritsu
        
    FROM jrd_kyi kyi
    LEFT JOIN jrd_joa joa 
        ON joa.keibajo_code = kyi.keibajo_code
        AND joa.race_shikonen = kyi.race_shikonen
        AND joa.kaisai_kai = kyi.kaisai_kai
        AND joa.kaisai_nichime = kyi.kaisai_nichime
        AND joa.race_bango = kyi.race_bango
        AND joa.umaban = kyi.umaban
    LEFT JOIN jrd_cyb cyb
        ON cyb.keibajo_code = kyi.keibajo_code
        AND cyb.race_shikonen = kyi.race_shikonen
        AND cyb.kaisai_kai = kyi.kaisai_kai
        AND cyb.kaisai_nichime = kyi.kaisai_nichime
        AND cyb.race_bango = kyi.race_bango
        AND cyb.ketto_toroku_bango = kyi.ketto_toroku_bango
    WHERE kyi.race_shikonen = '{race_shikonen}'
    ORDER BY kyi.keibajo_code, kyi.kaisai_kai, kyi.kaisai_nichime, kyi.race_bango, kyi.umaban
    """)
    
    df = pd.read_sql(sql, engine)
    logging.info(f"  {year}年: {len(df):,} 件 × {len(df.columns)} 列")
    return df

def main():
    start_time = datetime.now()
    logging.info("=" * 70)
    logging.info("Phase 1-B Step 1: JRDB 基本データ抽出開始")
    logging.info("=" * 70)
    
    # データベース接続
    config = load_db_config()
    engine = create_db_engine(config)
    logging.info("✓ JRDBデータベース接続完了")
    
    # 年別抽出
    all_data = []
    for year in range(2016, 2026):
        logging.info(f"📊 {year}年 JRDB基本データ抽出中...")
        df_year = extract_year_data(engine, year)
        all_data.append(df_year)
    
    # 結合
    logging.info("\n📦 全年データ結合中...")
    df_all = pd.concat(all_data, ignore_index=True)
    logging.info(f"✓ 結合完了: {len(df_all):,} 件 × {len(df_all.columns)} 列")
    
    # 出力
    output_dir = Path("data/raw")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_file = output_dir / "jrdb_basic_41cols.csv"
    
    logging.info(f"\n💾 CSV出力中: {output_file}")
    df_all.to_csv(output_file, index=False, encoding='utf-8-sig')
    
    file_size = output_file.stat().st_size / (1024 * 1024)
    elapsed = datetime.now() - start_time
    
    logging.info("\n" + "=" * 70)
    logging.info("✅ Phase 1-B Step 1 完了")
    logging.info("=" * 70)
    logging.info(f"出力ファイル: {output_file}")
    logging.info(f"ファイルサイズ: {file_size:.1f} MB")
    logging.info(f"総レコード数: {len(df_all):,} 件")
    logging.info(f"列数: {len(df_all.columns)} 列")
    logging.info(f"実行時間: {elapsed}")
    logging.info("=" * 70)

if __name__ == "__main__":
    main()
