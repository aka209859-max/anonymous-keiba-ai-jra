# JRDB カラム名マッピング (2026-03-03)

## 🎯 SQLエラー原因の特定完了

### **エラーと正しいカラム名の対応表**

| エラーで使用したカラム名 | 正しいカラム名 | テーブル | 用途 |
|------------------------|--------------|---------|------|
| `idm_shisu` | `idm` | jrd_kyi | IDM指数 |
| `jockey_shisu` | `kishu_shisu` | jrd_kyi | 騎手指数 |
| `sogo_shisu_3` | `sogo_shisu` | jrd_kyi | 総合指数 |
| `tenkai_yoso_data_pace` | `pace_yoso` | jrd_kyi | ペース予想 |
| `time` | `soha_time` | jrd_sed | 走破タイム |
| `ten_shisu` | **jrd_kyi に存在** | jrd_kyi | テン指数 |
| `agari_shisu` | **jrd_kyi に存在** | jrd_kyi | 上がり指数 |
| `pace_shisu` | **jrd_kyi に存在** | jrd_kyi | ペース指数 |

---

## 📊 JRDB 5テーブルの全カラム詳細

### **1. jrd_kyi (132カラム) - 馬・騎手指数データ**

#### **🔥 ROI向上必須カラム（優先度S）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `idm` | IDM指数 | character varying(5) |
| `kishu_shisu` | 騎手指数 | character varying(5) |
| `sogo_shisu` | 総合指数 | character varying(5) |
| `ten_shisu` | テン指数（序盤3F） | character varying(5) |
| `pace_shisu` | ペース指数 | character varying(5) |
| `agari_shisu` | 上がり指数（終盤3F） | character varying(5) |
| `ichi_shisu` | 位置指数 | character varying(5) |

#### **展開・ペース予想系（優先度A）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `pace_yoso` | ペース予想 | character varying(1) |
| `dochu_juni` | 道中順位予想 | character varying(2) |
| `dochu_sa` | 道中差 | character varying(2) |
| `kohan_3f_juni` | 後半3F順位予想 | character varying(2) |
| `goal_juni` | ゴール順位予想 | character varying(2) |
| `tenkai_kigo_code` | 展開記号コード | character varying(1) |

#### **調教・厩舎評価（優先度A）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `chokyo_shisu` | 調教指数 | character varying(5) |
| `kyusha_shisu` | 厩舎指数 | character varying(5) |
| `chokyo_yajirushi_code` | 調教矢印コード | character varying(1) |
| `kyusha_hyoka_code` | 厩舎評価コード | character varying(1) |

#### **騎手・厩舎期待値（優先度A）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `kishu_kitai_rentai_ritsu` | 騎手期待連対率 | character varying(4) |
| `kishu_kitai_tansho_ritsu` | 騎手期待単勝率 | character varying(4) |
| `kishu_kitai_sanchakunai_ritsu` | 騎手期待3着内率 | character varying(4) |

#### **その他重要指数（優先度B）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `ninki_shisu` | 人気指数 | character varying(5) |
| `gekiso_shisu` | 激走指数 | character varying(3) |
| `joho_shisu` | 情報指数 | character varying(5) |
| `ls_shisu_juni` | LS指数順位 | character varying(2) |
| `manken_shisu` | 万券指数 | character varying(3) |
| `uma_start_shisu` | 馬スタート指数 | character varying(4) |

#### **過去成績キー（優先度B）**
| カラム名 | 用途 |
|---------|------|
| `kako1_kyoso_seiseki_key` | 過去1走成績キー |
| `kako2_kyoso_seiseki_key` | 過去2走成績キー |
| `kako3_kyoso_seiseki_key` | 過去3走成績キー |
| `kako4_kyoso_seiseki_key` | 過去4走成績キー |
| `kako5_kyoso_seiseki_key` | 過去5走成績キー |

---

### **2. jrd_sed (80カラム) - 成績・ラップデータ**

#### **🔥 ROI向上必須カラム（優先度S）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `soha_time` | 走破タイム | character varying(4) |
| `pace` | ペース | character varying(3) |
| `idm` | IDM（結果版） | character varying(3) |
| `babasa` | 馬場差 | character varying(3) |

