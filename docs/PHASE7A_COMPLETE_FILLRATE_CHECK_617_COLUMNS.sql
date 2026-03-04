-- ============================================================
-- Phase 7-A: 全617カラム完全版充填率チェックSQL
-- 作成日: 2026-03-03
-- 対象: JRA-VAN 4テーブル(327列) + JRDB 5テーブル(290列) = 617列
-- 目的: 2016～2025年データの充填率を確認し、200～220カラム選定
-- ============================================================

-- ============================================================
-- 【JRA-VAN テーブル群】 - 2016～2025年フィルタあり
-- ============================================================

-- ============================================================
-- 1. jvd_se (70カラム) - 出走馬基本情報
-- ============================================================
SELECT 
    'jvd_se' AS table_name,
    COUNT(*) AS total_records,
    
    -- 基本情報（21カラム）
    ROUND(100.0 * COUNT(kaisai_nen) / NULLIF(COUNT(*), 0), 2) AS kaisai_nen_rate,
    ROUND(100.0 * COUNT(kaisai_tsukihi) / NULLIF(COUNT(*), 0), 2) AS kaisai_tsukihi_rate,
    ROUND(100.0 * COUNT(keibajo_code) / NULLIF(COUNT(*), 0), 2) AS keibajo_code_rate,
    ROUND(100.0 * COUNT(kaisai_kai) / NULLIF(COUNT(*), 0), 2) AS kaisai_kai_rate,
    ROUND(100.0 * COUNT(kaisai_nichime) / NULLIF(COUNT(*), 0), 2) AS kaisai_nichime_rate,
    ROUND(100.0 * COUNT(race_bango) / NULLIF(COUNT(*), 0), 2) AS race_bango_rate,
    ROUND(100.0 * COUNT(umaban) / NULLIF(COUNT(*), 0), 2) AS umaban_rate,
    ROUND(100.0 * COUNT(ketto_toroku_bango) / NULLIF(COUNT(*), 0), 2) AS ketto_rate,
    ROUND(100.0 * COUNT(wakuban) / NULLIF(COUNT(*), 0), 2) AS wakuban_rate,
    ROUND(100.0 * COUNT(seibetsu_code) / NULLIF(COUNT(*), 0), 2) AS seibetsu_rate,
    ROUND(100.0 * COUNT(barei) / NULLIF(COUNT(*), 0), 2) AS barei_rate,
    ROUND(100.0 * COUNT(kishu_code) / NULLIF(COUNT(*), 0), 2) AS kishu_code_rate,
    ROUND(100.0 * COUNT(kishumei) / NULLIF(COUNT(*), 0), 2) AS kishumei_rate,
    ROUND(100.0 * COUNT(futan_juryo) / NULLIF(COUNT(*), 0), 2) AS futan_juryo_rate,
    ROUND(100.0 * COUNT(blinker_shiyo_kubun) / NULLIF(COUNT(*), 0), 2) AS blinker_rate,
    ROUND(100.0 * COUNT(zogen_sa) / NULLIF(COUNT(*), 0), 2) AS zogen_sa_rate,
    ROUND(100.0 * COUNT(bataiju) / NULLIF(COUNT(*), 0), 2) AS bataiju_rate,
    ROUND(100.0 * COUNT(chokyoshi_code) / NULLIF(COUNT(*), 0), 2) AS chokyoshi_code_rate,
    ROUND(100.0 * COUNT(chokyoshimei) / NULLIF(COUNT(*), 0), 2) AS chokyoshimei_rate,
    ROUND(100.0 * COUNT(banushi_code) / NULLIF(COUNT(*), 0), 2) AS banushi_code_rate,
    ROUND(100.0 * COUNT(banushimei) / NULLIF(COUNT(*), 0), 2) AS banushimei_rate
    
