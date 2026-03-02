# JRA中央競馬 AI予測モデル 統合特徴量仕様書（最終版）

**📅 作成日**: 2026-02-19  
**📖 根拠**: ディープサーチレポート『中央競馬（JRA）におけるAI予測モデルの最適化』パターンC+推奨  
**📄 ステータス**: 開発実装用最終確定版  
**🎯 対象**: 開発AI・実装エンジニア向け

---

## 🎯 **仕様概要**

### **競馬場コード定義（11競馬場 + 小倉季節分割）**

| コード | 競馬場名 | 開催時期 | 特徴量用識別子 | 備考 |
|--------|----------|----------|----------------|------|
| 01 | 札幌 | 夏季（6月-8月） | `keibajo_season_code='01'` | 北海道、涼しい気候 |
| 02 | 函館 | 夏季（6月-8月） | `keibajo_season_code='02'` | 北海道、夏季のみ |
| 03 | 福島 | 春・夏季 | `keibajo_season_code='03'` | 東北、芝が良好 |
| 04 | 新潟 | 夏季 | `keibajo_season_code='04'` | 直線が長い |
| 05 | 東京 | 通年 | `keibajo_season_code='05'` | 府中、最多G1開催 |
| 06 | 中山 | 通年 | `keibajo_season_code='06'` | 船橋、急坂有り |
| 07 | 中京 | 通年 | `keibajo_season_code='07'` | 豊明、年間開催増 |
| 08 | 京都 | 春・秋季 | `keibajo_season_code='08'` | 京都、G1多数 |
| 09 | 阪神 | 通年 | `keibajo_season_code='09'` | 宝塚、関西メイン |
| **10_summer** | **小倉（夏）** | **7月-8月** | **`keibajo_season_code='10_summer'`** | **夏枯れ芝、高温多湿** |
| **10_winter** | **小倉（冬）** | **1月-2月** | **`keibajo_season_code='10_winter'`** | **冬芝良好、寒冷** |

**季節分割SQL例（小倉の場合）**:
```sql
CASE 
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi,1,2) AS INTEGER) IN (7,8) THEN '10_summer'
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi,1,2) AS INTEGER) IN (1,2) THEN '10_winter'
    ELSE keibajo_code
END AS keibajo_season_code
```

---

### **総次元数**

| 項目 | 数値 | 備考 |
|---|---|---|
| **競馬場数（季節分割後）** | **11** | 小倉を夏・冬で分割 |
| **特徴量数** | **148** | JRA-VAN 97 + JRDB 48 + 派生3 |
| **総次元数** | **11 × 148 = 1,628次元** | LightGBMで扱える範囲 |

---

## 📊 **特徴量内訳サマリー**

| データソース | カテゴリ | カラム数 | 小計 |
|---|---|---|---|
| **JRA-VAN** | | | **97** |
| | 基礎情報系 | 24 | |
| | 馬実績データ（jvd_ck） | 14 | |
| | 過去走データ（パターンC+） | 58 | |
| | ターゲット変数 | 1 | |
| **JRDB** | | | **48** |
| | 予測指数系（jrd_kyi） | 13 | |
| | 調教・厩舎評価系（jrd_kyi, jrd_cyb） | 5 | |
| | 馬の適性・状態系（jrd_kyi） | 6 | |
| | 展開予想系（jrd_kyi） | 2 | |
| | ランク・その他（jrd_kyi） | 6 | |
| | CID・LS指数系（jrd_joa） | 7 | |
| | 調教データB（jrd_cyb） | 2 | |
| | 過去走用（jrd_sed） | 7 | |
| **派生特徴量** | | | **3** |
| | 距離増減系 | 3 | |
| **総合計** | | | **148** |

---

## 📋 **詳細特徴量リスト**

---

## 【JRA-VAN特徴量（97カラム）】

---

### **A. 基礎情報系（24カラム）**

#### **A-1. レース基本情報（7カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 1 | `month` | **JRA-VAN** | 派生 | - | INT | `kaisai_tsukihi`から抽出（1～12月） | ★★★★ |
| 2 | `kyori` | **JRA-VAN** | `kyori` | jvd_ra | INT | 距離（メートル） | ★★★★★ |
| 3 | `track_code` | **JRA-VAN** | `track_code` | jvd_ra | VARCHAR(2) | トラック種別（芝/ダート/障害） | ★★★★★ |
| 4 | `grade_code` | **JRA-VAN** | `grade_code` | jvd_ra | VARCHAR(1) | グレードコード（A=G1, B=G2, C=G3, D=Jpn1, E=Jpn2, F=Jpn3, G=リステッド, H=OP, ' '=条件戦） | ★★★★ |
| 5 | `shusso_tosu` | **JRA-VAN** | `shusso_tosu` | jvd_ra | INT | 出走頭数 | ★★★ |
| 6 | `tenko_code` | **JRA-VAN** | `tenko_code` | jvd_ra | VARCHAR(1) | 天候コード（1=晴, 2=曇, 3=雨, 4=雪等） | ★★★ |
| 7 | `keibajo_season_code` | **JRA-VAN** | 派生 | - | VARCHAR(10) | **競馬場季節コード（11競馬場）** | ★★★★★ |

