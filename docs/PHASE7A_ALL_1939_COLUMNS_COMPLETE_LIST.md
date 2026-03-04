# 全1,939カラム 完全リスト

**作成日**: 2026-03-03  
**データソース**: pgAdmin4から直接取得  
**ハルシネーション**: なし（実データのみ）

---

## 📊 サマリー

- **総カラム数**: 1,939
- **総テーブル数**: 43
- **JRA-VAN**: 38テーブル, 1,649カラム
- **JRDB**: 5テーブル, 290カラム

---

## JRD_BAC

**カラム数**: 27  
**分類**: JRDB  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `keibajo_code` | character varying | 2 |
| 2 | `race_shikonen` | character varying | 6 |
| 3 | `kaisai_kai` | character varying | 1 |
| 4 | `kaisai_nichime` | character varying | 1 |
| 5 | `race_bango` | character varying | 2 |
| 6 | `kaisai_tsukihi` | character varying | 4 |
| 7 | `hasso_jikoku` | character varying | 4 |
| 8 | `kyori` | character varying | 4 |
| 9 | `track_code` | character varying | 3 |
| 10 | `kyoso_shubetsu_code` | character varying | 2 |
| 11 | `kyoso_joken_code` | character varying | 2 |
| 12 | `kyoso_kigo_code` | character varying | 3 |
| 13 | `juryo_shubetsu_code` | character varying | 1 |
| 14 | `grade_code` | character varying | 1 |
| 15 | `kyosomei` | character varying | 50 |
| 16 | `jusho_kaiji` | character varying | 8 |
| 17 | `toroku_tosu` | character varying | 2 |
| 18 | `course_kubun` | character varying | 1 |
| 19 | `kaisai_kubun` | character varying | 1 |
| 20 | `kyosomei_ryakusho_4` | character varying | 8 |
| 21 | `kyosomei_ryakusho_9` | character varying | 18 |
| 22 | `data_kubun` | character varying | 1 |
| 23 | `honshokin` | character varying | 25 |
| 24 | `fukashokin` | character varying | 10 |
| 25 | `baken_hatsubai_flag` | character varying | 16 |
| 26 | `win5_flag` | character varying | 1 |
| 27 | `yobi_1` | character varying | 5 |

---

## JRD_CYB

**カラム数**: 27  
**分類**: JRDB  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `keibajo_code` | character varying | 2 |
| 2 | `race_shikonen` | character varying | 10 |
| 3 | `kaisai_kai` | character varying | 1 |
| 4 | `kaisai_nichime` | character varying | 1 |
| 5 | `race_bango` | character varying | 2 |
| 6 | `umaban` | character varying | 2 |
| 7 | `chokyo_type` | character varying | 2 |
| 8 | `chokyo_corse_shubetsu` | character varying | 1 |
| 9 | `chokyo_corse_hanro` | character varying | 2 |
| 10 | `chokyo_corse_wood` | character varying | 2 |
| 11 | `chokyo_corse_dirt` | character varying | 2 |
| 12 | `chokyo_corse_shiba` | character varying | 2 |
| 13 | `chokyo_corse_pool` | character varying | 2 |
| 14 | `chokyo_corse_shogai` | character varying | 2 |
| 15 | `chokyo_corse_polytrack` | character varying | 2 |
| 16 | `chokyo_kyori` | character varying | 1 |
| 17 | `chokyo_juten` | character varying | 1 |
| 18 | `oikiri_shisu` | character varying | 3 |
| 19 | `shiage_shisu` | character varying | 3 |
| 20 | `chokyo_ryo_hyoka` | character varying | 1 |
| 21 | `shiage_shisu_henka` | character varying | 1 |
| 22 | `chokyo_comment` | character varying | 40 |
| 23 | `comment_nengappi` | character varying | 8 |
| 24 | `chokyo_hyoka` | character varying | 1 |
| 25 | `oikiri_shisu_isshumae` | character varying | 3 |
| 26 | `oikiri_corse_isshumae` | character varying | 2 |
| 27 | `yobi_1` | character varying | 3 |

---

## JRD_JOA

**カラム数**: 24  
**分類**: JRDB  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `keibajo_code` | character varying | 2 |
| 2 | `race_shikonen` | character varying | 10 |
| 3 | `kaisai_kai` | character varying | 1 |
| 4 | `kaisai_nichime` | character varying | 1 |
| 5 | `race_bango` | character varying | 2 |
| 6 | `umaban` | character varying | 2 |
| 7 | `ketto_toroku_bango` | character varying | 8 |
| 8 | `bamei` | character varying | 36 |
| 9 | `kijun_odds_tansho` | character varying | 5 |
| 10 | `kijun_odds_fukusho` | character varying | 5 |
| 11 | `cid_chokyo_soten` | character varying | 5 |
| 12 | `cid_kyusha_soten` | character varying | 5 |
| 13 | `cid_soten` | character varying | 5 |
| 14 | `cid` | character varying | 3 |
| 15 | `ls_shisu` | character varying | 5 |
| 16 | `ls_hyoka` | character varying | 1 |
| 17 | `em` | character varying | 1 |
| 18 | `kyusha_bb_shirushi` | character varying | 1 |
| 19 | `kyusha_bb_nijumaru_tansho_kaishuritsu` | character varying | 5 |
| 20 | `kyusha_bb_nijumaru_rentai_ritsu` | character varying | 5 |
| 21 | `kishu_bb_shirushi` | character varying | 1 |
| 22 | `kishu_bb_nijumaru_tansho_kaishuritsu` | character varying | 5 |
| 23 | `kishu_bb_nijumaru_rentai_ritsu` | character varying | 5 |
| 24 | `yobi_1` | character varying | 3 |

---

## JRD_KYI

**カラム数**: 132  
**分類**: JRDB  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `keibajo_code` | character varying | 2 |
| 2 | `race_shikonen` | character varying | 10 |
| 3 | `kaisai_kai` | character varying | 1 |
| 4 | `kaisai_nichime` | character varying | 1 |
| 5 | `race_bango` | character varying | 2 |
| 6 | `umaban` | character varying | 2 |
| 7 | `ketto_toroku_bango` | character varying | 8 |
| 8 | `bamei` | character varying | 36 |
| 9 | `idm` | character varying | 5 |
| 10 | `kishu_shisu` | character varying | 5 |
| 11 | `joho_shisu` | character varying | 5 |
| 12 | `yobi_1` | character varying | 15 |
| 13 | `sogo_shisu` | character varying | 5 |
| 14 | `kyakushitsu_code` | character varying | 1 |
| 15 | `kyori_tekisei_code` | character varying | 1 |
| 16 | `joshodo_code` | character varying | 1 |
| 17 | `rotation` | character varying | 3 |
| 18 | `kijun_odds_tansho` | character varying | 5 |
| 19 | `kijun_ninkijun_tansho` | character varying | 2 |
| 20 | `kijun_odds_fukusho` | character varying | 5 |
| 21 | `kijun_ninkijun_fukusho` | character varying | 2 |
| 22 | `tokutei_joho_1` | character varying | 3 |
| 23 | `tokutei_joho_2` | character varying | 3 |
| 24 | `tokutei_joho_3` | character varying | 3 |
| 25 | `tokutei_joho_4` | character varying | 3 |
| 26 | `tokutei_joho_5` | character varying | 3 |
| 27 | `sogo_joho_1` | character varying | 3 |
| 28 | `sogo_joho_2` | character varying | 3 |
| 29 | `sogo_joho_3` | character varying | 3 |
| 30 | `sogo_joho_4` | character varying | 3 |
| 31 | `sogo_joho_5` | character varying | 3 |
| 32 | `ninki_shisu` | character varying | 5 |
| 33 | `chokyo_shisu` | character varying | 5 |
| 34 | `kyusha_shisu` | character varying | 5 |
| 35 | `chokyo_yajirushi_code` | character varying | 1 |
| 36 | `kyusha_hyoka_code` | character varying | 1 |
| 37 | `kishu_kitai_rentai_ritsu` | character varying | 4 |
| 38 | `gekiso_shisu` | character varying | 3 |
| 39 | `hizume_code` | character varying | 2 |
| 40 | `tekisei_code_omo` | character varying | 1 |
| 41 | `class_code` | character varying | 2 |
| 42 | `yobi_2` | character varying | 2 |
| 43 | `blinker_shiyo_kubun` | character varying | 1 |
| 44 | `kishumei` | character varying | 12 |
| 45 | `futan_juryo` | character varying | 3 |
| 46 | `kishu_minarai_code` | character varying | 1 |
| 47 | `chokyoshimei` | character varying | 12 |
| 48 | `chokyoshi_shozoku` | character varying | 4 |
| 49 | `kako1_kyoso_seiseki_key` | character varying | 16 |
| 50 | `kako2_kyoso_seiseki_key` | character varying | 16 |
| 51 | `kako3_kyoso_seiseki_key` | character varying | 16 |
| 52 | `kako4_kyoso_seiseki_key` | character varying | 16 |
| 53 | `kako5_kyoso_seiseki_key` | character varying | 16 |
| 54 | `kako1_race_key` | character varying | 8 |
| 55 | `kako2_race_key` | character varying | 8 |
| 56 | `kako3_race_key` | character varying | 8 |
| 57 | `kako4_race_key` | character varying | 8 |
| 58 | `kako5_race_key` | character varying | 8 |
| 59 | `wakuban` | character varying | 1 |
| 60 | `yobi_3` | character varying | 2 |
| 61 | `shirushi_code_1` | character varying | 1 |
| 62 | `shirushi_code_2` | character varying | 1 |
| 63 | `shirushi_code_3` | character varying | 1 |
| 64 | `shirushi_code_4` | character varying | 1 |
| 65 | `shirushi_code_5` | character varying | 1 |
| 66 | `shirushi_code_6` | character varying | 1 |
| 67 | `shirushi_code_7` | character varying | 1 |
| 68 | `tekisei_code_shiba` | character varying | 1 |
| 69 | `tekisei_code_dirt` | character varying | 1 |
| 70 | `kishu_code` | character varying | 5 |
| 71 | `chokyoshi_code` | character varying | 5 |
| 72 | `yobi_4` | character varying | 1 |
| 73 | `kakutoku_shokin_ruikei` | character varying | 6 |
| 74 | `shutoku_shokin_ruikei` | character varying | 5 |
| 75 | `joken_class_code` | character varying | 1 |
| 76 | `ten_shisu` | character varying | 5 |
| 77 | `pace_shisu` | character varying | 5 |
| 78 | `agari_shisu` | character varying | 5 |
| 79 | `ichi_shisu` | character varying | 5 |
| 80 | `pace_yoso` | character varying | 1 |
| 81 | `dochu_juni` | character varying | 2 |
| 82 | `dochu_sa` | character varying | 2 |
| 83 | `dochu_uchisoto` | character varying | 1 |
| 84 | `kohan_3f_juni` | character varying | 2 |
| 85 | `kohan_3f_sa` | character varying | 2 |
| 86 | `kohan_3f_uchisoto` | character varying | 1 |
| 87 | `goal_juni` | character varying | 2 |
| 88 | `goal_sa` | character varying | 2 |
| 89 | `goal_uchisoto` | character varying | 1 |
| 90 | `tenkai_kigo_code` | character varying | 1 |
| 91 | `kyori_tekisei_code_2` | character varying | 1 |
| 92 | `bataiju` | character varying | 3 |
| 93 | `bataiju_zogen` | character varying | 3 |
| 94 | `torikeshi_flag` | character varying | 1 |
| 95 | `seibetsu_code` | character varying | 1 |
| 96 | `banushimei` | character varying | 40 |
| 97 | `banushikai_code` | character varying | 2 |
| 98 | `umakigo_code` | character varying | 2 |
| 99 | `gekiso_juni` | character varying | 2 |
| 100 | `ls_shisu_juni` | character varying | 2 |
| 101 | `ten_shisu_juni` | character varying | 2 |
| 102 | `pace_shisu_juni` | character varying | 2 |
| 103 | `agari_shisu_juni` | character varying | 2 |
| 104 | `ichi_shisu_juni` | character varying | 2 |
| 105 | `kishu_kitai_tansho_ritsu` | character varying | 4 |
| 106 | `kishu_kitai_sanchakunai_ritsu` | character varying | 4 |
| 107 | `yuso_kubun` | character varying | 1 |
| 108 | `soho` | character varying | 8 |
| 109 | `taikei` | character varying | 24 |
| 110 | `taikei_sogo_1` | character varying | 3 |
| 111 | `taikei_sogo_2` | character varying | 3 |
| 112 | `taikei_sogo_3` | character varying | 3 |
| 113 | `uma_tokki_1` | character varying | 3 |
| 114 | `uma_tokki_2` | character varying | 3 |
| 115 | `uma_tokki_3` | character varying | 3 |
| 116 | `uma_start_shisu` | character varying | 4 |
| 117 | `uma_deokure_ritsu` | character varying | 4 |
| 118 | `sanko_zenso` | character varying | 2 |
| 119 | `sanko_zenso_kishu_code` | character varying | 5 |
| 120 | `manken_shisu` | character varying | 3 |
| 121 | `manken_shirushi` | character varying | 1 |
| 122 | `kokyu_flag` | character varying | 1 |
| 123 | `gekiso_type` | character varying | 2 |
| 124 | `kyuyo_riyu_bunrui_code` | character varying | 2 |
| 125 | `flag` | character varying | 16 |
| 126 | `nyukyu_nansome` | character varying | 2 |
| 127 | `nyukyu_nengappi` | character varying | 8 |
| 128 | `nyukyu_nannichimae` | character varying | 3 |
| 129 | `hobokusaki` | character varying | 50 |
| 130 | `hobokusaki_rank` | character varying | 1 |
| 131 | `kyusha_rank` | character varying | 1 |
| 132 | `yobi_5` | character varying | 398 |

---

## JRD_SED

