#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
データベーススキーマ完全エクスポートスクリプト
===============================================

【目的】
PC-KEIBAデータベースの全テーブル構造を調査し、
Markdownファイルとして保存する。

【出力】
- docs/DB_SCHEMA_JRAVAN.md: JRA-VANテーブル群（jvd_*）
- docs/DB_SCHEMA_JRDB.md: JRDBテーブル群（jrd_*）

【実行方法】
python scripts/utils/export_db_schema.py --db-config config/db_config.yaml

【作成日】2026-02-21
"""

import argparse
import yaml
import psycopg2
from pathlib import Path
from datetime import datetime

def load_db_config(config_path: str) -> dict:
    """DB設定ファイルを読み込む"""
    with open(config_path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def get_all_tables(cursor, schema_prefix: str) -> list:
    """指定されたプレフィックスを持つテーブル一覧を取得"""
    cursor.execute(f"""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
          AND table_name LIKE '{schema_prefix}%'
        ORDER BY table_name;
    """)
    return [row[0] for row in cursor.fetchall()]

def get_table_columns(cursor, table_name: str) -> list:
    """テーブルのカラム情報を取得"""
    cursor.execute(f"""
        SELECT 
            column_name, 
            data_type, 
            character_maximum_length,
            is_nullable,
            column_default
        FROM information_schema.columns
        WHERE table_name = '{table_name}'
        ORDER BY ordinal_position;
    """)
    return cursor.fetchall()

def get_table_row_count(cursor, table_name: str) -> int:
    """テーブルの行数を取得"""
    try:
        cursor.execute(f"SELECT COUNT(*) FROM {table_name};")
        return cursor.fetchone()[0]
    except Exception:
        return 0

def export_schema_to_markdown(conn, schema_prefix: str, output_path: str, schema_name: str):
    """スキーマ情報をMarkdownファイルに出力"""
    cursor = conn.cursor()
    
    # テーブル一覧取得
    tables = get_all_tables(cursor, schema_prefix)
    
    # Markdown生成
    md_lines = []
    md_lines.append(f"# {schema_name} データベーススキーマ")
    md_lines.append("")
    md_lines.append(f"**生成日時**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    md_lines.append(f"**テーブル数**: {len(tables)}")
    md_lines.append("")
    md_lines.append("---")
    md_lines.append("")
    
    # 目次
    md_lines.append("## 📋 目次")
    md_lines.append("")
    for i, table in enumerate(tables, 1):
        row_count = get_table_row_count(cursor, table)
        md_lines.append(f"{i}. [{table}](#{table.replace('_', '-')}) ({row_count:,}行)")
    md_lines.append("")
    md_lines.append("---")
    md_lines.append("")
    
    # 各テーブルの詳細
    for table in tables:
        columns = get_table_columns(cursor, table)
        row_count = get_table_row_count(cursor, table)
        
        md_lines.append(f"## {table}")
        md_lines.append("")
        md_lines.append(f"**行数**: {row_count:,}")
        md_lines.append(f"**カラム数**: {len(columns)}")
        md_lines.append("")
        
        # カラム情報テーブル
        md_lines.append("| # | カラム名 | データ型 | 長さ | NULL許可 | デフォルト値 |")
        md_lines.append("|---|----------|----------|------|----------|--------------|")
        
        for i, (col_name, data_type, max_length, nullable, default_val) in enumerate(columns, 1):
            max_length_str = str(max_length) if max_length else "-"
            nullable_str = "YES" if nullable == "YES" else "NO"
            default_str = str(default_val) if default_val else "-"
            md_lines.append(f"| {i} | `{col_name}` | {data_type} | {max_length_str} | {nullable_str} | {default_str} |")
        
        md_lines.append("")
        
        # サンプルデータ（最初の3行）
        try:
            cursor.execute(f"SELECT * FROM {table} LIMIT 3;")
            sample_rows = cursor.fetchall()
            
            if sample_rows:
                md_lines.append("### サンプルデータ（最初の3行）")
                md_lines.append("")
                md_lines.append("```")
                col_names = [desc[0] for desc in cursor.description]
                md_lines.append(" | ".join(col_names))
                md_lines.append("-" * 80)
                for row in sample_rows:
                    row_str = " | ".join([str(val)[:30] if val else "NULL" for val in row])
                    md_lines.append(row_str)
                md_lines.append("```")
                md_lines.append("")
        except Exception as e:
            md_lines.append(f"_サンプルデータ取得エラー: {str(e)}_")
            md_lines.append("")
        
        md_lines.append("---")
        md_lines.append("")
    
    # ファイル保存
    output_path = Path(output_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(md_lines))
    
    print(f"✅ スキーマ保存完了: {output_path} ({len(tables)}テーブル)")
    cursor.close()

def main():
    parser = argparse.ArgumentParser(description='データベーススキーマをMarkdownファイルにエクスポート')
    parser.add_argument('--db-config', default='config/db_config.yaml', help='DB設定ファイルパス')
    parser.add_argument('--output-dir', default='docs/database_schema', help='出力ディレクトリ')
    args = parser.parse_args()
    
    # DB設定読込
    config = load_db_config(args.db_config)
    
    # JRA-VAN スキーマエクスポート
    print("\n[1/2] JRA-VAN テーブル構造調査開始...")
    conn_jravan = psycopg2.connect(
        host=config['jravan']['host'],
        port=config['jravan']['port'],
        dbname=config['jravan']['database'],
        user=config['jravan']['user'],
        password=config['jravan']['password']
    )
    export_schema_to_markdown(
        conn_jravan, 
        'jvd_', 
        f"{args.output_dir}/DB_SCHEMA_JRAVAN.md",
        "JRA-VAN"
    )
    conn_jravan.close()
    
    # JRDB スキーマエクスポート
    print("\n[2/2] JRDB テーブル構造調査開始...")
    conn_jrdb = psycopg2.connect(
        host=config['jrdb']['host'],
        port=config['jrdb']['port'],
        dbname=config['jrdb']['database'],
        user=config['jrdb']['user'],
        password=config['jrdb']['password']
    )
    export_schema_to_markdown(
        conn_jrdb, 
        'jrd_', 
        f"{args.output_dir}/DB_SCHEMA_JRDB.md",
        "JRDB"
    )
    conn_jrdb.close()
    
    print("\n" + "="*80)
    print("✅ 全テーブル構造エクスポート完了")
    print("="*80)
    print(f"\n出力先:")
    print(f"  - {args.output_dir}/DB_SCHEMA_JRAVAN.md")
    print(f"  - {args.output_dir}/DB_SCHEMA_JRDB.md")
    print("\n次のステップ:")
    print("  1. 上記ファイルを確認")
    print("  2. extract_jra_features_v1.py のカラム名を修正")
    print("  3. 再テスト実行")

if __name__ == '__main__':
    main()
