# Phase 7-B 修正履歴

## 概要

このドキュメントは、Phase 7-B データ統合スクリプト (`create_merged_dataset_334cols.py`) の開発過程で発生した全てのエラーと修正内容を記録しています。

---

## 🔄 修正履歴サマリー（全9回）

| 回 | エラー内容 | 原因 | 修正内容 | コミット |
|----|-----------|------|---------|---------|
| 1 | `um.kaisai_nen` 存在しない | 馬マスタを誤ってレース結合 | 馬マスタ結合に変更 | e08221c |
| 2 | `hr.ketto_toroku_bango` 存在しない | レーステーブルを誤って馬マスタ結合 | レーステーブルに変更 | 7f4a5f0 |
| 3 | `dm.ketto_toroku_bango` 存在しない | 全テーブル主キー推測ミス | 実主キー調査後修正 | 875a16a |
| 4 | `kyi.race_id` 存在しない | JRDB に `race_id` 誤認 | 複合キーJOINに変更 | d7f2d43 |
| 5 | `se.race_id` 存在しない | JRA-VAN に `race_id` 誤認 | 複合キーから動的生成 | ba962de |
| 6 | *(未実行)* | - | - | - |
| 7 | `bt` テーブルがFROM句に無い | 結合キー不在3テーブル除外漏れ | `jvd_bt`, `jvd_hn`, `jvd_br` 除外 | 4ecd118 |
| 8 | 0行取得 | 日付フォーマット不一致 | `TO_CHAR()` で変換試行 | bdec3cf |
| 9 | **`TO_CHAR()` 関数エラー** | **文字列型に `TO_CHAR` 不可** | **`SUBSTRING` + `\|\|` で文字列結合** | **60dd849** |

---

## 📋 詳細な修正履歴

### 修正 #1: 馬マスタテーブルの結合修正

**日時**: 2026-03-11  
**コミット**: e08221c

#### エラー内容
```
ERROR: column um.kaisai_nen does not exist in jvd_um table
LINE 385: LEFT JOIN jvd_um AS um ON se.kaisai_nen = um.kaisai_nen ...
```

#### 原因
`jvd_um`（馬基本情報）テーブルをレース情報テーブルと誤認し、レース特定用キー（`kaisai_nen`, `kaisai_tsukihi`, `keibajo_code`, `race_bango`）で結合しようとした。

実際には `jvd_um` は馬マスタテーブルで、主キーは `ketto_toroku_bango`（血統登録番号）のみ。

#### 修正内容
```sql
-- ❌ 修正前
LEFT JOIN jvd_um AS um 
    ON se.kaisai_nen = um.kaisai_nen 
    AND se.kaisai_tsukihi = um.kaisai_tsukihi 
    AND se.keibajo_code = um.keibajo_code 
    AND se.race_bango = um.race_bango

-- ✅ 修正後
LEFT JOIN jvd_um AS um 
    ON se.ketto_toroku_bango = um.ketto_toroku_bango
```

---

### 修正 #2: 払戻金テーブルの分類修正

**日時**: 2026-03-11  
**コミット**: 7f4a5f0

#### エラー内容
```
ERROR: column hr.ketto_toroku_bango does not exist
LINE 388: LEFT JOIN jvd_hr AS hr ON se.ketto_toroku_bango = hr.ketto_t...
```

#### 原因
`jvd_hr`（払戻金詳細）、`jvd_h1`（払戻金情報）、`jvd_h6`（三連単払戻）を馬マスタテーブルと誤認。

実際にはこれらはレース単位のテーブルで、主キーは `kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango`。

#### 修正内容
```python
# テーブル分類の修正
race_tables = [
    'jvd_ra', 'jvd_ck', 'jvd_wc', 'jvd_hc', 'jvd_sk',
    'jvd_hr', 'jvd_h1', 'jvd_h6'  # ← 追加
]
```

---

### 修正 #3: 全テーブルの主キー実調査

**日時**: 2026-03-11  
**コミット**: 875a16a

#### エラー内容
```
ERROR: column dm.ketto_toroku_bango does not exist
```

#### 原因
全テーブルの主キーを推測で実装していたため、実際の構造と不一致。

#### 修正内容
PostgreSQL から全テーブルの主キーを取得し、実構造に基づいて JOIN 条件を修正。

**調査結果**:
```sql
jvd_se: kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango, umaban, ketto_toroku_bango
jvd_ra: kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango
jvd_ck: kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango, ketto_toroku_bango
jvd_dm: kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango
jvd_um: ketto_toroku_bango
jvd_sk: ketto_toroku_bango
jvd_ch: chokyoshi_code
jvd_wc: tracen_kubun, chokyo_nengappi, chokyo_jikoku, ketto_toroku_bango
jvd_hc: tracen_kubun, chokyo_nengappi, chokyo_jikoku, ketto_toroku_bango
jvd_jg: kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango, ketto_toroku_bango, shutsuba_tohyo_uketsuke
```