**カラム数**: 80  
**分類**: JRDB  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `keibajo_code` | character varying | 2 |
| 2 | `race_shikonen` | character varying | 10 |
| 3 | `kaisai_kai` | character varying | 1 |
| 4 | `kaisai_nichime` | character varying | 1 |
| 5 | `race_bango` | character varying | 2 |
| 6 | `umaban` | character varying | 2 |
| 7 | `ketto_toroku_bango` | character varying | 8 |
| 8 | `kaisai_nen` | character varying | 4 |
| 9 | `kaisai_tsukihi` | character varying | 4 |
| 10 | `bamei` | character varying | 36 |
| 11 | `kyori` | character varying | 4 |
| 12 | `track_code` | character varying | 3 |
| 13 | `babajotai_code` | character varying | 2 |
| 14 | `kyoso_shubetsu_code` | character varying | 2 |
| 15 | `kyoso_joken_code` | character varying | 2 |
| 16 | `kyoso_kigo_code` | character varying | 3 |
| 17 | `juryo_shubetsu_code` | character varying | 1 |
| 18 | `grade_code` | character varying | 1 |
| 19 | `kyosomei` | character varying | 50 |
| 20 | `toroku_tosu` | character varying | 2 |
| 21 | `kyosomei_ryakusho_4` | character varying | 8 |
| 22 | `kakutei_chakujun` | character varying | 2 |
| 23 | `ijo_kubun_code` | character varying | 1 |
| 24 | `soha_time` | character varying | 4 |
| 25 | `futan_juryo` | character varying | 3 |
| 26 | `kishumei` | character varying | 12 |
| 27 | `chokyoshimei` | character varying | 12 |
| 28 | `tansho_odds` | character varying | 6 |
| 29 | `tansho_ninkijun` | character varying | 2 |
| 30 | `idm` | character varying | 3 |
| 31 | `soten` | character varying | 3 |
| 32 | `babasa` | character varying | 3 |
| 33 | `pace` | character varying | 3 |
| 34 | `deokure` | character varying | 3 |
| 35 | `ichidori` | character varying | 3 |
| 36 | `furi` | character varying | 3 |
| 37 | `furi_1` | character varying | 3 |
| 38 | `furi_2` | character varying | 3 |
| 39 | `furi_3` | character varying | 3 |
| 40 | `race` | character varying | 3 |
| 41 | `course_dori_code` | character varying | 1 |
| 42 | `joshodo_code` | character varying | 1 |
| 43 | `class_code` | character varying | 2 |
| 44 | `batai_code` | character varying | 1 |
| 45 | `kehai_code` | character varying | 1 |
| 46 | `race_pace` | character varying | 1 |
| 47 | `uma_pace` | character varying | 1 |
| 48 | `ten_shisu` | character varying | 5 |
| 49 | `agari_shisu` | character varying | 5 |
| 50 | `pace_shisu` | character varying | 5 |
| 51 | `race_p_shisu` | character varying | 5 |
| 52 | `aiteuma_joho_1` | character varying | 15 |
| 53 | `zenhan_3f_taimu` | character varying | 3 |
| 54 | `kohan_3f` | character varying | 3 |
| 55 | `biko` | character varying | 24 |
| 56 | `yobi_1` | character varying | 2 |
| 57 | `odds_fukusho` | character varying | 6 |
| 58 | `odds_tansho_10am` | character varying | 6 |
| 59 | `odds_fukusho_10am` | character varying | 6 |
| 60 | `corner_1` | character varying | 2 |
| 61 | `corner_2` | character varying | 2 |
| 62 | `corner_3` | character varying | 2 |
| 63 | `corner_4` | character varying | 2 |
| 64 | `zenhan_3f_sento_sa` | character varying | 3 |
| 65 | `kohan_3f_sento_sa` | character varying | 3 |
| 66 | `kishu_code` | character varying | 5 |
| 67 | `chokyoshi_code` | character varying | 5 |
| 68 | `bataiju` | character varying | 3 |
| 69 | `bataiju_zogen` | character varying | 3 |
| 70 | `tenko_code` | character varying | 1 |
| 71 | `course_kubun` | character varying | 1 |
| 72 | `kyakushitsu_code` | character varying | 1 |
| 73 | `haraimodoshi_tansho` | character varying | 7 |
| 74 | `haraimodoshi_fukusho` | character varying | 7 |
| 75 | `honshokin` | character varying | 5 |
| 76 | `shutoku_shokin` | character varying | 5 |
| 77 | `race_pace_nagare` | character varying | 2 |
| 78 | `uma_pace_nagare` | character varying | 2 |
| 79 | `corse_dori_code_corner_4` | character varying | 1 |
| 80 | `hasso_jikoku` | character varying | 4 |

---

## JVD_AV

**カラム数**: 13  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `umaban` | character varying | 2 |
| 12 | `bamei` | character varying | 36 |
| 13 | `jiyu_kubun` | character varying | 3 |

---

## JVD_BN

**カラム数**: 11  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `banushi_code` | character varying | 6 |
| 5 | `banushimei_hojinkaku` | character varying | 64 |
| 6 | `banushimei` | character varying | 64 |
| 7 | `banushimei_hankaku_kana` | character varying | 50 |
| 8 | `banushimei_eur` | character varying | 100 |
| 9 | `fukushoku_hyoji` | character varying | 60 |
| 10 | `seiseki_joho_1` | character varying | 60 |
| 11 | `seiseki_joho_2` | character varying | 60 |

---

## JVD_BR

**カラム数**: 11  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `seisansha_code` | character varying | 8 |
| 5 | `seisanshamei_hojinkaku` | character varying | 72 |
| 6 | `seisanshamei` | character varying | 72 |
| 7 | `seisanshamei_hankaku_kana` | character varying | 72 |
| 8 | `seisanshamei_eur` | character varying | 168 |
| 9 | `seisansha_jusho_jichishomei` | character varying | 20 |
| 10 | `seiseki_joho_1` | character varying | 60 |
| 11 | `seiseki_joho_2` | character varying | 60 |

---

## JVD_BT

**カラム数**: 7  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `hanshoku_toroku_bango` | character varying | 10 |
| 5 | `keito_id` | character varying | 30 |
| 6 | `keito_mei` | character varying | 36 |
| 7 | `keito_setsumei` | character varying | 6800 |

---

## JVD_CC

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `kyori` | character varying | 4 |
| 12 | `track_code` | character varying | 2 |
| 13 | `kyori_henkomae` | character varying | 4 |
| 14 | `track_code_henkomae` | character varying | 2 |
| 15 | `jiyu_kubun` | character varying | 1 |

---

## JVD_CH

**カラム数**: 21  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `chokyoshi_code` | character varying | 5 |
| 5 | `massho_kubun` | character varying | 1 |
| 6 | `menkyo_kofu_nengappi` | character varying | 8 |
| 7 | `menkyo_massho_nengappi` | character varying | 8 |
| 8 | `seinengappi` | character varying | 8 |
| 9 | `chokyoshimei` | character varying | 34 |
| 10 | `chokyoshimei_hankaku_kana` | character varying | 30 |
| 11 | `chokyoshimei_ryakusho` | character varying | 8 |
| 12 | `chokyoshimei_eur` | character varying | 80 |
| 13 | `seibetsu_kubun` | character varying | 1 |
| 14 | `tozai_shozoku_code` | character varying | 1 |
| 15 | `shotai_chiikimei` | character varying | 20 |
| 16 | `jushoshori_joho_1` | character varying | 163 |
| 17 | `jushoshori_joho_2` | character varying | 163 |
| 18 | `jushoshori_joho_3` | character varying | 163 |
| 19 | `seiseki_joho_1` | character varying | 1052 |
| 20 | `seiseki_joho_2` | character varying | 1052 |
| 21 | `seiseki_joho_3` | character varying | 1052 |

---

## JVD_CK

**カラム数**: 106  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `ketto_toroku_bango` | character varying | 10 |
| 11 | `bamei` | character varying | 36 |
| 12 | `heichi_honshokin_ruikei` | character varying | 9 |
| 13 | `shogai_honshokin_ruikei` | character varying | 9 |
| 14 | `heichi_fukashokin_ruikei` | character varying | 9 |
| 15 | `shogai_fukashokin_ruikei` | character varying | 9 |
| 16 | `heichi_shutokushokin_ruikei` | character varying | 9 |
| 17 | `shogai_shutokushokin_ruikei` | character varying | 9 |
| 18 | `sogo` | character varying | 18 |
| 19 | `chuo_gokei` | character varying | 18 |
| 20 | `shiba_choku` | character varying | 18 |
| 21 | `shiba_migi` | character varying | 18 |
| 22 | `shiba_hidari` | character varying | 18 |
| 23 | `dirt_choku` | character varying | 18 |
| 24 | `dirt_migi` | character varying | 18 |
| 25 | `dirt_hidari` | character varying | 18 |
| 26 | `shogai` | character varying | 18 |
| 27 | `shiba_ryo` | character varying | 18 |
| 28 | `shiba_yayaomo` | character varying | 18 |
| 29 | `shiba_omo` | character varying | 18 |
| 30 | `shiba_furyo` | character varying | 18 |
| 31 | `dirt_ryo` | character varying | 18 |
| 32 | `dirt_yayaomo` | character varying | 18 |
| 33 | `dirt_omo` | character varying | 18 |
| 34 | `dirt_furyo` | character varying | 18 |
| 35 | `shogai_ryo` | character varying | 18 |
| 36 | `shogai_yayaomo` | character varying | 18 |
| 37 | `shogai_omo` | character varying | 18 |
| 38 | `shogai_furyo` | character varying | 18 |
| 39 | `shiba_1200_ika` | character varying | 18 |
| 40 | `shiba_1201_1400` | character varying | 18 |
| 41 | `shiba_1401_1600` | character varying | 18 |
| 42 | `shiba_1601_1800` | character varying | 18 |
| 43 | `shiba_1801_2000` | character varying | 18 |
| 44 | `shiba_2001_2200` | character varying | 18 |
| 45 | `shiba_2201_2400` | character varying | 18 |
| 46 | `shiba_2401_2800` | character varying | 18 |
| 47 | `shiba_2801_ijo` | character varying | 18 |
| 48 | `dirt_1200_ika` | character varying | 18 |
| 49 | `dirt_1201_1400` | character varying | 18 |
| 50 | `dirt_1401_1600` | character varying | 18 |
| 51 | `dirt_1601_1800` | character varying | 18 |
| 52 | `dirt_1801_2000` | character varying | 18 |
| 53 | `dirt_2001_2200` | character varying | 18 |
| 54 | `dirt_2201_2400` | character varying | 18 |
| 55 | `dirt_2401_2800` | character varying | 18 |
| 56 | `dirt_2801_ijo` | character varying | 18 |
| 57 | `shiba_sapporo` | character varying | 18 |
| 58 | `shiba_hakodate` | character varying | 18 |
| 59 | `shiba_fukushima` | character varying | 18 |
| 60 | `shiba_niigata` | character varying | 18 |
| 61 | `shiba_tokyo` | character varying | 18 |
| 62 | `shiba_nakayama` | character varying | 18 |
| 63 | `shiba_chukyo` | character varying | 18 |
| 64 | `shiba_kyoto` | character varying | 18 |
| 65 | `shiba_hanshin` | character varying | 18 |
| 66 | `shiba_kokura` | character varying | 18 |
| 67 | `dirt_sapporo` | character varying | 18 |
| 68 | `dirt_hakodate` | character varying | 18 |
| 69 | `dirt_fukushima` | character varying | 18 |
| 70 | `dirt_niigata` | character varying | 18 |
| 71 | `dirt_tokyo` | character varying | 18 |
| 72 | `dirt_nakayama` | character varying | 18 |
| 73 | `dirt_chukyo` | character varying | 18 |
| 74 | `dirt_kyoto` | character varying | 18 |
| 75 | `dirt_hanshin` | character varying | 18 |
| 76 | `dirt_kokura` | character varying | 18 |
| 77 | `shogai_sapporo` | character varying | 18 |
| 78 | `shogai_hakodate` | character varying | 18 |
| 79 | `shogai_fukushima` | character varying | 18 |
| 80 | `shogai_niigata` | character varying | 18 |
| 81 | `shogai_tokyo` | character varying | 18 |
| 82 | `shogai_nakayama` | character varying | 18 |
| 83 | `shogai_chukyo` | character varying | 18 |
| 84 | `shogai_kyoto` | character varying | 18 |
| 85 | `shogai_hanshin` | character varying | 18 |
| 86 | `shogai_kokura` | character varying | 18 |
| 87 | `kyakushitsu_keiko` | character varying | 12 |
| 88 | `toroku_race_su` | character varying | 3 |
| 89 | `kishu_code` | character varying | 5 |
| 90 | `kishumei` | character varying | 34 |
| 91 | `seiseki_joho_kishu_1` | character varying | 1220 |
| 92 | `seiseki_joho_kishu_2` | character varying | 1220 |
| 93 | `chokyoshi_code` | character varying | 5 |
| 94 | `chokyoshimei` | character varying | 34 |
| 95 | `seiseki_joho_chokyoshi_1` | character varying | 1220 |
| 96 | `seiseki_joho_chokyoshi_2` | character varying | 1220 |
| 97 | `banushi_code` | character varying | 6 |
| 98 | `banushimei_hojinkaku` | character varying | 64 |
| 99 | `banushimei` | character varying | 64 |
| 100 | `seiseki_joho_banushi_1` | character varying | 60 |
| 101 | `seiseki_joho_banushi_2` | character varying | 60 |
| 102 | `seisansha_code` | character varying | 8 |
| 103 | `seisanshamei_hojinkaku` | character varying | 72 |
| 104 | `seisanshamei` | character varying | 72 |
| 105 | `seiseki_joho_seisansha_1` | character varying | 60 |
| 106 | `seiseki_joho_seisansha_2` | character varying | 60 |

---

## JVD_CS

**カラム数**: 8  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `keibajo_code` | character varying | 2 |
| 5 | `kyori` | character varying | 4 |
| 6 | `track_code` | character varying | 2 |
| 7 | `course_kaishu_nengappi` | character varying | 8 |
| 8 | `course_setsumei` | character varying | 6800 |

---

## JVD_DM

