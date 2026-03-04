-- 充填率チェック: jvd_hc (14カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_hc' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(tracen_kubun) AS cnt_tracen_kubun,
    ROUND(COUNT(tracen_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_tracen_kubun,
    COUNT(chokyo_nengappi) AS cnt_chokyo_nengappi,
    ROUND(COUNT(chokyo_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_chokyo_nengappi,
    COUNT(chokyo_jikoku) AS cnt_chokyo_jikoku,
    ROUND(COUNT(chokyo_jikoku)::NUMERIC / COUNT(*) * 100, 2) AS rate_chokyo_jikoku,
    COUNT(ketto_toroku_bango) AS cnt_ketto_toroku_bango,
    ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) AS rate_ketto_toroku_bango,
    COUNT(time_gokei_4f) AS cnt_time_gokei_4f,
    ROUND(COUNT(time_gokei_4f)::NUMERIC / COUNT(*) * 100, 2) AS rate_time_gokei_4f,
    COUNT(lap_time_4f) AS cnt_lap_time_4f,
    ROUND(COUNT(lap_time_4f)::NUMERIC / COUNT(*) * 100, 2) AS rate_lap_time_4f,
    COUNT(time_gokei_3f) AS cnt_time_gokei_3f,
    ROUND(COUNT(time_gokei_3f)::NUMERIC / COUNT(*) * 100, 2) AS rate_time_gokei_3f,
    COUNT(lap_time_3f) AS cnt_lap_time_3f,
    ROUND(COUNT(lap_time_3f)::NUMERIC / COUNT(*) * 100, 2) AS rate_lap_time_3f,
    COUNT(time_gokei_2f) AS cnt_time_gokei_2f,
    ROUND(COUNT(time_gokei_2f)::NUMERIC / COUNT(*) * 100, 2) AS rate_time_gokei_2f,
    COUNT(lap_time_2f) AS cnt_lap_time_2f,
    ROUND(COUNT(lap_time_2f)::NUMERIC / COUNT(*) * 100, 2) AS rate_lap_time_2f,
    COUNT(lap_time_1f) AS cnt_lap_time_1f,
    ROUND(COUNT(lap_time_1f)::NUMERIC / COUNT(*) * 100, 2) AS rate_lap_time_1f
FROM jvd_hc
;