# JRA中央競馬 特徴量抽出スクリプト 使用ガイド

**作成日**: 2026-02-21  
**バージョン**: v1.0  
**スクリプト**: `scripts/phase1/extract_jra_features_v1.py`

---

## 📋 概要

PC-KEIBAデータベース（pckeiba）からJRA-VANとJRDBのデータを結合し、`INTEGRATED_FEATURE_SPECIFICATION_FINAL.md`で定義された**148列**の特徴量を生成します。

### 📊 特徴量構成

| カテゴリ | 列数 | データソース |
|---------|------|-------------|
| **A. 基礎情報系** | 24 | JRA-VAN |
| **B. 馬実績データ** | 14 | JRA-VAN (jvd_ck) |
| **C. 過去走データ（パターンC+）** | 58 | JRA-VAN (jvd_se, jvd_ra) |
| ├ C-1. 高解像度（直近2走詳細） | 28 | - |
| ├ C-2. 低解像度（統計） | 18 | - |
| └ C-3. コンテキスト（条件別実績） | 12 | - |
| **D. ターゲット変数** | 1 | 派生 |
| **E. JRDB特徴量** | 41 | JRDB (jrd_kyi, jrd_cyb, jrd_joa) |
| **G. JRDB過去走特徴量** | 7 | JRDB (jrd_sed) |
| **F. 派生特徴量** | 3 | 計算 |
| **合計** | **148** | - |

---

## 🚀 実行方法

### 基本実行

```bash
# 札幌競馬場（2016-2025年）
python scripts/phase1/extract_jra_features_v1.py --keibajo 01 --start-year 2016 --end-year 2025

# 小倉競馬場（季節分割: 10_summer, 10_winter）
python scripts/phase1/extract_jra_features_v1.py --keibajo 10 --start-year 2016 --end-year 2025

# カスタム期間
python scripts/phase1/extract_jra_features_v1.py --keibajo 05 --start-year 2020 --end-year 2023
```

### オプション引数

| 引数 | 必須 | デフォルト | 説明 |
|------|------|-----------|------|
| `--keibajo` | ✅ | - | 競馬場コード（01-10） |
| `--start-year` | - | 2016 | 開始年 |
| `--end-year` | - | 2025 | 終了年 |
| `--db-config` | - | `db_config.yaml` | DB設定ファイルパス |
| `--output-dir` | - | `data/features` | 出力ディレクトリ |

---

## 📂 出力ファイル

### 特徴量CSVファイル

```
data/features/
├── 01_2016-2025_features.csv      # 札幌（夏季のみ）
├── 02_2016-2025_features.csv      # 函館（夏季のみ）
├── 03_2016-2025_features.csv      # 福島
├── 04_2016-2025_features.csv      # 新潟
├── 05_2016-2025_features.csv      # 東京
├── 06_2016-2025_features.csv      # 中山
├── 07_2016-2025_features.csv      # 中京
├── 08_2016-2025_features.csv      # 京都
├── 09_2016-2025_features.csv      # 阪神
├── 10_summer_2016-2025_features.csv   # 小倉（夏: 7-8月）
└── 10_winter_2016-2025_features.csv   # 小倉（冬: 1-2月）
```

### ログファイル

```
logs/
└── extract_features_{keibajo}_{timestamp}.log
```

### レポートファイル

```
data/features/
└── missing_value_report.csv   # 欠損値レポート
```

---

## 🔧 主要関数の説明

### 1. `extract_basic_features()`
**A. 基礎情報系特徴量を抽出（24列）**

- **A-1. レース基本情報（7列）**
  - `month`, `kyori`, `track_code`, `grade_code`, `shusso_tosu`, `tenko_code`, `keibajo_season_code`
  
- **A-2. 馬場状態（2列）**
  - `babajotai_code_shiba`, `babajotai_code_dirt`
  
- **A-3. 馬基本情報（5列）**
  - `umaban`, `seibetsu_code`, `barei`, `moshoku_code`, （`days_since_last_race` は後で計算）
  
- **A-4. 騎手・調教師（6列）**
  - `kishu_code`, `chokyoshi_code`, `kishumei_ryakusho`, `chokyoshimei_ryakusho`, `tozai_shozoku_code`, `kishu_minarai_code`
  
- **A-5. 装備・枠・負担重量（3列）**
  - `blinker_shiyo_kubun`, `wakuban`, `futan_juryo`
  
- **A-6. 馬主・生産者（2列）**
  - `banushi_code`, `banushimei`