**カラム数**: 28  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `data_sakusei_jifun` | character varying | 4 |
| 11 | `mining_yoso_01` | character varying | 15 |
| 12 | `mining_yoso_02` | character varying | 15 |
| 13 | `mining_yoso_03` | character varying | 15 |
| 14 | `mining_yoso_04` | character varying | 15 |
| 15 | `mining_yoso_05` | character varying | 15 |
| 16 | `mining_yoso_06` | character varying | 15 |
| 17 | `mining_yoso_07` | character varying | 15 |
| 18 | `mining_yoso_08` | character varying | 15 |
| 19 | `mining_yoso_09` | character varying | 15 |
| 20 | `mining_yoso_10` | character varying | 15 |
| 21 | `mining_yoso_11` | character varying | 15 |
| 22 | `mining_yoso_12` | character varying | 15 |
| 23 | `mining_yoso_13` | character varying | 15 |
| 24 | `mining_yoso_14` | character varying | 15 |
| 25 | `mining_yoso_15` | character varying | 15 |
| 26 | `mining_yoso_16` | character varying | 15 |
| 27 | `mining_yoso_17` | character varying | 15 |
| 28 | `mining_yoso_18` | character varying | 15 |

---

## JVD_H1

**カラム数**: 43  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `toroku_tosu` | character varying | 2 |
| 11 | `shusso_tosu` | character varying | 2 |
| 12 | `hatsubai_flag_tansho` | character varying | 1 |
| 13 | `hatsubai_flag_fukusho` | character varying | 1 |
| 14 | `hatsubai_flag_wakuren` | character varying | 1 |
| 15 | `hatsubai_flag_umaren` | character varying | 1 |
| 16 | `hatsubai_flag_wide` | character varying | 1 |
| 17 | `hatsubai_flag_umatan` | character varying | 1 |
| 18 | `hatsubai_flag_sanrenpuku` | character varying | 1 |
| 19 | `fukusho_chakubarai_key` | character varying | 1 |
| 20 | `henkan_umaban_joho` | character varying | 28 |
| 21 | `henkan_wakuban_joho` | character varying | 8 |
| 22 | `henkan_dowaku_joho` | character varying | 8 |
| 23 | `hyosu_tansho` | character varying | 420 |
| 24 | `hyosu_fukusho` | character varying | 420 |
| 25 | `hyosu_wakuren` | character varying | 540 |
| 26 | `hyosu_umaren` | character varying | 2754 |
| 27 | `hyosu_wide` | character varying | 2754 |
| 28 | `hyosu_umatan` | character varying | 5508 |
| 29 | `hyosu_sanrenpuku` | character varying | 16320 |
| 30 | `hyosu_gokei_tansho` | character varying | 11 |
| 31 | `hyosu_gokei_fukusho` | character varying | 11 |
| 32 | `hyosu_gokei_wakuren` | character varying | 11 |
| 33 | `hyosu_gokei_umaren` | character varying | 11 |
| 34 | `hyosu_gokei_wide` | character varying | 11 |
| 35 | `hyosu_gokei_umatan` | character varying | 11 |
| 36 | `hyosu_gokei_sanrenpuku` | character varying | 11 |
| 37 | `henkan_hyosu_gokei_tansho` | character varying | 11 |
| 38 | `henkan_hyosu_gokei_fukusho` | character varying | 11 |
| 39 | `henkan_hyosu_gokei_wakuren` | character varying | 11 |
| 40 | `henkan_hyosu_gokei_umaren` | character varying | 11 |
| 41 | `henkan_hyosu_gokei_wide` | character varying | 11 |
| 42 | `henkan_hyosu_gokei_umatan` | character varying | 11 |
| 43 | `henkan_hyosu_gokei_sanrenpuku` | character varying | 11 |

---

## JVD_H6

**カラム数**: 16  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `toroku_tosu` | character varying | 2 |
| 11 | `shusso_tosu` | character varying | 2 |
| 12 | `hatsubai_flag_sanrentan` | character varying | 1 |
| 13 | `henkan_umaban_joho` | character varying | 18 |
| 14 | `hyosu_sanrentan` | character varying | 102816 |
| 15 | `hyosu_gokei_sanrentan` | character varying | 11 |
| 16 | `henkan_hyosu_gokei_sanrentan` | character varying | 11 |

---

## JVD_HC

**カラム数**: 14  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `tracen_kubun` | character varying | 1 |
| 5 | `chokyo_nengappi` | character varying | 8 |
| 6 | `chokyo_jikoku` | character varying | 4 |
| 7 | `ketto_toroku_bango` | character varying | 10 |
| 8 | `time_gokei_4f` | character varying | 4 |
| 9 | `lap_time_4f` | character varying | 3 |
| 10 | `time_gokei_3f` | character varying | 4 |
| 11 | `lap_time_3f` | character varying | 3 |
| 12 | `time_gokei_2f` | character varying | 4 |
| 13 | `lap_time_2f` | character varying | 3 |
| 14 | `lap_time_1f` | character varying | 3 |

---

## JVD_HN

**カラム数**: 19  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `hanshoku_toroku_bango` | character varying | 10 |
| 5 | `yobi_1` | character varying | 8 |
| 6 | `ketto_toroku_bango` | character varying | 10 |
| 7 | `yobi_2` | character varying | 1 |
| 8 | `bamei` | character varying | 36 |
| 9 | `bamei_hankaku_kana` | character varying | 40 |
| 10 | `bamei_eur` | character varying | 80 |
| 11 | `seinen` | character varying | 4 |
| 12 | `seibetsu_code` | character varying | 1 |
| 13 | `hinshu_code` | character varying | 1 |
| 14 | `moshoku_code` | character varying | 2 |
| 15 | `mochikomi_kubun` | character varying | 1 |
| 16 | `yunyu_nen` | character varying | 4 |
| 17 | `sanchimei` | character varying | 20 |
| 18 | `ketto_joho_01a` | character varying | 10 |
| 19 | `ketto_joho_02a` | character varying | 10 |

---

## JVD_HR

**カラム数**: 158  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `toroku_tosu` | character varying | 2 |
| 11 | `shusso_tosu` | character varying | 2 |
| 12 | `fuseiritsu_flag_tansho` | character varying | 1 |
| 13 | `fuseiritsu_flag_fukusho` | character varying | 1 |
| 14 | `fuseiritsu_flag_wakuren` | character varying | 1 |
| 15 | `fuseiritsu_flag_umaren` | character varying | 1 |
| 16 | `fuseiritsu_flag_wide` | character varying | 1 |
| 17 | `yobi_1` | character varying | 1 |
| 18 | `fuseiritsu_flag_umatan` | character varying | 1 |
| 19 | `fuseiritsu_flag_sanrenpuku` | character varying | 1 |
| 20 | `fuseiritsu_flag_sanrentan` | character varying | 1 |
| 21 | `tokubarai_flag_tansho` | character varying | 1 |
| 22 | `tokubarai_flag_fukusho` | character varying | 1 |
| 23 | `tokubarai_flag_wakuren` | character varying | 1 |
| 24 | `tokubarai_flag_umaren` | character varying | 1 |
| 25 | `tokubarai_flag_wide` | character varying | 1 |
| 26 | `yobi_2` | character varying | 1 |
| 27 | `tokubarai_flag_umatan` | character varying | 1 |
| 28 | `tokubarai_flag_sanrenpuku` | character varying | 1 |
| 29 | `tokubarai_flag_sanrentan` | character varying | 1 |
| 30 | `henkan_flag_tansho` | character varying | 1 |
| 31 | `henkan_flag_fukusho` | character varying | 1 |
| 32 | `henkan_flag_wakuren` | character varying | 1 |
| 33 | `henkan_flag_umaren` | character varying | 1 |
| 34 | `henkan_flag_wide` | character varying | 1 |
| 35 | `yobi_3` | character varying | 1 |
| 36 | `henkan_flag_umatan` | character varying | 1 |
| 37 | `henkan_flag_sanrenpuku` | character varying | 1 |
| 38 | `henkan_flag_sanrentan` | character varying | 1 |
| 39 | `henkan_umaban_joho` | character varying | 28 |
| 40 | `henkan_wakuban_joho` | character varying | 8 |
| 41 | `henkan_dowaku_joho` | character varying | 8 |
| 42 | `haraimodoshi_tansho_1a` | character varying | 2 |
| 43 | `haraimodoshi_tansho_1b` | character varying | 9 |
| 44 | `haraimodoshi_tansho_1c` | character varying | 2 |
| 45 | `haraimodoshi_tansho_2a` | character varying | 2 |
| 46 | `haraimodoshi_tansho_2b` | character varying | 9 |
| 47 | `haraimodoshi_tansho_2c` | character varying | 2 |
| 48 | `haraimodoshi_tansho_3a` | character varying | 2 |
| 49 | `haraimodoshi_tansho_3b` | character varying | 9 |
| 50 | `haraimodoshi_tansho_3c` | character varying | 2 |
| 51 | `haraimodoshi_fukusho_1a` | character varying | 2 |
| 52 | `haraimodoshi_fukusho_1b` | character varying | 9 |
| 53 | `haraimodoshi_fukusho_1c` | character varying | 2 |
| 54 | `haraimodoshi_fukusho_2a` | character varying | 2 |
| 55 | `haraimodoshi_fukusho_2b` | character varying | 9 |
| 56 | `haraimodoshi_fukusho_2c` | character varying | 2 |
| 57 | `haraimodoshi_fukusho_3a` | character varying | 2 |
| 58 | `haraimodoshi_fukusho_3b` | character varying | 9 |
| 59 | `haraimodoshi_fukusho_3c` | character varying | 2 |
| 60 | `haraimodoshi_fukusho_4a` | character varying | 2 |
| 61 | `haraimodoshi_fukusho_4b` | character varying | 9 |
| 62 | `haraimodoshi_fukusho_4c` | character varying | 2 |
| 63 | `haraimodoshi_fukusho_5a` | character varying | 2 |
| 64 | `haraimodoshi_fukusho_5b` | character varying | 9 |
| 65 | `haraimodoshi_fukusho_5c` | character varying | 2 |
| 66 | `haraimodoshi_wakuren_1a` | character varying | 2 |
| 67 | `haraimodoshi_wakuren_1b` | character varying | 9 |
| 68 | `haraimodoshi_wakuren_1c` | character varying | 2 |
| 69 | `haraimodoshi_wakuren_2a` | character varying | 2 |
| 70 | `haraimodoshi_wakuren_2b` | character varying | 9 |
| 71 | `haraimodoshi_wakuren_2c` | character varying | 2 |
| 72 | `haraimodoshi_wakuren_3a` | character varying | 2 |
| 73 | `haraimodoshi_wakuren_3b` | character varying | 9 |
| 74 | `haraimodoshi_wakuren_3c` | character varying | 2 |
| 75 | `haraimodoshi_umaren_1a` | character varying | 4 |
| 76 | `haraimodoshi_umaren_1b` | character varying | 9 |
| 77 | `haraimodoshi_umaren_1c` | character varying | 3 |
| 78 | `haraimodoshi_umaren_2a` | character varying | 4 |
| 79 | `haraimodoshi_umaren_2b` | character varying | 9 |
| 80 | `haraimodoshi_umaren_2c` | character varying | 3 |
| 81 | `haraimodoshi_umaren_3a` | character varying | 4 |
| 82 | `haraimodoshi_umaren_3b` | character varying | 9 |
| 83 | `haraimodoshi_umaren_3c` | character varying | 3 |
| 84 | `haraimodoshi_wide_1a` | character varying | 4 |
| 85 | `haraimodoshi_wide_1b` | character varying | 9 |
| 86 | `haraimodoshi_wide_1c` | character varying | 3 |
| 87 | `haraimodoshi_wide_2a` | character varying | 4 |
| 88 | `haraimodoshi_wide_2b` | character varying | 9 |
| 89 | `haraimodoshi_wide_2c` | character varying | 3 |
| 90 | `haraimodoshi_wide_3a` | character varying | 4 |
| 91 | `haraimodoshi_wide_3b` | character varying | 9 |
| 92 | `haraimodoshi_wide_3c` | character varying | 3 |
| 93 | `haraimodoshi_wide_4a` | character varying | 4 |
| 94 | `haraimodoshi_wide_4b` | character varying | 9 |
| 95 | `haraimodoshi_wide_4c` | character varying | 3 |
| 96 | `haraimodoshi_wide_5a` | character varying | 4 |
| 97 | `haraimodoshi_wide_5b` | character varying | 9 |
| 98 | `haraimodoshi_wide_5c` | character varying | 3 |
| 99 | `haraimodoshi_wide_6a` | character varying | 4 |
| 100 | `haraimodoshi_wide_6b` | character varying | 9 |
| 101 | `haraimodoshi_wide_6c` | character varying | 3 |
| 102 | `haraimodoshi_wide_7a` | character varying | 4 |
| 103 | `haraimodoshi_wide_7b` | character varying | 9 |
| 104 | `haraimodoshi_wide_7c` | character varying | 3 |
| 105 | `yobi_4_1a` | character varying | 4 |
| 106 | `yobi_4_1b` | character varying | 9 |
| 107 | `yobi_4_1c` | character varying | 3 |
| 108 | `yobi_4_2a` | character varying | 4 |
| 109 | `yobi_4_2b` | character varying | 9 |
| 110 | `yobi_4_2c` | character varying | 3 |
| 111 | `yobi_4_3a` | character varying | 4 |
| 112 | `yobi_4_3b` | character varying | 9 |
| 113 | `yobi_4_3c` | character varying | 3 |
| 114 | `haraimodoshi_umatan_1a` | character varying | 4 |
| 115 | `haraimodoshi_umatan_1b` | character varying | 9 |
| 116 | `haraimodoshi_umatan_1c` | character varying | 3 |
| 117 | `haraimodoshi_umatan_2a` | character varying | 4 |
| 118 | `haraimodoshi_umatan_2b` | character varying | 9 |
| 119 | `haraimodoshi_umatan_2c` | character varying | 3 |
| 120 | `haraimodoshi_umatan_3a` | character varying | 4 |
| 121 | `haraimodoshi_umatan_3b` | character varying | 9 |
| 122 | `haraimodoshi_umatan_3c` | character varying | 3 |
| 123 | `haraimodoshi_umatan_4a` | character varying | 4 |
| 124 | `haraimodoshi_umatan_4b` | character varying | 9 |
| 125 | `haraimodoshi_umatan_4c` | character varying | 3 |
| 126 | `haraimodoshi_umatan_5a` | character varying | 4 |
| 127 | `haraimodoshi_umatan_5b` | character varying | 9 |
| 128 | `haraimodoshi_umatan_5c` | character varying | 3 |
| 129 | `haraimodoshi_umatan_6a` | character varying | 4 |
| 130 | `haraimodoshi_umatan_6b` | character varying | 9 |
| 131 | `haraimodoshi_umatan_6c` | character varying | 3 |
| 132 | `haraimodoshi_sanrenpuku_1a` | character varying | 6 |
| 133 | `haraimodoshi_sanrenpuku_1b` | character varying | 9 |
| 134 | `haraimodoshi_sanrenpuku_1c` | character varying | 3 |
| 135 | `haraimodoshi_sanrenpuku_2a` | character varying | 6 |
| 136 | `haraimodoshi_sanrenpuku_2b` | character varying | 9 |
| 137 | `haraimodoshi_sanrenpuku_2c` | character varying | 3 |
| 138 | `haraimodoshi_sanrenpuku_3a` | character varying | 6 |
| 139 | `haraimodoshi_sanrenpuku_3b` | character varying | 9 |
| 140 | `haraimodoshi_sanrenpuku_3c` | character varying | 3 |
| 141 | `haraimodoshi_sanrentan_1a` | character varying | 6 |
| 142 | `haraimodoshi_sanrentan_1b` | character varying | 9 |
| 143 | `haraimodoshi_sanrentan_1c` | character varying | 4 |
| 144 | `haraimodoshi_sanrentan_2a` | character varying | 6 |
| 145 | `haraimodoshi_sanrentan_2b` | character varying | 9 |
| 146 | `haraimodoshi_sanrentan_2c` | character varying | 4 |
| 147 | `haraimodoshi_sanrentan_3a` | character varying | 6 |
| 148 | `haraimodoshi_sanrentan_3b` | character varying | 9 |
| 149 | `haraimodoshi_sanrentan_3c` | character varying | 4 |
| 150 | `haraimodoshi_sanrentan_4a` | character varying | 6 |
| 151 | `haraimodoshi_sanrentan_4b` | character varying | 9 |
| 152 | `haraimodoshi_sanrentan_4c` | character varying | 4 |
| 153 | `haraimodoshi_sanrentan_5a` | character varying | 6 |
| 154 | `haraimodoshi_sanrentan_5b` | character varying | 9 |
| 155 | `haraimodoshi_sanrentan_5c` | character varying | 4 |
| 156 | `haraimodoshi_sanrentan_6a` | character varying | 6 |
| 157 | `haraimodoshi_sanrentan_6b` | character varying | 9 |
| 158 | `haraimodoshi_sanrentan_6c` | character varying | 4 |

