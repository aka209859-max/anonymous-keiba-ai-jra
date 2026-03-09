# Phase 1-C データ結合問題：完全解決のためのディープサーチ指示

## 📋 現状サマリー

### 発生した問題
1. **問題1**: `ValueError: invalid literal for int() with base 10: 'a'`
   - JRDB の `kaisai_nichime` に 'a', 'b', 'c' が含まれる（10日目、11日目、12日目）
   - 修正: 変換関数を実装（a→10, b→11, c→12）
   - ステータス: ✅ 解決済み

2. **問題2**: `KeyError: 'kaisai_kai'`
   - JRA-VAN データに `kaisai_kai` と `kaisai_nichime` 列が存在しない
   - 暫定対応: 結合キーを5つから3つに削減
   - ステータス: ⚠️ 暫定対応のみ

### 現在の暫定解決策
```python
# 結合キー: 3つ（年は事前フィルタ）
merge_keys = ['keibajo_code', 'race_bango', 'umaban']
```

### 懸念事項
- ✅ 年別フィルタで kaisai_nen/race_shikonen を統一済み
- ⚠️ kaisai_kai（開催回）と kaisai_nichime（開催日目）の情報が欠落
- ⚠️ 同一年・同一競馬場・同一レース番号・同一馬番で複数マッチの可能性
- ⚠️ データの一意性が保証されていない

---

## 🔍 ディープサーチの目的

### 主要な調査項目

#### 1. データの一意性検証
**目的**: 暫定解決策（3キー結合）が実際に機能するか確認

**調査内容**:
```sql
-- JRA-VAN データの一意性チェック
SELECT 
    kaisai_nen,
    keibajo_code,
    race_bango,
    umaban,
    COUNT(*) as record_count,
    COUNT(DISTINCT kaisai_tsukihi) as unique_dates
FROM jra_jravan_central_only
GROUP BY kaisai_nen, keibajo_code, race_bango, umaban
HAVING COUNT(*) > 1
ORDER BY record_count DESC
LIMIT 100;

-- JRDB データの一意性チェック
SELECT 
    race_shikonen,
    keibajo_code,
    race_bango,
    umaban,
    COUNT(*) as record_count,
    COUNT(DISTINCT kaisai_kai || '-' || kaisai_nichime) as unique_kai_nichime
FROM jrdb_48cols
GROUP BY race_shikonen, keibajo_code, race_bango, umaban
HAVING COUNT(*) > 1
ORDER BY record_count DESC
LIMIT 100;
```

**期待される結果**:
- 重複が0件 → 3キー結合で問題なし
- 重複が存在 → 追加のキーが必要

---

#### 2. kaisai_tsukihi と kaisai_kai/kaisai_nichime の対応関係分析

**目的**: JRA-VAN の `kaisai_tsukihi`（月日）から JRDB の `kaisai_kai`（開催回）と `kaisai_nichime`（開催日目）を推測可能か検証

**調査内容**:

**ステップ1**: 結合可能なレコードのサンプル抽出
```sql
-- 2016年の最初の100件で kaisai_tsukihi と kaisai_kai/kaisai_nichime の関係を確認
SELECT 
    jravan.kaisai_nen,
    jravan.kaisai_tsukihi,
    jravan.keibajo_code,
    jravan.race_bango,
    jravan.umaban,
    jrdb.kaisai_kai,
    jrdb.kaisai_nichime,
    jrdb.keibajo_code as jrdb_keibajo,
    jrdb.race_bango as jrdb_race_bango,
    jrdb.umaban as jrdb_umaban
FROM jra_jravan_central_only jravan
INNER JOIN jrdb_48cols jrdb
    ON jravan.keibajo_code = jrdb.keibajo_code
    AND jravan.race_bango = jrdb.race_bango
    AND jravan.umaban = jrdb.umaban
    AND jravan.kaisai_nen = (2000 + jrdb.race_shikonen)
WHERE jravan.kaisai_nen = 2016
ORDER BY jravan.kaisai_tsukihi, jravan.keibajo_code, jravan.race_bango, jravan.umaban
LIMIT 100;
```

**ステップ2**: kaisai_tsukihi のパターン分析
```sql
-- kaisai_tsukihi の値の分布
SELECT 
    LEFT(LPAD(kaisai_tsukihi::TEXT, 4, '0'), 2) as month,
    COUNT(*) as record_count,
    COUNT(DISTINCT kaisai_tsukihi) as unique_dates
FROM jra_jravan_central_only
WHERE kaisai_nen = 2016
GROUP BY month
ORDER BY month;
```