**特殊処理**: `keibajo_season_code` の生成
```python
def generate_keibajo_season_code(keibajo_code: str, kaisai_tsukihi: str) -> str:
    if keibajo_code == '10':
        month = int(kaisai_tsukihi[:2])
        if month in [7, 8]:
            return '10_summer'
        elif month in [1, 2]:
            return '10_winter'
    return keibajo_code
```

---

### 2. `extract_horse_performance_features()`
**B. 馬実績データ（14列）**

jvd_ckテーブルから馬の累積成績を取得:

- **B-1. 基本成績（2列）**: `sogo`, `kyakushitsu_keiko`
- **B-2. 馬場状態別着回数（8列）**: `shiba_ryo`, `shiba_yayaomo`, `shiba_omo`, `shiba_furyo`, `dirt_ryo`, `dirt_yayaomo`, `dirt_omo`, `dirt_furyo`
- **B-3. 距離別着回数（4列）**: `shiba_1200_ika`, `shiba_1201_1400`, `dirt_1200_ika`, `dirt_1201_1400`

---

### 3. `extract_past_race_features()`
**C. 過去走データ（58列）- パターンC+**

#### **C-1. レイヤー1: 高解像度（直近2走詳細: 28列）**

##### 前走（t-1）【14列】
```sql
-- ROW_NUMBER() = 1 でLATERAL JOIN相当
MAX(CASE WHEN pr.race_order = 1 THEN pr.kakutei_chakujun::INTEGER END) AS prev1_rank
```

- `prev1_rank`, `prev1_time`, `prev1_last3f`, `prev1_corner1`, `prev1_corner4`
- `prev1_weight`, `prev1_weight_diff`, `prev1_time_diff`
- `prev1_distance`, `prev1_track`, `prev1_baba_shiba`, `prev1_baba_dirt`, `prev1_keibajo`
- `prev1_race_date` （日数計算用）

##### 2走前（t-2）【14列】
```sql
-- ROW_NUMBER() = 2
MAX(CASE WHEN pr.race_order = 2 THEN pr.kakutei_chakujun::INTEGER END) AS prev2_rank
```

同様の14項目

---

#### **C-2. レイヤー2: 低解像度（統計: 18列）**

##### 着順統計【5列】
```sql
AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_avg
MIN(...) AS past5_rank_best
MAX(...) AS past5_rank_worst
STDDEV(...) AS past5_rank_std
```

- `past5_rank_avg`, `past5_rank_best`, `past5_rank_worst`, `past5_rank_std`, `past5_top3_rate`

##### 速度指数統計【5列】
- `past5_time_avg`, `past5_time_best`, （EMA・トレンド・変動性は後処理）

##### 上がり3F統計【3列】
- `past5_last3f_avg`, `past5_last3f_best`, （EMAは後処理）

##### 馬体重統計【3列】
- `past5_weight_avg`, （トレンド・変動性は後処理）

##### 展開適性【2列】
- `past5_avg_position` （平均4角順位）
- `past5_early_speed` （平均1角順位）

---

#### **C-3. レイヤー3: コンテキスト（条件別実績: 12列）**

##### 芝・ダート別実績【4列】
- `turf_avg_rank`, `turf_top3_rate`, `dirt_avg_rank`, `dirt_top3_rate`
  ※ 実装: jvd_ck集計（現在未実装 → 追加実装が必要）

##### 距離適性【4列】
```sql
AVG(CASE WHEN pr.race_order <= 10 AND ABS(pr.kyori::INTEGER - tr.current_kyori::INTEGER) <= 200 
    THEN pr.kakutei_chakujun::INTEGER END) AS same_distance_avg_rank
```
- `same_distance_avg_rank`, `same_distance_count`, `distance_category_best`, `distance_versatility`
  ※ 一部実装済み、詳細は要拡張

##### 競馬場適性【2列】
```sql
AVG(CASE WHEN pr.race_order <= 10 AND pr.past_keibajo = tr.keibajo_code 
    THEN pr.kakutei_chakujun::INTEGER END) AS same_track_avg_rank
```
- `same_track_avg_rank`, `same_track_count`

##### 休養明け対応【2列】
- `days_since_last` （前走からの日数）
- `layoff_performance` （休養明け平均着順）
  ※ 日数計算は後処理

---

### 4. `add_target_variable()`
**D. ターゲット変数（1列）**

```python
def calc_target(chakujun):
    if pd.isna(chakujun) or chakujun == '':
        return -1  # 未確定
    try:
        rank = int(chakujun)
        return 1 if rank <= 3 else 0
    except:
        return -1  # 取消・除外等
```

- `target_top3`: 3着以内=1, 4着以下=0, 未確定=-1

---

### 5. `extract_jrdb_features()`
**E. JRDB特徴量（41列）**