---

## JVD_HS

**カラム数**: 14  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `ketto_toroku_bango` | character varying | 10 |
| 5 | `ketto_joho_01a` | character varying | 10 |
| 6 | `ketto_joho_02a` | character varying | 10 |
| 7 | `seinen` | character varying | 4 |
| 8 | `shusaisha_shijo_code` | character varying | 6 |
| 9 | `shusaisha_meisho` | character varying | 40 |
| 10 | `shijo_meisho` | character varying | 80 |
| 11 | `kaisai_kikan_min` | character varying | 8 |
| 12 | `kaisai_kikan_max` | character varying | 8 |
| 13 | `torihikiji_nenrei` | character varying | 1 |
| 14 | `torihiki_kakaku` | character varying | 10 |

---

## JVD_HY

**カラム数**: 6  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `ketto_toroku_bango` | character varying | 10 |
| 5 | `bamei` | character varying | 36 |
| 6 | `bamei_imi_yurai` | character varying | 64 |

---

## JVD_JC

**カラム数**: 20  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `umaban` | character varying | 2 |
| 12 | `bamei` | character varying | 36 |
| 13 | `futan_juryo` | character varying | 3 |
| 14 | `kishu_code` | character varying | 5 |
| 15 | `kishumei` | character varying | 34 |
| 16 | `kishu_minarai_code` | character varying | 1 |
| 17 | `futan_juryo_henkomae` | character varying | 3 |
| 18 | `kishu_code_henkomae` | character varying | 5 |
| 19 | `kishumei_henkomae` | character varying | 34 |
| 20 | `kishu_minarai_code_henkomae` | character varying | 1 |

---

## JVD_JG

**カラム数**: 14  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `ketto_toroku_bango` | character varying | 10 |
| 11 | `bamei` | character varying | 36 |
| 12 | `shutsuba_tohyo_uketsuke` | character varying | 3 |
| 13 | `shusso_kubun` | character varying | 1 |
| 14 | `jogai_jotai_kubun` | character varying | 1 |

---

## JVD_KS

**カラム数**: 30  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kishu_code` | character varying | 5 |
| 5 | `massho_kubun` | character varying | 1 |
| 6 | `menkyo_kofu_nengappi` | character varying | 8 |
| 7 | `menkyo_massho_nengappi` | character varying | 8 |
| 8 | `seinengappi` | character varying | 8 |
| 9 | `kishumei` | character varying | 34 |
| 10 | `yobi_1` | character varying | 34 |
| 11 | `kishumei_hankaku_kana` | character varying | 30 |
| 12 | `kishumei_ryakusho` | character varying | 8 |
| 13 | `kishumei_eur` | character varying | 80 |
| 14 | `seibetsu_kubun` | character varying | 1 |
| 15 | `kijo_shikaku_code` | character varying | 1 |
| 16 | `kishu_minarai_code` | character varying | 1 |
| 17 | `tozai_shozoku_code` | character varying | 1 |
| 18 | `shotai_chiikimei` | character varying | 20 |
| 19 | `chokyoshi_code` | character varying | 5 |
| 20 | `chokyoshimei_ryakusho` | character varying | 8 |
| 21 | `hatsukijo_joho_1` | character varying | 67 |
| 22 | `hatsukijo_joho_2` | character varying | 67 |
| 23 | `hatsushori_joho_1` | character varying | 64 |
| 24 | `hatsushori_joho_2` | character varying | 64 |
| 25 | `jushoshori_joho_1` | character varying | 163 |
| 26 | `jushoshori_joho_2` | character varying | 163 |
| 27 | `jushoshori_joho_3` | character varying | 163 |
| 28 | `seiseki_joho_1` | character varying | 1052 |
| 29 | `seiseki_joho_2` | character varying | 1052 |
| 30 | `seiseki_joho_3` | character varying | 1052 |

---

## JVD_O1

**カラム数**: 22  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_tansho` | character varying | 1 |
| 14 | `hatsubai_flag_fukusho` | character varying | 1 |
| 15 | `hatsubai_flag_wakuren` | character varying | 1 |
| 16 | `fukusho_chakubarai_key` | character varying | 1 |
| 17 | `odds_tansho` | character varying | 224 |
| 18 | `odds_fukusho` | character varying | 336 |
| 19 | `odds_wakuren` | character varying | 324 |
| 20 | `hyosu_gokei_tansho` | character varying | 11 |
| 21 | `hyosu_gokei_fukusho` | character varying | 11 |
| 22 | `hyosu_gokei_wakuren` | character varying | 11 |

---

## JVD_O2

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_umaren` | character varying | 1 |
| 14 | `odds_umaren` | character varying | 1989 |
| 15 | `hyosu_gokei_umaren` | character varying | 11 |

---

## JVD_O3

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_wide` | character varying | 1 |
| 14 | `odds_wide` | character varying | 2601 |
| 15 | `hyosu_gokei_wide` | character varying | 11 |

---

## JVD_O4

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_umatan` | character varying | 1 |
| 14 | `odds_umatan` | character varying | 3978 |
| 15 | `hyosu_gokei_umatan` | character varying | 11 |

---

## JVD_O5

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_sanrenpuku` | character varying | 1 |
| 14 | `odds_sanrenpuku` | character varying | 12240 |
| 15 | `hyosu_gokei_sanrenpuku` | character varying | 11 |

---

## JVD_O6

**カラム数**: 15  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `toroku_tosu` | character varying | 2 |
| 12 | `shusso_tosu` | character varying | 2 |
| 13 | `hatsubai_flag_sanrentan` | character varying | 1 |
| 14 | `odds_sanrentan` | character varying | 83232 |
| 15 | `hyosu_gokei_sanrentan` | character varying | 11 |

---

## JVD_RA

**カラム数**: 62  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `yobi_code` | character varying | 1 |
| 11 | `tokubetsu_kyoso_bango` | character varying | 4 |
| 12 | `kyosomei_hondai` | character varying | 60 |
| 13 | `kyosomei_fukudai` | character varying | 60 |
| 14 | `kyosomei_kakkonai` | character varying | 60 |
| 15 | `kyosomei_hondai_eur` | character varying | 120 |
| 16 | `kyosomei_fukudai_eur` | character varying | 120 |
| 17 | `kyosomei_kakkonai_eur` | character varying | 120 |
| 18 | `kyosomei_ryakusho_10` | character varying | 20 |
| 19 | `kyosomei_ryakusho_6` | character varying | 12 |
| 20 | `kyosomei_ryakusho_3` | character varying | 6 |
| 21 | `kyosomei_kubun` | character varying | 1 |
| 22 | `jusho_kaiji` | character varying | 3 |
| 23 | `grade_code` | character varying | 1 |
| 24 | `grade_code_henkomae` | character varying | 1 |
| 25 | `kyoso_shubetsu_code` | character varying | 2 |
| 26 | `kyoso_kigo_code` | character varying | 3 |
| 27 | `juryo_shubetsu_code` | character varying | 1 |
| 28 | `kyoso_joken_code_2sai` | character varying | 3 |
| 29 | `kyoso_joken_code_3sai` | character varying | 3 |
| 30 | `kyoso_joken_code_4sai` | character varying | 3 |
| 31 | `kyoso_joken_code_5sai_ijo` | character varying | 3 |
| 32 | `kyoso_joken_code` | character varying | 3 |
| 33 | `kyoso_joken_meisho` | character varying | 60 |
| 34 | `kyori` | character varying | 4 |
| 35 | `kyori_henkomae` | character varying | 4 |
| 36 | `track_code` | character varying | 2 |
| 37 | `track_code_henkomae` | character varying | 2 |
| 38 | `course_kubun` | character varying | 2 |
| 39 | `course_kubun_henkomae` | character varying | 2 |
| 40 | `honshokin` | character varying | 56 |
| 41 | `honshokin_henkomae` | character varying | 40 |
| 42 | `fukashokin` | character varying | 40 |
| 43 | `fukashokin_henkomae` | character varying | 24 |
| 44 | `hasso_jikoku` | character varying | 4 |
| 45 | `hasso_jikoku_henkomae` | character varying | 4 |
| 46 | `toroku_tosu` | character varying | 2 |
| 47 | `shusso_tosu` | character varying | 2 |
| 48 | `nyusen_tosu` | character varying | 2 |
| 49 | `tenko_code` | character varying | 1 |
| 50 | `babajotai_code_shiba` | character varying | 1 |
| 51 | `babajotai_code_dirt` | character varying | 1 |
| 52 | `lap_time` | character varying | 75 |
| 53 | `shogai_mile_time` | character varying | 4 |
| 54 | `zenhan_3f` | character varying | 3 |
| 55 | `zenhan_4f` | character varying | 3 |
| 56 | `kohan_3f` | character varying | 3 |
| 57 | `kohan_4f` | character varying | 3 |
| 58 | `corner_tsuka_juni_1` | character varying | 72 |
| 59 | `corner_tsuka_juni_2` | character varying | 72 |
| 60 | `corner_tsuka_juni_3` | character varying | 72 |
| 61 | `corner_tsuka_juni_4` | character varying | 72 |
| 62 | `record_koshin_kubun` | character varying | 1 |

---

## JVD_RC

**カラム数**: 24  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `record_shikibetsu_kubun` | character varying | 1 |
| 5 | `kaisai_nen` | character varying | 4 |
| 6 | `kaisai_tsukihi` | character varying | 4 |
| 7 | `keibajo_code` | character varying | 2 |
| 8 | `kaisai_kai` | character varying | 2 |
| 9 | `kaisai_nichime` | character varying | 2 |
| 10 | `race_bango` | character varying | 2 |
| 11 | `tokubetsu_kyoso_bango` | character varying | 4 |
| 12 | `kyosomei_hondai` | character varying | 60 |
| 13 | `grade_code` | character varying | 1 |
| 14 | `kyoso_shubetsu_code` | character varying | 2 |
| 15 | `kyori` | character varying | 4 |
| 16 | `track_code` | character varying | 2 |
| 17 | `record_kubun` | character varying | 1 |
| 18 | `record_time` | character varying | 4 |
| 19 | `tenko_code` | character varying | 1 |
| 20 | `babajotai_code_shiba` | character varying | 1 |
| 21 | `babajotai_code_dirt` | character varying | 1 |
| 22 | `record_hojiuma_joho_1` | character varying | 130 |
| 23 | `record_hojiuma_joho_2` | character varying | 130 |
| 24 | `record_hojiuma_joho_3` | character varying | 130 |

---

## JVD_SE

