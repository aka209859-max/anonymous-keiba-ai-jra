#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA-VAN 出馬テーブル確認スクリプト
出馬情報を含むテーブル（jvd_se, jvd_o1, jvd_o2, nvd_se）を確認します。
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

def check_table_exists(cursor, table_name):
    """テーブルが存在するか確認"""
    query = """
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_schema = 'public' AND table_name = %s
        );
    """
    cursor.execute(query, (table_name,))
    return cursor.fetchone()[0]

def check_table_columns(cursor, table_name):
    """テーブルの列情報を取得"""
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
    return cursor.fetchall()

def check_sample_data(cursor, table_name, key_columns):
    """サンプルデータを取得"""
    if not key_columns:
        return []
    
    sample_columns = key_columns[:10]  # 最初の10列のみ
    sample_query = f"SELECT {', '.join(sample_columns)} FROM {table_name} LIMIT 3;"
    cursor.execute(sample_query)
    return cursor.fetchall(), sample_columns

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
        
        # チェックするテーブルリスト
        candidate_tables = ['jvd_se', 'jvd_o1', 'jvd_o2', 'nvd_se']
        
        found_tables = []
        
        print(f"{'='*80}")
        print("🔍 出馬テーブル候補の確認")
        print(f"{'='*80}\n")
        
        for table_name in candidate_tables:
            print(f"📋 テーブル: {table_name}")
            
            if check_table_exists(cursor, table_name):
                print(f"  ✅ 存在します")
                found_tables.append(table_name)
                
                # 列情報を取得
                columns = check_table_columns(cursor, table_name)
                print(f"  列数: {len(columns)}")
                
                # キー候補列を表示
                key_columns = []
                for col_name, data_type, max_length, nullable in columns:
                    if any(keyword in col_name.lower() for keyword in 
                           ['kaisai', 'keibajo', 'race', 'bango', 'umaban', 'ketto', 'code']):
                        key_columns.append(col_name)
                
                if key_columns:
                    print(f"  🔑 キー候補列:")
                    for col_name in key_columns:
                        col_info = next((c for c in columns if c[0] == col_name), None)
                        if col_info:
                            _, data_type, max_length, _ = col_info
                            length_str = f"({max_length})" if max_length else ""
                            print(f"    • {col_name}: {data_type}{length_str}")
                
                # サンプルデータを表示
                rows, sample_cols = check_sample_data(cursor, table_name, key_columns)
                if rows:
                    print(f"  📊 サンプルデータ（最初の3行）:")
                    for i, row in enumerate(rows, 1):
                        print(f"    行 {i}:")
                        for col, val in zip(sample_cols, row):
                            print(f"      {col}: {val}")
            else:
                print(f"  ❌ 存在しません")
            
            print()
        
        # 結論
        print(f"\n{'='*80}")
        print("📌 結論")
        print(f"{'='*80}")
        
        if found_tables:
            print(f"✅ 見つかった出馬テーブル: {', '.join(found_tables)}")
            print(f"\n推奨事項:")
            print(f"1. 上記のテーブルから最適なものを選択してください")
            print(f"2. Phase 1-A スクリプトで選択したテーブルを使用してください")
            print(f"3. レース情報テーブル (jvd_ra) と結合してください")
        else:
            print("⚠️  出馬テーブルが見つかりませんでした")
        
        cursor.close()
        conn.close()
        
        print("\n✅ 処理完了")
        
    except Exception as e:
        print(f"\n❌ エラー: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    main()
