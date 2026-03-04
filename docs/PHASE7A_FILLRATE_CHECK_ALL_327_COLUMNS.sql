-- ============================================================
-- Phase 7-A: 全327カラム充填率チェック SQL
-- 作成日: 2026-03-03
-- 目的: JRA-VAN 4テーブル（jvd_se, jvd_ra, jvd_ck, jvd_um）の
--       全327カラムの充填率を確認し、データが存在するカラムを特定
-- ============================================================

-- ============================================================
-- 1. jvd_se (70カラム) - 2016～2025年
-- ============================================================

SELECT 
    'jvd_se' AS table_name,
    COUNT(*) AS total_records,
    
    -- 基本情報（21カラム）
    ROUND(100.0 * COUNT(kaisai_nen) / COUNT(*), 2) AS kaisai_nen_rate,
    ROUND(100.0 * COUNT(kaisai_tsukihi) / COUNT(*), 2) AS kaisai_tsukihi_rate,
    ROUND(100.0 * COUNT(keibajo_code) / COUNT(*), 2) AS keibajo_code_rate,
    ROUND(100.0 * COUNT(kaisai_kai) / COUNT(*), 2) AS kaisai_kai_rate,
    ROUND(100.0 * COUNT(kaisai_nichime) / COUNT(*), 2) AS kaisai_nichime_rate,
    ROUND(100.0 * COUNT(race_bango) / COUNT(*), 2) AS race_bango_rate,
    ROUND(100.0 * COUNT(umaban) / COUNT(*), 2) AS umaban_rate,
    ROUND(100.0 * COUNT(ketto_toroku_bango) / COUNT(*), 2) AS ketto_rate,
    ROUND(100.0 * COUNT(wakuban) / COUNT(*), 2) AS wakuban_rate,
    ROUND(100.0 * COUNT(seibetsu_code) / COUNT(*), 2) AS seibetsu_rate,
    ROUND(100.0 * COUNT(barei) / COUNT(*), 2) AS barei_rate,
    ROUND(100.0 * COUNT(kishu_code) / COUNT(*), 2) AS kishu_code_rate,
    ROUND(100.0 * COUNT(kishumei) / COUNT(*), 2) AS kishumei_rate,
    ROUND(100.0 * COUNT(futan_juryo) / COUNT(*), 2) AS futan_juryo_rate,
    ROUND(100.0 * COUNT(blinker_shiyo_kubun) / COUNT(*), 2) AS blinker_rate,
    ROUND(100.0 * COUNT(zogen_sa) / COUNT(*), 2) AS zogen_sa_rate,
    ROUND(100.0 * COUNT(bataiju) / COUNT(*), 2) AS bataiju_rate,
    ROUND(100.0 * COUNT(chokyoshi_code) / COUNT(*), 2) AS chokyoshi_code_rate,
    ROUND(100.0 * COUNT(chokyoshimei) / COUNT(*), 2) AS chokyoshimei_rate,
    ROUND(100.0 * COUNT(banushi_code) / COUNT(*), 2) AS banushi_code_rate,
    ROUND(100.0 * COUNT(banushimei) / COUNT(*), 2) AS banushimei_rate
    
FROM jvd_se
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 2. jvd_ra (62カラム) - 2016～2025年
-- ============================================================