**期待される結果**:
- kaisai_tsukihi と kaisai_kai/kaisai_nichime の間に規則的な対応関係が存在
- 対応関係が不規則 → kaisai_tsukihi からの推測は困難

---

#### 3. JRA-VAN データソースの再確認

**目的**: JRA-VAN の元データに kaisai_kai/kaisai_nichime の情報が存在するか確認

**調査内容**:

**Phase 1-A 抽出スクリプトの確認**:
```bash
# scripts/phase1a_simple.py の SQL クエリを確認
cat scripts/phase1a_simple.py | grep -A 50 "SELECT"
```

**元データベースのテーブル構造確認**:
```sql
-- JRA-VAN テーブルのカラム一覧
SELECT 
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name IN ('n_uma_race', 'n_race', 'n_uma')
ORDER BY table_name, ordinal_position;
```

**可能性の検証**:
- ✅ kaisai_kai/kaisai_nichime が別テーブルに存在 → Phase 1-A を修正
- ❌ 情報が存在しない → 3キー結合を継続

---

#### 4. 血統登録番号による結合精度の検証

**目的**: `ketto_toroku_bango`（血統登録番号）を追加キーとして使用できるか確認

**調査内容**:
```sql
-- 血統登録番号の一意性チェック（JRA-VAN）
SELECT 
    kaisai_nen,
    keibajo_code,
    race_bango,
    umaban,
    ketto_toroku_bango,
    COUNT(*) as record_count
FROM jra_jravan_central_only
WHERE ketto_toroku_bango IS NOT NULL
GROUP BY kaisai_nen, keibajo_code, race_bango, umaban, ketto_toroku_bango
HAVING COUNT(*) > 1
LIMIT 100;

-- 血統登録番号の一致率確認
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT ketto_toroku_bango) as unique_ketto,
    COUNT(CASE WHEN ketto_toroku_bango IS NULL THEN 1 END) as null_count
FROM jra_jravan_central_only;

-- JRDB 側も同様に確認
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT ketto_toroku_bango) as unique_ketto,
    COUNT(CASE WHEN ketto_toroku_bango IS NULL THEN 1 END) as null_count
FROM jrdb_48cols;
```

**期待される結果**:
- 血統登録番号が高頻度で一致 → 追加キーとして有効
- 一致率が低い → 現行の3キー結合を継続

---

#### 5. 実データでの結合テスト（小規模）

**目的**: 3キー結合が実際にどのような結果を生むか検証

**調査内容**:
```python
import pandas as pd

# 2016年の小規模テスト
df_jravan = pd.read_csv('data/raw/jra_jravan_central_only.csv', encoding='utf-8-sig')
df_jrdb = pd.read_csv('data/raw/jrdb_48cols.csv', encoding='utf-8-sig')

# 2016年のみ抽出
df_jravan_2016 = df_jravan[df_jravan['kaisai_nen'] == 2016].copy()
df_jrdb_2016 = df_jrdb[df_jrdb['race_shikonen'] == 16].copy()

# キー準備
df_jravan_2016['keibajo_code'] = df_jravan_2016['keibajo_code'].astype(str).str.zfill(2)
df_jrdb_2016['keibajo_code'] = df_jrdb_2016['keibajo_code'].astype(str).str.zfill(2)

# 3キー結合
merge_keys = ['keibajo_code', 'race_bango', 'umaban']
df_merged = pd.merge(
    df_jrdb_2016,
    df_jravan_2016,
    on=merge_keys,
    how='inner',
    suffixes=('_jrdb', '_jravan')
)

# 統計出力
print(f"JRA-VAN 2016年: {len(df_jravan_2016):,} 件")
print(f"JRDB 2016年: {len(df_jrdb_2016):,} 件")
print(f"結合後: {len(df_merged):,} 件")
print(f"結合率（対JRDB）: {len(df_merged)/len(df_jrdb_2016)*100:.1f}%")

# 重複確認
duplicates = df_merged.groupby(merge_keys).size()
duplicates_count = (duplicates > 1).sum()
print(f"重複キー数: {duplicates_count}")

if duplicates_count > 0:
    print("\n重複例（最初の5件）:")
    print(duplicates[duplicates > 1].head())
    
# 血統登録番号一致確認
if 'ketto_toroku_bango_jrdb' in df_merged.columns and 'ketto_toroku_bango_jravan' in df_merged.columns:
    match_count = (df_merged['ketto_toroku_bango_jrdb'] == df_merged['ketto_toroku_bango_jravan']).sum()
    print(f"\n血統登録番号一致: {match_count:,} 件 ({match_count/len(df_merged)*100:.1f}%)")
```

