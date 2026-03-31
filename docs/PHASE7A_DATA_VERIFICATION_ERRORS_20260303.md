# Phase 7-A データ検証エラー報告 (2026-03-03)

## 🚨 pgAdmin4 SQL実行エラー分析

### **エラー1: jvd_ra テーブル**
```
ERROR: column "baba_jotai_code_shiba" does not exist
LINE 5: COUNT(baba_jotai_code_shiba) AS turf_condition_filled,
HINT: Perhaps you meant to reference the column "jvd_ra.babajotai_code_shiba".
```
**原因**: カラム名の誤り
- ❌ `baba_jotai_code_shiba`
- ✅ `babajotai_code_shiba` （正しいカラム名）

---

### **エラー2: jvd_ck テーブル**
```
ERROR: column "kakutei_chakujun" does not exist
LINE 3: COUNT(kakutei_chakujun) AS finish_position_filled,
HINT: Perhaps you meant to reference the column "jvd_ck.ten_shisu" or "jvd_ck.ichi_shisu".
```
**原因**: jvd_ck テーブルには `kakutei_chakujun` カラムが存在しない
- **想定**: 着順データは jvd_se テーブルの `kakutei_chakujun` に存在
- **jvd_ck**: 成績累積データ（賞金、競馬場別成績）のみ

---

### **エラー3: jrd_kyi テーブル**
```
ERROR: column "idm_shisu" does not exist
LINE 3: COUNT(idm_shisu) AS idm_filled,
HINT: Perhaps you meant to reference the column "jrd_kyi.ten_shisu" or "jrd_kyi.ichi_shisu".
```
**原因**: カラム名が異なる可能性
- **確認必要**: `JRDBテーブルのカラム詳細.csv` で jrd_kyi の実カラム名を特定

---

### **エラー4: jrd_sed テーブル**
```
ERROR: column "time" does not exist
LINE 3: COUNT(time) AS time_filled,
```
**原因**: `time` カラムが存在しない
- **確認必要**: `JRDBテーブルのカラム詳細.csv` で jrd_sed の実カラム名を特定

---

## ✅ 正常に取得できたデータ

### **1. JRA-VAN 年次範囲（jvd_se）**
| 年 | レコード数 | ユニーク馬数 |
|----|-----------|-------------|
| 2026 | 9,105 | 5,869 |
| 2025 | 48,134 | 11,935 |
| 2024 | 46,811 | 11,788 |
| 2023 | 47,741 | 11,726 |
| 2022 | 47,295 | 11,560 |
| 2021 | 47,904 | 11,574 |
| 2020 | 48,523 | 11,707 |
| 2019 | 48,257 | 11,564 |
| 2018 | 49,213 | 11,408 |
| 2017 | 49,929 | 11,286 |
| 2016 | 50,174 | 11,188 |
**合計（2016〜2025）**: 483,981レコード

---

### **2. jvd_se 全カラム充填率**
- **総レコード数**: 739,040（全年次）
- **2016〜2025**: 483,981レコード
- **充填率**: **100.00%**（全70カラムがNULLなし）

**主要カラム例**:
- `ketto_toroku_bango` (馬ID): 100%
- `kishu_code` (騎手コード): 100%
- `futan_juryo` (負担重量): 100%
- `blinker_shiyo_kubun` (ブリンカー使用): 100%
- `zogen_sa` (馬体重増減): 100%

---

### **3. JRA-VAN 主要3テーブルのカラム数**
| テーブル | カラム数 | 用途 |
|---------|---------|------|
| jvd_ck | 106 | 競走成績累積（賞金、距離別/競馬場別成績） |
| jvd_ra | 62 | レース情報（距離、馬場、ラップタイム、コーナー通過順） |
| jvd_se | 70 | 出走馬情報（馬、騎手、負担重量、着順、タイム） |
**合計**: 238カラム

---

## ⚠️ JRDB 年次データの異常

**CSVファイル**: `JRDB テーブルのデータ年次範囲確認.csv`

```
year, record_count
2622, 1
2621, 12
261b, 12  ← 16進数表記
261a, 12  ← 16進数表記
2619, 12
...
```

**問題**: `race_shikonen` カラムが**16進数文字列**で格納されている
- `2622` → 2026年2月?
- `261b` → 2026年1月11日? (0x1b = 27)

**推測**: JRDB の `race_shikonen` は YYYYMMDD 形式ではない独自フォーマット

---

## 📋 次のアクション

### **優先度A: JRDBカラム名の正確な特定**
1. `JRDBテーブルのカラム詳細.csv` を精査
2. jrd_kyi の指数系カラム名を確認:
   - `idm_shisu` → 実際のカラム名は？
   - `jockey_shisu` → 実際のカラム名は？
   - `sogo_shisu_3` → 実際のカラム名は？
3. jrd_sed のタイム系カラム名を確認:
   - `time` → 実際のカラム名は？
   - `pace` → 実際のカラム名は？

### **優先度B: JRDBの年次範囲再取得**
```sql
-- race_shikonen を年次に変換
SELECT 
    SUBSTRING(race_shikonen, 1, 4) AS year,
    COUNT(*) AS record_count
FROM jrd_kyi
WHERE race_shikonen IS NOT NULL
  AND LENGTH(race_shikonen) >= 8
GROUP BY SUBSTRING(race_shikonen, 1, 4)
ORDER BY year DESC;
```

### **優先度C: jvd_ra カラム名修正後の再実行**
```sql
SELECT 
    COUNT(*) AS total_records,
    COUNT(kyori) AS distance_filled,
    COUNT(track_code) AS track_code_filled,
    COUNT(babajotai_code_shiba) AS turf_condition_filled,  -- 修正
    COUNT(babajotai_code_dirt) AS dirt_condition_filled,   -- 修正
    COUNT(lap_time) AS lap_time_filled,                    -- 単一カラムに修正
    ROUND(100.0 * COUNT(kyori) / COUNT(*), 2) AS distance_rate,
    ROUND(100.0 * COUNT(lap_time) / COUNT(*), 2) AS lap_time_rate
FROM jvd_ra
WHERE LEFT(kaisai_nen::text, 4) BETWEEN '2016' AND '2025';
```

---

## 🎯 成果物

### **現時点で確定した情報**
✅ JRA-VAN jvd_se: 70カラム、483,981レコード（2016〜2025）、充填率100%  
✅ JRA-VAN 主要3テーブル: 238カラム（jvd_ck 106 + jvd_ra 62 + jvd_se 70）  
✅ 既存CSV: 139カラム → 未使用候補 238 - 139 = **99カラム（JRA-VANのみ）**  

⚠️ JRDB: カラム名と年次範囲の再確認が必要  
⚠️ JRDB: 290カラム → 正確なカラム名取得後、充填率チェック実施

---

**作成日**: 2026-03-03  
**ステータス**: Phase 7-A Day 3 実施中（データ検証エラー対応待ち）  
**次ステップ**: JRDBカラム詳細CSVの精査 → カラム名修正 → SQL再実行