#### **展開・位置取り（優先度A）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `deokure` | 出遅れ | character varying(3) |
| `ichidori` | 位置取り | character varying(3) |
| `corner_1` | 1コーナー通過順 | character varying(2) |
| `corner_2` | 2コーナー通過順 | character varying(2) |
| `corner_3` | 3コーナー通過順 | character varying(2) |
| `corner_4` | 4コーナー通過順 | character varying(2) |

#### **ラップタイム詳細（優先度A）**
```
lap_time_1 〜 lap_time_25 (各 character varying(3))
```
- **合計25分割ラップタイム**（200m刻み）

#### **その他重要指標（優先度B）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `tansho_odds` | 単勝オッズ | character varying(6) |
| `tansho_ninkijun` | 単勝人気順 | character varying(2) |
| `kakutei_chakujun` | 確定着順 | character varying(2) |
| `babajotai_code` | 馬場状態コード | character varying(2) |

---

### **3. jrd_bac (27カラム) - 馬場・開催情報**

#### **重要カラム（優先度B）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `kaisai_tsukihi` | 開催月日 | character varying(4) |
| `kyori` | 距離 | character varying(4) |
| `track_code` | トラックコード | character varying(3) |
| `kyoso_shubetsu_code` | 競走種別コード | character varying(2) |
| `grade_code` | グレードコード | character varying(1) |
| `honshokin` | 本賞金 | character varying(25) |
| `fukashokin` | 付加賞金 | character varying(10) |

---

### **4. jrd_cyb (27カラム) - 調教データ**

#### **重要カラム（優先度B）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `chokyo_type` | 調教タイプ | character varying(2) |
| `oikiri_shisu` | 追い切り指数 | character varying(3) |
| `shiage_shisu` | 仕上げ指数 | character varying(3) |
| `chokyo_ryo_hyoka` | 調教量評価 | character varying(1) |
| `chokyo_hyoka` | 調教評価 | character varying(1) |
| `chokyo_comment` | 調教コメント | character varying(40) |

---

### **5. jrd_joa (24カラム) - オッズ分析データ**

#### **重要カラム（優先度C）**
| カラム名 | 用途 | データ型 |
|---------|------|---------|
| `kijun_odds_tansho` | 基準オッズ単勝 | character varying(5) |
| `kijun_odds_fukusho` | 基準オッズ複勝 | character varying(5) |
| `cid` | CID | character varying(3) |
| `ls_shisu` | LS指数 | character varying(5) |
| `kyusha_bb_nijumaru_tansho_kaishuritsu` | 厩舎BB二重丸単勝回収率 | character varying(5) |
| `kishu_bb_nijumaru_tansho_kaishuritsu` | 騎手BB二重丸単勝回収率 | character varying(5) |

---

## 🔥 ROI向上期待度ランキング Top 30

