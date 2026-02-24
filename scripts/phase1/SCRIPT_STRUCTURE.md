# Phase 1 特徴量抽出スクリプト 骨格説明書

**作成日**: 2026-02-21  
**バージョン**: v1.0  
**対象**: `scripts/phase1/extract_jra_features_v1.py`

---

## 🏗️ スクリプト構造概要

### 📦 モジュール構成

```
extract_jra_features_v1.py (1,000行, 38KB)
│
├── [インポート]
│   ├── 標準ライブラリ: argparse, logging, sys, pathlib, datetime
│   ├── データ処理: yaml, psycopg2, pandas, numpy
│   └── 型ヒント: typing
│
├── [ログ設定]
│   └── setup_logging()
│
├── [データベース接続]
│   ├── load_db_config()
│   └── get_db_connection()
│
├── [競馬場季節コード]
│   └── generate_keibajo_season_code()
│
├── [A. 基礎情報系 24列]
│   └── extract_basic_features()
│
├── [B. 馬実績データ 14列]
│   └── extract_horse_performance_features()
│
├── [C. 過去走データ 58列]
│   └── extract_past_race_features()
│       ├── C-1. 高解像度（28列）
│       ├── C-2. 低解像度（18列）
│       └── C-3. コンテキスト（12列）
│
├── [D. ターゲット変数 1列]
│   └── add_target_variable()
│
├── [E. JRDB特徴量 41列]
│   └── extract_jrdb_features()
│
├── [G. JRDB過去走 7列]
│   └── extract_jrdb_past_race_features()
│
├── [F. 派生特徴量 3列]
│   └── add_derived_features()
│
├── [データ型最適化]
│   └── optimize_dtypes()
│
├── [欠損値レポート]
│   └── generate_missing_report()
│
├── [最終検証]
│   └── validate_features()
│
└── [メイン処理]
    └── main()
```

---

## 🔧 関数定義詳細

### 1️⃣ `setup_logging(log_dir: Path, keibajo_code: str) -> logging.Logger`

**目的**: ログ設定を初期化

**処理フロー**:
```
1. ログディレクトリ作成
2. タイムスタンプ付きログファイル名生成
3. ファイル・コンソール両方に出力設定
4. Loggerオブジェクトを返す
```

**出力**:
```
logs/extract_features_01_20260221_120000.log
```

---

### 2️⃣ `load_db_config(config_path: Path) -> Dict`

**目的**: YAMLからDB設定を読み込み

**処理フロー**:
```
1. db_config.yaml を開く
2. YAMLパース
3. 辞書として返す
```

**返り値**:
```python
{
    'jravan': {'host': 'localhost', 'port': 5432, 'database': 'jra_keiba', ...},
    'jrdb': {...}
}
```

---

### 3️⃣ `get_db_connection(config: Dict, db_type: str) -> psycopg2.connection`

**目的**: PostgreSQL接続を確立

**重要ポイント**:
```python
db_config['database'] = 'pckeiba'  # ★ 実DB名に自動修正
```

**処理フロー**:
```
1. configから指定タイプ（jravan/jrdb）の設定取得
2. database名を 'pckeiba' に上書き
3. psycopg2.connect() で接続
4. connectionオブジェクトを返す
```

---

### 4️⃣ `generate_keibajo_season_code(keibajo_code: str, kaisai_tsukihi: str) -> str`

**目的**: 小倉競馬場の季節分割

**ロジック**:
```python
if keibajo_code == '10':
    month = int(kaisai_tsukihi[:2])
    if month in [7, 8]:
        return '10_summer'
    elif month in [1, 2]:
        return '10_winter'
    else:
        return '10'  # 稀なケース
return keibajo_code
```

**出力例**:
| 入力 | 出力 |
|------|------|
| ('10', '0715') | '10_summer' |
| ('10', '0128') | '10_winter' |
| ('05', '1215') | '05' |

---

### 5️⃣ `extract_basic_features(conn, keibajo_code: str, start_year: int, end_year: int) -> pd.DataFrame`

**目的**: A. 基礎情報系特徴量を抽出（24列）

