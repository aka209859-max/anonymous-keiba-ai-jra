-- 充填率チェック: jvd_cs (8カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_cs' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(keibajo_code) AS cnt_keibajo_code,
    ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_keibajo_code,
    COUNT(kyori) AS cnt_kyori,
    ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) AS rate_kyori,
    COUNT(track_code) AS cnt_track_code,
    ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_track_code,
    COUNT(course_kaishu_nengappi) AS cnt_course_kaishu_nengappi,
    ROUND(COUNT(course_kaishu_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_course_kaishu_nengappi,
    COUNT(course_setsumei) AS cnt_course_setsumei,
    ROUND(COUNT(course_setsumei)::NUMERIC / COUNT(*) * 100, 2) AS rate_course_setsumei
FROM jvd_cs
;