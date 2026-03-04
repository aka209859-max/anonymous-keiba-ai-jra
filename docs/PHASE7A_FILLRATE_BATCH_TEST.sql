-- ============================================================
-- Phase 7-A 充填率一括取得（テスト版）
-- 作成日: 2026-03-03
-- 対象: 主要5テーブルのみ（実行時間: 約1分）
-- ============================================================

-- このSQLは動作確認用です
-- 問題なければ PHASE7A_ALL_1939_COLUMNS_FILLRATE_BATCH.sql を実行してください

-- JRD_KYI (132カラム)
SELECT 'jrd_kyi', 'keibajo_code', COUNT(*), COUNT(keibajo_code), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'race_shikonen', COUNT(*), COUNT(race_shikonen), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kaisai_kai', COUNT(*), COUNT(kaisai_kai), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kaisai_nichime', COUNT(*), COUNT(kaisai_nichime), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'race_bango', COUNT(*), COUNT(race_bango), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'umaban', COUNT(*), COUNT(umaban), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ketto_toroku_bango', COUNT(*), COUNT(ketto_toroku_bango), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'bamei', COUNT(*), COUNT(bamei), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'idm', COUNT(*), COUNT(idm), ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_shisu', COUNT(*), COUNT(kishu_shisu), ROUND(COUNT(kishu_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'joho_shisu', COUNT(*), COUNT(joho_shisu), ROUND(COUNT(joho_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yobi_1', COUNT(*), COUNT(yobi_1), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_shisu', COUNT(*), COUNT(sogo_shisu), ROUND(COUNT(sogo_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyakushitsu_code', COUNT(*), COUNT(kyakushitsu_code), ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyori_tekisei_code', COUNT(*), COUNT(kyori_tekisei_code), ROUND(COUNT(kyori_tekisei_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'joshodo_code', COUNT(*), COUNT(joshodo_code), ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'rotation', COUNT(*), COUNT(rotation), ROUND(COUNT(rotation)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kijun_odds_tansho', COUNT(*), COUNT(kijun_odds_tansho), ROUND(COUNT(kijun_odds_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kijun_ninkijun_tansho', COUNT(*), COUNT(kijun_ninkijun_tansho), ROUND(COUNT(kijun_ninkijun_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kijun_odds_fukusho', COUNT(*), COUNT(kijun_odds_fukusho), ROUND(COUNT(kijun_odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kijun_ninkijun_fukusho', COUNT(*), COUNT(kijun_ninkijun_fukusho), ROUND(COUNT(kijun_ninkijun_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tokutei_joho_1', COUNT(*), COUNT(tokutei_joho_1), ROUND(COUNT(tokutei_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tokutei_joho_2', COUNT(*), COUNT(tokutei_joho_2), ROUND(COUNT(tokutei_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tokutei_joho_3', COUNT(*), COUNT(tokutei_joho_3), ROUND(COUNT(tokutei_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tokutei_joho_4', COUNT(*), COUNT(tokutei_joho_4), ROUND(COUNT(tokutei_joho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tokutei_joho_5', COUNT(*), COUNT(tokutei_joho_5), ROUND(COUNT(tokutei_joho_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_joho_1', COUNT(*), COUNT(sogo_joho_1), ROUND(COUNT(sogo_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_joho_2', COUNT(*), COUNT(sogo_joho_2), ROUND(COUNT(sogo_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_joho_3', COUNT(*), COUNT(sogo_joho_3), ROUND(COUNT(sogo_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_joho_4', COUNT(*), COUNT(sogo_joho_4), ROUND(COUNT(sogo_joho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sogo_joho_5', COUNT(*), COUNT(sogo_joho_5), ROUND(COUNT(sogo_joho_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ninki_shisu', COUNT(*), COUNT(ninki_shisu), ROUND(COUNT(ninki_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'chokyo_shisu', COUNT(*), COUNT(chokyo_shisu), ROUND(COUNT(chokyo_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyusha_shisu', COUNT(*), COUNT(kyusha_shisu), ROUND(COUNT(kyusha_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'chokyo_yajirushi_code', COUNT(*), COUNT(chokyo_yajirushi_code), ROUND(COUNT(chokyo_yajirushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyusha_hyoka_code', COUNT(*), COUNT(kyusha_hyoka_code), ROUND(COUNT(kyusha_hyoka_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_kitai_rentai_ritsu', COUNT(*), COUNT(kishu_kitai_rentai_ritsu), ROUND(COUNT(kishu_kitai_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'gekiso_shisu', COUNT(*), COUNT(gekiso_shisu), ROUND(COUNT(gekiso_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'hizume_code', COUNT(*), COUNT(hizume_code), ROUND(COUNT(hizume_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tekisei_code_omo', COUNT(*), COUNT(tekisei_code_omo), ROUND(COUNT(tekisei_code_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'class_code', COUNT(*), COUNT(class_code), ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yobi_2', COUNT(*), COUNT(yobi_2), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'blinker_shiyo_kubun', COUNT(*), COUNT(blinker_shiyo_kubun), ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishumei', COUNT(*), COUNT(kishumei), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'futan_juryo', COUNT(*), COUNT(futan_juryo), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_minarai_code', COUNT(*), COUNT(kishu_minarai_code), ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'chokyoshimei', COUNT(*), COUNT(chokyoshimei), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'chokyoshi_shozoku', COUNT(*), COUNT(chokyoshi_shozoku), ROUND(COUNT(chokyoshi_shozoku)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako1_kyoso_seiseki_key', COUNT(*), COUNT(kako1_kyoso_seiseki_key), ROUND(COUNT(kako1_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako2_kyoso_seiseki_key', COUNT(*), COUNT(kako2_kyoso_seiseki_key), ROUND(COUNT(kako2_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako3_kyoso_seiseki_key', COUNT(*), COUNT(kako3_kyoso_seiseki_key), ROUND(COUNT(kako3_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako4_kyoso_seiseki_key', COUNT(*), COUNT(kako4_kyoso_seiseki_key), ROUND(COUNT(kako4_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako5_kyoso_seiseki_key', COUNT(*), COUNT(kako5_kyoso_seiseki_key), ROUND(COUNT(kako5_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako1_race_key', COUNT(*), COUNT(kako1_race_key), ROUND(COUNT(kako1_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako2_race_key', COUNT(*), COUNT(kako2_race_key), ROUND(COUNT(kako2_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako3_race_key', COUNT(*), COUNT(kako3_race_key), ROUND(COUNT(kako3_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako4_race_key', COUNT(*), COUNT(kako4_race_key), ROUND(COUNT(kako4_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kako5_race_key', COUNT(*), COUNT(kako5_race_key), ROUND(COUNT(kako5_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'wakuban', COUNT(*), COUNT(wakuban), ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yobi_3', COUNT(*), COUNT(yobi_3), ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_1', COUNT(*), COUNT(shirushi_code_1), ROUND(COUNT(shirushi_code_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_2', COUNT(*), COUNT(shirushi_code_2), ROUND(COUNT(shirushi_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_3', COUNT(*), COUNT(shirushi_code_3), ROUND(COUNT(shirushi_code_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_4', COUNT(*), COUNT(shirushi_code_4), ROUND(COUNT(shirushi_code_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_5', COUNT(*), COUNT(shirushi_code_5), ROUND(COUNT(shirushi_code_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_6', COUNT(*), COUNT(shirushi_code_6), ROUND(COUNT(shirushi_code_6)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shirushi_code_7', COUNT(*), COUNT(shirushi_code_7), ROUND(COUNT(shirushi_code_7)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tekisei_code_shiba', COUNT(*), COUNT(tekisei_code_shiba), ROUND(COUNT(tekisei_code_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tekisei_code_dirt', COUNT(*), COUNT(tekisei_code_dirt), ROUND(COUNT(tekisei_code_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_code', COUNT(*), COUNT(kishu_code), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'chokyoshi_code', COUNT(*), COUNT(chokyoshi_code), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yobi_4', COUNT(*), COUNT(yobi_4), ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kakutoku_shokin_ruikei', COUNT(*), COUNT(kakutoku_shokin_ruikei), ROUND(COUNT(kakutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'shutoku_shokin_ruikei', COUNT(*), COUNT(shutoku_shokin_ruikei), ROUND(COUNT(shutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'joken_class_code', COUNT(*), COUNT(joken_class_code), ROUND(COUNT(joken_class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ten_shisu', COUNT(*), COUNT(ten_shisu), ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'pace_shisu', COUNT(*), COUNT(pace_shisu), ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'agari_shisu', COUNT(*), COUNT(agari_shisu), ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ichi_shisu', COUNT(*), COUNT(ichi_shisu), ROUND(COUNT(ichi_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'pace_yoso', COUNT(*), COUNT(pace_yoso), ROUND(COUNT(pace_yoso)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'dochu_juni', COUNT(*), COUNT(dochu_juni), ROUND(COUNT(dochu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'dochu_sa', COUNT(*), COUNT(dochu_sa), ROUND(COUNT(dochu_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'dochu_uchisoto', COUNT(*), COUNT(dochu_uchisoto), ROUND(COUNT(dochu_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kohan_3f_juni', COUNT(*), COUNT(kohan_3f_juni), ROUND(COUNT(kohan_3f_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kohan_3f_sa', COUNT(*), COUNT(kohan_3f_sa), ROUND(COUNT(kohan_3f_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kohan_3f_uchisoto', COUNT(*), COUNT(kohan_3f_uchisoto), ROUND(COUNT(kohan_3f_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'goal_juni', COUNT(*), COUNT(goal_juni), ROUND(COUNT(goal_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'goal_sa', COUNT(*), COUNT(goal_sa), ROUND(COUNT(goal_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'goal_uchisoto', COUNT(*), COUNT(goal_uchisoto), ROUND(COUNT(goal_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'tenkai_kigo_code', COUNT(*), COUNT(tenkai_kigo_code), ROUND(COUNT(tenkai_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyori_tekisei_code_2', COUNT(*), COUNT(kyori_tekisei_code_2), ROUND(COUNT(kyori_tekisei_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'bataiju', COUNT(*), COUNT(bataiju), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'bataiju_zogen', COUNT(*), COUNT(bataiju_zogen), ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'torikeshi_flag', COUNT(*), COUNT(torikeshi_flag), ROUND(COUNT(torikeshi_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'seibetsu_code', COUNT(*), COUNT(seibetsu_code), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'banushimei', COUNT(*), COUNT(banushimei), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'banushikai_code', COUNT(*), COUNT(banushikai_code), ROUND(COUNT(banushikai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'umakigo_code', COUNT(*), COUNT(umakigo_code), ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'gekiso_juni', COUNT(*), COUNT(gekiso_juni), ROUND(COUNT(gekiso_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ls_shisu_juni', COUNT(*), COUNT(ls_shisu_juni), ROUND(COUNT(ls_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ten_shisu_juni', COUNT(*), COUNT(ten_shisu_juni), ROUND(COUNT(ten_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'pace_shisu_juni', COUNT(*), COUNT(pace_shisu_juni), ROUND(COUNT(pace_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'agari_shisu_juni', COUNT(*), COUNT(agari_shisu_juni), ROUND(COUNT(agari_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'ichi_shisu_juni', COUNT(*), COUNT(ichi_shisu_juni), ROUND(COUNT(ichi_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_kitai_tansho_ritsu', COUNT(*), COUNT(kishu_kitai_tansho_ritsu), ROUND(COUNT(kishu_kitai_tansho_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kishu_kitai_sanchakunai_ritsu', COUNT(*), COUNT(kishu_kitai_sanchakunai_ritsu), ROUND(COUNT(kishu_kitai_sanchakunai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yuso_kubun', COUNT(*), COUNT(yuso_kubun), ROUND(COUNT(yuso_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'soho', COUNT(*), COUNT(soho), ROUND(COUNT(soho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'taikei', COUNT(*), COUNT(taikei), ROUND(COUNT(taikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'taikei_sogo_1', COUNT(*), COUNT(taikei_sogo_1), ROUND(COUNT(taikei_sogo_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'taikei_sogo_2', COUNT(*), COUNT(taikei_sogo_2), ROUND(COUNT(taikei_sogo_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'taikei_sogo_3', COUNT(*), COUNT(taikei_sogo_3), ROUND(COUNT(taikei_sogo_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'uma_tokki_1', COUNT(*), COUNT(uma_tokki_1), ROUND(COUNT(uma_tokki_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'uma_tokki_2', COUNT(*), COUNT(uma_tokki_2), ROUND(COUNT(uma_tokki_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'uma_tokki_3', COUNT(*), COUNT(uma_tokki_3), ROUND(COUNT(uma_tokki_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'uma_start_shisu', COUNT(*), COUNT(uma_start_shisu), ROUND(COUNT(uma_start_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'uma_deokure_ritsu', COUNT(*), COUNT(uma_deokure_ritsu), ROUND(COUNT(uma_deokure_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sanko_zenso', COUNT(*), COUNT(sanko_zenso), ROUND(COUNT(sanko_zenso)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'sanko_zenso_kishu_code', COUNT(*), COUNT(sanko_zenso_kishu_code), ROUND(COUNT(sanko_zenso_kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'manken_shisu', COUNT(*), COUNT(manken_shisu), ROUND(COUNT(manken_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'manken_shirushi', COUNT(*), COUNT(manken_shirushi), ROUND(COUNT(manken_shirushi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kokyu_flag', COUNT(*), COUNT(kokyu_flag), ROUND(COUNT(kokyu_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'gekiso_type', COUNT(*), COUNT(gekiso_type), ROUND(COUNT(gekiso_type)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyuyo_riyu_bunrui_code', COUNT(*), COUNT(kyuyo_riyu_bunrui_code), ROUND(COUNT(kyuyo_riyu_bunrui_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'flag', COUNT(*), COUNT(flag), ROUND(COUNT(flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'nyukyu_nansome', COUNT(*), COUNT(nyukyu_nansome), ROUND(COUNT(nyukyu_nansome)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'nyukyu_nengappi', COUNT(*), COUNT(nyukyu_nengappi), ROUND(COUNT(nyukyu_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'nyukyu_nannichimae', COUNT(*), COUNT(nyukyu_nannichimae), ROUND(COUNT(nyukyu_nannichimae)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'hobokusaki', COUNT(*), COUNT(hobokusaki), ROUND(COUNT(hobokusaki)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'hobokusaki_rank', COUNT(*), COUNT(hobokusaki_rank), ROUND(COUNT(hobokusaki_rank)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'kyusha_rank', COUNT(*), COUNT(kyusha_rank), ROUND(COUNT(kyusha_rank)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi', 'yobi_5', COUNT(*), COUNT(yobi_5), ROUND(COUNT(yobi_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi

UNION ALL

-- JRD_SED (80カラム)
SELECT 'jrd_sed', 'keibajo_code', COUNT(*), COUNT(keibajo_code), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race_shikonen', COUNT(*), COUNT(race_shikonen), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kaisai_kai', COUNT(*), COUNT(kaisai_kai), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kaisai_nichime', COUNT(*), COUNT(kaisai_nichime), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race_bango', COUNT(*), COUNT(race_bango), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'umaban', COUNT(*), COUNT(umaban), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'ketto_toroku_bango', COUNT(*), COUNT(ketto_toroku_bango), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kaisai_nen', COUNT(*), COUNT(kaisai_nen), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kaisai_tsukihi', COUNT(*), COUNT(kaisai_tsukihi), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'bamei', COUNT(*), COUNT(bamei), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyori', COUNT(*), COUNT(kyori), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'track_code', COUNT(*), COUNT(track_code), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'babajotai_code', COUNT(*), COUNT(babajotai_code), ROUND(COUNT(babajotai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyoso_shubetsu_code', COUNT(*), COUNT(kyoso_shubetsu_code), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyoso_joken_code', COUNT(*), COUNT(kyoso_joken_code), ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyoso_kigo_code', COUNT(*), COUNT(kyoso_kigo_code), ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'juryo_shubetsu_code', COUNT(*), COUNT(juryo_shubetsu_code), ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'grade_code', COUNT(*), COUNT(grade_code), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyosomei', COUNT(*), COUNT(kyosomei), ROUND(COUNT(kyosomei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'toroku_tosu', COUNT(*), COUNT(toroku_tosu), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyosomei_ryakusho_4', COUNT(*), COUNT(kyosomei_ryakusho_4), ROUND(COUNT(kyosomei_ryakusho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kakutei_chakujun', COUNT(*), COUNT(kakutei_chakujun), ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'ijo_kubun_code', COUNT(*), COUNT(ijo_kubun_code), ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'soha_time', COUNT(*), COUNT(soha_time), ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'futan_juryo', COUNT(*), COUNT(futan_juryo), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kishumei', COUNT(*), COUNT(kishumei), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'chokyoshimei', COUNT(*), COUNT(chokyoshimei), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'tansho_odds', COUNT(*), COUNT(tansho_odds), ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'tansho_ninkijun', COUNT(*), COUNT(tansho_ninkijun), ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'idm', COUNT(*), COUNT(idm), ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'soten', COUNT(*), COUNT(soten), ROUND(COUNT(soten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'babasa', COUNT(*), COUNT(babasa), ROUND(COUNT(babasa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'pace', COUNT(*), COUNT(pace), ROUND(COUNT(pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'deokure', COUNT(*), COUNT(deokure), ROUND(COUNT(deokure)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'ichidori', COUNT(*), COUNT(ichidori), ROUND(COUNT(ichidori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'furi', COUNT(*), COUNT(furi), ROUND(COUNT(furi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'furi_1', COUNT(*), COUNT(furi_1), ROUND(COUNT(furi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'furi_2', COUNT(*), COUNT(furi_2), ROUND(COUNT(furi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'furi_3', COUNT(*), COUNT(furi_3), ROUND(COUNT(furi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race', COUNT(*), COUNT(race), ROUND(COUNT(race)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'course_dori_code', COUNT(*), COUNT(course_dori_code), ROUND(COUNT(course_dori_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'joshodo_code', COUNT(*), COUNT(joshodo_code), ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'class_code', COUNT(*), COUNT(class_code), ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'batai_code', COUNT(*), COUNT(batai_code), ROUND(COUNT(batai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kehai_code', COUNT(*), COUNT(kehai_code), ROUND(COUNT(kehai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race_pace', COUNT(*), COUNT(race_pace), ROUND(COUNT(race_pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'uma_pace', COUNT(*), COUNT(uma_pace), ROUND(COUNT(uma_pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'ten_shisu', COUNT(*), COUNT(ten_shisu), ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'agari_shisu', COUNT(*), COUNT(agari_shisu), ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'pace_shisu', COUNT(*), COUNT(pace_shisu), ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race_p_shisu', COUNT(*), COUNT(race_p_shisu), ROUND(COUNT(race_p_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'aiteuma_joho_1', COUNT(*), COUNT(aiteuma_joho_1), ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'zenhan_3f_taimu', COUNT(*), COUNT(zenhan_3f_taimu), ROUND(COUNT(zenhan_3f_taimu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kohan_3f', COUNT(*), COUNT(kohan_3f), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'biko', COUNT(*), COUNT(biko), ROUND(COUNT(biko)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'yobi_1', COUNT(*), COUNT(yobi_1), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'odds_fukusho', COUNT(*), COUNT(odds_fukusho), ROUND(COUNT(odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'odds_tansho_10am', COUNT(*), COUNT(odds_tansho_10am), ROUND(COUNT(odds_tansho_10am)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'odds_fukusho_10am', COUNT(*), COUNT(odds_fukusho_10am), ROUND(COUNT(odds_fukusho_10am)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'corner_1', COUNT(*), COUNT(corner_1), ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'corner_2', COUNT(*), COUNT(corner_2), ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'corner_3', COUNT(*), COUNT(corner_3), ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'corner_4', COUNT(*), COUNT(corner_4), ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'zenhan_3f_sento_sa', COUNT(*), COUNT(zenhan_3f_sento_sa), ROUND(COUNT(zenhan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kohan_3f_sento_sa', COUNT(*), COUNT(kohan_3f_sento_sa), ROUND(COUNT(kohan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kishu_code', COUNT(*), COUNT(kishu_code), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'chokyoshi_code', COUNT(*), COUNT(chokyoshi_code), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'bataiju', COUNT(*), COUNT(bataiju), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'bataiju_zogen', COUNT(*), COUNT(bataiju_zogen), ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'tenko_code', COUNT(*), COUNT(tenko_code), ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'course_kubun', COUNT(*), COUNT(course_kubun), ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'kyakushitsu_code', COUNT(*), COUNT(kyakushitsu_code), ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'haraimodoshi_tansho', COUNT(*), COUNT(haraimodoshi_tansho), ROUND(COUNT(haraimodoshi_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'haraimodoshi_fukusho', COUNT(*), COUNT(haraimodoshi_fukusho), ROUND(COUNT(haraimodoshi_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'honshokin', COUNT(*), COUNT(honshokin), ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'shutoku_shokin', COUNT(*), COUNT(shutoku_shokin), ROUND(COUNT(shutoku_shokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'race_pace_nagare', COUNT(*), COUNT(race_pace_nagare), ROUND(COUNT(race_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'uma_pace_nagare', COUNT(*), COUNT(uma_pace_nagare), ROUND(COUNT(uma_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'corse_dori_code_corner_4', COUNT(*), COUNT(corse_dori_code_corner_4), ROUND(COUNT(corse_dori_code_corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL
SELECT 'jrd_sed', 'hasso_jikoku', COUNT(*), COUNT(hasso_jikoku), ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed

UNION ALL

-- JVD_CK (106カラム)
SELECT 'jvd_ck', 'record_id', COUNT(*), COUNT(record_id), ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'data_kubun', COUNT(*), COUNT(data_kubun), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'data_sakusei_nengappi', COUNT(*), COUNT(data_sakusei_nengappi), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kaisai_nen', COUNT(*), COUNT(kaisai_nen), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kaisai_tsukihi', COUNT(*), COUNT(kaisai_tsukihi), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'keibajo_code', COUNT(*), COUNT(keibajo_code), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kaisai_kai', COUNT(*), COUNT(kaisai_kai), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kaisai_nichime', COUNT(*), COUNT(kaisai_nichime), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'race_bango', COUNT(*), COUNT(race_bango), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'ketto_toroku_bango', COUNT(*), COUNT(ketto_toroku_bango), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'bamei', COUNT(*), COUNT(bamei), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'heichi_honshokin_ruikei', COUNT(*), COUNT(heichi_honshokin_ruikei), ROUND(COUNT(heichi_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_honshokin_ruikei', COUNT(*), COUNT(shogai_honshokin_ruikei), ROUND(COUNT(shogai_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'heichi_fukashokin_ruikei', COUNT(*), COUNT(heichi_fukashokin_ruikei), ROUND(COUNT(heichi_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_fukashokin_ruikei', COUNT(*), COUNT(shogai_fukashokin_ruikei), ROUND(COUNT(shogai_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'heichi_shutokushokin_ruikei', COUNT(*), COUNT(heichi_shutokushokin_ruikei), ROUND(COUNT(heichi_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_shutokushokin_ruikei', COUNT(*), COUNT(shogai_shutokushokin_ruikei), ROUND(COUNT(shogai_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'sogo', COUNT(*), COUNT(sogo), ROUND(COUNT(sogo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'chuo_gokei', COUNT(*), COUNT(chuo_gokei), ROUND(COUNT(chuo_gokei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_choku', COUNT(*), COUNT(shiba_choku), ROUND(COUNT(shiba_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_migi', COUNT(*), COUNT(shiba_migi), ROUND(COUNT(shiba_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_hidari', COUNT(*), COUNT(shiba_hidari), ROUND(COUNT(shiba_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_choku', COUNT(*), COUNT(dirt_choku), ROUND(COUNT(dirt_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_migi', COUNT(*), COUNT(dirt_migi), ROUND(COUNT(dirt_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_hidari', COUNT(*), COUNT(dirt_hidari), ROUND(COUNT(dirt_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai', COUNT(*), COUNT(shogai), ROUND(COUNT(shogai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_ryo', COUNT(*), COUNT(shiba_ryo), ROUND(COUNT(shiba_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_yayaomo', COUNT(*), COUNT(shiba_yayaomo), ROUND(COUNT(shiba_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_omo', COUNT(*), COUNT(shiba_omo), ROUND(COUNT(shiba_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_furyo', COUNT(*), COUNT(shiba_furyo), ROUND(COUNT(shiba_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_ryo', COUNT(*), COUNT(dirt_ryo), ROUND(COUNT(dirt_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_yayaomo', COUNT(*), COUNT(dirt_yayaomo), ROUND(COUNT(dirt_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_omo', COUNT(*), COUNT(dirt_omo), ROUND(COUNT(dirt_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_furyo', COUNT(*), COUNT(dirt_furyo), ROUND(COUNT(dirt_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_ryo', COUNT(*), COUNT(shogai_ryo), ROUND(COUNT(shogai_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_yayaomo', COUNT(*), COUNT(shogai_yayaomo), ROUND(COUNT(shogai_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_omo', COUNT(*), COUNT(shogai_omo), ROUND(COUNT(shogai_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_furyo', COUNT(*), COUNT(shogai_furyo), ROUND(COUNT(shogai_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_1200_ika', COUNT(*), COUNT(shiba_1200_ika), ROUND(COUNT(shiba_1200_ika)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_1201_1400', COUNT(*), COUNT(shiba_1201_1400), ROUND(COUNT(shiba_1201_1400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_1401_1600', COUNT(*), COUNT(shiba_1401_1600), ROUND(COUNT(shiba_1401_1600)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_1601_1800', COUNT(*), COUNT(shiba_1601_1800), ROUND(COUNT(shiba_1601_1800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_1801_2000', COUNT(*), COUNT(shiba_1801_2000), ROUND(COUNT(shiba_1801_2000)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_2001_2200', COUNT(*), COUNT(shiba_2001_2200), ROUND(COUNT(shiba_2001_2200)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_2201_2400', COUNT(*), COUNT(shiba_2201_2400), ROUND(COUNT(shiba_2201_2400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_2401_2800', COUNT(*), COUNT(shiba_2401_2800), ROUND(COUNT(shiba_2401_2800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_2801_ijo', COUNT(*), COUNT(shiba_2801_ijo), ROUND(COUNT(shiba_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_1200_ika', COUNT(*), COUNT(dirt_1200_ika), ROUND(COUNT(dirt_1200_ika)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_1201_1400', COUNT(*), COUNT(dirt_1201_1400), ROUND(COUNT(dirt_1201_1400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_1401_1600', COUNT(*), COUNT(dirt_1401_1600), ROUND(COUNT(dirt_1401_1600)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_1601_1800', COUNT(*), COUNT(dirt_1601_1800), ROUND(COUNT(dirt_1601_1800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_1801_2000', COUNT(*), COUNT(dirt_1801_2000), ROUND(COUNT(dirt_1801_2000)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_2001_2200', COUNT(*), COUNT(dirt_2001_2200), ROUND(COUNT(dirt_2001_2200)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_2201_2400', COUNT(*), COUNT(dirt_2201_2400), ROUND(COUNT(dirt_2201_2400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_2401_2800', COUNT(*), COUNT(dirt_2401_2800), ROUND(COUNT(dirt_2401_2800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_2801_ijo', COUNT(*), COUNT(dirt_2801_ijo), ROUND(COUNT(dirt_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_sapporo', COUNT(*), COUNT(shiba_sapporo), ROUND(COUNT(shiba_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_hakodate', COUNT(*), COUNT(shiba_hakodate), ROUND(COUNT(shiba_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_fukushima', COUNT(*), COUNT(shiba_fukushima), ROUND(COUNT(shiba_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_niigata', COUNT(*), COUNT(shiba_niigata), ROUND(COUNT(shiba_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_tokyo', COUNT(*), COUNT(shiba_tokyo), ROUND(COUNT(shiba_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_nakayama', COUNT(*), COUNT(shiba_nakayama), ROUND(COUNT(shiba_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_chukyo', COUNT(*), COUNT(shiba_chukyo), ROUND(COUNT(shiba_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_kyoto', COUNT(*), COUNT(shiba_kyoto), ROUND(COUNT(shiba_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_hanshin', COUNT(*), COUNT(shiba_hanshin), ROUND(COUNT(shiba_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shiba_kokura', COUNT(*), COUNT(shiba_kokura), ROUND(COUNT(shiba_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_sapporo', COUNT(*), COUNT(dirt_sapporo), ROUND(COUNT(dirt_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_hakodate', COUNT(*), COUNT(dirt_hakodate), ROUND(COUNT(dirt_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_fukushima', COUNT(*), COUNT(dirt_fukushima), ROUND(COUNT(dirt_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_niigata', COUNT(*), COUNT(dirt_niigata), ROUND(COUNT(dirt_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_tokyo', COUNT(*), COUNT(dirt_tokyo), ROUND(COUNT(dirt_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_nakayama', COUNT(*), COUNT(dirt_nakayama), ROUND(COUNT(dirt_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_chukyo', COUNT(*), COUNT(dirt_chukyo), ROUND(COUNT(dirt_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_kyoto', COUNT(*), COUNT(dirt_kyoto), ROUND(COUNT(dirt_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_hanshin', COUNT(*), COUNT(dirt_hanshin), ROUND(COUNT(dirt_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'dirt_kokura', COUNT(*), COUNT(dirt_kokura), ROUND(COUNT(dirt_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_sapporo', COUNT(*), COUNT(shogai_sapporo), ROUND(COUNT(shogai_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_hakodate', COUNT(*), COUNT(shogai_hakodate), ROUND(COUNT(shogai_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_fukushima', COUNT(*), COUNT(shogai_fukushima), ROUND(COUNT(shogai_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_niigata', COUNT(*), COUNT(shogai_niigata), ROUND(COUNT(shogai_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_tokyo', COUNT(*), COUNT(shogai_tokyo), ROUND(COUNT(shogai_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_nakayama', COUNT(*), COUNT(shogai_nakayama), ROUND(COUNT(shogai_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_chukyo', COUNT(*), COUNT(shogai_chukyo), ROUND(COUNT(shogai_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_kyoto', COUNT(*), COUNT(shogai_kyoto), ROUND(COUNT(shogai_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_hanshin', COUNT(*), COUNT(shogai_hanshin), ROUND(COUNT(shogai_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'shogai_kokura', COUNT(*), COUNT(shogai_kokura), ROUND(COUNT(shogai_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kyakushitsu_keiko', COUNT(*), COUNT(kyakushitsu_keiko), ROUND(COUNT(kyakushitsu_keiko)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'toroku_race_su', COUNT(*), COUNT(toroku_race_su), ROUND(COUNT(toroku_race_su)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kishu_code', COUNT(*), COUNT(kishu_code), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'kishumei', COUNT(*), COUNT(kishumei), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_kishu_1', COUNT(*), COUNT(seiseki_joho_kishu_1), ROUND(COUNT(seiseki_joho_kishu_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_kishu_2', COUNT(*), COUNT(seiseki_joho_kishu_2), ROUND(COUNT(seiseki_joho_kishu_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'chokyoshi_code', COUNT(*), COUNT(chokyoshi_code), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'chokyoshimei', COUNT(*), COUNT(chokyoshimei), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_chokyoshi_1', COUNT(*), COUNT(seiseki_joho_chokyoshi_1), ROUND(COUNT(seiseki_joho_chokyoshi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_chokyoshi_2', COUNT(*), COUNT(seiseki_joho_chokyoshi_2), ROUND(COUNT(seiseki_joho_chokyoshi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'banushi_code', COUNT(*), COUNT(banushi_code), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'banushimei_hojinkaku', COUNT(*), COUNT(banushimei_hojinkaku), ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'banushimei', COUNT(*), COUNT(banushimei), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_banushi_1', COUNT(*), COUNT(seiseki_joho_banushi_1), ROUND(COUNT(seiseki_joho_banushi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_banushi_2', COUNT(*), COUNT(seiseki_joho_banushi_2), ROUND(COUNT(seiseki_joho_banushi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seisansha_code', COUNT(*), COUNT(seisansha_code), ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seisanshamei_hojinkaku', COUNT(*), COUNT(seisanshamei_hojinkaku), ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seisanshamei', COUNT(*), COUNT(seisanshamei), ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_seisansha_1', COUNT(*), COUNT(seiseki_joho_seisansha_1), ROUND(COUNT(seiseki_joho_seisansha_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck', 'seiseki_joho_seisansha_2', COUNT(*), COUNT(seiseki_joho_seisansha_2), ROUND(COUNT(seiseki_joho_seisansha_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

-- JVD_RA (62カラム)
SELECT 'jvd_ra', 'record_id', COUNT(*), COUNT(record_id), ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'data_kubun', COUNT(*), COUNT(data_kubun), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'data_sakusei_nengappi', COUNT(*), COUNT(data_sakusei_nengappi), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kaisai_nen', COUNT(*), COUNT(kaisai_nen), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kaisai_tsukihi', COUNT(*), COUNT(kaisai_tsukihi), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'keibajo_code', COUNT(*), COUNT(keibajo_code), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kaisai_kai', COUNT(*), COUNT(kaisai_kai), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kaisai_nichime', COUNT(*), COUNT(kaisai_nichime), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'race_bango', COUNT(*), COUNT(race_bango), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'yobi_code', COUNT(*), COUNT(yobi_code), ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'tokubetsu_kyoso_bango', COUNT(*), COUNT(tokubetsu_kyoso_bango), ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_hondai', COUNT(*), COUNT(kyosomei_hondai), ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_fukudai', COUNT(*), COUNT(kyosomei_fukudai), ROUND(COUNT(kyosomei_fukudai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_kakkonai', COUNT(*), COUNT(kyosomei_kakkonai), ROUND(COUNT(kyosomei_kakkonai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_hondai_eur', COUNT(*), COUNT(kyosomei_hondai_eur), ROUND(COUNT(kyosomei_hondai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_fukudai_eur', COUNT(*), COUNT(kyosomei_fukudai_eur), ROUND(COUNT(kyosomei_fukudai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_kakkonai_eur', COUNT(*), COUNT(kyosomei_kakkonai_eur), ROUND(COUNT(kyosomei_kakkonai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_ryakusho_10', COUNT(*), COUNT(kyosomei_ryakusho_10), ROUND(COUNT(kyosomei_ryakusho_10)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_ryakusho_6', COUNT(*), COUNT(kyosomei_ryakusho_6), ROUND(COUNT(kyosomei_ryakusho_6)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_ryakusho_3', COUNT(*), COUNT(kyosomei_ryakusho_3), ROUND(COUNT(kyosomei_ryakusho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyosomei_kubun', COUNT(*), COUNT(kyosomei_kubun), ROUND(COUNT(kyosomei_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'jusho_kaiji', COUNT(*), COUNT(jusho_kaiji), ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'grade_code', COUNT(*), COUNT(grade_code), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'grade_code_henkomae', COUNT(*), COUNT(grade_code_henkomae), ROUND(COUNT(grade_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_shubetsu_code', COUNT(*), COUNT(kyoso_shubetsu_code), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_kigo_code', COUNT(*), COUNT(kyoso_kigo_code), ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'juryo_shubetsu_code', COUNT(*), COUNT(juryo_shubetsu_code), ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_code_2sai', COUNT(*), COUNT(kyoso_joken_code_2sai), ROUND(COUNT(kyoso_joken_code_2sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_code_3sai', COUNT(*), COUNT(kyoso_joken_code_3sai), ROUND(COUNT(kyoso_joken_code_3sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_code_4sai', COUNT(*), COUNT(kyoso_joken_code_4sai), ROUND(COUNT(kyoso_joken_code_4sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_code_5sai_ijo', COUNT(*), COUNT(kyoso_joken_code_5sai_ijo), ROUND(COUNT(kyoso_joken_code_5sai_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_code', COUNT(*), COUNT(kyoso_joken_code), ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyoso_joken_meisho', COUNT(*), COUNT(kyoso_joken_meisho), ROUND(COUNT(kyoso_joken_meisho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyori', COUNT(*), COUNT(kyori), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kyori_henkomae', COUNT(*), COUNT(kyori_henkomae), ROUND(COUNT(kyori_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'track_code', COUNT(*), COUNT(track_code), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'track_code_henkomae', COUNT(*), COUNT(track_code_henkomae), ROUND(COUNT(track_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'course_kubun', COUNT(*), COUNT(course_kubun), ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'course_kubun_henkomae', COUNT(*), COUNT(course_kubun_henkomae), ROUND(COUNT(course_kubun_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'honshokin', COUNT(*), COUNT(honshokin), ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'honshokin_henkomae', COUNT(*), COUNT(honshokin_henkomae), ROUND(COUNT(honshokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'fukashokin', COUNT(*), COUNT(fukashokin), ROUND(COUNT(fukashokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'fukashokin_henkomae', COUNT(*), COUNT(fukashokin_henkomae), ROUND(COUNT(fukashokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'hasso_jikoku', COUNT(*), COUNT(hasso_jikoku), ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'hasso_jikoku_henkomae', COUNT(*), COUNT(hasso_jikoku_henkomae), ROUND(COUNT(hasso_jikoku_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'toroku_tosu', COUNT(*), COUNT(toroku_tosu), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'shusso_tosu', COUNT(*), COUNT(shusso_tosu), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'nyusen_tosu', COUNT(*), COUNT(nyusen_tosu), ROUND(COUNT(nyusen_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'tenko_code', COUNT(*), COUNT(tenko_code), ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'babajotai_code_shiba', COUNT(*), COUNT(babajotai_code_shiba), ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'babajotai_code_dirt', COUNT(*), COUNT(babajotai_code_dirt), ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'lap_time', COUNT(*), COUNT(lap_time), ROUND(COUNT(lap_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'shogai_mile_time', COUNT(*), COUNT(shogai_mile_time), ROUND(COUNT(shogai_mile_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'zenhan_3f', COUNT(*), COUNT(zenhan_3f), ROUND(COUNT(zenhan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'zenhan_4f', COUNT(*), COUNT(zenhan_4f), ROUND(COUNT(zenhan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kohan_3f', COUNT(*), COUNT(kohan_3f), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'kohan_4f', COUNT(*), COUNT(kohan_4f), ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'corner_tsuka_juni_1', COUNT(*), COUNT(corner_tsuka_juni_1), ROUND(COUNT(corner_tsuka_juni_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'corner_tsuka_juni_2', COUNT(*), COUNT(corner_tsuka_juni_2), ROUND(COUNT(corner_tsuka_juni_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'corner_tsuka_juni_3', COUNT(*), COUNT(corner_tsuka_juni_3), ROUND(COUNT(corner_tsuka_juni_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'corner_tsuka_juni_4', COUNT(*), COUNT(corner_tsuka_juni_4), ROUND(COUNT(corner_tsuka_juni_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra', 'record_koshin_kubun', COUNT(*), COUNT(record_koshin_kubun), ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

-- JVD_SE (70カラム)
SELECT 'jvd_se', 'record_id', COUNT(*), COUNT(record_id), ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'data_kubun', COUNT(*), COUNT(data_kubun), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'data_sakusei_nengappi', COUNT(*), COUNT(data_sakusei_nengappi), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kaisai_nen', COUNT(*), COUNT(kaisai_nen), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kaisai_tsukihi', COUNT(*), COUNT(kaisai_tsukihi), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'keibajo_code', COUNT(*), COUNT(keibajo_code), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kaisai_kai', COUNT(*), COUNT(kaisai_kai), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kaisai_nichime', COUNT(*), COUNT(kaisai_nichime), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'race_bango', COUNT(*), COUNT(race_bango), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'wakuban', COUNT(*), COUNT(wakuban), ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'umaban', COUNT(*), COUNT(umaban), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'ketto_toroku_bango', COUNT(*), COUNT(ketto_toroku_bango), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'bamei', COUNT(*), COUNT(bamei), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'umakigo_code', COUNT(*), COUNT(umakigo_code), ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'seibetsu_code', COUNT(*), COUNT(seibetsu_code), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'hinshu_code', COUNT(*), COUNT(hinshu_code), ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'moshoku_code', COUNT(*), COUNT(moshoku_code), ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'barei', COUNT(*), COUNT(barei), ROUND(COUNT(barei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'tozai_shozoku_code', COUNT(*), COUNT(tozai_shozoku_code), ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'chokyoshi_code', COUNT(*), COUNT(chokyoshi_code), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'chokyoshimei_ryakusho', COUNT(*), COUNT(chokyoshimei_ryakusho), ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'banushi_code', COUNT(*), COUNT(banushi_code), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'banushimei', COUNT(*), COUNT(banushimei), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'fukushoku_hyoji', COUNT(*), COUNT(fukushoku_hyoji), ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yobi_1', COUNT(*), COUNT(yobi_1), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'futan_juryo', COUNT(*), COUNT(futan_juryo), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'futan_juryo_henkomae', COUNT(*), COUNT(futan_juryo_henkomae), ROUND(COUNT(futan_juryo_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'blinker_shiyo_kubun', COUNT(*), COUNT(blinker_shiyo_kubun), ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yobi_2', COUNT(*), COUNT(yobi_2), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishu_code', COUNT(*), COUNT(kishu_code), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishu_code_henkomae', COUNT(*), COUNT(kishu_code_henkomae), ROUND(COUNT(kishu_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishumei_ryakusho', COUNT(*), COUNT(kishumei_ryakusho), ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishumei_ryakusho_henkomae', COUNT(*), COUNT(kishumei_ryakusho_henkomae), ROUND(COUNT(kishumei_ryakusho_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishu_minarai_code', COUNT(*), COUNT(kishu_minarai_code), ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kishu_minarai_code_henkomae', COUNT(*), COUNT(kishu_minarai_code_henkomae), ROUND(COUNT(kishu_minarai_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'bataiju', COUNT(*), COUNT(bataiju), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'zogen_fugo', COUNT(*), COUNT(zogen_fugo), ROUND(COUNT(zogen_fugo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'zogen_sa', COUNT(*), COUNT(zogen_sa), ROUND(COUNT(zogen_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'ijo_kubun_code', COUNT(*), COUNT(ijo_kubun_code), ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'nyusen_juni', COUNT(*), COUNT(nyusen_juni), ROUND(COUNT(nyusen_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kakutei_chakujun', COUNT(*), COUNT(kakutei_chakujun), ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'dochaku_kubun', COUNT(*), COUNT(dochaku_kubun), ROUND(COUNT(dochaku_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'dochaku_tosu', COUNT(*), COUNT(dochaku_tosu), ROUND(COUNT(dochaku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'soha_time', COUNT(*), COUNT(soha_time), ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'chakusa_code_1', COUNT(*), COUNT(chakusa_code_1), ROUND(COUNT(chakusa_code_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'chakusa_code_2', COUNT(*), COUNT(chakusa_code_2), ROUND(COUNT(chakusa_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'chakusa_code_3', COUNT(*), COUNT(chakusa_code_3), ROUND(COUNT(chakusa_code_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'corner_1', COUNT(*), COUNT(corner_1), ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'corner_2', COUNT(*), COUNT(corner_2), ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'corner_3', COUNT(*), COUNT(corner_3), ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'corner_4', COUNT(*), COUNT(corner_4), ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'tansho_odds', COUNT(*), COUNT(tansho_odds), ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'tansho_ninkijun', COUNT(*), COUNT(tansho_ninkijun), ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kakutoku_honshokin', COUNT(*), COUNT(kakutoku_honshokin), ROUND(COUNT(kakutoku_honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kakutoku_fukashokin', COUNT(*), COUNT(kakutoku_fukashokin), ROUND(COUNT(kakutoku_fukashokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yobi_3', COUNT(*), COUNT(yobi_3), ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yobi_4', COUNT(*), COUNT(yobi_4), ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kohan_4f', COUNT(*), COUNT(kohan_4f), ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kohan_3f', COUNT(*), COUNT(kohan_3f), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'aiteuma_joho_1', COUNT(*), COUNT(aiteuma_joho_1), ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'aiteuma_joho_2', COUNT(*), COUNT(aiteuma_joho_2), ROUND(COUNT(aiteuma_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'aiteuma_joho_3', COUNT(*), COUNT(aiteuma_joho_3), ROUND(COUNT(aiteuma_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'time_sa', COUNT(*), COUNT(time_sa), ROUND(COUNT(time_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'record_koshin_kubun', COUNT(*), COUNT(record_koshin_kubun), ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'mining_kubun', COUNT(*), COUNT(mining_kubun), ROUND(COUNT(mining_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yoso_soha_time', COUNT(*), COUNT(yoso_soha_time), ROUND(COUNT(yoso_soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yoso_gosa_plus', COUNT(*), COUNT(yoso_gosa_plus), ROUND(COUNT(yoso_gosa_plus)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yoso_gosa_minus', COUNT(*), COUNT(yoso_gosa_minus), ROUND(COUNT(yoso_gosa_minus)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'yoso_juni', COUNT(*), COUNT(yoso_juni), ROUND(COUNT(yoso_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se', 'kyakushitsu_hantei', COUNT(*), COUNT(kyakushitsu_hantei), ROUND(COUNT(kyakushitsu_hantei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'

ORDER BY 1, 2;
