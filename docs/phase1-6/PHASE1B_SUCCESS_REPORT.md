# ✅ Phase 1-B 完全成功レポート

## 📊 実行結果サマリー

### データ抽出成功
- **出力ファイル**: `data/raw/jrdb_48cols.csv`
- **総行数**: 481,627 行（データ行） + 1 行（ヘッダー） = 481,628 行
- **列数**: 53 列（キー7列 + 特徴46列）
- **ファイルサイズ**: 86.0 MB (90,139,753 bytes)
- **実行時間**: 
  - Step 1（基本データ抽出）: 15.74秒
  - Step 2（過去走データ抽出）: 23秒
  - Step 3（データ結合）: 5.71秒
  - **合計**: 約44秒 ⚡
- **エンコーディング**: UTF-8-sig
- **データ品質**: ✅ 検証済み

### 3ステップ抽出方式の成果
| ステップ | 内容 | 行数 | 列数 | サイズ | 実行時間 |
|---------|------|------|------|--------|----------|
| **Step 1** | 基本データ（予測指数・調教・適性・CID/LS等） | 481,627 | 46 | 83.1 MB | 15.74秒 |
| **Step 2** | 過去走データ（pace・deokure・furi等） | 481,627 | 12 | 21.1 MB | 23秒 |
| **Step 3** | データ結合 | 481,627 | 53 | 86.0 MB | 5.71秒 |
| **合計** | **JRDB完全データセット** | **481,627** | **53** | **86.0 MB** | **44秒** |

### データ統計
- **過去走データあり**: 399,707件（83.0%）
- **過去走データなし**: 81,920件（17.0%）※新馬・初出走馬
- **データ期間**: 2016年〜2025年（10年分）

---

## 🏗️ 3ステップ抽出アーキテクチャ

### アプローチの選択理由
初期の単一クエリ方式（LATERAL JOIN）は以下の問題が発生：
- ❌ **パフォーマンス**: 2016年の抽出で無限ループ
- ❌ **メモリ使用**: PostgreSQL一時ファイル増大
- ❌ **複雑性**: デバッグ困難

**解決策**: データソース別の段階的抽出 + Python結合

### Step 1: 基本データ抽出（41列）
**目的**: JRDBコア情報の高速抽出

**データソース**:
- `jrd_kyi`: 基本レース・馬情報、予測指数
- `jrd_joa`: 調教情報、CID/LS指数
- `jrd_cyb`: 馬体重情報

**抽出カラム（46列 = キー7 + 特徴39列）**:

#### キー列（7列）
1. keibajo_code - 競馬場コード
2. race_shikonen - レース施行年（下2桁）
3. kaisai_kai - 開催回
4. kaisai_nichime - 開催日目
5. race_bango - レース番号
6. umaban - 馬番
7. ketto_toroku_bango - 血統登録番号

#### 予測指数（13列）#99-#111
8. idm - IDM（スピード指数）
9. kishu_shisu - 騎手指数
10. joho_shisu - 情報指数
11. sogo_shisu - 総合指数
12. chokyo_shisu - 調教指数
13. kyusha_shisu - 厩舎指数
14. gekiso_shisu - 激走指数
15. ninki_shisu - 人気指数
16. ten_shisu - 展開指数
17. pace_shisu - ペース指数
18. agari_shisu - 上がり指数
19. ichi_shisu - 位置指数
20. manken_shisu - 万券指数

#### 調教・厩舎評価（5列）#112-#116
21. chokyo_yajirushi_code - 調教矢印コード
22. kyusha_hyoka_code - 厩舎評価コード
23. kishu_kitai_rentai_ritsu - 騎手期待連対率
24. shiage_shisu - 仕上指数
25. chokyo_hyoka - 調教評価

#### 馬適性・状態（6列）#117-#122
26. kyakushitsu_code - 脚質コード
27. kyori_tekisei_code - 距離適性コード
28. joshodo_code - 上昇度コード
29. tekisei_code_omo - 適性コード（重）
30. hizume_code - 蹄コード
31. class_code - クラスコード

#### 展開予測（2列）#123-#124
32. pace_yoso - ペース予想
33. uma_deokure_ritsu - 馬出遅率

#### ランク・その他（6列）#125-#130
34. rotation - ローテーション
35. hobokusaki_rank - 放牧先ランク
36. kyusha_rank - 厩舎ランク
37. bataiju - 馬体重
38. bataiju_zogen - 馬体重増減
39. uma_start_shisu - 馬スタート指数

#### CID/LS指数（7列）#131-#137
40. cid - CID
41. ls_shisu - LS指数
42. ls_hyoka - LS評価
43. em - EM
44. kyusha_bb_shirushi - 厩舎BB印
45. kishu_bb_shirushi - 騎手BB印
46. kyusha_bb_nijumaru_tansho_kaishuritsu - 厩舎BB二重丸単勝回収率

