-- ============================================================
-- JRDB充填率分析SQL
-- 目的: JRDBデータ（jrd_kyi, jrd_joa, jrd_cyb, jrd_sed）の
--       欠損パターンを特定し、レース条件との関係を明らかにする
-- 実行環境: pgAdmin4
-- 作成日: 2026-03-04
-- ============================================================

-- ============================================================
-- 【分析1】レース種別ごとのJRDB充填率
-- ============================================================
-- 目的: 新馬戦・障害戦でJRDBデータが欠損しているか確認
-- ============================================================

SELECT
    -- レース種別（jvd_raから取得）
    CASE
        WHEN ra.kyoso_kigo_code IN ('16', '17', '18', '19', '20', '21', '22') THEN '障害戦'
        WHEN se.kyoso_joken_code = '701' THEN '新馬'
        WHEN se.kyoso_joken_code = '702' THEN '未勝利'
        WHEN se.kyoso_joken_code IN ('703', '704', '705') THEN '1勝クラス'
        WHEN se.kyoso_joken_code IN ('706', '707', '708') THEN '2勝クラス'
        WHEN se.kyoso_joken_code IN ('709', '710', '711') THEN '3勝クラス'
        WHEN se.kyoso_joken_code BETWEEN '001' AND '099' THEN 'G1'
        WHEN se.kyoso_joken_code BETWEEN '100' AND '199' THEN 'G2'
        WHEN se.kyoso_joken_code BETWEEN '200' AND '299' THEN 'G3'
        WHEN se.kyoso_joken_code BETWEEN '300' AND '999' THEN 'OP/L'
        ELSE 'その他'
    END AS race_category,
    
    -- 総レース数
    COUNT(DISTINCT se.race_id) AS total_races,
    
    -- JRDB各テーブルの充填率
    COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) AS kyi_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS kyi_fillrate,
    
    COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) AS joa_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS joa_fillrate,
    
    COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) AS cyb_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS cyb_fillrate,
    
    COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) AS sed_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS sed_fillrate

FROM
    jvd_se se
    INNER JOIN jvd_ra ra ON se.race_id = ra.race_id
    LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
    LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
    LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
    LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id

WHERE
    se.data_kubun = '7'  -- 確定データのみ

GROUP BY
    race_category

ORDER BY
    total_races DESC;


-- ============================================================
-- 【分析2】年度別JRDB充填率
-- ============================================================
-- 目的: 特定年度でJRDBデータ提供が少ないか確認
-- ============================================================

SELECT
    EXTRACT(YEAR FROM ra.hassokaijo_nengappi) AS race_year,
    
    COUNT(DISTINCT se.race_id) AS total_races,
    
    -- JRDB各テーブルの充填率
    COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) AS kyi_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS kyi_fillrate,
    
    COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) AS joa_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS joa_fillrate,
    
    COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) AS cyb_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS cyb_fillrate,
    
    COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) AS sed_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS sed_fillrate

FROM
    jvd_se se
    INNER JOIN jvd_ra ra ON se.race_id = ra.race_id
    LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
    LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
    LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
    LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id

WHERE
    se.data_kubun = '7'
    AND EXTRACT(YEAR FROM ra.hassokaijo_nengappi) BETWEEN 2016 AND 2025

GROUP BY
    race_year

ORDER BY
    race_year;


-- ============================================================
-- 【分析3】競馬場別JRDB充填率
-- ============================================================
-- 目的: 特定競馬場でJRDBデータが少ないか確認
-- ============================================================

SELECT
    ra.keibajo_code,
    CASE ra.keibajo_code
        WHEN '01' THEN '札幌'
        WHEN '02' THEN '函館'
        WHEN '03' THEN '福島'
        WHEN '04' THEN '新潟'
        WHEN '05' THEN '東京'
        WHEN '06' THEN '中山'
        WHEN '07' THEN '中京'
        WHEN '08' THEN '京都'
        WHEN '09' THEN '阪神'
        WHEN '10' THEN '小倉'
        ELSE '不明'
    END AS keibajo_name,
    
    COUNT(DISTINCT se.race_id) AS total_races,
    
    -- JRDB各テーブルの充填率
    COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) AS kyi_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS kyi_fillrate,
    
    COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) AS joa_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS joa_fillrate,
    
    COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) AS cyb_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS cyb_fillrate,
    
    COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) AS sed_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS sed_fillrate

FROM
    jvd_se se
    INNER JOIN jvd_ra ra ON se.race_id = ra.race_id
    LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
    LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
    LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
    LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id

WHERE
    se.data_kubun = '7'

GROUP BY
    ra.keibajo_code

ORDER BY
    total_races DESC;


-- ============================================================
-- 【分析4】JRDBデータが欠損しているレースのサンプル抽出
-- ============================================================
-- 目的: 欠損レースの具体例を確認（最大50件）
-- ============================================================

