-- ============================================================
-- Phase 7-A 充填率一括取得（テスト版・修正版）
-- 作成日: 2026-03-03
-- 対象: 主要5テーブル（実行時間: 約1分）
-- ============================================================

SELECT 'jrd_kyi' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'race_shikonen' as column_name, COUNT(*) as total_rows, COUNT(race_shikonen) as filled_count, ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'idm' as column_name, COUNT(*) as total_rows, COUNT(idm) as filled_count, ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_shisu' as column_name, COUNT(*) as total_rows, COUNT(kishu_shisu) as filled_count, ROUND(COUNT(kishu_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'joho_shisu' as column_name, COUNT(*) as total_rows, COUNT(joho_shisu) as filled_count, ROUND(COUNT(joho_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_shisu' as column_name, COUNT(*) as total_rows, COUNT(sogo_shisu) as filled_count, ROUND(COUNT(sogo_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyakushitsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyakushitsu_code) as filled_count, ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyori_tekisei_code' as column_name, COUNT(*) as total_rows, COUNT(kyori_tekisei_code) as filled_count, ROUND(COUNT(kyori_tekisei_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'joshodo_code' as column_name, COUNT(*) as total_rows, COUNT(joshodo_code) as filled_count, ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'rotation' as column_name, COUNT(*) as total_rows, COUNT(rotation) as filled_count, ROUND(COUNT(rotation)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kijun_odds_tansho' as column_name, COUNT(*) as total_rows, COUNT(kijun_odds_tansho) as filled_count, ROUND(COUNT(kijun_odds_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kijun_ninkijun_tansho' as column_name, COUNT(*) as total_rows, COUNT(kijun_ninkijun_tansho) as filled_count, ROUND(COUNT(kijun_ninkijun_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kijun_odds_fukusho' as column_name, COUNT(*) as total_rows, COUNT(kijun_odds_fukusho) as filled_count, ROUND(COUNT(kijun_odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kijun_ninkijun_fukusho' as column_name, COUNT(*) as total_rows, COUNT(kijun_ninkijun_fukusho) as filled_count, ROUND(COUNT(kijun_ninkijun_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tokutei_joho_1' as column_name, COUNT(*) as total_rows, COUNT(tokutei_joho_1) as filled_count, ROUND(COUNT(tokutei_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tokutei_joho_2' as column_name, COUNT(*) as total_rows, COUNT(tokutei_joho_2) as filled_count, ROUND(COUNT(tokutei_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tokutei_joho_3' as column_name, COUNT(*) as total_rows, COUNT(tokutei_joho_3) as filled_count, ROUND(COUNT(tokutei_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tokutei_joho_4' as column_name, COUNT(*) as total_rows, COUNT(tokutei_joho_4) as filled_count, ROUND(COUNT(tokutei_joho_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tokutei_joho_5' as column_name, COUNT(*) as total_rows, COUNT(tokutei_joho_5) as filled_count, ROUND(COUNT(tokutei_joho_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_joho_1' as column_name, COUNT(*) as total_rows, COUNT(sogo_joho_1) as filled_count, ROUND(COUNT(sogo_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_joho_2' as column_name, COUNT(*) as total_rows, COUNT(sogo_joho_2) as filled_count, ROUND(COUNT(sogo_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_joho_3' as column_name, COUNT(*) as total_rows, COUNT(sogo_joho_3) as filled_count, ROUND(COUNT(sogo_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_joho_4' as column_name, COUNT(*) as total_rows, COUNT(sogo_joho_4) as filled_count, ROUND(COUNT(sogo_joho_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sogo_joho_5' as column_name, COUNT(*) as total_rows, COUNT(sogo_joho_5) as filled_count, ROUND(COUNT(sogo_joho_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ninki_shisu' as column_name, COUNT(*) as total_rows, COUNT(ninki_shisu) as filled_count, ROUND(COUNT(ninki_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'chokyo_shisu' as column_name, COUNT(*) as total_rows, COUNT(chokyo_shisu) as filled_count, ROUND(COUNT(chokyo_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyusha_shisu' as column_name, COUNT(*) as total_rows, COUNT(kyusha_shisu) as filled_count, ROUND(COUNT(kyusha_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'chokyo_yajirushi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyo_yajirushi_code) as filled_count, ROUND(COUNT(chokyo_yajirushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyusha_hyoka_code' as column_name, COUNT(*) as total_rows, COUNT(kyusha_hyoka_code) as filled_count, ROUND(COUNT(kyusha_hyoka_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_kitai_rentai_ritsu' as column_name, COUNT(*) as total_rows, COUNT(kishu_kitai_rentai_ritsu) as filled_count, ROUND(COUNT(kishu_kitai_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'gekiso_shisu' as column_name, COUNT(*) as total_rows, COUNT(gekiso_shisu) as filled_count, ROUND(COUNT(gekiso_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'hizume_code' as column_name, COUNT(*) as total_rows, COUNT(hizume_code) as filled_count, ROUND(COUNT(hizume_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tekisei_code_omo' as column_name, COUNT(*) as total_rows, COUNT(tekisei_code_omo) as filled_count, ROUND(COUNT(tekisei_code_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'class_code' as column_name, COUNT(*) as total_rows, COUNT(class_code) as filled_count, ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yobi_2' as column_name, COUNT(*) as total_rows, COUNT(yobi_2) as filled_count, ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'blinker_shiyo_kubun' as column_name, COUNT(*) as total_rows, COUNT(blinker_shiyo_kubun) as filled_count, ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishumei' as column_name, COUNT(*) as total_rows, COUNT(kishumei) as filled_count, ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'futan_juryo' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo) as filled_count, ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_minarai_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code) as filled_count, ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'chokyoshimei' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei) as filled_count, ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'chokyoshi_shozoku' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_shozoku) as filled_count, ROUND(COUNT(chokyoshi_shozoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako1_kyoso_seiseki_key' as column_name, COUNT(*) as total_rows, COUNT(kako1_kyoso_seiseki_key) as filled_count, ROUND(COUNT(kako1_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako2_kyoso_seiseki_key' as column_name, COUNT(*) as total_rows, COUNT(kako2_kyoso_seiseki_key) as filled_count, ROUND(COUNT(kako2_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako3_kyoso_seiseki_key' as column_name, COUNT(*) as total_rows, COUNT(kako3_kyoso_seiseki_key) as filled_count, ROUND(COUNT(kako3_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako4_kyoso_seiseki_key' as column_name, COUNT(*) as total_rows, COUNT(kako4_kyoso_seiseki_key) as filled_count, ROUND(COUNT(kako4_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako5_kyoso_seiseki_key' as column_name, COUNT(*) as total_rows, COUNT(kako5_kyoso_seiseki_key) as filled_count, ROUND(COUNT(kako5_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako1_race_key' as column_name, COUNT(*) as total_rows, COUNT(kako1_race_key) as filled_count, ROUND(COUNT(kako1_race_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako2_race_key' as column_name, COUNT(*) as total_rows, COUNT(kako2_race_key) as filled_count, ROUND(COUNT(kako2_race_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako3_race_key' as column_name, COUNT(*) as total_rows, COUNT(kako3_race_key) as filled_count, ROUND(COUNT(kako3_race_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako4_race_key' as column_name, COUNT(*) as total_rows, COUNT(kako4_race_key) as filled_count, ROUND(COUNT(kako4_race_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kako5_race_key' as column_name, COUNT(*) as total_rows, COUNT(kako5_race_key) as filled_count, ROUND(COUNT(kako5_race_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'wakuban' as column_name, COUNT(*) as total_rows, COUNT(wakuban) as filled_count, ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yobi_3' as column_name, COUNT(*) as total_rows, COUNT(yobi_3) as filled_count, ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_1' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_1) as filled_count, ROUND(COUNT(shirushi_code_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_2' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_2) as filled_count, ROUND(COUNT(shirushi_code_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_3' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_3) as filled_count, ROUND(COUNT(shirushi_code_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_4' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_4) as filled_count, ROUND(COUNT(shirushi_code_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_5' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_5) as filled_count, ROUND(COUNT(shirushi_code_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_6' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_6) as filled_count, ROUND(COUNT(shirushi_code_6)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shirushi_code_7' as column_name, COUNT(*) as total_rows, COUNT(shirushi_code_7) as filled_count, ROUND(COUNT(shirushi_code_7)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tekisei_code_shiba' as column_name, COUNT(*) as total_rows, COUNT(tekisei_code_shiba) as filled_count, ROUND(COUNT(tekisei_code_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tekisei_code_dirt' as column_name, COUNT(*) as total_rows, COUNT(tekisei_code_dirt) as filled_count, ROUND(COUNT(tekisei_code_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yobi_4' as column_name, COUNT(*) as total_rows, COUNT(yobi_4) as filled_count, ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kakutoku_shokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(kakutoku_shokin_ruikei) as filled_count, ROUND(COUNT(kakutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'shutoku_shokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shutoku_shokin_ruikei) as filled_count, ROUND(COUNT(shutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'joken_class_code' as column_name, COUNT(*) as total_rows, COUNT(joken_class_code) as filled_count, ROUND(COUNT(joken_class_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ten_shisu' as column_name, COUNT(*) as total_rows, COUNT(ten_shisu) as filled_count, ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'pace_shisu' as column_name, COUNT(*) as total_rows, COUNT(pace_shisu) as filled_count, ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'agari_shisu' as column_name, COUNT(*) as total_rows, COUNT(agari_shisu) as filled_count, ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ichi_shisu' as column_name, COUNT(*) as total_rows, COUNT(ichi_shisu) as filled_count, ROUND(COUNT(ichi_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'pace_yoso' as column_name, COUNT(*) as total_rows, COUNT(pace_yoso) as filled_count, ROUND(COUNT(pace_yoso)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'dochu_juni' as column_name, COUNT(*) as total_rows, COUNT(dochu_juni) as filled_count, ROUND(COUNT(dochu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'dochu_sa' as column_name, COUNT(*) as total_rows, COUNT(dochu_sa) as filled_count, ROUND(COUNT(dochu_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'dochu_uchisoto' as column_name, COUNT(*) as total_rows, COUNT(dochu_uchisoto) as filled_count, ROUND(COUNT(dochu_uchisoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kohan_3f_juni' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f_juni) as filled_count, ROUND(COUNT(kohan_3f_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kohan_3f_sa' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f_sa) as filled_count, ROUND(COUNT(kohan_3f_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kohan_3f_uchisoto' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f_uchisoto) as filled_count, ROUND(COUNT(kohan_3f_uchisoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'goal_juni' as column_name, COUNT(*) as total_rows, COUNT(goal_juni) as filled_count, ROUND(COUNT(goal_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'goal_sa' as column_name, COUNT(*) as total_rows, COUNT(goal_sa) as filled_count, ROUND(COUNT(goal_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'goal_uchisoto' as column_name, COUNT(*) as total_rows, COUNT(goal_uchisoto) as filled_count, ROUND(COUNT(goal_uchisoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'tenkai_kigo_code' as column_name, COUNT(*) as total_rows, COUNT(tenkai_kigo_code) as filled_count, ROUND(COUNT(tenkai_kigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyori_tekisei_code_2' as column_name, COUNT(*) as total_rows, COUNT(kyori_tekisei_code_2) as filled_count, ROUND(COUNT(kyori_tekisei_code_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'bataiju' as column_name, COUNT(*) as total_rows, COUNT(bataiju) as filled_count, ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'bataiju_zogen' as column_name, COUNT(*) as total_rows, COUNT(bataiju_zogen) as filled_count, ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'torikeshi_flag' as column_name, COUNT(*) as total_rows, COUNT(torikeshi_flag) as filled_count, ROUND(COUNT(torikeshi_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'seibetsu_code' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_code) as filled_count, ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'banushimei' as column_name, COUNT(*) as total_rows, COUNT(banushimei) as filled_count, ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'banushikai_code' as column_name, COUNT(*) as total_rows, COUNT(banushikai_code) as filled_count, ROUND(COUNT(banushikai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'umakigo_code' as column_name, COUNT(*) as total_rows, COUNT(umakigo_code) as filled_count, ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'gekiso_juni' as column_name, COUNT(*) as total_rows, COUNT(gekiso_juni) as filled_count, ROUND(COUNT(gekiso_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ls_shisu_juni' as column_name, COUNT(*) as total_rows, COUNT(ls_shisu_juni) as filled_count, ROUND(COUNT(ls_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ten_shisu_juni' as column_name, COUNT(*) as total_rows, COUNT(ten_shisu_juni) as filled_count, ROUND(COUNT(ten_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'pace_shisu_juni' as column_name, COUNT(*) as total_rows, COUNT(pace_shisu_juni) as filled_count, ROUND(COUNT(pace_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'agari_shisu_juni' as column_name, COUNT(*) as total_rows, COUNT(agari_shisu_juni) as filled_count, ROUND(COUNT(agari_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'ichi_shisu_juni' as column_name, COUNT(*) as total_rows, COUNT(ichi_shisu_juni) as filled_count, ROUND(COUNT(ichi_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_kitai_tansho_ritsu' as column_name, COUNT(*) as total_rows, COUNT(kishu_kitai_tansho_ritsu) as filled_count, ROUND(COUNT(kishu_kitai_tansho_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kishu_kitai_sanchakunai_ritsu' as column_name, COUNT(*) as total_rows, COUNT(kishu_kitai_sanchakunai_ritsu) as filled_count, ROUND(COUNT(kishu_kitai_sanchakunai_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yuso_kubun' as column_name, COUNT(*) as total_rows, COUNT(yuso_kubun) as filled_count, ROUND(COUNT(yuso_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'soho' as column_name, COUNT(*) as total_rows, COUNT(soho) as filled_count, ROUND(COUNT(soho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'taikei' as column_name, COUNT(*) as total_rows, COUNT(taikei) as filled_count, ROUND(COUNT(taikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'taikei_sogo_1' as column_name, COUNT(*) as total_rows, COUNT(taikei_sogo_1) as filled_count, ROUND(COUNT(taikei_sogo_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'taikei_sogo_2' as column_name, COUNT(*) as total_rows, COUNT(taikei_sogo_2) as filled_count, ROUND(COUNT(taikei_sogo_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'taikei_sogo_3' as column_name, COUNT(*) as total_rows, COUNT(taikei_sogo_3) as filled_count, ROUND(COUNT(taikei_sogo_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'uma_tokki_1' as column_name, COUNT(*) as total_rows, COUNT(uma_tokki_1) as filled_count, ROUND(COUNT(uma_tokki_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'uma_tokki_2' as column_name, COUNT(*) as total_rows, COUNT(uma_tokki_2) as filled_count, ROUND(COUNT(uma_tokki_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'uma_tokki_3' as column_name, COUNT(*) as total_rows, COUNT(uma_tokki_3) as filled_count, ROUND(COUNT(uma_tokki_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'uma_start_shisu' as column_name, COUNT(*) as total_rows, COUNT(uma_start_shisu) as filled_count, ROUND(COUNT(uma_start_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'uma_deokure_ritsu' as column_name, COUNT(*) as total_rows, COUNT(uma_deokure_ritsu) as filled_count, ROUND(COUNT(uma_deokure_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sanko_zenso' as column_name, COUNT(*) as total_rows, COUNT(sanko_zenso) as filled_count, ROUND(COUNT(sanko_zenso)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'sanko_zenso_kishu_code' as column_name, COUNT(*) as total_rows, COUNT(sanko_zenso_kishu_code) as filled_count, ROUND(COUNT(sanko_zenso_kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'manken_shisu' as column_name, COUNT(*) as total_rows, COUNT(manken_shisu) as filled_count, ROUND(COUNT(manken_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'manken_shirushi' as column_name, COUNT(*) as total_rows, COUNT(manken_shirushi) as filled_count, ROUND(COUNT(manken_shirushi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kokyu_flag' as column_name, COUNT(*) as total_rows, COUNT(kokyu_flag) as filled_count, ROUND(COUNT(kokyu_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'gekiso_type' as column_name, COUNT(*) as total_rows, COUNT(gekiso_type) as filled_count, ROUND(COUNT(gekiso_type)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyuyo_riyu_bunrui_code' as column_name, COUNT(*) as total_rows, COUNT(kyuyo_riyu_bunrui_code) as filled_count, ROUND(COUNT(kyuyo_riyu_bunrui_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'flag' as column_name, COUNT(*) as total_rows, COUNT(flag) as filled_count, ROUND(COUNT(flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'nyukyu_nansome' as column_name, COUNT(*) as total_rows, COUNT(nyukyu_nansome) as filled_count, ROUND(COUNT(nyukyu_nansome)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'nyukyu_nengappi' as column_name, COUNT(*) as total_rows, COUNT(nyukyu_nengappi) as filled_count, ROUND(COUNT(nyukyu_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'nyukyu_nannichimae' as column_name, COUNT(*) as total_rows, COUNT(nyukyu_nannichimae) as filled_count, ROUND(COUNT(nyukyu_nannichimae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'hobokusaki' as column_name, COUNT(*) as total_rows, COUNT(hobokusaki) as filled_count, ROUND(COUNT(hobokusaki)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'hobokusaki_rank' as column_name, COUNT(*) as total_rows, COUNT(hobokusaki_rank) as filled_count, ROUND(COUNT(hobokusaki_rank)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'kyusha_rank' as column_name, COUNT(*) as total_rows, COUNT(kyusha_rank) as filled_count, ROUND(COUNT(kyusha_rank)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_kyi' as table_name, 'yobi_5' as column_name, COUNT(*) as total_rows, COUNT(yobi_5) as filled_count, ROUND(COUNT(yobi_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_kyi
UNION ALL
SELECT 'jrd_sed' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race_shikonen' as column_name, COUNT(*) as total_rows, COUNT(race_shikonen) as filled_count, ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'babajotai_code' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code) as filled_count, ROUND(COUNT(babajotai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyoso_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_shubetsu_code) as filled_count, ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyoso_joken_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code) as filled_count, ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyoso_kigo_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_kigo_code) as filled_count, ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'juryo_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(juryo_shubetsu_code) as filled_count, ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'grade_code' as column_name, COUNT(*) as total_rows, COUNT(grade_code) as filled_count, ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyosomei' as column_name, COUNT(*) as total_rows, COUNT(kyosomei) as filled_count, ROUND(COUNT(kyosomei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyosomei_ryakusho_4' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_4) as filled_count, ROUND(COUNT(kyosomei_ryakusho_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kakutei_chakujun' as column_name, COUNT(*) as total_rows, COUNT(kakutei_chakujun) as filled_count, ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'ijo_kubun_code' as column_name, COUNT(*) as total_rows, COUNT(ijo_kubun_code) as filled_count, ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'soha_time' as column_name, COUNT(*) as total_rows, COUNT(soha_time) as filled_count, ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'futan_juryo' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo) as filled_count, ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kishumei' as column_name, COUNT(*) as total_rows, COUNT(kishumei) as filled_count, ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'chokyoshimei' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei) as filled_count, ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'tansho_odds' as column_name, COUNT(*) as total_rows, COUNT(tansho_odds) as filled_count, ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'tansho_ninkijun' as column_name, COUNT(*) as total_rows, COUNT(tansho_ninkijun) as filled_count, ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'idm' as column_name, COUNT(*) as total_rows, COUNT(idm) as filled_count, ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'soten' as column_name, COUNT(*) as total_rows, COUNT(soten) as filled_count, ROUND(COUNT(soten)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'babasa' as column_name, COUNT(*) as total_rows, COUNT(babasa) as filled_count, ROUND(COUNT(babasa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'pace' as column_name, COUNT(*) as total_rows, COUNT(pace) as filled_count, ROUND(COUNT(pace)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'deokure' as column_name, COUNT(*) as total_rows, COUNT(deokure) as filled_count, ROUND(COUNT(deokure)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'ichidori' as column_name, COUNT(*) as total_rows, COUNT(ichidori) as filled_count, ROUND(COUNT(ichidori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'furi' as column_name, COUNT(*) as total_rows, COUNT(furi) as filled_count, ROUND(COUNT(furi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'furi_1' as column_name, COUNT(*) as total_rows, COUNT(furi_1) as filled_count, ROUND(COUNT(furi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'furi_2' as column_name, COUNT(*) as total_rows, COUNT(furi_2) as filled_count, ROUND(COUNT(furi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'furi_3' as column_name, COUNT(*) as total_rows, COUNT(furi_3) as filled_count, ROUND(COUNT(furi_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race' as column_name, COUNT(*) as total_rows, COUNT(race) as filled_count, ROUND(COUNT(race)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'course_dori_code' as column_name, COUNT(*) as total_rows, COUNT(course_dori_code) as filled_count, ROUND(COUNT(course_dori_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'joshodo_code' as column_name, COUNT(*) as total_rows, COUNT(joshodo_code) as filled_count, ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'class_code' as column_name, COUNT(*) as total_rows, COUNT(class_code) as filled_count, ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'batai_code' as column_name, COUNT(*) as total_rows, COUNT(batai_code) as filled_count, ROUND(COUNT(batai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kehai_code' as column_name, COUNT(*) as total_rows, COUNT(kehai_code) as filled_count, ROUND(COUNT(kehai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race_pace' as column_name, COUNT(*) as total_rows, COUNT(race_pace) as filled_count, ROUND(COUNT(race_pace)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'uma_pace' as column_name, COUNT(*) as total_rows, COUNT(uma_pace) as filled_count, ROUND(COUNT(uma_pace)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'ten_shisu' as column_name, COUNT(*) as total_rows, COUNT(ten_shisu) as filled_count, ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'agari_shisu' as column_name, COUNT(*) as total_rows, COUNT(agari_shisu) as filled_count, ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'pace_shisu' as column_name, COUNT(*) as total_rows, COUNT(pace_shisu) as filled_count, ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race_p_shisu' as column_name, COUNT(*) as total_rows, COUNT(race_p_shisu) as filled_count, ROUND(COUNT(race_p_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'aiteuma_joho_1' as column_name, COUNT(*) as total_rows, COUNT(aiteuma_joho_1) as filled_count, ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'zenhan_3f_taimu' as column_name, COUNT(*) as total_rows, COUNT(zenhan_3f_taimu) as filled_count, ROUND(COUNT(zenhan_3f_taimu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kohan_3f' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f) as filled_count, ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'biko' as column_name, COUNT(*) as total_rows, COUNT(biko) as filled_count, ROUND(COUNT(biko)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'odds_fukusho' as column_name, COUNT(*) as total_rows, COUNT(odds_fukusho) as filled_count, ROUND(COUNT(odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'odds_tansho_10am' as column_name, COUNT(*) as total_rows, COUNT(odds_tansho_10am) as filled_count, ROUND(COUNT(odds_tansho_10am)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'odds_fukusho_10am' as column_name, COUNT(*) as total_rows, COUNT(odds_fukusho_10am) as filled_count, ROUND(COUNT(odds_fukusho_10am)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'corner_1' as column_name, COUNT(*) as total_rows, COUNT(corner_1) as filled_count, ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'corner_2' as column_name, COUNT(*) as total_rows, COUNT(corner_2) as filled_count, ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'corner_3' as column_name, COUNT(*) as total_rows, COUNT(corner_3) as filled_count, ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'corner_4' as column_name, COUNT(*) as total_rows, COUNT(corner_4) as filled_count, ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'zenhan_3f_sento_sa' as column_name, COUNT(*) as total_rows, COUNT(zenhan_3f_sento_sa) as filled_count, ROUND(COUNT(zenhan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kohan_3f_sento_sa' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f_sento_sa) as filled_count, ROUND(COUNT(kohan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'bataiju' as column_name, COUNT(*) as total_rows, COUNT(bataiju) as filled_count, ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'bataiju_zogen' as column_name, COUNT(*) as total_rows, COUNT(bataiju_zogen) as filled_count, ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'tenko_code' as column_name, COUNT(*) as total_rows, COUNT(tenko_code) as filled_count, ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'course_kubun' as column_name, COUNT(*) as total_rows, COUNT(course_kubun) as filled_count, ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'kyakushitsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyakushitsu_code) as filled_count, ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'haraimodoshi_tansho' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho) as filled_count, ROUND(COUNT(haraimodoshi_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'haraimodoshi_fukusho' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho) as filled_count, ROUND(COUNT(haraimodoshi_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'honshokin' as column_name, COUNT(*) as total_rows, COUNT(honshokin) as filled_count, ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'shutoku_shokin' as column_name, COUNT(*) as total_rows, COUNT(shutoku_shokin) as filled_count, ROUND(COUNT(shutoku_shokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'race_pace_nagare' as column_name, COUNT(*) as total_rows, COUNT(race_pace_nagare) as filled_count, ROUND(COUNT(race_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'uma_pace_nagare' as column_name, COUNT(*) as total_rows, COUNT(uma_pace_nagare) as filled_count, ROUND(COUNT(uma_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'corse_dori_code_corner_4' as column_name, COUNT(*) as total_rows, COUNT(corse_dori_code_corner_4) as filled_count, ROUND(COUNT(corse_dori_code_corner_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jrd_sed' as table_name, 'hasso_jikoku' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku) as filled_count, ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_sed
UNION ALL
SELECT 'jvd_ck' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'heichi_honshokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_honshokin_ruikei) as filled_count, ROUND(COUNT(heichi_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_honshokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_honshokin_ruikei) as filled_count, ROUND(COUNT(shogai_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'heichi_fukashokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_fukashokin_ruikei) as filled_count, ROUND(COUNT(heichi_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_fukashokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_fukashokin_ruikei) as filled_count, ROUND(COUNT(shogai_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'heichi_shutokushokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_shutokushokin_ruikei) as filled_count, ROUND(COUNT(heichi_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_shutokushokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_shutokushokin_ruikei) as filled_count, ROUND(COUNT(shogai_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'sogo' as column_name, COUNT(*) as total_rows, COUNT(sogo) as filled_count, ROUND(COUNT(sogo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'chuo_gokei' as column_name, COUNT(*) as total_rows, COUNT(chuo_gokei) as filled_count, ROUND(COUNT(chuo_gokei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_choku' as column_name, COUNT(*) as total_rows, COUNT(shiba_choku) as filled_count, ROUND(COUNT(shiba_choku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_migi' as column_name, COUNT(*) as total_rows, COUNT(shiba_migi) as filled_count, ROUND(COUNT(shiba_migi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_hidari' as column_name, COUNT(*) as total_rows, COUNT(shiba_hidari) as filled_count, ROUND(COUNT(shiba_hidari)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_choku' as column_name, COUNT(*) as total_rows, COUNT(dirt_choku) as filled_count, ROUND(COUNT(dirt_choku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_migi' as column_name, COUNT(*) as total_rows, COUNT(dirt_migi) as filled_count, ROUND(COUNT(dirt_migi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_hidari' as column_name, COUNT(*) as total_rows, COUNT(dirt_hidari) as filled_count, ROUND(COUNT(dirt_hidari)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai' as column_name, COUNT(*) as total_rows, COUNT(shogai) as filled_count, ROUND(COUNT(shogai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_ryo' as column_name, COUNT(*) as total_rows, COUNT(shiba_ryo) as filled_count, ROUND(COUNT(shiba_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(shiba_yayaomo) as filled_count, ROUND(COUNT(shiba_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_omo' as column_name, COUNT(*) as total_rows, COUNT(shiba_omo) as filled_count, ROUND(COUNT(shiba_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_furyo' as column_name, COUNT(*) as total_rows, COUNT(shiba_furyo) as filled_count, ROUND(COUNT(shiba_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_ryo' as column_name, COUNT(*) as total_rows, COUNT(dirt_ryo) as filled_count, ROUND(COUNT(dirt_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(dirt_yayaomo) as filled_count, ROUND(COUNT(dirt_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_omo' as column_name, COUNT(*) as total_rows, COUNT(dirt_omo) as filled_count, ROUND(COUNT(dirt_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_furyo' as column_name, COUNT(*) as total_rows, COUNT(dirt_furyo) as filled_count, ROUND(COUNT(dirt_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_ryo' as column_name, COUNT(*) as total_rows, COUNT(shogai_ryo) as filled_count, ROUND(COUNT(shogai_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(shogai_yayaomo) as filled_count, ROUND(COUNT(shogai_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_omo' as column_name, COUNT(*) as total_rows, COUNT(shogai_omo) as filled_count, ROUND(COUNT(shogai_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_furyo' as column_name, COUNT(*) as total_rows, COUNT(shogai_furyo) as filled_count, ROUND(COUNT(shogai_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_1200_ika' as column_name, COUNT(*) as total_rows, COUNT(shiba_1200_ika) as filled_count, ROUND(COUNT(shiba_1200_ika)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_1201_1400' as column_name, COUNT(*) as total_rows, COUNT(shiba_1201_1400) as filled_count, ROUND(COUNT(shiba_1201_1400)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_1401_1600' as column_name, COUNT(*) as total_rows, COUNT(shiba_1401_1600) as filled_count, ROUND(COUNT(shiba_1401_1600)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_1601_1800' as column_name, COUNT(*) as total_rows, COUNT(shiba_1601_1800) as filled_count, ROUND(COUNT(shiba_1601_1800)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_1801_2000' as column_name, COUNT(*) as total_rows, COUNT(shiba_1801_2000) as filled_count, ROUND(COUNT(shiba_1801_2000)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_2001_2200' as column_name, COUNT(*) as total_rows, COUNT(shiba_2001_2200) as filled_count, ROUND(COUNT(shiba_2001_2200)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_2201_2400' as column_name, COUNT(*) as total_rows, COUNT(shiba_2201_2400) as filled_count, ROUND(COUNT(shiba_2201_2400)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_2401_2800' as column_name, COUNT(*) as total_rows, COUNT(shiba_2401_2800) as filled_count, ROUND(COUNT(shiba_2401_2800)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_2801_ijo' as column_name, COUNT(*) as total_rows, COUNT(shiba_2801_ijo) as filled_count, ROUND(COUNT(shiba_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_1200_ika' as column_name, COUNT(*) as total_rows, COUNT(dirt_1200_ika) as filled_count, ROUND(COUNT(dirt_1200_ika)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_1201_1400' as column_name, COUNT(*) as total_rows, COUNT(dirt_1201_1400) as filled_count, ROUND(COUNT(dirt_1201_1400)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_1401_1600' as column_name, COUNT(*) as total_rows, COUNT(dirt_1401_1600) as filled_count, ROUND(COUNT(dirt_1401_1600)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_1601_1800' as column_name, COUNT(*) as total_rows, COUNT(dirt_1601_1800) as filled_count, ROUND(COUNT(dirt_1601_1800)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_1801_2000' as column_name, COUNT(*) as total_rows, COUNT(dirt_1801_2000) as filled_count, ROUND(COUNT(dirt_1801_2000)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_2001_2200' as column_name, COUNT(*) as total_rows, COUNT(dirt_2001_2200) as filled_count, ROUND(COUNT(dirt_2001_2200)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_2201_2400' as column_name, COUNT(*) as total_rows, COUNT(dirt_2201_2400) as filled_count, ROUND(COUNT(dirt_2201_2400)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_2401_2800' as column_name, COUNT(*) as total_rows, COUNT(dirt_2401_2800) as filled_count, ROUND(COUNT(dirt_2401_2800)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_2801_ijo' as column_name, COUNT(*) as total_rows, COUNT(dirt_2801_ijo) as filled_count, ROUND(COUNT(dirt_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_sapporo' as column_name, COUNT(*) as total_rows, COUNT(shiba_sapporo) as filled_count, ROUND(COUNT(shiba_sapporo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_hakodate' as column_name, COUNT(*) as total_rows, COUNT(shiba_hakodate) as filled_count, ROUND(COUNT(shiba_hakodate)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_fukushima' as column_name, COUNT(*) as total_rows, COUNT(shiba_fukushima) as filled_count, ROUND(COUNT(shiba_fukushima)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_niigata' as column_name, COUNT(*) as total_rows, COUNT(shiba_niigata) as filled_count, ROUND(COUNT(shiba_niigata)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_tokyo' as column_name, COUNT(*) as total_rows, COUNT(shiba_tokyo) as filled_count, ROUND(COUNT(shiba_tokyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_nakayama' as column_name, COUNT(*) as total_rows, COUNT(shiba_nakayama) as filled_count, ROUND(COUNT(shiba_nakayama)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_chukyo' as column_name, COUNT(*) as total_rows, COUNT(shiba_chukyo) as filled_count, ROUND(COUNT(shiba_chukyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_kyoto' as column_name, COUNT(*) as total_rows, COUNT(shiba_kyoto) as filled_count, ROUND(COUNT(shiba_kyoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_hanshin' as column_name, COUNT(*) as total_rows, COUNT(shiba_hanshin) as filled_count, ROUND(COUNT(shiba_hanshin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shiba_kokura' as column_name, COUNT(*) as total_rows, COUNT(shiba_kokura) as filled_count, ROUND(COUNT(shiba_kokura)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_sapporo' as column_name, COUNT(*) as total_rows, COUNT(dirt_sapporo) as filled_count, ROUND(COUNT(dirt_sapporo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_hakodate' as column_name, COUNT(*) as total_rows, COUNT(dirt_hakodate) as filled_count, ROUND(COUNT(dirt_hakodate)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_fukushima' as column_name, COUNT(*) as total_rows, COUNT(dirt_fukushima) as filled_count, ROUND(COUNT(dirt_fukushima)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_niigata' as column_name, COUNT(*) as total_rows, COUNT(dirt_niigata) as filled_count, ROUND(COUNT(dirt_niigata)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_tokyo' as column_name, COUNT(*) as total_rows, COUNT(dirt_tokyo) as filled_count, ROUND(COUNT(dirt_tokyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_nakayama' as column_name, COUNT(*) as total_rows, COUNT(dirt_nakayama) as filled_count, ROUND(COUNT(dirt_nakayama)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_chukyo' as column_name, COUNT(*) as total_rows, COUNT(dirt_chukyo) as filled_count, ROUND(COUNT(dirt_chukyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_kyoto' as column_name, COUNT(*) as total_rows, COUNT(dirt_kyoto) as filled_count, ROUND(COUNT(dirt_kyoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_hanshin' as column_name, COUNT(*) as total_rows, COUNT(dirt_hanshin) as filled_count, ROUND(COUNT(dirt_hanshin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'dirt_kokura' as column_name, COUNT(*) as total_rows, COUNT(dirt_kokura) as filled_count, ROUND(COUNT(dirt_kokura)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_sapporo' as column_name, COUNT(*) as total_rows, COUNT(shogai_sapporo) as filled_count, ROUND(COUNT(shogai_sapporo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_hakodate' as column_name, COUNT(*) as total_rows, COUNT(shogai_hakodate) as filled_count, ROUND(COUNT(shogai_hakodate)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_fukushima' as column_name, COUNT(*) as total_rows, COUNT(shogai_fukushima) as filled_count, ROUND(COUNT(shogai_fukushima)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_niigata' as column_name, COUNT(*) as total_rows, COUNT(shogai_niigata) as filled_count, ROUND(COUNT(shogai_niigata)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_tokyo' as column_name, COUNT(*) as total_rows, COUNT(shogai_tokyo) as filled_count, ROUND(COUNT(shogai_tokyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_nakayama' as column_name, COUNT(*) as total_rows, COUNT(shogai_nakayama) as filled_count, ROUND(COUNT(shogai_nakayama)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_chukyo' as column_name, COUNT(*) as total_rows, COUNT(shogai_chukyo) as filled_count, ROUND(COUNT(shogai_chukyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_kyoto' as column_name, COUNT(*) as total_rows, COUNT(shogai_kyoto) as filled_count, ROUND(COUNT(shogai_kyoto)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_hanshin' as column_name, COUNT(*) as total_rows, COUNT(shogai_hanshin) as filled_count, ROUND(COUNT(shogai_hanshin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'shogai_kokura' as column_name, COUNT(*) as total_rows, COUNT(shogai_kokura) as filled_count, ROUND(COUNT(shogai_kokura)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kyakushitsu_keiko' as column_name, COUNT(*) as total_rows, COUNT(kyakushitsu_keiko) as filled_count, ROUND(COUNT(kyakushitsu_keiko)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'toroku_race_su' as column_name, COUNT(*) as total_rows, COUNT(toroku_race_su) as filled_count, ROUND(COUNT(toroku_race_su)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'kishumei' as column_name, COUNT(*) as total_rows, COUNT(kishumei) as filled_count, ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_kishu_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_kishu_1) as filled_count, ROUND(COUNT(seiseki_joho_kishu_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_kishu_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_kishu_2) as filled_count, ROUND(COUNT(seiseki_joho_kishu_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'chokyoshimei' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei) as filled_count, ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_chokyoshi_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_chokyoshi_1) as filled_count, ROUND(COUNT(seiseki_joho_chokyoshi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_chokyoshi_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_chokyoshi_2) as filled_count, ROUND(COUNT(seiseki_joho_chokyoshi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'banushi_code' as column_name, COUNT(*) as total_rows, COUNT(banushi_code) as filled_count, ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'banushimei_hojinkaku' as column_name, COUNT(*) as total_rows, COUNT(banushimei_hojinkaku) as filled_count, ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'banushimei' as column_name, COUNT(*) as total_rows, COUNT(banushimei) as filled_count, ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_banushi_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_banushi_1) as filled_count, ROUND(COUNT(seiseki_joho_banushi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_banushi_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_banushi_2) as filled_count, ROUND(COUNT(seiseki_joho_banushi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seisansha_code' as column_name, COUNT(*) as total_rows, COUNT(seisansha_code) as filled_count, ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seisanshamei_hojinkaku' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei_hojinkaku) as filled_count, ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seisanshamei' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei) as filled_count, ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_seisansha_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_seisansha_1) as filled_count, ROUND(COUNT(seiseki_joho_seisansha_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ck' as table_name, 'seiseki_joho_seisansha_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_seisansha_2) as filled_count, ROUND(COUNT(seiseki_joho_seisansha_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'yobi_code' as column_name, COUNT(*) as total_rows, COUNT(yobi_code) as filled_count, ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'tokubetsu_kyoso_bango' as column_name, COUNT(*) as total_rows, COUNT(tokubetsu_kyoso_bango) as filled_count, ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_hondai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_hondai) as filled_count, ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_fukudai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_fukudai) as filled_count, ROUND(COUNT(kyosomei_fukudai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_kakkonai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kakkonai) as filled_count, ROUND(COUNT(kyosomei_kakkonai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_hondai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_hondai_eur) as filled_count, ROUND(COUNT(kyosomei_hondai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_fukudai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_fukudai_eur) as filled_count, ROUND(COUNT(kyosomei_fukudai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_kakkonai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kakkonai_eur) as filled_count, ROUND(COUNT(kyosomei_kakkonai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_ryakusho_10' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_10) as filled_count, ROUND(COUNT(kyosomei_ryakusho_10)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_ryakusho_6' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_6) as filled_count, ROUND(COUNT(kyosomei_ryakusho_6)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_ryakusho_3' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_3) as filled_count, ROUND(COUNT(kyosomei_ryakusho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyosomei_kubun' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kubun) as filled_count, ROUND(COUNT(kyosomei_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'jusho_kaiji' as column_name, COUNT(*) as total_rows, COUNT(jusho_kaiji) as filled_count, ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'grade_code' as column_name, COUNT(*) as total_rows, COUNT(grade_code) as filled_count, ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'grade_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(grade_code_henkomae) as filled_count, ROUND(COUNT(grade_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_shubetsu_code) as filled_count, ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_kigo_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_kigo_code) as filled_count, ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'juryo_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(juryo_shubetsu_code) as filled_count, ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_code_2sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_2sai) as filled_count, ROUND(COUNT(kyoso_joken_code_2sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_code_3sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_3sai) as filled_count, ROUND(COUNT(kyoso_joken_code_3sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_code_4sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_4sai) as filled_count, ROUND(COUNT(kyoso_joken_code_4sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_code_5sai_ijo' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_5sai_ijo) as filled_count, ROUND(COUNT(kyoso_joken_code_5sai_ijo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code) as filled_count, ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyoso_joken_meisho' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_meisho) as filled_count, ROUND(COUNT(kyoso_joken_meisho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kyori_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kyori_henkomae) as filled_count, ROUND(COUNT(kyori_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'track_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(track_code_henkomae) as filled_count, ROUND(COUNT(track_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'course_kubun' as column_name, COUNT(*) as total_rows, COUNT(course_kubun) as filled_count, ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'course_kubun_henkomae' as column_name, COUNT(*) as total_rows, COUNT(course_kubun_henkomae) as filled_count, ROUND(COUNT(course_kubun_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'honshokin' as column_name, COUNT(*) as total_rows, COUNT(honshokin) as filled_count, ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'honshokin_henkomae' as column_name, COUNT(*) as total_rows, COUNT(honshokin_henkomae) as filled_count, ROUND(COUNT(honshokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'fukashokin' as column_name, COUNT(*) as total_rows, COUNT(fukashokin) as filled_count, ROUND(COUNT(fukashokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'fukashokin_henkomae' as column_name, COUNT(*) as total_rows, COUNT(fukashokin_henkomae) as filled_count, ROUND(COUNT(fukashokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'hasso_jikoku' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku) as filled_count, ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'hasso_jikoku_henkomae' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku_henkomae) as filled_count, ROUND(COUNT(hasso_jikoku_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'nyusen_tosu' as column_name, COUNT(*) as total_rows, COUNT(nyusen_tosu) as filled_count, ROUND(COUNT(nyusen_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'tenko_code' as column_name, COUNT(*) as total_rows, COUNT(tenko_code) as filled_count, ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'babajotai_code_shiba' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_shiba) as filled_count, ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'babajotai_code_dirt' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_dirt) as filled_count, ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'lap_time' as column_name, COUNT(*) as total_rows, COUNT(lap_time) as filled_count, ROUND(COUNT(lap_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'shogai_mile_time' as column_name, COUNT(*) as total_rows, COUNT(shogai_mile_time) as filled_count, ROUND(COUNT(shogai_mile_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'zenhan_3f' as column_name, COUNT(*) as total_rows, COUNT(zenhan_3f) as filled_count, ROUND(COUNT(zenhan_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'zenhan_4f' as column_name, COUNT(*) as total_rows, COUNT(zenhan_4f) as filled_count, ROUND(COUNT(zenhan_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kohan_3f' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f) as filled_count, ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'kohan_4f' as column_name, COUNT(*) as total_rows, COUNT(kohan_4f) as filled_count, ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'corner_tsuka_juni_1' as column_name, COUNT(*) as total_rows, COUNT(corner_tsuka_juni_1) as filled_count, ROUND(COUNT(corner_tsuka_juni_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'corner_tsuka_juni_2' as column_name, COUNT(*) as total_rows, COUNT(corner_tsuka_juni_2) as filled_count, ROUND(COUNT(corner_tsuka_juni_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'corner_tsuka_juni_3' as column_name, COUNT(*) as total_rows, COUNT(corner_tsuka_juni_3) as filled_count, ROUND(COUNT(corner_tsuka_juni_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'corner_tsuka_juni_4' as column_name, COUNT(*) as total_rows, COUNT(corner_tsuka_juni_4) as filled_count, ROUND(COUNT(corner_tsuka_juni_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_ra' as table_name, 'record_koshin_kubun' as column_name, COUNT(*) as total_rows, COUNT(record_koshin_kubun) as filled_count, ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'wakuban' as column_name, COUNT(*) as total_rows, COUNT(wakuban) as filled_count, ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'umakigo_code' as column_name, COUNT(*) as total_rows, COUNT(umakigo_code) as filled_count, ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'seibetsu_code' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_code) as filled_count, ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'hinshu_code' as column_name, COUNT(*) as total_rows, COUNT(hinshu_code) as filled_count, ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'moshoku_code' as column_name, COUNT(*) as total_rows, COUNT(moshoku_code) as filled_count, ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'barei' as column_name, COUNT(*) as total_rows, COUNT(barei) as filled_count, ROUND(COUNT(barei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'tozai_shozoku_code' as column_name, COUNT(*) as total_rows, COUNT(tozai_shozoku_code) as filled_count, ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'chokyoshimei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_ryakusho) as filled_count, ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'banushi_code' as column_name, COUNT(*) as total_rows, COUNT(banushi_code) as filled_count, ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'banushimei' as column_name, COUNT(*) as total_rows, COUNT(banushimei) as filled_count, ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'fukushoku_hyoji' as column_name, COUNT(*) as total_rows, COUNT(fukushoku_hyoji) as filled_count, ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'futan_juryo' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo) as filled_count, ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'futan_juryo_henkomae' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo_henkomae) as filled_count, ROUND(COUNT(futan_juryo_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'blinker_shiyo_kubun' as column_name, COUNT(*) as total_rows, COUNT(blinker_shiyo_kubun) as filled_count, ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yobi_2' as column_name, COUNT(*) as total_rows, COUNT(yobi_2) as filled_count, ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishu_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishu_code_henkomae) as filled_count, ROUND(COUNT(kishu_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishumei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(kishumei_ryakusho) as filled_count, ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishumei_ryakusho_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishumei_ryakusho_henkomae) as filled_count, ROUND(COUNT(kishumei_ryakusho_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishu_minarai_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code) as filled_count, ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kishu_minarai_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code_henkomae) as filled_count, ROUND(COUNT(kishu_minarai_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'bataiju' as column_name, COUNT(*) as total_rows, COUNT(bataiju) as filled_count, ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'zogen_fugo' as column_name, COUNT(*) as total_rows, COUNT(zogen_fugo) as filled_count, ROUND(COUNT(zogen_fugo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'zogen_sa' as column_name, COUNT(*) as total_rows, COUNT(zogen_sa) as filled_count, ROUND(COUNT(zogen_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'ijo_kubun_code' as column_name, COUNT(*) as total_rows, COUNT(ijo_kubun_code) as filled_count, ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'nyusen_juni' as column_name, COUNT(*) as total_rows, COUNT(nyusen_juni) as filled_count, ROUND(COUNT(nyusen_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kakutei_chakujun' as column_name, COUNT(*) as total_rows, COUNT(kakutei_chakujun) as filled_count, ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'dochaku_kubun' as column_name, COUNT(*) as total_rows, COUNT(dochaku_kubun) as filled_count, ROUND(COUNT(dochaku_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'dochaku_tosu' as column_name, COUNT(*) as total_rows, COUNT(dochaku_tosu) as filled_count, ROUND(COUNT(dochaku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'soha_time' as column_name, COUNT(*) as total_rows, COUNT(soha_time) as filled_count, ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'chakusa_code_1' as column_name, COUNT(*) as total_rows, COUNT(chakusa_code_1) as filled_count, ROUND(COUNT(chakusa_code_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'chakusa_code_2' as column_name, COUNT(*) as total_rows, COUNT(chakusa_code_2) as filled_count, ROUND(COUNT(chakusa_code_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'chakusa_code_3' as column_name, COUNT(*) as total_rows, COUNT(chakusa_code_3) as filled_count, ROUND(COUNT(chakusa_code_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'corner_1' as column_name, COUNT(*) as total_rows, COUNT(corner_1) as filled_count, ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'corner_2' as column_name, COUNT(*) as total_rows, COUNT(corner_2) as filled_count, ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'corner_3' as column_name, COUNT(*) as total_rows, COUNT(corner_3) as filled_count, ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'corner_4' as column_name, COUNT(*) as total_rows, COUNT(corner_4) as filled_count, ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'tansho_odds' as column_name, COUNT(*) as total_rows, COUNT(tansho_odds) as filled_count, ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'tansho_ninkijun' as column_name, COUNT(*) as total_rows, COUNT(tansho_ninkijun) as filled_count, ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kakutoku_honshokin' as column_name, COUNT(*) as total_rows, COUNT(kakutoku_honshokin) as filled_count, ROUND(COUNT(kakutoku_honshokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kakutoku_fukashokin' as column_name, COUNT(*) as total_rows, COUNT(kakutoku_fukashokin) as filled_count, ROUND(COUNT(kakutoku_fukashokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yobi_3' as column_name, COUNT(*) as total_rows, COUNT(yobi_3) as filled_count, ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yobi_4' as column_name, COUNT(*) as total_rows, COUNT(yobi_4) as filled_count, ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kohan_4f' as column_name, COUNT(*) as total_rows, COUNT(kohan_4f) as filled_count, ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kohan_3f' as column_name, COUNT(*) as total_rows, COUNT(kohan_3f) as filled_count, ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'aiteuma_joho_1' as column_name, COUNT(*) as total_rows, COUNT(aiteuma_joho_1) as filled_count, ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'aiteuma_joho_2' as column_name, COUNT(*) as total_rows, COUNT(aiteuma_joho_2) as filled_count, ROUND(COUNT(aiteuma_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'aiteuma_joho_3' as column_name, COUNT(*) as total_rows, COUNT(aiteuma_joho_3) as filled_count, ROUND(COUNT(aiteuma_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'time_sa' as column_name, COUNT(*) as total_rows, COUNT(time_sa) as filled_count, ROUND(COUNT(time_sa)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'record_koshin_kubun' as column_name, COUNT(*) as total_rows, COUNT(record_koshin_kubun) as filled_count, ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'mining_kubun' as column_name, COUNT(*) as total_rows, COUNT(mining_kubun) as filled_count, ROUND(COUNT(mining_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yoso_soha_time' as column_name, COUNT(*) as total_rows, COUNT(yoso_soha_time) as filled_count, ROUND(COUNT(yoso_soha_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yoso_gosa_plus' as column_name, COUNT(*) as total_rows, COUNT(yoso_gosa_plus) as filled_count, ROUND(COUNT(yoso_gosa_plus)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yoso_gosa_minus' as column_name, COUNT(*) as total_rows, COUNT(yoso_gosa_minus) as filled_count, ROUND(COUNT(yoso_gosa_minus)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'yoso_juni' as column_name, COUNT(*) as total_rows, COUNT(yoso_juni) as filled_count, ROUND(COUNT(yoso_juni)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_se' as table_name, 'kyakushitsu_hantei' as column_name, COUNT(*) as total_rows, COUNT(kyakushitsu_hantei) as filled_count, ROUND(COUNT(kyakushitsu_hantei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
ORDER BY table_name, column_name;