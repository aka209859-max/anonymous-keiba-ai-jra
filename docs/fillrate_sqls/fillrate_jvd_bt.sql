-- 充填率チェック: jvd_bt (7カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_bt' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(hanshoku_toroku_bango) AS cnt_hanshoku_toroku_bango,
    ROUND(COUNT(hanshoku_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) AS rate_hanshoku_toroku_bango,
    COUNT(keito_id) AS cnt_keito_id,
    ROUND(COUNT(keito_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_keito_id,
    COUNT(keito_mei) AS cnt_keito_mei,
    ROUND(COUNT(keito_mei)::NUMERIC / COUNT(*) * 100, 2) AS rate_keito_mei,
    COUNT(keito_setsumei) AS cnt_keito_setsumei,
    ROUND(COUNT(keito_setsumei)::NUMERIC / COUNT(*) * 100, 2) AS rate_keito_setsumei
FROM jvd_bt
;