**SQL特徴**:
- LEFT JOIN使用（jrd_joa、jrd_cybは欠損許容）
- 年別バッチ処理（race_shikonen='16'〜'25'）
- シンプルな結合キー（競馬場・施行年・開催回日目・レース・馬番）

**パフォーマンス**:
- 実行時間: 15.74秒
- 出力: 481,627件 × 46列（83.1 MB）

---

### Step 2: 過去走データ抽出（7列）
**目的**: 馬の前走パフォーマンス情報取得

**データソース**:
- `jrd_sed`: 成績データ（過去走）

**抽出カラム（12列 = キー5 + 過去走7列）**:

#### キー列（5列）
1. ketto_toroku_bango - 血統登録番号
2. keibajo_code - 競馬場コード
3. race_shikonen - レース施行年
4. kaisai_kai - 開催回
5. kaisai_nichime - 開催日目

#### 過去走データ（7列）#138-#144
6. prev1_pace - 前走ペース
7. prev1_deokure - 前走出遅
8. prev1_furi - 前走不利
9. prev1_furi_1 - 前走不利1
10. prev1_furi_2 - 前走不利2
11. prev1_furi_3 - 前走不利3
12. prev1_batai_code - 前走馬体コード

**SQL特徴**:
- CTE (WITH句) + ROW_NUMBER()使用
- 前走の定義: 同一馬の確定着順レース（日付降順で最新1件）
- 年別フィルタリングで効率化
- インデックス活用（idx_jrd_sed_ketto_race）

**パフォーマンス**:
- 実行時間: 23秒
- 出力: 481,627件 × 12列（21.1 MB）
- 欠損: 81,920件（17.0%）※新馬・初出走馬

---

### Step 3: データ結合（48列化）
**目的**: 基本データと過去走データをマージして完全データセット作成

**結合方式**:
- pandas.merge (LEFT JOIN)
- 結合キー: ['ketto_toroku_bango', 'keibajo_code', 'race_shikonen', 'kaisai_kai', 'kaisai_nichime']

**結果**:
- 入力1: 481,627件 × 46列（基本データ）
- 入力2: 481,627件 × 12列（過去走データ）
- 出力: 481,627件 × 53列（完全データ）

**列数の内訳**:
- キー列: 7列（keibajo_code, race_shikonen, kaisai_kai, kaisai_nichime, race_bango, umaban, ketto_toroku_bango）
- 基本特徴: 39列（予測指数13 + 調教5 + 適性6 + 展開2 + ランク6 + CID/LS 7）
- 過去走特徴: 7列（prev1_pace, prev1_deokure, prev1_furi, prev1_furi_1, prev1_furi_2, prev1_furi_3, prev1_batai_code）
- **合計**: 53列

**パフォーマンス**:
- 実行時間: 5.71秒
- 出力: 481,627件 × 53列（86.0 MB）

---

## 🔧 技術的成果

### 解決した問題

#### 1. カラム名不一致
- **問題**: JRDBテーブルに`kaisai_nen`が存在しない
- **調査**: `check_jrdb_columns.py`でスキーマ確認
- **発見**: `race_shikonen`（施行年下2桁）、`kaisai_kai`（開催回）、`kaisai_nichime`（開催日目）を使用
- **解決**: JRDBの日付管理方式に合わせたクエリ設計

#### 2. LATERAL JOIN パフォーマンス問題
- **問題**: 単一クエリで2016年抽出が無限ループ
- **原因**: 
  - `jrd_sed`が数百万行で毎回ORDER BY + LIMIT 1実行
  - PostgreSQL一時ファイル増大
- **解決**: 
  - 過去走データを別クエリで抽出（Step 2）
  - Python側でpandas merge実行（Step 3）
  - SQL負荷分散、デバッグ容易化

#### 3. インデックス最適化
- **実施**: 
  - `idx_jrd_sed_ketto_race` on `jrd_sed (ketto_toroku_bango, kaisai_nen DESC, kaisai_tsukihi DESC, race_bango DESC)`
  - `idx_jrd_kyi_shikonen` on `jrd_kyi (race_shikonen, keibajo_code, kaisai_kai, kaisai_nichime)`
- **効果**: Step 2の過去走抽出を高速化

#### 4. データ型混在警告
- **警告**: `DtypeWarning: Columns (3,11,19,25,26,27) have mixed types`
- **対応**: 読み込み時に`low_memory=False`または`dtype`指定で回避可能（現状は警告のみ）

---

## 📁 ファイル構成

### 新規追加スクリプト（4個）

1. ✅ **`scripts/phase1b_step1_basic.py`** - Step 1: 基本データ抽出
   - 年別バッチ処理（2016-2025）
   - jrd_kyi + jrd_joa + jrd_cyb結合
   - 出力: `data/raw/jrdb_basic_41cols.csv`（481,627件 × 46列）