**SQL構造**:
```sql
SELECT 
    -- キー列（8列）
    ra.kaisai_nen, ra.kaisai_tsukihi, ra.keibajo_code, ...
    
    -- A-1. レース基本情報（7列）
    CAST(SUBSTRING(ra.kaisai_tsukihi, 1, 2) AS INTEGER) AS month,
    ra.kyori, ra.track_code, ra.grade_code, ...
    
    -- A-2. 馬場状態（2列）
    ra.babajotai_code_shiba, ra.babajotai_code_dirt,
    
    -- A-3. 馬基本情報（5列）
    se.seibetsu_code, se.barei, se.moshoku_code, ...
    
    -- A-4. 騎手・調教師（6列）
    se.kishu_code, se.chokyoshi_code, ...
    
    -- A-5. 装備・枠・負担重量（3列）
    se.blinker_shiyo_kubun, se.wakuban, se.futan_juryo,
    
    -- A-6. 馬主・生産者（2列）
    se.banushi_code, se.banushimei,
    
    -- ターゲット変数用
    se.kakutei_chakujun
    
FROM jvd_ra ra
INNER JOIN jvd_se se ON (
    ra.kaisai_nen = se.kaisai_nen AND ...
)
WHERE ra.keibajo_code = %s
  AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN %s AND %s
ORDER BY ra.kaisai_nen, ra.kaisai_tsukihi, ra.race_bango, se.umaban
```

**後処理**:
```python
df['keibajo_season_code'] = df.apply(
    lambda row: generate_keibajo_season_code(row['keibajo_code'], row['kaisai_tsukihi']),
    axis=1
)
```

**返り値**: DataFrame（24列 + キー列8列 + kakutei_chakujun）

---

### 6️⃣ `extract_horse_performance_features(conn, df_basic: pd.DataFrame) -> pd.DataFrame`

**目的**: B. 馬実績データ抽出（14列）

**SQL構造**:
```sql
SELECT 
    ketto_toroku_bango,
    
    -- B-1. 基本成績（2列）
    sogo, kyakushitsu_keiko,
    
    -- B-2. 馬場状態別着回数（8列）
    shiba_ryo, shiba_yayaomo, shiba_omo, shiba_furyo,
    dirt_ryo, dirt_yayaomo, dirt_omo, dirt_furyo,
    
    -- B-3. 距離別着回数（4列）
    shiba_1200_ika, shiba_1201_1400,
    dirt_1200_ika, dirt_1201_1400
    
FROM jvd_ck
WHERE ketto_toroku_bango = ANY(%s)
```

**処理フロー**:
```
1. df_basic から ユニークな ketto_toroku_bango を抽出
2. jvd_ck テーブルから該当馬のデータ取得
3. df_basic と LEFT JOIN
4. マージ結果を返す
```

---

### 7️⃣ `extract_past_race_features(conn, df_basic: pd.DataFrame) -> pd.DataFrame`

**目的**: C. 過去走データ抽出（58列）- パターンC+

**SQL構造（複雑・重要）**:

