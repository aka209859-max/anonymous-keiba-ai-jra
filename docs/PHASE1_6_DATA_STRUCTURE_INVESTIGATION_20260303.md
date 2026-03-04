# Phase 1-6 データ構造調査報告 - 2026-03-03

**調査日時**: 2026-03-03  
**調査対象**: E:\anonymous-keiba-ai-JRA のPhase 1-6実装

---

## 🎯 重要な発見

### **✅ データは既に存在しています！**

`E:\anonymous-keiba-ai-JRA\data\raw\` に以下のCSVファイルがあります:

| ファイル名 | サイズ | 説明 |
|-----------|--------|------|
| **jra_jravan_97cols.csv** | 99.8 MB | JRA-VAN 97カラム |
| **jrdb_basic_41cols.csv** | 87.2 MB | JRDB基本 41カラム |
| **jrdb_past_7cols.csv** | 22.2 MB | JRDB過去走 7カラム |
| **jrdb_48cols.csv** | 715 bytes | JRDB 48カラム（小さいファイル） |
| **jra_jravan_central_only.csv** | 54.1 MB | JRA-VAN中央競馬のみ |
| **jravan_jrdb_merged.csv** | 137.9 MB | JRA-VAN + JRDB 統合 |
| **jravan_jrdb_merged_fixed.csv** | 138.8 MB | JRA-VAN + JRDB 統合（修正版） |

---

## 📊 Phase 1-6 で使用した特徴量構成

### **Phase 1: extract_jra_features_v1.py の分析**

**特徴量構成（合計145列）**:
- **JRA-VAN**: 97カラム
- **JRDB基本**: 41カラム
- **JRDB過去走**: 4カラム（race_pace, batai_code, pace_shisu, uma_pace）
- **派生特徴量**: 3カラム

**データソース**:
- データベース: `pckeiba`（PostgreSQL）
- テーブル:
  - JRA-VAN: `jvd_ra`, `jvd_se`, `jvd_ck`
  - JRDB: `jrd_kyi`, `jrd_cyb`, `jrd_joa`, `jrd_sed`
- データ期間: 2016-2025年

### **Phase 2: merge_all_features.py の分析**

**統合処理**:
- 11個の競馬場別CSVを1つに統合
- 最終列数: **139列**
- 期待行数: 480,000 ～ 485,000行

**139列の内訳（推定）**:
- JRA-VAN: 97列
- JRDB基本: 41列
- JRDB過去走: 1列（おそらく統合時に削減）

---

## 🔍 Phase 7-A の調整案

### **発見: Phase 1-6 では 145列 → 139列 に厳選していた**

Phase 7-A の目標は「**すべての利用可能な特徴量を探す**」ことです。

### **Phase 7-A の正しいアプローチ**

#### **Day 1-2: 既存データの完全分析**

1. **JRA-VAN 97カラムの詳細確認**
   ```powershell
   cd E:\anonymous-keiba-ai-JRA\data\raw
   
   # Pythonでカラム一覧を取得
   python -c "import pandas as pd; df = pd.read_csv('jra_jravan_97cols.csv', nrows=5); print('\n'.join(df.columns))" > jravan_97cols_list.txt
   ```

2. **JRDB 41+7カラムの詳細確認**
   ```powershell
   # JRDB基本41カラム
   python -c "import pandas as pd; df = pd.read_csv('jrdb_basic_41cols.csv', nrows=5); print('\n'.join(df.columns))" > jrdb_basic_41cols_list.txt
   
   # JRDB過去走7カラム
   python -c "import pandas as pd; df = pd.read_csv('jrdb_past_7cols.csv', nrows=5); print('\n'.join(df.columns))" > jrdb_past_7cols_list.txt
   ```

3. **統合ファイルの139カラム確認**
   ```powershell
   python -c "import pandas as pd; df = pd.read_csv('jravan_jrdb_merged_fixed.csv', nrows=5); print('\n'.join(df.columns))" > merged_139cols_list.txt
   ```

#### **Day 3-4: PostgreSQLデータベースの追加カラム調査**

Phase 1-6 では **データベースから97+41列を抽出** していました。  
データベースには **さらに多くのカラムが存在する可能性** があります。

**調査対象テーブル**:
- **JRA-VAN**: `jvd_ra`, `jvd_se`, `jvd_ck`
- **JRDB**: `jrd_kyi`, `jrd_cyb`, `jrd_joa`, `jrd_sed`

**調査方法**:
1. PostgreSQLに接続
2. 各テーブルの全カラムをリストアップ
3. Phase 1-6で使用していないカラムを特定
4. 前日情報として利用可能かを判定

#### **Day 5-6: 追加特徴量候補の抽出**

**目標次元数**:
- **Phase 1-6**: 139次元（厳選済み）
- **Phase 7-A 目標**: 200~220次元（すべての利用可能な特徴量）

**追加候補**:
- JRA-VAN未使用カラム: +20~40列
- JRDB未使用カラム: +20~30列
- 派生特徴量: +20~30列

#### **Day 7: 統合マスター作成**

**成果物**:
- `jravan_available_features.csv`: JRA-VAN全カラム（97 + 追加）
- `jrdb_available_features.csv`: JRDB全カラム（48 + 追加）
- `combined_features_master.csv`: 統合220次元
- `cross_source_feature_candidates.csv`: クロスソース候補

---

## 🚀 次のアクション（今すぐ実行）

### **ステップ 1: 既存CSVのカラム一覧を取得**

```powershell
cd E:\anonymous-keiba-ai-JRA\data\raw

