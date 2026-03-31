# Phase 7-A Day 3 完了報告 (2026-03-03)

## ✅ 完了した作業内容

### **1. pgAdmin4 データ検証結果の完全分析**
- ✅ JRA-VAN 年次範囲確認: 2016〜2025年（10年分、483,981レコード）
- ✅ jvd_se 全70カラムのNULL率確認: **100%充填率**
- ✅ JRA-VAN主要3テーブル（jvd_se, jvd_ra, jvd_ck）合計238カラム確認
- ⚠️ JRDB 年次データの異常検出（16進数表記）
- ⚠️ SQL実行エラー4件の原因特定

### **2. JRDB カラム名マッピング完了**
- ✅ 5テーブル（jrd_kyi, jrd_sed, jrd_bac, jrd_cyb, jrd_joa）全290カラムの詳細確認
- ✅ SQL エラーの正しいカラム名特定:
  - `idm_shisu` → `idm`
  - `jockey_shisu` → `kishu_shisu`
  - `sogo_shisu_3` → `sogo_shisu`
  - `time` → `soha_time`
- ✅ ROI向上期待度ランキング Top 30 作成
- ✅ 修正SQL作成（jrd_kyi, jrd_sed 充填率チェック用）

### **3. ドキュメント作成（4ファイル）**
1. `PHASE7A_DATA_VERIFICATION_ERRORS_20260303.md` (5,814 B)
   - pgAdmin4 SQL実行エラー分析
   - JRA-VAN データ確認結果
   - JRDB 年次データ異常の詳細
   
2. `PHASE7A_JRDB_COLUMN_MAPPING_20260303.md` (11,287 B)
   - JRDB 5テーブル全カラム詳細
   - ROI期待度ランキング Top 30
   - 修正SQL 2種類
   
3. `PHASE7A_COMPLETE_DATABASE_INVESTIGATION_20260303.md` (作成済み)
4. `PHASE7A_DATABASE_INVESTIGATION_PLAN_20260303.md` (作成済み)

---

## 📊 データベース調査結果サマリー

### **JRA-VAN (1,649カラム)**

| テーブル | カラム数 | 2016〜2025レコード数 | 充填率 | 用途 |
|---------|---------|---------------------|-------|------|
| jvd_se | 70 | 483,981 | **100%** | 出走馬情報（馬、騎手、負担重量、着順） |
| jvd_ra | 62 | 237,000〜 | 要確認 | レース情報（距離、馬場、ラップタイム） |
| jvd_ck | 106 | 1,091,540〜 | 要確認 | 競走成績累積（賞金、距離/競馬場別） |

**JRA-VAN 合計**: 238カラム（主要3テーブル）

---

### **JRDB (290カラム)**

| テーブル | カラム数 | 用途 | ROI重要度 |
|---------|---------|------|----------|
| jrd_kyi | 132 | 馬・騎手指数、展開予想 | ★★★★★ |
| jrd_sed | 80 | 成績・ラップタイム・ペース | ★★★★☆ |
| jrd_bac | 27 | 馬場・開催情報 | ★★★☆☆ |
| jrd_cyb | 27 | 調教データ | ★★★☆☆ |
| jrd_joa | 24 | オッズ分析 | ★★☆☆☆ |

**JRDB 合計**: 290カラム

---

## 🔥 ROI向上期待度 Top 10 カラム

| 順位 | カラム名 | テーブル | データ型 | 用途 | ROI期待度 |
|------|---------|---------|---------|------|----------|
| 1 | `idm` | jrd_kyi | varchar(5) | IDM指数 | ★★★★★ |
| 2 | `sogo_shisu` | jrd_kyi | varchar(5) | 総合指数 | ★★★★★ |
| 3 | `ten_shisu` | jrd_kyi | varchar(5) | テン指数（序盤3F） | ★★★★★ |
| 4 | `agari_shisu` | jrd_kyi | varchar(5) | 上がり指数（終盤3F） | ★★★★★ |
| 5 | `pace_shisu` | jrd_kyi | varchar(5) | ペース指数 | ★★★★★ |
| 6 | `ichi_shisu` | jrd_kyi | varchar(5) | 位置指数 | ★★★★★ |
| 7 | `kishu_shisu` | jrd_kyi | varchar(5) | 騎手指数 | ★★★★☆ |
| 8 | `chokyo_shisu` | jrd_kyi | varchar(5) | 調教指数 | ★★★★☆ |
| 9 | `kyusha_shisu` | jrd_kyi | varchar(5) | 厩舎指数 | ★★★★☆ |
| 10 | `kishu_kitai_rentai_ritsu` | jrd_kyi | varchar(4) | 騎手期待連対率 | ★★★★☆ |

---

## 🎯 現時点の特徴量拡張可能性

### **確定情報**
- **既存CSV**: 139カラム（Phase 1-6で確定）
- **JRA-VAN**: 238カラム（jvd_se 70 + jvd_ra 62 + jvd_ck 106）
- **JRDB**: 290カラム（jrd_kyi 132 + jrd_sed 80 + 他 78）
- **合計候補**: 1,939カラム（JRA-VAN 1,649 + JRDB 290）

### **未使用カラム推定**
- **JRA-VAN 未使用**: 238 - (既存139の一部) ≈ **100〜150カラム**
- **JRDB 未使用**: 290 - (既存139の一部) ≈ **200〜250カラム**
- **合計未使用候補**: **300〜400カラム**

### **目標**
- **Phase 7-A 目標**: 200〜220次元（既存139 + 61〜81）
- **達成可能性**: ✅ **十分達成可能**（候補300〜400 >> 目標61〜81）

