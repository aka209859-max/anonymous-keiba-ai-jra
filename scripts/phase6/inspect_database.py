#!/usr/bin/env python3
"""
PC-KEIBA PostgreSQLデータベース構造調査スクリプト

目的:
- pckeibaデータベースに接続
- 全テーブルの一覧を取得
- 各テーブルのレコード数を確認
- 主要テーブルのカラム情報を表示
"""

import psycopg2
import pandas as pd
from datetime import datetime

# データベース接続情報
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

def connect_db():
    """PostgreSQLに接続"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("✅ データベース接続成功")
        return conn
    except Exception as e:
        print(f"❌ データベース接続失敗: {e}")
        return None

def get_all_tables(conn):
    """全テーブルの一覧を取得"""
    query = """
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public'
        ORDER BY table_name;
    """
    df = pd.read_sql(query, conn)
    return df['table_name'].tolist()

def get_table_row_count(conn, table_name):
    """テーブルのレコード数を取得"""
    try:
        query = f"SELECT COUNT(*) FROM {table_name};"
        cursor = conn.cursor()
        cursor.execute(query)
        count = cursor.fetchone()[0]
        cursor.close()
        return count
    except Exception as e:
        return f"エラー: {e}"

def get_table_columns(conn, table_name):
    """テーブルのカラム情報を取得"""
    query = f"""
        SELECT 
            column_name, 
            data_type, 
            character_maximum_length,
            is_nullable
        FROM information_schema.columns 
        WHERE table_name = '{table_name}'
        ORDER BY ordinal_position;
    """
    df = pd.read_sql(query, conn)
    return df

def main():
    print("=" * 80)
    print("PC-KEIBA PostgreSQL データベース構造調査")
    print("=" * 80)
    print(f"調査日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"データベース: {DB_CONFIG['database']}")
    print("=" * 80)
    print()
    
    # データベース接続
    conn = connect_db()
    if not conn:
        return
    
    try:
        # テーブル一覧取得
        print("📊 テーブル一覧取得中...")
        tables = get_all_tables(conn)
        print(f"✅ 検出されたテーブル数: {len(tables)}")
        print()
        
        # テーブル一覧とレコード数を表示
        print("=" * 80)
        print("テーブル一覧とレコード数")
        print("=" * 80)
        
        table_info = []
        for table in tables:
            count = get_table_row_count(conn, table)
            table_info.append((table, count))
            print(f"  {table:<50} {count:>15,}" if isinstance(count, int) else f"  {table:<50} {count}")
        
        print()
        print("=" * 80)
        
        # JRA関連テーブルの詳細調査
        jra_tables = [t for t in tables if 'jra' in t.lower() or 'race' in t.lower() or 'uma' in t.lower()]
        
        if jra_tables:
            print("🔍 主要テーブルのカラム構造")
            print("=" * 80)
            
            for table in jra_tables[:5]:  # 最初の5テーブルのみ詳細表示
                print(f"\n📋 テーブル: {table}")
                print("-" * 80)
                df_cols = get_table_columns(conn, table)
                print(df_cols.to_string(index=False))
                print()
        
        # 出馬表テーブル検索
        print("=" * 80)
        print("🎯 重要: 出馬表テーブルの特定")
        print("=" * 80)
        
        shutsuba_candidates = [t for t in tables if 'shutsuba' in t.lower() or 'entry' in t.lower() or 'starter' in t.lower()]
        if shutsuba_candidates:
            print(f"✅ 出馬表テーブル候補: {shutsuba_candidates}")
            for table in shutsuba_candidates:
                count = get_table_row_count(conn, table)
                print(f"  - {table}: {count:,} レコード")
        else:
            print("⚠️  'shutsuba'を含むテーブルが見つかりません")
            print("   他のテーブル名を確認してください")
        
        print()
        
        # 予測テーブル検索
        print("=" * 80)
        print("🤖 既存AI予測テーブルの確認")
        print("=" * 80)
        
        pred_tables = [t for t in tables if 'pred' in t.lower() or 'lambdarank' in t.lower()]
        if pred_tables:
            print(f"✅ 予測テーブル候補: {pred_tables}")
            for table in pred_tables:
                count = get_table_row_count(conn, table)
                print(f"  - {table}: {count:,} レコード")
                
                # カラム構造表示
                if count != 0 and isinstance(count, int):
                    print(f"\n   カラム構造:")
                    df_cols = get_table_columns(conn, table)
                    for _, row in df_cols.iterrows():
                        print(f"     - {row['column_name']}: {row['data_type']}")
        else:
            print("⚠️  予測テーブルが見つかりません")
        
        print()
        print("=" * 80)
        print("✅ 調査完了")
        print("=" * 80)
        
        # 結果をテキストファイルに保存
        output_file = "database_structure_report.txt"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("=" * 80 + "\n")
            f.write("PC-KEIBA PostgreSQL データベース構造調査レポート\n")
            f.write("=" * 80 + "\n")
            f.write(f"調査日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"データベース: {DB_CONFIG['database']}\n")
            f.write(f"テーブル数: {len(tables)}\n")
            f.write("=" * 80 + "\n\n")
            
            f.write("テーブル一覧とレコード数:\n")
            f.write("-" * 80 + "\n")
            for table, count in table_info:
                f.write(f"{table:<50} {count:>15,}\n" if isinstance(count, int) else f"{table:<50} {count}\n")
            
        print(f"\n📄 調査結果を保存しました: {output_file}")
        
    except Exception as e:
        print(f"❌ エラーが発生しました: {e}")
        import traceback
        traceback.print_exc()
    
    finally:
        conn.close()
        print("\n✅ データベース接続をクローズしました")

if __name__ == "__main__":
    main()
