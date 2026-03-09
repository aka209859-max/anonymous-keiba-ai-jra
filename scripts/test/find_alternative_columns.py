#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRDB全テーブルから pace, deokure, furi 等の代替カラムを検索
"""
import psycopg2
import yaml

with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

conn = psycopg2.connect(**config['jrdb'])
cursor = conn.cursor()

# 検索対象のキーワード
search_keywords = ['pace', 'deokure', 'furi', 'batai']

# JRDBの全テーブル一覧取得
cursor.execute("""
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public' 
      AND table_name LIKE 'jrd_%'
    ORDER BY table_name;
""")
tables = [row[0] for row in cursor.fetchall()]

print("="*80)
print("JRDB 全テーブル一覧")
print("="*80)
print(f"テーブル数: {len(tables)}")
print(f"テーブル: {', '.join(tables)}")

print("\n" + "="*80)
print("検索対象キーワード: " + ", ".join(search_keywords))
print("="*80)

# 各キーワードでカラム検索
for keyword in search_keywords:
    print(f"\n{'='*80}")
    print(f"🔍 キーワード: '{keyword}' を含むカラム")
    print("="*80)
    
    cursor.execute(f"""
        SELECT table_name, column_name, data_type, character_maximum_length
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name LIKE 'jrd_%'
          AND column_name LIKE '%{keyword}%'
        ORDER BY table_name, ordinal_position;
    """)
    
    results = cursor.fetchall()
    
    if results:
        for table, column, dtype, length in results:
            length_str = f"({length})" if length else ""
            print(f"  📌 {table:20s} | {column:30s} | {dtype}{length_str}")
            
            # サンプルデータ取得（NULL以外の値）
            try:
                cursor.execute(f"""
                    SELECT {column}, COUNT(*) as cnt
                    FROM {table}
                    WHERE {column} IS NOT NULL 
                      AND TRIM({column}) != ''
                    GROUP BY {column}
                    ORDER BY cnt DESC
                    LIMIT 5;
                """)
                samples = cursor.fetchall()
                
                if samples:
                    print(f"       └─ サンプル値:")
                    for value, count in samples:
                        value_display = repr(value[:20]) if len(str(value)) > 20 else repr(value)
                        print(f"          • {value_display} ({count:,}件)")
                else:
                    print(f"       └─ ⚠️ 全て NULL または空白")
            except Exception as e:
                print(f"       └─ サンプル取得エラー: {e}")
    else:
        print(f"  ❌ 見つかりませんでした")

# 特殊ケース: jrd_sed 以外で過去走データがあるテーブル
print("\n" + "="*80)
print("🔍 過去走データを含む可能性のあるテーブル")
print("="*80)

for table in tables:
    if table == 'jrd_sed':
        continue
    
    try:
        # ketto_toroku_bango を含むテーブルを確認
        cursor.execute(f"""
            SELECT column_name 
            FROM information_schema.columns
            WHERE table_name = '{table}'
              AND column_name IN ('ketto_toroku_bango', 'bamei', 'kaisai_nen', 'kaisai_tsukihi')
            ORDER BY column_name;
        """)
        key_cols = [row[0] for row in cursor.fetchall()]
        
        if 'ketto_toroku_bango' in key_cols:
            cursor.execute(f"SELECT COUNT(*) FROM {table};")
            count = cursor.fetchone()[0]
            
            # カラム数取得
            cursor.execute(f"""
                SELECT COUNT(*) 
                FROM information_schema.columns
                WHERE table_name = '{table}';
            """)
            col_count = cursor.fetchone()[0]
            
            print(f"  📊 {table:20s} | {count:>10,}件 | {col_count:3d}列 | キー: {', '.join(key_cols)}")
    except Exception as e:
        pass

print("\n" + "="*80)
print("調査完了")
print("="*80)

conn.close()