**カラム数**: 70  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `wakuban` | character varying | 1 |
| 11 | `umaban` | character varying | 2 |
| 12 | `ketto_toroku_bango` | character varying | 10 |
| 13 | `bamei` | character varying | 36 |
| 14 | `umakigo_code` | character varying | 2 |
| 15 | `seibetsu_code` | character varying | 1 |
| 16 | `hinshu_code` | character varying | 1 |
| 17 | `moshoku_code` | character varying | 2 |
| 18 | `barei` | character varying | 2 |
| 19 | `tozai_shozoku_code` | character varying | 1 |
| 20 | `chokyoshi_code` | character varying | 5 |
| 21 | `chokyoshimei_ryakusho` | character varying | 8 |
| 22 | `banushi_code` | character varying | 6 |
| 23 | `banushimei` | character varying | 64 |
| 24 | `fukushoku_hyoji` | character varying | 60 |
| 25 | `yobi_1` | character varying | 60 |
| 26 | `futan_juryo` | character varying | 3 |
| 27 | `futan_juryo_henkomae` | character varying | 3 |
| 28 | `blinker_shiyo_kubun` | character varying | 1 |
| 29 | `yobi_2` | character varying | 1 |
| 30 | `kishu_code` | character varying | 5 |
| 31 | `kishu_code_henkomae` | character varying | 5 |
| 32 | `kishumei_ryakusho` | character varying | 8 |
| 33 | `kishumei_ryakusho_henkomae` | character varying | 8 |
| 34 | `kishu_minarai_code` | character varying | 1 |
| 35 | `kishu_minarai_code_henkomae` | character varying | 1 |
| 36 | `bataiju` | character varying | 3 |
| 37 | `zogen_fugo` | character varying | 1 |
| 38 | `zogen_sa` | character varying | 3 |
| 39 | `ijo_kubun_code` | character varying | 1 |
| 40 | `nyusen_juni` | character varying | 2 |
| 41 | `kakutei_chakujun` | character varying | 2 |
| 42 | `dochaku_kubun` | character varying | 1 |
| 43 | `dochaku_tosu` | character varying | 1 |
| 44 | `soha_time` | character varying | 4 |
| 45 | `chakusa_code_1` | character varying | 3 |
| 46 | `chakusa_code_2` | character varying | 3 |
| 47 | `chakusa_code_3` | character varying | 3 |
| 48 | `corner_1` | character varying | 2 |
| 49 | `corner_2` | character varying | 2 |
| 50 | `corner_3` | character varying | 2 |
| 51 | `corner_4` | character varying | 2 |
| 52 | `tansho_odds` | character varying | 4 |
| 53 | `tansho_ninkijun` | character varying | 2 |
| 54 | `kakutoku_honshokin` | character varying | 8 |
| 55 | `kakutoku_fukashokin` | character varying | 8 |
| 56 | `yobi_3` | character varying | 3 |
| 57 | `yobi_4` | character varying | 3 |
| 58 | `kohan_4f` | character varying | 3 |
| 59 | `kohan_3f` | character varying | 3 |
| 60 | `aiteuma_joho_1` | character varying | 46 |
| 61 | `aiteuma_joho_2` | character varying | 46 |
| 62 | `aiteuma_joho_3` | character varying | 46 |
| 63 | `time_sa` | character varying | 4 |
| 64 | `record_koshin_kubun` | character varying | 1 |
| 65 | `mining_kubun` | character varying | 1 |
| 66 | `yoso_soha_time` | character varying | 5 |
| 67 | `yoso_gosa_plus` | character varying | 4 |
| 68 | `yoso_gosa_minus` | character varying | 4 |
| 69 | `yoso_juni` | character varying | 2 |
| 70 | `kyakushitsu_hantei` | character varying | 1 |

---

## JVD_SK

**カラム数**: 26  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `ketto_toroku_bango` | character varying | 10 |
| 5 | `seinengappi` | character varying | 8 |
| 6 | `seibetsu_code` | character varying | 1 |
| 7 | `hinshu_code` | character varying | 1 |
| 8 | `moshoku_code` | character varying | 2 |
| 9 | `mochikomi_kubun` | character varying | 1 |
| 10 | `yunyu_nen` | character varying | 4 |
| 11 | `seisansha_code` | character varying | 8 |
| 12 | `sanchimei` | character varying | 20 |
| 13 | `ketto_joho_01a` | character varying | 10 |
| 14 | `ketto_joho_02a` | character varying | 10 |
| 15 | `ketto_joho_03a` | character varying | 10 |
| 16 | `ketto_joho_04a` | character varying | 10 |
| 17 | `ketto_joho_05a` | character varying | 10 |
| 18 | `ketto_joho_06a` | character varying | 10 |
| 19 | `ketto_joho_07a` | character varying | 10 |
| 20 | `ketto_joho_08a` | character varying | 10 |
| 21 | `ketto_joho_09a` | character varying | 10 |
| 22 | `ketto_joho_10a` | character varying | 10 |
| 23 | `ketto_joho_11a` | character varying | 10 |
| 24 | `ketto_joho_12a` | character varying | 10 |
| 25 | `ketto_joho_13a` | character varying | 10 |
| 26 | `ketto_joho_14a` | character varying | 10 |

---

## JVD_TC

**カラム数**: 12  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `hasso_jikoku` | character varying | 4 |
| 12 | `hasso_jikoku_henkomae` | character varying | 4 |

---

## JVD_TK