FROM jvd_se
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 2. jvd_ra (62カラム) - レース情報
-- ============================================================
SELECT 
    'jvd_ra' AS table_name,
    COUNT(*) AS total_records,
    
    -- レース条件（12カラム）
    ROUND(100.0 * COUNT(kyori) / NULLIF(COUNT(*), 0), 2) AS kyori_rate,
    ROUND(100.0 * COUNT(track_code) / NULLIF(COUNT(*), 0), 2) AS track_code_rate,
    ROUND(100.0 * COUNT(tenko_code) / NULLIF(COUNT(*), 0), 2) AS tenko_code_rate,
    ROUND(100.0 * COUNT(babajotai_code_shiba) / NULLIF(COUNT(*), 0), 2) AS baba_shiba_rate,
    ROUND(100.0 * COUNT(babajotai_code_dirt) / NULLIF(COUNT(*), 0), 2) AS baba_dirt_rate,
    ROUND(100.0 * COUNT(grade_code) / NULLIF(COUNT(*), 0), 2) AS grade_code_rate,
    ROUND(100.0 * COUNT(hasso_jikoku) / NULLIF(COUNT(*), 0), 2) AS hasso_jikoku_rate,
    ROUND(100.0 * COUNT(shusso_tosu) / NULLIF(COUNT(*), 0), 2) AS shusso_tosu_rate,
    ROUND(100.0 * COUNT(keibajo_season_code) / NULLIF(COUNT(*), 0), 2) AS season_code_rate,
    ROUND(100.0 * COUNT(race_shubetsu_code) / NULLIF(COUNT(*), 0), 2) AS race_shubetsu_rate,
    ROUND(100.0 * COUNT(joken_code) / NULLIF(COUNT(*), 0), 2) AS joken_code_rate,
    ROUND(100.0 * COUNT(honshokin) / NULLIF(COUNT(*), 0), 2) AS honshokin_rate
    
FROM jvd_ra
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 3. jvd_ck (106カラム) - 調教情報
-- ============================================================
SELECT 
    'jvd_ck' AS table_name,
    COUNT(*) AS total_records,
    
    -- 調教データ（11カラムサンプル）
    ROUND(100.0 * COUNT(chokyo_type) / NULLIF(COUNT(*), 0), 2) AS chokyo_type_rate,
    ROUND(100.0 * COUNT(chokyo_course_shubetsu) / NULLIF(COUNT(*), 0), 2) AS chokyo_course_rate,
    ROUND(100.0 * COUNT(chokyo_kyori) / NULLIF(COUNT(*), 0), 2) AS chokyo_kyori_rate,
    ROUND(100.0 * COUNT(chokyo_jokyo) / NULLIF(COUNT(*), 0), 2) AS chokyo_jokyo_rate,
    ROUND(100.0 * COUNT(chokyo_shurui) / NULLIF(COUNT(*), 0), 2) AS chokyo_shurui_rate,
    ROUND(100.0 * COUNT(chokyo_hyoka) / NULLIF(COUNT(*), 0), 2) AS chokyo_hyoka_rate
    