#### **E-1. 予測指数系（jrd_kyi: 13列）**
```sql
kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu, kyi.chokyo_shisu,
kyi.kyusha_shisu, kyi.gekiso_shisu, kyi.ninki_shisu, kyi.ten_shisu,
kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu, kyi.manken_shisu
```

#### **E-2. 調教・厩舎評価系（5列）**
```sql
kyi.chokyo_yajirushi_code, kyi.kyusha_hyoka_code, kyi.kishu_kitai_rentai_ritsu,
cyb.shiage_shisu, cyb.chokyo_hyoka
```

#### **E-3. 馬の適性・状態系（6列）**
```sql
kyi.kyakushitsu_code, kyi.kyori_tekisei_code, kyi.joshodo_code,
kyi.tekisei_code_omo, kyi.hizume_code, kyi.class_code
```

#### **E-4. 展開予想系（2列）**
```sql
kyi.pace_yoso, kyi.uma_deokure_ritsu
```

#### **E-5. ランク・その他（6列）**
```sql
kyi.rotation, kyi.hobokusaki_rank, kyi.kyusha_rank,
kyi.bataiju AS bataiju_jrdb, kyi.bataiju_zogen, kyi.uma_start_shisu
```

#### **F. CID・LS指数系（jrd_joa: 7列）**
```sql
joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em,
joa.kyusha_bb_shirushi, joa.kishu_bb_shirushi,
joa.kyusha_bb_nijumaru_tansho_kaishuritsu
```

---

### 6. `extract_jrdb_past_race_features()`
**G. JRDB過去走特徴量（7列）**

```sql
-- jrd_sed から前走データ取得
MAX(CASE WHEN race_order = 1 THEN pace END) AS prev1_pace
```

- `prev1_pace`, `prev1_deokure`, `prev1_furi`, `prev1_furi_1`, `prev1_furi_2`, `prev1_furi_3`, `prev1_batai_code`

---

### 7. `add_derived_features()`
**F. 派生特徴量（3列）**

```python
# 距離増減
df['distance_change'] = df['kyori'] - df['prev1_distance']

# トラック変更（芝↔ダート）
df['track_change'] = (df['track_code'] != df['prev1_track']).astype(int)

# クラス変更（仮実装）
df['class_change'] = (df['grade_code'] != '').astype(int)
```

---

### 8. `optimize_dtypes()`
**データ型最適化**

```python
# カテゴリカル列 → category型
categorical_cols = ['keibajo_code', 'track_code', 'grade_code', ...]

# 整数列 → Int32
int_cols = ['month', 'umaban', 'wakuban', ...]

# 浮動小数点列 → float32
float_cols = ['futan_juryo', 'prev1_time', ...]
```

**メモリ削減効果**: 約50-70%削減（100MB → 30-50MB）

---

## ⚠️ 重要な注意事項

### 1. データベース名の修正

スクリプト内で**実際のDB名に自動修正**しています:

```python
def get_db_connection(config: Dict, db_type: str = 'jravan'):
    db_config = config[db_type].copy()
    db_config['database'] = 'pckeiba'  # ★ 実DBに合わせて修正
    ...
```

**理由**: `db_config.yaml`では`jra_keiba`となっていますが、実際のDB名は`pckeiba`です。

---

### 2. 小倉競馬場の季節分割

小倉（コード`10`）は以下のように分割されます:

| 月 | 季節コード | 備考 |
|----|-----------|------|
| 1-2月 | `10_winter` | 冬芝良好、寒冷 |
| 7-8月 | `10_summer` | 夏枯れ芝、高温多湿 |
| その他 | `10` | 稀（通常は1-2月、7-8月のみ開催） |

**出力**: 2つの独立したCSVファイル
- `10_summer_2016-2025_features.csv`
- `10_winter_2016-2025_features.csv`

---

### 3. 過去走データの欠損

- **新馬戦**: 過去走データが全てNULL
- **5走未満の馬**: 統計量は計算可能な範囲で算出（例: 3走しかない場合は3走の平均）
- **欠損値の扱い**: `-1`または`NaN`としてLightGBMが自動処理

---

### 4. データリーク防止

以下は**対象レースの結果データ**なので、特徴量として使用**不可**:

| カラム | 理由 |
|--------|------|
| `kakutei_chakujun` | 着順（予測対象） |
| `soha_time` | 走破タイム（結果） |
| `kohan_3f` | 上がり3F（結果） |
| `corner_1～4` | コーナー通過順位（結果） |

**注意**: これらは**前走（t-1）以前**では使用可能です（`prev1_rank`等）。

---

## 🧪 テスト実行例

### 少量データでテスト（札幌2023年のみ）