**カラム数**: 336  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `yobi_code` | character varying | 1 |
| 11 | `tokubetsu_kyoso_bango` | character varying | 4 |
| 12 | `kyosomei_hondai` | character varying | 60 |
| 13 | `kyosomei_fukudai` | character varying | 60 |
| 14 | `kyosomei_kakkonai` | character varying | 60 |
| 15 | `kyosomei_hondai_eur` | character varying | 120 |
| 16 | `kyosomei_fukudai_eur` | character varying | 120 |
| 17 | `kyosomei_kakkonai_eur` | character varying | 120 |
| 18 | `kyosomei_ryakusho_10` | character varying | 20 |
| 19 | `kyosomei_ryakusho_6` | character varying | 12 |
| 20 | `kyosomei_ryakusho_3` | character varying | 6 |
| 21 | `kyosomei_kubun` | character varying | 1 |
| 22 | `jusho_kaiji` | character varying | 3 |
| 23 | `grade_code` | character varying | 1 |
| 24 | `kyoso_shubetsu_code` | character varying | 2 |
| 25 | `kyoso_kigo_code` | character varying | 3 |
| 26 | `juryo_shubetsu_code` | character varying | 1 |
| 27 | `kyoso_joken_code_2sai` | character varying | 3 |
| 28 | `kyoso_joken_code_3sai` | character varying | 3 |
| 29 | `kyoso_joken_code_4sai` | character varying | 3 |
| 30 | `kyoso_joken_code_5sai_ijo` | character varying | 3 |
| 31 | `kyoso_joken_code` | character varying | 3 |
| 32 | `kyori` | character varying | 4 |
| 33 | `track_code` | character varying | 2 |
| 34 | `course_kubun` | character varying | 2 |
| 35 | `handicap_happyobi` | character varying | 8 |
| 36 | `toroku_tosu` | character varying | 3 |
| 37 | `torokuba_joho_001` | character varying | 70 |
| 38 | `torokuba_joho_002` | character varying | 70 |
| 39 | `torokuba_joho_003` | character varying | 70 |
| 40 | `torokuba_joho_004` | character varying | 70 |
| 41 | `torokuba_joho_005` | character varying | 70 |
| 42 | `torokuba_joho_006` | character varying | 70 |
| 43 | `torokuba_joho_007` | character varying | 70 |
| 44 | `torokuba_joho_008` | character varying | 70 |
| 45 | `torokuba_joho_009` | character varying | 70 |
| 46 | `torokuba_joho_010` | character varying | 70 |
| 47 | `torokuba_joho_011` | character varying | 70 |
| 48 | `torokuba_joho_012` | character varying | 70 |
| 49 | `torokuba_joho_013` | character varying | 70 |
| 50 | `torokuba_joho_014` | character varying | 70 |
| 51 | `torokuba_joho_015` | character varying | 70 |
| 52 | `torokuba_joho_016` | character varying | 70 |
| 53 | `torokuba_joho_017` | character varying | 70 |
| 54 | `torokuba_joho_018` | character varying | 70 |
| 55 | `torokuba_joho_019` | character varying | 70 |
| 56 | `torokuba_joho_020` | character varying | 70 |
| 57 | `torokuba_joho_021` | character varying | 70 |
| 58 | `torokuba_joho_022` | character varying | 70 |
| 59 | `torokuba_joho_023` | character varying | 70 |
| 60 | `torokuba_joho_024` | character varying | 70 |
| 61 | `torokuba_joho_025` | character varying | 70 |
| 62 | `torokuba_joho_026` | character varying | 70 |
| 63 | `torokuba_joho_027` | character varying | 70 |
| 64 | `torokuba_joho_028` | character varying | 70 |
| 65 | `torokuba_joho_029` | character varying | 70 |
| 66 | `torokuba_joho_030` | character varying | 70 |
| 67 | `torokuba_joho_031` | character varying | 70 |
| 68 | `torokuba_joho_032` | character varying | 70 |
| 69 | `torokuba_joho_033` | character varying | 70 |
| 70 | `torokuba_joho_034` | character varying | 70 |
| 71 | `torokuba_joho_035` | character varying | 70 |
| 72 | `torokuba_joho_036` | character varying | 70 |
| 73 | `torokuba_joho_037` | character varying | 70 |
| 74 | `torokuba_joho_038` | character varying | 70 |
| 75 | `torokuba_joho_039` | character varying | 70 |
| 76 | `torokuba_joho_040` | character varying | 70 |
| 77 | `torokuba_joho_041` | character varying | 70 |
| 78 | `torokuba_joho_042` | character varying | 70 |
| 79 | `torokuba_joho_043` | character varying | 70 |
| 80 | `torokuba_joho_044` | character varying | 70 |
| 81 | `torokuba_joho_045` | character varying | 70 |
| 82 | `torokuba_joho_046` | character varying | 70 |
| 83 | `torokuba_joho_047` | character varying | 70 |
| 84 | `torokuba_joho_048` | character varying | 70 |
| 85 | `torokuba_joho_049` | character varying | 70 |
| 86 | `torokuba_joho_050` | character varying | 70 |
| 87 | `torokuba_joho_051` | character varying | 70 |
| 88 | `torokuba_joho_052` | character varying | 70 |
| 89 | `torokuba_joho_053` | character varying | 70 |
| 90 | `torokuba_joho_054` | character varying | 70 |
| 91 | `torokuba_joho_055` | character varying | 70 |
| 92 | `torokuba_joho_056` | character varying | 70 |
| 93 | `torokuba_joho_057` | character varying | 70 |
| 94 | `torokuba_joho_058` | character varying | 70 |
| 95 | `torokuba_joho_059` | character varying | 70 |
| 96 | `torokuba_joho_060` | character varying | 70 |
| 97 | `torokuba_joho_061` | character varying | 70 |
| 98 | `torokuba_joho_062` | character varying | 70 |
| 99 | `torokuba_joho_063` | character varying | 70 |
| 100 | `torokuba_joho_064` | character varying | 70 |
| 101 | `torokuba_joho_065` | character varying | 70 |
| 102 | `torokuba_joho_066` | character varying | 70 |
| 103 | `torokuba_joho_067` | character varying | 70 |
| 104 | `torokuba_joho_068` | character varying | 70 |
| 105 | `torokuba_joho_069` | character varying | 70 |
| 106 | `torokuba_joho_070` | character varying | 70 |
| 107 | `torokuba_joho_071` | character varying | 70 |
| 108 | `torokuba_joho_072` | character varying | 70 |
| 109 | `torokuba_joho_073` | character varying | 70 |
| 110 | `torokuba_joho_074` | character varying | 70 |
| 111 | `torokuba_joho_075` | character varying | 70 |
| 112 | `torokuba_joho_076` | character varying | 70 |
| 113 | `torokuba_joho_077` | character varying | 70 |
| 114 | `torokuba_joho_078` | character varying | 70 |
| 115 | `torokuba_joho_079` | character varying | 70 |
| 116 | `torokuba_joho_080` | character varying | 70 |
| 117 | `torokuba_joho_081` | character varying | 70 |
| 118 | `torokuba_joho_082` | character varying | 70 |
| 119 | `torokuba_joho_083` | character varying | 70 |
| 120 | `torokuba_joho_084` | character varying | 70 |
| 121 | `torokuba_joho_085` | character varying | 70 |
| 122 | `torokuba_joho_086` | character varying | 70 |
| 123 | `torokuba_joho_087` | character varying | 70 |
| 124 | `torokuba_joho_088` | character varying | 70 |
| 125 | `torokuba_joho_089` | character varying | 70 |
| 126 | `torokuba_joho_090` | character varying | 70 |
| 127 | `torokuba_joho_091` | character varying | 70 |
| 128 | `torokuba_joho_092` | character varying | 70 |
| 129 | `torokuba_joho_093` | character varying | 70 |
| 130 | `torokuba_joho_094` | character varying | 70 |
| 131 | `torokuba_joho_095` | character varying | 70 |
| 132 | `torokuba_joho_096` | character varying | 70 |
| 133 | `torokuba_joho_097` | character varying | 70 |
| 134 | `torokuba_joho_098` | character varying | 70 |
| 135 | `torokuba_joho_099` | character varying | 70 |
| 136 | `torokuba_joho_100` | character varying | 70 |
| 137 | `torokuba_joho_101` | character varying | 70 |
| 138 | `torokuba_joho_102` | character varying | 70 |
| 139 | `torokuba_joho_103` | character varying | 70 |
| 140 | `torokuba_joho_104` | character varying | 70 |
| 141 | `torokuba_joho_105` | character varying | 70 |
| 142 | `torokuba_joho_106` | character varying | 70 |
| 143 | `torokuba_joho_107` | character varying | 70 |
| 144 | `torokuba_joho_108` | character varying | 70 |
| 145 | `torokuba_joho_109` | character varying | 70 |
| 146 | `torokuba_joho_110` | character varying | 70 |
| 147 | `torokuba_joho_111` | character varying | 70 |
| 148 | `torokuba_joho_112` | character varying | 70 |
| 149 | `torokuba_joho_113` | character varying | 70 |
| 150 | `torokuba_joho_114` | character varying | 70 |
| 151 | `torokuba_joho_115` | character varying | 70 |
| 152 | `torokuba_joho_116` | character varying | 70 |
| 153 | `torokuba_joho_117` | character varying | 70 |
| 154 | `torokuba_joho_118` | character varying | 70 |
| 155 | `torokuba_joho_119` | character varying | 70 |
| 156 | `torokuba_joho_120` | character varying | 70 |
| 157 | `torokuba_joho_121` | character varying | 70 |
| 158 | `torokuba_joho_122` | character varying | 70 |
| 159 | `torokuba_joho_123` | character varying | 70 |
| 160 | `torokuba_joho_124` | character varying | 70 |
| 161 | `torokuba_joho_125` | character varying | 70 |
| 162 | `torokuba_joho_126` | character varying | 70 |
| 163 | `torokuba_joho_127` | character varying | 70 |
| 164 | `torokuba_joho_128` | character varying | 70 |
| 165 | `torokuba_joho_129` | character varying | 70 |
| 166 | `torokuba_joho_130` | character varying | 70 |
| 167 | `torokuba_joho_131` | character varying | 70 |
| 168 | `torokuba_joho_132` | character varying | 70 |
| 169 | `torokuba_joho_133` | character varying | 70 |
| 170 | `torokuba_joho_134` | character varying | 70 |
| 171 | `torokuba_joho_135` | character varying | 70 |
| 172 | `torokuba_joho_136` | character varying | 70 |
| 173 | `torokuba_joho_137` | character varying | 70 |
| 174 | `torokuba_joho_138` | character varying | 70 |
| 175 | `torokuba_joho_139` | character varying | 70 |
| 176 | `torokuba_joho_140` | character varying | 70 |
| 177 | `torokuba_joho_141` | character varying | 70 |
| 178 | `torokuba_joho_142` | character varying | 70 |
| 179 | `torokuba_joho_143` | character varying | 70 |
| 180 | `torokuba_joho_144` | character varying | 70 |
| 181 | `torokuba_joho_145` | character varying | 70 |
| 182 | `torokuba_joho_146` | character varying | 70 |
| 183 | `torokuba_joho_147` | character varying | 70 |
| 184 | `torokuba_joho_148` | character varying | 70 |
| 185 | `torokuba_joho_149` | character varying | 70 |
| 186 | `torokuba_joho_150` | character varying | 70 |
| 187 | `torokuba_joho_151` | character varying | 70 |
| 188 | `torokuba_joho_152` | character varying | 70 |
| 189 | `torokuba_joho_153` | character varying | 70 |
| 190 | `torokuba_joho_154` | character varying | 70 |
| 191 | `torokuba_joho_155` | character varying | 70 |
| 192 | `torokuba_joho_156` | character varying | 70 |
| 193 | `torokuba_joho_157` | character varying | 70 |
| 194 | `torokuba_joho_158` | character varying | 70 |
| 195 | `torokuba_joho_159` | character varying | 70 |
| 196 | `torokuba_joho_160` | character varying | 70 |
| 197 | `torokuba_joho_161` | character varying | 70 |
| 198 | `torokuba_joho_162` | character varying | 70 |
| 199 | `torokuba_joho_163` | character varying | 70 |
| 200 | `torokuba_joho_164` | character varying | 70 |
| 201 | `torokuba_joho_165` | character varying | 70 |
| 202 | `torokuba_joho_166` | character varying | 70 |
| 203 | `torokuba_joho_167` | character varying | 70 |
| 204 | `torokuba_joho_168` | character varying | 70 |
| 205 | `torokuba_joho_169` | character varying | 70 |
| 206 | `torokuba_joho_170` | character varying | 70 |
| 207 | `torokuba_joho_171` | character varying | 70 |
| 208 | `torokuba_joho_172` | character varying | 70 |
| 209 | `torokuba_joho_173` | character varying | 70 |
| 210 | `torokuba_joho_174` | character varying | 70 |
| 211 | `torokuba_joho_175` | character varying | 70 |
| 212 | `torokuba_joho_176` | character varying | 70 |
| 213 | `torokuba_joho_177` | character varying | 70 |
| 214 | `torokuba_joho_178` | character varying | 70 |
| 215 | `torokuba_joho_179` | character varying | 70 |
| 216 | `torokuba_joho_180` | character varying | 70 |
| 217 | `torokuba_joho_181` | character varying | 70 |
| 218 | `torokuba_joho_182` | character varying | 70 |
| 219 | `torokuba_joho_183` | character varying | 70 |
| 220 | `torokuba_joho_184` | character varying | 70 |
| 221 | `torokuba_joho_185` | character varying | 70 |
| 222 | `torokuba_joho_186` | character varying | 70 |
| 223 | `torokuba_joho_187` | character varying | 70 |
| 224 | `torokuba_joho_188` | character varying | 70 |
| 225 | `torokuba_joho_189` | character varying | 70 |
| 226 | `torokuba_joho_190` | character varying | 70 |
| 227 | `torokuba_joho_191` | character varying | 70 |
| 228 | `torokuba_joho_192` | character varying | 70 |
| 229 | `torokuba_joho_193` | character varying | 70 |
| 230 | `torokuba_joho_194` | character varying | 70 |
| 231 | `torokuba_joho_195` | character varying | 70 |
| 232 | `torokuba_joho_196` | character varying | 70 |
| 233 | `torokuba_joho_197` | character varying | 70 |
| 234 | `torokuba_joho_198` | character varying | 70 |
| 235 | `torokuba_joho_199` | character varying | 70 |
| 236 | `torokuba_joho_200` | character varying | 70 |
| 237 | `torokuba_joho_201` | character varying | 70 |
| 238 | `torokuba_joho_202` | character varying | 70 |
| 239 | `torokuba_joho_203` | character varying | 70 |
| 240 | `torokuba_joho_204` | character varying | 70 |
| 241 | `torokuba_joho_205` | character varying | 70 |
| 242 | `torokuba_joho_206` | character varying | 70 |
| 243 | `torokuba_joho_207` | character varying | 70 |
| 244 | `torokuba_joho_208` | character varying | 70 |
| 245 | `torokuba_joho_209` | character varying | 70 |
| 246 | `torokuba_joho_210` | character varying | 70 |
| 247 | `torokuba_joho_211` | character varying | 70 |
| 248 | `torokuba_joho_212` | character varying | 70 |
| 249 | `torokuba_joho_213` | character varying | 70 |
| 250 | `torokuba_joho_214` | character varying | 70 |
| 251 | `torokuba_joho_215` | character varying | 70 |
| 252 | `torokuba_joho_216` | character varying | 70 |
| 253 | `torokuba_joho_217` | character varying | 70 |
| 254 | `torokuba_joho_218` | character varying | 70 |
| 255 | `torokuba_joho_219` | character varying | 70 |
| 256 | `torokuba_joho_220` | character varying | 70 |
| 257 | `torokuba_joho_221` | character varying | 70 |
| 258 | `torokuba_joho_222` | character varying | 70 |
| 259 | `torokuba_joho_223` | character varying | 70 |
| 260 | `torokuba_joho_224` | character varying | 70 |
| 261 | `torokuba_joho_225` | character varying | 70 |
| 262 | `torokuba_joho_226` | character varying | 70 |
| 263 | `torokuba_joho_227` | character varying | 70 |
| 264 | `torokuba_joho_228` | character varying | 70 |
| 265 | `torokuba_joho_229` | character varying | 70 |
| 266 | `torokuba_joho_230` | character varying | 70 |
| 267 | `torokuba_joho_231` | character varying | 70 |
| 268 | `torokuba_joho_232` | character varying | 70 |
| 269 | `torokuba_joho_233` | character varying | 70 |
| 270 | `torokuba_joho_234` | character varying | 70 |
| 271 | `torokuba_joho_235` | character varying | 70 |
| 272 | `torokuba_joho_236` | character varying | 70 |
| 273 | `torokuba_joho_237` | character varying | 70 |
| 274 | `torokuba_joho_238` | character varying | 70 |
| 275 | `torokuba_joho_239` | character varying | 70 |
| 276 | `torokuba_joho_240` | character varying | 70 |
| 277 | `torokuba_joho_241` | character varying | 70 |
| 278 | `torokuba_joho_242` | character varying | 70 |
| 279 | `torokuba_joho_243` | character varying | 70 |
| 280 | `torokuba_joho_244` | character varying | 70 |
| 281 | `torokuba_joho_245` | character varying | 70 |
| 282 | `torokuba_joho_246` | character varying | 70 |
| 283 | `torokuba_joho_247` | character varying | 70 |
| 284 | `torokuba_joho_248` | character varying | 70 |
| 285 | `torokuba_joho_249` | character varying | 70 |
| 286 | `torokuba_joho_250` | character varying | 70 |
| 287 | `torokuba_joho_251` | character varying | 70 |
| 288 | `torokuba_joho_252` | character varying | 70 |
| 289 | `torokuba_joho_253` | character varying | 70 |
| 290 | `torokuba_joho_254` | character varying | 70 |
| 291 | `torokuba_joho_255` | character varying | 70 |
| 292 | `torokuba_joho_256` | character varying | 70 |
| 293 | `torokuba_joho_257` | character varying | 70 |
| 294 | `torokuba_joho_258` | character varying | 70 |
| 295 | `torokuba_joho_259` | character varying | 70 |
| 296 | `torokuba_joho_260` | character varying | 70 |
| 297 | `torokuba_joho_261` | character varying | 70 |
| 298 | `torokuba_joho_262` | character varying | 70 |
| 299 | `torokuba_joho_263` | character varying | 70 |
| 300 | `torokuba_joho_264` | character varying | 70 |
| 301 | `torokuba_joho_265` | character varying | 70 |
| 302 | `torokuba_joho_266` | character varying | 70 |
| 303 | `torokuba_joho_267` | character varying | 70 |
| 304 | `torokuba_joho_268` | character varying | 70 |
| 305 | `torokuba_joho_269` | character varying | 70 |
| 306 | `torokuba_joho_270` | character varying | 70 |
| 307 | `torokuba_joho_271` | character varying | 70 |
| 308 | `torokuba_joho_272` | character varying | 70 |
| 309 | `torokuba_joho_273` | character varying | 70 |
| 310 | `torokuba_joho_274` | character varying | 70 |
| 311 | `torokuba_joho_275` | character varying | 70 |
| 312 | `torokuba_joho_276` | character varying | 70 |
| 313 | `torokuba_joho_277` | character varying | 70 |
| 314 | `torokuba_joho_278` | character varying | 70 |
| 315 | `torokuba_joho_279` | character varying | 70 |
| 316 | `torokuba_joho_280` | character varying | 70 |
| 317 | `torokuba_joho_281` | character varying | 70 |
| 318 | `torokuba_joho_282` | character varying | 70 |
| 319 | `torokuba_joho_283` | character varying | 70 |
| 320 | `torokuba_joho_284` | character varying | 70 |
| 321 | `torokuba_joho_285` | character varying | 70 |
| 322 | `torokuba_joho_286` | character varying | 70 |
| 323 | `torokuba_joho_287` | character varying | 70 |
| 324 | `torokuba_joho_288` | character varying | 70 |
| 325 | `torokuba_joho_289` | character varying | 70 |
| 326 | `torokuba_joho_290` | character varying | 70 |
| 327 | `torokuba_joho_291` | character varying | 70 |
| 328 | `torokuba_joho_292` | character varying | 70 |
| 329 | `torokuba_joho_293` | character varying | 70 |
| 330 | `torokuba_joho_294` | character varying | 70 |
| 331 | `torokuba_joho_295` | character varying | 70 |
| 332 | `torokuba_joho_296` | character varying | 70 |
| 333 | `torokuba_joho_297` | character varying | 70 |
| 334 | `torokuba_joho_298` | character varying | 70 |
| 335 | `torokuba_joho_299` | character varying | 70 |
| 336 | `torokuba_joho_300` | character varying | 70 |

---

## JVD_TM

**カラム数**: 28  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `data_sakusei_jifun` | character varying | 4 |
| 11 | `mining_yoso_01` | character varying | 6 |
| 12 | `mining_yoso_02` | character varying | 6 |
| 13 | `mining_yoso_03` | character varying | 6 |
| 14 | `mining_yoso_04` | character varying | 6 |
| 15 | `mining_yoso_05` | character varying | 6 |
| 16 | `mining_yoso_06` | character varying | 6 |
| 17 | `mining_yoso_07` | character varying | 6 |
| 18 | `mining_yoso_08` | character varying | 6 |
| 19 | `mining_yoso_09` | character varying | 6 |
| 20 | `mining_yoso_10` | character varying | 6 |
| 21 | `mining_yoso_11` | character varying | 6 |
| 22 | `mining_yoso_12` | character varying | 6 |
| 23 | `mining_yoso_13` | character varying | 6 |
| 24 | `mining_yoso_14` | character varying | 6 |
| 25 | `mining_yoso_15` | character varying | 6 |
| 26 | `mining_yoso_16` | character varying | 6 |
| 27 | `mining_yoso_17` | character varying | 6 |
| 28 | `mining_yoso_18` | character varying | 6 |

---

## JVD_UM

