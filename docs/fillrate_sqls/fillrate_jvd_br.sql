-- 充填率チェック: jvd_br (11カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_br' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(seisansha_code) AS cnt_seisansha_code,
    ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisansha_code,
    COUNT(seisanshamei_hojinkaku) AS cnt_seisanshamei_hojinkaku,
    ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisanshamei_hojinkaku,
    COUNT(seisanshamei) AS cnt_seisanshamei,
    ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisanshamei,
    COUNT(seisanshamei_hankaku_kana) AS cnt_seisanshamei_hankaku_kana,
    ROUND(COUNT(seisanshamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisanshamei_hankaku_kana,
    COUNT(seisanshamei_eur) AS cnt_seisanshamei_eur,
    ROUND(COUNT(seisanshamei_eur)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisanshamei_eur,
    COUNT(seisansha_jusho_jichishomei) AS cnt_seisansha_jusho_jichishomei,
    ROUND(COUNT(seisansha_jusho_jichishomei)::NUMERIC / COUNT(*) * 100, 2) AS rate_seisansha_jusho_jichishomei,
    COUNT(seiseki_joho_1) AS cnt_seiseki_joho_1,
    ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) AS rate_seiseki_joho_1,
    COUNT(seiseki_joho_2) AS cnt_seiseki_joho_2,
    ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) AS rate_seiseki_joho_2
FROM jvd_br
;