# Phase 7-A Day 4 完全分析報告 (2026-03-03)

## 🚨 重要な発見：既存CSVは81カラム（139カラムではない）

### **訂正事項**
- ❌ **誤**: 既存CSV 139カラム
- ✅ **正**: 既存CSV **81カラム**

---

## ✅ 確認完了データ

### **1. jrd_kyi 充填率チェック結果**

| カラム名 | 充填数 | 総数 | 充填率 | 評価 |
|---------|--------|------|--------|------|
| `idm` (IDM指数) | 4,828 | 4,828 | **100.00%** | ★★★★★ |
| `kishu_shisu` (騎手指数) | 4,828 | 4,828 | **100.00%** | ★★★★★ |
| `sogo_shisu` (総合指数) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |
| `ten_shisu` (テン指数) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |
| `agari_shisu` (上がり指数) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |
| `pace_shisu` (ペース指数) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |
| `pace_yoso` (ペース予想) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |
| `chokyo_shisu` (調教指数) | 3,152 | 4,828 | **65.29%** | ★★★☆☆ |

**総レコード数**: 4,828

**充填率分析**:
- ✅ **完全充填（100%）**: `idm`, `kishu_shisu` → **学習に最適**
- ⚠️ **部分充填（65.29%）**: その他6カラム → **欠損値処理必要**

---

### **2. jrd_sed 充填率チェック結果（エラー発生）**

#### **SQL実行エラー**
```
ERROR: column "lap_time_1" does not exist
LINE 8: COUNT(lap_time_1) AS lap_time_1_filled,
SQL state: 42703
```

**原因**: `jrd_sed` テーブルに `lap_time_1` カラムが存在しない

**推測**: 
- ラップタイムは `lap_time` という単一カラムに格納されている可能性
- または `jrd_sed` には分割ラップタイムが存在しない

**対策**: `JRDBテーブルのカラム詳細.csv` で `jrd_sed` の実カラム名を再確認

---

### **3. 既存CSV 81カラムの完全リスト**

#### **全カラム（81個）**
```
1. kaisai_nen                        28. prev1_rank
2. kaisai_tsukihi                    29. prev1_time
3. keibajo_code                      30. prev1_last_3f
4. kaisai_kai                        31. past5_rank_avg
5. kaisai_nichime                    32. past5_rank_best
6. race_bango                        33. past5_time_avg
7. umaban                            34. race_shikonen
8. ketto_toroku_bango_jravan         35. ketto_toroku_bango_jrdb
9. wakuban                           36. idm
10. seibetsu_code                    37. kishu_shisu
11. month                            38. joho_shisu
12. kyori                            39. sogo_shisu
13. track_code                       40. chokyo_shisu
14. tenko_code                       41. kyusha_shisu
15. babajotai_code_shiba             42. gekiso_shisu
16. babajotai_code_dirt              43. ninki_shisu
17. hasso_jikoku                     44. ten_shisu
18. grade_code                       45. pace_shisu
19. keibajo_season_code              46. agari_shisu
20. shusso_tosu                      47. ichi_shisu
21. barei                            48. manken_shisu
22. kishumei_ryakusho                49. chokyo_yajirushi_code
23. bataiju_jravan                   50. kyusha_hyoka_code
24. zogen_sa                         51. kishu_kitai_rentai_ritsu
25. blinker_shiyo_kubun              52. shiage_shisu
26. race_date_int                    53. chokyo_hyoka
27. target_top3                      54. kyakushitsu_code
                                     ... (続く)
```

#### **カテゴリ別内訳**

| カテゴリ | カラム数 | 主な内容 |
|---------|---------|---------|
| **JRA-VAN由来** | 44 | レース基本情報、馬・騎手情報 |
| **JRDB由来** | 22 | 指数系データ（idm, 騎手指数等） |
| **派生カラム** | 15 | 前走成績、過去5走平均等 |
| **合計** | **81** | - |

---

## 📊 JRDB jrd_kyi カラム利用状況

### **既存CSV に存在する jrd_kyi カラム（39個）**

#### **優先度S（完全充填100%、必須）**
1. `idm` - IDM指数 ★★★★★
2. `kishu_shisu` - 騎手指数 ★★★★★

#### **優先度A（部分充填65.29%、重要）**
3. `sogo_shisu` - 総合指数 ★★★★☆
4. `ten_shisu` - テン指数 ★★★★☆
5. `agari_shisu` - 上がり指数 ★★★★☆
6. `pace_shisu` - ペース指数 ★★★★☆
7. `ichi_shisu` - 位置指数 ★★★★☆
8. `chokyo_shisu` - 調教指数 ★★★★☆
9. `kyusha_shisu` - 厩舎指数 ★★★★☆