---

### 修正 #4: JRDB の race_id カラム不在対応

**日時**: 2026-03-11  
**コミット**: d7f2d43

#### エラー内容
```
ERROR: column kyi.race_id does not exist
LINE 394: LEFT JOIN jrd_kyi AS kyi ON se.race_id = kyi.race_id ...
```

#### 原因
JRDB テーブルに `race_id` カラムが存在しないのに、JOIN条件で使用。

実際の JRDB 主キーは: `keibajo_code, race_shikonen, kaisai_kai, kaisai_nichime, race_bango, umaban`

#### 修正内容
```sql
-- ❌ 修正前
LEFT JOIN jrd_kyi AS kyi ON se.race_id = kyi.race_id

-- ✅ 修正後
LEFT JOIN jrd_kyi AS kyi 
    ON se.keibajo_code = kyi.keibajo_code 
    AND se.kaisai_nen = kyi.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = kyi.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = kyi.kaisai_nichime 
    AND se.race_bango = kyi.race_bango 
    AND se.umaban = kyi.umaban
```

---

### 修正 #5: JRA-VAN の race_id 動的生成

**日時**: 2026-03-11  
**コミット**: ba962de

#### エラー内容
```
ERROR: column se.race_id does not exist
LINE 3: se.race_id,
```

#### 原因
`jvd_se` テーブルに `race_id` カラムが存在しないのに、SELECT句で選択。

#### 修正内容
```sql
-- ❌ 修正前
SELECT se.race_id, se.umaban, se.kaisai_tsukihi, ...

-- ✅ 修正後
SELECT 
    (se.kaisai_nen || se.keibajo_code || 
     COALESCE(se.kaisai_kai, '00') || 
     COALESCE(se.kaisai_nichime, '00') || 
     se.race_bango) AS race_id,
    se.umaban,
    se.kaisai_tsukihi,
    ...
```

**生成される race_id の例**:
- `'2024' || '05' || '03' || '05' || '11'` → `'202405030511'`

---

### 修正 #7: 結合不可能テーブルの除外

**日時**: 2026-03-12  
**コミット**: 4ecd118

#### エラー内容
```
ERROR: missing FROM-clause entry for table "bt"
LINE 191: bt.keito_id,
```

#### 原因
`jvd_bt`, `jvd_hn`, `jvd_br` の3テーブルは `jvd_se` に結合キーが存在しないのに、SELECT に含まれていた。

#### 調査結果
```
jvd_se の存在確認:
- hanshoku_toroku_bango (繁殖登録番号): ❌ 不存在
- seisansha_code (生産者コード): ❌ 不存在
- banushi_code (馬主コード): ✅ 存在
```

#### 修正内容
以下3テーブルを除外:
1. `jvd_bt` (2列): `hanshoku_toroku_bango` で結合不可
2. `jvd_hn` (6列): `hanshoku_toroku_bango` で結合不可
3. `jvd_br` (1列): `seisansha_code` で結合不可

**代替情報**:
- 血統情報: `jvd_sk` (12列) + `jvd_um` (14列) で十分カバー
- 馬主情報: `jvd_se.banushi_code`, `banushimei` で基本情報取得可能

**カラム数調整**:
- 修正前: 334列
- 除外: 9列
- 修正後: **325列**

---

### 修正 #8: 日付フォーマット不一致修正（第1回）

**日時**: 2026-03-12  
**コミット**: bdec3cf

#### エラー内容
```
✅ 取得完了: 0 行 × 326 列
```

#### 原因
WHERE句が厳しすぎる + 日付形式の不一致。

**調査結果**:
```
jvd_se (JRA-VAN): 739,559 行 ✅
jrd_kyi (JRDB): 0 行 ❌
→ JRDB データの race_shikonen が YYMMDD 形式（例: '240307'）
→ JRA-VAN の kaisai_nen は YYYY 形式（例: '2024'）
→ 直接比較不可: '2024' ≠ '240307'
```

#### 修正内容

**WHERE句の修正**:
```sql
-- ❌ 修正前
WHERE kyi.race_shikonen ~ '^[0-9]+$'
  AND CAST(kyi.race_shikonen AS INTEGER) < 260201

-- ✅ 修正後
WHERE se.kaisai_nen >= '2016' AND se.kaisai_nen <= '2025'
```

**JOIN条件の修正（誤り）**:
```sql
-- ❌ 誤った修正（TO_CHAR 使用）
LEFT JOIN jrd_kyi AS kyi 
    ON se.keibajo_code = kyi.keibajo_code 
    AND TO_CHAR(se.kaisai_tsukihi, 'YYMMDD') = kyi.race_shikonen
    ...
```