FROM jvd_ck
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- ============================================================
-- 4. jvd_um (89カラム) - 馬マスタ（成績統計）
-- ============================================================
SELECT 
    'jvd_um' AS table_name,
    COUNT(*) AS total_records,
    
    -- 成績統計（40カラム）
    ROUND(100.0 * COUNT(heichi_honshokin_ruikei) / NULLIF(COUNT(*), 0), 2) AS heichi_honshokin_rate,
    ROUND(100.0 * COUNT(shogai_honshokin_ruikei) / NULLIF(COUNT(*), 0), 2) AS shogai_honshokin_rate,
    ROUND(100.0 * COUNT(heichi_shutokushokin_ruikei) / NULLIF(COUNT(*), 0), 2) AS heichi_shutoku_rate,
    ROUND(100.0 * COUNT(shogai_shutokushokin_ruikei) / NULLIF(COUNT(*), 0), 2) AS shogai_shutoku_rate,
    ROUND(100.0 * COUNT(sogo) / NULLIF(COUNT(*), 0), 2) AS sogo_rate,
    ROUND(100.0 * COUNT(chuo_gokei) / NULLIF(COUNT(*), 0), 2) AS chuo_gokei_rate,
    ROUND(100.0 * COUNT(shiba_choku) / NULLIF(COUNT(*), 0), 2) AS shiba_choku_rate,
    ROUND(100.0 * COUNT(shiba_migi) / NULLIF(COUNT(*), 0), 2) AS shiba_migi_rate,
    ROUND(100.0 * COUNT(shiba_hidari) / NULLIF(COUNT(*), 0), 2) AS shiba_hidari_rate,
    ROUND(100.0 * COUNT(dirt_choku) / NULLIF(COUNT(*), 0), 2) AS dirt_choku_rate,
    ROUND(100.0 * COUNT(dirt_migi) / NULLIF(COUNT(*), 0), 2) AS dirt_migi_rate,
    ROUND(100.0 * COUNT(dirt_hidari) / NULLIF(COUNT(*), 0), 2) AS dirt_hidari_rate,
    ROUND(100.0 * COUNT(shiba_ryo) / NULLIF(COUNT(*), 0), 2) AS shiba_ryo_rate,
    ROUND(100.0 * COUNT(shiba_yayaomo) / NULLIF(COUNT(*), 0), 2) AS shiba_yayaomo_rate,
    ROUND(100.0 * COUNT(shiba_omo) / NULLIF(COUNT(*), 0), 2) AS shiba_omo_rate,
    ROUND(100.0 * COUNT(shiba_furyo) / NULLIF(COUNT(*), 0), 2) AS shiba_furyo_rate,
    ROUND(100.0 * COUNT(dirt_ryo) / NULLIF(COUNT(*), 0), 2) AS dirt_ryo_rate,
    ROUND(100.0 * COUNT(dirt_yayaomo) / NULLIF(COUNT(*), 0), 2) AS dirt_yayaomo_rate,
    ROUND(100.0 * COUNT(dirt_omo) / NULLIF(COUNT(*), 0), 2) AS dirt_omo_rate,
    ROUND(100.0 * COUNT(dirt_furyo) / NULLIF(COUNT(*), 0), 2) AS dirt_furyo_rate,
    ROUND(100.0 * COUNT(shiba_1200_ika) / NULLIF(COUNT(*), 0), 2) AS shiba_1200_ika_rate,
    ROUND(100.0 * COUNT(shiba_1201_1400) / NULLIF(COUNT(*), 0), 2) AS shiba_1201_1400_rate,
    ROUND(100.0 * COUNT(shiba_1401_1600) / NULLIF(COUNT(*), 0), 2) AS shiba_1401_1600_rate,
    ROUND(100.0 * COUNT(shiba_1601_1800) / NULLIF(COUNT(*), 0), 2) AS shiba_1601_1800_rate,
    ROUND(100.0 * COUNT(shiba_1801_2000) / NULLIF(COUNT(*), 0), 2) AS shiba_1801_2000_rate,
    ROUND(100.0 * COUNT(shiba_2001_2200) / NULLIF(COUNT(*), 0), 2) AS shiba_2001_2200_rate,
    ROUND(100.0 * COUNT(shiba_2201_2400) / NULLIF(COUNT(*), 0), 2) AS shiba_2201_2400_rate,
    ROUND(100.0 * COUNT(shiba_2401_2800) / NULLIF(COUNT(*), 0), 2) AS shiba_2401_2800_rate,
    ROUND(100.0 * COUNT(shiba_2801_ijo) / NULLIF(COUNT(*), 0), 2) AS shiba_2801_ijo_rate,
    ROUND(100.0 * COUNT(shiba_sapporo) / NULLIF(COUNT(*), 0), 2) AS shiba_sapporo_rate,
    ROUND(100.0 * COUNT(shiba_hakodate) / NULLIF(COUNT(*), 0), 2) AS shiba_hakodate_rate,
    ROUND(100.0 * COUNT(shiba_fukushima) / NULLIF(COUNT(*), 0), 2) AS shiba_fukushima_rate,
    ROUND(100.0 * COUNT(shiba_niigata) / NULLIF(COUNT(*), 0), 2) AS shiba_niigata_rate,
    ROUND(100.0 * COUNT(shiba_tokyo) / NULLIF(COUNT(*), 0), 2) AS shiba_tokyo_rate,
    ROUND(100.0 * COUNT(shiba_nakayama) / NULLIF(COUNT(*), 0), 2) AS shiba_nakayama_rate,
    ROUND(100.0 * COUNT(shiba_chukyo) / NULLIF(COUNT(*), 0), 2) AS shiba_chukyo_rate,
    ROUND(100.0 * COUNT(shiba_kyoto) / NULLIF(COUNT(*), 0), 2) AS shiba_kyoto_rate,
    ROUND(100.0 * COUNT(shiba_hanshin) / NULLIF(COUNT(*), 0), 2) AS shiba_hanshin_rate,
    ROUND(100.0 * COUNT(shiba_kokura) / NULLIF(COUNT(*), 0), 2) AS shiba_kokura_rate,
    ROUND(100.0 * COUNT(kyakushitsu_keiko) / NULLIF(COUNT(*), 0), 2) AS kyakushitsu_keiko_rate
    
