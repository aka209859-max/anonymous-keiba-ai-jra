#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
オッズ・払戻データのテーブル特定スクリプト
"""

import psycopg2
import yaml
from pathlib import Path

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def main():
    print("=" * 80)
    print("🔍 オッズ・払戻データのテーブル特定")
    print("=" * 80)
    
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    # 1. 全テーブルを取得
    print("\n📋 データベース内の全テーブル:")
    print("-" * 80)
    cursor.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
        ORDER BY table_name;
    """)
    
    all_tables = [row[0] for row in cursor.fetchall()]
    print(f"テーブル数: {len(all_tables)}個\n")
    
    # 2. オッズ関連のカラムを持つテーブルを検索
    print("\n🎯 オッズ関連カラムを持つテーブル:")
    print("-" * 80)
    
    odds_keywords = ['odds', 'オッズ', '単勝', '複勝', 'tansho', 'fukusho', 'haito', '払戻', 'payout']
    
    odds_tables = {}
    
    for table in all_tables:
        cursor.execute("""
            SELECT column_name, data_type
            FROM information_schema.columns
            WHERE table_name = %s
            ORDER BY ordinal_position;
        """, (table,))
        
        columns = cursor.fetchall()
        column_names = [col[0] for col in columns]
        
        # オッズ関連のカラムを検索
        matching_columns = []
        for col_name in column_names:
            for keyword in odds_keywords:
                if keyword.lower() in col_name.lower():
                    col_type = [col[1] for col in columns if col[0] == col_name][0]
                    matching_columns.append((col_name, col_type))
                    break
        
        if matching_columns:
            odds_tables[table] = matching_columns
    
    # 結果表示
    for table, columns in sorted(odds_tables.items()):
        print(f"\n✅ テーブル: {table}")
        print(f"   オッズ関連カラム数: {len(columns)}個")
        for col_name, col_type in columns:
            print(f"     - {col_name:<40} ({col_type})")
    
    # 3. 特に重要なテーブルの詳細を確認
    print("\n" + "=" * 80)
    print("📊 重要なテーブルのデータ確認")
    print("=" * 80)
    
    important_tables = ['jvd_ha', 'jvd_o1', 'jvd_o2', 'jvd_o3', 'jvd_o4', 'jvd_o5', 'jvd_o6', 
                        'n_uma_race', 'n_haito', 'jrd_skb', 'jrd_bac']
    
    for table in important_tables:
        if table in all_tables:
            print(f"\n🔍 テーブル: {table}")
            print("-" * 80)
            
            # 2025年データ件数
            try:
                cursor.execute(f"""
                    SELECT COUNT(*) 
                    FROM {table}
                    WHERE kaisai_nen = '2025';
                """)
                count = cursor.fetchone()[0]
                print(f"   2025年データ: {count:,}件")
                
                # サンプルデータ（最初の1行）
                cursor.execute(f"SELECT * FROM {table} WHERE kaisai_nen = '2025' LIMIT 1;")
                sample = cursor.fetchone()
                
                if sample:
                    # カラム名を取得
                    cursor.execute(f"""
                        SELECT column_name 
                        FROM information_schema.columns 
                        WHERE table_name = '{table}'
                        ORDER BY ordinal_position;
                    """)
                    col_names = [row[0] for row in cursor.fetchall()]
                    
                    print(f"   サンプルデータ:")
                    for col_name, val in zip(col_names[:10], sample[:10]):  # 最初の10カラムのみ
                        print(f"     {col_name:<30} = {val}")
                    
                    if len(col_names) > 10:
                        print(f"     ... 他 {len(col_names)-10}カラム")
                
            except Exception as e:
                print(f"   ⚠️ アクセスエラー: {e}")
    
    # 4. jvd_se テーブルの全カラムを表示
    print("\n" + "=" * 80)
    print("📋 jvd_se テーブルの全カラム一覧")
    print("=" * 80)
    
    cursor.execute("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = 'jvd_se'
        ORDER BY ordinal_position;
    """)
    
    se_columns = cursor.fetchall()
    print(f"全{len(se_columns)}カラム:\n")
    
    for i, (col_name, col_type) in enumerate(se_columns, 1):
        print(f"{i:3}. {col_name:<40} ({col_type})")
    
    cursor.close()
    conn.close()
    
    print("\n" + "=" * 80)
    print("✅ 調査完了")
    print("=" * 80)

if __name__ == "__main__":
    main()
