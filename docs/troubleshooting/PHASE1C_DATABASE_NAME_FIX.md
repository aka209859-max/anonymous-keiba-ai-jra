# Phase 1-C データベース名エラー修正ガイド

## 📋 問題の概要

**エラーメッセージ:**
```
connection to server at "127.0.0.1", port 5432 failed: FATAL: database "jra_keiba" does not exist
```

**根本原因:**
- スクリプトがデフォルトで `jra_keiba` というDB名を探していた
- 実際のデータベース名は **`pckeiba`** だった
- `config/db_config.yaml` が存在しなかった

---

## ✅ 解決済み事項

### 1. データベース名の特定
画像から判明した実際のDB構成:
- **データベース名:** `pckeiba`（JRA-VAN の PC版ソフトのデフォルト名）
- **接続先:** `127.0.0.1:5432`
- **ユーザー:** `postgres`

### 2. スクリプト修正内容（commit: 5bd27e8）

#### `scripts/check_database_schema.py` の改善
```python
def load_config():
    """設定ファイルから接続情報を読み込み"""
    # 複数の設定ファイルパスを試行
    config_paths = [
        Path('config/config.yml'),
        Path('db_config_corrected.yaml'),  # ★ pckeiba を使用
        Path('db_config.yaml'),
    ]
    
    for config_file in config_paths:
        if config_file.exists():
            print(f"✅ 設定ファイル使用: {config_file}")
            with open(config_file, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                # jravan セクションから接続情報を取得
                if 'jravan' in config:
                    return config['jravan']
                elif 'database' in config:
                    return config['database']
    
    # 設定ファイルが見つからない場合
    print(f"❌ エラー: 設定ファイルが見つかりません")
    return {
        'host': '127.0.0.1',
        'port': 5432,
        'database': 'pckeiba',  # ★ デフォルトを pckeiba に変更
        'user': 'postgres',
        'password': 'postgres123'
    }
```

**変更点:**
- ✅ デフォルトDB名を `pckeiba` に変更
- ✅ 既存の `db_config_corrected.yaml` を自動検出
- ✅ 複数の設定ファイルパスをフォールバック

---

## 🚀 実行手順（Windows）

### ステップ1: コードを最新化
```powershell
cd E:\anonymous-keiba-ai-JRA
git pull origin genspark_ai_developer
```

### ステップ2: データベース接続確認
```powershell
# スクリプトを実行
python scripts\check_database_schema.py
```

**期待される出力:**
```
======================================================================
JRA-VAN データベース スキーマ確認
======================================================================
✅ 設定ファイル使用: db_config_corrected.yaml

接続情報:
  Host: 127.0.0.1
  Port: 5432
  Database: pckeiba
  User: postgres

データベースに接続中...
✅ 接続成功

======================================================================
テーブル: n_race
======================================================================

総列数: 45

列名                           データ型             最大長      NULL許可
----------------------------------------------------------------------
...
```

### ステップ3: 結果の報告

以下の情報を確認してください:

#### A. テーブル `n_race` に必要な列が存在する場合

**確認項目:**
- ✅ `kaisai_kai` 列が存在するか？
- ✅ `kaisai_nichime` 列が存在するか？（または類似名: `day_number`, `nichime` など）

**サンプルデータ例:**
```
kaisai_nen | kaisai_tsukihi | keibajo_code | kaisai_kai | kaisai_nichime | race_bango
-----------+----------------+--------------+------------+----------------+------------
2016       | 105            | 06           | 1          | 1              | 1
2016       | 105            | 06           | 1          | 1              | 2
```

**→ このパターンなら Scenario C を実行可能！**

#### B. 必要な列が存在しない場合

**出力例:**
```
❌ kaisai_kai と kaisai_nichime が見つかりません

他のテーブルを確認します...

--- n_uma_race テーブルを確認 ---
...
```

**→ この場合は Scenario D（血統登録番号キー）へフォールバック**

---

## 📊 次のステップ決定フローチャート

