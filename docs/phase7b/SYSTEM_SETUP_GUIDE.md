# Phase 7-B システム構築ガイド

## 📋 目次

1. [システム概要](#システム概要)
2. [必要な環境](#必要な環境)
3. [データベースセットアップ](#データベースセットアップ)
4. [ファイル構成](#ファイル構成)
5. [実行手順](#実行手順)
6. [トラブルシューティング](#トラブルシューティング)

---

## システム概要

Phase 7-B は JRA-VAN データと JRDB データを統合するデータ基盤システムです。

### 主な機能
1. **データ統合**: JRA-VAN（209列）+ JRDB（116列）→ 統合データセット（325列）
2. **データ出力**: PostgreSQL から統合データを CSV 形式で出力
3. **データ品質確認**: 欠損値サマリー、データ型確認

> **⚠️ 注意**: このシステムはデータ統合のみを担当します。予測モデルや分析手法については別途設計・実装します。

---

## 必要な環境

### ソフトウェア要件
| ソフトウェア | バージョン | 用途 |
|------------|----------|------|
| PostgreSQL | 12以上 | データベース |
| Python | 3.8以上 | データ処理 |
| pandas | 1.3以上 | データフレーム操作 |
| psycopg2 | 2.8以上 | PostgreSQL接続 |

### ハードウェア要件
| 項目 | 最小 | 推奨 |
|-----|------|------|
| RAM | 8GB | 16GB以上 |
| ストレージ空き容量 | 10GB | 20GB以上 |
| CPU | 2コア | 4コア以上 |

---

## データベースセットアップ

### 1. PostgreSQL 接続情報

```
ホスト: 127.0.0.1
ポート: 5432
データベース: pckeiba
ユーザー: postgres
パスワード: postgres123
```

### 2. 必要なデータテーブル

#### JRA-VAN テーブル（必須）
- `jvd_se` (成績) - ベーステーブル
- `jvd_ra` (レース基本情報)
- `jvd_ck` (レース成績・距離別成績)
- `jvd_um` (馬基本情報)
- `jvd_hr` (払戻金詳細)
- `jvd_h1` (払戻金情報)
- `jvd_h6` (三連単払戻)
- `jvd_dm` (データマイニング予想)
- `jvd_wc` (ウッドチップ調教)
- `jvd_hc` (芝・ダート調教)
- `jvd_ch` (調教師マスタ)
- `jvd_jg` (除外・取消情報)
- `jvd_sk` (血統情報)

#### JRDB テーブル（必須）
- `jrd_kyi` (競馬指数)
- `jrd_cyb` (調教分析)
- `jrd_sed` (レース詳細)
- `jrd_joa` (騎手・厩舎評価)
- `jrd_bac` (レース基本情報)

### 3. データインポート方法

**JRA-VAN データ**:
```bash
# JRA-VAN Data Lab からダウンロードしたCSVをインポート
psql -U postgres -d pckeiba -c "\COPY jvd_se FROM 'path/to/jvd_se.csv' CSV HEADER"
# 他のテーブルも同様
```

**JRDB データ**:
```bash
# JRDB からダウンロードしたデータをインポート
psql -U postgres -d pckeiba -c "\COPY jrd_kyi FROM 'path/to/jrd_kyi.csv' CSV HEADER"
# 他のテーブルも同様
```

### 4. データ確認

```sql
-- JRA-VAN データ件数確認（2016-2025年）
SELECT COUNT(*) FROM jvd_se WHERE kaisai_nen >= '2016' AND kaisai_nen <= '2025';
-- 期待値: 739,559 行

-- JRDB データ件数確認
SELECT COUNT(*) FROM jrd_kyi;
-- 期待値: 491,176 行
```

---

## ファイル構成

```
anonymous-keiba-ai-jra/
├── docs/
│   ├── PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv  # カラム定義ファイル
│   └── phase7b/
│       ├── DATABASE_SCHEMA_REFERENCE.md         # データベーススキーマ参考資料
│       ├── ERROR_HISTORY.md                     # 修正履歴
│       └── SYSTEM_SETUP_GUIDE.md                # 本ガイド
│
├── phase7/
│   ├── scripts/
│   │   └── phase7b_factor_roi/
│   │       └── create_merged_dataset_334cols.py  # データ統合スクリプト
│   │
│   └── results/
│       └── phase7b_roi/
│           └── jravan_jrdb_merged_334cols_2016_2025.csv  # 統合データ
```

---

## 実行手順

### Step 1: 環境確認

```powershell
# Python バージョン確認
python --version
# 期待: Python 3.8.0 以上

# 必要なパッケージのインストール
pip install pandas psycopg2-binary
```

### Step 2: カラム定義ファイルの配置

カラム定義ファイル `PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv` を以下に配置:
```
E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv
```

**カラム定義ファイルの形式**:
```csv
table_name,column_name,japanese_name
jvd_se,kaisai_nen,開催年
jvd_se,kaisai_tsukihi,開催月日
jrd_kyi,idm,IDM
...
```

### Step 3: データ統合スクリプト実行

```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi
python create_merged_dataset_334cols.py
```

**実行時間**: 約10-20分

**期待される出力**:
```
✅ 取得完了: 460,424 行 × 325 列
✅ 保存完了
ファイルパス: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
ファイルサイズ: 120.5 MB
```

### Step 4: データ統合完了

上記のステップで325列の統合データセットが生成されます。

**出力ファイル**:
```
E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
```

**次のステップ**: このデータを使用して予測モデルを構築します（別途実装）。

---

## スクリプト詳細

### `create_merged_dataset_334cols.py`

**機能**: JRA-VAN と JRDB データを統合

**入力**:
- PostgreSQL データベース (`pckeiba`)
- カラム定義CSV (`PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv`)

**出力**:
- `jravan_jrdb_merged_334cols_2016_2025.csv` (325列 × 約46万行)

**処理フロー**:
1. カラム定義CSVを読み込み
2. SQL を自動生成
3. PostgreSQL からデータ取得
4. CSV に保存

**主要な設定**:
```python
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

INPUT_CSV = r'E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv'
OUTPUT_DIR = r'E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi'
```

---

## トラブルシューティング

### よくある問題と対処法

#### 1. データが0行取得される

**症状**:
```
✅ 取得完了: 0 行 × 326 列
```

**原因**:
- WHERE句の期間指定が不適切
- JOIN条件の日付変換が間違っている

**対処法**:
```sql
-- WHERE句を確認
WHERE se.kaisai_nen >= '2016' AND se.kaisai_nen <= '2025'

-- JOIN条件を確認（JRDB）
(SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen
```

---

#### 2. `column does not exist` エラー

**症状**:
```
ERROR: column um.kaisai_nen does not exist
```

**原因**:
- テーブルの主キーが間違っている
- 存在しないカラムを参照している

**対処法**:
1. [DATABASE_SCHEMA_REFERENCE.md](DATABASE_SCHEMA_REFERENCE.md) でテーブル構造を確認
2. 主キーを修正

---

#### 3. `function to_char(character varying, unknown) does not exist`

**症状**:
```
function to_char(character varying, unknown) does not exist
```

**原因**:
- `character varying` 型に `TO_CHAR()` を使用している

**対処法**:
```sql
-- ❌ 誤り
TO_CHAR(se.kaisai_tsukihi, 'YYMMDD')

-- ✅ 正解
(SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi)
```

---

#### 4. メモリ不足エラー

**症状**:
```
MemoryError: Unable to allocate array
```

**原因**:
- データ量が大きすぎてメモリ不足

**対処法**:
```python
# チャンク読み込みに変更
for chunk in pd.read_sql(sql, conn, chunksize=10000):
    # 処理
    pass
```

---

#### 5. PostgreSQL 接続エラー

**症状**:
```
psycopg2.OperationalError: could not connect to server
```

**原因**:
- PostgreSQL が起動していない
- 接続情報が間違っている

**対処法**:
1. PostgreSQL サービスを起動
2. 接続情報を確認
```powershell
# PostgreSQL 起動確認
Get-Service postgresql*

# 接続テスト
psql -U postgres -d pckeiba -c "SELECT 1;"
```

---

## 付録

### A. データ型一覧

JRA-VAN と JRDB の全カラムは `character varying` 型です。

**注意点**:
- 数値比較ではなく文字列比較を使用
- 日付変換には `SUBSTRING()` と文字列結合 `||` を使用

---

### B. 日付変換例

```sql
-- JRA-VAN の kaisai_nen (YYYY) と kaisai_tsukihi (MMDD) を
-- JRDB の race_shikonen (YYMMDD) 形式に変換

-- 例: '2024' + '0307' → '240307'
SELECT 
    SUBSTRING(kaisai_nen, 3, 2) || kaisai_tsukihi AS race_shikonen_format
FROM jvd_se
WHERE kaisai_nen = '2024' AND kaisai_tsukihi = '0307';
-- 結果: '240307'
```

---

### C. 主キー確認SQL

```sql
-- 全JRA-VANテーブルの主キー確認
SELECT 
    tc.table_name,
    string_agg(kcu.column_name, ', ' ORDER BY kcu.ordinal_position) AS primary_keys
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'
  AND tc.table_name LIKE 'jvd_%'
GROUP BY tc.table_name
ORDER BY tc.table_name;
```

---

### D. データ件数確認SQL

```sql
-- 各テーブルのデータ件数確認
SELECT 'jvd_se' AS table_name, COUNT(*) AS count FROM jvd_se
UNION ALL
SELECT 'jrd_kyi', COUNT(*) FROM jrd_kyi
UNION ALL
SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb
UNION ALL
SELECT 'jrd_sed', COUNT(*) FROM jrd_sed
UNION ALL
SELECT 'jrd_joa', COUNT(*) FROM jrd_joa
UNION ALL
SELECT 'jrd_bac', COUNT(*) FROM jrd_bac;
```

---

## 連絡先・サポート

このシステムに関する質問や問題がある場合は、GitHubのIssueで報告してください。

**リポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra

---

## 更新履歴

- 2026-03-12: 初版作成（Phase 7-B システム構築ガイド）
