# Phase 7-A データソース調査計画（修正版） - 2026-03-03

**重要な理解**: CSVは厳選済み（139列） → **元データソース（PostgreSQL）を調べる**

---

## 🎯 正しい理解

### **Phase 1-6 の処理フロー**

```
PostgreSQL データベース『pckeiba』
├── JRA-VANテーブル: jvd_ra, jvd_se, jvd_ck
│   ↓（Phase 1で97列を抽出・厳選）
│   jra_jravan_97cols.csv
│
├── JRDBテーブル: jrd_kyi, jrd_cyb, jrd_joa, jrd_sed
│   ↓（Phase 1で41+7列を抽出・厳選）
│   jrdb_basic_41cols.csv + jrdb_past_7cols.csv
│
↓ Phase 2で統合
jravan_jrdb_merged_fixed.csv（139列に厳選）
```

### **Phase 7-A の正しい目標**

**元のPostgreSQLデータベースに戻って、すべての利用可能なカラムを調査する**

---

## 📊 PostgreSQL データベース構造（Phase 1のコードから判明）

### **JRA-VANテーブル**

| テーブル名 | 説明 | Phase 1で使用 |
|-----------|------|--------------|
| **jvd_ra** | レース基本情報 | ✅ 使用（一部カラムのみ） |
| **jvd_se** | 出走馬情報 | ✅ 使用（一部カラムのみ） |
| **jvd_ck** | 馬成績データ | ✅ 使用（一部カラムのみ） |

### **JRDBテーブル**

| テーブル名 | 説明 | Phase 1で使用 |
|-----------|------|--------------|
| **jrd_kyi** | JRDB 競走馬調教データ | ✅ 使用（一部カラムのみ） |
| **jrd_cyb** | JRDB 調教評価 | ✅ 使用（一部カラムのみ） |
| **jrd_joa** | JRDB 騎手評価 | ✅ 使用（一部カラムのみ） |
| **jrd_sed** | JRDB レース詳細 | ✅ 使用（一部カラムのみ） |

---

## 🚀 Phase 7-A Day 1-2: PostgreSQLデータベース調査

### **ステップ 1: PostgreSQL接続情報確認**

```powershell
cd E:\anonymous-keiba-ai-JRA
type config\db_config.yaml
```

**確認項目**:
- ホスト: localhost（通常）
- ポート: 5432（PostgreSQLデフォルト）
- データベース名: pckeiba
- ユーザー名
- パスワード

### **ステップ 2: PostgreSQLサービス起動確認**

```powershell
# PostgreSQLサービスが起動しているか確認
Get-Service -Name postgresql*

# または
Get-Service | Where-Object {$_.DisplayName -like "*postgres*"}
```

**起動していない場合**:
```powershell
Start-Service postgresql-x64-14  # バージョンに応じて変更
```

### **ステップ 3: PostgreSQL全カラム調査スクリプト作成**

以下のPythonスクリプトを作成します:

**ファイル名**: `E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion\investigate_database_schema.py`

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-A Day 1-2: PostgreSQLデータベース全カラム調査
====================================================

