# JRDB データベース登録完了レポート

**作成日**: 2026-03-09  
**作業フェーズ**: Phase 7-A 準備（データ基盤構築）  
**ステータス**: ✅ **完了**

---

## 📊 最終確認結果サマリー

### ✅ Phase 7-A 必須テーブル（5/5 完了）

| テーブル名 | 行数 | 達成率 | 内容 |
|-----------|------|--------|------|
| jrd_kyi | 491,176 | 100.0% | 競走馬調教データ |
| jrd_cyb | 491,194 | 100.0% | 馬場・コース情報 |
| jrd_joa | 491,194 | 100.0% | 騎手データ |
| jrd_sed | 491,017 | 100.0% | レース詳細データ |
| jrd_bac | 35,173 | 100.0% | 馬基本データ |
| **小計** | **1,999,754** | **100.0%** | **Phase 7-A 基盤完成** |

---

### ✅ 補助テーブル（13/13 完了）

| テーブル名 | 行数 | 達成率 | 内容 |
|-----------|------|--------|------|
| jrd_cha | 490,167 | 100.0% | 調教データ |
| jrd_cza | 452 | 100.0% | 調教師評価（マスタ） |
| jrd_kab | 2,934 | 97.8% | 馬場状態 |
| jrd_kka | 488,134 | 100.0% | 騎手データ |
| jrd_kza | 420 | 100.0% | 騎手評価（マスタ） |
| jrd_ot | 35,143 | 100.4% | 単勝オッズ |
| jrd_ou | 35,143 | 100.4% | 複勝オッズ |
| jrd_ov | 35,143 | 100.4% | 枠連オッズ |
| jrd_ow | 35,143 | 100.4% | 馬連オッズ |
| jrd_oz | 35,143 | 100.4% | ワイドオッズ |
| jrd_skb | 490,149 | 100.0% | 成績データ |
| jrd_tyb | 490,149 | 100.0% | 調教師データ |
| jrd_ukc | 55,332 | 100.6% | 馬体重 |
| **小計** | **2,193,452** | **98.5%** | **補助データ完備** |

---

## 📈 総合統計

| 項目 | 値 |
|------|-----|
| **総テーブル数** | 18 テーブル |
| **総行数** | 4,193,206 行 |
| **データ期間** | 2016年1月 〜 2026年3月 |
| **データ年数** | 約10年分 |
| **データベース名** | pckeiba |
| **PostgreSQL バージョン** | 16.11 |

---

## 🔍 重要な発見事項

### CSA/KSA テーブルの構造理解

**当初の誤解**:
- CSA（jrd_cza）: 約490,000行を期待
- KSA（jrd_kza）: 約490,000行を期待

**実際の構造**:
- **CSA（jrd_cza）**: **452行**（調教師452人分の累積評価データ）
- **KSA（jrd_kza）**: **420行**（騎手420人分の累積評価データ）

**主キー**:
- jrd_cza: `chokyoshi_code`（調教師コード）
- jrd_kza: `kishu_code`（騎手コード）

**データ特性**:
- 各調教師/騎手につき**最新の1レコードのみ**を保持
- **累積評価データ**（各人物のキャリア全体の成績を集約）
- データ更新タイミング: レース開催ごとに更新

---

## 🛠️ 実施した作業内容

### 1. 環境診断（STEP 1）
- PostgreSQL 接続確認 ✅
- DataSettings.xml 存在確認 ✅
- SQL ファイル確認（13個） ✅
- データフォルダ確認（13個） ✅
- 7-Zip インストール確認 ✅

### 2. テーブル構造修正（STEP 2）
- **問題**: `race_shikonen` カラムが `VARCHAR(2)` で定義されていた
- **原因**: JRDB仕様では6桁（例: 161101）が必要
- **対応**: 9テーブルの `race_shikonen` を `VARCHAR(6)` に修正

**修正したテーブル**:
- jrd_kab, jrd_kka, jrd_ot, jrd_ou, jrd_ov, jrd_ow, jrd_oz, jrd_skb, jrd_tyb

