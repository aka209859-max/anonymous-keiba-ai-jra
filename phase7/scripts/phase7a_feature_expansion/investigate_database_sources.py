#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-A データソース調査スクリプト
元のPostgreSQLデータベースから全テーブル・カラム情報を抽出
"""

import psycopg2
import yaml
import pandas as pd
from datetime import datetime
import sys
import os

def load_db_config():
    """DB設定読み込み"""
    config_path = os.path.join('..', '..', '..', 'config', 'db_config.yaml')
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config['jravan']

def get_all_tables_info(conn):
    """全テーブルとカラム情報取得"""
    cur = conn.cursor()
    
    # 全テーブル一覧
    cur.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        ORDER BY table_name;
    """)
    tables = cur.fetchall()
    
    print(f"\n{'='*80}")
    print(f"PostgreSQL データベーステーブル一覧")
    print(f"{'='*80}")
    print(f"合計テーブル数: {len(tables)}\n")
    
    table_info_list = []
    
    for (table_name,) in tables:
        # カラム情報取得
        cur.execute(f"""
            SELECT 
                column_name, 
                data_type, 
                character_maximum_length,
                is_nullable
            FROM information_schema.columns 
            WHERE table_schema = 'public' 
              AND table_name = '{table_name}'
            ORDER BY ordinal_position;
        """)
        columns = cur.fetchall()
        
        # 行数取得
        try:
            cur.execute(f"SELECT COUNT(*) FROM {table_name};")
            row_count = cur.fetchone()[0]
        except:
            row_count = 0
        
        table_info = {
            'table_name': table_name,
            'column_count': len(columns),
            'row_count': row_count,
            'columns': columns
        }
        table_info_list.append(table_info)
        
        print(f"{table_name}")
        print(f"  カラム数: {len(columns)}")
        print(f"  行数: {row_count:,}")
        print()
    
    cur.close()
    return table_info_list

def analyze_jra_van_tables(table_info_list):
    """JRA-VAN関連テーブルの詳細分析"""
    print(f"\n{'='*80}")
    print(f"JRA-VAN テーブル詳細分析")
    print(f"{'='*80}\n")
    
    # JVD_で始まるテーブルを検索
    jravan_tables = [t for t in table_info_list if t['table_name'].startswith('jvd_')]
    
    print(f"JVD_テーブル数: {len(jravan_tables)}\n")
    
    total_columns = 0
    for table in jravan_tables:
        print(f"\n【{table['table_name']}】")
        print(f"カラム数: {table['column_count']}")
        print(f"行数: {table['row_count']:,}")
        print(f"\nカラム一覧:")
        
        for col_name, data_type, max_len, nullable in table['columns']:
            type_info = f"{data_type}"
            if max_len:
                type_info += f"({max_len})"
            nullable_info = "NULL" if nullable == 'YES' else "NOT NULL"
            print(f"  - {col_name:<40} {type_info:<20} {nullable_info}")
        
        total_columns += table['column_count']
    
    print(f"\n{'='*80}")
    print(f"JRA-VANテーブル合計カラム数: {total_columns}")
    print(f"{'='*80}\n")
    
    return jravan_tables

def analyze_jrdb_tables(table_info_list):
    """JRDB関連テーブルの詳細分析"""
    print(f"\n{'='*80}")
    print(f"JRDB テーブル詳細分析")
    print(f"{'='*80}\n")
    
    # JRDBで始まるテーブル、またはjrdbを含むテーブルを検索
    jrdb_tables = [t for t in table_info_list 
                   if 'jrdb' in t['table_name'].lower()]
    
    print(f"JRDBテーブル数: {len(jrdb_tables)}\n")
    
    total_columns = 0
    for table in jrdb_tables:
        print(f"\n【{table['table_name']}】")
        print(f"カラム数: {table['column_count']}")
        print(f"行数: {table['row_count']:,}")
        print(f"\nカラム一覧:")
        
        for col_name, data_type, max_len, nullable in table['columns']:
            type_info = f"{data_type}"
            if max_len:
                type_info += f"({max_len})"
            nullable_info = "NULL" if nullable == 'YES' else "NOT NULL"
            print(f"  - {col_name:<40} {type_info:<20} {nullable_info}")
        
        total_columns += table['column_count']
    
    print(f"\n{'='*80}")
    print(f"JRDBテーブル合計カラム数: {total_columns}")
    print(f"{'='*80}\n")
    
    return jrdb_tables