```sql
WITH target_races AS (
    -- 対象レース一覧
    SELECT DISTINCT
        se.ketto_toroku_bango, ra.kaisai_nen, ra.kaisai_tsukihi, ...
        ra.kyori AS current_kyori,
        ra.track_code AS current_track
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (...)
    WHERE se.ketto_toroku_bango = ANY(%s)
),
past_races AS (
    -- 過去走データ（ROW_NUMBER付き）
    SELECT 
        se.ketto_toroku_bango,
        se.kakutei_chakujun, se.soha_time, se.kohan_3f, se.corner_1, se.corner_4,
        se.bataiju, se.zogen_sa, se.time_sa,
        ra.kyori, ra.track_code, ra.babajotai_code_shiba, ra.babajotai_code_dirt,
        ra.keibajo_code AS past_keibajo,
        ROW_NUMBER() OVER (
            PARTITION BY se.ketto_toroku_bango 
            ORDER BY se.kaisai_nen DESC, se.kaisai_tsukihi DESC, se.race_bango DESC
        ) AS race_order  -- ★ LATERAL JOIN相当
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (...)
    WHERE se.ketto_toroku_bango = ANY(%s)
      AND se.kakutei_chakujun ~ '^[0-9]+$'  -- 着順確定レースのみ
)
SELECT 
    tr.ketto_toroku_bango, tr.kaisai_nen, ...,
    
    -- C-1. レイヤー1: 高解像度（前走: 14列）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.kakutei_chakujun::INTEGER END) AS prev1_rank,
    MAX(CASE WHEN pr.race_order = 1 THEN pr.soha_time::FLOAT END) AS prev1_time,
    ...
    
    -- C-1. レイヤー1: 高解像度（2走前: 14列）
    MAX(CASE WHEN pr.race_order = 2 THEN pr.kakutei_chakujun::INTEGER END) AS prev2_rank,
    ...
    
    -- C-2. レイヤー2: 低解像度（統計: 18列）
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_avg,
    MIN(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_best,
    STDDEV(...) AS past5_rank_std,
    SUM(CASE WHEN ... AND pr.kakutei_chakujun::INTEGER <= 3 THEN 1 ELSE 0 END)::FLOAT 
        / NULLIF(COUNT(...), 0) AS past5_top3_rate,
    
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.soha_time::FLOAT END) AS past5_time_avg,
    MIN(...) AS past5_time_best,
    
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kohan_3f::FLOAT END) AS past5_last3f_avg,
    MIN(...) AS past5_last3f_best,
    
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.bataiju::INTEGER END) AS past5_weight_avg,
    
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.corner_4::INTEGER END) AS past5_avg_position,
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.corner_1::INTEGER END) AS past5_early_speed,
    
    -- C-3. レイヤー3: コンテキスト（12列）
    AVG(CASE WHEN pr.race_order <= 10 AND pr.track_code = tr.current_track THEN pr.kakutei_chakujun::INTEGER END) AS same_track_type_avg_rank,
    COUNT(CASE WHEN pr.race_order <= 10 AND pr.track_code = tr.current_track THEN 1 END) AS same_track_type_count,
    
    AVG(CASE WHEN pr.race_order <= 10 AND ABS(pr.kyori::INTEGER - tr.current_kyori::INTEGER) <= 200 THEN pr.kakutei_chakujun::INTEGER END) AS same_distance_avg_rank,
    COUNT(...) AS same_distance_count,
    
    AVG(CASE WHEN pr.race_order <= 10 AND pr.past_keibajo = tr.keibajo_code THEN pr.kakutei_chakujun::INTEGER END) AS same_track_avg_rank,
    COUNT(...) AS same_track_count
    
FROM target_races tr
LEFT JOIN past_races pr ON tr.ketto_toroku_bango = pr.ketto_toroku_bango
GROUP BY tr.ketto_toroku_bango, tr.kaisai_nen, tr.kaisai_tsukihi, ...
```

**重要ポイント**:
1. `ROW_NUMBER()` でLATERAL JOIN相当を実現
2. `CASE WHEN race_order = N` で特定走次データ取得
3. `BETWEEN 1 AND 5` で過去5走統計
4. `race_order <= 10` でコンテキスト集計

---

### 8️⃣ `add_target_variable(df: pd.DataFrame) -> pd.DataFrame`

**目的**: D. ターゲット変数生成（1列）

**ロジック**:
```python
def calc_target(chakujun):
    if pd.isna(chakujun) or chakujun == '':
        return -1  # 未確定
    try:
        rank = int(chakujun)
        return 1 if rank <= 3 else 0
    except:
        return -1  # 取消・除外等

df['target_top3'] = df['kakutei_chakujun'].apply(calc_target)
```

**出力値**:
- `1`: 3着以内（正例）
- `0`: 4着以下（負例）
- `-1`: 未確定/取消/除外

---

### 9️⃣ `extract_jrdb_features(conn, df_basic: pd.DataFrame) -> pd.DataFrame`

**目的**: E. JRDB特徴量抽出（41列）

**SQL構造**:
```sql
SELECT 
    kyi.kaisai_nen, kyi.kaisai_tsukihi, kyi.keibajo_code, ...,
    
    -- E-1. 予測指数系（13列）
    kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu, kyi.chokyo_shisu,
    kyi.kyusha_shisu, kyi.gekiso_shisu, kyi.ninki_shisu, kyi.ten_shisu,
    kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu, kyi.manken_shisu,
    
    -- E-2. 調教・厩舎評価系（5列）
    kyi.chokyo_yajirushi_code, kyi.kyusha_hyoka_code, kyi.kishu_kitai_rentai_ritsu,
    cyb.shiage_shisu, cyb.chokyo_hyoka,
    
    -- E-3. 馬の適性・状態系（6列）
    kyi.kyakushitsu_code, kyi.kyori_tekisei_code, kyi.joshodo_code,
    kyi.tekisei_code_omo, kyi.hizume_code, kyi.class_code,
    
    -- E-4. 展開予想系（2列）
    kyi.pace_yoso, kyi.uma_deokure_ritsu,
    
    -- E-5. ランク・その他（6列）
    kyi.rotation, kyi.hobokusaki_rank, kyi.kyusha_rank,
    kyi.bataiju AS bataiju_jrdb, kyi.bataiju_zogen, kyi.uma_start_shisu,
    
    -- F. CID・LS指数系（7列）
    joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em,
    joa.kyusha_bb_shirushi, joa.kishu_bb_shirushi,
    joa.kyusha_bb_nijumaru_tansho_kaishuritsu
    
FROM jrd_kyi kyi
LEFT JOIN jrd_cyb cyb ON (kyi.kaisai_nen = cyb.kaisai_nen AND ...)
LEFT JOIN jrd_joa joa ON (kyi.kaisai_nen = joa.kaisai_nen AND ...)
WHERE kyi.keibajo_code = %s
  AND CAST(kyi.kaisai_nen AS INTEGER) BETWEEN %s AND %s
```

