#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
============================================================================
JRDB データファイルインポートスクリプト
============================================================================
目的: JRDBテキストファイル（KYI, CYB, JOA, SED, BAC）をPostgreSQLにインポート
============================================================================
"""

import psycopg2
from pathlib import Path
import logging
import sys
from datetime import datetime

# ロギング設定
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler(sys.stdout)]
)
logger = logging.getLogger(__name__)

# データベース接続設定
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

# JRDBファイル定義（Shift-JIS エンコーディング）
JRDB_FILES = {
    'KYI': {
        'table': 'jrd_kyi',
        'columns': [
            ('race_shikonen', 6, 'VARCHAR(10)'),
            ('keibajo_code', 6, 'VARCHAR(2)'),
            ('kaisai_kai', 2, 'VARCHAR(2)'),
            ('kaisai_nichime', 1, 'VARCHAR(2)'),
            ('race_bango', 2, 'VARCHAR(2)'),
            ('umaban', 2, 'VARCHAR(2)'),
            ('bamei', 36, 'VARCHAR(36)'),
            ('tozai_shozoku_code', 1, 'VARCHAR(1)'),
            ('chokyoshi_code', 5, 'VARCHAR(5)'),
            ('kishu_code', 5, 'VARCHAR(5)'),
            ('tekisei_code_kyori', 1, 'VARCHAR(1)'),
            ('tekisei_code_babajotai', 1, 'VARCHAR(1)'),
            ('tekisei_code_omo', 1, 'VARCHAR(1)'),
            ('hizume_code', 1, 'VARCHAR(1)'),
            ('class_code', 2, 'VARCHAR(2)'),
            ('pace_yoso', 1, 'VARCHAR(1)'),
            ('uma_deokure_ritsu', 3, 'VARCHAR(3)'),
            ('rotation', 3, 'VARCHAR(3)'),
            ('hobokusaki_rank', 1, 'VARCHAR(1)'),
            ('kyusha_rank', 1, 'VARCHAR(1)'),
            ('bataiju', 3, 'VARCHAR(3)'),
            ('bataiju_zogen', 3, 'VARCHAR(3)'),
            ('uma_start_shisu', 3, 'VARCHAR(3)'),
        ]
    },
    'CYB': {
        'table': 'jrd_cyb',
        'columns': [
            ('race_shikonen', 6, 'VARCHAR(10)'),
            ('keibajo_code', 6, 'VARCHAR(2)'),
            ('kaisai_kai', 2, 'VARCHAR(2)'),
            ('kaisai_nichime', 1, 'VARCHAR(2)'),
            ('race_bango', 2, 'VARCHAR(2)'),
            ('umaban', 2, 'VARCHAR(2)'),
            ('chokyoshi_code', 5, 'VARCHAR(5)'),
            ('chokyoshi_mei', 12, 'VARCHAR(20)'),
            ('chokyo_type', 1, 'VARCHAR(1)'),
            ('chokyo_course_shubetsu', 2, 'VARCHAR(2)'),
            ('sakusha_hyoka_f_h', 1, 'VARCHAR(1)'),
            ('chokyo_juten', 1, 'VARCHAR(1)'),
            ('chokyo_hyoka_1', 1, 'VARCHAR(1)'),
            ('chokyo_hyoka_2', 1, 'VARCHAR(1)'),
            ('chokyo_hyoka_3', 1, 'VARCHAR(1)'),
        ]
    },
    'JOA': {
        'table': 'jrd_joa',
        'columns': [
            ('race_shikonen', 6, 'VARCHAR(10)'),
            ('keibajo_code', 6, 'VARCHAR(2)'),
            ('kaisai_kai', 2, 'VARCHAR(2)'),
            ('kaisai_nichime', 1, 'VARCHAR(2)'),
            ('race_bango', 2, 'VARCHAR(2)'),
            ('umaban', 2, 'VARCHAR(2)'),
            ('cid', 8, 'VARCHAR(10)'),
            ('ls_shisu', 4, 'VARCHAR(5)'),
            ('ls_hyoka', 1, 'VARCHAR(1)'),
            ('em', 3, 'VARCHAR(5)'),
            ('kyusha_bb_shirushi', 1, 'VARCHAR(1)'),
            ('kishu_bb_shirushi', 1, 'VARCHAR(1)'),
            ('kyusha_bb_nijumaru_tansho_kaishuritsu', 2, 'VARCHAR(3)'),
        ]
    },
    'SED': {
        'table': 'jrd_sed',
        'columns': [
            ('ketto_toroku_bango', 10, 'VARCHAR(10)'),
            ('kaisai_nen', 4, 'VARCHAR(4)'),
            ('kaisai_tsukihi', 4, 'VARCHAR(4)'),
            ('keibajo_code', 2, 'VARCHAR(2)'),
            ('race_bango', 2, 'VARCHAR(2)'),
            ('race_pace', 1, 'VARCHAR(1)'),
            ('uma_pace', 1, 'VARCHAR(1)'),
            ('pace_shisu', 3, 'VARCHAR(5)'),
            ('batai_code', 1, 'VARCHAR(1)'),
        ]
    },
    'BAC': {
        'table': 'jrd_bac',
        'columns': [
            ('keibajo_code', 2, 'VARCHAR(2)'),
            ('kaisai_nen', 4, 'VARCHAR(4)'),
            ('kaisai_tsukihi', 4, 'VARCHAR(4)'),
            ('track_code', 2, 'VARCHAR(2)'),
            ('babasa', 4, 'VARCHAR(10)'),
        ]
    }
}


def parse_jrdb_file(file_path: Path, file_type: str):
    """JRDBファイルをパース"""
    if file_type not in JRDB_FILES:
        raise ValueError(f"未対応のファイルタイプ: {file_type}")
    
    config = JRDB_FILES[file_type]
    records = []
    
    try:
        with open(file_path, 'r', encoding='shift_jis', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                if not line.strip():
                    continue
                
                record = {}
                pos = 0
                
                for col_name, col_width, col_type in config['columns']:
                    value = line[pos:pos+col_width].strip()
                    record[col_name] = value if value else None
                    pos += col_width
                
                records.append(record)
                
                if line_num % 1000 == 0:
                    logger.info(f"  {file_type}: {line_num}行 処理中...")
    
    except Exception as e:
        logger.error(f"❌ ファイル読み込みエラー ({file_path}): {e}")
        return []
    
    return records


def import_to_db(records: list, file_type: str, conn):
    """データベースにインポート"""
    if not records:
        logger.warning(f"⚠️  {file_type}: インポートするデータがありません")
        return 0
    
    config = JRDB_FILES[file_type]
    table_name = config['table']
    columns = [col[0] for col in config['columns']]
    
    try:
        cur = conn.cursor()
        
        # プレースホルダー生成
        placeholders = ','.join(['%s'] * len(columns))
        insert_sql = f"INSERT INTO {table_name} ({','.join(columns)}) VALUES ({placeholders})"
        
        # バッチインサート
        for i, record in enumerate(records, 1):
            values = [record.get(col) for col in columns]
            cur.execute(insert_sql, values)
            
            if i % 1000 == 0:
                conn.commit()
                logger.info(f"  {file_type}: {i}/{len(records)} 件 インポート中...")
        
        conn.commit()
        cur.close()
        
        logger.info(f"✅ {file_type}: {len(records)} 件 インポート完了")
        return len(records)
    
    except Exception as e:
        conn.rollback()
        logger.error(f"❌ {file_type} インポートエラー: {e}")
        return 0


def main(data_dir: str):
    """メイン処理"""
    logger.info("=" * 80)
    logger.info("JRDB データファイルインポート開始")
    logger.info("=" * 80)
    
    data_path = Path(data_dir)
    if not data_path.exists():
        logger.error(f"❌ データディレクトリが見つかりません: {data_dir}")
        sys.exit(1)
    
    # データベース接続
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        logger.info("✅ データベース接続完了")
    except Exception as e:
        logger.error(f"❌ データベース接続エラー: {e}")
        sys.exit(1)
    
    total_imported = 0
    
    # 各ファイルをインポート
    for file_type in ['KYI', 'CYB', 'JOA', 'SED', 'BAC']:
        file_pattern = list(data_path.glob(f"{file_type}*.txt"))
        
        if not file_pattern:
            logger.warning(f"⚠️  {file_type} ファイルが見つかりません")
            continue
        
        for file_path in file_pattern:
            logger.info(f"\n📁 処理中: {file_path.name}")
            
            # パース
            records = parse_jrdb_file(file_path, file_type)
            logger.info(f"  パース完了: {len(records)} 件")
            
            # インポート
            imported = import_to_db(records, file_type, conn)
            total_imported += imported
    
    conn.close()
    
    logger.info("\n" + "=" * 80)
    logger.info(f"✅ インポート完了: 合計 {total_imported} 件")
    logger.info("=" * 80)


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='JRDB データファイルインポート')
    parser.add_argument('data_dir', help='JRDBファイルが格納されているディレクトリ')
    
    args = parser.parse_args()
    main(args.data_dir)