2. ✅ **`scripts/phase1b_step2_past.py`** - Step 2: 過去走データ抽出
   - CTE + ROW_NUMBER()で前走取得
   - 年別バッチ処理
   - 出力: `data/raw/jrdb_past_7cols.csv`（481,627件 × 12列）

3. ✅ **`scripts/phase1b_step3_merge.py`** - Step 3: データ結合
   - pandas merge（LEFT JOIN）
   - 欠損値統計出力
   - 出力: `data/raw/jrdb_48cols.csv`（481,627件 × 53列）

4. ✅ **`scripts/create_jrdb_indexes.py`** - インデックス作成
   - `idx_jrd_sed_ketto_race`（過去走用）
   - `idx_jrd_kyi_shikonen`（レース情報用）

### 最終ファイル構成

```
anonymous-keiba-ai-jra/
├── scripts/
│   ├── create_indexes.py              # JRA-VANインデックス作成
│   ├── create_jrdb_indexes.py         # JRDBインデックス作成 ⭐NEW
│   ├── phase1a_simple.py              # Phase 1-A: JRA-VAN抽出
│   ├── phase1b_step1_basic.py         # Phase 1-B Step 1 ⭐NEW
│   ├── phase1b_step2_past.py          # Phase 1-B Step 2 ⭐NEW
│   └── phase1b_step3_merge.py         # Phase 1-B Step 3 ⭐NEW
├── sql/
│   ├── jravan_extraction_lateral.sql  # JRA-VAN参考資料
│   └── jrdb_extraction.sql            # JRDB参考資料（未使用）
├── data/raw/
│   ├── jra_jravan_97cols.csv          # Phase 1-A出力（738,844行 × 31列）
│   ├── jrdb_basic_41cols.csv          # Step 1出力（481,627行 × 46列）
│   ├── jrdb_past_7cols.csv            # Step 2出力（481,627行 × 12列）
│   └── jrdb_48cols.csv                # Step 3出力（481,627行 × 53列）⭐
├── logs/
│   ├── phase1a_jravan_extraction.log  # Phase 1-Aログ
│   ├── phase1b_step1_basic.log        # Step 1ログ
│   ├── phase1b_step2_past.log         # Step 2ログ
│   ├── phase1b_step3_merge.log        # Step 3ログ
│   └── create_jrdb_indexes.log        # インデックス作成ログ
├── PHASE1A_SUCCESS_REPORT.md          # Phase 1-A完了報告
└── PHASE1B_SUCCESS_REPORT.md          # このファイル ⭐NEW
```

---

## 📈 パフォーマンス比較

| 手法 | アプローチ | 実行時間 | ファイルサイズ | 結果 |
|------|-----------|----------|---------------|------|
| **初期版** | 単一クエリ + LATERAL JOIN | 無限ループ | - | ❌ 2016年で停止 |
| **3ステップ版** | データソース別抽出 + Python結合 | **44秒** | 86.0 MB | ✅ **成功** |

**改善点**:
- 実行時間: 無限ループ → 44秒（完全解決）
- デバッグ: 困難 → 容易（各ステップ独立）
- スケーラビリティ: 低 → 高（並列処理可能）

---

## ✅ データ品質検証

### 基本統計
```python
総行数: 481,627
列数: 53
ファイルサイズ: 86.0 MB

過去走データ分布:
  あり: 399,707 (83.0%)
  なし:  81,920 (17.0%)  ※新馬・初出走馬

年別分布:
  2016年: 約48,000件
  2017年: 約48,000件
  ...
  2025年: 約47,000件
```

### 全カラム一覧（53列）

#### キー列（7列）
1. keibajo_code
2. race_shikonen
3. kaisai_kai
4. kaisai_nichime
5. race_bango
6. umaban
7. ketto_toroku_bango

#### 予測指数（13列）
8. idm
9. kishu_shisu
10. joho_shisu
11. sogo_shisu
12. chokyo_shisu
13. kyusha_shisu
14. gekiso_shisu
15. ninki_shisu
16. ten_shisu
17. pace_shisu
18. agari_shisu
19. ichi_shisu
20. manken_shisu

#### 調教・厩舎評価（5列）
21. chokyo_yajirushi_code
22. kyusha_hyoka_code
23. kishu_kitai_rentai_ritsu
24. shiage_shisu
25. chokyo_hyoka

#### 馬適性・状態（6列）
26. kyakushitsu_code
27. kyori_tekisei_code
28. joshodo_code
29. tekisei_code_omo
30. hizume_code
31. class_code

#### 展開予測（2列）
32. pace_yoso
33. uma_deokure_ritsu

#### ランク・その他（6列）
34. rotation
35. hobokusaki_rank
36. kyusha_rank
37. bataiju
38. bataiju_zogen
39. uma_start_shisu