**JOIN戦略**: LEFT JOINで欠損を許容

---

### 🔟 `extract_jrdb_past_race_features(conn, df_basic: pd.DataFrame) -> pd.DataFrame`

**目的**: G. JRDB過去走特徴量抽出（7列）

**SQL構造**:
```sql
WITH past_races_jrdb AS (
    SELECT 
        sed.ketto_toroku_bango,
        sed.pace, sed.deokure, sed.furi, sed.furi_1, sed.furi_2, sed.furi_3, sed.batai_code,
        ROW_NUMBER() OVER (
            PARTITION BY sed.ketto_toroku_bango 
            ORDER BY sed.kaisai_nen DESC, sed.kaisai_tsukihi DESC, sed.race_bango DESC
        ) AS race_order
    FROM jrd_sed sed
    WHERE sed.ketto_toroku_bango = ANY(%s)
)
SELECT 
    tr.ketto_toroku_bango, ...,
    
    MAX(CASE WHEN race_order = 1 THEN pace END) AS prev1_pace,
    MAX(CASE WHEN race_order = 1 THEN deokure END) AS prev1_deokure,
    MAX(CASE WHEN race_order = 1 THEN furi END) AS prev1_furi,
    MAX(CASE WHEN race_order = 1 THEN furi_1 END) AS prev1_furi_1,
    MAX(CASE WHEN race_order = 1 THEN furi_2 END) AS prev1_furi_2,
    MAX(CASE WHEN race_order = 1 THEN furi_3 END) AS prev1_furi_3,
    MAX(CASE WHEN race_order = 1 THEN batai_code END) AS prev1_batai_code
    
FROM target_races tr
LEFT JOIN past_races_jrdb pr ON tr.ketto_toroku_bango = pr.ketto_toroku_bango
GROUP BY tr.ketto_toroku_bango, ...
```

---

### 1️⃣1️⃣ `add_derived_features(df: pd.DataFrame) -> pd.DataFrame`

**目的**: F. 派生特徴量生成（3列）

**処理**:
```python
# 距離増減（m）
df['distance_change'] = df['kyori'] - df['prev1_distance']

# トラック変更フラグ（0/1）
df['track_change'] = (df['track_code'] != df['prev1_track']).astype(int)

# クラス変更フラグ（仮実装）
df['class_change'] = (df['grade_code'] != '').astype(int)
```

---

### 1️⃣2️⃣ `optimize_dtypes(df: pd.DataFrame) -> pd.DataFrame`

**目的**: データ型最適化（メモリ削減）

**処理**:
```python
# カテゴリカル列 → category型
categorical_cols = ['keibajo_code', 'track_code', 'grade_code', ...]
for col in categorical_cols:
    if col in df.columns:
        df[col] = df[col].astype('category')

# 整数列 → Int32
int_cols = ['month', 'umaban', 'wakuban', ...]
for col in int_cols:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce').astype('Int32')

# 浮動小数点列 → float32
float_cols = ['futan_juryo', 'prev1_time', ...]
for col in float_cols:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce').astype('float32')
```

**効果**: メモリ使用量50-70%削減

---

### 1️⃣3️⃣ `generate_missing_report(df: pd.DataFrame, output_dir: Path)`

**目的**: 欠損値レポート生成

**処理**:
```python
missing_df = pd.DataFrame({
    'column': df.columns,
    'missing_count': df.isnull().sum().values,
    'missing_rate': (df.isnull().sum() / len(df) * 100).values
}).sort_values('missing_rate', ascending=False)

report_path = output_dir / 'missing_value_report.csv'
missing_df.to_csv(report_path, index=False, encoding='utf-8')
```