SELECT
    ra.hassokaijo_nengappi AS race_date,
    CASE ra.keibajo_code
        WHEN '01' THEN '札幌'
        WHEN '02' THEN '函館'
        WHEN '03' THEN '福島'
        WHEN '04' THEN '新潟'
        WHEN '05' THEN '東京'
        WHEN '06' THEN '中山'
        WHEN '07' THEN '中京'
        WHEN '08' THEN '京都'
        WHEN '09' THEN '阪神'
        WHEN '10' THEN '小倉'
    END AS keibajo,
    ra.race_bango AS race_no,
    ra.kyoso_mei AS race_name,
    CASE
        WHEN ra.kyoso_kigo_code IN ('16', '17', '18', '19', '20', '21', '22') THEN '障害戦'
        WHEN se.kyoso_joken_code = '701' THEN '新馬'
        WHEN se.kyoso_joken_code = '702' THEN '未勝利'
        WHEN se.kyoso_joken_code IN ('703', '704', '705') THEN '1勝クラス'
        WHEN se.kyoso_joken_code BETWEEN '001' AND '099' THEN 'G1'
        WHEN se.kyoso_joken_code BETWEEN '100' AND '199' THEN 'G2'
        WHEN se.kyoso_joken_code BETWEEN '200' AND '299' THEN 'G3'
        ELSE 'OP/条件'
    END AS race_grade,
    
    -- 各JRDBテーブルの有無
    CASE WHEN kyi.race_id IS NOT NULL THEN '○' ELSE '×' END AS kyi_exists,
    CASE WHEN joa.race_id IS NOT NULL THEN '○' ELSE '×' END AS joa_exists,
    CASE WHEN cyb.race_id IS NOT NULL THEN '○' ELSE '×' END AS cyb_exists,
    CASE WHEN sed.race_id IS NOT NULL THEN '○' ELSE '×' END AS sed_exists

FROM
    jvd_se se
    INNER JOIN jvd_ra ra ON se.race_id = ra.race_id
    LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
    LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
    LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
    LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id

WHERE
    se.data_kubun = '7'
    AND (
        kyi.race_id IS NULL OR
        joa.race_id IS NULL OR
        cyb.race_id IS NULL OR
        sed.race_id IS NULL
    )

ORDER BY
    ra.hassokaijo_nengappi DESC,
    ra.keibajo_code,
    ra.race_bango

LIMIT 50;


-- ============================================================
-- 【分析5】芝・ダート・障害別JRDB充填率
-- ============================================================
-- 目的: トラック種別でJRDBデータ提供に差があるか確認
-- ============================================================

SELECT
    CASE
        WHEN ra.track_code IN ('10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22') THEN '芝'
        WHEN ra.track_code IN ('23', '24', '25', '26', '27', '28', '29') THEN 'ダート'
        WHEN ra.track_code IN ('51', '52', '53', '54', '55', '56', '57', '58', '59') THEN '障害'
        ELSE '不明'
    END AS track_type,
    
    COUNT(DISTINCT se.race_id) AS total_races,
    
    -- JRDB各テーブルの充填率
    COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) AS kyi_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyi.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS kyi_fillrate,
    
    COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) AS joa_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN joa.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS joa_fillrate,
    
    COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) AS cyb_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN cyb.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS cyb_fillrate,
    
    COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) AS sed_filled,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN sed.race_id IS NOT NULL THEN se.race_id END) / COUNT(DISTINCT se.race_id), 1) AS sed_fillrate

FROM
    jvd_se se
    INNER JOIN jvd_ra ra ON se.race_id = ra.race_id
    LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
    LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
    LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
    LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id

WHERE
    se.data_kubun = '7'

GROUP BY
    track_type

ORDER BY
    total_races DESC;


-- ============================================================
-- 【分析6】レース総合サマリー
-- ============================================================
-- 目的: 全体の充填状況と欠損パターンの要約
-- ============================================================

WITH race_summary AS (
    SELECT
        se.race_id,
        CASE WHEN kyi.race_id IS NOT NULL THEN 1 ELSE 0 END AS has_kyi,
        CASE WHEN joa.race_id IS NOT NULL THEN 1 ELSE 0 END AS has_joa,
        CASE WHEN cyb.race_id IS NOT NULL THEN 1 ELSE 0 END AS has_cyb,
        CASE WHEN sed.race_id IS NOT NULL THEN 1 ELSE 0 END AS has_sed
    FROM
        jvd_se se
        LEFT JOIN jrd_kyi kyi ON se.race_id = kyi.race_id
        LEFT JOIN jrd_joa joa ON se.race_id = joa.race_id
        LEFT JOIN jrd_cyb cyb ON se.race_id = cyb.race_id
        LEFT JOIN jrd_sed sed ON se.race_id = sed.race_id
    WHERE
        se.data_kubun = '7'
)

SELECT
    '全JRDB揃っている' AS data_pattern,
    COUNT(*) AS race_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM race_summary), 1) AS percentage
FROM race_summary
WHERE has_kyi = 1 AND has_joa = 1 AND has_cyb = 1 AND has_sed = 1

UNION ALL

SELECT
    '一部JRDBのみ' AS data_pattern,
    COUNT(*) AS race_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM race_summary), 1) AS percentage
FROM race_summary
WHERE (has_kyi + has_joa + has_cyb + has_sed) BETWEEN 1 AND 3

UNION ALL

SELECT
    'JRDB完全欠損' AS data_pattern,
    COUNT(*) AS race_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM race_summary), 1) AS percentage
FROM race_summary
WHERE has_kyi = 0 AND has_joa = 0 AND has_cyb = 0 AND has_sed = 0

ORDER BY race_count DESC;


-- ============================================================
-- 実行完了
-- ============================================================
-- 上記6つの分析結果をCSVエクスポートして保存してください。
-- 推奨ファイル名:
--   1. JRDB_fillrate_by_race_category.csv
--   2. JRDB_fillrate_by_year.csv
--   3. JRDB_fillrate_by_keibajo.csv
--   4. JRDB_missing_race_samples.csv
--   5. JRDB_fillrate_by_track_type.csv
--   6. JRDB_overall_pattern_summary.csv
-- ============================================================
