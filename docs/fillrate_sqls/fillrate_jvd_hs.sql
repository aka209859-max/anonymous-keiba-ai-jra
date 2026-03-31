-- 充填率チェック: jvd_hs (14カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_hs' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(ketto_toroku_bango) AS cnt_ketto_toroku_bango,
    ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) AS rate_ketto_toroku_bango,
    COUNT(ketto_joho_01a) AS cnt_ketto_joho_01a,
    ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) AS rate_ketto_joho_01a,
    COUNT(ketto_joho_02a) AS cnt_ketto_joho_02a,
    ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) AS rate_ketto_joho_02a,
    COUNT(seinen) AS cnt_seinen,
    ROUND(COUNT(seinen)::NUMERIC / COUNT(*) * 100, 2) AS rate_seinen,
    COUNT(shusaisha_shijo_code) AS cnt_shusaisha_shijo_code,
    ROUND(COUNT(shusaisha_shijo_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_shusaisha_shijo_code,
    COUNT(shusaisha_meisho) AS cnt_shusaisha_meisho,
    ROUND(COUNT(shusaisha_meisho)::NUMERIC / COUNT(*) * 100, 2) AS rate_shusaisha_meisho,
    COUNT(shijo_meisho) AS cnt_shijo_meisho,
    ROUND(COUNT(shijo_meisho)::NUMERIC / COUNT(*) * 100, 2) AS rate_shijo_meisho,
    COUNT(kaisai_kikan_min) AS cnt_kaisai_kikan_min,
    ROUND(COUNT(kaisai_kikan_min)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_kikan_min,
    COUNT(kaisai_kikan_max) AS cnt_kaisai_kikan_max,
    ROUND(COUNT(kaisai_kikan_max)::NUMERIC / COUNT(*) * 100, 2) AS rate_kaisai_kikan_max,
    COUNT(torihikiji_nenrei) AS cnt_torihikiji_nenrei,
    ROUND(COUNT(torihikiji_nenrei)::NUMERIC / COUNT(*) * 100, 2) AS rate_torihikiji_nenrei,
    COUNT(torihiki_kakaku) AS cnt_torihiki_kakaku,
    ROUND(COUNT(torihiki_kakaku)::NUMERIC / COUNT(*) * 100, 2) AS rate_torihiki_kakaku
FROM jvd_hs
;