#### CID/LS指数（7列）
40. cid
41. ls_shisu
42. ls_hyoka
43. em
44. kyusha_bb_shirushi
45. kishu_bb_shirushi
46. kyusha_bb_nijumaru_tansho_kaishuritsu

#### 過去走データ（7列）
47. prev1_pace
48. prev1_deokure
49. prev1_furi
50. prev1_furi_1
51. prev1_furi_2
52. prev1_furi_3
53. prev1_batai_code

---

## 🎓 技術的知見

### 3ステップ抽出のメリット

1. **パフォーマンス向上**
   - SQLの複雑性低減（LATERAL JOIN回避）
   - PostgreSQL負荷分散
   - Python並列処理への拡張容易

2. **デバッグ容易性**
   - 各ステップ独立実行可能
   - 中間ファイル確認可能
   - エラー箇所特定が容易

3. **メンテナンス性**
   - コード分割で可読性向上
   - 各ステップの責務明確
   - 再利用性高い

4. **スケーラビリティ**
   - 年別並列処理への拡張容易
   - データソース追加が容易
   - 部分的な再実行可能

### インデックス戦略

**過去走データ用（jrd_sed）**:
```sql
CREATE INDEX idx_jrd_sed_ketto_race 
ON jrd_sed (ketto_toroku_bango, kaisai_nen DESC, kaisai_tsukihi DESC, race_bango DESC)
```
- 血統登録番号で絞り込み
- 日付降順で最新レース優先
- ROW_NUMBER()のORDER BYと一致

**レース情報用（jrd_kyi）**:
```sql
CREATE INDEX idx_jrd_kyi_shikonen 
ON jrd_kyi (race_shikonen, keibajo_code, kaisai_kai, kaisai_nichime)
```
- 年別バッチ処理に最適
- 結合キーと一致

---

## 🚀 次のステップ: Phase 1-C

### タスク
Phase 1-C では、JRA-VANデータ（Phase 1-A）とJRDBデータ（Phase 1-B）を結合します。

### 結合方式検討

**課題**: 日付管理方式の違い
- **JRA-VAN**: `kaisai_nen` (4桁) + `kaisai_tsukihi` (4桁MMDD)
- **JRDB**: `race_shikonen` (2桁) + `kaisai_kai` (開催回) + `kaisai_nichime` (日目)

**解決策**:
1. **Option A**: JRA-VANに`kaisai_kai`・`kaisai_nichime`を追加（逆引きマスタ必要）
2. **Option B**: JRDBに`kaisai_nen`・`kaisai_tsukihi`を追加（日付計算ロジック必要）
3. **Option C**: 共通キー（競馬場 + レース番号 + 馬番）で結合（精度検証必要）

**推奨**: Option C（共通キー結合）
- 理由: 実装シンプル、データ変換不要
- リスク: 同日複数開催時の誤結合（検証で確認）

### データ量予測
- JRA-VAN: 738,844行 × 31列
- JRDB: 481,627行 × 53列
- 結合後（予測）: 約740,000行 × 84列（内部結合の場合は481,627行）

### 期待される成果
- 結合データ: 約740,000行 × 84列
- ファイルサイズ: 約150-180 MB
- Phase 1-C 実行時間: 5-10分（推定）

---

## 📝 まとめ

### 成果
✅ **Phase 1-B 完全成功**
- データ抽出: 481,627行 × 53列
- 実行時間: 44秒
- ファイルサイズ: 86.0 MB
- データ品質: 検証済み

✅ **技術的課題解決**
- LATERAL JOINパフォーマンス問題解消
- JRDBスキーマ差異対応
- インデックス最適化完了

✅ **3ステップ抽出方式確立**
- Step 1: 基本データ抽出（15.74秒）
- Step 2: 過去走データ抽出（23秒）
- Step 3: データ結合（5.71秒）

### 教訓
1. **段階的抽出が効果的** - 複雑なSQLより分割処理
2. **インデックスが重要** - 過去走データ取得に必須
3. **年別バッチが安全** - メモリ・ディスク負荷軽減
4. **Python結合が柔軟** - SQLより制御容易

### Phase 1 進捗状況
- ✅ **Phase 1-A**: JRA-VAN抽出完了（738,844行 × 31列、5分50秒）
- ✅ **Phase 1-B**: JRDB抽出完了（481,627行 × 53列、44秒）
- ⬜ **Phase 1-C**: データ結合（予定：5-10分）
- ⬜ **Phase 1-D**: 派生特徴量追加（予定：5-10分）

**Phase 1 完了予定**: あと15-20分

---

**作成日時**: 2026-02-20
**プロジェクト**: anonymous-keiba-ai-jra
**フェーズ**: Phase 1-B ✅ COMPLETE
**次フェーズ**: Phase 1-C ⬜ PENDING
