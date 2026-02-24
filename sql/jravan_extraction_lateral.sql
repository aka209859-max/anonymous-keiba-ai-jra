-- ============================================================================
-- JRA-VAN Phase 1-A: LATERAL JOIN版（確実完走・97列）
-- ============================================================================
-- 設計方針: 
--   1. LATERAL JOINで過去走を効率的に取得（ROW_NUMBER不要）
--   2. 年別実行を想定（WHERE ra.kaisai_nen = 'YYYY'）
--   3. pg_input_is_validで型安全性確保
--   4. 仕様書準拠の97列を出力
-- ============================================================================

WITH target_races AS (
    -- 対象レース（2016-2025年、年別実行）
    SELECT 
        ra.kaisai_nen,
        ra.kaisai_tsukihi,
        ra.keibajo_code,
        ra.race_bango,
        se.umaban,
        se.ketto_toroku_bango,
        se.wakuban,
        se.seibetsu_code,
        
        -- A. 基礎情報系（24列）
        EXTRACT(MONTH FROM TO_DATE(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi, 4, '0'), 'YYYYMMDD')) AS month,
        CASE 
            WHEN pg_input_is_valid(TRIM(ra.kyori), 'int4') THEN TRIM(ra.kyori)::int4
            ELSE NULL 
        END AS kyori,
        ra.track_code,
        ra.tenko_code,
        ra.babajotai_code_shiba,
        ra.babajotai_code_dirt,
        ra.hasso_jikoku,
        ra.grade_code,
        CASE 
            WHEN ra.keibajo_code = '10' AND EXTRACT(MONTH FROM TO_DATE(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi, 4, '0'), 'YYYYMMDD')) IN (7, 8) 
            THEN '10_summer'
            WHEN ra.keibajo_code = '10' AND EXTRACT(MONTH FROM TO_DATE(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi, 4, '0'), 'YYYYMMDD')) IN (1, 2) 
            THEN '10_winter'
            ELSE ra.keibajo_code
        END AS keibajo_season_code,
        CASE 
            WHEN pg_input_is_valid(TRIM(ra.shusso_tosu), 'int4') THEN TRIM(ra.shusso_tosu)::int4
            ELSE NULL 
        END AS shusso_tosu,
        CASE 
            WHEN pg_input_is_valid(TRIM(se.barei), 'int4') THEN TRIM(se.barei)::int4
            ELSE NULL 
        END AS barei,
        se.kishumei_ryakusho,
        se.chokyoshimei_ryakusho,
        se.blinker_shiyo_kubun,
        CASE 
            WHEN pg_input_is_valid(TRIM(se.bataiju), 'numeric') THEN TRIM(se.bataiju)::numeric
            ELSE NULL 
        END AS bataiju,
        CASE 
            WHEN pg_input_is_valid(TRIM(se.zogen_sa), 'numeric') THEN TRIM(se.zogen_sa)::numeric
            ELSE NULL 
        END AS zogen_sa,
        se.banushimei,
        
        -- レース日付（内部計算用）
        CASE 
            WHEN ra.kaisai_nen ~ '^[0-9]{4}$' AND ra.kaisai_tsukihi ~ '^[0-9]{1,4}$'
            THEN CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT)
            ELSE NULL 
        END AS race_date_int,
        
        -- D. ターゲット変数（1列）
        CASE
            WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                AND TRIM(se.kakutei_chakujun)::int4 BETWEEN 1 AND 3
            THEN 1 ELSE 0
        END AS target_top3
        
    FROM jvd_ra ra
    INNER JOIN jvd_se se ON (
        ra.kaisai_nen = se.kaisai_nen
        AND ra.kaisai_tsukihi = se.kaisai_tsukihi
        AND ra.keibajo_code = se.keibajo_code
        AND ra.race_bango = se.race_bango
    )
    WHERE ra.kaisai_nen ~ '^[0-9]{4}$'
        AND ra.kaisai_nen BETWEEN '2016' AND '2025'
        -- 年別実行時はここを修正: AND ra.kaisai_nen = '2016'
        AND ra.kaisai_tsukihi ~ '^[0-9]{1,4}$'
)

