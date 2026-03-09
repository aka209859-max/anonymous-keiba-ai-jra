#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA-VAN データベース スキーマ確認スクリプト

目的: n_race テーブルに kaisai_kai と kaisai_nichime が存在するか確認
"""

import psycopg2
import yaml
from pathlib import Path

def load_config():
    """設定ファイルから接続情報を読み込み"""
    # 複数の設定ファイルパスを試行
    config_paths = [
        Path('config/config.yml'),
        Path('db_config_corrected.yaml'),  # ★ pckeiba を使用
        Path('db_config.yaml'),
    ]
    
    for config_file in config_paths:
        if config_file.exists():
            print(f"✅ 設定ファイル使用: {config_file}")
            with open(config_file, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                # jravan セクションから接続情報を取得
                if 'jravan' in config:
                    return config['jravan']
                elif 'database' in config:
                    return config['database']
    
    # 設定ファイルが見つからない場合
    print(f"❌ エラー: 設定ファイルが見つかりません")
    print(f"  検索パス: {[str(p) for p in config_paths]}")
    print("\nデフォルト設定を使用します:")
    return {
        'host': '127.0.0.1',
        'port': 5432,
        'database': 'pckeiba',  # ★ デフォルトを pckeiba に変更
        'user': 'postgres',
        'password': 'postgres123'
    }

def check_table_schema(conn, table_name):
    """テーブルのスキーマを確認"""
    print(f"\n{'='*70}")
    print(f"テーブル: {table_name}")
    print(f"{'='*70}")
    
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
    
    cursor = conn.cursor()
    cursor.execute(query, (table_name,))
    columns = cursor.fetchall()
    
    if not columns:
        print(f"⚠️ テーブル '{table_name}' が見つかりません")
        return None
    
    print(f"\n総列数: {len(columns)}")
    print(f"\n{'列名':<30} {'データ型':<20} {'最大長':<10} {'NULL許可'}")
    print('-' * 70)
    
    kaisai_kai_found = False
    kaisai_nichime_found = False
    
    for col in columns:
        col_name, data_type, max_length, nullable = col
        max_len_str = str(max_length) if max_length else '-'
        
        print(f"{col_name:<30} {data_type:<20} {max_len_str:<10} {nullable}")
        
        # kaisai_kai または類似の列を検索
        if 'kaisai' in col_name.lower() and 'kai' in col_name.lower():
            kaisai_kai_found = True
            print(f"  ★ 開催回候補: {col_name}")
        
        # kaisai_nichime または類似の列を検索
        if 'kaisai' in col_name.lower() and ('nichime' in col_name.lower() or 'day' in col_name.lower()):
            kaisai_nichime_found = True
            print(f"  ★ 開催日目候補: {col_name}")
    
    cursor.close()
    
    return {
        'kaisai_kai_found': kaisai_kai_found,
        'kaisai_nichime_found': kaisai_nichime_found,
        'columns': columns
    }

def check_sample_data(conn, table_name):
    """サンプルデータを確認"""
    print(f"\n{'='*70}")
    print(f"サンプルデータ（最初の5件）")
    print(f"{'='*70}")
    
    # まず列名を取得
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {table_name} LIMIT 0")
    colnames = [desc[0] for desc in cursor.description]
    
    # 重要な列のみ選択
    important_cols = []
    for col in colnames:
        if any(keyword in col.lower() for keyword in ['kaisai', 'keibajo', 'race', 'nen', 'tsukihi', 'bango']):
            important_cols.append(col)
    
    if important_cols:
        cols_str = ', '.join(important_cols[:10])  # 最初の10列まで
        query = f"SELECT {cols_str} FROM {table_name} LIMIT 5"
        
        cursor.execute(query)
        rows = cursor.fetchall()
        
        print(f"\n表示列: {cols_str}")
        print('-' * 70)
        
        for row in rows:
            print(row)
    
    cursor.close()

def main():
    print("="*70)
    print("JRA-VAN データベース スキーマ確認")
    print("="*70)
    
    # 設定読み込み
    try:
        db_config = load_config()
        print(f"\n接続情報:")
        print(f"  Host: {db_config['host']}")
        print(f"  Port: {db_config['port']}")
        print(f"  Database: {db_config['database']}")
        print(f"  User: {db_config['user']}")
    except Exception as e:
        print(f"❌ 設定読み込みエラー: {e}")
        return
    
    # データベース接続
    try:
        print(f"\nデータベースに接続中...")
        conn = psycopg2.connect(**db_config)
        print("✅ 接続成功")
    except Exception as e:
        print(f"❌ 接続エラー: {e}")
        return
    
    try:
        # n_race テーブルのスキーマ確認
        result = check_table_schema(conn, 'n_race')
        
        if result:
            # サンプルデータ確認
            check_sample_data(conn, 'n_race')
            
            # 結論
            print(f"\n{'='*70}")
            print("結論")
            print(f"{'='*70}")
            
            if result['kaisai_kai_found'] and result['kaisai_nichime_found']:
                print("✅ kaisai_kai と kaisai_nichime（または類似列）が存在します")
                print("\n推奨: Phase 1-A のスクリプトを修正して、これらの列を追加してください")
            elif result['kaisai_kai_found']:
                print("⚠️ kaisai_kai は存在しますが、kaisai_nichime が見つかりません")
                print("\n他のテーブルも確認する必要があります")
            elif result['kaisai_nichime_found']:
                print("⚠️ kaisai_nichime は存在しますが、kaisai_kai が見つかりません")
                print("\n他のテーブルも確認する必要があります")
            else:
                print("❌ kaisai_kai と kaisai_nichime が見つかりません")
                print("\n他のテーブルを確認します...")
                
                # 他のテーブルも確認
                for table in ['n_uma_race', 'n_uma', 'n_kishu']:
                    print(f"\n--- {table} テーブルを確認 ---")
                    check_table_schema(conn, table)
        
    except Exception as e:
        print(f"❌ エラー: {e}")
        import traceback
        traceback.print_exc()
    
    finally:
        conn.close()
        print(f"\n{'='*70}")
        print("✅ 処理完了")
        print(f"{'='*70}")

if __name__ == "__main__":
    main()