```
スクリプト実行
    ↓
接続成功？
    ├─ YES → n_race テーブル確認
    │          ↓
    │       kaisai_kai/kaisai_nichime 存在？
    │          ├─ YES → 【Scenario C 実行】
    │          │         Phase 1-A スクリプト修正
    │          │         ↓
    │          │       Phase 1-C 5キー結合
    │          │
    │          └─ NO  → 【Scenario D 実行】
    │                    血統登録番号を4番目のキーに追加
    │
    └─ NO  → エラー詳細を報告
              - データベースが起動しているか？
              - パスワードが正しいか？
```

---

## 🎯 Scenario C 実行ガイド（推奨）

### 前提条件
✅ `n_race` テーブルに `kaisai_kai` と `kaisai_nichime` が存在すること

### 1. Phase 1-A スクリプト修正

**ファイル:** `scripts/phase1a_simple.py`

**修正箇所:** SQL の SELECT 句に以下の2列を追加

```python
sql = f"""
WITH target_races AS (
    SELECT 
        ra.kaisai_nen,
        ra.kaisai_tsukihi,
        ra.keibajo_code,
        ra.kaisai_kai,        -- ★ 追加
        ra.kaisai_nichime,    -- ★ 追加
        ra.race_bango,
        ...
```

### 2. Phase 1-A 再実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase1a_simple.py
```

**期待出力:**
- ファイル: `data\raw\jra_jravan_central_only.csv`
- 行数: 約500,000行
- **列数: 33列**（従来31列 → +2列）
- サイズ: 約100MB
- 実行時間: 5-10分

### 3. Phase 1-C マージスクリプト修正

**ファイル:** `scripts/phase1c_merge_final.py`

**修正箇所:** `MERGE_KEYS` を5キーに変更

```python
# 結合キー定義（5キー）
MERGE_KEYS = [
    'keibajo_code',      # 競馬場コード
    'kaisai_kai',        # 開催回（第1回、第2回...）
    'kaisai_nichime',    # 開催日目（1日目、2日目...）
    'race_bango',        # レース番号
    'umaban'             # 馬番
]
```

### 4. Phase 1-C 実行

```powershell
python scripts\phase1c_merge_final.py
```

**期待出力:**
- ファイル: `data\raw\jravan_jrdb_merged.csv`
- 行数: 約478,000行
- 列数: 約83列
- サイズ: 150-180MB
- 血統登録番号一致率: >90%
- 重複キー数: **0件**
- 実行時間: 5-10分

---

## 🔧 Scenario D 実行ガイド（フォールバック）

### 前提条件
✅ `kaisai_kai`/`kaisai_nichime` が n_race に存在しない
✅ 両データセットの `ketto_toroku_bango`（血統登録番号）の欠損率 < 1%

### 1. 血統登録番号の欠損率確認

```python
import pandas as pd

# JRA-VAN データ確認
df_jravan = pd.read_csv('data/raw/jra_jravan_central_only.csv')
missing_rate_jravan = df_jravan['ketto_toroku_bango'].isna().mean() * 100

# JRDB データ確認
df_jrdb = pd.read_csv('data/raw/jrdb_48cols.csv')
missing_rate_jrdb = df_jrdb['ketto_toroku_bango'].isna().mean() * 100

print(f"JRA-VAN 欠損率: {missing_rate_jravan:.2f}%")
print(f"JRDB 欠損率: {missing_rate_jrdb:.2f}%")

# 許容条件: 両方とも < 1%
if missing_rate_jravan < 1.0 and missing_rate_jrdb < 1.0:
    print("✅ 血統登録番号をキーとして使用可能")
else:
    print("❌ 欠損率が高すぎる - 別の方法が必要")
```

### 2. Phase 1-C マージスクリプト修正

**修正箇所:** 4キー結合に変更

```python
# 結合キー定義（4キー）
MERGE_KEYS = [
    'keibajo_code',          # 競馬場コード
    'race_bango',            # レース番号
    'umaban',                # 馬番
    'ketto_toroku_bango'     # 血統登録番号（10桁統一）
]

