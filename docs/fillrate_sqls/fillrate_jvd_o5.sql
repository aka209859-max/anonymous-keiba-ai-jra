-- 充填率チェック: jvd_o5 (15カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_o5' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(kaisai_nen) AS cnt_kaisai_nen,
    ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_nen,
    COUNT(kaisai_tsukihi) AS cnt_kaisai_tsukihi,
    ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_tsukihi,
    COUNT(keibajo_code) AS cnt_keibajo_code,
    ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_keibajo_code,
    COUNT(kaisai_kai) AS cnt_kaisai_kai,
    ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_kai,
    COUNT(kaisai_nichime) AS cnt_kaisai_nichime,
    ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_nichime,
    COUNT(race_bango) AS cnt_race_bango,
    ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) AS rate_race_bango,
    COUNT(happyo_tsukihi_jifun) AS cnt_happyo_tsukihi_jifun,
    ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) AS rate_happyo_tsukihi_jifun,
    COUNT(toroku_tosu) AS cnt_toroku_tosu,
    ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) AS rate_toroku_tosu,
    COUNT(shusso_tosu) AS cnt_shusso_tosu,
    ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) AS rate_shusso_tosu,
    COUNT(hatsubai_flag_sanrenpuku) AS cnt_hatsubai_flag_sanrenpuku,
    ROUND(COUNT(hatsubai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) AS rate_hatsubai_flag_sanrenpuku,
    COUNT(odds_sanrenpuku) AS cnt_odds_sanrenpuku,
    ROUND(COUNT(odds_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) AS rate_odds_sanrenpuku,
    COUNT(hyosu_gokei_sanrenpuku) AS cnt_hyosu_gokei_sanrenpuku,
    ROUND(COUNT(hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) AS rate_hyosu_gokei_sanrenpuku
FROM jvd_o5
;