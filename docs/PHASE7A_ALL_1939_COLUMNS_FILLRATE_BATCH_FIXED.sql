-- ============================================================
-- Phase 7-A 全1,939カラム充填率一括取得（修正版）
-- 作成日: 2026-03-03
-- 目的: 全43テーブルの充填率を1回のSQLで取得
-- ============================================================

-- 【実行手順】
-- 1. pgAdmin4でこのSQLをコピー＆ペースト
-- 2. 実行（F5）
-- 3. 結果を右クリック → "Export" → CSV
-- 4. ファイル名: all_1939_columns_fillrate_complete.csv
-- 5. アップロード

-- 【推定実行時間】5-10分

SELECT 'jrd_bac' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'race_shikonen' as column_name, COUNT(*) as total_rows, COUNT(race_shikonen) as filled_count, ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'hasso_jikoku' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku) as filled_count, ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyoso_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_shubetsu_code) as filled_count, ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyoso_joken_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code) as filled_count, ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyoso_kigo_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_kigo_code) as filled_count, ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'juryo_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(juryo_shubetsu_code) as filled_count, ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'grade_code' as column_name, COUNT(*) as total_rows, COUNT(grade_code) as filled_count, ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyosomei' as column_name, COUNT(*) as total_rows, COUNT(kyosomei) as filled_count, ROUND(COUNT(kyosomei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'jusho_kaiji' as column_name, COUNT(*) as total_rows, COUNT(jusho_kaiji) as filled_count, ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'course_kubun' as column_name, COUNT(*) as total_rows, COUNT(course_kubun) as filled_count, ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kaisai_kubun' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kubun) as filled_count, ROUND(COUNT(kaisai_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyosomei_ryakusho_4' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_4) as filled_count, ROUND(COUNT(kyosomei_ryakusho_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'kyosomei_ryakusho_9' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_9) as filled_count, ROUND(COUNT(kyosomei_ryakusho_9)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'honshokin' as column_name, COUNT(*) as total_rows, COUNT(honshokin) as filled_count, ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'fukashokin' as column_name, COUNT(*) as total_rows, COUNT(fukashokin) as filled_count, ROUND(COUNT(fukashokin)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'baken_hatsubai_flag' as column_name, COUNT(*) as total_rows, COUNT(baken_hatsubai_flag) as filled_count, ROUND(COUNT(baken_hatsubai_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'win5_flag' as column_name, COUNT(*) as total_rows, COUNT(win5_flag) as filled_count, ROUND(COUNT(win5_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_bac' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_bac
UNION ALL
SELECT 'jrd_cyb' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'race_shikonen' as column_name, COUNT(*) as total_rows, COUNT(race_shikonen) as filled_count, ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_type' as column_name, COUNT(*) as total_rows, COUNT(chokyo_type) as filled_count, ROUND(COUNT(chokyo_type)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_shubetsu' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_shubetsu) as filled_count, ROUND(COUNT(chokyo_corse_shubetsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_hanro' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_hanro) as filled_count, ROUND(COUNT(chokyo_corse_hanro)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_wood' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_wood) as filled_count, ROUND(COUNT(chokyo_corse_wood)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_dirt' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_dirt) as filled_count, ROUND(COUNT(chokyo_corse_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_shiba' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_shiba) as filled_count, ROUND(COUNT(chokyo_corse_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_pool' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_pool) as filled_count, ROUND(COUNT(chokyo_corse_pool)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_shogai' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_shogai) as filled_count, ROUND(COUNT(chokyo_corse_shogai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_corse_polytrack' as column_name, COUNT(*) as total_rows, COUNT(chokyo_corse_polytrack) as filled_count, ROUND(COUNT(chokyo_corse_polytrack)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_kyori' as column_name, COUNT(*) as total_rows, COUNT(chokyo_kyori) as filled_count, ROUND(COUNT(chokyo_kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_juten' as column_name, COUNT(*) as total_rows, COUNT(chokyo_juten) as filled_count, ROUND(COUNT(chokyo_juten)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'oikiri_shisu' as column_name, COUNT(*) as total_rows, COUNT(oikiri_shisu) as filled_count, ROUND(COUNT(oikiri_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'shiage_shisu' as column_name, COUNT(*) as total_rows, COUNT(shiage_shisu) as filled_count, ROUND(COUNT(shiage_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_ryo_hyoka' as column_name, COUNT(*) as total_rows, COUNT(chokyo_ryo_hyoka) as filled_count, ROUND(COUNT(chokyo_ryo_hyoka)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'shiage_shisu_henka' as column_name, COUNT(*) as total_rows, COUNT(shiage_shisu_henka) as filled_count, ROUND(COUNT(shiage_shisu_henka)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_comment' as column_name, COUNT(*) as total_rows, COUNT(chokyo_comment) as filled_count, ROUND(COUNT(chokyo_comment)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'comment_nengappi' as column_name, COUNT(*) as total_rows, COUNT(comment_nengappi) as filled_count, ROUND(COUNT(comment_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'chokyo_hyoka' as column_name, COUNT(*) as total_rows, COUNT(chokyo_hyoka) as filled_count, ROUND(COUNT(chokyo_hyoka)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'oikiri_shisu_isshumae' as column_name, COUNT(*) as total_rows, COUNT(oikiri_shisu_isshumae) as filled_count, ROUND(COUNT(oikiri_shisu_isshumae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'oikiri_corse_isshumae' as column_name, COUNT(*) as total_rows, COUNT(oikiri_corse_isshumae) as filled_count, ROUND(COUNT(oikiri_corse_isshumae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_cyb' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_cyb
UNION ALL
SELECT 'jrd_joa' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'race_shikonen' as column_name, COUNT(*) as total_rows, COUNT(race_shikonen) as filled_count, ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kijun_odds_tansho' as column_name, COUNT(*) as total_rows, COUNT(kijun_odds_tansho) as filled_count, ROUND(COUNT(kijun_odds_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kijun_odds_fukusho' as column_name, COUNT(*) as total_rows, COUNT(kijun_odds_fukusho) as filled_count, ROUND(COUNT(kijun_odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'cid_chokyo_soten' as column_name, COUNT(*) as total_rows, COUNT(cid_chokyo_soten) as filled_count, ROUND(COUNT(cid_chokyo_soten)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'cid_kyusha_soten' as column_name, COUNT(*) as total_rows, COUNT(cid_kyusha_soten) as filled_count, ROUND(COUNT(cid_kyusha_soten)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'cid_soten' as column_name, COUNT(*) as total_rows, COUNT(cid_soten) as filled_count, ROUND(COUNT(cid_soten)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'cid' as column_name, COUNT(*) as total_rows, COUNT(cid) as filled_count, ROUND(COUNT(cid)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'ls_shisu' as column_name, COUNT(*) as total_rows, COUNT(ls_shisu) as filled_count, ROUND(COUNT(ls_shisu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'ls_hyoka' as column_name, COUNT(*) as total_rows, COUNT(ls_hyoka) as filled_count, ROUND(COUNT(ls_hyoka)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'em' as column_name, COUNT(*) as total_rows, COUNT(em) as filled_count, ROUND(COUNT(em)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kyusha_bb_shirushi' as column_name, COUNT(*) as total_rows, COUNT(kyusha_bb_shirushi) as filled_count, ROUND(COUNT(kyusha_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kyusha_bb_nijumaru_tansho_kaishuritsu' as column_name, COUNT(*) as total_rows, COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu) as filled_count, ROUND(COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kyusha_bb_nijumaru_rentai_ritsu' as column_name, COUNT(*) as total_rows, COUNT(kyusha_bb_nijumaru_rentai_ritsu) as filled_count, ROUND(COUNT(kyusha_bb_nijumaru_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kishu_bb_shirushi' as column_name, COUNT(*) as total_rows, COUNT(kishu_bb_shirushi) as filled_count, ROUND(COUNT(kishu_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kishu_bb_nijumaru_tansho_kaishuritsu' as column_name, COUNT(*) as total_rows, COUNT(kishu_bb_nijumaru_tansho_kaishuritsu) as filled_count, ROUND(COUNT(kishu_bb_nijumaru_tansho_kaishuritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'kishu_bb_nijumaru_rentai_ritsu' as column_name, COUNT(*) as total_rows, COUNT(kishu_bb_nijumaru_rentai_ritsu) as filled_count, ROUND(COUNT(kishu_bb_nijumaru_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
SELECT 'jrd_joa' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jrd_joa
UNION ALL
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
SELECT 'jvd_av' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_av' as table_name, 'jiyu_kubun' as column_name, COUNT(*) as total_rows, COUNT(jiyu_kubun) as filled_count, ROUND(COUNT(jiyu_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_av
UNION ALL
SELECT 'jvd_bn' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'banushi_code' as column_name, COUNT(*) as total_rows, COUNT(banushi_code) as filled_count, ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'banushimei_hojinkaku' as column_name, COUNT(*) as total_rows, COUNT(banushimei_hojinkaku) as filled_count, ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'banushimei' as column_name, COUNT(*) as total_rows, COUNT(banushimei) as filled_count, ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'banushimei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(banushimei_hankaku_kana) as filled_count, ROUND(COUNT(banushimei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'banushimei_eur' as column_name, COUNT(*) as total_rows, COUNT(banushimei_eur) as filled_count, ROUND(COUNT(banushimei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'fukushoku_hyoji' as column_name, COUNT(*) as total_rows, COUNT(fukushoku_hyoji) as filled_count, ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'seiseki_joho_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_1) as filled_count, ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_bn' as table_name, 'seiseki_joho_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_2) as filled_count, ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bn
UNION ALL
SELECT 'jvd_br' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisansha_code' as column_name, COUNT(*) as total_rows, COUNT(seisansha_code) as filled_count, ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisanshamei_hojinkaku' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei_hojinkaku) as filled_count, ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisanshamei' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei) as filled_count, ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisanshamei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei_hankaku_kana) as filled_count, ROUND(COUNT(seisanshamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisanshamei_eur' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei_eur) as filled_count, ROUND(COUNT(seisanshamei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seisansha_jusho_jichishomei' as column_name, COUNT(*) as total_rows, COUNT(seisansha_jusho_jichishomei) as filled_count, ROUND(COUNT(seisansha_jusho_jichishomei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seiseki_joho_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_1) as filled_count, ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_br' as table_name, 'seiseki_joho_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_2) as filled_count, ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_br
UNION ALL
SELECT 'jvd_bt' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'hanshoku_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(hanshoku_toroku_bango) as filled_count, ROUND(COUNT(hanshoku_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'keito_id' as column_name, COUNT(*) as total_rows, COUNT(keito_id) as filled_count, ROUND(COUNT(keito_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'keito_mei' as column_name, COUNT(*) as total_rows, COUNT(keito_mei) as filled_count, ROUND(COUNT(keito_mei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_bt' as table_name, 'keito_setsumei' as column_name, COUNT(*) as total_rows, COUNT(keito_setsumei) as filled_count, ROUND(COUNT(keito_setsumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_bt
UNION ALL
SELECT 'jvd_cc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'kyori_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kyori_henkomae) as filled_count, ROUND(COUNT(kyori_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'track_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(track_code_henkomae) as filled_count, ROUND(COUNT(track_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_cc' as table_name, 'jiyu_kubun' as column_name, COUNT(*) as total_rows, COUNT(jiyu_kubun) as filled_count, ROUND(COUNT(jiyu_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cc
UNION ALL
SELECT 'jvd_ch' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'massho_kubun' as column_name, COUNT(*) as total_rows, COUNT(massho_kubun) as filled_count, ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'menkyo_kofu_nengappi' as column_name, COUNT(*) as total_rows, COUNT(menkyo_kofu_nengappi) as filled_count, ROUND(COUNT(menkyo_kofu_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'menkyo_massho_nengappi' as column_name, COUNT(*) as total_rows, COUNT(menkyo_massho_nengappi) as filled_count, ROUND(COUNT(menkyo_massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'seinengappi' as column_name, COUNT(*) as total_rows, COUNT(seinengappi) as filled_count, ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'chokyoshimei' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei) as filled_count, ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'chokyoshimei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_hankaku_kana) as filled_count, ROUND(COUNT(chokyoshimei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'chokyoshimei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_ryakusho) as filled_count, ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'chokyoshimei_eur' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_eur) as filled_count, ROUND(COUNT(chokyoshimei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'seibetsu_kubun' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_kubun) as filled_count, ROUND(COUNT(seibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'tozai_shozoku_code' as column_name, COUNT(*) as total_rows, COUNT(tozai_shozoku_code) as filled_count, ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'shotai_chiikimei' as column_name, COUNT(*) as total_rows, COUNT(shotai_chiikimei) as filled_count, ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'jushoshori_joho_1' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_1) as filled_count, ROUND(COUNT(jushoshori_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'jushoshori_joho_2' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_2) as filled_count, ROUND(COUNT(jushoshori_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'jushoshori_joho_3' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_3) as filled_count, ROUND(COUNT(jushoshori_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'seiseki_joho_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_1) as filled_count, ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'seiseki_joho_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_2) as filled_count, ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
UNION ALL
SELECT 'jvd_ch' as table_name, 'seiseki_joho_3' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_3) as filled_count, ROUND(COUNT(seiseki_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ch
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
SELECT 'jvd_cs' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'course_kaishu_nengappi' as column_name, COUNT(*) as total_rows, COUNT(course_kaishu_nengappi) as filled_count, ROUND(COUNT(course_kaishu_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_cs' as table_name, 'course_setsumei' as column_name, COUNT(*) as total_rows, COUNT(course_setsumei) as filled_count, ROUND(COUNT(course_setsumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_cs
UNION ALL
SELECT 'jvd_dm' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'data_sakusei_jifun' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_jifun) as filled_count, ROUND(COUNT(data_sakusei_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_01' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_01) as filled_count, ROUND(COUNT(mining_yoso_01)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_02' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_02) as filled_count, ROUND(COUNT(mining_yoso_02)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_03' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_03) as filled_count, ROUND(COUNT(mining_yoso_03)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_04' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_04) as filled_count, ROUND(COUNT(mining_yoso_04)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_05' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_05) as filled_count, ROUND(COUNT(mining_yoso_05)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_06' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_06) as filled_count, ROUND(COUNT(mining_yoso_06)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_07' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_07) as filled_count, ROUND(COUNT(mining_yoso_07)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_08' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_08) as filled_count, ROUND(COUNT(mining_yoso_08)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_09' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_09) as filled_count, ROUND(COUNT(mining_yoso_09)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_10' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_10) as filled_count, ROUND(COUNT(mining_yoso_10)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_11' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_11) as filled_count, ROUND(COUNT(mining_yoso_11)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_12' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_12) as filled_count, ROUND(COUNT(mining_yoso_12)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_13' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_13) as filled_count, ROUND(COUNT(mining_yoso_13)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_14' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_14) as filled_count, ROUND(COUNT(mining_yoso_14)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_15' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_15) as filled_count, ROUND(COUNT(mining_yoso_15)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_16' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_16) as filled_count, ROUND(COUNT(mining_yoso_16)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_17' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_17) as filled_count, ROUND(COUNT(mining_yoso_17)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_dm' as table_name, 'mining_yoso_18' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_18) as filled_count, ROUND(COUNT(mining_yoso_18)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_tansho' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_tansho) as filled_count, ROUND(COUNT(hatsubai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_fukusho' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_fukusho) as filled_count, ROUND(COUNT(hatsubai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_wakuren' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_wakuren) as filled_count, ROUND(COUNT(hatsubai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_umaren' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_umaren) as filled_count, ROUND(COUNT(hatsubai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_wide' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_wide) as filled_count, ROUND(COUNT(hatsubai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_umatan' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_umatan) as filled_count, ROUND(COUNT(hatsubai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hatsubai_flag_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_sanrenpuku) as filled_count, ROUND(COUNT(hatsubai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'fukusho_chakubarai_key' as column_name, COUNT(*) as total_rows, COUNT(fukusho_chakubarai_key) as filled_count, ROUND(COUNT(fukusho_chakubarai_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_umaban_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_umaban_joho) as filled_count, ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_wakuban_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_wakuban_joho) as filled_count, ROUND(COUNT(henkan_wakuban_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_dowaku_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_dowaku_joho) as filled_count, ROUND(COUNT(henkan_dowaku_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_tansho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_tansho) as filled_count, ROUND(COUNT(hyosu_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_fukusho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_fukusho) as filled_count, ROUND(COUNT(hyosu_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_wakuren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_wakuren) as filled_count, ROUND(COUNT(hyosu_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_umaren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_umaren) as filled_count, ROUND(COUNT(hyosu_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_wide' as column_name, COUNT(*) as total_rows, COUNT(hyosu_wide) as filled_count, ROUND(COUNT(hyosu_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_umatan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_umatan) as filled_count, ROUND(COUNT(hyosu_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(hyosu_sanrenpuku) as filled_count, ROUND(COUNT(hyosu_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_tansho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_tansho) as filled_count, ROUND(COUNT(hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_fukusho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_fukusho) as filled_count, ROUND(COUNT(hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_wakuren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_wakuren) as filled_count, ROUND(COUNT(hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_umaren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_umaren) as filled_count, ROUND(COUNT(hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_wide' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_wide) as filled_count, ROUND(COUNT(hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_umatan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_umatan) as filled_count, ROUND(COUNT(hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'hyosu_gokei_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_sanrenpuku) as filled_count, ROUND(COUNT(hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_tansho' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_tansho) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_fukusho' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_fukusho) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_wakuren' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_wakuren) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_umaren' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_umaren) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_wide' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_wide) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_umatan' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_umatan) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h1' as table_name, 'henkan_hyosu_gokei_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_sanrenpuku) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'hatsubai_flag_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_sanrentan) as filled_count, ROUND(COUNT(hatsubai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'henkan_umaban_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_umaban_joho) as filled_count, ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'hyosu_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_sanrentan) as filled_count, ROUND(COUNT(hyosu_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'hyosu_gokei_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_sanrentan) as filled_count, ROUND(COUNT(hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_h6' as table_name, 'henkan_hyosu_gokei_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(henkan_hyosu_gokei_sanrentan) as filled_count, ROUND(COUNT(henkan_hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'tracen_kubun' as column_name, COUNT(*) as total_rows, COUNT(tracen_kubun) as filled_count, ROUND(COUNT(tracen_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'chokyo_nengappi' as column_name, COUNT(*) as total_rows, COUNT(chokyo_nengappi) as filled_count, ROUND(COUNT(chokyo_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'chokyo_jikoku' as column_name, COUNT(*) as total_rows, COUNT(chokyo_jikoku) as filled_count, ROUND(COUNT(chokyo_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'time_gokei_4f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_4f) as filled_count, ROUND(COUNT(time_gokei_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'lap_time_4f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_4f) as filled_count, ROUND(COUNT(lap_time_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'time_gokei_3f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_3f) as filled_count, ROUND(COUNT(time_gokei_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'lap_time_3f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_3f) as filled_count, ROUND(COUNT(lap_time_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'time_gokei_2f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_2f) as filled_count, ROUND(COUNT(time_gokei_2f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'lap_time_2f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_2f) as filled_count, ROUND(COUNT(lap_time_2f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hc' as table_name, 'lap_time_1f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_1f) as filled_count, ROUND(COUNT(lap_time_1f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hc
UNION ALL
SELECT 'jvd_hn' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'hanshoku_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(hanshoku_toroku_bango) as filled_count, ROUND(COUNT(hanshoku_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'yobi_2' as column_name, COUNT(*) as total_rows, COUNT(yobi_2) as filled_count, ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'bamei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(bamei_hankaku_kana) as filled_count, ROUND(COUNT(bamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'bamei_eur' as column_name, COUNT(*) as total_rows, COUNT(bamei_eur) as filled_count, ROUND(COUNT(bamei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'seinen' as column_name, COUNT(*) as total_rows, COUNT(seinen) as filled_count, ROUND(COUNT(seinen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'seibetsu_code' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_code) as filled_count, ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'hinshu_code' as column_name, COUNT(*) as total_rows, COUNT(hinshu_code) as filled_count, ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'moshoku_code' as column_name, COUNT(*) as total_rows, COUNT(moshoku_code) as filled_count, ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'mochikomi_kubun' as column_name, COUNT(*) as total_rows, COUNT(mochikomi_kubun) as filled_count, ROUND(COUNT(mochikomi_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'yunyu_nen' as column_name, COUNT(*) as total_rows, COUNT(yunyu_nen) as filled_count, ROUND(COUNT(yunyu_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'sanchimei' as column_name, COUNT(*) as total_rows, COUNT(sanchimei) as filled_count, ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'ketto_joho_01a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_01a) as filled_count, ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hn' as table_name, 'ketto_joho_02a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_02a) as filled_count, ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hn
UNION ALL
SELECT 'jvd_hr' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_tansho' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_tansho) as filled_count, ROUND(COUNT(fuseiritsu_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_fukusho' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_fukusho) as filled_count, ROUND(COUNT(fuseiritsu_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_wakuren' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_wakuren) as filled_count, ROUND(COUNT(fuseiritsu_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_umaren' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_umaren) as filled_count, ROUND(COUNT(fuseiritsu_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_wide' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_wide) as filled_count, ROUND(COUNT(fuseiritsu_flag_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_umatan' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_umatan) as filled_count, ROUND(COUNT(fuseiritsu_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_sanrenpuku) as filled_count, ROUND(COUNT(fuseiritsu_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'fuseiritsu_flag_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag_sanrentan) as filled_count, ROUND(COUNT(fuseiritsu_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_tansho' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_tansho) as filled_count, ROUND(COUNT(tokubarai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_fukusho' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_fukusho) as filled_count, ROUND(COUNT(tokubarai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_wakuren' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_wakuren) as filled_count, ROUND(COUNT(tokubarai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_umaren' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_umaren) as filled_count, ROUND(COUNT(tokubarai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_wide' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_wide) as filled_count, ROUND(COUNT(tokubarai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_2' as column_name, COUNT(*) as total_rows, COUNT(yobi_2) as filled_count, ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_umatan' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_umatan) as filled_count, ROUND(COUNT(tokubarai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_sanrenpuku) as filled_count, ROUND(COUNT(tokubarai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'tokubarai_flag_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(tokubarai_flag_sanrentan) as filled_count, ROUND(COUNT(tokubarai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_tansho' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_tansho) as filled_count, ROUND(COUNT(henkan_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_fukusho' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_fukusho) as filled_count, ROUND(COUNT(henkan_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_wakuren' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_wakuren) as filled_count, ROUND(COUNT(henkan_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_umaren' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_umaren) as filled_count, ROUND(COUNT(henkan_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_wide' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_wide) as filled_count, ROUND(COUNT(henkan_flag_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_3' as column_name, COUNT(*) as total_rows, COUNT(yobi_3) as filled_count, ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_umatan' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_umatan) as filled_count, ROUND(COUNT(henkan_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_sanrenpuku) as filled_count, ROUND(COUNT(henkan_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_flag_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag_sanrentan) as filled_count, ROUND(COUNT(henkan_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_umaban_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_umaban_joho) as filled_count, ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_wakuban_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_wakuban_joho) as filled_count, ROUND(COUNT(henkan_wakuban_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'henkan_dowaku_joho' as column_name, COUNT(*) as total_rows, COUNT(henkan_dowaku_joho) as filled_count, ROUND(COUNT(henkan_dowaku_joho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_1a) as filled_count, ROUND(COUNT(haraimodoshi_tansho_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_1b) as filled_count, ROUND(COUNT(haraimodoshi_tansho_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_1c) as filled_count, ROUND(COUNT(haraimodoshi_tansho_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_2a) as filled_count, ROUND(COUNT(haraimodoshi_tansho_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_2b) as filled_count, ROUND(COUNT(haraimodoshi_tansho_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_2c) as filled_count, ROUND(COUNT(haraimodoshi_tansho_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_3a) as filled_count, ROUND(COUNT(haraimodoshi_tansho_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_3b) as filled_count, ROUND(COUNT(haraimodoshi_tansho_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_tansho_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_tansho_3c) as filled_count, ROUND(COUNT(haraimodoshi_tansho_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_1a) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_1b) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_1c) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_2a) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_2b) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_2c) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_3a) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_3b) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_3c) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_4a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_4a) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_4a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_4b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_4b) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_4b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_4c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_4c) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_4c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_5a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_5a) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_5a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_5b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_5b) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_5b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_fukusho_5c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_fukusho_5c) as filled_count, ROUND(COUNT(haraimodoshi_fukusho_5c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_1a) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_1b) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_1c) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_2a) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_2b) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_2c) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_3a) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_3b) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wakuren_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wakuren_3c) as filled_count, ROUND(COUNT(haraimodoshi_wakuren_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_1a) as filled_count, ROUND(COUNT(haraimodoshi_umaren_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_1b) as filled_count, ROUND(COUNT(haraimodoshi_umaren_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_1c) as filled_count, ROUND(COUNT(haraimodoshi_umaren_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_2a) as filled_count, ROUND(COUNT(haraimodoshi_umaren_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_2b) as filled_count, ROUND(COUNT(haraimodoshi_umaren_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_2c) as filled_count, ROUND(COUNT(haraimodoshi_umaren_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_3a) as filled_count, ROUND(COUNT(haraimodoshi_umaren_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_3b) as filled_count, ROUND(COUNT(haraimodoshi_umaren_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umaren_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umaren_3c) as filled_count, ROUND(COUNT(haraimodoshi_umaren_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_1a) as filled_count, ROUND(COUNT(haraimodoshi_wide_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_1b) as filled_count, ROUND(COUNT(haraimodoshi_wide_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_1c) as filled_count, ROUND(COUNT(haraimodoshi_wide_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_2a) as filled_count, ROUND(COUNT(haraimodoshi_wide_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_2b) as filled_count, ROUND(COUNT(haraimodoshi_wide_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_2c) as filled_count, ROUND(COUNT(haraimodoshi_wide_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_3a) as filled_count, ROUND(COUNT(haraimodoshi_wide_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_3b) as filled_count, ROUND(COUNT(haraimodoshi_wide_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_3c) as filled_count, ROUND(COUNT(haraimodoshi_wide_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_4a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_4a) as filled_count, ROUND(COUNT(haraimodoshi_wide_4a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_4b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_4b) as filled_count, ROUND(COUNT(haraimodoshi_wide_4b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_4c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_4c) as filled_count, ROUND(COUNT(haraimodoshi_wide_4c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_5a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_5a) as filled_count, ROUND(COUNT(haraimodoshi_wide_5a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_5b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_5b) as filled_count, ROUND(COUNT(haraimodoshi_wide_5b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_5c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_5c) as filled_count, ROUND(COUNT(haraimodoshi_wide_5c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_6a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_6a) as filled_count, ROUND(COUNT(haraimodoshi_wide_6a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_6b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_6b) as filled_count, ROUND(COUNT(haraimodoshi_wide_6b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_6c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_6c) as filled_count, ROUND(COUNT(haraimodoshi_wide_6c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_7a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_7a) as filled_count, ROUND(COUNT(haraimodoshi_wide_7a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_7b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_7b) as filled_count, ROUND(COUNT(haraimodoshi_wide_7b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_wide_7c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_wide_7c) as filled_count, ROUND(COUNT(haraimodoshi_wide_7c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_1a' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_1a) as filled_count, ROUND(COUNT(yobi_4_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_1b' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_1b) as filled_count, ROUND(COUNT(yobi_4_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_1c' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_1c) as filled_count, ROUND(COUNT(yobi_4_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_2a' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_2a) as filled_count, ROUND(COUNT(yobi_4_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_2b' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_2b) as filled_count, ROUND(COUNT(yobi_4_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_2c' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_2c) as filled_count, ROUND(COUNT(yobi_4_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_3a' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_3a) as filled_count, ROUND(COUNT(yobi_4_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_3b' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_3b) as filled_count, ROUND(COUNT(yobi_4_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'yobi_4_3c' as column_name, COUNT(*) as total_rows, COUNT(yobi_4_3c) as filled_count, ROUND(COUNT(yobi_4_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_1a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_1b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_1c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_2a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_2b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_2c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_3a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_3b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_3c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_4a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_4a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_4a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_4b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_4b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_4b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_4c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_4c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_4c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_5a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_5a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_5a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_5b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_5b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_5b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_5c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_5c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_5c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_6a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_6a) as filled_count, ROUND(COUNT(haraimodoshi_umatan_6a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_6b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_6b) as filled_count, ROUND(COUNT(haraimodoshi_umatan_6b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_umatan_6c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_umatan_6c) as filled_count, ROUND(COUNT(haraimodoshi_umatan_6c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_1a) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_1b) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_1c) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_2a) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_2b) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_2c) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_3a) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_3b) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrenpuku_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrenpuku_3c) as filled_count, ROUND(COUNT(haraimodoshi_sanrenpuku_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_1a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_1a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_1a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_1b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_1b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_1b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_1c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_1c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_1c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_2a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_2a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_2a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_2b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_2b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_2b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_2c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_2c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_2c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_3a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_3a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_3a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_3b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_3b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_3b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_3c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_3c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_3c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_4a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_4a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_4a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_4b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_4b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_4b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_4c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_4c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_4c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_5a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_5a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_5a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_5b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_5b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_5b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_5c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_5c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_5c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_6a' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_6a) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_6a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_6b' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_6b) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_6b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hr' as table_name, 'haraimodoshi_sanrentan_6c' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_sanrentan_6c) as filled_count, ROUND(COUNT(haraimodoshi_sanrentan_6c)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_hs' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'ketto_joho_01a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_01a) as filled_count, ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'ketto_joho_02a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_02a) as filled_count, ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'seinen' as column_name, COUNT(*) as total_rows, COUNT(seinen) as filled_count, ROUND(COUNT(seinen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'shusaisha_shijo_code' as column_name, COUNT(*) as total_rows, COUNT(shusaisha_shijo_code) as filled_count, ROUND(COUNT(shusaisha_shijo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'shusaisha_meisho' as column_name, COUNT(*) as total_rows, COUNT(shusaisha_meisho) as filled_count, ROUND(COUNT(shusaisha_meisho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'shijo_meisho' as column_name, COUNT(*) as total_rows, COUNT(shijo_meisho) as filled_count, ROUND(COUNT(shijo_meisho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'kaisai_kikan_min' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kikan_min) as filled_count, ROUND(COUNT(kaisai_kikan_min)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'kaisai_kikan_max' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kikan_max) as filled_count, ROUND(COUNT(kaisai_kikan_max)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'torihikiji_nenrei' as column_name, COUNT(*) as total_rows, COUNT(torihikiji_nenrei) as filled_count, ROUND(COUNT(torihikiji_nenrei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hs' as table_name, 'torihiki_kakaku' as column_name, COUNT(*) as total_rows, COUNT(torihiki_kakaku) as filled_count, ROUND(COUNT(torihiki_kakaku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hs
UNION ALL
SELECT 'jvd_hy' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_hy' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_hy' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_hy' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_hy' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_hy' as table_name, 'bamei_imi_yurai' as column_name, COUNT(*) as total_rows, COUNT(bamei_imi_yurai) as filled_count, ROUND(COUNT(bamei_imi_yurai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_hy
UNION ALL
SELECT 'jvd_jc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'umaban' as column_name, COUNT(*) as total_rows, COUNT(umaban) as filled_count, ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'futan_juryo' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo) as filled_count, ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishumei' as column_name, COUNT(*) as total_rows, COUNT(kishumei) as filled_count, ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishu_minarai_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code) as filled_count, ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'futan_juryo_henkomae' as column_name, COUNT(*) as total_rows, COUNT(futan_juryo_henkomae) as filled_count, ROUND(COUNT(futan_juryo_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishu_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishu_code_henkomae) as filled_count, ROUND(COUNT(kishu_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishumei_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishumei_henkomae) as filled_count, ROUND(COUNT(kishumei_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jc' as table_name, 'kishu_minarai_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code_henkomae) as filled_count, ROUND(COUNT(kishu_minarai_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jc
UNION ALL
SELECT 'jvd_jg' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'shutsuba_tohyo_uketsuke' as column_name, COUNT(*) as total_rows, COUNT(shutsuba_tohyo_uketsuke) as filled_count, ROUND(COUNT(shutsuba_tohyo_uketsuke)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'shusso_kubun' as column_name, COUNT(*) as total_rows, COUNT(shusso_kubun) as filled_count, ROUND(COUNT(shusso_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_jg' as table_name, 'jogai_jotai_kubun' as column_name, COUNT(*) as total_rows, COUNT(jogai_jotai_kubun) as filled_count, ROUND(COUNT(jogai_jotai_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_jg
UNION ALL
SELECT 'jvd_ks' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishu_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_code) as filled_count, ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'massho_kubun' as column_name, COUNT(*) as total_rows, COUNT(massho_kubun) as filled_count, ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'menkyo_kofu_nengappi' as column_name, COUNT(*) as total_rows, COUNT(menkyo_kofu_nengappi) as filled_count, ROUND(COUNT(menkyo_kofu_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'menkyo_massho_nengappi' as column_name, COUNT(*) as total_rows, COUNT(menkyo_massho_nengappi) as filled_count, ROUND(COUNT(menkyo_massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'seinengappi' as column_name, COUNT(*) as total_rows, COUNT(seinengappi) as filled_count, ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishumei' as column_name, COUNT(*) as total_rows, COUNT(kishumei) as filled_count, ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishumei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(kishumei_hankaku_kana) as filled_count, ROUND(COUNT(kishumei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishumei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(kishumei_ryakusho) as filled_count, ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishumei_eur' as column_name, COUNT(*) as total_rows, COUNT(kishumei_eur) as filled_count, ROUND(COUNT(kishumei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'seibetsu_kubun' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_kubun) as filled_count, ROUND(COUNT(seibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kijo_shikaku_code' as column_name, COUNT(*) as total_rows, COUNT(kijo_shikaku_code) as filled_count, ROUND(COUNT(kijo_shikaku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'kishu_minarai_code' as column_name, COUNT(*) as total_rows, COUNT(kishu_minarai_code) as filled_count, ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'tozai_shozoku_code' as column_name, COUNT(*) as total_rows, COUNT(tozai_shozoku_code) as filled_count, ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'shotai_chiikimei' as column_name, COUNT(*) as total_rows, COUNT(shotai_chiikimei) as filled_count, ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'chokyoshimei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_ryakusho) as filled_count, ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'hatsukijo_joho_1' as column_name, COUNT(*) as total_rows, COUNT(hatsukijo_joho_1) as filled_count, ROUND(COUNT(hatsukijo_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'hatsukijo_joho_2' as column_name, COUNT(*) as total_rows, COUNT(hatsukijo_joho_2) as filled_count, ROUND(COUNT(hatsukijo_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'hatsushori_joho_1' as column_name, COUNT(*) as total_rows, COUNT(hatsushori_joho_1) as filled_count, ROUND(COUNT(hatsushori_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'hatsushori_joho_2' as column_name, COUNT(*) as total_rows, COUNT(hatsushori_joho_2) as filled_count, ROUND(COUNT(hatsushori_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'jushoshori_joho_1' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_1) as filled_count, ROUND(COUNT(jushoshori_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'jushoshori_joho_2' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_2) as filled_count, ROUND(COUNT(jushoshori_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'jushoshori_joho_3' as column_name, COUNT(*) as total_rows, COUNT(jushoshori_joho_3) as filled_count, ROUND(COUNT(jushoshori_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'seiseki_joho_1' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_1) as filled_count, ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'seiseki_joho_2' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_2) as filled_count, ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_ks' as table_name, 'seiseki_joho_3' as column_name, COUNT(*) as total_rows, COUNT(seiseki_joho_3) as filled_count, ROUND(COUNT(seiseki_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ks
UNION ALL
SELECT 'jvd_o1' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hatsubai_flag_tansho' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_tansho) as filled_count, ROUND(COUNT(hatsubai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hatsubai_flag_fukusho' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_fukusho) as filled_count, ROUND(COUNT(hatsubai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hatsubai_flag_wakuren' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_wakuren) as filled_count, ROUND(COUNT(hatsubai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'fukusho_chakubarai_key' as column_name, COUNT(*) as total_rows, COUNT(fukusho_chakubarai_key) as filled_count, ROUND(COUNT(fukusho_chakubarai_key)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'odds_tansho' as column_name, COUNT(*) as total_rows, COUNT(odds_tansho) as filled_count, ROUND(COUNT(odds_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'odds_fukusho' as column_name, COUNT(*) as total_rows, COUNT(odds_fukusho) as filled_count, ROUND(COUNT(odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'odds_wakuren' as column_name, COUNT(*) as total_rows, COUNT(odds_wakuren) as filled_count, ROUND(COUNT(odds_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hyosu_gokei_tansho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_tansho) as filled_count, ROUND(COUNT(hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hyosu_gokei_fukusho' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_fukusho) as filled_count, ROUND(COUNT(hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o1' as table_name, 'hyosu_gokei_wakuren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_wakuren) as filled_count, ROUND(COUNT(hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o1
UNION ALL
SELECT 'jvd_o2' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'hatsubai_flag_umaren' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_umaren) as filled_count, ROUND(COUNT(hatsubai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'odds_umaren' as column_name, COUNT(*) as total_rows, COUNT(odds_umaren) as filled_count, ROUND(COUNT(odds_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o2' as table_name, 'hyosu_gokei_umaren' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_umaren) as filled_count, ROUND(COUNT(hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o2
UNION ALL
SELECT 'jvd_o3' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'hatsubai_flag_wide' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_wide) as filled_count, ROUND(COUNT(hatsubai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'odds_wide' as column_name, COUNT(*) as total_rows, COUNT(odds_wide) as filled_count, ROUND(COUNT(odds_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o3' as table_name, 'hyosu_gokei_wide' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_wide) as filled_count, ROUND(COUNT(hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o3
UNION ALL
SELECT 'jvd_o4' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'hatsubai_flag_umatan' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_umatan) as filled_count, ROUND(COUNT(hatsubai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'odds_umatan' as column_name, COUNT(*) as total_rows, COUNT(odds_umatan) as filled_count, ROUND(COUNT(odds_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o4' as table_name, 'hyosu_gokei_umatan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_umatan) as filled_count, ROUND(COUNT(hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o4
UNION ALL
SELECT 'jvd_o5' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'hatsubai_flag_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_sanrenpuku) as filled_count, ROUND(COUNT(hatsubai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'odds_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(odds_sanrenpuku) as filled_count, ROUND(COUNT(odds_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o5' as table_name, 'hyosu_gokei_sanrenpuku' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_sanrenpuku) as filled_count, ROUND(COUNT(hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o5
UNION ALL
SELECT 'jvd_o6' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'shusso_tosu' as column_name, COUNT(*) as total_rows, COUNT(shusso_tosu) as filled_count, ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'hatsubai_flag_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(hatsubai_flag_sanrentan) as filled_count, ROUND(COUNT(hatsubai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'odds_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(odds_sanrentan) as filled_count, ROUND(COUNT(odds_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
UNION ALL
SELECT 'jvd_o6' as table_name, 'hyosu_gokei_sanrentan' as column_name, COUNT(*) as total_rows, COUNT(hyosu_gokei_sanrentan) as filled_count, ROUND(COUNT(hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_o6
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
SELECT 'jvd_rc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_shikibetsu_kubun' as column_name, COUNT(*) as total_rows, COUNT(record_shikibetsu_kubun) as filled_count, ROUND(COUNT(record_shikibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'tokubetsu_kyoso_bango' as column_name, COUNT(*) as total_rows, COUNT(tokubetsu_kyoso_bango) as filled_count, ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kyosomei_hondai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_hondai) as filled_count, ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'grade_code' as column_name, COUNT(*) as total_rows, COUNT(grade_code) as filled_count, ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kyoso_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_shubetsu_code) as filled_count, ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_kubun' as column_name, COUNT(*) as total_rows, COUNT(record_kubun) as filled_count, ROUND(COUNT(record_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_time' as column_name, COUNT(*) as total_rows, COUNT(record_time) as filled_count, ROUND(COUNT(record_time)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'tenko_code' as column_name, COUNT(*) as total_rows, COUNT(tenko_code) as filled_count, ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'babajotai_code_shiba' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_shiba) as filled_count, ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'babajotai_code_dirt' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_dirt) as filled_count, ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_hojiuma_joho_1' as column_name, COUNT(*) as total_rows, COUNT(record_hojiuma_joho_1) as filled_count, ROUND(COUNT(record_hojiuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_hojiuma_joho_2' as column_name, COUNT(*) as total_rows, COUNT(record_hojiuma_joho_2) as filled_count, ROUND(COUNT(record_hojiuma_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
UNION ALL
SELECT 'jvd_rc' as table_name, 'record_hojiuma_joho_3' as column_name, COUNT(*) as total_rows, COUNT(record_hojiuma_joho_3) as filled_count, ROUND(COUNT(record_hojiuma_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_rc
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
UNION ALL
SELECT 'jvd_sk' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'seinengappi' as column_name, COUNT(*) as total_rows, COUNT(seinengappi) as filled_count, ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'seibetsu_code' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_code) as filled_count, ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'hinshu_code' as column_name, COUNT(*) as total_rows, COUNT(hinshu_code) as filled_count, ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'moshoku_code' as column_name, COUNT(*) as total_rows, COUNT(moshoku_code) as filled_count, ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'mochikomi_kubun' as column_name, COUNT(*) as total_rows, COUNT(mochikomi_kubun) as filled_count, ROUND(COUNT(mochikomi_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'yunyu_nen' as column_name, COUNT(*) as total_rows, COUNT(yunyu_nen) as filled_count, ROUND(COUNT(yunyu_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'seisansha_code' as column_name, COUNT(*) as total_rows, COUNT(seisansha_code) as filled_count, ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'sanchimei' as column_name, COUNT(*) as total_rows, COUNT(sanchimei) as filled_count, ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_01a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_01a) as filled_count, ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_02a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_02a) as filled_count, ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_03a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_03a) as filled_count, ROUND(COUNT(ketto_joho_03a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_04a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_04a) as filled_count, ROUND(COUNT(ketto_joho_04a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_05a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_05a) as filled_count, ROUND(COUNT(ketto_joho_05a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_06a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_06a) as filled_count, ROUND(COUNT(ketto_joho_06a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_07a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_07a) as filled_count, ROUND(COUNT(ketto_joho_07a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_08a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_08a) as filled_count, ROUND(COUNT(ketto_joho_08a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_09a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_09a) as filled_count, ROUND(COUNT(ketto_joho_09a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_10a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_10a) as filled_count, ROUND(COUNT(ketto_joho_10a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_11a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_11a) as filled_count, ROUND(COUNT(ketto_joho_11a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_12a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_12a) as filled_count, ROUND(COUNT(ketto_joho_12a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_13a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_13a) as filled_count, ROUND(COUNT(ketto_joho_13a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_sk' as table_name, 'ketto_joho_14a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_14a) as filled_count, ROUND(COUNT(ketto_joho_14a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_sk
UNION ALL
SELECT 'jvd_tc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'hasso_jikoku' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku) as filled_count, ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tc' as table_name, 'hasso_jikoku_henkomae' as column_name, COUNT(*) as total_rows, COUNT(hasso_jikoku_henkomae) as filled_count, ROUND(COUNT(hasso_jikoku_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tc
UNION ALL
SELECT 'jvd_tk' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'yobi_code' as column_name, COUNT(*) as total_rows, COUNT(yobi_code) as filled_count, ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'tokubetsu_kyoso_bango' as column_name, COUNT(*) as total_rows, COUNT(tokubetsu_kyoso_bango) as filled_count, ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_hondai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_hondai) as filled_count, ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_fukudai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_fukudai) as filled_count, ROUND(COUNT(kyosomei_fukudai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_kakkonai' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kakkonai) as filled_count, ROUND(COUNT(kyosomei_kakkonai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_hondai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_hondai_eur) as filled_count, ROUND(COUNT(kyosomei_hondai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_fukudai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_fukudai_eur) as filled_count, ROUND(COUNT(kyosomei_fukudai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_kakkonai_eur' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kakkonai_eur) as filled_count, ROUND(COUNT(kyosomei_kakkonai_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_ryakusho_10' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_10) as filled_count, ROUND(COUNT(kyosomei_ryakusho_10)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_ryakusho_6' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_6) as filled_count, ROUND(COUNT(kyosomei_ryakusho_6)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_ryakusho_3' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_ryakusho_3) as filled_count, ROUND(COUNT(kyosomei_ryakusho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyosomei_kubun' as column_name, COUNT(*) as total_rows, COUNT(kyosomei_kubun) as filled_count, ROUND(COUNT(kyosomei_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'jusho_kaiji' as column_name, COUNT(*) as total_rows, COUNT(jusho_kaiji) as filled_count, ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'grade_code' as column_name, COUNT(*) as total_rows, COUNT(grade_code) as filled_count, ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_shubetsu_code) as filled_count, ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_kigo_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_kigo_code) as filled_count, ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'juryo_shubetsu_code' as column_name, COUNT(*) as total_rows, COUNT(juryo_shubetsu_code) as filled_count, ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_joken_code_2sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_2sai) as filled_count, ROUND(COUNT(kyoso_joken_code_2sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_joken_code_3sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_3sai) as filled_count, ROUND(COUNT(kyoso_joken_code_3sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_joken_code_4sai' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_4sai) as filled_count, ROUND(COUNT(kyoso_joken_code_4sai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_joken_code_5sai_ijo' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code_5sai_ijo) as filled_count, ROUND(COUNT(kyoso_joken_code_5sai_ijo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyoso_joken_code' as column_name, COUNT(*) as total_rows, COUNT(kyoso_joken_code) as filled_count, ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'kyori' as column_name, COUNT(*) as total_rows, COUNT(kyori) as filled_count, ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'track_code' as column_name, COUNT(*) as total_rows, COUNT(track_code) as filled_count, ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'course_kubun' as column_name, COUNT(*) as total_rows, COUNT(course_kubun) as filled_count, ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'handicap_happyobi' as column_name, COUNT(*) as total_rows, COUNT(handicap_happyobi) as filled_count, ROUND(COUNT(handicap_happyobi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'toroku_tosu' as column_name, COUNT(*) as total_rows, COUNT(toroku_tosu) as filled_count, ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_001' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_001) as filled_count, ROUND(COUNT(torokuba_joho_001)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_002' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_002) as filled_count, ROUND(COUNT(torokuba_joho_002)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_003' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_003) as filled_count, ROUND(COUNT(torokuba_joho_003)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_004' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_004) as filled_count, ROUND(COUNT(torokuba_joho_004)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_005' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_005) as filled_count, ROUND(COUNT(torokuba_joho_005)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_006' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_006) as filled_count, ROUND(COUNT(torokuba_joho_006)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_007' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_007) as filled_count, ROUND(COUNT(torokuba_joho_007)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_008' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_008) as filled_count, ROUND(COUNT(torokuba_joho_008)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_009' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_009) as filled_count, ROUND(COUNT(torokuba_joho_009)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_010' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_010) as filled_count, ROUND(COUNT(torokuba_joho_010)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_011' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_011) as filled_count, ROUND(COUNT(torokuba_joho_011)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_012' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_012) as filled_count, ROUND(COUNT(torokuba_joho_012)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_013' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_013) as filled_count, ROUND(COUNT(torokuba_joho_013)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_014' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_014) as filled_count, ROUND(COUNT(torokuba_joho_014)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_015' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_015) as filled_count, ROUND(COUNT(torokuba_joho_015)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_016' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_016) as filled_count, ROUND(COUNT(torokuba_joho_016)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_017' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_017) as filled_count, ROUND(COUNT(torokuba_joho_017)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_018' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_018) as filled_count, ROUND(COUNT(torokuba_joho_018)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_019' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_019) as filled_count, ROUND(COUNT(torokuba_joho_019)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_020' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_020) as filled_count, ROUND(COUNT(torokuba_joho_020)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_021' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_021) as filled_count, ROUND(COUNT(torokuba_joho_021)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_022' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_022) as filled_count, ROUND(COUNT(torokuba_joho_022)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_023' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_023) as filled_count, ROUND(COUNT(torokuba_joho_023)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_024' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_024) as filled_count, ROUND(COUNT(torokuba_joho_024)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_025' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_025) as filled_count, ROUND(COUNT(torokuba_joho_025)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_026' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_026) as filled_count, ROUND(COUNT(torokuba_joho_026)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_027' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_027) as filled_count, ROUND(COUNT(torokuba_joho_027)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_028' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_028) as filled_count, ROUND(COUNT(torokuba_joho_028)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_029' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_029) as filled_count, ROUND(COUNT(torokuba_joho_029)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_030' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_030) as filled_count, ROUND(COUNT(torokuba_joho_030)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_031' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_031) as filled_count, ROUND(COUNT(torokuba_joho_031)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_032' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_032) as filled_count, ROUND(COUNT(torokuba_joho_032)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_033' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_033) as filled_count, ROUND(COUNT(torokuba_joho_033)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_034' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_034) as filled_count, ROUND(COUNT(torokuba_joho_034)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_035' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_035) as filled_count, ROUND(COUNT(torokuba_joho_035)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_036' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_036) as filled_count, ROUND(COUNT(torokuba_joho_036)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_037' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_037) as filled_count, ROUND(COUNT(torokuba_joho_037)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_038' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_038) as filled_count, ROUND(COUNT(torokuba_joho_038)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_039' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_039) as filled_count, ROUND(COUNT(torokuba_joho_039)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_040' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_040) as filled_count, ROUND(COUNT(torokuba_joho_040)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_041' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_041) as filled_count, ROUND(COUNT(torokuba_joho_041)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_042' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_042) as filled_count, ROUND(COUNT(torokuba_joho_042)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_043' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_043) as filled_count, ROUND(COUNT(torokuba_joho_043)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_044' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_044) as filled_count, ROUND(COUNT(torokuba_joho_044)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_045' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_045) as filled_count, ROUND(COUNT(torokuba_joho_045)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_046' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_046) as filled_count, ROUND(COUNT(torokuba_joho_046)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_047' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_047) as filled_count, ROUND(COUNT(torokuba_joho_047)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_048' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_048) as filled_count, ROUND(COUNT(torokuba_joho_048)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_049' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_049) as filled_count, ROUND(COUNT(torokuba_joho_049)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_050' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_050) as filled_count, ROUND(COUNT(torokuba_joho_050)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_051' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_051) as filled_count, ROUND(COUNT(torokuba_joho_051)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_052' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_052) as filled_count, ROUND(COUNT(torokuba_joho_052)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_053' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_053) as filled_count, ROUND(COUNT(torokuba_joho_053)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_054' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_054) as filled_count, ROUND(COUNT(torokuba_joho_054)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_055' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_055) as filled_count, ROUND(COUNT(torokuba_joho_055)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_056' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_056) as filled_count, ROUND(COUNT(torokuba_joho_056)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_057' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_057) as filled_count, ROUND(COUNT(torokuba_joho_057)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_058' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_058) as filled_count, ROUND(COUNT(torokuba_joho_058)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_059' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_059) as filled_count, ROUND(COUNT(torokuba_joho_059)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_060' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_060) as filled_count, ROUND(COUNT(torokuba_joho_060)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_061' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_061) as filled_count, ROUND(COUNT(torokuba_joho_061)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_062' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_062) as filled_count, ROUND(COUNT(torokuba_joho_062)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_063' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_063) as filled_count, ROUND(COUNT(torokuba_joho_063)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_064' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_064) as filled_count, ROUND(COUNT(torokuba_joho_064)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_065' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_065) as filled_count, ROUND(COUNT(torokuba_joho_065)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_066' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_066) as filled_count, ROUND(COUNT(torokuba_joho_066)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_067' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_067) as filled_count, ROUND(COUNT(torokuba_joho_067)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_068' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_068) as filled_count, ROUND(COUNT(torokuba_joho_068)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_069' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_069) as filled_count, ROUND(COUNT(torokuba_joho_069)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_070' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_070) as filled_count, ROUND(COUNT(torokuba_joho_070)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_071' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_071) as filled_count, ROUND(COUNT(torokuba_joho_071)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_072' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_072) as filled_count, ROUND(COUNT(torokuba_joho_072)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_073' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_073) as filled_count, ROUND(COUNT(torokuba_joho_073)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_074' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_074) as filled_count, ROUND(COUNT(torokuba_joho_074)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_075' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_075) as filled_count, ROUND(COUNT(torokuba_joho_075)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_076' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_076) as filled_count, ROUND(COUNT(torokuba_joho_076)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_077' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_077) as filled_count, ROUND(COUNT(torokuba_joho_077)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_078' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_078) as filled_count, ROUND(COUNT(torokuba_joho_078)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_079' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_079) as filled_count, ROUND(COUNT(torokuba_joho_079)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_080' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_080) as filled_count, ROUND(COUNT(torokuba_joho_080)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_081' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_081) as filled_count, ROUND(COUNT(torokuba_joho_081)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_082' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_082) as filled_count, ROUND(COUNT(torokuba_joho_082)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_083' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_083) as filled_count, ROUND(COUNT(torokuba_joho_083)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_084' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_084) as filled_count, ROUND(COUNT(torokuba_joho_084)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_085' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_085) as filled_count, ROUND(COUNT(torokuba_joho_085)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_086' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_086) as filled_count, ROUND(COUNT(torokuba_joho_086)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_087' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_087) as filled_count, ROUND(COUNT(torokuba_joho_087)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_088' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_088) as filled_count, ROUND(COUNT(torokuba_joho_088)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_089' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_089) as filled_count, ROUND(COUNT(torokuba_joho_089)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_090' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_090) as filled_count, ROUND(COUNT(torokuba_joho_090)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_091' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_091) as filled_count, ROUND(COUNT(torokuba_joho_091)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_092' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_092) as filled_count, ROUND(COUNT(torokuba_joho_092)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_093' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_093) as filled_count, ROUND(COUNT(torokuba_joho_093)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_094' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_094) as filled_count, ROUND(COUNT(torokuba_joho_094)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_095' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_095) as filled_count, ROUND(COUNT(torokuba_joho_095)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_096' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_096) as filled_count, ROUND(COUNT(torokuba_joho_096)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_097' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_097) as filled_count, ROUND(COUNT(torokuba_joho_097)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_098' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_098) as filled_count, ROUND(COUNT(torokuba_joho_098)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_099' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_099) as filled_count, ROUND(COUNT(torokuba_joho_099)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_100' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_100) as filled_count, ROUND(COUNT(torokuba_joho_100)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_101' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_101) as filled_count, ROUND(COUNT(torokuba_joho_101)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_102' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_102) as filled_count, ROUND(COUNT(torokuba_joho_102)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_103' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_103) as filled_count, ROUND(COUNT(torokuba_joho_103)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_104' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_104) as filled_count, ROUND(COUNT(torokuba_joho_104)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_105' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_105) as filled_count, ROUND(COUNT(torokuba_joho_105)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_106' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_106) as filled_count, ROUND(COUNT(torokuba_joho_106)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_107' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_107) as filled_count, ROUND(COUNT(torokuba_joho_107)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_108' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_108) as filled_count, ROUND(COUNT(torokuba_joho_108)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_109' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_109) as filled_count, ROUND(COUNT(torokuba_joho_109)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_110' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_110) as filled_count, ROUND(COUNT(torokuba_joho_110)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_111' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_111) as filled_count, ROUND(COUNT(torokuba_joho_111)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_112' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_112) as filled_count, ROUND(COUNT(torokuba_joho_112)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_113' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_113) as filled_count, ROUND(COUNT(torokuba_joho_113)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_114' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_114) as filled_count, ROUND(COUNT(torokuba_joho_114)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_115' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_115) as filled_count, ROUND(COUNT(torokuba_joho_115)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_116' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_116) as filled_count, ROUND(COUNT(torokuba_joho_116)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_117' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_117) as filled_count, ROUND(COUNT(torokuba_joho_117)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_118' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_118) as filled_count, ROUND(COUNT(torokuba_joho_118)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_119' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_119) as filled_count, ROUND(COUNT(torokuba_joho_119)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_120' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_120) as filled_count, ROUND(COUNT(torokuba_joho_120)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_121' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_121) as filled_count, ROUND(COUNT(torokuba_joho_121)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_122' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_122) as filled_count, ROUND(COUNT(torokuba_joho_122)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_123' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_123) as filled_count, ROUND(COUNT(torokuba_joho_123)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_124' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_124) as filled_count, ROUND(COUNT(torokuba_joho_124)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_125' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_125) as filled_count, ROUND(COUNT(torokuba_joho_125)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_126' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_126) as filled_count, ROUND(COUNT(torokuba_joho_126)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_127' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_127) as filled_count, ROUND(COUNT(torokuba_joho_127)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_128' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_128) as filled_count, ROUND(COUNT(torokuba_joho_128)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_129' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_129) as filled_count, ROUND(COUNT(torokuba_joho_129)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_130' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_130) as filled_count, ROUND(COUNT(torokuba_joho_130)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_131' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_131) as filled_count, ROUND(COUNT(torokuba_joho_131)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_132' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_132) as filled_count, ROUND(COUNT(torokuba_joho_132)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_133' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_133) as filled_count, ROUND(COUNT(torokuba_joho_133)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_134' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_134) as filled_count, ROUND(COUNT(torokuba_joho_134)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_135' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_135) as filled_count, ROUND(COUNT(torokuba_joho_135)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_136' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_136) as filled_count, ROUND(COUNT(torokuba_joho_136)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_137' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_137) as filled_count, ROUND(COUNT(torokuba_joho_137)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_138' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_138) as filled_count, ROUND(COUNT(torokuba_joho_138)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_139' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_139) as filled_count, ROUND(COUNT(torokuba_joho_139)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_140' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_140) as filled_count, ROUND(COUNT(torokuba_joho_140)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_141' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_141) as filled_count, ROUND(COUNT(torokuba_joho_141)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_142' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_142) as filled_count, ROUND(COUNT(torokuba_joho_142)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_143' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_143) as filled_count, ROUND(COUNT(torokuba_joho_143)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_144' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_144) as filled_count, ROUND(COUNT(torokuba_joho_144)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_145' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_145) as filled_count, ROUND(COUNT(torokuba_joho_145)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_146' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_146) as filled_count, ROUND(COUNT(torokuba_joho_146)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_147' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_147) as filled_count, ROUND(COUNT(torokuba_joho_147)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_148' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_148) as filled_count, ROUND(COUNT(torokuba_joho_148)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_149' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_149) as filled_count, ROUND(COUNT(torokuba_joho_149)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_150' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_150) as filled_count, ROUND(COUNT(torokuba_joho_150)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_151' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_151) as filled_count, ROUND(COUNT(torokuba_joho_151)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_152' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_152) as filled_count, ROUND(COUNT(torokuba_joho_152)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_153' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_153) as filled_count, ROUND(COUNT(torokuba_joho_153)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_154' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_154) as filled_count, ROUND(COUNT(torokuba_joho_154)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_155' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_155) as filled_count, ROUND(COUNT(torokuba_joho_155)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_156' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_156) as filled_count, ROUND(COUNT(torokuba_joho_156)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_157' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_157) as filled_count, ROUND(COUNT(torokuba_joho_157)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_158' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_158) as filled_count, ROUND(COUNT(torokuba_joho_158)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_159' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_159) as filled_count, ROUND(COUNT(torokuba_joho_159)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_160' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_160) as filled_count, ROUND(COUNT(torokuba_joho_160)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_161' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_161) as filled_count, ROUND(COUNT(torokuba_joho_161)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_162' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_162) as filled_count, ROUND(COUNT(torokuba_joho_162)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_163' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_163) as filled_count, ROUND(COUNT(torokuba_joho_163)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_164' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_164) as filled_count, ROUND(COUNT(torokuba_joho_164)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_165' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_165) as filled_count, ROUND(COUNT(torokuba_joho_165)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_166' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_166) as filled_count, ROUND(COUNT(torokuba_joho_166)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_167' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_167) as filled_count, ROUND(COUNT(torokuba_joho_167)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_168' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_168) as filled_count, ROUND(COUNT(torokuba_joho_168)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_169' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_169) as filled_count, ROUND(COUNT(torokuba_joho_169)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_170' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_170) as filled_count, ROUND(COUNT(torokuba_joho_170)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_171' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_171) as filled_count, ROUND(COUNT(torokuba_joho_171)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_172' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_172) as filled_count, ROUND(COUNT(torokuba_joho_172)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_173' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_173) as filled_count, ROUND(COUNT(torokuba_joho_173)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_174' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_174) as filled_count, ROUND(COUNT(torokuba_joho_174)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_175' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_175) as filled_count, ROUND(COUNT(torokuba_joho_175)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_176' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_176) as filled_count, ROUND(COUNT(torokuba_joho_176)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_177' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_177) as filled_count, ROUND(COUNT(torokuba_joho_177)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_178' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_178) as filled_count, ROUND(COUNT(torokuba_joho_178)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_179' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_179) as filled_count, ROUND(COUNT(torokuba_joho_179)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_180' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_180) as filled_count, ROUND(COUNT(torokuba_joho_180)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_181' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_181) as filled_count, ROUND(COUNT(torokuba_joho_181)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_182' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_182) as filled_count, ROUND(COUNT(torokuba_joho_182)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_183' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_183) as filled_count, ROUND(COUNT(torokuba_joho_183)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_184' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_184) as filled_count, ROUND(COUNT(torokuba_joho_184)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_185' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_185) as filled_count, ROUND(COUNT(torokuba_joho_185)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_186' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_186) as filled_count, ROUND(COUNT(torokuba_joho_186)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_187' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_187) as filled_count, ROUND(COUNT(torokuba_joho_187)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_188' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_188) as filled_count, ROUND(COUNT(torokuba_joho_188)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_189' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_189) as filled_count, ROUND(COUNT(torokuba_joho_189)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_190' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_190) as filled_count, ROUND(COUNT(torokuba_joho_190)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_191' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_191) as filled_count, ROUND(COUNT(torokuba_joho_191)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_192' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_192) as filled_count, ROUND(COUNT(torokuba_joho_192)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_193' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_193) as filled_count, ROUND(COUNT(torokuba_joho_193)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_194' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_194) as filled_count, ROUND(COUNT(torokuba_joho_194)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_195' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_195) as filled_count, ROUND(COUNT(torokuba_joho_195)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_196' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_196) as filled_count, ROUND(COUNT(torokuba_joho_196)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_197' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_197) as filled_count, ROUND(COUNT(torokuba_joho_197)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_198' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_198) as filled_count, ROUND(COUNT(torokuba_joho_198)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_199' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_199) as filled_count, ROUND(COUNT(torokuba_joho_199)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_200' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_200) as filled_count, ROUND(COUNT(torokuba_joho_200)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_201' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_201) as filled_count, ROUND(COUNT(torokuba_joho_201)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_202' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_202) as filled_count, ROUND(COUNT(torokuba_joho_202)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_203' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_203) as filled_count, ROUND(COUNT(torokuba_joho_203)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_204' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_204) as filled_count, ROUND(COUNT(torokuba_joho_204)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_205' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_205) as filled_count, ROUND(COUNT(torokuba_joho_205)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_206' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_206) as filled_count, ROUND(COUNT(torokuba_joho_206)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_207' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_207) as filled_count, ROUND(COUNT(torokuba_joho_207)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_208' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_208) as filled_count, ROUND(COUNT(torokuba_joho_208)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_209' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_209) as filled_count, ROUND(COUNT(torokuba_joho_209)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_210' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_210) as filled_count, ROUND(COUNT(torokuba_joho_210)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_211' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_211) as filled_count, ROUND(COUNT(torokuba_joho_211)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_212' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_212) as filled_count, ROUND(COUNT(torokuba_joho_212)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_213' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_213) as filled_count, ROUND(COUNT(torokuba_joho_213)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_214' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_214) as filled_count, ROUND(COUNT(torokuba_joho_214)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_215' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_215) as filled_count, ROUND(COUNT(torokuba_joho_215)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_216' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_216) as filled_count, ROUND(COUNT(torokuba_joho_216)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_217' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_217) as filled_count, ROUND(COUNT(torokuba_joho_217)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_218' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_218) as filled_count, ROUND(COUNT(torokuba_joho_218)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_219' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_219) as filled_count, ROUND(COUNT(torokuba_joho_219)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_220' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_220) as filled_count, ROUND(COUNT(torokuba_joho_220)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_221' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_221) as filled_count, ROUND(COUNT(torokuba_joho_221)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_222' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_222) as filled_count, ROUND(COUNT(torokuba_joho_222)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_223' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_223) as filled_count, ROUND(COUNT(torokuba_joho_223)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_224' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_224) as filled_count, ROUND(COUNT(torokuba_joho_224)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_225' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_225) as filled_count, ROUND(COUNT(torokuba_joho_225)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_226' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_226) as filled_count, ROUND(COUNT(torokuba_joho_226)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_227' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_227) as filled_count, ROUND(COUNT(torokuba_joho_227)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_228' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_228) as filled_count, ROUND(COUNT(torokuba_joho_228)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_229' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_229) as filled_count, ROUND(COUNT(torokuba_joho_229)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_230' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_230) as filled_count, ROUND(COUNT(torokuba_joho_230)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_231' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_231) as filled_count, ROUND(COUNT(torokuba_joho_231)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_232' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_232) as filled_count, ROUND(COUNT(torokuba_joho_232)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_233' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_233) as filled_count, ROUND(COUNT(torokuba_joho_233)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_234' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_234) as filled_count, ROUND(COUNT(torokuba_joho_234)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_235' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_235) as filled_count, ROUND(COUNT(torokuba_joho_235)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_236' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_236) as filled_count, ROUND(COUNT(torokuba_joho_236)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_237' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_237) as filled_count, ROUND(COUNT(torokuba_joho_237)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_238' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_238) as filled_count, ROUND(COUNT(torokuba_joho_238)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_239' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_239) as filled_count, ROUND(COUNT(torokuba_joho_239)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_240' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_240) as filled_count, ROUND(COUNT(torokuba_joho_240)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_241' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_241) as filled_count, ROUND(COUNT(torokuba_joho_241)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_242' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_242) as filled_count, ROUND(COUNT(torokuba_joho_242)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_243' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_243) as filled_count, ROUND(COUNT(torokuba_joho_243)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_244' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_244) as filled_count, ROUND(COUNT(torokuba_joho_244)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_245' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_245) as filled_count, ROUND(COUNT(torokuba_joho_245)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_246' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_246) as filled_count, ROUND(COUNT(torokuba_joho_246)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_247' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_247) as filled_count, ROUND(COUNT(torokuba_joho_247)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_248' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_248) as filled_count, ROUND(COUNT(torokuba_joho_248)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_249' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_249) as filled_count, ROUND(COUNT(torokuba_joho_249)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_250' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_250) as filled_count, ROUND(COUNT(torokuba_joho_250)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_251' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_251) as filled_count, ROUND(COUNT(torokuba_joho_251)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_252' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_252) as filled_count, ROUND(COUNT(torokuba_joho_252)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_253' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_253) as filled_count, ROUND(COUNT(torokuba_joho_253)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_254' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_254) as filled_count, ROUND(COUNT(torokuba_joho_254)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_255' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_255) as filled_count, ROUND(COUNT(torokuba_joho_255)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_256' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_256) as filled_count, ROUND(COUNT(torokuba_joho_256)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_257' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_257) as filled_count, ROUND(COUNT(torokuba_joho_257)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_258' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_258) as filled_count, ROUND(COUNT(torokuba_joho_258)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_259' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_259) as filled_count, ROUND(COUNT(torokuba_joho_259)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_260' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_260) as filled_count, ROUND(COUNT(torokuba_joho_260)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_261' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_261) as filled_count, ROUND(COUNT(torokuba_joho_261)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_262' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_262) as filled_count, ROUND(COUNT(torokuba_joho_262)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_263' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_263) as filled_count, ROUND(COUNT(torokuba_joho_263)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_264' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_264) as filled_count, ROUND(COUNT(torokuba_joho_264)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_265' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_265) as filled_count, ROUND(COUNT(torokuba_joho_265)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_266' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_266) as filled_count, ROUND(COUNT(torokuba_joho_266)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_267' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_267) as filled_count, ROUND(COUNT(torokuba_joho_267)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_268' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_268) as filled_count, ROUND(COUNT(torokuba_joho_268)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_269' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_269) as filled_count, ROUND(COUNT(torokuba_joho_269)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_270' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_270) as filled_count, ROUND(COUNT(torokuba_joho_270)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_271' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_271) as filled_count, ROUND(COUNT(torokuba_joho_271)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_272' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_272) as filled_count, ROUND(COUNT(torokuba_joho_272)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_273' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_273) as filled_count, ROUND(COUNT(torokuba_joho_273)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_274' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_274) as filled_count, ROUND(COUNT(torokuba_joho_274)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_275' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_275) as filled_count, ROUND(COUNT(torokuba_joho_275)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_276' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_276) as filled_count, ROUND(COUNT(torokuba_joho_276)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_277' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_277) as filled_count, ROUND(COUNT(torokuba_joho_277)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_278' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_278) as filled_count, ROUND(COUNT(torokuba_joho_278)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_279' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_279) as filled_count, ROUND(COUNT(torokuba_joho_279)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_280' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_280) as filled_count, ROUND(COUNT(torokuba_joho_280)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_281' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_281) as filled_count, ROUND(COUNT(torokuba_joho_281)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_282' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_282) as filled_count, ROUND(COUNT(torokuba_joho_282)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_283' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_283) as filled_count, ROUND(COUNT(torokuba_joho_283)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_284' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_284) as filled_count, ROUND(COUNT(torokuba_joho_284)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_285' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_285) as filled_count, ROUND(COUNT(torokuba_joho_285)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_286' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_286) as filled_count, ROUND(COUNT(torokuba_joho_286)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_287' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_287) as filled_count, ROUND(COUNT(torokuba_joho_287)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_288' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_288) as filled_count, ROUND(COUNT(torokuba_joho_288)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_289' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_289) as filled_count, ROUND(COUNT(torokuba_joho_289)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_290' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_290) as filled_count, ROUND(COUNT(torokuba_joho_290)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_291' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_291) as filled_count, ROUND(COUNT(torokuba_joho_291)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_292' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_292) as filled_count, ROUND(COUNT(torokuba_joho_292)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_293' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_293) as filled_count, ROUND(COUNT(torokuba_joho_293)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_294' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_294) as filled_count, ROUND(COUNT(torokuba_joho_294)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_295' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_295) as filled_count, ROUND(COUNT(torokuba_joho_295)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_296' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_296) as filled_count, ROUND(COUNT(torokuba_joho_296)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_297' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_297) as filled_count, ROUND(COUNT(torokuba_joho_297)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_298' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_298) as filled_count, ROUND(COUNT(torokuba_joho_298)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_299' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_299) as filled_count, ROUND(COUNT(torokuba_joho_299)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tk' as table_name, 'torokuba_joho_300' as column_name, COUNT(*) as total_rows, COUNT(torokuba_joho_300) as filled_count, ROUND(COUNT(torokuba_joho_300)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tk
UNION ALL
SELECT 'jvd_tm' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'data_sakusei_jifun' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_jifun) as filled_count, ROUND(COUNT(data_sakusei_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_01' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_01) as filled_count, ROUND(COUNT(mining_yoso_01)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_02' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_02) as filled_count, ROUND(COUNT(mining_yoso_02)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_03' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_03) as filled_count, ROUND(COUNT(mining_yoso_03)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_04' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_04) as filled_count, ROUND(COUNT(mining_yoso_04)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_05' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_05) as filled_count, ROUND(COUNT(mining_yoso_05)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_06' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_06) as filled_count, ROUND(COUNT(mining_yoso_06)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_07' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_07) as filled_count, ROUND(COUNT(mining_yoso_07)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_08' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_08) as filled_count, ROUND(COUNT(mining_yoso_08)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_09' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_09) as filled_count, ROUND(COUNT(mining_yoso_09)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_10' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_10) as filled_count, ROUND(COUNT(mining_yoso_10)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_11' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_11) as filled_count, ROUND(COUNT(mining_yoso_11)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_12' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_12) as filled_count, ROUND(COUNT(mining_yoso_12)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_13' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_13) as filled_count, ROUND(COUNT(mining_yoso_13)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_14' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_14) as filled_count, ROUND(COUNT(mining_yoso_14)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_15' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_15) as filled_count, ROUND(COUNT(mining_yoso_15)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_16' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_16) as filled_count, ROUND(COUNT(mining_yoso_16)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_17' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_17) as filled_count, ROUND(COUNT(mining_yoso_17)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_tm' as table_name, 'mining_yoso_18' as column_name, COUNT(*) as total_rows, COUNT(mining_yoso_18) as filled_count, ROUND(COUNT(mining_yoso_18)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_tm
UNION ALL
SELECT 'jvd_um' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'massho_kubun' as column_name, COUNT(*) as total_rows, COUNT(massho_kubun) as filled_count, ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'toroku_nengappi' as column_name, COUNT(*) as total_rows, COUNT(toroku_nengappi) as filled_count, ROUND(COUNT(toroku_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'massho_nengappi' as column_name, COUNT(*) as total_rows, COUNT(massho_nengappi) as filled_count, ROUND(COUNT(massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'seinengappi' as column_name, COUNT(*) as total_rows, COUNT(seinengappi) as filled_count, ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'bamei' as column_name, COUNT(*) as total_rows, COUNT(bamei) as filled_count, ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'bamei_hankaku_kana' as column_name, COUNT(*) as total_rows, COUNT(bamei_hankaku_kana) as filled_count, ROUND(COUNT(bamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'bamei_eur' as column_name, COUNT(*) as total_rows, COUNT(bamei_eur) as filled_count, ROUND(COUNT(bamei_eur)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'zaikyu_flag' as column_name, COUNT(*) as total_rows, COUNT(zaikyu_flag) as filled_count, ROUND(COUNT(zaikyu_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'umakigo_code' as column_name, COUNT(*) as total_rows, COUNT(umakigo_code) as filled_count, ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'seibetsu_code' as column_name, COUNT(*) as total_rows, COUNT(seibetsu_code) as filled_count, ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'hinshu_code' as column_name, COUNT(*) as total_rows, COUNT(hinshu_code) as filled_count, ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'moshoku_code' as column_name, COUNT(*) as total_rows, COUNT(moshoku_code) as filled_count, ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_01a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_01a) as filled_count, ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_01b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_01b) as filled_count, ROUND(COUNT(ketto_joho_01b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_02a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_02a) as filled_count, ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_02b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_02b) as filled_count, ROUND(COUNT(ketto_joho_02b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_03a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_03a) as filled_count, ROUND(COUNT(ketto_joho_03a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_03b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_03b) as filled_count, ROUND(COUNT(ketto_joho_03b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_04a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_04a) as filled_count, ROUND(COUNT(ketto_joho_04a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_04b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_04b) as filled_count, ROUND(COUNT(ketto_joho_04b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_05a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_05a) as filled_count, ROUND(COUNT(ketto_joho_05a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_05b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_05b) as filled_count, ROUND(COUNT(ketto_joho_05b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_06a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_06a) as filled_count, ROUND(COUNT(ketto_joho_06a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_06b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_06b) as filled_count, ROUND(COUNT(ketto_joho_06b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_07a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_07a) as filled_count, ROUND(COUNT(ketto_joho_07a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_07b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_07b) as filled_count, ROUND(COUNT(ketto_joho_07b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_08a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_08a) as filled_count, ROUND(COUNT(ketto_joho_08a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_08b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_08b) as filled_count, ROUND(COUNT(ketto_joho_08b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_09a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_09a) as filled_count, ROUND(COUNT(ketto_joho_09a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_09b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_09b) as filled_count, ROUND(COUNT(ketto_joho_09b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_10a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_10a) as filled_count, ROUND(COUNT(ketto_joho_10a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_10b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_10b) as filled_count, ROUND(COUNT(ketto_joho_10b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_11a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_11a) as filled_count, ROUND(COUNT(ketto_joho_11a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_11b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_11b) as filled_count, ROUND(COUNT(ketto_joho_11b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_12a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_12a) as filled_count, ROUND(COUNT(ketto_joho_12a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_12b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_12b) as filled_count, ROUND(COUNT(ketto_joho_12b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_13a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_13a) as filled_count, ROUND(COUNT(ketto_joho_13a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_13b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_13b) as filled_count, ROUND(COUNT(ketto_joho_13b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_14a' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_14a) as filled_count, ROUND(COUNT(ketto_joho_14a)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'ketto_joho_14b' as column_name, COUNT(*) as total_rows, COUNT(ketto_joho_14b) as filled_count, ROUND(COUNT(ketto_joho_14b)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'tozai_shozoku_code' as column_name, COUNT(*) as total_rows, COUNT(tozai_shozoku_code) as filled_count, ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'chokyoshi_code' as column_name, COUNT(*) as total_rows, COUNT(chokyoshi_code) as filled_count, ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'chokyoshimei_ryakusho' as column_name, COUNT(*) as total_rows, COUNT(chokyoshimei_ryakusho) as filled_count, ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shotai_chiikimei' as column_name, COUNT(*) as total_rows, COUNT(shotai_chiikimei) as filled_count, ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'seisansha_code' as column_name, COUNT(*) as total_rows, COUNT(seisansha_code) as filled_count, ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'seisanshamei' as column_name, COUNT(*) as total_rows, COUNT(seisanshamei) as filled_count, ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'sanchimei' as column_name, COUNT(*) as total_rows, COUNT(sanchimei) as filled_count, ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'banushi_code' as column_name, COUNT(*) as total_rows, COUNT(banushi_code) as filled_count, ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'banushimei' as column_name, COUNT(*) as total_rows, COUNT(banushimei) as filled_count, ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'heichi_honshokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_honshokin_ruikei) as filled_count, ROUND(COUNT(heichi_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_honshokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_honshokin_ruikei) as filled_count, ROUND(COUNT(shogai_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'heichi_fukashokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_fukashokin_ruikei) as filled_count, ROUND(COUNT(heichi_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_fukashokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_fukashokin_ruikei) as filled_count, ROUND(COUNT(shogai_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'heichi_shutokushokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(heichi_shutokushokin_ruikei) as filled_count, ROUND(COUNT(heichi_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_shutokushokin_ruikei' as column_name, COUNT(*) as total_rows, COUNT(shogai_shutokushokin_ruikei) as filled_count, ROUND(COUNT(shogai_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'sogo' as column_name, COUNT(*) as total_rows, COUNT(sogo) as filled_count, ROUND(COUNT(sogo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'chuo_gokei' as column_name, COUNT(*) as total_rows, COUNT(chuo_gokei) as filled_count, ROUND(COUNT(chuo_gokei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_choku' as column_name, COUNT(*) as total_rows, COUNT(shiba_choku) as filled_count, ROUND(COUNT(shiba_choku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_migi' as column_name, COUNT(*) as total_rows, COUNT(shiba_migi) as filled_count, ROUND(COUNT(shiba_migi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_hidari' as column_name, COUNT(*) as total_rows, COUNT(shiba_hidari) as filled_count, ROUND(COUNT(shiba_hidari)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_choku' as column_name, COUNT(*) as total_rows, COUNT(dirt_choku) as filled_count, ROUND(COUNT(dirt_choku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_migi' as column_name, COUNT(*) as total_rows, COUNT(dirt_migi) as filled_count, ROUND(COUNT(dirt_migi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_hidari' as column_name, COUNT(*) as total_rows, COUNT(dirt_hidari) as filled_count, ROUND(COUNT(dirt_hidari)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai' as column_name, COUNT(*) as total_rows, COUNT(shogai) as filled_count, ROUND(COUNT(shogai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_ryo' as column_name, COUNT(*) as total_rows, COUNT(shiba_ryo) as filled_count, ROUND(COUNT(shiba_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(shiba_yayaomo) as filled_count, ROUND(COUNT(shiba_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_omo' as column_name, COUNT(*) as total_rows, COUNT(shiba_omo) as filled_count, ROUND(COUNT(shiba_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_furyo' as column_name, COUNT(*) as total_rows, COUNT(shiba_furyo) as filled_count, ROUND(COUNT(shiba_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_ryo' as column_name, COUNT(*) as total_rows, COUNT(dirt_ryo) as filled_count, ROUND(COUNT(dirt_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(dirt_yayaomo) as filled_count, ROUND(COUNT(dirt_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_omo' as column_name, COUNT(*) as total_rows, COUNT(dirt_omo) as filled_count, ROUND(COUNT(dirt_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_furyo' as column_name, COUNT(*) as total_rows, COUNT(dirt_furyo) as filled_count, ROUND(COUNT(dirt_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_ryo' as column_name, COUNT(*) as total_rows, COUNT(shogai_ryo) as filled_count, ROUND(COUNT(shogai_ryo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_yayaomo' as column_name, COUNT(*) as total_rows, COUNT(shogai_yayaomo) as filled_count, ROUND(COUNT(shogai_yayaomo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_omo' as column_name, COUNT(*) as total_rows, COUNT(shogai_omo) as filled_count, ROUND(COUNT(shogai_omo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shogai_furyo' as column_name, COUNT(*) as total_rows, COUNT(shogai_furyo) as filled_count, ROUND(COUNT(shogai_furyo)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_short' as column_name, COUNT(*) as total_rows, COUNT(shiba_short) as filled_count, ROUND(COUNT(shiba_short)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_middle' as column_name, COUNT(*) as total_rows, COUNT(shiba_middle) as filled_count, ROUND(COUNT(shiba_middle)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'shiba_long' as column_name, COUNT(*) as total_rows, COUNT(shiba_long) as filled_count, ROUND(COUNT(shiba_long)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_short' as column_name, COUNT(*) as total_rows, COUNT(dirt_short) as filled_count, ROUND(COUNT(dirt_short)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_middle' as column_name, COUNT(*) as total_rows, COUNT(dirt_middle) as filled_count, ROUND(COUNT(dirt_middle)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'dirt_long' as column_name, COUNT(*) as total_rows, COUNT(dirt_long) as filled_count, ROUND(COUNT(dirt_long)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'kyakushitsu_keiko' as column_name, COUNT(*) as total_rows, COUNT(kyakushitsu_keiko) as filled_count, ROUND(COUNT(kyakushitsu_keiko)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_um' as table_name, 'toroku_race_su' as column_name, COUNT(*) as total_rows, COUNT(toroku_race_su) as filled_count, ROUND(COUNT(toroku_race_su)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_um
UNION ALL
SELECT 'jvd_wc' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'tracen_kubun' as column_name, COUNT(*) as total_rows, COUNT(tracen_kubun) as filled_count, ROUND(COUNT(tracen_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'chokyo_nengappi' as column_name, COUNT(*) as total_rows, COUNT(chokyo_nengappi) as filled_count, ROUND(COUNT(chokyo_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'chokyo_jikoku' as column_name, COUNT(*) as total_rows, COUNT(chokyo_jikoku) as filled_count, ROUND(COUNT(chokyo_jikoku)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'ketto_toroku_bango' as column_name, COUNT(*) as total_rows, COUNT(ketto_toroku_bango) as filled_count, ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'course' as column_name, COUNT(*) as total_rows, COUNT(course) as filled_count, ROUND(COUNT(course)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'babamawari' as column_name, COUNT(*) as total_rows, COUNT(babamawari) as filled_count, ROUND(COUNT(babamawari)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_10f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_10f) as filled_count, ROUND(COUNT(time_gokei_10f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_10f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_10f) as filled_count, ROUND(COUNT(lap_time_10f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_9f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_9f) as filled_count, ROUND(COUNT(time_gokei_9f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_9f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_9f) as filled_count, ROUND(COUNT(lap_time_9f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_8f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_8f) as filled_count, ROUND(COUNT(time_gokei_8f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_8f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_8f) as filled_count, ROUND(COUNT(lap_time_8f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_7f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_7f) as filled_count, ROUND(COUNT(time_gokei_7f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_7f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_7f) as filled_count, ROUND(COUNT(lap_time_7f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_6f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_6f) as filled_count, ROUND(COUNT(time_gokei_6f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_6f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_6f) as filled_count, ROUND(COUNT(lap_time_6f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_5f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_5f) as filled_count, ROUND(COUNT(time_gokei_5f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_5f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_5f) as filled_count, ROUND(COUNT(lap_time_5f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_4f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_4f) as filled_count, ROUND(COUNT(time_gokei_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_4f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_4f) as filled_count, ROUND(COUNT(lap_time_4f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_3f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_3f) as filled_count, ROUND(COUNT(time_gokei_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_3f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_3f) as filled_count, ROUND(COUNT(lap_time_3f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'time_gokei_2f' as column_name, COUNT(*) as total_rows, COUNT(time_gokei_2f) as filled_count, ROUND(COUNT(time_gokei_2f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_2f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_2f) as filled_count, ROUND(COUNT(lap_time_2f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_wc' as table_name, 'lap_time_1f' as column_name, COUNT(*) as total_rows, COUNT(lap_time_1f) as filled_count, ROUND(COUNT(lap_time_1f)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wc
UNION ALL
SELECT 'jvd_we' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'henko_shikibetsu' as column_name, COUNT(*) as total_rows, COUNT(henko_shikibetsu) as filled_count, ROUND(COUNT(henko_shikibetsu)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'tenko_code' as column_name, COUNT(*) as total_rows, COUNT(tenko_code) as filled_count, ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'babajotai_code_shiba' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_shiba) as filled_count, ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'babajotai_code_dirt' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_dirt) as filled_count, ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'tenko_code_henkomae' as column_name, COUNT(*) as total_rows, COUNT(tenko_code_henkomae) as filled_count, ROUND(COUNT(tenko_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'babajotai_code_shiba_henkomae' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_shiba_henkomae) as filled_count, ROUND(COUNT(babajotai_code_shiba_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_we' as table_name, 'babajotai_code_dirt_henkomae' as column_name, COUNT(*) as total_rows, COUNT(babajotai_code_dirt_henkomae) as filled_count, ROUND(COUNT(babajotai_code_dirt_henkomae)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_we
UNION ALL
SELECT 'jvd_wf' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yobi_1' as column_name, COUNT(*) as total_rows, COUNT(yobi_1) as filled_count, ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'race_joho_1' as column_name, COUNT(*) as total_rows, COUNT(race_joho_1) as filled_count, ROUND(COUNT(race_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'race_joho_2' as column_name, COUNT(*) as total_rows, COUNT(race_joho_2) as filled_count, ROUND(COUNT(race_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'race_joho_3' as column_name, COUNT(*) as total_rows, COUNT(race_joho_3) as filled_count, ROUND(COUNT(race_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'race_joho_4' as column_name, COUNT(*) as total_rows, COUNT(race_joho_4) as filled_count, ROUND(COUNT(race_joho_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'race_joho_5' as column_name, COUNT(*) as total_rows, COUNT(race_joho_5) as filled_count, ROUND(COUNT(race_joho_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yobi_2' as column_name, COUNT(*) as total_rows, COUNT(yobi_2) as filled_count, ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'win5_hyosu_gokei' as column_name, COUNT(*) as total_rows, COUNT(win5_hyosu_gokei) as filled_count, ROUND(COUNT(win5_hyosu_gokei)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yuko_hyosu_1' as column_name, COUNT(*) as total_rows, COUNT(yuko_hyosu_1) as filled_count, ROUND(COUNT(yuko_hyosu_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yuko_hyosu_2' as column_name, COUNT(*) as total_rows, COUNT(yuko_hyosu_2) as filled_count, ROUND(COUNT(yuko_hyosu_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yuko_hyosu_3' as column_name, COUNT(*) as total_rows, COUNT(yuko_hyosu_3) as filled_count, ROUND(COUNT(yuko_hyosu_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yuko_hyosu_4' as column_name, COUNT(*) as total_rows, COUNT(yuko_hyosu_4) as filled_count, ROUND(COUNT(yuko_hyosu_4)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'yuko_hyosu_5' as column_name, COUNT(*) as total_rows, COUNT(yuko_hyosu_5) as filled_count, ROUND(COUNT(yuko_hyosu_5)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'henkan_flag' as column_name, COUNT(*) as total_rows, COUNT(henkan_flag) as filled_count, ROUND(COUNT(henkan_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'fuseiritsu_flag' as column_name, COUNT(*) as total_rows, COUNT(fuseiritsu_flag) as filled_count, ROUND(COUNT(fuseiritsu_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'tekichu_nashi_flag' as column_name, COUNT(*) as total_rows, COUNT(tekichu_nashi_flag) as filled_count, ROUND(COUNT(tekichu_nashi_flag)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'carry_over' as column_name, COUNT(*) as total_rows, COUNT(carry_over) as filled_count, ROUND(COUNT(carry_over)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'carry_over_zandaka' as column_name, COUNT(*) as total_rows, COUNT(carry_over_zandaka) as filled_count, ROUND(COUNT(carry_over_zandaka)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_001' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_001) as filled_count, ROUND(COUNT(haraimodoshi_win5_001)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_002' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_002) as filled_count, ROUND(COUNT(haraimodoshi_win5_002)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_003' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_003) as filled_count, ROUND(COUNT(haraimodoshi_win5_003)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_004' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_004) as filled_count, ROUND(COUNT(haraimodoshi_win5_004)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_005' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_005) as filled_count, ROUND(COUNT(haraimodoshi_win5_005)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_006' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_006) as filled_count, ROUND(COUNT(haraimodoshi_win5_006)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_007' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_007) as filled_count, ROUND(COUNT(haraimodoshi_win5_007)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_008' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_008) as filled_count, ROUND(COUNT(haraimodoshi_win5_008)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_009' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_009) as filled_count, ROUND(COUNT(haraimodoshi_win5_009)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_010' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_010) as filled_count, ROUND(COUNT(haraimodoshi_win5_010)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_011' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_011) as filled_count, ROUND(COUNT(haraimodoshi_win5_011)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_012' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_012) as filled_count, ROUND(COUNT(haraimodoshi_win5_012)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_013' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_013) as filled_count, ROUND(COUNT(haraimodoshi_win5_013)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_014' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_014) as filled_count, ROUND(COUNT(haraimodoshi_win5_014)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_015' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_015) as filled_count, ROUND(COUNT(haraimodoshi_win5_015)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_016' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_016) as filled_count, ROUND(COUNT(haraimodoshi_win5_016)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_017' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_017) as filled_count, ROUND(COUNT(haraimodoshi_win5_017)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_018' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_018) as filled_count, ROUND(COUNT(haraimodoshi_win5_018)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_019' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_019) as filled_count, ROUND(COUNT(haraimodoshi_win5_019)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_020' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_020) as filled_count, ROUND(COUNT(haraimodoshi_win5_020)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_021' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_021) as filled_count, ROUND(COUNT(haraimodoshi_win5_021)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_022' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_022) as filled_count, ROUND(COUNT(haraimodoshi_win5_022)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_023' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_023) as filled_count, ROUND(COUNT(haraimodoshi_win5_023)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_024' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_024) as filled_count, ROUND(COUNT(haraimodoshi_win5_024)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_025' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_025) as filled_count, ROUND(COUNT(haraimodoshi_win5_025)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_026' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_026) as filled_count, ROUND(COUNT(haraimodoshi_win5_026)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_027' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_027) as filled_count, ROUND(COUNT(haraimodoshi_win5_027)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_028' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_028) as filled_count, ROUND(COUNT(haraimodoshi_win5_028)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_029' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_029) as filled_count, ROUND(COUNT(haraimodoshi_win5_029)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_030' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_030) as filled_count, ROUND(COUNT(haraimodoshi_win5_030)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_031' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_031) as filled_count, ROUND(COUNT(haraimodoshi_win5_031)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_032' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_032) as filled_count, ROUND(COUNT(haraimodoshi_win5_032)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_033' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_033) as filled_count, ROUND(COUNT(haraimodoshi_win5_033)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_034' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_034) as filled_count, ROUND(COUNT(haraimodoshi_win5_034)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_035' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_035) as filled_count, ROUND(COUNT(haraimodoshi_win5_035)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_036' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_036) as filled_count, ROUND(COUNT(haraimodoshi_win5_036)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_037' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_037) as filled_count, ROUND(COUNT(haraimodoshi_win5_037)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_038' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_038) as filled_count, ROUND(COUNT(haraimodoshi_win5_038)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_039' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_039) as filled_count, ROUND(COUNT(haraimodoshi_win5_039)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_040' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_040) as filled_count, ROUND(COUNT(haraimodoshi_win5_040)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_041' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_041) as filled_count, ROUND(COUNT(haraimodoshi_win5_041)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_042' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_042) as filled_count, ROUND(COUNT(haraimodoshi_win5_042)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_043' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_043) as filled_count, ROUND(COUNT(haraimodoshi_win5_043)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_044' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_044) as filled_count, ROUND(COUNT(haraimodoshi_win5_044)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_045' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_045) as filled_count, ROUND(COUNT(haraimodoshi_win5_045)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_046' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_046) as filled_count, ROUND(COUNT(haraimodoshi_win5_046)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_047' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_047) as filled_count, ROUND(COUNT(haraimodoshi_win5_047)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_048' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_048) as filled_count, ROUND(COUNT(haraimodoshi_win5_048)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_049' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_049) as filled_count, ROUND(COUNT(haraimodoshi_win5_049)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_050' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_050) as filled_count, ROUND(COUNT(haraimodoshi_win5_050)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_051' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_051) as filled_count, ROUND(COUNT(haraimodoshi_win5_051)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_052' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_052) as filled_count, ROUND(COUNT(haraimodoshi_win5_052)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_053' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_053) as filled_count, ROUND(COUNT(haraimodoshi_win5_053)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_054' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_054) as filled_count, ROUND(COUNT(haraimodoshi_win5_054)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_055' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_055) as filled_count, ROUND(COUNT(haraimodoshi_win5_055)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_056' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_056) as filled_count, ROUND(COUNT(haraimodoshi_win5_056)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_057' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_057) as filled_count, ROUND(COUNT(haraimodoshi_win5_057)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_058' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_058) as filled_count, ROUND(COUNT(haraimodoshi_win5_058)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_059' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_059) as filled_count, ROUND(COUNT(haraimodoshi_win5_059)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_060' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_060) as filled_count, ROUND(COUNT(haraimodoshi_win5_060)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_061' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_061) as filled_count, ROUND(COUNT(haraimodoshi_win5_061)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_062' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_062) as filled_count, ROUND(COUNT(haraimodoshi_win5_062)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_063' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_063) as filled_count, ROUND(COUNT(haraimodoshi_win5_063)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_064' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_064) as filled_count, ROUND(COUNT(haraimodoshi_win5_064)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_065' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_065) as filled_count, ROUND(COUNT(haraimodoshi_win5_065)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_066' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_066) as filled_count, ROUND(COUNT(haraimodoshi_win5_066)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_067' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_067) as filled_count, ROUND(COUNT(haraimodoshi_win5_067)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_068' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_068) as filled_count, ROUND(COUNT(haraimodoshi_win5_068)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_069' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_069) as filled_count, ROUND(COUNT(haraimodoshi_win5_069)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_070' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_070) as filled_count, ROUND(COUNT(haraimodoshi_win5_070)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_071' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_071) as filled_count, ROUND(COUNT(haraimodoshi_win5_071)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_072' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_072) as filled_count, ROUND(COUNT(haraimodoshi_win5_072)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_073' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_073) as filled_count, ROUND(COUNT(haraimodoshi_win5_073)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_074' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_074) as filled_count, ROUND(COUNT(haraimodoshi_win5_074)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_075' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_075) as filled_count, ROUND(COUNT(haraimodoshi_win5_075)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_076' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_076) as filled_count, ROUND(COUNT(haraimodoshi_win5_076)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_077' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_077) as filled_count, ROUND(COUNT(haraimodoshi_win5_077)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_078' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_078) as filled_count, ROUND(COUNT(haraimodoshi_win5_078)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_079' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_079) as filled_count, ROUND(COUNT(haraimodoshi_win5_079)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_080' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_080) as filled_count, ROUND(COUNT(haraimodoshi_win5_080)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_081' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_081) as filled_count, ROUND(COUNT(haraimodoshi_win5_081)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_082' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_082) as filled_count, ROUND(COUNT(haraimodoshi_win5_082)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_083' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_083) as filled_count, ROUND(COUNT(haraimodoshi_win5_083)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_084' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_084) as filled_count, ROUND(COUNT(haraimodoshi_win5_084)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_085' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_085) as filled_count, ROUND(COUNT(haraimodoshi_win5_085)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_086' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_086) as filled_count, ROUND(COUNT(haraimodoshi_win5_086)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_087' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_087) as filled_count, ROUND(COUNT(haraimodoshi_win5_087)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_088' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_088) as filled_count, ROUND(COUNT(haraimodoshi_win5_088)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_089' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_089) as filled_count, ROUND(COUNT(haraimodoshi_win5_089)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_090' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_090) as filled_count, ROUND(COUNT(haraimodoshi_win5_090)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_091' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_091) as filled_count, ROUND(COUNT(haraimodoshi_win5_091)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_092' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_092) as filled_count, ROUND(COUNT(haraimodoshi_win5_092)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_093' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_093) as filled_count, ROUND(COUNT(haraimodoshi_win5_093)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_094' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_094) as filled_count, ROUND(COUNT(haraimodoshi_win5_094)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_095' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_095) as filled_count, ROUND(COUNT(haraimodoshi_win5_095)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_096' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_096) as filled_count, ROUND(COUNT(haraimodoshi_win5_096)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_097' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_097) as filled_count, ROUND(COUNT(haraimodoshi_win5_097)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_098' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_098) as filled_count, ROUND(COUNT(haraimodoshi_win5_098)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_099' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_099) as filled_count, ROUND(COUNT(haraimodoshi_win5_099)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_100' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_100) as filled_count, ROUND(COUNT(haraimodoshi_win5_100)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_101' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_101) as filled_count, ROUND(COUNT(haraimodoshi_win5_101)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_102' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_102) as filled_count, ROUND(COUNT(haraimodoshi_win5_102)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_103' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_103) as filled_count, ROUND(COUNT(haraimodoshi_win5_103)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_104' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_104) as filled_count, ROUND(COUNT(haraimodoshi_win5_104)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_105' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_105) as filled_count, ROUND(COUNT(haraimodoshi_win5_105)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_106' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_106) as filled_count, ROUND(COUNT(haraimodoshi_win5_106)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_107' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_107) as filled_count, ROUND(COUNT(haraimodoshi_win5_107)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_108' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_108) as filled_count, ROUND(COUNT(haraimodoshi_win5_108)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_109' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_109) as filled_count, ROUND(COUNT(haraimodoshi_win5_109)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_110' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_110) as filled_count, ROUND(COUNT(haraimodoshi_win5_110)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_111' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_111) as filled_count, ROUND(COUNT(haraimodoshi_win5_111)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_112' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_112) as filled_count, ROUND(COUNT(haraimodoshi_win5_112)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_113' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_113) as filled_count, ROUND(COUNT(haraimodoshi_win5_113)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_114' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_114) as filled_count, ROUND(COUNT(haraimodoshi_win5_114)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_115' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_115) as filled_count, ROUND(COUNT(haraimodoshi_win5_115)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_116' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_116) as filled_count, ROUND(COUNT(haraimodoshi_win5_116)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_117' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_117) as filled_count, ROUND(COUNT(haraimodoshi_win5_117)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_118' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_118) as filled_count, ROUND(COUNT(haraimodoshi_win5_118)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_119' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_119) as filled_count, ROUND(COUNT(haraimodoshi_win5_119)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_120' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_120) as filled_count, ROUND(COUNT(haraimodoshi_win5_120)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_121' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_121) as filled_count, ROUND(COUNT(haraimodoshi_win5_121)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_122' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_122) as filled_count, ROUND(COUNT(haraimodoshi_win5_122)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_123' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_123) as filled_count, ROUND(COUNT(haraimodoshi_win5_123)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_124' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_124) as filled_count, ROUND(COUNT(haraimodoshi_win5_124)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_125' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_125) as filled_count, ROUND(COUNT(haraimodoshi_win5_125)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_126' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_126) as filled_count, ROUND(COUNT(haraimodoshi_win5_126)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_127' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_127) as filled_count, ROUND(COUNT(haraimodoshi_win5_127)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_128' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_128) as filled_count, ROUND(COUNT(haraimodoshi_win5_128)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_129' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_129) as filled_count, ROUND(COUNT(haraimodoshi_win5_129)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_130' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_130) as filled_count, ROUND(COUNT(haraimodoshi_win5_130)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_131' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_131) as filled_count, ROUND(COUNT(haraimodoshi_win5_131)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_132' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_132) as filled_count, ROUND(COUNT(haraimodoshi_win5_132)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_133' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_133) as filled_count, ROUND(COUNT(haraimodoshi_win5_133)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_134' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_134) as filled_count, ROUND(COUNT(haraimodoshi_win5_134)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_135' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_135) as filled_count, ROUND(COUNT(haraimodoshi_win5_135)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_136' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_136) as filled_count, ROUND(COUNT(haraimodoshi_win5_136)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_137' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_137) as filled_count, ROUND(COUNT(haraimodoshi_win5_137)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_138' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_138) as filled_count, ROUND(COUNT(haraimodoshi_win5_138)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_139' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_139) as filled_count, ROUND(COUNT(haraimodoshi_win5_139)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_140' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_140) as filled_count, ROUND(COUNT(haraimodoshi_win5_140)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_141' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_141) as filled_count, ROUND(COUNT(haraimodoshi_win5_141)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_142' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_142) as filled_count, ROUND(COUNT(haraimodoshi_win5_142)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_143' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_143) as filled_count, ROUND(COUNT(haraimodoshi_win5_143)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_144' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_144) as filled_count, ROUND(COUNT(haraimodoshi_win5_144)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_145' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_145) as filled_count, ROUND(COUNT(haraimodoshi_win5_145)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_146' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_146) as filled_count, ROUND(COUNT(haraimodoshi_win5_146)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_147' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_147) as filled_count, ROUND(COUNT(haraimodoshi_win5_147)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_148' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_148) as filled_count, ROUND(COUNT(haraimodoshi_win5_148)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_149' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_149) as filled_count, ROUND(COUNT(haraimodoshi_win5_149)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_150' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_150) as filled_count, ROUND(COUNT(haraimodoshi_win5_150)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_151' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_151) as filled_count, ROUND(COUNT(haraimodoshi_win5_151)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_152' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_152) as filled_count, ROUND(COUNT(haraimodoshi_win5_152)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_153' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_153) as filled_count, ROUND(COUNT(haraimodoshi_win5_153)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_154' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_154) as filled_count, ROUND(COUNT(haraimodoshi_win5_154)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_155' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_155) as filled_count, ROUND(COUNT(haraimodoshi_win5_155)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_156' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_156) as filled_count, ROUND(COUNT(haraimodoshi_win5_156)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_157' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_157) as filled_count, ROUND(COUNT(haraimodoshi_win5_157)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_158' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_158) as filled_count, ROUND(COUNT(haraimodoshi_win5_158)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_159' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_159) as filled_count, ROUND(COUNT(haraimodoshi_win5_159)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_160' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_160) as filled_count, ROUND(COUNT(haraimodoshi_win5_160)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_161' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_161) as filled_count, ROUND(COUNT(haraimodoshi_win5_161)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_162' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_162) as filled_count, ROUND(COUNT(haraimodoshi_win5_162)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_163' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_163) as filled_count, ROUND(COUNT(haraimodoshi_win5_163)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_164' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_164) as filled_count, ROUND(COUNT(haraimodoshi_win5_164)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_165' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_165) as filled_count, ROUND(COUNT(haraimodoshi_win5_165)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_166' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_166) as filled_count, ROUND(COUNT(haraimodoshi_win5_166)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_167' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_167) as filled_count, ROUND(COUNT(haraimodoshi_win5_167)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_168' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_168) as filled_count, ROUND(COUNT(haraimodoshi_win5_168)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_169' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_169) as filled_count, ROUND(COUNT(haraimodoshi_win5_169)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_170' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_170) as filled_count, ROUND(COUNT(haraimodoshi_win5_170)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_171' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_171) as filled_count, ROUND(COUNT(haraimodoshi_win5_171)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_172' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_172) as filled_count, ROUND(COUNT(haraimodoshi_win5_172)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_173' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_173) as filled_count, ROUND(COUNT(haraimodoshi_win5_173)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_174' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_174) as filled_count, ROUND(COUNT(haraimodoshi_win5_174)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_175' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_175) as filled_count, ROUND(COUNT(haraimodoshi_win5_175)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_176' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_176) as filled_count, ROUND(COUNT(haraimodoshi_win5_176)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_177' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_177) as filled_count, ROUND(COUNT(haraimodoshi_win5_177)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_178' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_178) as filled_count, ROUND(COUNT(haraimodoshi_win5_178)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_179' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_179) as filled_count, ROUND(COUNT(haraimodoshi_win5_179)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_180' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_180) as filled_count, ROUND(COUNT(haraimodoshi_win5_180)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_181' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_181) as filled_count, ROUND(COUNT(haraimodoshi_win5_181)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_182' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_182) as filled_count, ROUND(COUNT(haraimodoshi_win5_182)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_183' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_183) as filled_count, ROUND(COUNT(haraimodoshi_win5_183)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_184' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_184) as filled_count, ROUND(COUNT(haraimodoshi_win5_184)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_185' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_185) as filled_count, ROUND(COUNT(haraimodoshi_win5_185)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_186' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_186) as filled_count, ROUND(COUNT(haraimodoshi_win5_186)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_187' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_187) as filled_count, ROUND(COUNT(haraimodoshi_win5_187)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_188' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_188) as filled_count, ROUND(COUNT(haraimodoshi_win5_188)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_189' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_189) as filled_count, ROUND(COUNT(haraimodoshi_win5_189)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_190' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_190) as filled_count, ROUND(COUNT(haraimodoshi_win5_190)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_191' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_191) as filled_count, ROUND(COUNT(haraimodoshi_win5_191)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_192' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_192) as filled_count, ROUND(COUNT(haraimodoshi_win5_192)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_193' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_193) as filled_count, ROUND(COUNT(haraimodoshi_win5_193)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_194' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_194) as filled_count, ROUND(COUNT(haraimodoshi_win5_194)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_195' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_195) as filled_count, ROUND(COUNT(haraimodoshi_win5_195)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_196' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_196) as filled_count, ROUND(COUNT(haraimodoshi_win5_196)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_197' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_197) as filled_count, ROUND(COUNT(haraimodoshi_win5_197)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_198' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_198) as filled_count, ROUND(COUNT(haraimodoshi_win5_198)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_199' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_199) as filled_count, ROUND(COUNT(haraimodoshi_win5_199)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_200' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_200) as filled_count, ROUND(COUNT(haraimodoshi_win5_200)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_201' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_201) as filled_count, ROUND(COUNT(haraimodoshi_win5_201)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_202' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_202) as filled_count, ROUND(COUNT(haraimodoshi_win5_202)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_203' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_203) as filled_count, ROUND(COUNT(haraimodoshi_win5_203)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_204' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_204) as filled_count, ROUND(COUNT(haraimodoshi_win5_204)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_205' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_205) as filled_count, ROUND(COUNT(haraimodoshi_win5_205)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_206' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_206) as filled_count, ROUND(COUNT(haraimodoshi_win5_206)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_207' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_207) as filled_count, ROUND(COUNT(haraimodoshi_win5_207)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_208' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_208) as filled_count, ROUND(COUNT(haraimodoshi_win5_208)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_209' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_209) as filled_count, ROUND(COUNT(haraimodoshi_win5_209)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_210' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_210) as filled_count, ROUND(COUNT(haraimodoshi_win5_210)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_211' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_211) as filled_count, ROUND(COUNT(haraimodoshi_win5_211)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_212' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_212) as filled_count, ROUND(COUNT(haraimodoshi_win5_212)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_213' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_213) as filled_count, ROUND(COUNT(haraimodoshi_win5_213)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_214' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_214) as filled_count, ROUND(COUNT(haraimodoshi_win5_214)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_215' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_215) as filled_count, ROUND(COUNT(haraimodoshi_win5_215)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_216' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_216) as filled_count, ROUND(COUNT(haraimodoshi_win5_216)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_217' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_217) as filled_count, ROUND(COUNT(haraimodoshi_win5_217)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_218' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_218) as filled_count, ROUND(COUNT(haraimodoshi_win5_218)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_219' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_219) as filled_count, ROUND(COUNT(haraimodoshi_win5_219)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_220' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_220) as filled_count, ROUND(COUNT(haraimodoshi_win5_220)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_221' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_221) as filled_count, ROUND(COUNT(haraimodoshi_win5_221)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_222' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_222) as filled_count, ROUND(COUNT(haraimodoshi_win5_222)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_223' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_223) as filled_count, ROUND(COUNT(haraimodoshi_win5_223)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_224' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_224) as filled_count, ROUND(COUNT(haraimodoshi_win5_224)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_225' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_225) as filled_count, ROUND(COUNT(haraimodoshi_win5_225)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_226' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_226) as filled_count, ROUND(COUNT(haraimodoshi_win5_226)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_227' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_227) as filled_count, ROUND(COUNT(haraimodoshi_win5_227)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_228' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_228) as filled_count, ROUND(COUNT(haraimodoshi_win5_228)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_229' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_229) as filled_count, ROUND(COUNT(haraimodoshi_win5_229)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_230' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_230) as filled_count, ROUND(COUNT(haraimodoshi_win5_230)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_231' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_231) as filled_count, ROUND(COUNT(haraimodoshi_win5_231)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_232' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_232) as filled_count, ROUND(COUNT(haraimodoshi_win5_232)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_233' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_233) as filled_count, ROUND(COUNT(haraimodoshi_win5_233)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_234' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_234) as filled_count, ROUND(COUNT(haraimodoshi_win5_234)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_235' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_235) as filled_count, ROUND(COUNT(haraimodoshi_win5_235)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_236' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_236) as filled_count, ROUND(COUNT(haraimodoshi_win5_236)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_237' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_237) as filled_count, ROUND(COUNT(haraimodoshi_win5_237)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_238' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_238) as filled_count, ROUND(COUNT(haraimodoshi_win5_238)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_239' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_239) as filled_count, ROUND(COUNT(haraimodoshi_win5_239)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_240' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_240) as filled_count, ROUND(COUNT(haraimodoshi_win5_240)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_241' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_241) as filled_count, ROUND(COUNT(haraimodoshi_win5_241)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_242' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_242) as filled_count, ROUND(COUNT(haraimodoshi_win5_242)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wf' as table_name, 'haraimodoshi_win5_243' as column_name, COUNT(*) as total_rows, COUNT(haraimodoshi_win5_243) as filled_count, ROUND(COUNT(haraimodoshi_win5_243)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL
SELECT 'jvd_wh' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'race_bango' as column_name, COUNT(*) as total_rows, COUNT(race_bango) as filled_count, ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'happyo_tsukihi_jifun' as column_name, COUNT(*) as total_rows, COUNT(happyo_tsukihi_jifun) as filled_count, ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_01' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_01) as filled_count, ROUND(COUNT(bataiju_joho_01)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_02' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_02) as filled_count, ROUND(COUNT(bataiju_joho_02)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_03' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_03) as filled_count, ROUND(COUNT(bataiju_joho_03)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_04' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_04) as filled_count, ROUND(COUNT(bataiju_joho_04)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_05' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_05) as filled_count, ROUND(COUNT(bataiju_joho_05)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_06' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_06) as filled_count, ROUND(COUNT(bataiju_joho_06)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_07' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_07) as filled_count, ROUND(COUNT(bataiju_joho_07)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_08' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_08) as filled_count, ROUND(COUNT(bataiju_joho_08)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_09' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_09) as filled_count, ROUND(COUNT(bataiju_joho_09)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_10' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_10) as filled_count, ROUND(COUNT(bataiju_joho_10)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_11' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_11) as filled_count, ROUND(COUNT(bataiju_joho_11)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_12' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_12) as filled_count, ROUND(COUNT(bataiju_joho_12)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_13' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_13) as filled_count, ROUND(COUNT(bataiju_joho_13)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_14' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_14) as filled_count, ROUND(COUNT(bataiju_joho_14)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_15' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_15) as filled_count, ROUND(COUNT(bataiju_joho_15)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_16' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_16) as filled_count, ROUND(COUNT(bataiju_joho_16)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_17' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_17) as filled_count, ROUND(COUNT(bataiju_joho_17)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_wh' as table_name, 'bataiju_joho_18' as column_name, COUNT(*) as total_rows, COUNT(bataiju_joho_18) as filled_count, ROUND(COUNT(bataiju_joho_18)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_wh
UNION ALL
SELECT 'jvd_ys' as table_name, 'record_id' as column_name, COUNT(*) as total_rows, COUNT(record_id) as filled_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'data_kubun' as column_name, COUNT(*) as total_rows, COUNT(data_kubun) as filled_count, ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'data_sakusei_nengappi' as column_name, COUNT(*) as total_rows, COUNT(data_sakusei_nengappi) as filled_count, ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'kaisai_nen' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nen) as filled_count, ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'kaisai_tsukihi' as column_name, COUNT(*) as total_rows, COUNT(kaisai_tsukihi) as filled_count, ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'keibajo_code' as column_name, COUNT(*) as total_rows, COUNT(keibajo_code) as filled_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'kaisai_kai' as column_name, COUNT(*) as total_rows, COUNT(kaisai_kai) as filled_count, ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'kaisai_nichime' as column_name, COUNT(*) as total_rows, COUNT(kaisai_nichime) as filled_count, ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'yobi_code' as column_name, COUNT(*) as total_rows, COUNT(yobi_code) as filled_count, ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'jusho_joho_1' as column_name, COUNT(*) as total_rows, COUNT(jusho_joho_1) as filled_count, ROUND(COUNT(jusho_joho_1)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'jusho_joho_2' as column_name, COUNT(*) as total_rows, COUNT(jusho_joho_2) as filled_count, ROUND(COUNT(jusho_joho_2)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
UNION ALL
SELECT 'jvd_ys' as table_name, 'jusho_joho_3' as column_name, COUNT(*) as total_rows, COUNT(jusho_joho_3) as filled_count, ROUND(COUNT(jusho_joho_3)::NUMERIC / COUNT(*) * 100, 2) as fillrate FROM jvd_ys
ORDER BY table_name, column_name;