FROM jvd_um;

-- ============================================================
-- 【JRDBテーブル群】 - 全件対象（年次フィルタなし）
-- ============================================================

-- ============================================================
-- 5. jrd_kyi (132カラム) - JRDB基幹データ
-- ============================================================
SELECT 
    'jrd_kyi' AS table_name,
    COUNT(*) AS total_records,
    
    -- 基本指数（16カラム）
    ROUND(100.0 * COUNT(idm) / NULLIF(COUNT(*), 0), 2) AS idm_rate,
    ROUND(100.0 * COUNT(kishu_shisu) / NULLIF(COUNT(*), 0), 2) AS kishu_shisu_rate,
    ROUND(100.0 * COUNT(joho_shisu) / NULLIF(COUNT(*), 0), 2) AS joho_shisu_rate,
    ROUND(100.0 * COUNT(sogo_shisu) / NULLIF(COUNT(*), 0), 2) AS sogo_shisu_rate,
    ROUND(100.0 * COUNT(ninki_shisu) / NULLIF(COUNT(*), 0), 2) AS ninki_shisu_rate,
    ROUND(100.0 * COUNT(chokyo_shisu) / NULLIF(COUNT(*), 0), 2) AS chokyo_shisu_rate,
    ROUND(100.0 * COUNT(kyusha_shisu) / NULLIF(COUNT(*), 0), 2) AS kyusha_shisu_rate,
    ROUND(100.0 * COUNT(gekiso_shisu) / NULLIF(COUNT(*), 0), 2) AS gekiso_shisu_rate,
    ROUND(100.0 * COUNT(ten_shisu) / NULLIF(COUNT(*), 0), 2) AS ten_shisu_rate,
    ROUND(100.0 * COUNT(pace_shisu) / NULLIF(COUNT(*), 0), 2) AS pace_shisu_rate,
    ROUND(100.0 * COUNT(agari_shisu) / NULLIF(COUNT(*), 0), 2) AS agari_shisu_rate,
    ROUND(100.0 * COUNT(ichi_shisu) / NULLIF(COUNT(*), 0), 2) AS ichi_shisu_rate,
    
    -- 適性・評価コード（11カラム）
    ROUND(100.0 * COUNT(kyakushitsu_code) / NULLIF(COUNT(*), 0), 2) AS kyakushitsu_code_rate,
    ROUND(100.0 * COUNT(kyori_tekisei_code) / NULLIF(COUNT(*), 0), 2) AS kyori_tekisei_rate,
    ROUND(100.0 * COUNT(joshodo_code) / NULLIF(COUNT(*), 0), 2) AS joshodo_code_rate,
    ROUND(100.0 * COUNT(chokyo_yajirushi_code) / NULLIF(COUNT(*), 0), 2) AS chokyo_yajirushi_rate,
    ROUND(100.0 * COUNT(kyusha_hyoka_code) / NULLIF(COUNT(*), 0), 2) AS kyusha_hyoka_rate,
    ROUND(100.0 * COUNT(class_code) / NULLIF(COUNT(*), 0), 2) AS class_code_rate,
    ROUND(100.0 * COUNT(tekisei_code_shiba) / NULLIF(COUNT(*), 0), 2) AS tekisei_shiba_rate,
    ROUND(100.0 * COUNT(tekisei_code_dirt) / NULLIF(COUNT(*), 0), 2) AS tekisei_dirt_rate,
    
    -- 予想・展開（14カラム）
    ROUND(100.0 * COUNT(pace_yoso) / NULLIF(COUNT(*), 0), 2) AS pace_yoso_rate,
    ROUND(100.0 * COUNT(kishu_kitai_rentai_ritsu) / NULLIF(COUNT(*), 0), 2) AS kishu_kitai_rentai_rate,
    ROUND(100.0 * COUNT(rotation) / NULLIF(COUNT(*), 0), 2) AS rotation_rate,
    ROUND(100.0 * COUNT(kyusha_rank) / NULLIF(COUNT(*), 0), 2) AS kyusha_rank_rate
    
