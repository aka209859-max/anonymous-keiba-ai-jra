# 地方競馬版 vs JRA中央競馬版 特徴量抽出スクリプト比較

**作成日**: 2026-02-21  
**目的**: 地方競馬版スクリプトとJRA版スクリプトの構造比較と改善提案

---

## 📊 スクリプト比較表

| 項目 | 地方競馬版 (`extract_training_data_v2.py`) | JRA中央競馬版 (`extract_jra_features_v1.py`) |
|------|-------------------------------------------|---------------------------------------------|
| **ファイルサイズ** | 456行, 16.7KB | 1,000行, 38KB |
| **特徴量数** | 約40-50列 | **148列** |
| **データソース** | nvd_ra, nvd_se, nvd_um | jvd_ra, jvd_se, jvd_ck, jrd_kyi, jrd_cyb, jrd_joa, jrd_sed |
| **過去走データ** | 前走〜5走前（基本情報のみ） | **パターンC+**: 3層構造（高解像度28列 + 統計18列 + コンテキスト12列） |
| **JRDB統合** | ❌ なし | ✅ あり（48列） |
| **競馬場分割** | ❌ なし | ✅ 小倉季節分割（10_summer, 10_winter） |
| **DB名修正** | ❌ なし | ✅ 自動修正（jra_keiba → pckeiba） |
| **データ型最適化** | ❌ 基本的な型変換のみ | ✅ category型、Int32、float32（メモリ50-70%削減） |
| **欠損値レポート** | ❌ コンソール出力のみ | ✅ CSV出力 |
| **最終検証** | ❌ なし | ✅ 列数・行数・target値・カテゴリ型確認 |
| **ドキュメント** | ❌ Docstringのみ | ✅ README + SCRIPT_STRUCTURE（合計39KB） |

---

## 🔧 地方競馬版の構造（シンプル版）

### 1. **SQL構造**

```sql
WITH target_race AS (
    -- 予測対象レース
    SELECT ra.*, se.*, um.moshoku_code
    FROM nvd_ra ra
    INNER JOIN nvd_se se ON (6キー結合)
    LEFT JOIN nvd_um um ON (血統登録番号)
    WHERE 着順確定済み
),
past_races AS (
    -- 過去走データ（ROW_NUMBER使用）
    SELECT 
        se.ketto_toroku_bango,
        se.kakutei_chakujun, se.soha_time, se.kohan_3f, ...
        ROW_NUMBER() OVER (
            PARTITION BY se.ketto_toroku_bango 
            ORDER BY se.kaisai_nen DESC, ...
        ) AS race_order
    FROM nvd_se se
    INNER JOIN target_race tr ON se.ketto_toroku_bango = tr.ketto_toroku_bango
    WHERE (当該レースより前) AND 着順確定済み
)
SELECT 
    -- ターゲット変数
    CASE WHEN tr.kakutei_chakujun::INTEGER <= 3 THEN 1 ELSE 0 END AS target,
    
    -- レース識別子
    tr.kaisai_nen, tr.kaisai_tsukihi, tr.keibajo_code, tr.race_bango, ...
    
    -- レース情報
    tr.kyori, tr.track_code, tr.babajotai_code_shiba, ...
    
    -- 出馬情報
    tr.wakuban, tr.seibetsu_code, tr.barei, ...
    
    -- 前走（14列）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.kakutei_chakujun END) AS prev1_rank,
    MAX(CASE WHEN pr.race_order = 1 THEN pr.soha_time END) AS prev1_time,
    ...
    
    -- 2走前（6列）
    MAX(CASE WHEN pr.race_order = 2 THEN pr.kakutei_chakujun END) AS prev2_rank,
    ...
    
    -- 3走前（3列）、4走前（2列）、5走前（2列）
    
FROM target_race tr
LEFT JOIN past_races pr ON tr.ketto_toroku_bango = pr.ketto_toroku_bango AND pr.race_order <= 5
GROUP BY tr.*
```

**特徴**:
- ✅ シンプルで理解しやすい
- ✅ ROW_NUMBER()で過去走取得
- ❌ 過去走は基本情報のみ（統計量なし）
- ❌ JRDB統合なし
- ❌ 馬実績データ（jvd_ck相当）なし

---

### 2. **Python構造**

```python
# グローバル設定
DB_CONFIG = {...}
LOCAL_KEIBAJO_CODES = ['30', '33', ...]

# 関数構成
def create_query_with_past_races()  # SQLクエリ生成
def connect_db()                     # DB接続
def extract_data()                   # データ抽出
def preprocess_data()                # 前処理
def save_csv()                       # CSV保存
def main()                           # メイン処理
```