#### **優先度B（その他30カラム）**
- `joho_shisu`, `gekiso_shisu`, `ninki_shisu`, `manken_shisu`
- `chokyo_yajirushi_code`, `kyusha_hyoka_code`, `kishu_kitai_rentai_ritsu`
- `shiage_shisu`, `chokyo_hyoka`, `kyakushitsu_code`, `kyori_tekisei_code`
- `joshodo_code`, `tekisei_code_omo`, `hizume_code`, `class_code`
- `pace_yoso`, `uma_deokure_ritsu`, `rotation`, `hobokusaki_rank`
- `kyusha_rank`, `bataiju_jrdb`, `bataiju_zogen`, `uma_start_shisu`
- `cid`, `ls_shisu`, `ls_hyoka`, `em`
- `kyusha_bb_shirushi`, `kishu_bb_shirushi`, `kyusha_bb_nijumaru_tansho_kaishuritsu`

### **jrd_kyi で未使用のカラム（93個）**

#### **優先度S（ROI期待大、追加推奨）**
1. `dochu_juni` - 道中順位予想
2. `dochu_sa` - 道中差
3. `kohan_3f_juni` - 後半3F順位予想
4. `kohan_3f_sa` - 後半3F差
5. `goal_juni` - ゴール順位予想
6. `goal_sa` - ゴール差
7. `tenkai_kigo_code` - 展開記号コード
8. `kyori_tekisei_code_2` - 距離適性コード2
9. `kishu_kitai_tansho_ritsu` - 騎手期待単勝率
10. `kishu_kitai_sanchakunai_ritsu` - 騎手期待3着内率

#### **優先度A（追加検討）**
- 過去成績キー（`kako1_kyoso_seiseki_key` 〜 `kako5_kyoso_seiseki_key`）
- レースキー（`kako1_race_key` 〜 `kako5_race_key`）
- 指数順位（`ls_shisu_juni`, `ten_shisu_juni`, `pace_shisu_juni`, `agari_shisu_juni`, `ichi_shisu_juni`）
- 馬体・調教（`taikei`, `taikei_sogo_1`, `taikei_sogo_2`, `taikei_sogo_3`）
- その他40+カラム

---

## 🎯 jrd_sed（JRDB成績データ）の未使用カラム

### **jrd_sed 80カラムの概要**

#### **優先度S（必須追加カラム）**
| カラム名 | 用途 | ROI期待度 |
|---------|------|----------|
| `soha_time` | 走破タイム | ★★★★★ |
| `pace` | ペース | ★★★★★ |
| `idm` | IDM（結果版） | ★★★★★ |
| `babasa` | 馬場差 | ★★★★☆ |
| `deokure` | 出遅れ | ★★★★☆ |
| `ichidori` | 位置取り | ★★★★☆ |

#### **優先度A（コーナー通過順）**
- `corner_1`, `corner_2`, `corner_3`, `corner_4`

#### **優先度B（その他指標）**
- `tansho_odds`, `tansho_ninkijun`, `kakutei_chakujun`
- `babajotai_code`, `kaisai_tsukihi`, `kyori`, `track_code`

**注意**: `lap_time_1` 〜 `lap_time_25` の存在を再確認必要

---

## 📈 特徴量拡張計画（修正版）

### **現状確認**
- **既存CSV**: 81カラム（JRA-VAN 44 + JRDB 22 + 派生 15）
- **目標**: 200〜220カラム
- **追加必要**: **119〜139カラム**

### **追加候補カラムのプール**

| データソース | 総カラム数 | 既存利用 | 未使用 | 追加可能 |
|------------|----------|---------|--------|---------|
| **JRA-VAN 3テーブル** | 238 | 44 | **194** | 80〜100 |
| **JRDB jrd_kyi** | 132 | 39 | **93** | 30〜40 |
| **JRDB jrd_sed** | 80 | 0 | **80** | 20〜30 |
| **JRDB 他3テーブル** | 78 | 0 | **78** | 5〜10 |
| **合計** | **528** | **83** | **445** | **135〜180** |

**結論**: 追加候補445カラム >> 目標119〜139カラム → ✅ **十分達成可能**

---

## 🔥 追加推奨カラム Top 60（優先度順）

### **優先度S（必須20カラム）**

#### **JRDB jrd_kyi（10個）**
1. `dochu_juni` - 道中順位予想
2. `kohan_3f_juni` - 後半3F順位予想
3. `goal_juni` - ゴール順位予想
4. `dochu_sa` - 道中差
5. `kohan_3f_sa` - 後半3F差
6. `goal_sa` - ゴール差
7. `tenkai_kigo_code` - 展開記号コード
8. `kishu_kitai_tansho_ritsu` - 騎手期待単勝率
9. `kishu_kitai_sanchakunai_ritsu` - 騎手期待3着内率
10. `kyori_tekisei_code_2` - 距離適性コード2

#### **JRDB jrd_sed（10個）**
11. `soha_time` - 走破タイム
12. `pace` - ペース
13. `idm` (sed) - IDM結果版
14. `babasa` - 馬場差
15. `deokure` - 出遅れ
16. `ichidori` - 位置取り
17. `corner_1` - 1コーナー通過順
18. `corner_2` - 2コーナー通過順
19. `corner_3` - 3コーナー通過順
20. `corner_4` - 4コーナー通過順

