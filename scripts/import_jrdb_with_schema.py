#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
============================================================================
JRDB データファイルインポートスクリプト (DataSettings.xml対応版)
============================================================================
目的: DataSettings.xmlのスキーマ定義に基づき、JRDBテキストファイルを
     PostgreSQLにインポート
============================================================================
"""

import psycopg2
from pathlib import Path
import logging
import sys
import xml.etree.ElementTree as ET
from typing import Dict, List, Tuple

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


def load_schema_from_xml(xml_path: str) -> Dict:
    """DataSettings.xmlからスキーマ定義を読み込む"""
    logger.info(f"📖 スキーマファイル読み込み: {xml_path}")
    
    tree = ET.parse(xml_path)
    root = tree.getroot()
    
    schemas = {}
    
    for file_elem in root.findall('file'):
        file_pattern = file_elem.get('name')  # e.g., "KYI*.txt"
        file_prefix = file_pattern.replace('*.txt', '')  # e.g., "KYI"
        
        table_name = file_elem.find('table').get('name')
        
        columns = []
        for col_elem in file_elem.find('columns').findall('column'):
            col_name = col_elem.get('name')
            col_length = int(col_elem.get('length'))
            columns.append((col_name, col_length))
        
        keys = []
        keys_elem = file_elem.find('keys')
        if keys_elem is not None:
            for key_elem in keys_elem.findall('key'):
                keys.append(key_elem.get('name'))
        
        schemas[file_prefix] = {
            'table': table_name,
            'columns': columns,
            'keys': keys
        }
    
    logger.info(f"✅ {len(schemas)} 種類のファイルスキーマを読み込みました")
    return schemas


def parse_fixed_length_file(file_path: Path, schema: Dict) -> List[Dict]:
    """固定長テキストファイルをパース"""
    records = []
    columns = schema['columns']
    
    try:
        # Shift-JIS で読み込み（JRDBファイルの標準エンコーディング）
        with open(file_path, 'r', encoding='shift_jis', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                if not line.strip():
                    continue
                
                record = {}
                pos = 0
                
                for col_name, col_width in columns:
                    # 固定長でデータを切り出し
                    value = line[pos:pos+col_width].strip()
                    record[col_name] = value if value else None
                    pos += col_width
                
                records.append(record)
                
                if line_num % 500 == 0:
                    logger.info(f"    {line_num}行 処理中...")
    
    except Exception as e:
        logger.error(f"❌ ファイル読み込みエラー ({file_path}): {e}")
        return []
    
    return records


def import_records_to_db(records: List[Dict], schema: Dict, conn, file_type: str):
    """レコードをデータベースにインポート"""
    if not records:
        logger.warning(f"⚠️  インポートするデータがありません")
        return 0
    
    table_name = schema['table']
    column_names = [col[0] for col in schema['columns']]
    
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
                if error_count <= 3:  # 最初の3件だけエラー詳細を表示
                    logger.warning(f"    ⚠️  レコード {i} スキップ: {str(e)[:100]}")
        
        conn.commit()
        cur.close()
        
        logger.info(f"✅ {file_type}: {success_count} 件インポート成功 ({error_count} 件スキップ)")
        return success_count
    
    except Exception as e:
        conn.rollback()
        logger.error(f"❌ {file_type} インポートエラー: {e}")
        return 0


def main(data_dir: str, schema_file: str):
    """メイン処理"""
    logger.info("\n" + "=" * 80)
    logger.info("🏇 JRDB データファイルインポート開始")
    logger.info("=" * 80)
    
    # データディレクトリ確認
    data_path = Path(data_dir)
    if not data_path.exists():
        logger.error(f"❌ データディレクトリが見つかりません: {data_dir}")
        sys.exit(1)
    
    # スキーマ読み込み
    schema_path = Path(schema_file)
    if not schema_path.exists():
        logger.error(f"❌ スキーマファイルが見つかりません: {schema_file}")
        sys.exit(1)
    
    try:
        schemas = load_schema_from_xml(schema_file)
    except Exception as e:
        logger.error(f"❌ スキーマ読み込みエラー: {e}")
        sys.exit(1)
    
    # データベース接続
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        logger.info("✅ データベース接続完了")
    except Exception as e:
        logger.error(f"❌ データベース接続エラー: {e}")
        sys.exit(1)
    
    # Phase 6 で使用する主要ファイルを優先的に処理
    priority_files = ['KYI', 'CYB', 'JOA', 'SED', 'BAC']
    
    total_imported = 0
    processed_files = []
    
    for file_prefix in priority_files:
        if file_prefix not in schemas:
            logger.warning(f"⚠️  {file_prefix}: スキーマ定義が見つかりません")
            continue
        
        # ファイル検索
        file_pattern = list(data_path.glob(f"{file_prefix}*.txt"))
        
        if not file_pattern:
            logger.warning(f"⚠️  {file_prefix}*.txt が見つかりません")
            continue
        
        for file_path in file_pattern:
            logger.info(f"\n📁 処理中: {file_path.name}")
            
            # パース
            schema = schemas[file_prefix]
            records = parse_fixed_length_file(file_path, schema)
            logger.info(f"  📊 パース完了: {len(records)} 件")
            
            # インポート
            imported = import_records_to_db(records, schema, conn, file_prefix)
            total_imported += imported
            processed_files.append(file_path.name)
    
    conn.close()
    
    logger.info("\n" + "=" * 80)
    logger.info(f"✅ インポート完了")
    logger.info(f"   処理ファイル数: {len(processed_files)}")
    logger.info(f"   合計レコード数: {total_imported} 件")
    logger.info("=" * 80)
    
    if processed_files:
        logger.info("\n📋 処理済みファイル:")
        for fname in processed_files:
            logger.info(f"  • {fname}")


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(
        description='JRDB データファイルインポート (DataSettings.xml対応版)'
    )
    parser.add_argument(
        'data_dir',
        help='JRDBファイルが格納されているディレクトリ'
    )
    parser.add_argument(
        '--schema',
        default='E:\\anonymous-keiba-ai-JRA\\data\\jrdb\\config\\DataSettings.xml',
        help='DataSettings.xmlのパス (デフォルト: プロジェクトフォルダ内)'
    )
    
    args = parser.parse_args()
    main(args.data_dir, args.schema)