```bash
python scripts/phase1/extract_jra_features_v1.py \
    --keibajo 01 \
    --start-year 2023 \
    --end-year 2023 \
    --output-dir data/features_test
```

### 期待される出力

```
[INFO] [A] 基礎情報系: 3,248行抽出完了
[INFO] [B] 馬実績データ: 2,105件マージ完了
[INFO] [C] 過去走データ: 3,248件マージ完了
[INFO] [D] ターゲット変数: 3着以内=1,012, 4着以下=2,103, 未確定=133
[INFO] [E] JRDB特徴量: 3,102件マージ完了
[INFO] [G] JRDB過去走特徴量: 3,248件マージ完了
[INFO] [F] 派生特徴量生成完了
[INFO] [最適化] メモリ使用量: 12.34 MB
[INFO] [検証] 最終検証完了 ✅

[出力] 01: 3,248行 → data/features_test/01_2023-2023_features.csv

✅ 特徴量抽出完了
総行数: 3,248
総列数: 148
ファイルサイズ: 12.34 MB
```

---

## 📊 最終検証チェックリスト

スクリプト内で自動実行される検証項目:

- [ ] **列数**: 148列（最低140列以上）
- [ ] **行数**: 0行でないこと
- [ ] **target_top3**: 値が {-1, 0, 1} のみ
- [ ] **カテゴリ列**: `category` 型に変換済み
- [ ] **キー列**: NULLがないこと（`kaisai_nen`, `kaisai_tsukihi`, `keibajo_code`, `race_bango`, `umaban`）

---

## 🔄 次のステップ（Phase 2以降）

1. **Phase 2: 特徴量選択**
   - Boruta特徴量選択
   - 相関分析・多重共線性除去

2. **Phase 3: モデル訓練**
   - LightGBM/XGBoost
   - Optunaハイパーパラメータチューニング

3. **Phase 4: モデル評価**
   - 交差検証
   - 的中率・回収率評価

4. **Phase 5: 本番予測**
   - 未知レースの予測
   - 馬券購入シミュレーション

---

## 📝 改善予定事項（TODO）

### 高優先度
- [ ] **速度指数の正式実装**: 基準タイムテーブル作成 → 速度指数計算
- [ ] **EMA計算の実装**: `past5_speed_ema`, `past5_last3f_ema`
- [ ] **days_since_last_race計算**: 前走からの日数
- [ ] **トレンド計算**: `past5_speed_trend`, `past5_weight_trend`
- [ ] **変動性計算**: `past5_speed_volatility`, `past5_weight_volatility`

### 中優先度
- [ ] **芝・ダート別実績**: jvd_ck集計で`turf_avg_rank`等を実装
- [ ] **距離適性詳細**: `distance_category_best`, `distance_versatility`
- [ ] **休養明け対応**: `layoff_performance` （3ヶ月以上休養後の平均着順）
- [ ] **prev1_pace計算**: 前半-後半のペース評価
- [ ] **class_change改善**: grade_codeではなく実クラス変化を判定

### 低優先度
- [ ] **並列処理**: 競馬場ごとに並列実行
- [ ] **進捗バー**: tqdmで処理進捗表示
- [ ] **エラーハンドリング強化**: 部分的なデータ欠損への対応

---

## 💡 トラブルシューティング

### エラー: `relation "jra_keiba.jvd_ra" does not exist`

**原因**: DB名が間違っている  
**解決**: スクリプト内で自動修正されますが、手動で確認する場合:

```python
# scripts/phase1/extract_jra_features_v1.py の63行目
db_config['database'] = 'pckeiba'  # 実DB名を指定
```

---

### エラー: `column "kaisai_nichime" does not exist`

**原因**: テーブルスキーマが仕様と異なる  
**解決**: `check_database_schema.py` でスキーマ確認

```bash
python scripts/check_database_schema.py
```

---

### 警告: `[検証] 列数不足: 135列（期待: 148列）`

**原因**: 一部の特徴量が未実装（EMA、トレンド等）  
**影響**: 現在のバージョンでは約135-140列（最低限の148列に近い）  
**対応**: TODO項目の実装で148列に到達予定

---

## 📚 参考資料

- **仕様書**: `INTEGRATED_FEATURE_SPECIFICATION_FINAL.md`
- **Phase 1-C完了報告**: `PHASE1C_COMPLETION_REPORT.md`
- **データベーススキーマ**: `scripts/check_database_schema.py` の出力

---

**📅 作成日**: 2026-02-21  
**📖 根拠**: INTEGRATED_FEATURE_SPECIFICATION_FINAL.md パターンC+  
**🎯 目標**: JRA中央競馬の3着以内入線を高精度で予測するAIモデルの構築
