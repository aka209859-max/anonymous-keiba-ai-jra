#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA-VAN jvd_um テーブル列確認スクリプト
馬マスターテーブルの列構造を確認します。
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

def main():
    try:
        # 設定読み込み
        config = load_db_config()
        
        print(f"\n接続情報:")
        print(f"  Host: {config['host']}")
        print(f"  Port: {config['port']}")
        print(f"  Database: {config['database']}")
        print(f"  User: {config['user']}")
        
        # データベース接続
        conn = psycopg2.connect(
            host=config['host'],
            port=config['port'],
            database=config['database'],
            user=config['user'],
            password=config['password']
        )
        print("✅ データベース接続成功\n")
        
        cursor = conn.cursor()
        
        # jvd_um テーブルの列情報を取得
        table_name = 'jvd_um'
        print(f"{'='*80}")
        print(f"📋 テーブル: {table_name}")
        print(f"{'='*80}\n")
        
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
        
        print(f"総列数: {len(columns)}\n")
        
        # キー候補となる列を強調表示
        print("🔑 キー候補列:")
        key_columns = []
        for col_name, data_type, max_length, nullable in columns:
            if any(keyword in col_name.lower() for keyword in 
                   ['kaisai', 'keibajo', 'race', 'bango', 'code', 'ketto', 'toroku']):
                key_columns.append(col_name)
                length_str = f"({max_length})" if max_length else ""
                print(f"  • {col_name}: {data_type}{length_str}")
        
        print(f"\n📊 全列リスト:")
        for i, (col_name, data_type, max_length, nullable) in enumerate(columns, 1):
            length_str = f"({max_length})" if max_length else ""
            print(f"  {i:2d}. {col_name}: {data_type}{length_str}")
        
        # サンプルデータを表示
        print(f"\n📋 サンプルデータ（最初の3行、主要列のみ）:")
        sample_columns = [col for col in key_columns[:10]]
        if sample_columns:
            sample_query = f"SELECT {', '.join(sample_columns)} FROM {table_name} LIMIT 3;"
            cursor.execute(sample_query)
            rows = cursor.fetchall()
            
            for i, row in enumerate(rows, 1):
                print(f"\n  行 {i}:")
                for col, val in zip(sample_columns, row):
                    print(f"    {col}: {val}")
        
        cursor.close()
        conn.close()
        
        print("\n✅ 処理完了")
        
    except Exception as e:
        print(f"\n❌ エラー: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    main()