**派生処理**:
```sql
-- month: kaisai_tsukihi（MMDD形式）から月を抽出
month = CAST(SUBSTRING(kaisai_tsukihi, 1, 2) AS INTEGER)

-- keibajo_season_code: 小倉の季節分割
keibajo_season_code = CASE 
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi,1,2) AS INTEGER) IN (7,8) THEN '10_summer'
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi,1,2) AS INTEGER) IN (1,2) THEN '10_winter'
    ELSE keibajo_code
END
```

**グレードコード変換例**:
```sql
-- 順序エンコーディング
grade_numeric = CASE grade_code
    WHEN 'A' THEN 1  WHEN 'B' THEN 2  WHEN 'C' THEN 3
    WHEN 'D' THEN 4  WHEN 'E' THEN 5  WHEN 'F' THEN 6
    WHEN 'G' THEN 7  WHEN 'H' THEN 8  ELSE 9
END

-- One-Hot フラグ（任意）
is_g1 = (grade_code IN ('A','D'))
is_graded = (grade_code IN ('A','B','C','D','E','F','G'))
```

---

#### **A-2. 馬場状態（2カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 8 | `babajotai_code_shiba` | **JRA-VAN** | `babajotai_code_shiba` | jvd_ra | VARCHAR | 芝馬場状態コード（1=良、2=稍重、3=重、4=不良） | ★★★★ |
| 9 | `babajotai_code_dirt` | **JRA-VAN** | `babajotai_code_dirt` | jvd_ra | VARCHAR | ダート馬場状態コード | ★★★★ |

---

#### **A-3. 馬基本情報（5カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 10 | `umaban` | **JRA-VAN** | `umaban` | jvd_se | INT | **馬番（1～18）** | ★★★★ |
| 11 | `seibetsu_code` | **JRA-VAN** | `seibetsu_code` | jvd_se | VARCHAR(1) | 性別コード（1=牡, 2=牝, 3=セン） | ★★★ |
| 12 | `barei` | **JRA-VAN** | `barei` | jvd_se | INT | 馬齢（2～10等） | ★★★★ |
| 13 | `moshoku_code` | **JRA-VAN** | `moshoku_code` | jvd_se | VARCHAR(2) | 毛色コード | ★★ |
| 14 | `days_since_last_race` | **JRA-VAN** | 派生 | - | INT | 前走からの間隔（日数） | ★★★★ |

**派生処理**:
```sql
days_since_last_race = DATEDIFF(current_race_date, prev1_race_date)
```

---

#### **A-4. 騎手・調教師（6カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 15 | `kishu_code` | **JRA-VAN** | `kishu_code` | jvd_se | VARCHAR | 騎手コード | ★★★★ |
| 16 | `chokyoshi_code` | **JRA-VAN** | `chokyoshi_code` | jvd_se | VARCHAR | 調教師コード | ★★★★ |
| 17 | `kishumei_ryakusho` | **JRA-VAN** | `kishumei_ryakusho` | jvd_se | VARCHAR | 騎手名略称 | ★★★ |
| 18 | `chokyoshimei_ryakusho` | **JRA-VAN** | `chokyoshimei_ryakusho` | jvd_se | VARCHAR | 調教師名略称 | ★★★ |
| 19 | `tozai_shozoku_code` | **JRA-VAN** | `tozai_shozoku_code` | jvd_se | VARCHAR | 騎手東西所属コード | ★★ |
| 20 | `kishu_minarai_code` | **JRA-VAN** | `kishu_minarai_code` | jvd_se | VARCHAR | 騎手見習コード | ★★ |

---

#### **A-5. 装備・枠・負担重量（3カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 21 | `blinker_shiyo_kubun` | **JRA-VAN** | `blinker_shiyo_kubun` | jvd_se | VARCHAR | ブリンカー使用区分 | ★★★ |
| 22 | `wakuban` | **JRA-VAN** | `wakuban` | jvd_se | INT | 枠番 | ★★★ |
| 23 | `futan_juryo` | **JRA-VAN** | `futan_juryo` | jvd_se | FLOAT | 負担重量（kg） | ★★★★ |

---

#### **A-6. 馬主・生産者（2カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 24 | `banushi_code` | **JRA-VAN** | `banushi_code` | jvd_se | VARCHAR | 馬主コード | ★★ |
| 25 | `banushimei` | **JRA-VAN** | `banushimei` | jvd_se | VARCHAR | 馬主名(法人格無) | ★★ |

---

### **B. 馬実績データ（jvd_ck：14カラム）**

#### **B-1. 基本成績（2カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 26 | `sogo` | **JRA-VAN** | `sogo` | jvd_ck | VARCHAR | 総合着回数（1-5着 + 着外） | ★★★★ |
| 27 | `kyakushitsu_keiko` | **JRA-VAN** | `kyakushitsu_keiko` | jvd_ck | VARCHAR | **脚質傾向（逃げ/先行/差し/追込回数）** | ★★★★ |

**注意**: `kyakushitsu_keiko`はJRA-VANの累積統計、JRDBの`kyakushitsu_code`は今回予想脚質（重複なし）

---

