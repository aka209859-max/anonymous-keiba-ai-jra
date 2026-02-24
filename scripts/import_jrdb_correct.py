#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
============================================================================
JRDB データファイルインポートスクリプト (JRDB公式フォーマット対応版)
============================================================================
目的: JRDB公式フォーマット仕様に基づき、正確にデータをインポート
============================================================================
"""

import psycopg2
from pathlib import Path
import logging
import sys
from typing import Dict, List

# ロギング設定
logging.basicConfig(
    level=logging.INFO,
    format='%(message)s',
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

# JRDB公式フォーマット定義（実ファイル構造に基づく）
# 各カラム: (開始位置, 長さ, カラム名)
JRDB_FORMATS = {
    'KYI': {
        'table': 'jrd_kyi',
        'format': [
            (0, 2, 'keibajo_code'),
            (2, 6, 'race_shikonen'),
            (8, 1, 'kaisai_kai'),
            (9, 1, 'kaisai_nichime'),
            (10, 2, 'race_bango'),
            (12, 2, 'umaban'),
            (14, 8, 'ketto_toroku_bango'),
            (22, 36, 'bamei'),
            (58, 5, 'idm'),
            (63, 5, 'kishu_shisu'),
            (68, 5, 'joho_shisu'),
            (73, 15, 'yobi_1'),
            (88, 5, 'sogo_shisu'),
            (93, 1, 'kyakushitsu_code'),
            (94, 1, 'kyori_tekisei_code'),
            (95, 1, 'joshodo_code'),
            (96, 3, 'rotation'),
            # 主要カラムのみ定義（Phase 6で使用するもの）
        ]
    },
    'CYB': {
        'table': 'jrd_cyb',
        'format': [
            (0, 2, 'keibajo_code'),
            (2, 6, 'race_shikonen'),
            (8, 1, 'kaisai_kai'),
            (9, 1, 'kaisai_nichime'),
            (10, 2, 'race_bango'),
            (12, 2, 'umaban'),
            (14, 2, 'chokyo_type'),
            (16, 1, 'chokyo_corse_shubetsu'),
            # 主要カラムのみ
        ]
    },
    'JOA': {
        'table': 'jrd_joa',
        'format': [
            (0, 2, 'keibajo_code'),
            (2, 6, 'race_shikonen'),
            (8, 1, 'kaisai_kai'),
            (9, 1, 'kaisai_nichime'),
            (10, 2, 'race_bango'),
            (12, 2, 'umaban'),
            (14, 8, 'ketto_toroku_bango'),
            (22, 36, 'bamei'),
            # 主要カラムのみ
        ]
    },
    'SED': {
        'table': 'jrd_sed',
        'format': [
            (0, 2, 'keibajo_code'),
            (2, 6, 'race_shikonen'),
            (8, 1, 'kaisai_kai'),
            (9, 1, 'kaisai_nichime'),
            (10, 2, 'race_bango'),
            (12, 2, 'umaban'),
            (14, 8, 'ketto_toroku_bango'),
            (22, 8, 'kaisai_nen_tsukihi'),  # 20260222 形式
            (30, 36, 'bamei'),
            # 主要カラムのみ
        ]
    },
    'BAC': {
        'table': 'jrd_bac',
        'format': [
            (0, 2, 'keibajo_code'),
            (2, 6, 'race_shikonen'),
            (8, 1, 'kaisai_kai'),
            (9, 1, 'kaisai_nichime'),
            (10, 2, 'race_bango'),
            (12, 8, 'kaisai_nen_tsukihi'),  # 20260222 形式
            # 主要カラムのみ
        ]
    }
}


def parse_jrdb_file(file_path: Path, file_type: str) -> List[Dict]:
    """JRDBファイルをパース（公式フォーマットに基づく）"""
    if file_type not in JRDB_FORMATS:
        raise ValueError(f"未対応のファイルタイプ: {file_type}")
    
    format_def = JRDB_FORMATS[file_type]
    records = []
    
    try:
        with open(file_path, 'r', encoding='shift_jis', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                if not line.strip() or len(line) < 50:
                    continue
                
                record = {}
                
                for start_pos, length, col_name in format_def['format']:
                    end_pos = start_pos + length
                    value = line[start_pos:end_pos].strip() if end_pos <= len(line) else ''
                    
                    # 特殊処理
                    if col_name == 'kaisai_nen_tsukihi' and len(value) == 8:
                        # 20260222 → kaisai_nen='2026', kaisai_tsukihi='0222'
                        record['kaisai_nen'] = value[:4]
                        record['kaisai_tsukihi'] = value[4:]
                    else:
                        record[col_name] = value if value else None
                
                records.append(record)
                
                if line_num % 500 == 0:
                    logger.info(f"    {line_num}行 処理中...")
    
    except Exception as e:
        logger.error(f"❌ ファイル読み込みエラー ({file_path}): {e}")
        return []
    
    return records


def import_records_to_db(records: List[Dict], file_type: str, conn):
    """レコードをデータベースにインポート"""
    if not records:
        logger.warning(f"⚠️  インポートするデータがありません")
        return 0
    
    table_name = JRDB_FORMATS[file_type]['table']
    
    # 最初のレコードからカラム名を取得
    column_names = list(records[0].keys())
    
    try:
        cur = conn.cursor()
        
        # INSERT文生成
        placeholders = ','.join(['%s'] * len(column_names))
        insert_sql = f"INSERT INTO {table_name} ({','.join(column_names)}) VALUES ({placeholders})"
        
        success_count = 0
        error_count = 0
        
        for i, record in enumerate(records, 1):
            try:
                values = [record.get(col) for col in column_names]
                cur.execute(insert_sql, values)
                success_count += 1
                
                if i % 100 == 0:
                    conn.commit()
                    logger.info(f"    {i}/{len(records)} 件 インポート中...")
            
            except Exception as e:
                error_count += 1
                if error_count <= 3:
                    logger.warning(f"    ⚠️  レコード {i} スキップ: {str(e)[:80]}")
        
        conn.commit()
        cur.close()
        
        logger.info(f"✅ {file_type}: {success_count} 件インポート成功 ({error_count} 件スキップ)")
        return success_count
    
    except Exception as e:
        conn.rollback()
        logger.error(f"❌ {file_type} インポートエラー: {e}")
        return 0


def main(data_dir: str):
    """メイン処理"""
    logger.info("\n" + "=" * 80)
    logger.info("🏇 JRDB データファイルインポート開始 (公式フォーマット対応版)")
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
    processed_files = []
    
    # Phase 6 で使用する主要ファイル
    priority_files = ['KYI', 'CYB', 'JOA', 'SED', 'BAC']
    
    for file_prefix in priority_files:
        file_pattern = list(data_path.glob(f"{file_prefix}*.txt"))
        
        if not file_pattern:
            logger.warning(f"⚠️  {file_prefix}*.txt が見つかりません")
            continue
        
        for file_path in file_pattern:
            logger.info(f"\n📁 処理中: {file_path.name}")
            
            # パース
            records = parse_jrdb_file(file_path, file_prefix)
            logger.info(f"  📊 パース完了: {len(records)} 件")
            
            # デバッグ: 最初の1レコードを表示
            if records:
                logger.info(f"  🔍 サンプル: {list(records[0].keys())[:8]}")
            
            # インポート
            imported = import_records_to_db(records, file_prefix, conn)
            total_imported += imported
            processed_files.append(file_path.name)
    
    conn.close()
    
    logger.info("\n" + "=" * 80)
    logger.info(f"✅ インポート完了")
    logger.info(f"   処理ファイル数: {len(processed_files)}")
    logger.info(f"   合計レコード数: {total_imported} 件")
    logger.info("=" * 80)


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(
        description='JRDB データファイルインポート (公式フォーマット対応版)'
    )
    parser.add_argument(
        'data_dir',
        help='JRDBファイルが格納されているディレクトリ'
    )
    
    args = parser.parse_args()
    main(args.data_dir)