**期待される結果**:
- 結合後レコード ≈ 48,000-50,000件（期待値）
- 重複キー数 = 0（理想）
- 血統登録番号一致率 >90%

---

## 📊 調査結果の判定基準

### シナリオ A: 3キー結合で問題なし ✅
**条件**:
- 重複キー数 = 0 または ごく少数（<100件）
- 血統登録番号一致率 >90%
- 結合後レコード数が期待範囲内（約478,000件）

**対応**: 現行の3キー結合を継続

---

### シナリオ B: kaisai_tsukihi から kaisai_kai/kaisai_nichime を推測可能 🔄
**条件**:
- kaisai_tsukihi と kaisai_kai/kaisai_nichime の間に規則的な対応関係
- 推測ロジックを実装可能

**対応**: JRA-VAN データに kaisai_kai/kaisai_nichime を補完してから5キー結合

---

### シナリオ C: JRA-VAN 元データに情報が存在 🔧
**条件**:
- 元データベースに kaisai_kai/kaisai_nichime 相当の列が存在

**対応**: Phase 1-A を修正して再抽出

---

### シナリオ D: 血統登録番号を追加キーとして使用 🐴
**条件**:
- 血統登録番号の欠損が少ない（<5%）
- 血統登録番号を含めた4キー結合で重複が解消

**対応**: 結合キーを4つに変更
```python
merge_keys = ['keibajo_code', 'race_bango', 'umaban', 'ketto_toroku_bango']
```

---

### シナリオ E: kaisai_tsukihi を追加キーとして使用 📅
**条件**:
- JRDB に kaisai_tsukihi 相当の情報が存在（未確認）
- または kaisai_kai/kaisai_nichime から逆算可能

**対応**: 4キー結合を実装
```python
merge_keys = ['keibajo_code', 'race_bango', 'umaban', 'kaisai_tsukihi']
```

---

## 🎯 推奨される調査順序

### 優先度 HIGH（必須）
1. ✅ **データの一意性検証**（調査項目1）
   - 所要時間: 5-10分
   - 3キー結合の妥当性を確認

2. ✅ **実データでの結合テスト**（調査項目5）
   - 所要時間: 5-10分
   - 実際の結合結果を確認

### 優先度 MEDIUM（重要）
3. 🔍 **kaisai_tsukihi と kaisai_kai/kaisai_nichime の対応関係分析**（調査項目2）
   - 所要時間: 15-20分
   - 推測可能性を確認

4. 🔍 **血統登録番号による結合精度の検証**（調査項目4）
   - 所要時間: 10-15分
   - 代替キーの可能性を確認

### 優先度 LOW（参考）
5. 📚 **JRA-VAN データソースの再確認**（調査項目3）
   - 所要時間: 20-30分
   - 元データに情報が存在するか確認

---

## 📝 調査実行スクリプト

### 調査1: データの一意性検証
```python
# scripts/phase1c_analysis_uniqueness.py
import pandas as pd
import sys

def check_uniqueness(file_path, year_col, year_val, keys, name):
    """データの一意性をチェック"""
    print(f"\n{'='*70}")
    print(f"{name} の一意性チェック")
    print(f"{'='*70}")
    
    df = pd.read_csv(file_path, encoding='utf-8-sig')
    
    # 指定年でフィルタ
    df_year = df[df[year_col] == year_val].copy()
    print(f"総レコード数: {len(df_year):,} 件")
    
    # 重複チェック
    duplicates = df_year.groupby(keys).size()
    dup_count = (duplicates > 1).sum()
    dup_records = duplicates[duplicates > 1]
    
    print(f"\nキー: {keys}")
    print(f"ユニークなキー組み合わせ数: {len(duplicates):,}")
    print(f"重複キー数: {dup_count}")
    
    if dup_count > 0:
        print(f"\n⚠️ 重複が検出されました！")
        print(f"重複例（最初の10件）:")
        print(dup_records.head(10))
        
        # 重複の詳細を表示
        first_dup_keys = dup_records.index[0]
        mask = True
        for i, key in enumerate(keys):
            mask &= (df_year[key] == first_dup_keys[i])
        print(f"\n重複例の詳細（最初のケース）:")
        print(df_year[mask])
    else:
        print(f"✅ 重複なし - 3キー結合で問題ありません")
    
    return dup_count

# 実行
jravan_dups = check_uniqueness(
    'data/raw/jra_jravan_central_only.csv',
    'kaisai_nen',
    2016,
    ['keibajo_code', 'race_bango', 'umaban'],
    'JRA-VAN 2016年'
)

jrdb_dups = check_uniqueness(
    'data/raw/jrdb_48cols.csv',
    'race_shikonen',
    16,
    ['keibajo_code', 'race_bango', 'umaban'],
    'JRDB 2016年'
)

# 結論
print(f"\n{'='*70}")
print(f"結論")
print(f"{'='*70}")
if jravan_dups == 0 and jrdb_dups == 0:
    print("✅ 3キー結合で問題なし")
else:
    print("⚠️ 追加のキーが必要です")
```