#### **B-2. 馬場状態別着回数（8カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | 説明 | 重要度 |
|---|---|---|---|---|---|---|
| 28 | `shiba_ryo` | **JRA-VAN** | `shiba_ryo` | jvd_ck | 芝良・着回数 | ★★★★ |
| 29 | `shiba_yayaomo` | **JRA-VAN** | `shiba_yayaomo` | jvd_ck | 芝稍・着回数 | ★★★★ |
| 30 | `shiba_omo` | **JRA-VAN** | `shiba_omo` | jvd_ck | 芝重・着回数 | ★★★★ |
| 31 | `shiba_furyo` | **JRA-VAN** | `shiba_furyo` | jvd_ck | 芝不・着回数 | ★★★ |
| 32 | `dirt_ryo` | **JRA-VAN** | `dirt_ryo` | jvd_ck | ダ良・着回数 | ★★★★ |
| 33 | `dirt_yayaomo` | **JRA-VAN** | `dirt_yayaomo` | jvd_ck | ダ稍・着回数 | ★★★★ |
| 34 | `dirt_omo` | **JRA-VAN** | `dirt_omo` | jvd_ck | ダ重・着回数 | ★★★★ |
| 35 | `dirt_furyo` | **JRA-VAN** | `dirt_furyo` | jvd_ck | ダ不・着回数 | ★★★ |

---

#### **B-3. 距離別着回数（4カラム）**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | 説明 | 重要度 |
|---|---|---|---|---|---|---|
| 36 | `shiba_1200_ika` | **JRA-VAN** | `shiba_1200_ika` | jvd_ck | 芝1200以下・着回数 | ★★★★ |
| 37 | `shiba_1201_1400` | **JRA-VAN** | `shiba_1201_1400` | jvd_ck | 芝1201-1400・着回数 | ★★★★ |
| 38 | `dirt_1200_ika` | **JRA-VAN** | `dirt_1200_ika` | jvd_ck | ダ1200以下・着回数 | ★★★★ |
| 39 | `dirt_1201_1400` | **JRA-VAN** | `dirt_1201_1400` | jvd_ck | ダ1201-1400・着回数 | ★★★★ |

---

### **C. 過去走データ（パターンC+：58カラム）**

#### **C-1. レイヤー1：高解像度（直近2走詳細：28カラム）**

##### **前走（t-1）詳細【14カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 40 | `prev1_rank` | **JRA-VAN** | `kakutei_chakujun` | jvd_se | INT | 前走着順 | ★★★★★ |
| 41 | `prev1_time` | **JRA-VAN** | `soha_time` | jvd_se | FLOAT | 前走走破タイム（秒） | ★★★★ |
| 42 | `prev1_last3f` | **JRA-VAN** | `kohan_3f` | jvd_se | FLOAT | 前走上がり3F（秒） | ★★★★★ |
| 43 | `prev1_corner1` | **JRA-VAN** | `corner_1` | jvd_se | INT | 前走1角順位 | ★★ |
| 44 | `prev1_corner4` | **JRA-VAN** | `corner_4` | jvd_se | INT | 前走4角順位（展開把握） | ★★★★ |
| 45 | `prev1_weight` | **JRA-VAN** | `bataiju` | jvd_se | INT | 前走馬体重（kg） | ★★★★ |
| 46 | `prev1_weight_diff` | **JRA-VAN** | `zogen_sa` | jvd_se | INT | 前走馬体重増減（kg） | ★★★ |
| 47 | `prev1_time_diff` | **JRA-VAN** | `time_sa` | jvd_se | FLOAT | 前走着差（秒） | ★★★ |
| 48 | `prev1_distance` | **JRA-VAN** | `kyori` | jvd_ra | INT | 前走距離（m） | ★★★★ |
| 49 | `prev1_track` | **JRA-VAN** | `track_code` | jvd_ra | VARCHAR | 前走トラック種別 | ★★★★ |
| 50 | `prev1_baba_shiba` | **JRA-VAN** | `babajotai_code_shiba` | jvd_ra | VARCHAR | 前走芝馬場状態 | ★★★ |
| 51 | `prev1_baba_dirt` | **JRA-VAN** | `babajotai_code_dirt` | jvd_ra | VARCHAR | 前走ダート馬場状態 | ★★★ |
| 52 | `prev1_keibajo` | **JRA-VAN** | `keibajo_code` | jvd_ra | VARCHAR | 前走競馬場コード | ★★★ |
| 53 | `prev1_pace` | **JRA-VAN** | 派生計算 | - | FLOAT | 前走ペース評価（前半-後半） | ★★★★ |

**取得方法**: `jvd_se`を`ketto_toroku_bango`でグループ化し、`kaisai_nen`+`kaisai_tsukihi`でソート後`ROW_NUMBER() = 1`を取得

---

##### **2走前（t-2）詳細【14カラム】**

| # | 特徴量名 | データソース | 元カラム名 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 54-67 | `prev2_rank`, `prev2_time`, ... `prev2_pace` | **JRA-VAN** | 同上 | 2走前の14項目（t-1と同一構成） | ★★★ |

**取得方法**: 同様に自己JOINで`ROW_NUMBER() = 2`を取得

---

#### **C-2. レイヤー2：低解像度（t-1～t-5統計：18カラム）**

##### **着順統計【5カラム】**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 68 | `past5_rank_avg` | **JRA-VAN** | `AVG(kakutei_chakujun)` | 過去5走平均着順 | ★★★★★ |
| 69 | `past5_rank_best` | **JRA-VAN** | `MIN(kakutei_chakujun)` | 過去5走最高着順 | ★★★★ |
| 70 | `past5_rank_worst` | **JRA-VAN** | `MAX(kakutei_chakujun)` | 過去5走最低着順 | ★★ |
| 71 | `past5_rank_std` | **JRA-VAN** | `STDDEV(kakutei_chakujun)` | 過去5走着順標準偏差（安定性） | ★★★ |
| 72 | `past5_top3_rate` | **JRA-VAN** | `COUNT(rank<=3)/COUNT(*)` | 過去5走連対率 | ★★★★ |