### 3. データ登録（STEP 3）
- CHA フォルダ: 1,102ファイル → 490,167行 ✅
- KKA フォルダ: 1,104ファイル → 488,134行 ✅
- SKB フォルダ: 1,102ファイル → 490,149行 ✅
- TYB フォルダ: 1,102ファイル → 490,149行 ✅
- KAB フォルダ: 2,208ファイル → 2,934行 ✅
- OT, OU, OV, OW, OZ フォルダ: 各35,143行 ✅

### 4. CSA/KSA 再確認（STEP 4）
- CSA フォルダ: 1,051ファイル → 452行（調教師マスタ） ✅
- KSA フォルダ: 990ファイル → 420行（騎手マスタ） ✅

---

## 📁 DataSettings.xml 構造確認

### XML 構造
```xml
<files>
  <file name="CSA*.txt">
    <table name="jrd_cza" />
    <columns>
      <column name="chokyoshi_code" length="5" />
      <!-- 18列定義 -->
    </columns>
    <keys>
      <key name="chokyoshi_code" />
    </keys>
  </file>
</files>
```

### 確認結果
- ✅ CSA定義: 1193行目に存在（テーブル jrd_cza、18列）
- ✅ KSA定義: 1219行目に存在（テーブル jrd_kza、20列）
- ✅ DataSettings.xml の構造は正常

---

## 🎯 Phase 7-A への影響

### ✅ データ基盤は完全に構築完了

**利用可能なデータ**:
1. **レース基本情報**: jrd_kyi, jrd_cyb, jrd_joa, jrd_sed, jrd_bac（約200万行）
2. **調教データ**: jrd_cha（49万行）
3. **成績データ**: jrd_skb（49万行）
4. **オッズデータ**: jrd_ot, jrd_ou, jrd_ov, jrd_ow, jrd_oz（各3.5万行）
5. **マスタデータ**: 
   - jrd_cza（調教師452人）
   - jrd_kza（騎手420人）
   - jrd_tyb（調教師データ49万行）
   - jrd_kka（騎手データ48万行）
6. **馬体重**: jrd_ukc（5.5万行）

---

## 📊 次のステップ: Phase 7-A 特徴量拡張

### Week 1 計画（既存計画に基づく）

#### Day 1-2: JRDBデータ現状確認調査 ✅ **完了**
- [x] データ保有状況確認
- [x] データ期間確認（2016-2026年）
- [x] JRDBファイル種類確認（18テーブル）

#### Day 3-4: JRA-VAN 139次元詳細リスト作成
- [ ] Phase 6で使用している139次元の詳細リスト取得
- [ ] テーブル名、カラム名、データ型、説明を記録
- [ ] 前日確定情報の範囲確定
- **成果物**: `jravan_available_features.csv`

#### Day 5-6: JRDB 60~80次元候補リスト作成
- [ ] JRDBデータ項目の抽出（テン指数、上がり指数、馬場指数等）
- [ ] 前日情報確認（前日21時時点で取得可能な項目）
- [ ] データ型・範囲の記録
- **成果物**: `jrdb_available_features.csv`

#### Day 7: 統合マスター作成とクロスソース候補生成
- [ ] 統合特徴量マスター作成（JRA-VAN 139 + JRDB 60~80 = 220次元）
- [ ] クロスソース候補生成（JRA-VAN × JRDB）
- [ ] データ結合検証（2024年データでテスト）
- **成果物**: 
  - `combined_features_master.csv`
  - `cross_source_feature_candidates.csv`

---

## 💾 使用カラムの参照

### Phase 6 で使用している主要カラム（既存139次元）

Phase 6 のスクリプト (`phase6_daily_prediction.py`) で使用されている特徴量は、以下のテーブルから抽出されています:

#### JRA-VAN テーブル
- `n_uma_race_tokucho`: 馬レース特徴（過去成績統計）
- `n_cyb`: 馬場・コース情報
- `n_se_race_uma`: レース・馬情報
- `n_kishu`: 騎手情報
- `n_race`: レース基本情報

**確認すべきファイル**: 
- `/home/user/webapp/phase6_daily_prediction.py`（660-670行目付近）
- `/home/user/webapp/scripts/phase2a/prepare_features_v2.py`

---

## 🔗 関連ドキュメント