### 調査5: 実データでの結合テスト
```python
# scripts/phase1c_analysis_merge_test.py
import pandas as pd

print("Phase 1-C 結合テスト（2016年）")
print("="*70)

# データ読み込み
df_jravan = pd.read_csv('data/raw/jra_jravan_central_only.csv', encoding='utf-8-sig')
df_jrdb = pd.read_csv('data/raw/jrdb_48cols.csv', encoding='utf-8-sig')

# 2016年抽出
df_jravan_2016 = df_jravan[df_jravan['kaisai_nen'] == 2016].copy()
df_jrdb_2016 = df_jrdb[df_jrdb['race_shikonen'] == 16].copy()

print(f"JRA-VAN 2016年: {len(df_jravan_2016):,} 件")
print(f"JRDB 2016年: {len(df_jrdb_2016):,} 件")

# キー準備
df_jravan_2016['keibajo_code'] = df_jravan_2016['keibajo_code'].astype(str).str.zfill(2)
df_jrdb_2016['keibajo_code'] = df_jrdb_2016['keibajo_code'].astype(str).str.zfill(2)

for col in ['race_bango', 'umaban']:
    df_jravan_2016[col] = pd.to_numeric(df_jravan_2016[col], errors='coerce')
    df_jrdb_2016[col] = pd.to_numeric(df_jrdb_2016[col], errors='coerce')

# 3キー結合
merge_keys = ['keibajo_code', 'race_bango', 'umaban']
df_merged = pd.merge(
    df_jrdb_2016,
    df_jravan_2016,
    on=merge_keys,
    how='inner',
    suffixes=('_jrdb', '_jravan')
)

print(f"\n結合後: {len(df_merged):,} 件")
print(f"結合率（対JRDB）: {len(df_merged)/len(df_jrdb_2016)*100:.1f}%")

# 重複確認
duplicates = df_merged.groupby(merge_keys).size()
dup_count = (duplicates > 1).sum()
print(f"\n重複キー数: {dup_count}")

if dup_count > 0:
    print(f"⚠️ 警告: 重複が検出されました")
    print(f"重複例:")
    print(duplicates[duplicates > 1].head())
else:
    print(f"✅ 重複なし")

# 血統登録番号一致確認
if 'ketto_toroku_bango_jrdb' in df_merged.columns and 'ketto_toroku_bango_jravan' in df_merged.columns:
    match_count = (df_merged['ketto_toroku_bango_jrdb'] == df_merged['ketto_toroku_bango_jravan']).sum()
    print(f"\n血統登録番号一致: {match_count:,} 件 ({match_count/len(df_merged)*100:.1f}%)")

print("\n" + "="*70)
print("✅ テスト完了")
```

---

## 📤 調査結果の報告フォーマット

```
## Phase 1-C ディープサーチ結果

### 調査1: データの一意性検証
- JRA-VAN 重複キー数: X件
- JRDB 重複キー数: Y件
- 結論: [問題なし / 追加キー必要]

### 調査5: 実データでの結合テスト（2016年）
- 入力JRA-VAN: XX,XXX件
- 入力JRDB: XX,XXX件
- 結合後: XX,XXX件
- 結合率: XX.X%
- 重複キー数: X件
- 血統登録番号一致率: XX.X%
- 結論: [問題なし / 調整必要]

### 推奨される対応
- シナリオ [A/B/C/D/E]
- 理由: ...
- 実装内容: ...
```

---

作成日: 2026-02-21  
バージョン: 1.0  
作成者: GenSpark AI Developer
