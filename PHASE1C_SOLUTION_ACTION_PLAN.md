# Phase 1-C 完全解決アクションプラン

## 📊 ディープサーチ結果サマリー

### 🔍 調査結果
| 調査項目 | 結果 | 判定 |
|---------|------|------|
| **一意性検証** | JRA-VAN/JRDB両方で重複キー多数 | ❌ 3キー結合不可 |
| **結合テスト** | 500,000件超（期待値の10倍以上） | ❌ デカルト積発生 |
| **血統番号一致率** | 10%未満（期待値>90%） | ❌ データ汚染 |

### 🎯 数学的証明
- **3キー結合の破綻**: $(L, R, H)$ タプルは年間複数回出現 → $N \times M$ の直積発生
- **例**: 東京競馬場・1R・1番が年間45回 → $45 \times 45 = 2,025$行（正解は45行のみ）
- **結論**: 3キー結合は**即座に放棄**すべき

---

## ✅ 最適解: シナリオ C（上流スキーマ修正）

### 根本原因
Phase 1-A の抽出SQL で `kaisai_kai`（開催回）と `kaisai_nichime`（開催日目）を**選択し忘れた**

### 解決策
JRA-VAN の元データベース（`n_race` テーブル）から不足している2列を追加抽出

---

## 🚀 実行手順

### ステップ 1: 元データベースのスキーマ確認（Windows）

```powershell
cd E:\anonymous-keiba-ai-JRA

# PostgreSQL に接続して n_race テーブルの構造を確認
psql -h 127.0.0.1 -p 5432 -U postgres -d jra_keiba -c "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'n_race' ORDER BY ordinal_position;"
```

**期待される出力**:
```
column_name          | data_type
---------------------+-----------
kaisai_nen           | integer
kaisai_tsukihi       | character varying
keibajo_code         | character varying
kaisai_kai           | integer          ← これを確認！
kaisai_nichime       | character varying ← これを確認！
race_bango           | integer
...
```

**確認事項**:
- ✅ `kaisai_kai` 列が存在するか
- ✅ `kaisai_nichime` 列が存在するか（または類似の列名）
- ✅ データ型を確認（integer または character varying）

---

### ステップ 2: Phase 1-A スクリプトの修正

**現在のスクリプト**: `scripts/phase1a_simple.py`

**修正箇所**:
```python
# 修正前（現在の SELECT 句）
SELECT
    r.kaisai_nen,
    r.kaisai_tsukihi,
    r.keibajo_code,
    r.race_bango,
    -- kaisai_kai と kaisai_nichime が欠落している ❌

# 修正後（追加する）
SELECT
    r.kaisai_nen,
    r.kaisai_tsukihi,
    r.keibajo_code,
    r.kaisai_kai,           -- 追加 ✅
    r.kaisai_nichime,       -- 追加 ✅
    r.race_bango,
```

**詳細な修正手順は後述のセクションを参照**

---

### ステップ 3: Phase 1-A の再実行

```powershell
cd E:\anonymous-keiba-ai-JRA

# 既存の出力ファイルをバックアップ
Move-Item data\raw\jra_jravan_central_only.csv data\raw\jra_jravan_central_only_OLD.csv

# Phase 1-A を再実行（修正版）
python scripts\phase1a_simple.py
```

**期待される結果**:
- 新しい `jra_jravan_central_only.csv` が生成される
- 列数が **31列 → 33列** に増加（`kaisai_kai` と `kaisai_nichime` が追加）
- 行数は約500,000件で変わらず

---

### ステップ 4: Phase 1-C の修正と実行

**修正箇所**: `scripts/phase1c_merge_final.py`

```python
# 結合キーを5つに変更（修正前: 3つ）
merge_keys = [
    'keibajo_code',
    'kaisai_kai',        # 追加 ✅
    'kaisai_nichime',    # 追加 ✅
    'race_bango',
    'umaban'
]
```