# JRA-VAN 97カラム一覧
python -c "import pandas as pd; df = pd.read_csv('jra_jravan_97cols.csv', nrows=1); print('JRA-VAN 97 columns:'); print('\n'.join(df.columns)); print(f'\nTotal: {len(df.columns)} columns')" > jravan_columns.txt

# JRDB 41カラム一覧
python -c "import pandas as pd; df = pd.read_csv('jrdb_basic_41cols.csv', nrows=1); print('JRDB Basic 41 columns:'); print('\n'.join(df.columns)); print(f'\nTotal: {len(df.columns)} columns')" > jrdb_basic_columns.txt

# JRDB過去走7カラム一覧
python -c "import pandas as pd; df = pd.read_csv('jrdb_past_7cols.csv', nrows=1); print('JRDB Past 7 columns:'); print('\n'.join(df.columns)); print(f'\nTotal: {len(df.columns)} columns')" > jrdb_past_columns.txt

# 統合139カラム一覧
python -c "import pandas as pd; df = pd.read_csv('jravan_jrdb_merged_fixed.csv', nrows=1); print('Merged 139 columns:'); print('\n'.join(df.columns)); print(f'\nTotal: {len(df.columns)} columns')" > merged_columns.txt

# ファイル表示
type jravan_columns.txt
type jrdb_basic_columns.txt
type jrdb_past_columns.txt
type merged_columns.txt
```

### **ステップ 2: PostgreSQLデータベース確認**

Phase 1-6 のスクリプトでは `config/db_config.yaml` を使用しています。

```powershell
cd E:\anonymous-keiba-ai-JRA
type config\db_config.yaml
```

**確認項目**:
- PostgreSQLが起動しているか？
- データベース名: `pckeiba`
- アクセス情報（ホスト、ポート、ユーザー、パスワード）

### **ステップ 3: 報告**

以下の情報を報告してください:

1. ✅ カラム一覧の取得結果（jravan_columns.txt, jrdb_basic_columns.txt 等）
2. ✅ PostgreSQLデータベースの状況（起動しているか？）
3. ✅ `config/db_config.yaml` の内容

---

## 📋 Phase 7-A Week 1 修正計画

### **修正後の目標**

**Phase 1-6 の実績**:
- 使用した特徴量: 139次元（JRA-VAN 97 + JRDB 41 + 派生 1）
- データソース: PostgreSQL データベース `pckeiba`
- データ形式: CSV（生データ）

**Phase 7-A の目標**:
- **すべての利用可能な特徴量を抽出**: 200~220次元
- データベースの未使用カラムを調査
- 前日情報として利用可能なカラムをすべて特定

### **修正後のスケジュール**

| Day | タスク | 成果物 |
|-----|--------|--------|
| **Day 1-2** | 既存CSVのカラム一覧取得<br>PostgreSQLデータベース確認 | jravan_columns.txt<br>jrdb_basic_columns.txt<br>merged_columns.txt<br>db_config確認 |
| **Day 3-4** | PostgreSQLの全テーブル・全カラム調査<br>未使用カラムの特定 | jravan_all_columns.csv<br>jrdb_all_columns.csv<br>unused_columns.csv |
| **Day 5-6** | 追加特徴量候補の抽出<br>前日情報判定 | additional_features_candidates.csv<br>220次元候補リスト |
| **Day 7** | 統合マスター作成 | combined_features_master.csv（220次元）<br>cross_source_feature_candidates.csv |

---

## ✅ 確認チェックリスト

### 理解の確認

- [x] Phase 1-6 では既に JRA-VAN + JRDB のデータを使用していた
- [x] 既存データは CSV形式で `data/raw/` に保存されている
- [x] Phase 1-6 では 139次元に厳選していた
- [x] Phase 7-A では **すべての利用可能な特徴量** を抽出する
- [x] データベース `pckeiba` に追加のカラムが存在する可能性がある

### 次のアクション

- [ ] 既存CSVのカラム一覧を取得（ステップ1）
- [ ] PostgreSQLデータベースの状況確認（ステップ2）
- [ ] カラム一覧と db_config.yaml を報告（ステップ3）

---

**まずステップ1のPowerShellコマンドを実行して、カラム一覧を取得してください 🚀**
