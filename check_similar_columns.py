#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
欠損カラムと同じ名前のカラムを他テーブルから探す
"""
import psycopg2
import yaml

with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
    config = yaml.safe_load(f)

# 調査対象カラム
target_columns = [
    'pace', 'deokure', 'furi', 'furi_1', 'furi_2', 'furi_3', 'batai_code'
]

print("="*80)
print("【調査対象】jrd_sed で空白だったカラム")
print("="*80)
for col in target_columns:
    print(f"  - {col}")

print("\n" + "="*80)
print("【1】JRDB データベース内での検索")
print("="*80)

conn_jrdb = psycopg2.connect(**config['jrdb'])
cursor_jrdb = conn_jrdb.cursor()

for col in target_columns:
    cursor_jrdb.execute("""
        SELECT table_name, column_name, data_type, character_maximum_length
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND column_name = %s
        ORDER BY table_name;
    """, (col,))
    
    results = cursor_jrdb.fetchall()
    
    print(f"\n【{col}】")
    if results:
        for table, column, dtype, max_len in results:
            print(f"  ✅ テーブル: {table:20s} | 型: {dtype:20s} | 長さ: {max_len}")
        
        # データがあるか確認
        for table, _, _, _ in results:
            try:
                cursor_jrdb.execute(f"""
                    SELECT COUNT(*) as total,
                           COUNT(CASE WHEN TRIM({col}) != '' THEN 1 END) as non_empty,
                           COUNT(CASE WHEN TRIM({col}) = '' OR {col} IS NULL THEN 1 END) as empty
                    FROM {table}
                    WHERE keibajo_code = '01';
                """)
                total, non_empty, empty = cursor_jrdb.fetchone()
                empty_rate = (empty / total * 100) if total > 0 else 0
                
                if non_empty > 0:
                    print(f"    → {table}: 総数 {total:,}件 | データ有り {non_empty:,}件 ({100-empty_rate:.1f}%) | 空白 {empty:,}件 ({empty_rate:.1f}%)")
                    
                    # サンプルデータ取得（データがある場合）
                    cursor_jrdb.execute(f"""
                        SELECT {col}
                        FROM {table}
                        WHERE keibajo_code = '01' 
                          AND TRIM({col}) != ''
                        LIMIT 3;
                    """)
                    samples = cursor_jrdb.fetchall()
                    if samples:
                        print(f"       サンプル: {[s[0] for s in samples]}")
                else:
                    print(f"    → {table}: 全て空白 ({total:,}件)")
            except Exception as e:
                print(f"    → {table}: データ確認エラー ({e})")
    else:
        print(f"  ❌ 見つかりませんでした")

print("\n" + "="*80)
print("【2】JRA-VAN データベース内での検索")
print("="*80)

conn_jravan = psycopg2.connect(**config['jravan'])
cursor_jravan = conn_jravan.cursor()

for col in target_columns:
    cursor_jravan.execute("""
        SELECT table_name, column_name, data_type, character_maximum_length
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND column_name = %s
        ORDER BY table_name;
    """, (col,))
    
    results = cursor_jravan.fetchall()
    
    print(f"\n【{col}】")
    if results:
        for table, column, dtype, max_len in results:
            print(f"  ✅ テーブル: {table:20s} | 型: {dtype:20s} | 長さ: {max_len}")
        
        # データがあるか確認
        for table, _, _, _ in results:
            try:
                cursor_jravan.execute(f"""
                    SELECT COUNT(*) as total,
                           COUNT(CASE WHEN TRIM({col}) != '' THEN 1 END) as non_empty
                    FROM {table}
                    WHERE keibajo_code = '01';
                """)
                total, non_empty = cursor_jravan.fetchone()
                
                if non_empty > 0:
                    print(f"    → {table}: 総数 {total:,}件 | データ有り {non_empty:,}件 ({non_empty/total*100:.1f}%)")
                    
                    # サンプルデータ取得
                    cursor_jravan.execute(f"""
                        SELECT {col}
                        FROM {table}
                        WHERE keibajo_code = '01' 
                          AND TRIM({col}) != ''
                        LIMIT 3;
                    """)
                    samples = cursor_jravan.fetchall()
                    if samples:
                        print(f"       サンプル: {[s[0] for s in samples]}")
                else:
                    print(f"    → {table}: 全て空白")
            except Exception as e:
                print(f"    → {table}: データ確認エラー")
    else:
        print(f"  ❌ 見つかりませんでした")

print("\n" + "="*80)
print("【3】類似カラム名の検索（部分一致）")
print("="*80)

# 'pace', 'furi' などのキーワードで類似カラムを探す
keywords = ['pace', 'furi', 'deokure', 'batai']

for keyword in keywords:
    cursor_jrdb.execute("""
        SELECT table_name, column_name
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND column_name LIKE %s
        ORDER BY table_name, column_name;
    """, (f'%{keyword}%',))
    
    results = cursor_jrdb.fetchall()
    
    print(f"\n【キーワード: {keyword}】")
    if results:
        for table, column in results:
            print(f"  ✅ {table:20s}.{column}")
    else:
        print(f"  ❌ 見つかりませんでした")

conn_jrdb.close()
conn_jravan.close()

print("\n" + "="*80)
print("調査完了")
print("="*80)