**特徴**:
- ✅ 1ファイル完結
- ✅ シンプルな構造
- ❌ 関数分割が少ない（モジュール化不足）
- ❌ ログ設定が簡易的

---

## 🚀 JRA中央競馬版の構造（高機能版）

### 1. **SQL構造（複雑だが高機能）**

#### A. 基礎情報系（24列）
```sql
SELECT 
    -- A-1. レース基本情報（7列）
    CAST(SUBSTRING(ra.kaisai_tsukihi, 1, 2) AS INTEGER) AS month,
    ra.kyori, ra.track_code, ra.grade_code, ...
    
    -- A-2. 馬場状態（2列）
    -- A-3. 馬基本情報（5列）
    -- A-4. 騎手・調教師（6列）
    -- A-5. 装備・枠・負担重量（3列）
    -- A-6. 馬主・生産者（2列）
FROM jvd_ra ra
INNER JOIN jvd_se se ON (6キー結合)
```

#### B. 馬実績データ（14列）
```sql
SELECT 
    sogo, kyakushitsu_keiko,
    shiba_ryo, shiba_yayaomo, shiba_omo, shiba_furyo,
    dirt_ryo, dirt_yayaomo, dirt_omo, dirt_furyo,
    shiba_1200_ika, shiba_1201_1400, dirt_1200_ika, dirt_1201_1400
FROM jvd_ck
WHERE ketto_toroku_bango = ANY(%s)
```

#### C. 過去走データ（58列）- パターンC+

##### C-1. 高解像度（28列）
```sql
-- 前走（14列）+ 2走前（14列）
MAX(CASE WHEN pr.race_order = 1 THEN pr.kakutei_chakujun::INTEGER END) AS prev1_rank,
MAX(CASE WHEN pr.race_order = 1 THEN pr.soha_time::FLOAT END) AS prev1_time,
MAX(CASE WHEN pr.race_order = 1 THEN pr.kohan_3f::FLOAT END) AS prev1_last3f,
MAX(CASE WHEN pr.race_order = 1 THEN pr.corner_1::INTEGER END) AS prev1_corner1,
MAX(CASE WHEN pr.race_order = 1 THEN pr.corner_4::INTEGER END) AS prev1_corner4,
MAX(CASE WHEN pr.race_order = 1 THEN pr.bataiju::INTEGER END) AS prev1_weight,
MAX(CASE WHEN pr.race_order = 1 THEN pr.zogen_sa::INTEGER END) AS prev1_weight_diff,
MAX(CASE WHEN pr.race_order = 1 THEN pr.time_sa::FLOAT END) AS prev1_time_diff,
MAX(CASE WHEN pr.race_order = 1 THEN pr.kyori::INTEGER END) AS prev1_distance,
MAX(CASE WHEN pr.race_order = 1 THEN pr.track_code END) AS prev1_track,
MAX(CASE WHEN pr.race_order = 1 THEN pr.babajotai_code_shiba END) AS prev1_baba_shiba,
MAX(CASE WHEN pr.race_order = 1 THEN pr.babajotai_code_dirt END) AS prev1_baba_dirt,
MAX(CASE WHEN pr.race_order = 1 THEN pr.past_keibajo END) AS prev1_keibajo,
MAX(CASE WHEN pr.race_order = 1 THEN pr.race_date END) AS prev1_race_date,

-- 2走前（同様の14列）
MAX(CASE WHEN pr.race_order = 2 THEN ... END) AS prev2_*,
```

##### C-2. 低解像度（統計: 18列）
```sql
-- 着順統計（5列）
AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_avg,
MIN(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_best,
MAX(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_worst,
STDDEV(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_std,
SUM(CASE WHEN pr.race_order BETWEEN 1 AND 5 AND pr.kakutei_chakujun::INTEGER <= 3 THEN 1 ELSE 0 END)::FLOAT 
    / NULLIF(COUNT(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN 1 END), 0) AS past5_top3_rate,

-- 速度指数統計（5列）
AVG(...) AS past5_time_avg,
MIN(...) AS past5_time_best,
-- EMA, トレンド, 変動性は後処理

-- 上がり3F統計（3列）
AVG(...) AS past5_last3f_avg,
MIN(...) AS past5_last3f_best,

-- 馬体重統計（3列）
AVG(...) AS past5_weight_avg,

-- 展開適性（2列）
AVG(...) AS past5_avg_position,
AVG(...) AS past5_early_speed,
```