**カラム数**: 89  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `ketto_toroku_bango` | character varying | 10 |
| 5 | `massho_kubun` | character varying | 1 |
| 6 | `toroku_nengappi` | character varying | 8 |
| 7 | `massho_nengappi` | character varying | 8 |
| 8 | `seinengappi` | character varying | 8 |
| 9 | `bamei` | character varying | 36 |
| 10 | `bamei_hankaku_kana` | character varying | 36 |
| 11 | `bamei_eur` | character varying | 60 |
| 12 | `zaikyu_flag` | character varying | 1 |
| 13 | `yobi_1` | character varying | 19 |
| 14 | `umakigo_code` | character varying | 2 |
| 15 | `seibetsu_code` | character varying | 1 |
| 16 | `hinshu_code` | character varying | 1 |
| 17 | `moshoku_code` | character varying | 2 |
| 18 | `ketto_joho_01a` | character varying | 10 |
| 19 | `ketto_joho_01b` | character varying | 36 |
| 20 | `ketto_joho_02a` | character varying | 10 |
| 21 | `ketto_joho_02b` | character varying | 36 |
| 22 | `ketto_joho_03a` | character varying | 10 |
| 23 | `ketto_joho_03b` | character varying | 36 |
| 24 | `ketto_joho_04a` | character varying | 10 |
| 25 | `ketto_joho_04b` | character varying | 36 |
| 26 | `ketto_joho_05a` | character varying | 10 |
| 27 | `ketto_joho_05b` | character varying | 36 |
| 28 | `ketto_joho_06a` | character varying | 10 |
| 29 | `ketto_joho_06b` | character varying | 36 |
| 30 | `ketto_joho_07a` | character varying | 10 |
| 31 | `ketto_joho_07b` | character varying | 36 |
| 32 | `ketto_joho_08a` | character varying | 10 |
| 33 | `ketto_joho_08b` | character varying | 36 |
| 34 | `ketto_joho_09a` | character varying | 10 |
| 35 | `ketto_joho_09b` | character varying | 36 |
| 36 | `ketto_joho_10a` | character varying | 10 |
| 37 | `ketto_joho_10b` | character varying | 36 |
| 38 | `ketto_joho_11a` | character varying | 10 |
| 39 | `ketto_joho_11b` | character varying | 36 |
| 40 | `ketto_joho_12a` | character varying | 10 |
| 41 | `ketto_joho_12b` | character varying | 36 |
| 42 | `ketto_joho_13a` | character varying | 10 |
| 43 | `ketto_joho_13b` | character varying | 36 |
| 44 | `ketto_joho_14a` | character varying | 10 |
| 45 | `ketto_joho_14b` | character varying | 36 |
| 46 | `tozai_shozoku_code` | character varying | 1 |
| 47 | `chokyoshi_code` | character varying | 5 |
| 48 | `chokyoshimei_ryakusho` | character varying | 8 |
| 49 | `shotai_chiikimei` | character varying | 20 |
| 50 | `seisansha_code` | character varying | 8 |
| 51 | `seisanshamei` | character varying | 72 |
| 52 | `sanchimei` | character varying | 20 |
| 53 | `banushi_code` | character varying | 6 |
| 54 | `banushimei` | character varying | 64 |
| 55 | `heichi_honshokin_ruikei` | character varying | 9 |
| 56 | `shogai_honshokin_ruikei` | character varying | 9 |
| 57 | `heichi_fukashokin_ruikei` | character varying | 9 |
| 58 | `shogai_fukashokin_ruikei` | character varying | 9 |
| 59 | `heichi_shutokushokin_ruikei` | character varying | 9 |
| 60 | `shogai_shutokushokin_ruikei` | character varying | 9 |
| 61 | `sogo` | character varying | 18 |
| 62 | `chuo_gokei` | character varying | 18 |
| 63 | `shiba_choku` | character varying | 18 |
| 64 | `shiba_migi` | character varying | 18 |
| 65 | `shiba_hidari` | character varying | 18 |
| 66 | `dirt_choku` | character varying | 18 |
| 67 | `dirt_migi` | character varying | 18 |
| 68 | `dirt_hidari` | character varying | 18 |
| 69 | `shogai` | character varying | 18 |
| 70 | `shiba_ryo` | character varying | 18 |
| 71 | `shiba_yayaomo` | character varying | 18 |
| 72 | `shiba_omo` | character varying | 18 |
| 73 | `shiba_furyo` | character varying | 18 |
| 74 | `dirt_ryo` | character varying | 18 |
| 75 | `dirt_yayaomo` | character varying | 18 |
| 76 | `dirt_omo` | character varying | 18 |
| 77 | `dirt_furyo` | character varying | 18 |
| 78 | `shogai_ryo` | character varying | 18 |
| 79 | `shogai_yayaomo` | character varying | 18 |
| 80 | `shogai_omo` | character varying | 18 |
| 81 | `shogai_furyo` | character varying | 18 |
| 82 | `shiba_short` | character varying | 18 |
| 83 | `shiba_middle` | character varying | 18 |
| 84 | `shiba_long` | character varying | 18 |
| 85 | `dirt_short` | character varying | 18 |
| 86 | `dirt_middle` | character varying | 18 |
| 87 | `dirt_long` | character varying | 18 |
| 88 | `kyakushitsu_keiko` | character varying | 12 |
| 89 | `toroku_race_su` | character varying | 3 |

---

## JVD_WC

**カラム数**: 29  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `tracen_kubun` | character varying | 1 |
| 5 | `chokyo_nengappi` | character varying | 8 |
| 6 | `chokyo_jikoku` | character varying | 4 |
| 7 | `ketto_toroku_bango` | character varying | 10 |
| 8 | `course` | character varying | 1 |
| 9 | `babamawari` | character varying | 1 |
| 10 | `yobi_1` | character varying | 1 |
| 11 | `time_gokei_10f` | character varying | 4 |
| 12 | `lap_time_10f` | character varying | 3 |
| 13 | `time_gokei_9f` | character varying | 4 |
| 14 | `lap_time_9f` | character varying | 3 |
| 15 | `time_gokei_8f` | character varying | 4 |
| 16 | `lap_time_8f` | character varying | 3 |
| 17 | `time_gokei_7f` | character varying | 4 |
| 18 | `lap_time_7f` | character varying | 3 |
| 19 | `time_gokei_6f` | character varying | 4 |
| 20 | `lap_time_6f` | character varying | 3 |
| 21 | `time_gokei_5f` | character varying | 4 |
| 22 | `lap_time_5f` | character varying | 3 |
| 23 | `time_gokei_4f` | character varying | 4 |
| 24 | `lap_time_4f` | character varying | 3 |
| 25 | `time_gokei_3f` | character varying | 4 |
| 26 | `lap_time_3f` | character varying | 3 |
| 27 | `time_gokei_2f` | character varying | 4 |
| 28 | `lap_time_2f` | character varying | 3 |
| 29 | `lap_time_1f` | character varying | 3 |

---

## JVD_WE

**カラム数**: 16  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `happyo_tsukihi_jifun` | character varying | 8 |
| 10 | `henko_shikibetsu` | character varying | 1 |
| 11 | `tenko_code` | character varying | 1 |
| 12 | `babajotai_code_shiba` | character varying | 1 |
| 13 | `babajotai_code_dirt` | character varying | 1 |
| 14 | `tenko_code_henkomae` | character varying | 1 |
| 15 | `babajotai_code_shiba_henkomae` | character varying | 1 |
| 16 | `babajotai_code_dirt_henkomae` | character varying | 1 |

---

## JVD_WF