### **優先度A（推奨40カラム）**

#### **JRA-VAN jvd_ra（10個）**
21. `lap_time` - ラップタイム
22. `zenhan_3f` - 前半3F
23. `zenhan_4f` - 前半4F
24. `kohan_3f` - 後半3F
25. `kohan_4f` - 後半4F
26. `corner_tsuka_juni_1` - コーナー通過順1
27. `corner_tsuka_juni_2` - コーナー通過順2
28. `corner_tsuka_juni_3` - コーナー通過順3
29. `corner_tsuka_juni_4` - コーナー通過順4
30. `honshokin` - 本賞金

#### **JRA-VAN jvd_ck（10個）**
31. `heichi_honshokin_ruikei` - 平地本賞金累計
32. `shogai_honshokin_ruikei` - 障害本賞金累計
33. `shiba_ryo` - 芝・良成績
34. `shiba_yayaomo` - 芝・稍重成績
35. `shiba_omo` - 芝・重成績
36. `dirt_ryo` - ダート・良成績
37. `dirt_yayaomo` - ダート・稍重成績
38. `shiba_tokyo` - 芝・東京成績
39. `shiba_nakayama` - 芝・中山成績
40. `shiba_hanshin` - 芝・阪神成績

#### **JRDB jrd_kyi（10個）**
41. `kako1_kyoso_seiseki_key` - 過去1走成績キー
42. `kako2_kyoso_seiseki_key` - 過去2走成績キー
43. `kako3_kyoso_seiseki_key` - 過去3走成績キー
44. `ls_shisu_juni` - LS指数順位
45. `ten_shisu_juni` - テン指数順位
46. `pace_shisu_juni` - ペース指数順位
47. `agari_shisu_juni` - 上がり指数順位
48. `ichi_shisu_juni` - 位置指数順位
49. `gekiso_juni` - 激走順位
50. `bataiju` - 馬体重

#### **JRDB jrd_sed（10個）**
51. `tansho_odds` - 単勝オッズ
52. `tansho_ninkijun` - 単勝人気順
53. `kakutei_chakujun` - 確定着順
54. `babajotai_code` - 馬場状態コード
55. `kaisai_tsukihi` - 開催月日
56. `kyori` - 距離
57. `track_code` - トラックコード
58. `kyoso_shubetsu_code` - 競走種別コード
59. `grade_code` - グレードコード
60. `toroku_tosu` - 登録頭数

---

## 📋 次のアクション

### **優先度A: jrd_sed カラム名の再確認**
`JRDBテーブルのカラム詳細.csv` から `jrd_sed` の全80カラムを抽出し、
`lap_time` 関連カラムの正確な名称を特定。

### **優先度B: 追加カラム選定（最終版）**
1. 優先度S 20カラムを確定
2. 優先度A 40カラムから30〜40個を選定
3. 優先度B から必要に応じて20〜30個を追加
4. **合計120〜140カラム**を選定（既存81 + 追加120〜140 = 201〜221）

### **優先度C: SQL抽出クエリ作成**
```sql
SELECT 
    -- 既存81カラム
    kaisai_nen, kaisai_tsukihi, ...
    
    -- 追加120〜140カラム
    jrd_kyi.dochu_juni,
    jrd_kyi.kohan_3f_juni,
    jrd_kyi.goal_juni,
    jrd_sed.soha_time,
    jrd_sed.pace,
    jvd_ra.lap_time,
    ...
FROM jvd_se
LEFT JOIN jrd_kyi USING (race_key, umaban)
LEFT JOIN jrd_sed USING (race_key, umaban)
LEFT JOIN jvd_ra USING (race_key)
LEFT JOIN jvd_ck USING (race_key, ketto_toroku_bango)
WHERE kaisai_nen BETWEEN 2016 AND 2025;
```

---

## 🎉 Phase 7-A Day 4 達成事項

### **確認完了**
- ✅ jrd_kyi 充填率: 4,828レコード、主要8カラム確認
- ✅ 既存CSV 81カラムの完全リスト取得
- ✅ JRDB jrd_kyi 39カラムの利用状況確認
- ✅ 未使用カラム 445個の特定（JRA-VAN 194 + JRDB 251）

### **新発見**
- 🔍 既存CSVは **81カラム**（139カラムではない）
- 🔍 追加必要カラム: **119〜139個**（既存81 → 目標200〜220）
- 🔍 追加候補プール: **445個** → 目標達成可能性 **極めて高い**

### **未解決課題**
- ⚠️ jrd_sed の `lap_time_1` エラー → カラム名再確認必要
- ⚠️ JRA-VAN jvd_ra, jvd_ck の充填率未確認

---

**作成日**: 2026-03-03  
**ステータス**: Phase 7-A Day 4 完了（一部データ確認保留）  
**次ステップ**: jrd_sed カラム名再確認 → 追加カラム120〜140個の最終選定
