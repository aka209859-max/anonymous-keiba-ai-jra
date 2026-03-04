-- 充填率チェック: jvd_ys (12カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_ys' AS table_name,
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
    COUNT(yobi_code) AS cnt_yobi_code,
    ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_yobi_code,
    COUNT(jusho_joho_1) AS cnt_jusho_joho_1,
    ROUND(COUNT(jusho_joho_1)::NUMERIC / COUNT(*) * 100, 2) AS rate_jusho_joho_1,
    COUNT(jusho_joho_2) AS cnt_jusho_joho_2,
    ROUND(COUNT(jusho_joho_2)::NUMERIC / COUNT(*) * 100, 2) AS rate_jusho_joho_2,
    COUNT(jusho_joho_3) AS cnt_jusho_joho_3,
    ROUND(COUNT(jusho_joho_3)::NUMERIC / COUNT(*) * 100, 2) AS rate_jusho_joho_3
FROM jvd_ys
;