SELECT
    tr.kaisai_nen,
    tr.kaisai_tsukihi,
    tr.keibajo_code,
    tr.race_bango,
    tr.umaban,
    tr.ketto_toroku_bango,
    tr.wakuban,
    tr.seibetsu_code,
    
    -- A. 基礎情報系（24列）
    tr.month,
    tr.kyori,
    tr.track_code,
    tr.tenko_code,
    tr.babajotai_code_shiba,
    tr.babajotai_code_dirt,
    tr.hasso_jikoku,
    tr.grade_code,
    tr.keibajo_season_code,
    tr.shusso_tosu,
    tr.barei,
    tr.kishumei_ryakusho,
    tr.chokyoshimei_ryakusho,
    tr.blinker_shiyo_kubun,
    tr.bataiju,
    tr.zogen_sa,
    tr.banushimei,
    
    -- B. 馬実績データ（14列）
    ck.toroku_race_su,
    ck.sogo AS total_races,
    ck.chuo_gokei,
    ck.honshoi_shokin_gokei,
    ck.kyakushitsu_keiko,
    ck.fukusho AS fukusho_count,
    ck.shiba_chakkaisu_1 AS shiba_win_count,
    ck.dirt_chakkaisu_1 AS dirt_win_count,
    ck.juuryo_baba_chakkaisu_1 AS heavy_win_count,
    ck.kyori_betu_chakkaisu_1_1 AS distance_1000_1300_win,
    ck.kyori_betu_chakkaisu_1_2 AS distance_1301_1899_win,
    ck.kyori_betu_chakkaisu_1_3 AS distance_1900_2100_win,
    ck.kyori_betu_chakkaisu_1_4 AS distance_2101_2700_win,
    ck.kyori_betu_chakkaisu_1_5 AS distance_2701_plus_win,
    
    -- C-1. 高解像度レイヤー（直近2走詳細: 28列）
    -- 直近1走（t-1）
    prev1.kakutei_chakujun AS prev1_rank,
    prev1.soha_time AS prev1_time,
    prev1.kohan_3f AS prev1_last_3f,
    prev1.corner_1 AS prev1_corner1,
    prev1.corner_4 AS prev1_corner4,
    prev1.bataiju AS prev1_weight,
    prev1.zogen_sa AS prev1_weight_change,
    prev1.kyori AS prev1_distance,
    prev1.track_code AS prev1_track,
    prev1.keibajo AS prev1_venue,
    prev1.kishumei AS prev1_jockey,
    prev1.baba_jotai AS prev1_ground_condition,
    prev1.tenko AS prev1_weather,
    prev1.race_shubetsu AS prev1_race_type,
    
    -- 直近2走（t-2）
    prev2.kakutei_chakujun AS prev2_rank,
    prev2.soha_time AS prev2_time,
    prev2.kohan_3f AS prev2_last_3f,
    prev2.corner_1 AS prev2_corner1,
    prev2.corner_4 AS prev2_corner4,
    prev2.bataiju AS prev2_weight,
    prev2.zogen_sa AS prev2_weight_change,
    prev2.kyori AS prev2_distance,
    prev2.track_code AS prev2_track,
    prev2.keibajo AS prev2_venue,
    prev2.kishumei AS prev2_jockey,
    prev2.baba_jotai AS prev2_ground_condition,
    prev2.tenko AS prev2_weather,
    prev2.race_shubetsu AS prev2_race_type,
    
    -- C-2. 低解像度レイヤー（過去5走統計: 18列）
    past5.avg_rank AS past5_rank_avg,
    past5.min_rank AS past5_rank_best,
    past5.max_rank AS past5_rank_worst,
    past5.avg_time AS past5_time_avg,
    past5.min_time AS past5_time_best,
    past5.avg_last_3f AS past5_last_3f_avg,
    past5.min_last_3f AS past5_last_3f_best,
    past5.avg_corner1 AS past5_corner1_avg,
    past5.avg_corner4 AS past5_corner4_avg,
    past5.avg_weight AS past5_weight_avg,
    past5.avg_weight_change AS past5_weight_change_avg,
    past5.turf_count AS past5_turf_count,
    past5.dirt_count AS past5_dirt_count,
    past5.win_count AS past5_win_count,
    past5.top3_count AS past5_top3_count,
    past5.race_count AS past5_race_count,
    past5.avg_distance AS past5_distance_avg,
    past5.days_since_last AS days_since_last_race,
    
    -- C-3. コンテキストレイヤー（条件別実績: 12列）
    ctx.same_venue_avg_rank,
    ctx.same_venue_count,
    ctx.same_distance_avg_rank,
    ctx.same_distance_count,
    ctx.same_track_avg_rank,
    ctx.same_track_count,
    ctx.same_jockey_avg_rank,
    ctx.same_jockey_count,
    ctx.heavy_ground_avg_rank,
    ctx.heavy_ground_count,
    ctx.turf_avg_rank,
    ctx.dirt_avg_rank,
    
    -- D. ターゲット変数（1列）
    tr.target_top3

