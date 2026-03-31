-- ============================================================
-- Phase 7-A 既存81カラムの充填率確認
-- 作成日: 2026-03-03
-- 目的: jravan_jrdb_merged_fixed.csv の81カラムの充填率を確認
-- ============================================================

-- 【実行方法】
-- 1. pgAdmin4 で jravan_jrdb_merged_fixed テーブルを確認
-- 2. このSQLを実行
-- 3. 結果を CSV にエクスポート: existing_81_columns_fillrate.csv

SELECT 
    COUNT(*) as total_rows,
    
    -- ===== 基本情報 (10カラム) =====
    COUNT(kaisai_nen) as filled_kaisai_nen,
    ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kaisai_nen,
    
    COUNT(kaisai_tsukihi) as filled_kaisai_tsukihi,
    ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kaisai_tsukihi,
    
    COUNT(keibajo_code) as filled_keibajo_code,
    ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_keibajo_code,
    
    COUNT(kaisai_kai) as filled_kaisai_kai,
    ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kaisai_kai,
    
    COUNT(kaisai_nichime) as filled_kaisai_nichime,
    ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kaisai_nichime,
    
    COUNT(race_bango) as filled_race_bango,
    ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate_race_bango,
    
    COUNT(umaban) as filled_umaban,
    ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate_umaban,
    
    COUNT(ketto_toroku_bango_jravan) as filled_ketto_toroku_bango_jravan,
    ROUND(COUNT(ketto_toroku_bango_jravan)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ketto_toroku_bango_jravan,
    
    COUNT(wakuban) as filled_wakuban,
    ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) as fillrate_wakuban,
    
    COUNT(seibetsu_code) as filled_seibetsu_code,
    ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_seibetsu_code,
    
    -- ===== レース条件 (9カラム) =====
    COUNT(month) as filled_month,
    ROUND(COUNT(month)::NUMERIC / COUNT(*) * 100, 2) as fillrate_month,
    
    COUNT(kyori) as filled_kyori,
    ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyori,
    
    COUNT(track_code) as filled_track_code,
    ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_track_code,
    
    COUNT(tenko_code) as filled_tenko_code,
    ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_tenko_code,
    
    COUNT(babajotai_code_shiba) as filled_babajotai_code_shiba,
    ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate_babajotai_code_shiba,
    
    COUNT(babajotai_code_dirt) as filled_babajotai_code_dirt,
    ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate_babajotai_code_dirt,
    
    COUNT(hasso_jikoku) as filled_hasso_jikoku,
    ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate_hasso_jikoku,
    
    COUNT(grade_code) as filled_grade_code,
    ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_grade_code,
    
    COUNT(keibajo_season_code) as filled_keibajo_season_code,
    ROUND(COUNT(keibajo_season_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_keibajo_season_code,
    
    COUNT(shusso_tosu) as filled_shusso_tosu,
    ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_shusso_tosu,
    
    -- ===== 馬情報 (6カラム) =====
    COUNT(barei) as filled_barei,
    ROUND(COUNT(barei)::NUMERIC / COUNT(*) * 100, 2) as fillrate_barei,
    
    COUNT(kishumei_ryakusho) as filled_kishumei_ryakusho,
    ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kishumei_ryakusho,
    
    COUNT(bataiju_jravan) as filled_bataiju_jravan,
    ROUND(COUNT(bataiju_jravan)::NUMERIC / COUNT(*) * 100, 2) as fillrate_bataiju_jravan,
    
    COUNT(zogen_sa) as filled_zogen_sa,
    ROUND(COUNT(zogen_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate_zogen_sa,
    
    COUNT(blinker_shiyo_kubun) as filled_blinker_shiyo_kubun,
    ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate_blinker_shiyo_kubun,
    
    COUNT(race_date_int) as filled_race_date_int,
    ROUND(COUNT(race_date_int)::NUMERIC / COUNT(*) * 100, 2) as fillrate_race_date_int,
    
    -- ===== ターゲット変数 (1カラム) =====
    COUNT(target_top3) as filled_target_top3,
    ROUND(COUNT(target_top3)::NUMERIC / COUNT(*) * 100, 2) as fillrate_target_top3,
    
    -- ===== 過去走データ (6カラム) =====
    COUNT(prev1_rank) as filled_prev1_rank,
    ROUND(COUNT(prev1_rank)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_rank,
    
    COUNT(prev1_time) as filled_prev1_time,
    ROUND(COUNT(prev1_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_time,
    
    COUNT(prev1_last_3f) as filled_prev1_last_3f,
    ROUND(COUNT(prev1_last_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_last_3f,
    
    COUNT(past5_rank_avg) as filled_past5_rank_avg,
    ROUND(COUNT(past5_rank_avg)::NUMERIC / COUNT(*) * 100, 2) as fillrate_past5_rank_avg,
    
    COUNT(past5_rank_best) as filled_past5_rank_best,
    ROUND(COUNT(past5_rank_best)::NUMERIC / COUNT(*) * 100, 2) as fillrate_past5_rank_best,
    
    COUNT(past5_time_avg) as filled_past5_time_avg,
    ROUND(COUNT(past5_time_avg)::NUMERIC / COUNT(*) * 100, 2) as fillrate_past5_time_avg,
    
    -- ===== JRDB 基本情報 (3カラム) =====
    COUNT(race_shikonen) as filled_race_shikonen,
    ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate_race_shikonen,
    
    COUNT(ketto_toroku_bango_jrdb) as filled_ketto_toroku_bango_jrdb,
    ROUND(COUNT(ketto_toroku_bango_jrdb)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ketto_toroku_bango_jrdb,
    
    -- ===== JRDB 指数系 (13カラム) =====
    COUNT(idm) as filled_idm,
    ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) as fillrate_idm,
    
    COUNT(kishu_shisu) as filled_kishu_shisu,
    ROUND(COUNT(kishu_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kishu_shisu,
    
    COUNT(joho_shisu) as filled_joho_shisu,
    ROUND(COUNT(joho_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_joho_shisu,
    
    COUNT(sogo_shisu) as filled_sogo_shisu,
    ROUND(COUNT(sogo_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_sogo_shisu,
    
    COUNT(chokyo_shisu) as filled_chokyo_shisu,
    ROUND(COUNT(chokyo_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_chokyo_shisu,
    
    COUNT(kyusha_shisu) as filled_kyusha_shisu,
    ROUND(COUNT(kyusha_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyusha_shisu,
    
    COUNT(gekiso_shisu) as filled_gekiso_shisu,
    ROUND(COUNT(gekiso_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_gekiso_shisu,
    
    COUNT(ninki_shisu) as filled_ninki_shisu,
    ROUND(COUNT(ninki_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ninki_shisu,
    
    COUNT(ten_shisu) as filled_ten_shisu,
    ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ten_shisu,
    
    COUNT(pace_shisu) as filled_pace_shisu,
    ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_pace_shisu,
    
    COUNT(agari_shisu) as filled_agari_shisu,
    ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_agari_shisu,
    
    COUNT(ichi_shisu) as filled_ichi_shisu,
    ROUND(COUNT(ichi_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ichi_shisu,
    
    COUNT(manken_shisu) as filled_manken_shisu,
    ROUND(COUNT(manken_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_manken_shisu,
    
    -- ===== JRDB 調教・厩舎評価 (5カラム) =====
    COUNT(chokyo_yajirushi_code) as filled_chokyo_yajirushi_code,
    ROUND(COUNT(chokyo_yajirushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_chokyo_yajirushi_code,
    
    COUNT(kyusha_hyoka_code) as filled_kyusha_hyoka_code,
    ROUND(COUNT(kyusha_hyoka_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyusha_hyoka_code,
    
    COUNT(kishu_kitai_rentai_ritsu) as filled_kishu_kitai_rentai_ritsu,
    ROUND(COUNT(kishu_kitai_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kishu_kitai_rentai_ritsu,
    
    COUNT(shiage_shisu) as filled_shiage_shisu,
    ROUND(COUNT(shiage_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_shiage_shisu,
    
    COUNT(chokyo_hyoka) as filled_chokyo_hyoka,
    ROUND(COUNT(chokyo_hyoka)::NUMERIC / COUNT(*) * 100, 2) as fillrate_chokyo_hyoka,
    
    -- ===== JRDB 適性・状態系 (6カラム) =====
    COUNT(kyakushitsu_code) as filled_kyakushitsu_code,
    ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyakushitsu_code,
    
    COUNT(kyori_tekisei_code) as filled_kyori_tekisei_code,
    ROUND(COUNT(kyori_tekisei_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyori_tekisei_code,
    
    COUNT(joshodo_code) as filled_joshodo_code,
    ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_joshodo_code,
    
    COUNT(tekisei_code_omo) as filled_tekisei_code_omo,
    ROUND(COUNT(tekisei_code_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate_tekisei_code_omo,
    
    COUNT(hizume_code) as filled_hizume_code,
    ROUND(COUNT(hizume_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_hizume_code,
    
    COUNT(class_code) as filled_class_code,
    ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_class_code,
    
    -- ===== JRDB 展開予想 (2カラム) =====
    COUNT(pace_yoso) as filled_pace_yoso,
    ROUND(COUNT(pace_yoso)::NUMERIC / COUNT(*) * 100, 2) as fillrate_pace_yoso,
    
    COUNT(uma_deokure_ritsu) as filled_uma_deokure_ritsu,
    ROUND(COUNT(uma_deokure_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_uma_deokure_ritsu,
    
    -- ===== JRDB ランク・その他 (6カラム) =====
    COUNT(rotation) as filled_rotation,
    ROUND(COUNT(rotation)::NUMERIC / COUNT(*) * 100, 2) as fillrate_rotation,
    
    COUNT(hobokusaki_rank) as filled_hobokusaki_rank,
    ROUND(COUNT(hobokusaki_rank)::NUMERIC / COUNT(*) * 100, 2) as fillrate_hobokusaki_rank,
    
    COUNT(kyusha_rank) as filled_kyusha_rank,
    ROUND(COUNT(kyusha_rank)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyusha_rank,
    
    COUNT(bataiju_jrdb) as filled_bataiju_jrdb,
    ROUND(COUNT(bataiju_jrdb)::NUMERIC / COUNT(*) * 100, 2) as fillrate_bataiju_jrdb,
    
    COUNT(bataiju_zogen) as filled_bataiju_zogen,
    ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) as fillrate_bataiju_zogen,
    
    COUNT(uma_start_shisu) as filled_uma_start_shisu,
    ROUND(COUNT(uma_start_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_uma_start_shisu,
    
    -- ===== JRDB CID・LS指数 (4カラム) =====
    COUNT(cid) as filled_cid,
    ROUND(COUNT(cid)::NUMERIC / COUNT(*) * 100, 2) as fillrate_cid,
    
    COUNT(ls_shisu) as filled_ls_shisu,
    ROUND(COUNT(ls_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ls_shisu,
    
    COUNT(ls_hyoka) as filled_ls_hyoka,
    ROUND(COUNT(ls_hyoka)::NUMERIC / COUNT(*) * 100, 2) as fillrate_ls_hyoka,
    
    COUNT(em) as filled_em,
    ROUND(COUNT(em)::NUMERIC / COUNT(*) * 100, 2) as fillrate_em,
    
    -- ===== JRDB 印・調教データB (4カラム) =====
    COUNT(kyusha_bb_shirushi) as filled_kyusha_bb_shirushi,
    ROUND(COUNT(kyusha_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyusha_bb_shirushi,
    
    COUNT(kishu_bb_shirushi) as filled_kishu_bb_shirushi,
    ROUND(COUNT(kishu_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kishu_bb_shirushi,
    
    COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu) as filled_kyusha_bb_nijumaru_tansho_kaishuritsu,
    ROUND(COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate_kyusha_bb_nijumaru_tansho_kaishuritsu,
    
    -- ===== JRDB 過去走用 (7カラム) =====
    COUNT(prev1_pace) as filled_prev1_pace,
    ROUND(COUNT(prev1_pace)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_pace,
    
    COUNT(prev1_deokure) as filled_prev1_deokure,
    ROUND(COUNT(prev1_deokure)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_deokure,
    
    COUNT(prev1_furi) as filled_prev1_furi,
    ROUND(COUNT(prev1_furi)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_furi,
    
    COUNT(prev1_furi_1) as filled_prev1_furi_1,
    ROUND(COUNT(prev1_furi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_furi_1,
    
    COUNT(prev1_furi_2) as filled_prev1_furi_2,
    ROUND(COUNT(prev1_furi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_furi_2,
    
    COUNT(prev1_furi_3) as filled_prev1_furi_3,
    ROUND(COUNT(prev1_furi_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_furi_3,
    
    COUNT(prev1_batai_code) as filled_prev1_batai_code,
    ROUND(COUNT(prev1_batai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate_prev1_batai_code

FROM jravan_jrdb_merged_fixed;

-- ============================================================
-- 【期待される出力形式】
-- ============================================================
-- total_rows: 約483,000件（2016-2025年のデータ）
-- 各カラムについて:
--   - filled_XXX: 非NULL値の件数
--   - fillrate_XXX: 充填率（%）
--
-- 【分析基準】
-- ✅ 充填率 100%: 必須カラム（キー情報、基本情報）
-- ✅ 充填率 90-99%: 高品質カラム（主要特徴量）
-- ⚠️ 充填率 50-89%: 要注意カラム（モデルによっては使用可能）
-- ❌ 充填率 <50%: 低品質カラム（使用非推奨）
--
-- 【次のステップ】
-- 1. このSQLをpgAdmin4で実行
-- 2. 結果を existing_81_columns_fillrate.csv としてエクスポート
-- 3. 全1,939カラムの充填率と比較して追加カラムを選定
-- ============================================================