##### C-3. コンテキスト（条件別実績: 12列）
```sql
-- 芝・ダート別実績（4列）
AVG(CASE WHEN pr.race_order <= 10 AND pr.track_code = tr.current_track THEN pr.kakutei_chakujun::INTEGER END) AS same_track_type_avg_rank,
COUNT(...) AS same_track_type_count,

-- 距離適性（4列）
AVG(CASE WHEN pr.race_order <= 10 AND ABS(pr.kyori::INTEGER - tr.current_kyori::INTEGER) <= 200 THEN pr.kakutei_chakujun::INTEGER END) AS same_distance_avg_rank,
COUNT(...) AS same_distance_count,

-- 競馬場適性（2列）
AVG(CASE WHEN pr.race_order <= 10 AND pr.past_keibajo = tr.keibajo_code THEN pr.kakutei_chakujun::INTEGER END) AS same_track_avg_rank,
COUNT(...) AS same_track_count,

-- 休養明け対応（2列）
-- days_since_last, layoff_performance は後処理
```

#### E. JRDB特徴量（41列）
```sql
SELECT 
    -- E-1. 予測指数系（13列）
    kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu, ...
    
    -- E-2. 調教・厩舎評価系（5列）
    kyi.chokyo_yajirushi_code, kyi.kyusha_hyoka_code, ...
    
    -- E-3. 馬の適性・状態系（6列）
    kyi.kyakushitsu_code, kyi.kyori_tekisei_code, ...
    
    -- E-4. 展開予想系（2列）
    kyi.pace_yoso, kyi.uma_deokure_ritsu,
    
    -- E-5. ランク・その他（6列）
    kyi.rotation, kyi.hobokusaki_rank, ...
    
    -- F. CID・LS指数系（7列）
    joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em, ...
    
FROM jrd_kyi kyi
LEFT JOIN jrd_cyb cyb ON (...)
LEFT JOIN jrd_joa joa ON (...)
```

#### G. JRDB過去走（7列）
```sql
SELECT 
    MAX(CASE WHEN race_order = 1 THEN pace END) AS prev1_pace,
    MAX(CASE WHEN race_order = 1 THEN deokure END) AS prev1_deokure,
    MAX(CASE WHEN race_order = 1 THEN furi END) AS prev1_furi,
    MAX(CASE WHEN race_order = 1 THEN furi_1 END) AS prev1_furi_1,
    MAX(CASE WHEN race_order = 1 THEN furi_2 END) AS prev1_furi_2,
    MAX(CASE WHEN race_order = 1 THEN furi_3 END) AS prev1_furi_3,
    MAX(CASE WHEN race_order = 1 THEN batai_code END) AS prev1_batai_code
FROM jrd_sed sed
```

---

### 2. **Python構造（モジュール化）**

```python
# 15個の関数（明確な役割分担）
1. setup_logging()                           # ログ設定
2. load_db_config()                          # DB設定読み込み
3. get_db_connection()                       # DB接続
4. generate_keibajo_season_code()            # 小倉季節分割

5. extract_basic_features()                  # A. 基礎情報系 (24列)
6. extract_horse_performance_features()      # B. 馬実績データ (14列)
7. extract_past_race_features()              # C. 過去走データ (58列)
8. add_target_variable()                     # D. ターゲット変数 (1列)
9. extract_jrdb_features()                   # E. JRDB特徴量 (41列)
10. extract_jrdb_past_race_features()        # G. JRDB過去走 (7列)
11. add_derived_features()                   # F. 派生特徴量 (3列)

12. optimize_dtypes()                        # データ型最適化
13. generate_missing_report()                # 欠損値レポート
14. validate_features()                      # 最終検証
15. main()                                   # メイン処理
```

**特徴**:
- ✅ 高度なモジュール化
- ✅ 各関数が1つの責務
- ✅ 詳細なログ出力
- ✅ 包括的なドキュメント

---

## 🔑 重要な違い

### 1. **過去走データの深度**

| 項目 | 地方競馬版 | JRA版 |
|------|-----------|-------|
| **前走** | 14列 | 14列（同等） |
| **2走前** | 6列 | 14列（詳細化） |
| **3走前** | 3列 | - |
| **4走前** | 2列 | - |
| **5走前** | 2列 | - |
| **過去5走統計** | ❌ なし | ✅ 18列（平均、最高、標準偏差、連対率、EMA等） |
| **コンテキスト** | ❌ なし | ✅ 12列（芝・ダート、距離、競馬場、休養明け） |
| **合計** | 27列 | **58列** |