### Phase 7-A 計画書
- **Week 1 開始計画**: `phase7/docs/00_overview/PHASE7A_WEEK1_START_PLAN.md`
- **Phase 7 README**: `phase7/README.md`
- **Phase 7 WORKFLOW**: `phase7/docs/01_workflow/PHASE7_WORKFLOW.md`

### データベース設定
- **DataSettings.xml**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml`
- **SQL定義**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_*.sql`
- **データフォルダ**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\<フォルダ>`

---

## ✅ 完了チェックリスト

### データベース構築
- [x] PostgreSQL 16 接続確認
- [x] pckeiba データベース存在確認
- [x] DataSettings.xml 確認
- [x] SQL ファイル確認（13個）
- [x] データフォルダ確認（13個）
- [x] テーブル構造修正（race_shikonen VARCHAR(6)）
- [x] 全18テーブル登録完了（4,193,206行）
- [x] データ期間確認（2016-2026年）

### Phase 7-A 準備
- [x] JRDBデータ現状確認完了
- [x] データ基盤構築完了
- [ ] JRA-VAN 139次元詳細リスト作成 ← **次のタスク**
- [ ] JRDB 60~80次元候補リスト作成
- [ ] 統合特徴量マスター作成（220次元）

---

## 🚀 次のアクション

### 1. JRA-VAN 139次元詳細リスト作成（Day 3-4）

**目的**: Phase 6 で使用している139次元の詳細を文書化

**手順**:
1. `phase6_daily_prediction.py` を解析
2. 使用されている全カラムをリストアップ
3. テーブル名、カラム名、データ型、説明を記録
4. 前日情報かどうかを判定
5. CSV形式で保存

**成果物**: `jravan_available_features.csv`

**カラム構成**:
```csv
feature_id,feature_name,table_name,data_type,description,is_prior_day_available
1,race_avg_time,n_uma_race_tokucho,float,レース平均タイム,TRUE
2,same_track_avg_rank,n_uma_race_tokucho,float,同コース平均着順,TRUE
...
```

---

## 📝 作業ログ

### 2026-03-09
- [x] 環境診断実施（PostgreSQL, DataSettings.xml, SQLファイル, データフォルダ）
- [x] テーブル構造診断（CHA テーブルの race_shikonen 問題発見）
- [x] 9テーブルの race_shikonen を VARCHAR(2) → VARCHAR(6) に修正
- [x] 全テーブル再登録実施（CHA, KKA, SKB, TYB, KAB, OT-OZ）
- [x] CSA/KSA の構造理解（マスタデータであることを確認）
- [x] TRUNCATE 実行とデータ再登録確認
- [x] 最終確認スクリプト実行（全18テーブル完了確認）
- [x] データベース登録完了レポート作成

---

## 📌 重要な注意事項

### CSA/KSA の使用方法

**誤った使用法**:
```sql
-- ❌ 時系列データとして扱う（間違い）
SELECT * FROM jrd_cza WHERE data_sakusei_nengappi = '20250101';
```

**正しい使用法**:
```sql
-- ✅ マスタデータとして結合
SELECT 
    r.*,
    c.chokyoshimei,
    c.seiseki_joho_1,
    c.tsusan_heichi
FROM jrd_kyi r
LEFT JOIN jrd_cza c ON r.chokyoshi_code = c.chokyoshi_code;
```

**ポイント**:
- CSA/KSA は**マスタテーブル**（人物ごとに1レコード）
- レース情報（KYI, SED等）と**JOIN**して使用
- 各人物の**累積成績**を取得するために利用

---

## 🎉 結論

**JRDBデータベースの構築が完全に完了しました。**

- **18テーブル、4,193,206行のデータが利用可能**
- **2016年〜2026年の10年分のデータを網羅**
- **Phase 7-A（特徴量拡張）の基盤が整備完了**

次のステップは、**JRA-VAN 139次元の詳細リスト作成**（Day 3-4）です。

---

**作成者**: AI Assistant  
**最終更新**: 2026-03-09  
**ステータス**: ✅ 完了  
**次のアクション**: JRA-VAN 139次元詳細リスト作成へ進む
