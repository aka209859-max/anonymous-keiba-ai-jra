# Phase 7-A: 全1,939カラム 完全リスト

**作成日**: 2026-03-03  
**対象**: JRA-VAN 38テーブル（1,649カラム） + JRDB 5テーブル（290カラム）

---

## 📊 サマリー

| データソース | テーブル数 | 総カラム数 |
|-------------|-----------|-----------|
| **JRA-VAN** | 38 | 1,649 |
| **JRDB** | 5 | 290 |
| **合計** | **43** | **1,939** |

---

## 🔵 JRA-VAN 38テーブル（1,649カラム）

### 1. jvd_tk (336 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(316カラム省略)* | ... | ... |

---

### 2. jvd_wf (266 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(246カラム省略)* | ... | ... |

---

### 3. jvd_hr (158 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(138カラム省略)* | ... | ... |

---

### 4. jvd_ck (106 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(86カラム省略)* | ... | ... |

---

### 5. jvd_um (89 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(69カラム省略)* | ... | ... |

---

### 6. jvd_se (70 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(50カラム省略)* | ... | ... |

---

### 7. jvd_ra (62 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(42カラム省略)* | ... | ... |

---

### 8. jvd_h1 (43 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(23カラム省略)* | ... | ... |

---

### 9. jvd_ks (30 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(10カラム省略)* | ... | ... |

---

### 10. jvd_wc (29 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(9カラム省略)* | ... | ... |

---

### 11. jvd_dm (28 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(8カラム省略)* | ... | ... |

---

### 12. jvd_tm (28 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(8カラム省略)* | ... | ... |

---

### 13. jvd_wh (28 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(8カラム省略)* | ... | ... |

---

### 14. jvd_sk (26 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(6カラム省略)* | ... | ... |

---

### 15. jvd_rc (24 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(4カラム省略)* | ... | ... |

---

### 16. jvd_o1 (22 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(2カラム省略)* | ... | ... |

---

### 17. jvd_ch (21 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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
| ... | *(1カラム省略)* | ... | ... |

---

### 18. jvd_jc (20 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 19. jvd_hn (19 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 20. jvd_h6 (16 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 21. jvd_we (16 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 22. jvd_cc (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 23. jvd_o2 (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 24. jvd_o3 (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 25. jvd_o4 (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 26. jvd_o5 (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 27. jvd_o6 (15 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 28. jvd_hc (14 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 29. jvd_hs (14 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 30. jvd_jg (14 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 31. jvd_av (13 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 32. jvd_tc (12 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 33. jvd_ys (12 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 34. jvd_bn (11 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 35. jvd_br (11 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 36. jvd_cs (8 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `keibajo_code` | character varying | 2 |
| 5 | `kyori` | character varying | 4 |
| 6 | `track_code` | character varying | 2 |
| 7 | `course_kaishu_nengappi` | character varying | 8 |
| 8 | `course_setsumei` | character varying | 6800 |

---

### 37. jvd_bt (7 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `hanshoku_toroku_bango` | character varying | 10 |
| 5 | `keito_id` | character varying | 30 |
| 6 | `keito_mei` | character varying | 36 |
| 7 | `keito_setsumei` | character varying | 6800 |

---

### 38. jvd_hy (6 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
| 1 | `record_id` | character varying | 2 |
| 2 | `data_kubun` | character varying | 1 |
| 3 | `data_sakusei_nengappi` | character varying | 8 |
| 4 | `ketto_toroku_bango` | character varying | 10 |
| 5 | `bamei` | character varying | 36 |
| 6 | `bamei_imi_yurai` | character varying | 64 |

---

## 🟠 JRDB 5テーブル（290カラム）

### 1. jrd_kyi (132 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 2. jrd_sed (80 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 3. jrd_bac (27 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 4. jrd_cyb (27 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

### 5. jrd_joa (24 カラム)

| # | カラム名 | データ型 | 長さ |
|---|----------|---------|------|
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

## 📋 次のステップ

### ✅ 完了
1. 全43テーブル・1,939カラムのリスト取得

### ⏳ 実行予定
2. 各テーブルの2016～2025年レコード数確認
3. 各カラムの充填率チェック（80%以上を選定）
4. 200～220カラムの選定リスト作成
5. データ抽出スクリプト実装
6. 最終CSV生成

---

**Phase 7-A Day 6 進行中** 🚀