---

### 修正 #9: 文字列型への対応（最終修正）

**日時**: 2026-03-12  
**コミット**: 60dd849

#### エラー内容
```
ERROR: function to_char(character varying, unknown) does not exist
LINE 379: ... AND TO_CHAR(se.kaisai_tsukihi, 'YYMMDD') = kyi.race_shikonen
HINT: No function matches the given name and argument types.
```

#### 原因
`kaisai_tsukihi` が `DATE` 型ではなく `character varying`（文字列型）だったため、`TO_CHAR()` 関数が使えない。

**調査結果**:
```
kaisai_tsukihi のデータ例:
  0101 (長さ: 4文字) → MMDD 形式
  
データ型:
- kaisai_nen: character varying (YYYY形式、例: '2024')
- kaisai_tsukihi: character varying (MMDD形式、例: '0101')
- race_shikonen: character varying (YYMMDD形式、例: '240101')
```

#### 修正内容
```sql
-- ❌ 修正前（8回目、エラー）
TO_CHAR(se.kaisai_tsukihi, 'YYMMDD') = kyi.race_shikonen

-- ✅ 修正後（9回目、正解）
(SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen
```

**動作例**:
```sql
SELECT 
    kaisai_nen,
    kaisai_tsukihi,
    SUBSTRING(kaisai_nen, 3, 2) AS year_yy,
    (SUBSTRING(kaisai_nen, 3, 2) || kaisai_tsukihi) AS race_shikonen_format
FROM jvd_se
WHERE kaisai_nen = '2024' AND kaisai_tsukihi = '0307';

-- 結果:
-- kaisai_nen: '2024'
-- kaisai_tsukihi: '0307'
-- year_yy: '24'
-- race_shikonen_format: '240307' ← JRDBの形式と一致
```

---

## 🎯 最終的な JOIN 条件（正解）

### JRA-VAN テーブル

#### レース結合テーブル
```sql
LEFT JOIN jvd_ra AS ra 
    ON se.kaisai_nen = ra.kaisai_nen 
    AND se.kaisai_tsukihi = ra.kaisai_tsukihi 
    AND se.keibajo_code = ra.keibajo_code 
    AND se.race_bango = ra.race_bango
```

#### レース+馬結合テーブル
```sql
LEFT JOIN jvd_ck AS ck 
    ON se.kaisai_nen = ck.kaisai_nen 
    AND se.kaisai_tsukihi = ck.kaisai_tsukihi 
    AND se.keibajo_code = ck.keibajo_code 
    AND se.race_bango = ck.race_bango 
    AND se.ketto_toroku_bango = ck.ketto_toroku_bango
```

#### 馬マスタテーブル
```sql
LEFT JOIN jvd_um AS um 
    ON se.ketto_toroku_bango = um.ketto_toroku_bango
```

#### 調教師マスタテーブル
```sql
LEFT JOIN jvd_ch AS ch 
    ON se.chokyoshi_code = ch.chokyoshi_code
```

---

### JRDB テーブル

#### 馬単位テーブル
```sql
LEFT JOIN jrd_kyi AS kyi 
    ON se.keibajo_code = kyi.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = kyi.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = kyi.kaisai_nichime 
    AND se.race_bango = kyi.race_bango 
    AND se.umaban = kyi.umaban
```

#### レース単位テーブル
```sql
LEFT JOIN jrd_bac AS bac 
    ON se.keibajo_code = bac.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = bac.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = bac.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = bac.kaisai_nichime 
    AND se.race_bango = bac.race_bango
```

---

## 📊 最終仕様

| 項目 | 値 |
|------|-----|
| 総カラム数 | **325列** |
| JRA-VAN | 209列（元218列 - 除外9列） |
| JRDB | 116列 |
| 期待行数 | 460,000～739,559行 |
| ファイルサイズ | 120～200 MB |
| 対象期間 | 2016-2025年 |

---

## 💡 学んだ教訓

### 1. 推測ではなく実データを確認する
全てのエラーは「テーブル構造を推測で実装したこと」が原因。最初に以下を確認すべきだった:
- 主キー
- データ型
- データ形式

### 2. データ型の重要性
`character varying` 型の日付に `TO_CHAR()` は使えない。文字列操作（`SUBSTRING`, `||`）を使用。

### 3. NULL値の扱い
`kaisai_kai` や `kaisai_nichime` は NULL の場合があるため、`COALESCE()` で '00' に変換。

### 4. テーブル分類の重要性
テーブルを正しく分類することで、適切な JOIN 条件を選択できる:
- レース結合テーブル
- レース+馬結合テーブル
- 馬マスタテーブル
- その他マスタテーブル

---

## 📝 更新履歴

- 2026-03-12: 初版作成（全9回の修正履歴を記録）