# データ準備時に血統登録番号を10桁に正規化
def normalize_ketto_toroku_bango(df):
    """血統登録番号を10桁に0埋め"""
    df['ketto_toroku_bango'] = (
        df['ketto_toroku_bango']
        .astype(str)
        .str.strip()
        .str.zfill(10)
    )
    # 欠損値を除外
    df = df[df['ketto_toroku_bango'] != '0000000000'].copy()
    return df

# JRA-VAN データ
df_jravan = normalize_ketto_toroku_bango(df_jravan)

# JRDB データ
df_jrdb = normalize_ketto_toroku_bango(df_jrdb)
```

### 3. 実行と検証

```powershell
python scripts\phase1c_merge_final.py
```

**警告条件:**
- 重複キー数が 100件以上 → データ品質に問題あり
- 血統登録番号一致率 < 85% → 結合精度不足

---

## 📝 報告テンプレート

スクリプト実行後、以下の情報を報告してください:

```markdown
### Phase 1-C データベーススキーマ確認結果

**1. 接続状況**
- [ ] ✅ 接続成功
- [ ] ❌ 接続失敗（エラーメッセージ: ________________）

**2. n_race テーブル情報**
- 総列数: ______ 列
- kaisai_kai 存在: [ ] Yes / [ ] No
- kaisai_nichime 存在: [ ] Yes / [ ] No
- 代替列名（あれば）: ________________

**3. サンプルデータ（最初の3行）**
```
kaisai_nen | kaisai_tsukihi | keibajo_code | kaisai_kai | kaisai_nichime | race_bango
-----------+----------------+--------------+------------+----------------+------------
...
...
...
```

**4. 決定事項**
- [ ] Scenario C を実行（kaisai_kai/kaisai_nichime を追加）
- [ ] Scenario D を実行（血統登録番号キーを使用）
- [ ] 追加調査が必要

**5. エラー・注意事項**
_________________________________________________
```

---

## 🔗 参考リンク

- **修正スクリプト:** https://github.com/aka209859-max/anonymous-keiba-ai-jra/blob/genspark_ai_developer/scripts/check_database_schema.py
- **Scenario C 詳細:** https://github.com/aka209859-max/anonymous-keiba-ai-jra/blob/genspark_ai_developer/PHASE1C_SOLUTION_ACTION_PLAN.md
- **PR コメント:** https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1#issuecomment-3937529519

---

## 💡 重要な補足

### データベース名について

JRA-VAN の PC版ソフトウェア（Data Lab.）は、デフォルトで以下のDB名を使用します:

- **`pckeiba`** ← 画像で確認されたDB名（一般的）
- `jravan` 
- `jra_keiba` 
- カスタム名

プロジェクト内の設定ファイルで使用されているDB名:
- `db_config.yaml` → `jra_keiba`（誤り）
- `db_config_corrected.yaml` → **`pckeiba`**（正しい）

---

## ✅ Git 履歴

| Commit | 概要 | リンク |
|--------|------|--------|
| `5bd27e8` | データベース名を pckeiba に修正、config読み込み改善 | [GitHub](https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/5bd27e8) |
| `bf133ee` | check_database_schema.py 初版作成 | [GitHub](https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/bf133ee) |

---

## 🚨 トラブルシューティング

### Q1. `connection refused` エラーが出る
**A:** PostgreSQL サービスが起動していない可能性があります。

```powershell
# Windows サービス確認
Get-Service postgresql*

# 起動
Start-Service postgresql-x64-14  # バージョン番号は環境に合わせる
```

### Q2. `password authentication failed` エラー
**A:** パスワードが間違っています。

```powershell
# pgAdmin から接続して確認
# または pg_hba.conf を trust に変更（開発環境のみ）
```

### Q3. n_race テーブルが見つからない
**A:** JRA-VAN Data Lab. でデータベースセットアップが完了していない可能性があります。

```sql
-- PostgreSQL で確認
\dt  -- テーブル一覧
SELECT COUNT(*) FROM n_race;  -- データ件数
```

---

**次のアクション:** まず `python scripts\check_database_schema.py` を実行し、結果を報告してください！