---

##### **速度指数統計【5カラム】**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 73 | `past5_speed_avg` | **JRA-VAN** | `AVG(speed_index)` | 過去5走平均速度指数 | ★★★★★ |
| 74 | `past5_speed_max` | **JRA-VAN** | `MAX(speed_index)` | 過去5走最高速度指数 | ★★★★★ |
| 75 | `past5_speed_ema` | **JRA-VAN** | `EMA(speed_index, α=0.3)` | 過去5走速度指数EMA（減衰） | ★★★★★ |
| 76 | `past5_speed_trend` | **JRA-VAN** | `(speed_t1 - speed_t5) / 4` | 速度指数トレンド（上昇/下降） | ★★★★ |
| 77 | `past5_speed_volatility` | **JRA-VAN** | `STDDEV(speed_index)` | 速度指数の標準偏差（安定性） | ★★★ |

**速度指数の計算式**:
```sql
-- 基準タイムテーブルを作成（競馬場・距離・馬場状態ごと）
CREATE TABLE standard_times AS
SELECT 
    keibajo_code,
    kyori,
    track_code,
    babajotai_code,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY soha_time::FLOAT) AS base_time
FROM jvd_se
INNER JOIN jvd_ra USING (kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango)
WHERE kakutei_chakujun = '01'  -- 1着馬のタイムから算出
GROUP BY keibajo_code, kyori, track_code, babajotai_code;

-- 速度指数の計算
speed_index = (base_time - actual_time) * 10 + 80  -- 基準値80
```

**EMA（指数移動平均）の計算**:
```python
# α=0.3（直近重視）
ema = prev1_value * 0.3 + prev2_value * 0.21 + prev3_value * 0.147 + prev4_value * 0.1029 + prev5_value * 0.07203
```

---

##### **上がり3F統計【3カラム】**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 78 | `past5_last3f_avg` | **JRA-VAN** | `AVG(kohan_3f)` | 過去5走平均上がり3F | ★★★★ |
| 79 | `past5_last3f_best` | **JRA-VAN** | `MIN(kohan_3f)` | 過去5走ベスト上がり3F | ★★★★★ |
| 80 | `past5_last3f_ema` | **JRA-VAN** | `EMA(kohan_3f, α=0.3)` | 過去5走上がり3F EMA | ★★★★ |

---

##### **馬体重統計【3カラム】**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 81 | `past5_weight_avg` | **JRA-VAN** | `AVG(bataiju)` | 過去5走平均馬体重 | ★★ |
| 82 | `past5_weight_trend` | **JRA-VAN** | `(weight_t1 - weight_t5) / 4` | 馬体重トレンド（増加/減少） | ★★★ |
| 83 | `past5_weight_volatility` | **JRA-VAN** | `STDDEV(bataiju)` | 馬体重の標準偏差（安定性） | ★★ |

---

##### **展開適性【2カラム】**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 84 | `past5_avg_position` | **JRA-VAN** | `AVG(corner_4)` | 過去5走平均4角順位（脚質） | ★★★★ |
| 85 | `past5_early_speed` | **JRA-VAN** | `AVG(corner_1)` | 過去5走平均1角順位（出脚評価） | ★★★ |

---

#### **C-3. レイヤー3：コンテキスト（条件別実績：12カラム）**

##### **芝・ダート別実績【4カラム】** 🔵

| # | 特徴量名 | ソース | データソース | 説明 | 重要度 |
|---|---|---|---|---|---|
| 86 | `turf_avg_rank` | 🔵 | jvd_ck集計 | 芝平均着順 | ★★★★ |
| 87 | `turf_top3_rate` | 🔵 | jvd_ck集計 | 芝連対率 | ★★★★ |
| 88 | `dirt_avg_rank` | 🔵 | jvd_ck集計 | ダート平均着順 | ★★★★ |
| 89 | `dirt_top3_rate` | 🔵 | jvd_ck集計 | ダート連対率 | ★★★★ |

---

##### **距離適性【4カラム】** 🔵

| # | 特徴量名 | ソース | データソース | 説明 | 重要度 |
|---|---|---|---|---|---|
| 90 | `same_distance_avg_rank` | 🔵 | 過去走フィルタ集計 | 同距離帯（±200m）平均着順 | ★★★★★ |
| 91 | `same_distance_count` | 🔵 | 過去走フィルタ集計 | 同距離帯出走回数 | ★★★ |
| 92 | `distance_category_best` | 🔵 | jvd_ck集計 | 最得意距離カテゴリ（1=短距離、2=マイル、3=中距離、4=長距離） | ★★★ |
| 93 | `distance_versatility` | 🔵 | jvd_ck集計 | 距離別勝率の標準偏差（万能性指標） | ★★ |

---

##### **競馬場適性【2カラム】** 🔵

| # | 特徴量名 | ソース | データソース | 説明 | 重要度 |
|---|---|---|---|---|---|
| 94 | `same_track_avg_rank` | 🔵 | 過去走フィルタ集計 | 同競馬場平均着順 | ★★★★ |
| 95 | `same_track_count` | 🔵 | 過去走フィルタ集計 | 同競馬場出走回数 | ★★★ |