---

## ⚠️ 未解決の課題

### **優先度A（PC側で実施必要）**
1. **JRDB 年次範囲の再取得**
   - `race_shikonen` が16進数表記（2622, 261b等）
   - 正しいフォーマット確認が必要
   
2. **JRDB 充填率チェック（修正SQL実行）**
   ```sql
   -- jrd_kyi
   SELECT COUNT(*), COUNT(idm), COUNT(kishu_shisu), ...
   FROM jrd_kyi;
   
   -- jrd_sed
   SELECT COUNT(*), COUNT(soha_time), COUNT(pace), ...
   FROM jrd_sed;
   ```

3. **jvd_ra, jvd_ck の充填率チェック（カラム名修正後）**
   - `baba_jotai_code_shiba` → `babajotai_code_shiba`
   - jvd_ck には `kakutei_chakujun` が存在しない（jvd_seに存在）

### **優先度B（既存139カラムの特定）**
4. **既存CSV ヘッダー取得**
   ```powershell
   Get-Content "E:\anonymous-keiba-ai-JRA\data\raw\jravan_jrdb_merged_fixed.csv" -TotalCount 1
   ```
   - 139カラムのリスト化
   - JRA-VAN/JRDB カラムとの重複チェック

---

## 📋 次のアクション（Day 4 以降）

### **ステップ1: JRDB 充填率確認（PC実施）**
- pgAdmin4で修正SQL実行
- jrd_kyi, jrd_sed の充填率を取得
- 結果をCSVで保存 → サンドボックスへ報告

### **ステップ2: 既存139カラムのリスト取得**
- CSVヘッダー行をコピー
- Excel または PowerShell でカラム名抽出

### **ステップ3: 未使用カラムの抽出**
- JRA-VAN 238 - 既存カラム = 未使用JRA-VANカラム
- JRDB 290 - 既存カラム = 未使用JRDBカラム

### **ステップ4: ROI期待カラム選定（61〜81個）**
- 優先度S: 20〜30個（必須）
- 優先度A: 20〜30個（推奨）
- 優先度B: 20〜30個（検討）

### **ステップ5: SQL抽出クエリ作成**
```sql
SELECT 
    -- 既存139カラム
    race_id, keibajo_code, kyori, ...
    
    -- 追加61〜81カラム
    jrd_kyi.idm,
    jrd_kyi.sogo_shisu,
    jrd_kyi.ten_shisu,
    ...
FROM jvd_se
LEFT JOIN jrd_kyi USING (race_key, umaban)
LEFT JOIN jrd_sed USING (race_key, umaban)
...
```

### **ステップ6: 抽出スクリプト実装**
- `phase7/scripts/extract_additional_features.py`
- PostgreSQL接続 → SQL実行 → CSV出力
- マージCSV作成（139 + 61〜81 = 200〜220カラム）

---

## 🎉 Phase 7-A Day 3 達成事項

### **成果物（合計 4 ドキュメント + 1 Git コミット）**
1. `PHASE7A_DATA_VERIFICATION_ERRORS_20260303.md`
2. `PHASE7A_JRDB_COLUMN_MAPPING_20260303.md`
3. `PHASE7A_COMPLETE_DATABASE_INVESTIGATION_20260303.md`
4. `PHASE7A_DATABASE_INVESTIGATION_PLAN_20260303.md`
5. Git コミット `121119c` (1,241 insertions)

### **技術的成果**
- ✅ pgAdmin4 データ検証エラー 4件の原因特定・解決策提示
- ✅ JRDB 全290カラムの正確なカラム名マッピング完成
- ✅ ROI向上期待度ランキング Top 30 作成
- ✅ JRA-VAN 238カラム、JRDB 290カラムの用途分類完了
- ✅ 修正SQL 2種類の作成

### **進捗状況**
- **Week 1 Day 3**: ✅ **完了**
- **Week 1 Day 4**: ⏳ 準備完了（PC側実施待ち）
- **次ステップ**: JRDB充填率確認 → 既存139カラム特定 → 候補選定

---

## 📌 重要な発見事項

### **1. JRA-VAN jvd_se の高品質データ**
- 2016〜2025年: 483,981レコード
- 全70カラム: **100%充填率**（NULLなし）
- → 安定した学習データとして最適

### **2. JRDB の豊富な指数系データ**
- jrd_kyi: 132カラム（指数7種類 + 展開予想 + 調教評価）
- jrd_sed: 80カラム（ラップタイム25分割 + ペース + 位置取り）
- → ROI向上に直結する高品質特徴量が豊富

### **3. 特徴量拡張の余地が十分**
- 未使用候補: 300〜400カラム
- 目標: 61〜81カラム追加
- → 達成可能性: **非常に高い**

---

## 🚀 次週（Week 2）への準備完了

### **Week 1 残タスク（Day 4-7）**
- Day 4: JRDB充填率確認 + 既存139カラム特定
- Day 5: 未使用カラム抽出 + ROI候補選定（61〜81個）
- Day 6-7: SQL抽出クエリ作成 + スクリプト実装

### **Week 2 移行準備**
- 200〜220次元マスターCSV作成
- 特徴量エンジニアリング（カテゴリカル変換、欠損値処理）
- モデル学習パイプライン構築

---

**作成日**: 2026-03-03  
**ステータス**: Phase 7-A Day 3 完了  
**Git コミット**: `121119c`  
**次アクション**: PC側でJRDB充填率確認SQLを実行し、結果を報告