**カラム数**: 266  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `yobi_1` | character varying | 2 |
| 7 | `race_joho_1` | character varying | 8 |
| 8 | `race_joho_2` | character varying | 8 |
| 9 | `race_joho_3` | character varying | 8 |
| 10 | `race_joho_4` | character varying | 8 |
| 11 | `race_joho_5` | character varying | 8 |
| 12 | `yobi_2` | character varying | 6 |
| 13 | `win5_hyosu_gokei` | character varying | 11 |
| 14 | `yuko_hyosu_1` | character varying | 11 |
| 15 | `yuko_hyosu_2` | character varying | 11 |
| 16 | `yuko_hyosu_3` | character varying | 11 |
| 17 | `yuko_hyosu_4` | character varying | 11 |
| 18 | `yuko_hyosu_5` | character varying | 11 |
| 19 | `henkan_flag` | character varying | 1 |
| 20 | `fuseiritsu_flag` | character varying | 1 |
| 21 | `tekichu_nashi_flag` | character varying | 1 |
| 22 | `carry_over` | character varying | 15 |
| 23 | `carry_over_zandaka` | character varying | 15 |
| 24 | `haraimodoshi_win5_001` | character varying | 29 |
| 25 | `haraimodoshi_win5_002` | character varying | 29 |
| 26 | `haraimodoshi_win5_003` | character varying | 29 |
| 27 | `haraimodoshi_win5_004` | character varying | 29 |
| 28 | `haraimodoshi_win5_005` | character varying | 29 |
| 29 | `haraimodoshi_win5_006` | character varying | 29 |
| 30 | `haraimodoshi_win5_007` | character varying | 29 |
| 31 | `haraimodoshi_win5_008` | character varying | 29 |
| 32 | `haraimodoshi_win5_009` | character varying | 29 |
| 33 | `haraimodoshi_win5_010` | character varying | 29 |
| 34 | `haraimodoshi_win5_011` | character varying | 29 |
| 35 | `haraimodoshi_win5_012` | character varying | 29 |
| 36 | `haraimodoshi_win5_013` | character varying | 29 |
| 37 | `haraimodoshi_win5_014` | character varying | 29 |
| 38 | `haraimodoshi_win5_015` | character varying | 29 |
| 39 | `haraimodoshi_win5_016` | character varying | 29 |
| 40 | `haraimodoshi_win5_017` | character varying | 29 |
| 41 | `haraimodoshi_win5_018` | character varying | 29 |
| 42 | `haraimodoshi_win5_019` | character varying | 29 |
| 43 | `haraimodoshi_win5_020` | character varying | 29 |
| 44 | `haraimodoshi_win5_021` | character varying | 29 |
| 45 | `haraimodoshi_win5_022` | character varying | 29 |
| 46 | `haraimodoshi_win5_023` | character varying | 29 |
| 47 | `haraimodoshi_win5_024` | character varying | 29 |
| 48 | `haraimodoshi_win5_025` | character varying | 29 |
| 49 | `haraimodoshi_win5_026` | character varying | 29 |
| 50 | `haraimodoshi_win5_027` | character varying | 29 |
| 51 | `haraimodoshi_win5_028` | character varying | 29 |
| 52 | `haraimodoshi_win5_029` | character varying | 29 |
| 53 | `haraimodoshi_win5_030` | character varying | 29 |
| 54 | `haraimodoshi_win5_031` | character varying | 29 |
| 55 | `haraimodoshi_win5_032` | character varying | 29 |
| 56 | `haraimodoshi_win5_033` | character varying | 29 |
| 57 | `haraimodoshi_win5_034` | character varying | 29 |
| 58 | `haraimodoshi_win5_035` | character varying | 29 |
| 59 | `haraimodoshi_win5_036` | character varying | 29 |
| 60 | `haraimodoshi_win5_037` | character varying | 29 |
| 61 | `haraimodoshi_win5_038` | character varying | 29 |
| 62 | `haraimodoshi_win5_039` | character varying | 29 |
| 63 | `haraimodoshi_win5_040` | character varying | 29 |
| 64 | `haraimodoshi_win5_041` | character varying | 29 |
| 65 | `haraimodoshi_win5_042` | character varying | 29 |
| 66 | `haraimodoshi_win5_043` | character varying | 29 |
| 67 | `haraimodoshi_win5_044` | character varying | 29 |
| 68 | `haraimodoshi_win5_045` | character varying | 29 |
| 69 | `haraimodoshi_win5_046` | character varying | 29 |
| 70 | `haraimodoshi_win5_047` | character varying | 29 |
| 71 | `haraimodoshi_win5_048` | character varying | 29 |
| 72 | `haraimodoshi_win5_049` | character varying | 29 |
| 73 | `haraimodoshi_win5_050` | character varying | 29 |
| 74 | `haraimodoshi_win5_051` | character varying | 29 |
| 75 | `haraimodoshi_win5_052` | character varying | 29 |
| 76 | `haraimodoshi_win5_053` | character varying | 29 |
| 77 | `haraimodoshi_win5_054` | character varying | 29 |
| 78 | `haraimodoshi_win5_055` | character varying | 29 |
| 79 | `haraimodoshi_win5_056` | character varying | 29 |
| 80 | `haraimodoshi_win5_057` | character varying | 29 |
| 81 | `haraimodoshi_win5_058` | character varying | 29 |
| 82 | `haraimodoshi_win5_059` | character varying | 29 |
| 83 | `haraimodoshi_win5_060` | character varying | 29 |
| 84 | `haraimodoshi_win5_061` | character varying | 29 |
| 85 | `haraimodoshi_win5_062` | character varying | 29 |
| 86 | `haraimodoshi_win5_063` | character varying | 29 |
| 87 | `haraimodoshi_win5_064` | character varying | 29 |
| 88 | `haraimodoshi_win5_065` | character varying | 29 |
| 89 | `haraimodoshi_win5_066` | character varying | 29 |
| 90 | `haraimodoshi_win5_067` | character varying | 29 |
| 91 | `haraimodoshi_win5_068` | character varying | 29 |
| 92 | `haraimodoshi_win5_069` | character varying | 29 |
| 93 | `haraimodoshi_win5_070` | character varying | 29 |
| 94 | `haraimodoshi_win5_071` | character varying | 29 |
| 95 | `haraimodoshi_win5_072` | character varying | 29 |
| 96 | `haraimodoshi_win5_073` | character varying | 29 |
| 97 | `haraimodoshi_win5_074` | character varying | 29 |
| 98 | `haraimodoshi_win5_075` | character varying | 29 |
| 99 | `haraimodoshi_win5_076` | character varying | 29 |
| 100 | `haraimodoshi_win5_077` | character varying | 29 |
| 101 | `haraimodoshi_win5_078` | character varying | 29 |
| 102 | `haraimodoshi_win5_079` | character varying | 29 |
| 103 | `haraimodoshi_win5_080` | character varying | 29 |
| 104 | `haraimodoshi_win5_081` | character varying | 29 |
| 105 | `haraimodoshi_win5_082` | character varying | 29 |
| 106 | `haraimodoshi_win5_083` | character varying | 29 |
| 107 | `haraimodoshi_win5_084` | character varying | 29 |
| 108 | `haraimodoshi_win5_085` | character varying | 29 |
| 109 | `haraimodoshi_win5_086` | character varying | 29 |
| 110 | `haraimodoshi_win5_087` | character varying | 29 |
| 111 | `haraimodoshi_win5_088` | character varying | 29 |
| 112 | `haraimodoshi_win5_089` | character varying | 29 |
| 113 | `haraimodoshi_win5_090` | character varying | 29 |
| 114 | `haraimodoshi_win5_091` | character varying | 29 |
| 115 | `haraimodoshi_win5_092` | character varying | 29 |
| 116 | `haraimodoshi_win5_093` | character varying | 29 |
| 117 | `haraimodoshi_win5_094` | character varying | 29 |
| 118 | `haraimodoshi_win5_095` | character varying | 29 |
| 119 | `haraimodoshi_win5_096` | character varying | 29 |
| 120 | `haraimodoshi_win5_097` | character varying | 29 |
| 121 | `haraimodoshi_win5_098` | character varying | 29 |
| 122 | `haraimodoshi_win5_099` | character varying | 29 |
| 123 | `haraimodoshi_win5_100` | character varying | 29 |
| 124 | `haraimodoshi_win5_101` | character varying | 29 |
| 125 | `haraimodoshi_win5_102` | character varying | 29 |
| 126 | `haraimodoshi_win5_103` | character varying | 29 |
| 127 | `haraimodoshi_win5_104` | character varying | 29 |
| 128 | `haraimodoshi_win5_105` | character varying | 29 |
| 129 | `haraimodoshi_win5_106` | character varying | 29 |
| 130 | `haraimodoshi_win5_107` | character varying | 29 |
| 131 | `haraimodoshi_win5_108` | character varying | 29 |
| 132 | `haraimodoshi_win5_109` | character varying | 29 |
| 133 | `haraimodoshi_win5_110` | character varying | 29 |
| 134 | `haraimodoshi_win5_111` | character varying | 29 |
| 135 | `haraimodoshi_win5_112` | character varying | 29 |
| 136 | `haraimodoshi_win5_113` | character varying | 29 |
| 137 | `haraimodoshi_win5_114` | character varying | 29 |
| 138 | `haraimodoshi_win5_115` | character varying | 29 |
| 139 | `haraimodoshi_win5_116` | character varying | 29 |
| 140 | `haraimodoshi_win5_117` | character varying | 29 |
| 141 | `haraimodoshi_win5_118` | character varying | 29 |
| 142 | `haraimodoshi_win5_119` | character varying | 29 |
| 143 | `haraimodoshi_win5_120` | character varying | 29 |
| 144 | `haraimodoshi_win5_121` | character varying | 29 |
| 145 | `haraimodoshi_win5_122` | character varying | 29 |
| 146 | `haraimodoshi_win5_123` | character varying | 29 |
| 147 | `haraimodoshi_win5_124` | character varying | 29 |
| 148 | `haraimodoshi_win5_125` | character varying | 29 |
| 149 | `haraimodoshi_win5_126` | character varying | 29 |
| 150 | `haraimodoshi_win5_127` | character varying | 29 |
| 151 | `haraimodoshi_win5_128` | character varying | 29 |
| 152 | `haraimodoshi_win5_129` | character varying | 29 |
| 153 | `haraimodoshi_win5_130` | character varying | 29 |
| 154 | `haraimodoshi_win5_131` | character varying | 29 |
| 155 | `haraimodoshi_win5_132` | character varying | 29 |
| 156 | `haraimodoshi_win5_133` | character varying | 29 |
| 157 | `haraimodoshi_win5_134` | character varying | 29 |
| 158 | `haraimodoshi_win5_135` | character varying | 29 |
| 159 | `haraimodoshi_win5_136` | character varying | 29 |
| 160 | `haraimodoshi_win5_137` | character varying | 29 |
| 161 | `haraimodoshi_win5_138` | character varying | 29 |
| 162 | `haraimodoshi_win5_139` | character varying | 29 |
| 163 | `haraimodoshi_win5_140` | character varying | 29 |
| 164 | `haraimodoshi_win5_141` | character varying | 29 |
| 165 | `haraimodoshi_win5_142` | character varying | 29 |
| 166 | `haraimodoshi_win5_143` | character varying | 29 |
| 167 | `haraimodoshi_win5_144` | character varying | 29 |
| 168 | `haraimodoshi_win5_145` | character varying | 29 |
| 169 | `haraimodoshi_win5_146` | character varying | 29 |
| 170 | `haraimodoshi_win5_147` | character varying | 29 |
| 171 | `haraimodoshi_win5_148` | character varying | 29 |
| 172 | `haraimodoshi_win5_149` | character varying | 29 |
| 173 | `haraimodoshi_win5_150` | character varying | 29 |
| 174 | `haraimodoshi_win5_151` | character varying | 29 |
| 175 | `haraimodoshi_win5_152` | character varying | 29 |
| 176 | `haraimodoshi_win5_153` | character varying | 29 |
| 177 | `haraimodoshi_win5_154` | character varying | 29 |
| 178 | `haraimodoshi_win5_155` | character varying | 29 |
| 179 | `haraimodoshi_win5_156` | character varying | 29 |
| 180 | `haraimodoshi_win5_157` | character varying | 29 |
| 181 | `haraimodoshi_win5_158` | character varying | 29 |
| 182 | `haraimodoshi_win5_159` | character varying | 29 |
| 183 | `haraimodoshi_win5_160` | character varying | 29 |
| 184 | `haraimodoshi_win5_161` | character varying | 29 |
| 185 | `haraimodoshi_win5_162` | character varying | 29 |
| 186 | `haraimodoshi_win5_163` | character varying | 29 |
| 187 | `haraimodoshi_win5_164` | character varying | 29 |
| 188 | `haraimodoshi_win5_165` | character varying | 29 |
| 189 | `haraimodoshi_win5_166` | character varying | 29 |
| 190 | `haraimodoshi_win5_167` | character varying | 29 |
| 191 | `haraimodoshi_win5_168` | character varying | 29 |
| 192 | `haraimodoshi_win5_169` | character varying | 29 |
| 193 | `haraimodoshi_win5_170` | character varying | 29 |
| 194 | `haraimodoshi_win5_171` | character varying | 29 |
| 195 | `haraimodoshi_win5_172` | character varying | 29 |
| 196 | `haraimodoshi_win5_173` | character varying | 29 |
| 197 | `haraimodoshi_win5_174` | character varying | 29 |
| 198 | `haraimodoshi_win5_175` | character varying | 29 |
| 199 | `haraimodoshi_win5_176` | character varying | 29 |
| 200 | `haraimodoshi_win5_177` | character varying | 29 |
| 201 | `haraimodoshi_win5_178` | character varying | 29 |
| 202 | `haraimodoshi_win5_179` | character varying | 29 |
| 203 | `haraimodoshi_win5_180` | character varying | 29 |
| 204 | `haraimodoshi_win5_181` | character varying | 29 |
| 205 | `haraimodoshi_win5_182` | character varying | 29 |
| 206 | `haraimodoshi_win5_183` | character varying | 29 |
| 207 | `haraimodoshi_win5_184` | character varying | 29 |
| 208 | `haraimodoshi_win5_185` | character varying | 29 |
| 209 | `haraimodoshi_win5_186` | character varying | 29 |
| 210 | `haraimodoshi_win5_187` | character varying | 29 |
| 211 | `haraimodoshi_win5_188` | character varying | 29 |
| 212 | `haraimodoshi_win5_189` | character varying | 29 |
| 213 | `haraimodoshi_win5_190` | character varying | 29 |
| 214 | `haraimodoshi_win5_191` | character varying | 29 |
| 215 | `haraimodoshi_win5_192` | character varying | 29 |
| 216 | `haraimodoshi_win5_193` | character varying | 29 |
| 217 | `haraimodoshi_win5_194` | character varying | 29 |
| 218 | `haraimodoshi_win5_195` | character varying | 29 |
| 219 | `haraimodoshi_win5_196` | character varying | 29 |
| 220 | `haraimodoshi_win5_197` | character varying | 29 |
| 221 | `haraimodoshi_win5_198` | character varying | 29 |
| 222 | `haraimodoshi_win5_199` | character varying | 29 |
| 223 | `haraimodoshi_win5_200` | character varying | 29 |
| 224 | `haraimodoshi_win5_201` | character varying | 29 |
| 225 | `haraimodoshi_win5_202` | character varying | 29 |
| 226 | `haraimodoshi_win5_203` | character varying | 29 |
| 227 | `haraimodoshi_win5_204` | character varying | 29 |
| 228 | `haraimodoshi_win5_205` | character varying | 29 |
| 229 | `haraimodoshi_win5_206` | character varying | 29 |
| 230 | `haraimodoshi_win5_207` | character varying | 29 |
| 231 | `haraimodoshi_win5_208` | character varying | 29 |
| 232 | `haraimodoshi_win5_209` | character varying | 29 |
| 233 | `haraimodoshi_win5_210` | character varying | 29 |
| 234 | `haraimodoshi_win5_211` | character varying | 29 |
| 235 | `haraimodoshi_win5_212` | character varying | 29 |
| 236 | `haraimodoshi_win5_213` | character varying | 29 |
| 237 | `haraimodoshi_win5_214` | character varying | 29 |
| 238 | `haraimodoshi_win5_215` | character varying | 29 |
| 239 | `haraimodoshi_win5_216` | character varying | 29 |
| 240 | `haraimodoshi_win5_217` | character varying | 29 |
| 241 | `haraimodoshi_win5_218` | character varying | 29 |
| 242 | `haraimodoshi_win5_219` | character varying | 29 |
| 243 | `haraimodoshi_win5_220` | character varying | 29 |
| 244 | `haraimodoshi_win5_221` | character varying | 29 |
| 245 | `haraimodoshi_win5_222` | character varying | 29 |
| 246 | `haraimodoshi_win5_223` | character varying | 29 |
| 247 | `haraimodoshi_win5_224` | character varying | 29 |
| 248 | `haraimodoshi_win5_225` | character varying | 29 |
| 249 | `haraimodoshi_win5_226` | character varying | 29 |
| 250 | `haraimodoshi_win5_227` | character varying | 29 |
| 251 | `haraimodoshi_win5_228` | character varying | 29 |
| 252 | `haraimodoshi_win5_229` | character varying | 29 |
| 253 | `haraimodoshi_win5_230` | character varying | 29 |
| 254 | `haraimodoshi_win5_231` | character varying | 29 |
| 255 | `haraimodoshi_win5_232` | character varying | 29 |
| 256 | `haraimodoshi_win5_233` | character varying | 29 |
| 257 | `haraimodoshi_win5_234` | character varying | 29 |
| 258 | `haraimodoshi_win5_235` | character varying | 29 |
| 259 | `haraimodoshi_win5_236` | character varying | 29 |
| 260 | `haraimodoshi_win5_237` | character varying | 29 |
| 261 | `haraimodoshi_win5_238` | character varying | 29 |
| 262 | `haraimodoshi_win5_239` | character varying | 29 |
| 263 | `haraimodoshi_win5_240` | character varying | 29 |
| 264 | `haraimodoshi_win5_241` | character varying | 29 |
| 265 | `haraimodoshi_win5_242` | character varying | 29 |
| 266 | `haraimodoshi_win5_243` | character varying | 29 |

---

## JVD_WH

**カラム数**: 28  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `race_bango` | character varying | 2 |
| 10 | `happyo_tsukihi_jifun` | character varying | 8 |
| 11 | `bataiju_joho_01` | character varying | 45 |
| 12 | `bataiju_joho_02` | character varying | 45 |
| 13 | `bataiju_joho_03` | character varying | 45 |
| 14 | `bataiju_joho_04` | character varying | 45 |
| 15 | `bataiju_joho_05` | character varying | 45 |
| 16 | `bataiju_joho_06` | character varying | 45 |
| 17 | `bataiju_joho_07` | character varying | 45 |
| 18 | `bataiju_joho_08` | character varying | 45 |
| 19 | `bataiju_joho_09` | character varying | 45 |
| 20 | `bataiju_joho_10` | character varying | 45 |
| 21 | `bataiju_joho_11` | character varying | 45 |
| 22 | `bataiju_joho_12` | character varying | 45 |
| 23 | `bataiju_joho_13` | character varying | 45 |
| 24 | `bataiju_joho_14` | character varying | 45 |
| 25 | `bataiju_joho_15` | character varying | 45 |
| 26 | `bataiju_joho_16` | character varying | 45 |
| 27 | `bataiju_joho_17` | character varying | 45 |
| 28 | `bataiju_joho_18` | character varying | 45 |

---

## JVD_YS

**カラム数**: 12  
**分類**: JRA-VAN  

| No | カラム名 | データ型 | 最大長 |
|----|---------|---------:|-------:|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `kaisai_nen` | character varying | 4 |
| 5 | `kaisai_tsukihi` | character varying | 4 |
| 6 | `keibajo_code` | character varying | 2 |
| 7 | `kaisai_kai` | character varying | 2 |
| 8 | `kaisai_nichime` | character varying | 2 |
| 9 | `yobi_code` | character varying | 1 |
| 10 | `jusho_joho_1` | character varying | 118 |
| 11 | `jusho_joho_2` | character varying | 118 |
| 12 | `jusho_joho_3` | character varying | 118 |

---

## 📋 テーブル一覧

| No | テーブル名 | カラム数 | 分類 |
|----|-----------|--------:|------|
| 1 | `jvd_tk` | 336 | JRA-VAN |
| 2 | `jvd_wf` | 266 | JRA-VAN |
| 3 | `jvd_hr` | 158 | JRA-VAN |
| 4 | `jrd_kyi` | 132 | JRDB |
| 5 | `jvd_ck` | 106 | JRA-VAN |
| 6 | `jvd_um` | 89 | JRA-VAN |
| 7 | `jrd_sed` | 80 | JRDB |
| 8 | `jvd_se` | 70 | JRA-VAN |
| 9 | `jvd_ra` | 62 | JRA-VAN |
| 10 | `jvd_h1` | 43 | JRA-VAN |
| 11 | `jvd_ks` | 30 | JRA-VAN |
| 12 | `jvd_wc` | 29 | JRA-VAN |
| 13 | `jvd_dm` | 28 | JRA-VAN |
| 14 | `jvd_tm` | 28 | JRA-VAN |
| 15 | `jvd_wh` | 28 | JRA-VAN |
| 16 | `jrd_bac` | 27 | JRDB |
| 17 | `jrd_cyb` | 27 | JRDB |
| 18 | `jvd_sk` | 26 | JRA-VAN |
| 19 | `jrd_joa` | 24 | JRDB |
| 20 | `jvd_rc` | 24 | JRA-VAN |
| 21 | `jvd_o1` | 22 | JRA-VAN |
| 22 | `jvd_ch` | 21 | JRA-VAN |
| 23 | `jvd_jc` | 20 | JRA-VAN |
| 24 | `jvd_hn` | 19 | JRA-VAN |
| 25 | `jvd_we` | 16 | JRA-VAN |
| 26 | `jvd_h6` | 16 | JRA-VAN |
| 27 | `jvd_cc` | 15 | JRA-VAN |
| 28 | `jvd_o4` | 15 | JRA-VAN |
| 29 | `jvd_o3` | 15 | JRA-VAN |
| 30 | `jvd_o2` | 15 | JRA-VAN |
| 31 | `jvd_o6` | 15 | JRA-VAN |
| 32 | `jvd_o5` | 15 | JRA-VAN |
| 33 | `jvd_hc` | 14 | JRA-VAN |
| 34 | `jvd_hs` | 14 | JRA-VAN |
| 35 | `jvd_jg` | 14 | JRA-VAN |
| 36 | `jvd_av` | 13 | JRA-VAN |
| 37 | `jvd_tc` | 12 | JRA-VAN |
| 38 | `jvd_ys` | 12 | JRA-VAN |
| 39 | `jvd_bn` | 11 | JRA-VAN |
| 40 | `jvd_br` | 11 | JRA-VAN |
| 41 | `jvd_cs` | 8 | JRA-VAN |
| 42 | `jvd_bt` | 7 | JRA-VAN |
| 43 | `jvd_hy` | 6 | JRA-VAN |