**出力**: `data/features/missing_value_report.csv`

---

### 1️⃣4️⃣ `validate_features(df: pd.DataFrame) -> bool`

**目的**: 最終検証

**チェック項目**:
```python
# 1. 列数チェック
if len(df.columns) < 140:
    return False

# 2. 行数チェック
if len(df) == 0:
    return False

# 3. target_top3の値チェック
if not set(df['target_top3'].unique()).issubset({-1, 0, 1}):
    return False

# 4. カテゴリ列の型チェック
categorical_cols = df.select_dtypes(include=['category']).columns

# 5. キー列のNULLチェック
key_cols = ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban']
for col in key_cols:
    if df[col].isnull().sum() > 0:
        return False

return True
```

---

### 1️⃣5️⃣ `main()`

**目的**: メイン処理フロー

**処理順序**:
```python
1. 引数パース（argparse）
2. パス設定（project_root, output_dir, log_dir）
3. ログ初期化
4. DB接続（JRA-VAN, JRDB）

5. [A] 基礎情報系抽出
6. [B] 馬実績データ抽出
7. [C] 過去走データ抽出
8. [D] ターゲット変数生成
9. [E] JRDB特徴量抽出
10. [G] JRDB過去走特徴量抽出
11. [F] 派生特徴量生成

12. データ型最適化
13. 欠損値レポート生成
14. 最終検証

15. 競馬場季節コードごとにCSV出力
16. DB接続クローズ
```

---

## 📊 データフロー図

```
[DB: pckeiba]
    ├── jvd_ra ──┐
    ├── jvd_se ──┼──> [A] 基礎情報系 (24列)
    ├── jvd_ck ──┼──> [B] 馬実績データ (14列)
    ├── jvd_se ──┼──> [C] 過去走データ (58列)
    │            │
    ├── jrd_kyi ─┼──> [E] JRDB特徴量 (41列)
    ├── jrd_cyb ─┤
    ├── jrd_joa ─┤
    └── jrd_sed ─┴──> [G] JRDB過去走 (7列)
                 │
                 ├──> [D] ターゲット変数 (1列)
                 ├──> [F] 派生特徴量 (3列)
                 │
                 ├──> optimize_dtypes()
                 ├──> generate_missing_report()
                 ├──> validate_features()
                 │
                 └──> [出力] CSV (148列)
                         ├── 01_2016-2025_features.csv
                         ├── 02_2016-2025_features.csv
                         ├── ...
                         ├── 10_summer_2016-2025_features.csv
                         └── 10_winter_2016-2025_features.csv
```

---

## 🔑 重要ポイントまとめ

### 1. LATERAL JOIN相当の実装

```sql
ROW_NUMBER() OVER (
    PARTITION BY ketto_toroku_bango 
    ORDER BY kaisai_nen DESC, kaisai_tsukihi DESC, race_bango DESC
) AS race_order
```

`race_order = 1` → 前走  
`race_order = 2` → 2走前  
`race_order BETWEEN 1 AND 5` → 過去5走

---

### 2. 小倉の季節分割

```python
if keibajo_code == '10':
    if month in [7, 8]:
        return '10_summer'
    elif month in [1, 2]:
        return '10_winter'
```

**出力**: 2つの独立したCSVファイル

---

### 3. データベース名の自動修正

```python
db_config['database'] = 'pckeiba'  # ★ 実DB名
```

---

### 4. データ型最適化

```python
category型: 50-70%メモリ削減
Int32: int64より50%削減
float32: float64より50%削減
```

---

### 5. 欠損値の扱い

- 過去走なし → NULL
- 新馬戦 → 全てNULL
- LightGBMがネイティブに処理

---

## 📝 TODO（改善予定）

### 高優先度
- [ ] 速度指数の正式実装
- [ ] EMA計算（α=0.3）
- [ ] days_since_last_race計算
- [ ] トレンド計算（speed, weight）
- [ ] 変動性計算（volatility）

### 中優先度
- [ ] 芝・ダート別実績（jvd_ck集計）
- [ ] 距離適性詳細
- [ ] 休養明け対応
- [ ] prev1_pace計算（前半-後半）
- [ ] class_change改善

---

**📅 作成日**: 2026-02-21  
**🎯 目標**: 148列の特徴量を生成し、Phase 2以降の機械学習モデル訓練に備える
