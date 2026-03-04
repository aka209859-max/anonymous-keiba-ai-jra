-- Phase 7-A: 大文字テーブルカラムの充填率チェック
-- 作成日: 2026-03-04
-- 目的: ユーザーが選定した大文字テーブルのカラムの充填率を確認
--
-- 実行方法:
-- 1. pgAdmin4でこのSQLを開く
-- 2. 全選択してF5で実行
-- 3. 結果を右クリック → Export → CSV
-- 4. ファイル名: uppercase_tables_fillrate.csv
-- 5. このチャットにアップロード
--
-- 対象テーブル数: 13
-- 対象カラム数: 192
--

SELECT 
    'jrd_kyi' AS table_name,
    'agari_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(agari_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(agari_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'agari_shisu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(agari_shisu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(agari_shisu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'blinker_shiyo_kubun' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(blinker_shiyo_kubun) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(blinker_shiyo_kubun)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'chokyo_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'chokyo_yajirushi_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_yajirushi_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_yajirushi_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'chokyoshi_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyoshi_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyoshi_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'class_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(class_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(class_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'dochu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(dochu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(dochu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'dochu_sa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(dochu_sa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(dochu_sa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'dochu_uchisoto' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(dochu_uchisoto) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(dochu_uchisoto)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'futan_juryo' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(futan_juryo) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(futan_juryo)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'gekiso_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(gekiso_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(gekiso_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'gekiso_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(gekiso_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(gekiso_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'gekiso_type' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(gekiso_type) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(gekiso_type)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'goal_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(goal_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(goal_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'goal_sa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(goal_sa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(goal_sa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'goal_uchisoto' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(goal_uchisoto) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(goal_uchisoto)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'hizume_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hizume_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hizume_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'hobokusaki' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hobokusaki) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hobokusaki)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'hobokusaki_rank' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hobokusaki_rank) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hobokusaki_rank)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'ichi_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ichi_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ichi_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'ichi_shisu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ichi_shisu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ichi_shisu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'idm' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(idm) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(idm)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'joho_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(joho_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(joho_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'joshodo_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(joshodo_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(joshodo_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kakutoku_shokin_ruikei' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kakutoku_shokin_ruikei) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kakutoku_shokin_ruikei)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kijun_ninkijun_fukusho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kijun_ninkijun_fukusho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kijun_ninkijun_fukusho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kijun_ninkijun_tansho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kijun_ninkijun_tansho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kijun_ninkijun_tansho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kijun_odds_fukusho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kijun_odds_fukusho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kijun_odds_fukusho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kijun_odds_tansho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kijun_odds_tansho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kijun_odds_tansho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kishu_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kishu_kitai_rentai_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_kitai_rentai_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_kitai_rentai_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kishu_kitai_sanchakunai_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_kitai_sanchakunai_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_kitai_sanchakunai_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kishu_kitai_tansho_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_kitai_tansho_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_kitai_tansho_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kishu_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kohan_3f_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kohan_3f_sa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f_sa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f_sa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kohan_3f_uchisoto' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f_uchisoto) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f_uchisoto)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyakushitsu_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyakushitsu_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyakushitsu_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyori_tekisei_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyori_tekisei_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyori_tekisei_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyusha_hyoka_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_hyoka_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_hyoka_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyusha_rank' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_rank) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_rank)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyusha_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'kyuyo_riyu_bunrui_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyuyo_riyu_bunrui_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyuyo_riyu_bunrui_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'ls_shisu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ls_shisu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ls_shisu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'manken_shirushi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(manken_shirushi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(manken_shirushi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'manken_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(manken_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(manken_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'pace_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(pace_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(pace_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'pace_shisu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(pace_shisu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(pace_shisu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'pace_yoso' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(pace_yoso) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(pace_yoso)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'shutoku_shokin_ruikei' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(shutoku_shokin_ruikei) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(shutoku_shokin_ruikei)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'sogo_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(sogo_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(sogo_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'taikei' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(taikei) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(taikei)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'taikei_sogo_1' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(taikei_sogo_1) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(taikei_sogo_1)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'taikei_sogo_2' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(taikei_sogo_2) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(taikei_sogo_2)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'taikei_sogo_3' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(taikei_sogo_3) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(taikei_sogo_3)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'tekisei_code_omo' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(tekisei_code_omo) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(tekisei_code_omo)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'ten_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ten_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ten_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'ten_shisu_juni' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ten_shisu_juni) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ten_shisu_juni)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'uma_deokure_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(uma_deokure_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(uma_deokure_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'uma_start_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(uma_start_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(uma_start_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'uma_tokki_1' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(uma_tokki_1) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(uma_tokki_1)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'uma_tokki_2' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(uma_tokki_2) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(uma_tokki_2)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'uma_tokki_3' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(uma_tokki_3) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(uma_tokki_3)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_kyi' AS table_name,
    'yuso_kubun' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(yuso_kubun) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(yuso_kubun)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jrd_kyi

UNION ALL

SELECT 
    'jrd_sed' AS table_name,
    'babasa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(babasa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(babasa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'corner_1' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_1) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_1)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'corner_2' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_2) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_2)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'corner_3' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_3) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_3)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'corner_4' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_4) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_4)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'course_dori_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(course_dori_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(course_dori_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'deokure' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(deokure) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(deokure)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'furi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(furi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(furi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'furi_1' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(furi_1) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(furi_1)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'furi_2' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(furi_2) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(furi_2)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'furi_3' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(furi_3) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(furi_3)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'ichidori' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ichidori) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ichidori)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'idm' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(idm) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(idm)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'joshodo_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(joshodo_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(joshodo_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'kohan_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'kohan_3f_sento_sa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f_sento_sa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f_sento_sa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'pace' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(pace) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(pace)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'pace_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(pace_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(pace_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'race_p_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(race_p_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(race_p_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'ten_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ten_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ten_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'tenko_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(tenko_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(tenko_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'zenhan_3f_sento_sa' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(zenhan_3f_sento_sa) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(zenhan_3f_sento_sa)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_sed' AS table_name,
    'zenhan_3f_taimu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(zenhan_3f_taimu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(zenhan_3f_taimu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jrd_sed

UNION ALL

SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_comment' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_comment) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_comment)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_dirt' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_dirt) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_dirt)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_hanro' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_hanro) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_hanro)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_polytrack' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_polytrack) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_polytrack)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_pool' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_pool) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_pool)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_shiba' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_shiba) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_shiba)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_shogai' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_shogai) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_shogai)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_shubetsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_shubetsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_shubetsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_corse_wood' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_corse_wood) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_corse_wood)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_hyoka' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_hyoka) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_hyoka)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_juten' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_juten) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_juten)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_kyori' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_kyori) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_kyori)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'chokyo_ryo_hyoka' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyo_ryo_hyoka) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyo_ryo_hyoka)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'oikiri_corse_isshumae' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(oikiri_corse_isshumae) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(oikiri_corse_isshumae)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'oikiri_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(oikiri_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(oikiri_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'oikiri_shisu_isshumae' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(oikiri_shisu_isshumae) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(oikiri_shisu_isshumae)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'shiage_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(shiage_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(shiage_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_cyb' AS table_name,
    'shiage_shisu_henka' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(shiage_shisu_henka) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(shiage_shisu_henka)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jrd_cyb

UNION ALL

SELECT 
    'jvd_ch' AS table_name,
    'chokyoshi_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(chokyoshi_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(chokyoshi_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ch' AS table_name,
    'tozai_shozoku_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(tozai_shozoku_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(tozai_shozoku_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_ch
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jrd_joa' AS table_name,
    'cid' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(cid) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(cid)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'em' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(em) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(em)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kishu_bb_nijumaru_rentai_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_bb_nijumaru_rentai_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_bb_nijumaru_rentai_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kishu_bb_nijumaru_tansho_kaishuritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_bb_nijumaru_tansho_kaishuritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_bb_nijumaru_tansho_kaishuritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kishu_bb_shirushi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kishu_bb_shirushi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kishu_bb_shirushi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kyusha_bb_nijumaru_rentai_ritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_bb_nijumaru_rentai_ritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_bb_nijumaru_rentai_ritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kyusha_bb_nijumaru_tansho_kaishuritsu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'kyusha_bb_shirushi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kyusha_bb_shirushi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kyusha_bb_shirushi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'ls_hyoka' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ls_hyoka) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ls_hyoka)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jrd_joa' AS table_name,
    'ls_shisu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ls_shisu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ls_shisu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jrd_joa

UNION ALL

SELECT 
    'jvd_ra' AS table_name,
    'corner_tsuka_juni_1' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_tsuka_juni_1) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_tsuka_juni_1)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'corner_tsuka_juni_2' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_tsuka_juni_2) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_tsuka_juni_2)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'corner_tsuka_juni_3' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_tsuka_juni_3) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_tsuka_juni_3)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'corner_tsuka_juni_4' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(corner_tsuka_juni_4) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(corner_tsuka_juni_4)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'kohan_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'kohan_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kohan_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kohan_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'zenhan_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(zenhan_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(zenhan_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_ra' AS table_name,
    'zenhan_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(zenhan_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(zenhan_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_ra
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_h1' AS table_name,
    'data_kubun' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(data_kubun) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(data_kubun)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'data_sakusei_nengappi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(data_sakusei_nengappi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(data_sakusei_nengappi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'fukusho_chakubarai_key' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(fukusho_chakubarai_key) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(fukusho_chakubarai_key)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_fukusho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_fukusho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_fukusho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_sanrenpuku' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_sanrenpuku) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_sanrenpuku)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_tansho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_tansho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_tansho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_umaren' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_umaren) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_umaren)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_umatan' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_umatan) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_umatan)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_wakuren' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_wakuren) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_wakuren)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'hatsubai_flag_wide' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_wide) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_wide)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'henkan_dowaku_joho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(henkan_dowaku_joho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(henkan_dowaku_joho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'henkan_hyosu_gokei_fukusho' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(henkan_hyosu_gokei_fukusho) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(henkan_hyosu_gokei_fukusho)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'henkan_hyosu_gokei_sanrenpuku' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(henkan_hyosu_gokei_sanrenpuku) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(henkan_hyosu_gokei_sanrenpuku)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'kaisai_kai' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_kai) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_kai)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'kaisai_nen' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_nen) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_nen)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'kaisai_nichime' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_nichime) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_nichime)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'kaisai_tsukihi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_tsukihi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_tsukihi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'keibajo_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(keibajo_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(keibajo_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'race_bango' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(race_bango) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(race_bango)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h1' AS table_name,
    'shusso_tosu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(shusso_tosu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(shusso_tosu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_h1
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_h6' AS table_name,
    'data_kubun' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(data_kubun) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(data_kubun)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'data_sakusei_nengappi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(data_sakusei_nengappi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(data_sakusei_nengappi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'hatsubai_flag_sanrentan' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hatsubai_flag_sanrentan) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hatsubai_flag_sanrentan)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'kaisai_kai' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_kai) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_kai)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'kaisai_nen' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_nen) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_nen)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'kaisai_nichime' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_nichime) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_nichime)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'kaisai_tsukihi' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(kaisai_tsukihi) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(kaisai_tsukihi)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'keibajo_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(keibajo_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(keibajo_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'race_bango' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(race_bango) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(race_bango)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_h6' AS table_name,
    'shusso_tosu' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(shusso_tosu) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(shusso_tosu)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_h6
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_hn' AS table_name,
    'hinshu_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(hinshu_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(hinshu_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hn' AS table_name,
    'mochikomi_kubun' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(mochikomi_kubun) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(mochikomi_kubun)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hn' AS table_name,
    'moshoku_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(moshoku_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(moshoku_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hn' AS table_name,
    'sanchimei' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(sanchimei) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(sanchimei)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hn' AS table_name,
    'seibetsu_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(seibetsu_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(seibetsu_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hn' AS table_name,
    'yunyu_nen' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(yunyu_nen) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(yunyu_nen)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_hn
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_bt' AS table_name,
    'keito_id' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(keito_id) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(keito_id)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_bt' AS table_name,
    'keito_mei' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(keito_mei) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(keito_mei)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_bt
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_hc' AS table_name,
    'ketto_toroku_bango' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(ketto_toroku_bango) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(ketto_toroku_bango)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'lap_time_1f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_1f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_1f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'lap_time_2f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_2f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_2f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'lap_time_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'lap_time_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'time_gokei_2f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_2f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_2f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'time_gokei_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_hc' AS table_name,
    'time_gokei_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_hc
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_wc' AS table_name,
    'lap_time_10f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_10f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_10f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_1f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_1f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_1f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_2f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_2f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_2f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_5f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_5f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_5f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_6f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_6f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_6f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_7f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_7f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_7f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_8f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_8f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_8f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'lap_time_9f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(lap_time_9f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(lap_time_9f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_10f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_10f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_10f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_2f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_2f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_2f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_3f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_3f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_3f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_4f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_4f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_4f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_5f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_5f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_5f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_6f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_6f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_6f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_7f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_7f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_7f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_8f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_8f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_8f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
UNION ALL
SELECT 
    'jvd_wc' AS table_name,
    'time_gokei_9f' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(time_gokei_9f) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(time_gokei_9f)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_wc
WHERE kaisai_nen BETWEEN '2016' AND '2025'

UNION ALL

SELECT 
    'jvd_br' AS table_name,
    'seisansha_code' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(seisansha_code) AS filled_count,
    CASE 
        WHEN COUNT(*) = 0 THEN 0 
        ELSE ROUND(COUNT(seisansha_code)::numeric / COUNT(*)::numeric * 100, 2)
    END AS fillrate
FROM jvd_br
WHERE kaisai_nen BETWEEN '2016' AND '2025'

ORDER BY table_name, column_name;