目的: pckeiba データベースの全テーブル・全カラムをリストアップ
"""

import yaml
import psycopg2
import pandas as pd
from pathlib import Path

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path('config/db_config.yaml')
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    # jravan設定を使用（pckeibaデータベース）
    db_config = config['jravan'].copy()
    db_config['database'] = 'pckeiba'
    return db_config

def get_all_tables(conn):
    """すべてのテーブル名を取得"""
    query = """
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public'
    ORDER BY table_name;
    """
    df = pd.read_sql_query(query, conn)
    return df['table_name'].tolist()

def get_table_columns(conn, table_name):
    """指定テーブルの全カラム情報を取得"""
    query = """
    SELECT 
        column_name,
        data_type,
        character_maximum_length,
        is_nullable
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name = %s
    ORDER BY ordinal_position;
    """
    df = pd.read_sql_query(query, conn, params=(table_name,))
    return df

def main():
    print("=" * 80)
    print("Phase 7-A: PostgreSQLデータベース全カラム調査")
    print("=" * 80)
    
    # 1. データベース接続
    print("\n[Step 1] データベース接続...")
    try:
        db_config = load_db_config()
        conn = psycopg2.connect(
            host=db_config['host'],
            port=db_config['port'],
            database=db_config['database'],
            user=db_config['user'],
            password=db_config['password']
        )
        print("✅ 接続成功")
    except Exception as e:
        print(f"❌ 接続失敗: {e}")
        return
    
    # 2. 全テーブル取得
    print("\n[Step 2] 全テーブル取得...")
    tables = get_all_tables(conn)
    print(f"✅ テーブル数: {len(tables)}")
    
    # JRA-VANとJRDBテーブルをフィルタ
    jravan_tables = [t for t in tables if t.startswith('jvd_')]
    jrdb_tables = [t for t in tables if t.startswith('jrd_')]
    
    print(f"\nJRA-VANテーブル: {len(jravan_tables)}個")
    for t in jravan_tables:
        print(f"  - {t}")
    
    print(f"\nJRDBテーブル: {len(jrdb_tables)}個")
    for t in jrdb_tables:
        print(f"  - {t}")
    
    # 3. 各テーブルのカラム情報を取得
    print("\n[Step 3] 各テーブルのカラム情報を取得...")
    
    # 出力ディレクトリ作成
    output_dir = Path('phase7/results/phase7a_features')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # JRA-VANテーブル
    print("\n[JRA-VAN テーブル調査]")
    all_jravan_columns = []
    for table in jravan_tables:
        print(f"\n  {table}:")
        df_cols = get_table_columns(conn, table)
        print(f"    カラム数: {len(df_cols)}")
        
        # テーブル名を追加
        df_cols['table_name'] = table
        all_jravan_columns.append(df_cols)
        
        # 最初の5カラムを表示
        for idx, row in df_cols.head(5).iterrows():
            print(f"      {row['column_name']} ({row['data_type']})")
    
    # 統合して保存
    df_jravan_all = pd.concat(all_jravan_columns, ignore_index=True)
    output_file = output_dir / 'jravan_all_columns.csv'
    df_jravan_all.to_csv(output_file, index=False, encoding='utf-8')
    print(f"\n✅ JRA-VAN全カラム保存: {output_file}")
    print(f"   総カラム数: {len(df_jravan_all)}")
    
    # JRDBテーブル
    print("\n[JRDB テーブル調査]")
    all_jrdb_columns = []
    for table in jrdb_tables:
        print(f"\n  {table}:")
        df_cols = get_table_columns(conn, table)
        print(f"    カラム数: {len(df_cols)}")
        
        # テーブル名を追加
        df_cols['table_name'] = table
        all_jrdb_columns.append(df_cols)
        
        # 最初の5カラムを表示
        for idx, row in df_cols.head(5).iterrows():
            print(f"      {row['column_name']} ({row['data_type']})")
    
    # 統合して保存
    df_jrdb_all = pd.concat(all_jrdb_columns, ignore_index=True)
    output_file = output_dir / 'jrdb_all_columns.csv'
    df_jrdb_all.to_csv(output_file, index=False, encoding='utf-8')
    print(f"\n✅ JRDB全カラム保存: {output_file}")
    print(f"   総カラム数: {len(df_jrdb_all)}")
    
    # サマリー出力
    print("\n" + "=" * 80)
    print("調査完了サマリー")
    print("=" * 80)
    print(f"JRA-VANテーブル: {len(jravan_tables)}個, 総カラム数: {len(df_jravan_all)}")
    print(f"JRDBテーブル: {len(jrdb_tables)}個, 総カラム数: {len(df_jrdb_all)}")
    print(f"\n成果物:")
    print(f"  - phase7/results/phase7a_features/jravan_all_columns.csv")
    print(f"  - phase7/results/phase7a_features/jrdb_all_columns.csv")
    
    conn.close()

if __name__ == '__main__':
    main()
```

---

## 📋 実行手順

### **1. PostgreSQL接続情報確認**

```powershell
cd E:\anonymous-keiba-ai-JRA
type config\db_config.yaml
```

### **2. PostgreSQLサービス確認**

```powershell
Get-Service -Name postgresql*
```

### **3. 調査スクリプト実行**

```powershell
cd E:\anonymous-keiba-ai-JRA
python phase7\scripts\phase7a_feature_expansion\investigate_database_schema.py
```

---

## 📊 期待される成果物

### **Day 1-2 成果物**

| ファイル名 | 内容 | 期待カラム数 |
|-----------|------|-------------|
| **jravan_all_columns.csv** | JRA-VAN全テーブルの全カラム | 200~300列 |
| **jrdb_all_columns.csv** | JRDB全テーブルの全カラム | 150~250列 |

### **Day 3-4 で実施すること**

1. `jravan_all_columns.csv` を開く
2. Phase 1で使用した97列を特定
3. **未使用カラム**を抽出（期待: +50~100列）
4. 前日情報として利用可能かを判定

---

## ✅ 確認チェックリスト

### 理解の確認
- [x] CSVは厳選済み（139列）
- [x] **元データはPostgreSQLデータベース**
- [x] データベースにはもっと多くのカラムがある
- [x] Phase 7-Aではデータベースの全カラムを調査する

### 次のアクション
- [ ] PostgreSQL接続情報確認（config/db_config.yaml）
- [ ] PostgreSQLサービス起動確認
- [ ] 調査スクリプト作成・実行
- [ ] jravan_all_columns.csv, jrdb_all_columns.csv の取得

---

**まず config/db_config.yaml の内容を確認してください 🚀**