FROM jrd_kyi;

-- ============================================================
-- 6. jrd_sed (80カラム) - JRDBレース成績
-- ============================================================
SELECT 
    'jrd_sed' AS table_name,
    COUNT(*) AS total_records,
    
    -- レース結果・タイム（20カラム）
    ROUND(100.0 * COUNT(soha_time) / NULLIF(COUNT(*), 0), 2) AS soha_time_rate,
    ROUND(100.0 * COUNT(kakutei_chakujun) / NULLIF(COUNT(*), 0), 2) AS chakujun_rate,
    ROUND(100.0 * COUNT(zenhan_3f_taimu) / NULLIF(COUNT(*), 0), 2) AS zenhan_3f_rate,
    ROUND(100.0 * COUNT(kohan_3f) / NULLIF(COUNT(*), 0), 2) AS kohan_3f_rate,
    ROUND(100.0 * COUNT(corner_1) / NULLIF(COUNT(*), 0), 2) AS corner_1_rate,
    ROUND(100.0 * COUNT(corner_2) / NULLIF(COUNT(*), 0), 2) AS corner_2_rate,
    ROUND(100.0 * COUNT(corner_3) / NULLIF(COUNT(*), 0), 2) AS corner_3_rate,
    ROUND(100.0 * COUNT(corner_4) / NULLIF(COUNT(*), 0), 2) AS corner_4_rate,
    
    -- JRDB指数（10カラム）
    ROUND(100.0 * COUNT(idm) / NULLIF(COUNT(*), 0), 2) AS idm_rate,
    ROUND(100.0 * COUNT(pace) / NULLIF(COUNT(*), 0), 2) AS pace_rate,
    ROUND(100.0 * COUNT(babasa) / NULLIF(COUNT(*), 0), 2) AS babasa_rate,
    ROUND(100.0 * COUNT(deokure) / NULLIF(COUNT(*), 0), 2) AS deokure_rate,
    ROUND(100.0 * COUNT(ichidori) / NULLIF(COUNT(*), 0), 2) AS ichidori_rate,
    ROUND(100.0 * COUNT(ten_shisu) / NULLIF(COUNT(*), 0), 2) AS ten_shisu_rate,
    ROUND(100.0 * COUNT(agari_shisu) / NULLIF(COUNT(*), 0), 2) AS agari_shisu_rate,
    ROUND(100.0 * COUNT(pace_shisu) / NULLIF(COUNT(*), 0), 2) AS pace_shisu_rate
    
FROM jrd_sed;

