-- 充填率チェック: jvd_hy (6カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_hy' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(ketto_toroku_bango) AS cnt_ketto_toroku_bango,
    ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) AS rate_ketto_toroku_bango,
    COUNT(bamei) AS cnt_bamei,
    ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) AS rate_bamei,
    COUNT(bamei_imi_yurai) AS cnt_bamei_imi_yurai,
    ROUND(COUNT(bamei_imi_yurai)::NUMERIC / COUNT(*) * 100, 2) AS rate_bamei_imi_yurai
FROM jvd_hy
;