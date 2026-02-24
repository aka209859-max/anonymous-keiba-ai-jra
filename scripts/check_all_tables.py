#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA-VAN データベース全テーブル確認スクリプト
すべてのテーブルを一覧表示し、race関連テーブルを自動検出します。
"""

import psycopg2
import yaml
from pathlib import Path

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
            print(f"✅ 設定ファイル読み込み: {config_path}")
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                if 'jravan' in config and 'database' in config['jravan']:
                    return config['jravan']
                elif 'database' in config:
                    return config
    
    # デフォルト設定
    print("⚠️  設定ファイルが見つからないため、デフォルト設定を使用")
    return {
        'host': 'localhost',
        'port': 5432,
        'database': 'pckeiba',
        'user': 'postgres',
        'password': 'postgres123'
    }

def connect_database(config):
    """データベースに接続"""
    print(f"\n接続情報:")
    print(f"  Host: {config['host']}")
    print(f"  Port: {config['port']}")
    print(f"  Database: {config['database']}")
    print(f"  User: {config['user']}")
    
    conn = psycopg2.connect(
        host=config['host'],
        port=config['port'],
        database=config['database'],
        user=config['user'],
        password=config['password']
    )
    print("✅ データベース接続成功\n")
    return conn

def list_all_tables(conn):
    """全テーブルを一覧表示"""
    cursor = conn.cursor()
    
    query = """
        SELECT table_schema, table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public'
        ORDER BY table_name;
    """
    
    cursor.execute(query)
    tables = cursor.fetchall()
    
    print(f"📊 データベース内のテーブル数: {len(tables)}\n")
    
    race_tables = []
    other_tables = []
    
    for schema, table in tables:
        if 'race' in table.lower():
            race_tables.append(table)
        else:
            other_tables.append(table)
    
    if race_tables:
        print(f"🏇 レース関連テーブル ({len(race_tables)}個):")
        for table in race_tables:
            print(f"  - {table}")
    else:
        print("⚠️  'race' を含むテーブルが見つかりません")
    
    print(f"\n📋 その他のテーブル ({len(other_tables)}個):")
    for table in other_tables[:20]:  # 最初の20個のみ表示
        print(f"  - {table}")
    if len(other_tables) > 20:
        print(f"  ... 他 {len(other_tables) - 20} 個")
    
    cursor.close()
    return race_tables

def check_table_details(conn, table_name):
    """テーブルの詳細情報を表示"""
    cursor = conn.cursor()
    
    print(f"\n{'='*80}")
    print(f"📋 テーブル: {table_name}")
    print(f"{'='*80}")
    
    # 列情報を取得
    query = """
        SELECT 
            column_name,
            data_type,
            character_maximum_length,
            is_nullable
        FROM information_schema.columns
        WHERE table_name = %s
        ORDER BY ordinal_position;
    """
    
    cursor.execute(query, (table_name,))
    columns = cursor.fetchall()
    
    print(f"\n列数: {len(columns)}")
    print("\n主要な列:")
    
    key_columns = []
    for col_name, data_type, max_length, nullable in columns:
        # キーになりそうな列をハイライト
        if any(keyword in col_name.lower() for keyword in ['kaisai', 'keibajo', 'race', 'bango', 'code']):
            key_columns.append(col_name)
            length_str = f"({max_length})" if max_length else ""
            print(f"  🔑 {col_name}: {data_type}{length_str} (NULL: {nullable})")
    
    if not key_columns:
        print("  (キー候補列が見つかりません)")
    
    # サンプルデータを取得
    print(f"\nサンプルデータ（最初の3行）:")
    sample_query = f"SELECT * FROM {table_name} LIMIT 3;"
    cursor.execute(sample_query)
    rows = cursor.fetchall()
    
    if rows:
        # 列名を取得
        col_names = [desc[0] for desc in cursor.description]
        
        for i, row in enumerate(rows, 1):
            print(f"\n  行 {i}:")
            for col, val in zip(col_names[:10], row[:10]):  # 最初の10列のみ
                print(f"    {col}: {val}")
    else:
        print("  (データがありません)")
    
    cursor.close()

def main():
    try:
        # 設定読み込み
        config = load_db_config()
        
        # データベース接続
        conn = connect_database(config)
        
        # 全テーブル一覧
        race_tables = list_all_tables(conn)
        
        # レース関連テーブルの詳細を表示
        if race_tables:
            print(f"\n\n{'='*80}")
            print("🔍 レース関連テーブルの詳細情報")
            print(f"{'='*80}")
            
            for table in race_tables:
                check_table_details(conn, table)
        
        # 推奨事項
        print(f"\n\n{'='*80}")
        print("📌 推奨事項")
        print(f"{'='*80}")
        print("1. 上記のテーブル詳細を確認してください")
        print("2. kaisai_kai と kaisai_nichime を含むテーブルを特定してください")
        print("3. Phase 1-A スクリプトでそのテーブル名を使用してください")
        
        # 接続クローズ
        conn.close()
        print("\n✅ 処理完了")
        
    except Exception as e:
        print(f"\n❌ エラー: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    main()