---

##### **休養明け対応【2カラム】** 🔵

| # | 特徴量名 | ソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 96 | `days_since_last` | 🔵 | 当該レース日 - prev1開催日 | 前走からの間隔（日数） | ★★★★ |
| 97 | `layoff_performance` | 🔵 | `AVG(rank WHERE days>=90)` | 休養明け（3ヶ月以上）の平均着順 | ★★★ |

---

### **D. ターゲット変数（1カラム）**

| # | 特徴量名 | データソース | 計算式 | 説明 | データ型 |
|---|---|---|---|---|---|
| 98 | `target_top3` | **JRA-VAN** | `kakutei_chakujun <= 3 ? 1 : 0` | 3着以内フラグ（1=3着以内、0=4着以下） | INT |

**派生処理**:
```sql
target_top3 = CASE 
    WHEN kakutei_chakujun::INTEGER <= 3 THEN 1 
    ELSE 0 
END
```

---

## 【JRDB特徴量（48カラム）】

---

### **E. jrd_kyi（予想データ）から選択【30カラム】**

#### **E-1. 予測指数系【13カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 99 | `idm` | **JRDB** | `idm` | jrd_kyi | VARCHAR(5) | **IDM（スピード指数）** | ★★★★★ |
| 100 | `kishu_shisu` | **JRDB** | `kishu_shisu` | jrd_kyi | VARCHAR(5) | 騎手指数 | ★★★★ |
| 101 | `joho_shisu` | **JRDB** | `joho_shisu` | jrd_kyi | VARCHAR(5) | 情報指数 | ★★★ |
| 102 | `sogo_shisu` | **JRDB** | `sogo_shisu` | jrd_kyi | VARCHAR(5) | 総合指数 | ★★★★★ |
| 103 | `chokyo_shisu` | **JRDB** | `chokyo_shisu` | jrd_kyi | VARCHAR(5) | 調教指数 | ★★★★★ |
| 104 | `kyusha_shisu` | **JRDB** | `kyusha_shisu` | jrd_kyi | VARCHAR(5) | 厩舎指数 | ★★★★ |
| 105 | `gekiso_shisu` | **JRDB** | `gekiso_shisu` | jrd_kyi | VARCHAR(3) | 激走指数 | ★★★★ |
| 106 | `ninki_shisu` | **JRDB** | `ninki_shisu` | jrd_kyi | VARCHAR(5) | 人気指数 | ★★★ |
| 107 | `ten_shisu` | **JRDB** | `ten_shisu` | jrd_kyi | VARCHAR(5) | **テン指数**（前半のスピード能力） | ★★★★ |
| 108 | `pace_shisu` | **JRDB** | `pace_shisu` | jrd_kyi | VARCHAR(5) | **ペース指数**（ペース対応能力） | ★★★★ |
| 109 | `agari_shisu` | **JRDB** | `agari_shisu` | jrd_kyi | VARCHAR(5) | **上がり指数**（後半の末脚能力） | ★★★★★ |
| 110 | `ichi_shisu` | **JRDB** | `ichi_shisu` | jrd_kyi | VARCHAR(5) | **位置指数**（位置取り能力） | ★★★★ |
| 111 | `manken_shisu` | **JRDB** | `manken_shisu` | jrd_kyi | VARCHAR(3) | **万券指数**（高配当期待度） | ★★★ |

---

#### **E-2. 調教・厩舎評価系【5カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 112 | `chokyo_yajirushi_code` | **JRDB** | `chokyo_yajirushi_code` | jrd_kyi | VARCHAR(1) | 調教矢印コード（1=↑、2=→、3=↓） | ★★★★ |
| 113 | `kyusha_hyoka_code` | **JRDB** | `kyusha_hyoka_code` | jrd_kyi | VARCHAR(1) | 厩舎評価コード（高い1～9低い） | ★★★ |
| 114 | `kishu_kitai_rentai_ritsu` | **JRDB** | `kishu_kitai_rentai_ritsu` | jrd_kyi | VARCHAR(4) | 騎手期待連対率（%） | ★★★ |
| 115 | `shiage_shisu` | **JRDB** | `shiage_shisu` | jrd_cyb | VARCHAR(3) | 仕上指数（仕上がり状態） | ★★★★ |
| 116 | `chokyo_hyoka` | **JRDB** | `chokyo_hyoka` | jrd_cyb | VARCHAR(1) | 調教評価（A～E） | ★★★★ |

---

#### **E-3. 馬の適性・状態系【6カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 117 | `kyakushitsu_code` | **JRDB** | `kyakushitsu_code` | jrd_kyi | VARCHAR(1) | **脚質コード**（1=逃げ、2=先行、3=差し、4=追込） | ★★★★ |
| 118 | `kyori_tekisei_code` | **JRDB** | `kyori_tekisei_code` | jrd_kyi | VARCHAR(1) | 距離適性コード（1=短、2=マイル、3=中、4=長、5=万能） | ★★★★ |
| 119 | `joshodo_code` | **JRDB** | `joshodo_code` | jrd_kyi | VARCHAR(1) | 上昇度コード（1=AA激走、2=A、3=B、4=C、5=?） | ★★★★ |
| 120 | `tekisei_code_omo` | **JRDB** | `tekisei_code_omo` | jrd_kyi | VARCHAR(1) | 適性コード(重)（重馬場適性） | ★★★ |
| 121 | `hizume_code` | **JRDB** | `hizume_code` | jrd_kyi | VARCHAR(2) | 蹄コード（蹄の状態評価） | ★★ |
| 122 | `class_code` | **JRDB** | `class_code` | jrd_kyi | VARCHAR(2) | クラスコード（馬のクラス評価） | ★★★ |