**JRA版の優位性**:
- **統計的特徴量**: 平均、標準偏差、EMA → 安定性・トレンド把握
- **コンテキスト**: 条件別実績 → ドメイン知識を反映

---

### 2. **JRDB統合**

| 項目 | 地方競馬版 | JRA版 |
|------|-----------|-------|
| **JRDB** | ❌ なし | ✅ 48列（予測指数、調教評価、適性、展開予想、CID・LS指数、過去走） |

**JRA版の優位性**:
- **専門家の知見**: IDM、騎手指数、調教指数、総合指数等
- **調教データ**: 仕上指数、調教評価
- **適性評価**: 脚質、距離適性、上昇度
- **展開予想**: ペース予想、出遅れ率

---

### 3. **データ型最適化**

| 項目 | 地方競馬版 | JRA版 |
|------|-----------|-------|
| **最適化** | 基本的な型変換 | category型、Int32、float32 |
| **メモリ削減** | - | **50-70%削減** (100MB → 30-50MB) |

**JRA版の優位性**:
- 大規模データセット対応
- メモリ効率向上
- 処理速度向上

---

### 4. **小倉競馬場の季節分割**

| 項目 | 地方競馬版 | JRA版 |
|------|-----------|-------|
| **季節分割** | ❌ なし | ✅ 10_summer (7-8月), 10_winter (1-2月) |

**理由**:
- 小倉は夏（夏枯れ芝）と冬（冬芝良好）で特性が大きく異なる
- 11競馬場として独立して扱うことで予測精度向上

---

## 📈 どちらを選ぶべきか？

### **地方競馬版（シンプル版）が適している場合**

✅ **こんな場合におすすめ**:
- 初めて機械学習モデルを構築する
- データ量が少ない（数万〜数十万行）
- シンプルな特徴量で十分
- JRDBデータがない
- 実装速度を重視

✅ **メリット**:
- コード量が少なく理解しやすい
- 実装が早い（1ファイル完結）
- デバッグが容易

❌ **デメリット**:
- 特徴量が少ない（精度が頭打ち）
- JRDB統合なし
- 統計的特徴量なし
- メモリ最適化なし

---

### **JRA中央競馬版（高機能版）が適している場合**

✅ **こんな場合におすすめ**:
- 高精度な予測モデルを構築したい
- データ量が大きい（数十万〜数百万行）
- 複雑な特徴量が必要
- JRDBデータがある
- 本番運用を見据えている

✅ **メリット**:
- **特徴量が豊富**（148列 vs 40-50列）
- **JRDB統合**（専門家の知見を活用）
- **統計的特徴量**（安定性・トレンド把握）
- **メモリ最適化**（大規模データ対応）
- **包括的なドキュメント**

❌ **デメリット**:
- コード量が多い（理解に時間がかかる）
- 実装が複雑
- デバッグが難しい

---

## 🎯 推奨アプローチ

### **Phase 1（初期実装）**: 地方競馬版スタイル

```
1. シンプルな特徴量で迅速にモデル構築
2. ベースライン精度を確立
3. 問題点を洗い出し
```

### **Phase 2（高度化）**: JRA中央競馬版スタイル

```
1. 統計的特徴量追加（過去5走統計）
2. JRDB統合
3. コンテキスト特徴量追加
4. データ型最適化
```

### **Phase 3（最適化）**: ハイブリッド

```
1. Boruta特徴量選択で重要な特徴量のみ残す
2. 不要な特徴量を削除してシンプル化
3. 本番運用に向けた最適化
```

---

## 📝 まとめ

| 項目 | 地方競馬版 | JRA中央競馬版 | 勝者 |
|------|-----------|---------------|------|
| **シンプルさ** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 地方 |
| **特徴量の豊富さ** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | **JRA** |
| **予測精度の上限** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | **JRA** |
| **実装速度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 地方 |
| **メモリ効率** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | **JRA** |
| **ドキュメント** | ⭐⭐ | ⭐⭐⭐⭐⭐ | **JRA** |
| **保守性** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | **JRA** |

---

**🏆 結論**: 
- **迅速な実装が必要** → 地方競馬版
- **高精度な予測が必要** → **JRA中央競馬版（推奨）**

---

**📅 作成日**: 2026-02-21  
**📖 参考**: extract_training_data_v2.py (地方競馬版), extract_jra_features_v1.py (JRA版)