def save_results(table_info_list, output_dir):
    """結果保存"""
    os.makedirs(output_dir, exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # 全テーブルサマリーCSV
    summary_data = []
    for table in table_info_list:
        summary_data.append({
            'table_name': table['table_name'],
            'column_count': table['column_count'],
            'row_count': table['row_count']
        })
    
    df_summary = pd.DataFrame(summary_data)
    summary_file = os.path.join(output_dir, f'database_tables_summary_{timestamp}.csv')
    df_summary.to_csv(summary_file, index=False, encoding='utf-8-sig')
    print(f"\n✅ サマリーファイル保存: {summary_file}")
    
    # 詳細カラム情報CSV
    detail_data = []
    for table in table_info_list:
        for col_name, data_type, max_len, nullable in table['columns']:
            detail_data.append({
                'table_name': table['table_name'],
                'column_name': col_name,
                'data_type': data_type,
                'max_length': max_len,
                'is_nullable': nullable
            })
    
    df_detail = pd.DataFrame(detail_data)
    detail_file = os.path.join(output_dir, f'database_columns_detail_{timestamp}.csv')
    df_detail.to_csv(detail_file, index=False, encoding='utf-8-sig')
    print(f"✅ 詳細ファイル保存: {detail_file}")
    
    return summary_file, detail_file

def main():
    """メイン処理"""
    print(f"\n{'='*80}")
    print(f"Phase 7-A データソース調査開始")
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"{'='*80}\n")
    
    try:
        # DB接続
        config = load_db_config()
        print(f"データベース接続中...")
        print(f"  Host: {config['host']}")
        print(f"  Port: {config['port']}")
        print(f"  Database: {config['database']}")
        
        conn = psycopg2.connect(
            host=config['host'],
            port=config['port'],
            database=config['database'],
            user=config['user'],
            password=config['password']
        )
        print(f"✅ 接続成功\n")
        
        # 全テーブル情報取得
        table_info_list = get_all_tables_info(conn)
        
        # JRA-VANテーブル分析
        jravan_tables = analyze_jra_van_tables(table_info_list)
        
        # JRDBテーブル分析
        jrdb_tables = analyze_jrdb_tables(table_info_list)
        
        # 結果保存
        output_dir = os.path.join('..', '..', 'results', 'phase7a_features')
        summary_file, detail_file = save_results(table_info_list, output_dir)
        
        # 最終サマリー
        print(f"\n{'='*80}")
        print(f"調査完了サマリー")
        print(f"{'='*80}")
        print(f"総テーブル数: {len(table_info_list)}")
        print(f"JRA-VANテーブル数: {len(jravan_tables)}")
        print(f"JRDBテーブル数: {len(jrdb_tables)}")
        
        total_jravan_cols = sum(t['column_count'] for t in jravan_tables)
        total_jrdb_cols = sum(t['column_count'] for t in jrdb_tables)
        
        print(f"\nJRA-VAN合計カラム数: {total_jravan_cols}")
        print(f"JRDB合計カラム数: {total_jrdb_cols}")
        print(f"総合計カラム数: {total_jravan_cols + total_jrdb_cols}")
        print(f"\n現在の特徴量数: 139")
        print(f"拡張可能カラム数: {total_jravan_cols + total_jrdb_cols - 139}")
        print(f"{'='*80}\n")
        
        conn.close()
        
        print("✅ Phase 7-A データソース調査完了")
        print(f"\n次のステップ:")
        print(f"1. {summary_file} を確認")
        print(f"2. {detail_file} を確認")
        print(f"3. 既存139カラムとの対応を分析")
        print(f"4. 未使用カラムから追加候補を選定")
        
        return 0
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == '__main__':
    sys.exit(main())