SELECT 
    'jvd_ra' AS table_name,
    COUNT(*) AS total_records,
    
    -- レース条件（12カラム）
    ROUND(100.0 * COUNT(kyori) / COUNT(*), 2) AS kyori_rate,
    ROUND(100.0 * COUNT(track_code) / COUNT(*), 2) AS track_code_rate,
    ROUND(100.0 * COUNT(tenko_code) / COUNT(*), 2) AS tenko_code_rate,
    ROUND(100.0 * COUNT(babajotai_code_shiba) / COUNT(*), 2) AS baba_shiba_rate,
    ROUND(100.0 * COUNT(babajotai_code_dirt) / COUNT(*), 2) AS baba_dirt_rate,
    ROUND(100.0 * COUNT(grade_code) / COUNT(*), 2) AS grade_code_rate,
    ROUND(100.0 * COUNT(hasso_jikoku) / COUNT(*), 2) AS hasso_jikoku_rate,
    ROUND(100.0 * COUNT(shusso_tosu) / COUNT(*), 2) AS shusso_tosu_rate,
    ROUND(100.0 * COUNT(keibajo_season_code) / COUNT(*), 2) AS season_code_rate,
    ROUND(100.0 * COUNT(race_shubetsu_code) / COUNT(*), 2) AS race_shubetsu_rate,
    ROUND(100.0 * COUNT(joken_code) / COUNT(*), 2) AS joken_code_rate,
    ROUND(100.0 * COUNT(honshokin) / COUNT(*), 2) AS honshokin_rate
    
FROM jvd_ra
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 3. jvd_ck (106カラム) - 2016～2025年
-- ============================================================

SELECT 
    'jvd_ck' AS table_name,
    COUNT(*) AS total_records,
    
    -- 調教データ（11カラム）
    ROUND(100.0 * COUNT(chokyo_type) / COUNT(*), 2) AS chokyo_type_rate,
    ROUND(100.0 * COUNT(chokyo_course_shubetsu) / COUNT(*), 2) AS chokyo_course_rate,
    ROUND(100.0 * COUNT(chokyo_kyori) / COUNT(*), 2) AS chokyo_kyori_rate,
    ROUND(100.0 * COUNT(chokyo_jokyo) / COUNT(*), 2) AS chokyo_jokyo_rate,
    ROUND(100.0 * COUNT(chokyo_shurui) / COUNT(*), 2) AS chokyo_shurui_rate,
    ROUND(100.0 * COUNT(chokyo_hyoka) / COUNT(*), 2) AS chokyo_hyoka_rate,
    ROUND(100.0 * COUNT(kakko_nai_50m) / COUNT(*), 2) AS time_50m_rate,
    ROUND(100.0 * COUNT(kakko_nai_40m) / COUNT(*), 2) AS time_40m_rate,
    ROUND(100.0 * COUNT(kakko_nai_30m) / COUNT(*), 2) AS time_30m_rate,
    ROUND(100.0 * COUNT(kakko_nai_20m) / COUNT(*), 2) AS time_20m_rate,
    ROUND(100.0 * COUNT(kakko_nai_10m) / COUNT(*), 2) AS time_10m_rate
    
FROM jvd_ck
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 4. jvd_um (89カラム) - 全件
-- ============================================================