FROM target_races tr

-- 馬実績データ（B）
LEFT JOIN jvd_ck ck ON tr.ketto_toroku_bango = ck.ketto_toroku_bango

-- C-1. 直近1走（LATERAL JOIN）
LEFT JOIN LATERAL (
    SELECT
        se.kakutei_chakujun,
        se.soha_time,
        se.kohan_3f,
        se.corner_1,
        se.corner_4,
        se.bataiju,
        se.zogen_sa,
        ra.kyori,
        ra.track_code,
        ra.keibajo_code AS keibajo,
        se.kishumei_ryakusho AS kishumei,
        ra.babajotai_code_shiba AS baba_jotai,
        ra.tenko_code AS tenko,
        ra.race_shubetsu_code AS race_shubetsu
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (
        se.kaisai_nen = ra.kaisai_nen
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.race_bango = ra.race_bango
    )
    WHERE se.ketto_toroku_bango = tr.ketto_toroku_bango
        AND CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) < tr.race_date_int
    ORDER BY CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) DESC
    LIMIT 1
) prev1 ON true

-- C-1. 直近2走（LATERAL JOIN）
LEFT JOIN LATERAL (
    SELECT
        se.kakutei_chakujun,
        se.soha_time,
        se.kohan_3f,
        se.corner_1,
        se.corner_4,
        se.bataiju,
        se.zogen_sa,
        ra.kyori,
        ra.track_code,
        ra.keibajo_code AS keibajo,
        se.kishumei_ryakusho AS kishumei,
        ra.babajotai_code_shiba AS baba_jotai,
        ra.tenko_code AS tenko,
        ra.race_shubetsu_code AS race_shubetsu
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (
        se.kaisai_nen = ra.kaisai_nen
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.race_bango = ra.race_bango
    )
    WHERE se.ketto_toroku_bango = tr.ketto_toroku_bango
        AND CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) < tr.race_date_int
    ORDER BY CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) DESC
    LIMIT 1 OFFSET 1
) prev2 ON true

