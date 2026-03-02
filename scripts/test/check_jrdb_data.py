#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRDBデータ確認スクリプト
データベース内のJRDBテーブルの状態を詳細に確認します
"""

import sys
import psycopg2
from datetime import datetime

# データベース接続情報
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

def check_table_data(cursor, table_name, date_filter=None):
    """テーブルのデータを確認"""
    print(f"\n{'='*60}")
    print(f"テーブル: {table_name}")
    print('='*60)
    
    try:
        # 全レコード数
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        total_count = cursor.fetchone()[0]
        print(f"全レコード数: {total_count:,}")
        
        if total_count == 0:
            print("⚠️ データが存在しません")
            return
        
        # 日付フィルターがある場合
        if date_filter and table_name == 'jrd_kyi':
            short_date = date_filter[2:]  # 20260301 -> 260301
            cursor.execute(f"SELECT COUNT(*) FROM {table_name} WHERE race_shikonen LIKE %s", (f"{short_date}%",))
            filtered_count = cursor.fetchone()[0]
            print(f"対象日({date_filter})のレコード数: {filtered_count:,}")
            
            if filtered_count > 0:
                # サンプルデータを表示
                cursor.execute(f"""
                    SELECT race_shikonen, keibajo_code, kaisai_kai, kaisai_nichime 
                    FROM {table_name} 
                    WHERE race_shikonen LIKE %s 
                    LIMIT 5
                """, (f"{short_date}%",))
                samples = cursor.fetchall()
                print("\nサンプルデータ:")
                for row in samples:
                    print(f"  race_shikonen={row[0]}, keibajo_code={row[1]}, kaisai_kai={row[2]}, kaisai_nichime={row[3]}")
        
        # 最新のrace_shikonen
        if table_name == 'jrd_kyi':
            cursor.execute(f"SELECT DISTINCT race_shikonen FROM {table_name} ORDER BY race_shikonen DESC LIMIT 5")
            recent_dates = cursor.fetchall()
            print("\n最新のrace_shikonen (上位5件):")
            for row in recent_dates:
                print(f"  {row[0]}")
        
        # カラム数
        cursor.execute(f"""
            SELECT COUNT(*) 
            FROM information_schema.columns 
            WHERE table_name = %s
        """, (table_name,))
        column_count = cursor.fetchone()[0]
        print(f"カラム数: {column_count}")
        
    except Exception as e:
        print(f"❌ エラー: {e}")

def main():
    target_date = sys.argv[1] if len(sys.argv) > 1 else datetime.now().strftime("%Y%m%d")
    
    print("="*60)
    print("JRDBデータ確認")
    print(f"対象日: {target_date}")
    print("="*60)
    
    try:
        # データベース接続
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()
        print("✅ データベース接続成功")
        
        # JRDBテーブルのリスト
        jrdb_tables = ['jrd_kyi', 'jrd_cyb', 'jrd_joa', 'jrd_sed', 'jrd_bac']
        
        for table in jrdb_tables:
            # テーブルが存在するか確認
            cursor.execute("""
                SELECT EXISTS (
                    SELECT FROM information_schema.tables 
                    WHERE table_name = %s
                )
            """, (table,))
            exists = cursor.fetchone()[0]
            
            if not exists:
                print(f"\n{'='*60}")
                print(f"テーブル: {table}")
                print('='*60)
                print("⚠️ テーブルが存在しません")
                continue
            
            check_table_data(cursor, table, target_date if table == 'jrd_kyi' else None)
        
        cursor.close()
        conn.close()
        
    except psycopg2.Error as e:
        print(f"\n❌ データベースエラー: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ 予期しないエラー: {e}")
        sys.exit(1)
    
    print("\n" + "="*60)
    print("確認完了")
    print("="*60)

if __name__ == "__main__":
    main()