SELECT 
    'jvd_um' AS table_name,
    COUNT(*) AS total_records,
    
    -- 成績統計（40カラム）
    ROUND(100.0 * COUNT(heichi_honshokin_ruikei) / COUNT(*), 2) AS heichi_honshokin_rate,
    ROUND(100.0 * COUNT(shogai_honshokin_ruikei) / COUNT(*), 2) AS shogai_honshokin_rate,
    ROUND(100.0 * COUNT(heichi_shutokushokin_ruikei) / COUNT(*), 2) AS heichi_shutoku_rate,
    ROUND(100.0 * COUNT(shogai_shutokushokin_ruikei) / COUNT(*), 2) AS shogai_shutoku_rate,
    ROUND(100.0 * COUNT(sogo) / COUNT(*), 2) AS sogo_rate,
    ROUND(100.0 * COUNT(chuo_gokei) / COUNT(*), 2) AS chuo_gokei_rate,
    ROUND(100.0 * COUNT(shiba_choku) / COUNT(*), 2) AS shiba_choku_rate,
    ROUND(100.0 * COUNT(shiba_migi) / COUNT(*), 2) AS shiba_migi_rate,
    ROUND(100.0 * COUNT(shiba_hidari) / COUNT(*), 2) AS shiba_hidari_rate,
    ROUND(100.0 * COUNT(dirt_choku) / COUNT(*), 2) AS dirt_choku_rate,
    ROUND(100.0 * COUNT(dirt_migi) / COUNT(*), 2) AS dirt_migi_rate,
    ROUND(100.0 * COUNT(dirt_hidari) / COUNT(*), 2) AS dirt_hidari_rate,
    ROUND(100.0 * COUNT(shiba_ryo) / COUNT(*), 2) AS shiba_ryo_rate,
    ROUND(100.0 * COUNT(shiba_yayaomo) / COUNT(*), 2) AS shiba_yayaomo_rate,
    ROUND(100.0 * COUNT(shiba_omo) / COUNT(*), 2) AS shiba_omo_rate,
    ROUND(100.0 * COUNT(shiba_furyo) / COUNT(*), 2) AS shiba_furyo_rate,
    ROUND(100.0 * COUNT(dirt_ryo) / COUNT(*), 2) AS dirt_ryo_rate,
    ROUND(100.0 * COUNT(dirt_yayaomo) / COUNT(*), 2) AS dirt_yayaomo_rate,
    ROUND(100.0 * COUNT(dirt_omo) / COUNT(*), 2) AS dirt_omo_rate,
    ROUND(100.0 * COUNT(dirt_furyo) / COUNT(*), 2) AS dirt_furyo_rate,
    ROUND(100.0 * COUNT(shiba_1200_ika) / COUNT(*), 2) AS shiba_1200_ika_rate,
    ROUND(100.0 * COUNT(shiba_1201_1400) / COUNT(*), 2) AS shiba_1201_1400_rate,
    ROUND(100.0 * COUNT(shiba_1401_1600) / COUNT(*), 2) AS shiba_1401_1600_rate,
    ROUND(100.0 * COUNT(shiba_1601_1800) / COUNT(*), 2) AS shiba_1601_1800_rate,
    ROUND(100.0 * COUNT(shiba_1801_2000) / COUNT(*), 2) AS shiba_1801_2000_rate,
    ROUND(100.0 * COUNT(shiba_2001_2200) / COUNT(*), 2) AS shiba_2001_2200_rate,
    ROUND(100.0 * COUNT(shiba_2201_2400) / COUNT(*), 2) AS shiba_2201_2400_rate,
    ROUND(100.0 * COUNT(shiba_2401_2800) / COUNT(*), 2) AS shiba_2401_2800_rate,
    ROUND(100.0 * COUNT(shiba_2801_ijo) / COUNT(*), 2) AS shiba_2801_ijo_rate,
    ROUND(100.0 * COUNT(shiba_sapporo) / COUNT(*), 2) AS shiba_sapporo_rate,
    ROUND(100.0 * COUNT(shiba_hakodate) / COUNT(*), 2) AS shiba_hakodate_rate,
    ROUND(100.0 * COUNT(shiba_fukushima) / COUNT(*), 2) AS shiba_fukushima_rate,
    ROUND(100.0 * COUNT(shiba_niigata) / COUNT(*), 2) AS shiba_niigata_rate,
    ROUND(100.0 * COUNT(shiba_tokyo) / COUNT(*), 2) AS shiba_tokyo_rate,
    ROUND(100.0 * COUNT(shiba_nakayama) / COUNT(*), 2) AS shiba_nakayama_rate,
    ROUND(100.0 * COUNT(shiba_chukyo) / COUNT(*), 2) AS shiba_chukyo_rate,
    ROUND(100.0 * COUNT(shiba_kyoto) / COUNT(*), 2) AS shiba_kyoto_rate,
    ROUND(100.0 * COUNT(shiba_hanshin) / COUNT(*), 2) AS shiba_hanshin_rate,
    ROUND(100.0 * COUNT(shiba_kokura) / COUNT(*), 2) AS shiba_kokura_rate,
    ROUND(100.0 * COUNT(kyakushitsu_keiko) / COUNT(*), 2) AS kyakushitsu_keiko_rate
    
FROM jvd_um;

-- ============================================================
-- 実行結果を CSV エクスポートしてください
-- ============================================================