**実行**:
```powershell
python scripts\phase1c_merge_final.py
```

**期待される結果**:
- 結合後レコード数: **約480,000件**（期待値通り）
- 血統登録番号一致率: **>95%**
- 重複キー数: **0件**
- 結合率: **約99%**（正常値）

---

## 📝 Phase 1-A 修正の詳細

### 現在のスクリプト構造

`scripts/phase1a_simple.py` の主要な SQL クエリ部分:

```python
def extract_year_data(conn, year):
    """指定年のデータを抽出"""
    
    # 現在の SQL（簡略版）
    query = """
        SELECT
            r.kaisai_nen,
            r.kaisai_tsukihi,
            r.keibajo_code,
            r.race_bango,
            ur.umaban,
            ur.ketto_toroku_bango,
            -- ... その他の列 ...
        FROM n_race r
        INNER JOIN n_uma_race ur ON ...
        WHERE r.kaisai_nen = %(year)s
        AND r.keibajo_code IN ('01','02',...,'10')
    """
```

### 修正版

```python
def extract_year_data(conn, year):
    """指定年のデータを抽出（kaisai_kai, kaisai_nichime 追加版）"""
    
    # 修正後の SQL
    query = """
        SELECT
            r.kaisai_nen,
            r.kaisai_tsukihi,
            r.keibajo_code,
            r.kaisai_kai,           -- ★ 追加
            r.kaisai_nichime,       -- ★ 追加
            r.race_bango,
            ur.umaban,
            ur.ketto_toroku_bango,
            -- ... その他の列（変更なし）...
        FROM n_race r
        INNER JOIN n_uma_race ur ON ...
        WHERE r.kaisai_nen = %(year)s
        AND r.keibajo_code IN ('01','02',...,'10')
    """
```

**重要な注意事項**:
1. **列名の確認**: PostgreSQL の `n_race` テーブルで実際の列名を確認してください
   - `kaisai_kai` が `kaisai_count` や `holding_number` という名前の可能性
   - `kaisai_nichime` が `kaisai_day` や `day_number` という名前の可能性

2. **データ型の確認**: ステップ1で確認したデータ型に応じて処理を調整
   - integer の場合: そのまま使用
   - character varying の場合: JRDB の 'a'/'b'/'c' 変換ロジックが必要か確認

---

## 📊 検証手順

### Phase 1-A 再抽出後の検証

```powershell
# 列数確認
python -c "import pandas as pd; df = pd.read_csv('data/raw/jra_jravan_central_only.csv', nrows=1, encoding='utf-8-sig'); print(f'列数: {len(df.columns)}'); print('列名:', list(df.columns))"
```

**期待される出力**:
```
列数: 33
列名: ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', ...]
```

**確認事項**:
- ✅ `kaisai_kai` 列が存在する
- ✅ `kaisai_nichime` 列が存在する
- ✅ サンプルデータで値が入っている（NULL でない）

```powershell
# サンプルデータ確認
python -c "import pandas as pd; df = pd.read_csv('data/raw/jra_jravan_central_only.csv', nrows=10, encoding='utf-8-sig'); print(df[['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']].to_string())"
```

### Phase 1-C 実行後の検証

**検証スクリプト実行**:
```powershell
# 一意性検証（修正後）
python scripts\phase1c_analysis_uniqueness.py

# 結合テスト（修正後）
python scripts\phase1c_analysis_merge_test.py
```

**期待される結果**:
```
======================================================================
JRA-VAN 2016年 の一意性チェック
======================================================================
総レコード数: 50,076 件

キー: ['keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']
ユニークなキー組み合わせ数: 50,076
重複キー数: 0
✅ 重複なし - 5キー結合で問題ありません

======================================================================
結合結果
======================================================================
結合後レコード数: 48,234 件
結合率（対JRDB）: 96.3%
重複キー数: 0
血統登録番号一致率: 99.8%
✅ 5キー結合は正常に機能しています
```

