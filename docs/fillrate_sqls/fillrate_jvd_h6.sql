-- 充填率チェック: jvd_h6 (16カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_h6' AS table_name,
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
    COUNT(toroku_tosu) AS cnt_toroku_tosu,
    ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) AS rate_toroku_tosu,
    COUNT(shusso_tosu) AS cnt_shusso_tosu,
    ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) AS rate_shusso_tosu,
    COUNT(hatsubai_flag_sanrentan) AS cnt_hatsubai_flag_sanrentan,
    ROUND(COUNT(hatsubai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) AS rate_hatsubai_flag_sanrentan,
    COUNT(henkan_umaban_joho) AS cnt_henkan_umaban_joho,
    ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) AS rate_henkan_umaban_joho,
    COUNT(hyosu_sanrentan) AS cnt_hyosu_sanrentan,
    ROUND(COUNT(hyosu_sanrentan)::NUMERIC / COUNT(*) * 100, 2) AS rate_hyosu_sanrentan,
    COUNT(hyosu_gokei_sanrentan) AS cnt_hyosu_gokei_sanrentan,
    ROUND(COUNT(hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) AS rate_hyosu_gokei_sanrentan,
    COUNT(henkan_hyosu_gokei_sanrentan) AS cnt_henkan_hyosu_gokei_sanrentan,
    ROUND(COUNT(henkan_hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) AS rate_henkan_hyosu_gokei_sanrentan
FROM jvd_h6
WHERE kaisai_nen BETWEEN '2016' AND '2025'
;