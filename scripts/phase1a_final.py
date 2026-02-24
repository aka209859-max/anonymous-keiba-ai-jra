#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-A: JRA-VAN データ抽出（最終版）
正しいテーブル（jvd_ra, jvd_se）を使用してデータを抽出します。
"""

import pandas as pd
import psycopg2
import yaml
import logging
from pathlib import Path
from datetime import datetime

# ログ設定
log_dir = Path('logs')
log_dir.mkdir(exist_ok=True)
log_file = log_dir / 'phase1a_final_extraction.log'

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

def load_db_config():
    """設定ファイルからDB接続情報を読み込む"""
    config_paths = [
        'config/db_config_corrected.yaml',
        'config/db_config.yaml',
        'db_config_corrected.yaml',
        'db_config.yaml'
    ]
    
    for config_path in config_paths:
        if Path(config_path).exists():
            logging.info(f"✅ 設定ファイル読み込み: {config_path}")
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                if 'jravan' in config and 'database' in config['jravan']:
                    return config['jravan']
                elif 'database' in config:
                    return config
    
    # デフォルト設定
    logging.warning("⚠️  設定ファイルが見つからないため、デフォルト設定を使用")
    return {
        'host': 'localhost',
        'port': 5432,
        'database': 'pckeiba',
        'user': 'postgres',
        'password': 'postgres123'
    }

def extract_jravan_data(config, start_year=2016, end_year=2025):
    """JRA-VANデータベースからデータを抽出"""
    
    logging.info(f"📊 JRA-VANデータ抽出開始 ({start_year}年 - {end_year}年)")
    
    # データベース接続
    conn = psycopg2.connect(
        host=config['host'],
        port=config['port'],
        database=config['database'],
        user=config['user'],
        password=config['password']
    )
    logging.info(f"✅ データベース接続成功: {config['database']}")
    
    # SQLクエリ（jvd_ra と jvd_se を使用）
    query = """
    SELECT 
        -- レース識別キー（6キー: 年、競馬場、開催回、日目、レース番号、馬番）
        se.kaisai_nen,
        se.kaisai_tsukihi,
        se.keibajo_code,
        se.kaisai_kai,
        se.kaisai_nichime,
        se.race_bango,
        se.umaban,
        
        -- 血統登録番号（結合検証用）
        se.ketto_toroku_bango,
        
        -- レース情報（jvd_ra から）
        ra.tokubetsu_kyoso_bango,
        ra.hondai,
        ra.fukudai,
        ra.track_code,
        ra.kyori,
        ra.tenki_code,
        ra.baba_jotai_code,
        
        -- 馬情報（jvd_se から）
        se.wakuban,
        se.umakigo_code,
        se.seibetsu_code,
        se.barei,
        se.futan_juryo,
        se.kishu_code,
        se.kishu_mei,
        se.blinker_code,
        
        -- 過去成績情報（空列、Phase 1-B で追加予定）
        '' AS past5_avg_rank,
        '' AS past5_win_rate,
        '' AS past5_place_rate,
        '' AS past5_avg_odds,
        '' AS past5_distance_aptitude,
        '' AS past5_track_aptitude,
        '' AS past5_time_avg
        
    FROM jvd_se se
    INNER JOIN jvd_ra ra
        ON se.kaisai_nen = ra.kaisai_nen
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.kaisai_kai = ra.kaisai_kai
        AND se.kaisai_nichime = ra.kaisai_nichime
        AND se.race_bango = ra.race_bango
    WHERE 
        CAST(se.kaisai_nen AS INTEGER) BETWEEN %s AND %s
        AND se.keibajo_code IN ('01','02','03','04','05','06','07','08','09','10')
        AND ra.data_kubun = '7'
    ORDER BY 
        se.kaisai_nen, se.kaisai_tsukihi, se.keibajo_code, 
        se.kaisai_kai, se.kaisai_nichime, se.race_bango, se.umaban;
    """
    
    # データ抽出
    logging.info("📥 データ抽出中...")
    df = pd.read_sql_query(query, conn, params=(start_year, end_year))
    
    conn.close()
    logging.info(f"✅ 抽出完了: {len(df):,}件")
    
    return df

def main():
    start_time = datetime.now()
    
    logging.info("="*70)
    logging.info("Phase 1-A: JRA-VAN データ抽出（最終版）")
    logging.info("="*70)
    
    try:
        # 設定読み込み
        config = load_db_config()
        
        # データ抽出
        df = extract_jravan_data(config)
        
        # 出力ディレクトリ作成
        output_dir = Path('data/raw')
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # CSV出力
        output_file = output_dir / 'jra_jravan_central_only.csv'
        
        # 既存ファイルがあれば削除
        if output_file.exists():
            output_file.unlink()
            logging.info(f"🗑️  既存ファイル削除: {output_file}")
        
        df.to_csv(output_file, index=False, encoding='utf-8')
        
        # 結果サマリー
        file_size_mb = output_file.stat().st_size / (1024 * 1024)
        
        logging.info("="*70)
        logging.info("✅ Phase 1-A 完了")
        logging.info("="*70)
        logging.info(f"出力ファイル: {output_file}")
        logging.info(f"総レコード数: {len(df):,}件")
        logging.info(f"列数: {len(df.columns)}列")
        logging.info(f"ファイルサイズ: {file_size_mb:.1f} MB")
        logging.info("")
        logging.info("📋 列リスト:")
        for i, col in enumerate(df.columns, 1):
            logging.info(f"  {i:2d}. {col}")
        
        logging.info("")
        logging.info("🔑 キー列のユニーク値:")
        logging.info(f"  keibajo_code: {sorted(df['keibajo_code'].unique())}")
        logging.info(f"  kaisai_kai: {sorted(df['kaisai_kai'].unique())}")
        logging.info(f"  kaisai_nichime: {sorted(df['kaisai_nichime'].unique())}")
        logging.info(f"  race_bango: {sorted(df['race_bango'].unique())}")
        logging.info(f"  umaban: {sorted(df['umaban'].unique())}")
        
        elapsed_time = (datetime.now() - start_time).total_seconds()
        logging.info(f"\n⏱️  実行時間: {elapsed_time:.1f}秒")
        logging.info("="*70)
        logging.info("📌 次のステップ: Phase 1-C（データ結合）の準備完了")
        logging.info("="*70)
        
    except Exception as e:
        logging.error(f"❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        raise

if __name__ == '__main__':
    main()