-- ============================================================
-- 7. jrd_joa (24カラム) - JRDBオッズ・評価
-- ============================================================
SELECT 
    'jrd_joa' AS table_name,
    COUNT(*) AS total_records,
    
    -- オッズ・指数（10カラム）
    ROUND(100.0 * COUNT(kijun_odds_tansho) / NULLIF(COUNT(*), 0), 2) AS odds_tansho_rate,
    ROUND(100.0 * COUNT(kijun_odds_fukusho) / NULLIF(COUNT(*), 0), 2) AS odds_fukusho_rate,
    ROUND(100.0 * COUNT(cid) / NULLIF(COUNT(*), 0), 2) AS cid_rate,
    ROUND(100.0 * COUNT(ls_shisu) / NULLIF(COUNT(*), 0), 2) AS ls_shisu_rate,
    ROUND(100.0 * COUNT(ls_hyoka) / NULLIF(COUNT(*), 0), 2) AS ls_hyoka_rate,
    ROUND(100.0 * COUNT(em) / NULLIF(COUNT(*), 0), 2) AS em_rate,
    ROUND(100.0 * COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu) / NULLIF(COUNT(*), 0), 2) AS kyusha_bb_tansho_rate,
    ROUND(100.0 * COUNT(kishu_bb_nijumaru_tansho_kaishuritsu) / NULLIF(COUNT(*), 0), 2) AS kishu_bb_tansho_rate
    
FROM jrd_joa;

-- ============================================================
-- 8. jrd_bac (27カラム) - JRDBレース基本情報
-- ============================================================
SELECT 
    'jrd_bac' AS table_name,
    COUNT(*) AS total_records,
    
    -- レース条件（15カラム）
    ROUND(100.0 * COUNT(kyori) / NULLIF(COUNT(*), 0), 2) AS kyori_rate,
    ROUND(100.0 * COUNT(track_code) / NULLIF(COUNT(*), 0), 2) AS track_code_rate,
    ROUND(100.0 * COUNT(grade_code) / NULLIF(COUNT(*), 0), 2) AS grade_code_rate,
    ROUND(100.0 * COUNT(kyosomei) / NULLIF(COUNT(*), 0), 2) AS kyosomei_rate,
    ROUND(100.0 * COUNT(honshokin) / NULLIF(COUNT(*), 0), 2) AS honshokin_rate,
    ROUND(100.0 * COUNT(toroku_tosu) / NULLIF(COUNT(*), 0), 2) AS toroku_tosu_rate,
    ROUND(100.0 * COUNT(hasso_jikoku) / NULLIF(COUNT(*), 0), 2) AS hasso_jikoku_rate
    
FROM jrd_bac;

-- ============================================================
-- 9. jrd_cyb (27カラム) - JRDB調教情報
-- ============================================================
SELECT 
    'jrd_cyb' AS table_name,
    COUNT(*) AS total_records,
    
    -- 調教評価（10カラム）
    ROUND(100.0 * COUNT(chokyo_type) / NULLIF(COUNT(*), 0), 2) AS chokyo_type_rate,
    ROUND(100.0 * COUNT(chokyo_kyori) / NULLIF(COUNT(*), 0), 2) AS chokyo_kyori_rate,
    ROUND(100.0 * COUNT(oikiri_shisu) / NULLIF(COUNT(*), 0), 2) AS oikiri_shisu_rate,
    ROUND(100.0 * COUNT(shiage_shisu) / NULLIF(COUNT(*), 0), 2) AS shiage_shisu_rate,
    ROUND(100.0 * COUNT(chokyo_hyoka) / NULLIF(COUNT(*), 0), 2) AS chokyo_hyoka_rate,
    ROUND(100.0 * COUNT(chokyo_ryo_hyoka) / NULLIF(COUNT(*), 0), 2) AS chokyo_ryo_hyoka_rate,
    ROUND(100.0 * COUNT(chokyo_comment) / NULLIF(COUNT(*), 0), 2) AS chokyo_comment_rate
    
FROM jrd_cyb;

-- ============================================================
-- 実行手順:
-- 1. pgAdmin4で上記SQLを順番に実行
-- 2. 各結果をCSVエクスポート
-- 3. 充填率80%以上のカラムをリストアップ
-- 4. 200～220カラム選定リストを作成
-- ============================================================
