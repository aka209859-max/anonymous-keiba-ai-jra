-- ==========================================
-- Phase 7-A Day 5: 修正版充填率チェックSQL
-- 作成日: 2026-03-03
-- ==========================================

-- ==========================================
-- 1. jrd_sed の年次範囲確認（まず年次形式を確認）
-- ==========================================
SELECT 
    race_shikonen,
    COUNT(*) as record_count
FROM jrd_sed
GROUP BY race_shikonen
ORDER BY race_shikonen DESC
LIMIT 20;

-- ==========================================
-- 2. jrd_sed の全レコード充填率チェック（年次フィルタなし）
-- ==========================================
SELECT 
    COUNT(*) as total_records,
    COUNT(soha_time) as time_filled,
    COUNT(pace) as pace_filled,
    COUNT(idm) as idm_filled,
    COUNT(babasa) as babasa_filled,
    COUNT(deokure) as deokure_filled,
    COUNT(ichidori) as ichidori_filled,
    COUNT(corner_1) as corner1_filled,
    COUNT(corner_2) as corner2_filled,
    COUNT(corner_3) as corner3_filled,
    COUNT(corner_4) as corner4_filled,
    COUNT(zenhan_3f_taimu) as zenhan_3f_filled,
    COUNT(kohan_3f) as kohan_3f_filled,
    COUNT(ten_shisu) as ten_filled,
    COUNT(agari_shisu) as agari_filled,
    COUNT(pace_shisu) as pace_shisu_filled,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(soha_time) / COUNT(*), 2) 
        ELSE 0 
    END as time_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(pace) / COUNT(*), 2) 
        ELSE 0 
    END as pace_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(idm) / COUNT(*), 2) 
        ELSE 0 
    END as idm_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(corner_1) / COUNT(*), 2) 
        ELSE 0 
    END as corner_rate
FROM jrd_sed;

-- ==========================================
-- 3. jvd_um のカラム名確認（実際のカラム名をリスト）
-- ==========================================
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_um'
    AND (
        column_name LIKE '%shiba%' 
        OR column_name LIKE '%dirt%'
        OR column_name LIKE '%honshokin%'
        OR column_name LIKE '%tokyo%'
        OR column_name LIKE '%nakayama%'
    )
ORDER BY column_name;

-- ==========================================
-- 4. jvd_um の基本充填率チェック（カラム名修正版）
-- ==========================================
SELECT 
    COUNT(*) as total_records,
    COUNT(heichi_honshokin_ruikei) as honshokin_filled,
    COUNT(shiba_ryo) as shiba_ryo_filled,
    COUNT(shiba_omo) as shiba_omo_filled,
    COUNT(dirt_ryo) as dirt_ryo_filled,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(heichi_honshokin_ruikei) / COUNT(*), 2) 
        ELSE 0 
    END as honshokin_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(shiba_ryo) / COUNT(*), 2) 
        ELSE 0 
    END as shiba_ryo_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(dirt_ryo) / COUNT(*), 2) 
        ELSE 0 
    END as dirt_ryo_rate
FROM jvd_um;

-- ==========================================
-- 5. jvd_ra の主要カラム充填率チェック
-- ==========================================
SELECT 
    COUNT(*) as total_records,
    COUNT(kyori) as distance_filled,
    COUNT(track_code) as track_filled,
    COUNT(babajotai_code_shiba) as baba_shiba_filled,
    COUNT(babajotai_code_dirt) as baba_dirt_filled,
    COUNT(tenko_code) as weather_filled,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(kyori) / COUNT(*), 2) 
        ELSE 0 
    END as distance_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(babajotai_code_shiba) / COUNT(*), 2) 
        ELSE 0 
    END as baba_rate
FROM jvd_ra;

-- ==========================================
-- 6. jvd_ck の主要カラム充填率チェック
-- ==========================================
SELECT 
    COUNT(*) as total_records,
    COUNT(soha_time) as time_filled,
    COUNT(tsuka_juni) as tsuka_filled,
    COUNT(agari_3f) as agari_filled,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(soha_time) / COUNT(*), 2) 
        ELSE 0 
    END as time_rate,
    CASE WHEN COUNT(*) > 0 
        THEN ROUND(100.0 * COUNT(tsuka_juni) / COUNT(*), 2) 
        ELSE 0 
    END as tsuka_rate
FROM jvd_ck;