---

## 🎯 代替案: シナリオ D（血統登録番号を追加）

**上流修正が困難な場合のフェイルオーバー戦略**

### 前提条件
- `ketto_toroku_bango` の欠損率が <1%
- 10桁形式への正規化が可能

### 実装

```python
# 4キー結合（3キー + 血統登録番号）
merge_keys = [
    'keibajo_code',
    'race_bango',
    'umaban',
    'ketto_toroku_bango'  # 追加
]

# 前処理: 10桁に正規化
df_jravan['ketto_toroku_bango'] = df_jravan['ketto_toroku_bango'].astype(str).str.zfill(10)
df_jrdb['ketto_toroku_bango'] = df_jrdb['ketto_toroku_bango'].astype(str).str.zfill(10)

# NULL値チェック
null_count_jravan = df_jravan['ketto_toroku_bango'].isna().sum()
null_count_jrdb = df_jrdb['ketto_toroku_bango'].isna().sum()

if null_count_jravan > len(df_jravan) * 0.01:
    raise ValueError(f"JRA-VAN の血統登録番号欠損率が1%を超えています: {null_count_jravan}")
```

**注意**: この方法は**暫定対応**であり、恒久的な解決策は**シナリオ C（上流修正）**です。

---

## 📤 実行後の報告フォーマット

```
## Phase 1-C 完全解決実行結果

### ステップ1: n_race テーブル構造確認
- kaisai_kai 列: [存在する/存在しない]
- kaisai_nichime 列: [存在する/存在しない]
- データ型: [integer/character varying/その他]

### ステップ2: Phase 1-A 再実行
- 実行時間: X分Y秒
- 出力ファイルサイズ: XX MB
- 列数: XX列（期待値: 33列）
- 行数: XXX,XXX件（期待値: 約500,000件）

### ステップ3: Phase 1-C 実行
- 実行時間: X分Y秒
- 出力ファイルサイズ: XXX MB（期待値: 150-180 MB）
- 結合後レコード数: XXX,XXX件（期待値: 約478,000件）
- 重複キー数: X件（期待値: 0件）
- 血統登録番号一致率: XX.X%（期待値: >95%）

### 結論
- [成功/失敗]
- 採用したシナリオ: [C/D]
- 備考: ...
```

---

## 🔄 トラブルシューティング

### 問題1: n_race テーブルに kaisai_kai/kaisai_nichime が存在しない

**対応**: 他のテーブルを調査
```sql
-- 全テーブルから kaisai_kai を検索
SELECT table_name, column_name 
FROM information_schema.columns 
WHERE column_name LIKE '%kaisai%' OR column_name LIKE '%kai%'
ORDER BY table_name, ordinal_position;
```

### 問題2: 列名が異なる

**対応**: スクリプトで列名をマッピング
```python
# 例: holding_number → kaisai_kai に変換
df_jravan = df_jravan.rename(columns={'holding_number': 'kaisai_kai'})
```

### 問題3: データ型が異なる

**対応**: 型変換ロジックを追加
```python
# character varying から integer への変換
df_jravan['kaisai_kai'] = pd.to_numeric(df_jravan['kaisai_kai'], errors='coerce')
df_jravan = df_jravan.dropna(subset=['kaisai_kai'])
df_jravan['kaisai_kai'] = df_jravan['kaisai_kai'].astype('int64')
```

---

## 📚 参考資料

- **ディープサーチ解析**: `/home/user/uploaded_files/Phase 1-C データ結合アーキテクチャ：JRA-VANとJRDB.txt`
- **現行スクリプト**: `scripts/phase1a_simple.py`, `scripts/phase1c_merge_final.py`
- **検証スクリプト**: `scripts/phase1c_analysis_uniqueness.py`, `scripts/phase1c_analysis_merge_test.py`

---

作成日: 2026-02-21  
バージョン: 1.0  
ステータス: 即座実行可能  
優先度: **CRITICAL**