**注意**: `kyakushitsu_code`（JRDB予想）と`kyakushitsu_keiko`（JRA-VAN累積）は異なる（両方使用）

---

#### **E-4. 展開予想系【2カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 123 | `pace_yoso` | **JRDB** | `pace_yoso` | jrd_kyi | VARCHAR(1) | ペース予想（H=ハイ、M=ミドル、S=スロー） | ★★★★ |
| 124 | `uma_deokure_ritsu` | **JRDB** | `uma_deokure_ritsu` | jrd_kyi | VARCHAR(4) | 馬出遅れ率（出遅れの頻度%） | ★★★ |

---

#### **E-5. ランク・その他【6カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 125 | `rotation` | **JRDB** | `rotation` | jrd_kyi | VARCHAR(3) | ローテーション（前走からの間隔週数） | ★★★ |
| 126 | `hobokusaki_rank` | **JRDB** | `hobokusaki_rank` | jrd_kyi | VARCHAR(1) | **放牧先ランク**（A～E、Aが最高） | ★★★ |
| 127 | `kyusha_rank` | **JRDB** | `kyusha_rank` | jrd_kyi | VARCHAR(1) | **厩舎ランク**（高い1～9低い） | ★★★ |
| 128 | `bataiju` | **JRDB** | `bataiju` | jrd_kyi | VARCHAR(3) | **(枠確定)馬体重**（枠確定時点） | ★★★★ |
| 129 | `bataiju_zogen` | **JRDB** | `bataiju_zogen` | jrd_kyi | VARCHAR(3) | (枠確定)馬体重増減（前走からの増減） | ★★★ |
| 130 | `uma_start_shisu` | **JRDB** | `uma_start_shisu` | jrd_kyi | VARCHAR(4) | 馬スタート指数（スタートの巧拙評価） | ★★★ |

---

### **F. jrd_joa（CID・LS指数）から選択【7カラム】**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 131 | `cid` | **JRDB** | `cid` | jrd_joa | VARCHAR(3) | CID（コース適性指数） | ★★★★ |
| 132 | `ls_shisu` | **JRDB** | `ls_shisu` | jrd_joa | VARCHAR(5) | LS指数（レイティング指数） | ★★★★ |
| 133 | `ls_hyoka` | **JRDB** | `ls_hyoka` | jrd_joa | VARCHAR(1) | LS評価（A～E） | ★★★ |
| 134 | `em` | **JRDB** | `em` | jrd_joa | VARCHAR(1) | EM（展開マーク） | ★★★ |
| 135 | `kyusha_bb_shirushi` | **JRDB** | `kyusha_bb_shirushi` | jrd_joa | VARCHAR(1) | 厩舎BB印（◎○▲△×） | ★★★ |
| 136 | `kishu_bb_shirushi` | **JRDB** | `kishu_bb_shirushi` | jrd_joa | VARCHAR(1) | 騎手BB印（◎○▲△×） | ★★★ |
| 137 | `kyusha_bb_nijumaru_tansho_kaishuritsu` | **JRDB** | `kyusha_bb_nijumaru_tansho_kaishuritsu` | jrd_joa | VARCHAR(5) | 厩舎BB◎単勝回収率（%） | ★★ |

---

### **G. jrd_sed（成績データ）から過去走用に選択【7カラム】**

**過去走データとして自己JOINで取得するカラム**

| # | 特徴量名 | データソース | 元カラム名 | テーブル | データ型 | 説明 | 重要度 |
|---|---|---|---|---|---|---|---|
| 138 | `prev1_pace` | **JRDB** | `pace` | jrd_sed | VARCHAR(3) | **前走ペース**（H=ハイ、M=ミドル、S=スロー） | ★★★★ |
| 139 | `prev1_deokure` | **JRDB** | `deokure` | jrd_sed | VARCHAR(3) | **前走出遅れ**（秒数または評価） | ★★★★ |
| 140 | `prev1_furi` | **JRDB** | `furi` | jrd_sed | VARCHAR(3) | **前走不利**（総合評価） | ★★★★ |
| 141 | `prev1_furi_1` | **JRDB** | `furi_1` | jrd_sed | VARCHAR(3) | **前走前不利**（前半の不利） | ★★★ |
| 142 | `prev1_furi_2` | **JRDB** | `furi_2` | jrd_sed | VARCHAR(3) | **前走中不利**（中盤の不利） | ★★★ |
| 143 | `prev1_furi_3` | **JRDB** | `furi_3` | jrd_sed | VARCHAR(3) | **前走後不利**（後半の不利） | ★★★ |
| 144 | `prev1_batai_code` | **JRDB** | `batai_code` | jrd_sed | VARCHAR(1) | **前走馬体コード**（1=太め、2=普通、3=細め等） | ★★★ |

