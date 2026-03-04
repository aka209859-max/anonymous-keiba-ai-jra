-- jvd_ck の走破タイム関連カラム確認
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_ck'
    AND (
        column_name LIKE '%time%'
        OR column_name LIKE '%taimu%'
        OR column_name LIKE '%soha%'
        OR column_name LIKE '%agari%'
        OR column_name LIKE '%tsuka%'
    )
ORDER BY column_name;