-- C-2. 過去5走統計（LATERAL JOIN）
LEFT JOIN LATERAL (
    SELECT
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4') 
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS avg_rank,
        MIN(CASE WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4') 
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS min_rank,
        MAX(CASE WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4') 
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS max_rank,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.soha_time), 'numeric') 
                 THEN TRIM(se.soha_time)::numeric END) AS avg_time,
        MIN(CASE WHEN pg_input_is_valid(TRIM(se.soha_time), 'numeric') 
                 THEN TRIM(se.soha_time)::numeric END) AS min_time,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.kohan_3f), 'numeric') 
                 THEN TRIM(se.kohan_3f)::numeric END) AS avg_last_3f,
        MIN(CASE WHEN pg_input_is_valid(TRIM(se.kohan_3f), 'numeric') 
                 THEN TRIM(se.kohan_3f)::numeric END) AS min_last_3f,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.corner_1), 'int4') 
                 THEN TRIM(se.corner_1)::int4 END) AS avg_corner1,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.corner_4), 'int4') 
                 THEN TRIM(se.corner_4)::int4 END) AS avg_corner4,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.bataiju), 'numeric') 
                 THEN TRIM(se.bataiju)::numeric END) AS avg_weight,
        AVG(CASE WHEN pg_input_is_valid(TRIM(se.zogen_sa), 'numeric') 
                 THEN TRIM(se.zogen_sa)::numeric END) AS avg_weight_change,
        COUNT(CASE WHEN ra.track_code LIKE '1%' THEN 1 END) AS turf_count,
        COUNT(CASE WHEN ra.track_code LIKE '2%' THEN 1 END) AS dirt_count,
        COUNT(CASE WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4') 
                   AND TRIM(se.kakutei_chakujun)::int4 = 1 THEN 1 END) AS win_count,
        COUNT(CASE WHEN pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4') 
                   AND TRIM(se.kakutei_chakujun)::int4 <= 3 THEN 1 END) AS top3_count,
        COUNT(*) AS race_count,
        AVG(CASE WHEN pg_input_is_valid(TRIM(ra.kyori), 'int4') 
                 THEN TRIM(ra.kyori)::int4 END) AS avg_distance,
        (tr.race_date_int - MAX(CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT))) / 10000 AS days_since_last
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (
        se.kaisai_nen = ra.kaisai_nen
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.race_bango = ra.race_bango
    )
    WHERE se.ketto_toroku_bango = tr.ketto_toroku_bango
        AND CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) < tr.race_date_int
    ORDER BY CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) DESC
    LIMIT 5
) past5 ON true

-- C-3. コンテキストレイヤー（LATERAL JOIN）
LEFT JOIN LATERAL (
    SELECT
        AVG(CASE WHEN ra.keibajo_code = tr.keibajo_code 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS same_venue_avg_rank,
        COUNT(CASE WHEN ra.keibajo_code = tr.keibajo_code THEN 1 END) AS same_venue_count,
        AVG(CASE WHEN ra.kyori = tr.kyori 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS same_distance_avg_rank,
        COUNT(CASE WHEN ra.kyori = tr.kyori THEN 1 END) AS same_distance_count,
        AVG(CASE WHEN ra.track_code = tr.track_code 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS same_track_avg_rank,
        COUNT(CASE WHEN ra.track_code = tr.track_code THEN 1 END) AS same_track_count,
        AVG(CASE WHEN se.kishumei_ryakusho = tr.kishumei_ryakusho 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS same_jockey_avg_rank,
        COUNT(CASE WHEN se.kishumei_ryakusho = tr.kishumei_ryakusho THEN 1 END) AS same_jockey_count,
        AVG(CASE WHEN ra.babajotai_code_shiba IN ('3', '4') 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS heavy_ground_avg_rank,
        COUNT(CASE WHEN ra.babajotai_code_shiba IN ('3', '4') THEN 1 END) AS heavy_ground_count,
        AVG(CASE WHEN ra.track_code LIKE '1%' 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS turf_avg_rank,
        AVG(CASE WHEN ra.track_code LIKE '2%' 
                 AND pg_input_is_valid(TRIM(se.kakutei_chakujun), 'int4')
                 THEN TRIM(se.kakutei_chakujun)::int4 END) AS dirt_avg_rank
    FROM jvd_se se
    INNER JOIN jvd_ra ra ON (
        se.kaisai_nen = ra.kaisai_nen
        AND se.kaisai_tsukihi = ra.kaisai_tsukihi
        AND se.keibajo_code = ra.keibajo_code
        AND se.race_bango = ra.race_bango
    )
    WHERE se.ketto_toroku_bango = tr.ketto_toroku_bango
        AND CAST(ra.kaisai_nen || LPAD(ra.kaisai_tsukihi::TEXT, 4, '0') AS BIGINT) < tr.race_date_int
) ctx ON true

ORDER BY tr.kaisai_nen, tr.kaisai_tsukihi, tr.keibajo_code, tr.race_bango, tr.umaban;
