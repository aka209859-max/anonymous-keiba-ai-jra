-- 充填率チェック: jvd_bn (11カラム)
-- 実行時間: 約1-5分

SELECT
    'jvd_bn' AS table_name,
    COUNT(*) AS total_records,
    COUNT(record_id) AS cnt_record_id,
    ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS rate_record_id,
    COUNT(data_kubun) AS cnt_data_kubun,
    ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_kubun,
    COUNT(data_sakusei_nengappi) AS cnt_data_sakusei_nengappi,
    ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) AS rate_data_sakusei_nengappi,
    COUNT(banushi_code) AS cnt_banushi_code,
    ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) AS rate_banushi_code,
    COUNT(banushimei_hojinkaku) AS cnt_banushimei_hojinkaku,
    ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) AS rate_banushimei_hojinkaku,
    COUNT(banushimei) AS cnt_banushimei,
    ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) AS rate_banushimei,
    COUNT(banushimei_hankaku_kana) AS cnt_banushimei_hankaku_kana,
    ROUND(COUNT(banushimei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) AS rate_banushimei_hankaku_kana,
    COUNT(banushimei_eur) AS cnt_banushimei_eur,
    ROUND(COUNT(banushimei_eur)::NUMERIC / COUNT(*) * 100, 2) AS rate_banushimei_eur,
    COUNT(fukushoku_hyoji) AS cnt_fukushoku_hyoji,
    ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) AS rate_fukushoku_hyoji,
    COUNT(seiseki_joho_1) AS cnt_seiseki_joho_1,
    ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) AS rate_seiseki_joho_1,
    COUNT(seiseki_joho_2) AS cnt_seiseki_joho_2,
    ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) AS rate_seiseki_joho_2
FROM jvd_bn
;