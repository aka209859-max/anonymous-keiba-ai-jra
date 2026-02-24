#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRDB インデックス作成スクリプト

目的: JRDB データベースにパフォーマンス向上のためのインデックスを作成
対象テーブル:
  - jrd_sed: 過去走データ用の複合インデックス
  - jrd_kyi: レース情報用のインデックス
"""

import yaml
from sqlalchemy import create_engine, text
from pathlib import Path
import logging
from datetime import datetime
import sys

# ログ設定
log_dir = Path("logs")
log_dir.mkdir(exist_ok=True)
log_file = log_dir / "create_jrdb_indexes.log"

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

def create_indexes(engine):
    """インデックスを作成"""
    indexes = [
        {
            'name': 'idx_jrd_sed_ketto_race',
            'table': 'jrd_sed',
            'columns': '(ketto_toroku_bango, kaisai_nen DESC, kaisai_tsukihi DESC, race_bango DESC)',
            'description': '過去走データ取得用（血統登録番号 + 日付降順）'
        },
        {
            'name': 'idx_jrd_kyi_shikonen',
            'table': 'jrd_kyi',
            'columns': '(race_shikonen, keibajo_code, kaisai_kai, kaisai_nichime)',
            'description': 'レース情報取得用（施行年 + 競馬場 + 開催回日目）'
        }
    ]
    
    with engine.connect() as conn:
        for idx in indexes:
            try:
                logging.info(f"📌 インデックス作成中: {idx['name']}")
                logging.info(f"   テーブル: {idx['table']}")
                logging.info(f"   カラム: {idx['columns']}")
                logging.info(f"   説明: {idx['description']}")
                
                sql = text(f"""
                CREATE INDEX IF NOT EXISTS {idx['name']} 
                ON {idx['table']} {idx['columns']}
                """)
                conn.execute(sql)
                conn.commit()
                
                logging.info(f"✓ 完了\n")
            except Exception as e:
                logging.error(f"❌ エラー: {idx['name']}")
                logging.error(f"   {str(e)}\n")

def main():
    start_time = datetime.now()
    logging.info("=" * 70)
    logging.info("JRDB インデックス作成開始")
    logging.info("=" * 70)
    
    # データベース接続
    config = load_db_config()
    connection_string = (
        f"postgresql://{config['user']}:{config['password']}"
        f"@{config['host']}:{config['port']}/{config['database']}"
    )
    engine = create_engine(connection_string)
    logging.info("✓ JRDBデータベース接続完了\n")
    
    # インデックス作成
    create_indexes(engine)
    
    elapsed = datetime.now() - start_time
    logging.info("=" * 70)
    logging.info("✅ インデックス作成完了")
    logging.info(f"実行時間: {elapsed}")
    logging.info("=" * 70)

if __name__ == "__main__":
    main()