| 順位 | カラム名 | テーブル | ROI期待度 | 理由 |
|------|---------|---------|----------|------|
| 1 | `idm` | jrd_kyi | ★★★★★ | JRDB最重要指数 |
| 2 | `sogo_shisu` | jrd_kyi | ★★★★★ | 総合指数（競走能力） |
| 3 | `ten_shisu` | jrd_kyi | ★★★★★ | テン指数（序盤3F） |
| 4 | `agari_shisu` | jrd_kyi | ★★★★★ | 上がり指数（終盤3F） |
| 5 | `pace_shisu` | jrd_kyi | ★★★★★ | ペース指数 |
| 6 | `ichi_shisu` | jrd_kyi | ★★★★★ | 位置指数 |
| 7 | `kishu_shisu` | jrd_kyi | ★★★★☆ | 騎手指数 |
| 8 | `chokyo_shisu` | jrd_kyi | ★★★★☆ | 調教指数 |
| 9 | `kyusha_shisu` | jrd_kyi | ★★★★☆ | 厩舎指数 |
| 10 | `kishu_kitai_rentai_ritsu` | jrd_kyi | ★★★★☆ | 騎手期待連対率 |
| 11 | `pace_yoso` | jrd_kyi | ★★★★☆ | ペース予想 |
| 12 | `dochu_juni` | jrd_kyi | ★★★★☆ | 道中順位予想 |
| 13 | `kohan_3f_juni` | jrd_kyi | ★★★★☆ | 後半3F順位予想 |
| 14 | `goal_juni` | jrd_kyi | ★★★★☆ | ゴール順位予想 |
| 15 | `soha_time` | jrd_sed | ★★★★☆ | 走破タイム |
| 16 | `pace` | jrd_sed | ★★★★☆ | ペース |
| 17 | `babasa` | jrd_sed | ★★★★☆ | 馬場差 |
| 18 | `deokure` | jrd_sed | ★★★★☆ | 出遅れ |
| 19 | `ichidori` | jrd_sed | ★★★★☆ | 位置取り |
| 20 | `lap_time_1〜25` | jrd_sed | ★★★★☆ | ラップタイム分割 |
| 21 | `gekiso_shisu` | jrd_kyi | ★★★☆☆ | 激走指数 |
| 22 | `ninki_shisu` | jrd_kyi | ★★★☆☆ | 人気指数 |
| 23 | `joho_shisu` | jrd_kyi | ★★★☆☆ | 情報指数 |
| 24 | `oikiri_shisu` | jrd_cyb | ★★★☆☆ | 追い切り指数 |
| 25 | `shiage_shisu` | jrd_cyb | ★★★☆☆ | 仕上げ指数 |
| 26 | `corner_1〜4` | jrd_sed | ★★★☆☆ | コーナー通過順 |
| 27 | `tansho_odds` | jrd_sed | ★★★☆☆ | 単勝オッズ |
| 28 | `manken_shisu` | jrd_kyi | ★★☆☆☆ | 万券指数 |
| 29 | `ls_shisu` | jrd_joa | ★★☆☆☆ | LS指数 |
| 30 | `chokyo_hyoka` | jrd_cyb | ★★☆☆☆ | 調教評価 |

---

## 📋 次のアクション: 修正SQL作成

### **jrd_kyi 充填率チェック（修正版）**
```sql
SELECT 
    COUNT(*) AS total_records,
    COUNT(idm) AS idm_filled,
    COUNT(kishu_shisu) AS jockey_index_filled,
    COUNT(sogo_shisu) AS sogo_index_filled,
    COUNT(pace_yoso) AS pace_forecast_filled,
    COUNT(chokyo_shisu) AS training_index_filled,
    COUNT(ten_shisu) AS ten_index_filled,
    COUNT(agari_shisu) AS agari_index_filled,
    COUNT(pace_shisu) AS pace_index_filled,
    ROUND(100.0 * COUNT(idm) / COUNT(*), 2) AS idm_rate,
    ROUND(100.0 * COUNT(kishu_shisu) / COUNT(*), 2) AS jockey_index_rate,
    ROUND(100.0 * COUNT(ten_shisu) / COUNT(*), 2) AS ten_index_rate
FROM jrd_kyi;
```

### **jrd_sed 充填率チェック（修正版）**
```sql
SELECT 
    COUNT(*) AS total_records,
    COUNT(soha_time) AS time_filled,
    COUNT(pace) AS pace_filled,
    COUNT(idm) AS idm_filled,
    COUNT(babasa) AS babasa_filled,
    COUNT(deokure) AS deokure_filled,
    COUNT(lap_time_1) AS lap_time_1_filled,
    ROUND(100.0 * COUNT(soha_time) / COUNT(*), 2) AS time_rate,
    ROUND(100.0 * COUNT(pace) / COUNT(*), 2) AS pace_rate,
    ROUND(100.0 * COUNT(idm) / COUNT(*), 2) AS idm_rate
FROM jrd_sed;
```

---

**作成日**: 2026-03-03  
**ステータス**: JRDBカラム名マッピング完了  
**次ステップ**: 修正SQLをpgAdmin4で実行 → JRDB充填率確認 → 候補カラム選定