**過去走での使用例**:
```sql
-- 前走でのペース
prev1_pace

-- 過去5走での不利発生回数
past5_furi_count = COUNT(CASE WHEN furi IS NOT NULL AND furi != '   ' THEN 1 END)
```

---

## 【派生特徴量（3カラム）】

---

### **H. 距離増減系（3カラム）**

| # | 特徴量名 | データソース | 計算式 | 説明 | 重要度 |
|---|---|---|---|---|---|
| 145 | `distance_change` | **派生（JRA-VAN）** | `jvd_ra.kyori - prev1_distance` | **距離増減（m）** | ★★★★ |
| 146 | `distance_change_abs` | **派生（JRA-VAN）** | `ABS(distance_change)` | **距離増減絶対値（m）** | ★★★ |
| 147 | `distance_change_sign` | **派生（JRA-VAN）** | `SIGN(distance_change)` | **距離増減符号（1=増、0=同、-1=減）** | ★★★ |

**派生処理**:
```sql
distance_change = jvd_ra.kyori - prev1_distance
distance_change_abs = ABS(distance_change)
distance_change_sign = SIGN(distance_change)
```

---

## 🔧 **実装ガイド**

---

### **1. 自己JOIN実装（過去走データ取得）**

```sql
WITH past_races AS (
    SELECT 
        se.ketto_toroku_bango,
        se.kaisai_nen,
        se.kaisai_tsukihi,
        se.keibajo_code,
        se.race_bango,
        se.kakutei_chakujun,
        se.soha_time,
        se.kohan_3f,
        se.corner_1,
        se.corner_4,
        se.bataiju,
        se.zogen_sa,
        se.time_sa,
        ra.kyori,
        ra.track_code,
        ra.babajotai_code_shiba,
        ra.babajotai_code_dirt,
        ra.keibajo_code AS past_keibajo,
        ROW_NUMBER() OVER (
            PARTITION BY se.ketto_toroku_bango 
            ORDER BY se.kaisai_nen DESC, se.kaisai_tsukihi DESC, se.race_bango DESC
        ) AS race_order
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (
        se.kaisai_nen = ra.kaisai_nen 
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.race_bango = ra.race_bango
    )
    WHERE se.kakutei_chakujun ~ '^[0-9]+$'
)
SELECT 
    -- レイヤー1: 高解像度（t-1）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.kakutei_chakujun::INTEGER END) AS prev1_rank,
    MAX(CASE WHEN pr.race_order = 1 THEN pr.soha_time::FLOAT END) AS prev1_time,
    MAX(CASE WHEN pr.race_order = 1 THEN pr.kohan_3f::FLOAT END) AS prev1_last3f,
    -- ... (他の前走カラム)
    
    -- レイヤー1: 高解像度（t-2）
    MAX(CASE WHEN pr.race_order = 2 THEN pr.kakutei_chakujun::INTEGER END) AS prev2_rank,
    -- ... (他の2走前カラム)
    
    -- レイヤー2: 低解像度（統計）
    AVG(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_avg,
    MIN(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_best,
    STDDEV(CASE WHEN pr.race_order BETWEEN 1 AND 5 THEN pr.kakutei_chakujun::INTEGER END) AS past5_rank_std,
    
    -- レイヤー3: コンテキスト（条件別）
    AVG(CASE 
        WHEN pr.race_order <= 10 AND pr.track_code = tr.track_code 
        THEN pr.kakutei_chakujun::INTEGER 
    END) AS same_track_avg_rank
    
FROM target_race tr
LEFT JOIN past_races pr ON tr.ketto_toroku_bango = pr.ketto_toroku_bango
GROUP BY tr.ketto_toroku_bango;
```

---

### **2. JRDB過去走データ取得**

```sql
WITH past_races_jrdb AS (
    SELECT 
        sed.ketto_toroku_bango,
        sed.pace,
        sed.deokure,
        sed.furi,
        sed.furi_1,
        sed.furi_2,
        sed.furi_3,
        sed.batai_code,
        ROW_NUMBER() OVER (
            PARTITION BY sed.ketto_toroku_bango 
            ORDER BY sed.kaisai_nen DESC, sed.kaisai_tsukihi DESC, sed.race_bango DESC
        ) AS race_order
    FROM jrd_sed sed
    WHERE sed.kakutei_chakujun ~ '^[0-9]+$'  -- 着順確定レースのみ
)
SELECT 
    -- 前走（t-1）
    MAX(CASE WHEN race_order = 1 THEN pace END) AS prev1_pace,
    MAX(CASE WHEN race_order = 1 THEN deokure END) AS prev1_deokure,
    MAX(CASE WHEN race_order = 1 THEN furi END) AS prev1_furi,
    MAX(CASE WHEN race_order = 1 THEN furi_1 END) AS prev1_furi_1,
    MAX(CASE WHEN race_order = 1 THEN furi_2 END) AS prev1_furi_2,
    MAX(CASE WHEN race_order = 1 THEN furi_3 END) AS prev1_furi_3,
    MAX(CASE WHEN race_order = 1 THEN batai_code END) AS prev1_batai_code
    
FROM target_race tr
LEFT JOIN past_races_jrdb pr ON tr.ketto_toroku_bango = pr.ketto_toroku_bango
GROUP BY tr.ketto_toroku_bango;
```

---

### **3. データ型変換**

| カラム種別 | 元の型 | 変換後の型 | 変換方法 |
|---|---|---|---|
| 着順 | VARCHAR | INTEGER | `kakutei_chakujun::INTEGER`（数値以外はNULL） |
| タイム | VARCHAR | FLOAT | `soha_time::FLOAT`（例: "120.5" → 120.5） |
| 馬体重 | VARCHAR | INTEGER | `bataiju::INTEGER` |
| コーナー順位 | VARCHAR | INTEGER | `corner_1::INTEGER` |

**NULL処理**:
```sql
-- 数値以外（"取消"、"除外"など）を除外
WHERE kakutei_chakujun ~ '^[0-9]+$'
```

---

### **4. 欠損値対応**

| シナリオ | 対応方法 |
|---|---|
| 過去走が5走未満 | 統計量は計算可能な範囲で算出（例: 3走しかない場合は3走の平均） |
| 新馬戦（過去走0） | 前走カラムは全てNULL、統計量カラムもNULL |
| 同条件実績なし | コンテキストレイヤーのカラムはNULL |

**LightGBMの欠損値処理**:
- LightGBMはネイティブに欠損値を扱える
- `missing=-1`や`NaN`として入力すれば、モデルが自動的に最適な分岐を学習

---

## ⚠️ **データリーク防止**

### **除外すべきカラム（対象レースの結果データ）**

以下は**予測対象レースの結果**であるため、特徴量として使用してはいけません：

| カラム | 理由 |
|---|---|
| `kakutei_chakujun` | 着順（予測対象） |
| `soha_time` | 走破タイム（結果） |
| `kohan_3f` | 上がり3F（結果） |
| `corner_1～4` | コーナー通過順位（結果） |
| `time_sa` | 着差（結果） |
| `bataiju` | 馬体重（レース当日朝確定だが、リーク注意） |
| `zogen_sa` | 馬体重増減（同上） |
| `tansho_odds` | 単勝オッズ（レース後確定） |
| `tansho_ninkijun` | 単勝人気順位（レース後確定） |

**注意**: これらは**前走（t-1）以前のデータとして**は使用可能です。

---

## 📚 **理論的根拠（レポートより）**

### **なぜパターンC+が最適なのか？**

#### **1. LightGBMとの相性◎**
> 「集約特徴量は、個別のラグ特徴量よりもノイズが低減されており（平滑化効果）、決定木のルートに近いノードで強力な分割基準として機能する。」

- 次元数を抑制（148カラム）→過学習リスク低減
- 特徴量マスキング（重要特徴の埋もれ）を回避

#### **2. Borutaとの相性◎**
> 「特徴量数が抑制されるため、計算効率が良い。また、集約特徴量は個別のラグよりも情報密度（Signal Density）が高いため、Borutaによって『重要』と判定されやすく、安定して選択される。」

- 多重検定の罠を回避
- 偽陰性（有用特徴の取りこぼし）を削減

#### **3. Optunaとの相性◎**
> 「安定した性能を発揮しやすい。探索空間がシンプルであり、パラメータチューニングが容易。」

- 探索空間の安定性
- 計算コスト低→試行回数を増やせる

#### **4. JRA競馬ドメイン知識◎**
> 「競馬予想のプロセス（まず馬の格付けを行い、次に直近の調子を見る）と合致している。」

- 調子（Form）と格（Class）を分離
- 文脈（Context）を考慮
- ペース・展開適性を評価可能

#### **5. 欠損値への耐性◎**
> 「『過去5走の平均着順』などは、出走回数が少なくても計算可能（2戦なら2戦の平均）であり、欠損を自然に回避できる点で構造的な優位性を持つ。」

- 新馬・若駒でも統計量が計算可能

---

## ✅ **次のステップ**

1. ✅ **統合特徴量仕様書作成完了**（148カラム、11競馬場、1,628次元）
2. ⏳ **Phase 0～5セットアップマニュアル作成**
3. ⏳ **コンテキスト維持プロトコル作成**

---

## 📝 **変更履歴**

| 日付 | 変更内容 |
|---|---|
| 2026-02-19 | 初版作成。JRA-VAN（97） + JRDB（48） + 派生（3） = 148カラム確定版 |

---

**📅 作成日**: 2026-02-19  
**📖 根拠**: ディープサーチレポート『中央競馬（JRA）におけるAI予測モデルの最適化』  
**📄 ステータス**: 開発実装用最終確定版  
**🏆 推奨パターン**: パターンC+（ハイブリッド・コンテキストモデル）  
**🎯 総次元数**: 11競馬場 × 148特徴量 = **1,628次元**
��成完了**（148カラム、11競馬場、1,628次元）
2. ⏳ **Phase 0～5セットアップマニュアル作成**
3. ⏳ **コンテキスト維持プロトコル作成**

---

## 📝 **変更履歴**

| 日付 | 変更内容 |
|---|---|
| 2026-02-19 | 初版作成。JRA-VAN（97） + JRDB（48） + 派生（3） = 148カラム確定版 |

---

**📅 作成日**: 2026-02-19  
**📖 根拠**: ディープサーチレポート『中央競馬（JRA）におけるAI予測モデルの最適化』  
**📄 ステータス**: 開発実装用最終確定版  
**🏆 推奨パターン**: パターンC+（ハイブリッド・コンテキストモデル）  
**🎯 総次元数**: 11競馬場 × 148特徴量 = **1,628次元**
