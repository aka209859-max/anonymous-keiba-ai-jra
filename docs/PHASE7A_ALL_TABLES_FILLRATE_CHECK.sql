-- ====================================================================================================
-- Phase 7-A: 全1,939カラムの充填率チェック（テーブル別SQL集）
-- ====================================================================================================
-- 作成日: 2026-03-03
-- 各テーブルごとにSQLを個別実行し、結果をCSVでエクスポートしてください
-- ====================================================================================================

-- ============================================================================
-- 1. JVD_SE (70カラム)
-- ============================================================================
-- 実行後、結果を jvd_se_fillrate.csv で保存してください

SELECT 'jvd_se' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'wakuban', COUNT(wakuban), COUNT(*), ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'umaban', COUNT(umaban), COUNT(*), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'umakigo_code', COUNT(umakigo_code), COUNT(*), ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'seibetsu_code', COUNT(seibetsu_code), COUNT(*), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'hinshu_code', COUNT(hinshu_code), COUNT(*), ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'moshoku_code', COUNT(moshoku_code), COUNT(*), ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'barei', COUNT(barei), COUNT(*), ROUND(COUNT(barei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'tozai_shozoku_code', COUNT(tozai_shozoku_code), COUNT(*), ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'chokyoshimei_ryakusho', COUNT(chokyoshimei_ryakusho), COUNT(*), ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'banushi_code', COUNT(banushi_code), COUNT(*), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'banushimei', COUNT(banushimei), COUNT(*), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'fukushoku_hyoji', COUNT(fukushoku_hyoji), COUNT(*), ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'futan_juryo', COUNT(futan_juryo), COUNT(*), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'futan_juryo_henkomae', COUNT(futan_juryo_henkomae), COUNT(*), ROUND(COUNT(futan_juryo_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'blinker_shiyo_kubun', COUNT(blinker_shiyo_kubun), COUNT(*), ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yobi_2', COUNT(yobi_2), COUNT(*), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishu_code', COUNT(kishu_code), COUNT(*), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishu_code_henkomae', COUNT(kishu_code_henkomae), COUNT(*), ROUND(COUNT(kishu_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishumei_ryakusho', COUNT(kishumei_ryakusho), COUNT(*), ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishumei_ryakusho_henkomae', COUNT(kishumei_ryakusho_henkomae), COUNT(*), ROUND(COUNT(kishumei_ryakusho_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishu_minarai_code', COUNT(kishu_minarai_code), COUNT(*), ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kishu_minarai_code_henkomae', COUNT(kishu_minarai_code_henkomae), COUNT(*), ROUND(COUNT(kishu_minarai_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'bataiju', COUNT(bataiju), COUNT(*), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'zogen_fugo', COUNT(zogen_fugo), COUNT(*), ROUND(COUNT(zogen_fugo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'zogen_sa', COUNT(zogen_sa), COUNT(*), ROUND(COUNT(zogen_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'ijo_kubun_code', COUNT(ijo_kubun_code), COUNT(*), ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'nyusen_juni', COUNT(nyusen_juni), COUNT(*), ROUND(COUNT(nyusen_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kakutei_chakujun', COUNT(kakutei_chakujun), COUNT(*), ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'dochaku_kubun', COUNT(dochaku_kubun), COUNT(*), ROUND(COUNT(dochaku_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'dochaku_tosu', COUNT(dochaku_tosu), COUNT(*), ROUND(COUNT(dochaku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'soha_time', COUNT(soha_time), COUNT(*), ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'chakusa_code_1', COUNT(chakusa_code_1), COUNT(*), ROUND(COUNT(chakusa_code_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'chakusa_code_2', COUNT(chakusa_code_2), COUNT(*), ROUND(COUNT(chakusa_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'chakusa_code_3', COUNT(chakusa_code_3), COUNT(*), ROUND(COUNT(chakusa_code_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'corner_1', COUNT(corner_1), COUNT(*), ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'corner_2', COUNT(corner_2), COUNT(*), ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'corner_3', COUNT(corner_3), COUNT(*), ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'corner_4', COUNT(corner_4), COUNT(*), ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'tansho_odds', COUNT(tansho_odds), COUNT(*), ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'tansho_ninkijun', COUNT(tansho_ninkijun), COUNT(*), ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kakutoku_honshokin', COUNT(kakutoku_honshokin), COUNT(*), ROUND(COUNT(kakutoku_honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kakutoku_fukashokin', COUNT(kakutoku_fukashokin), COUNT(*), ROUND(COUNT(kakutoku_fukashokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yobi_3', COUNT(yobi_3), COUNT(*), ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yobi_4', COUNT(yobi_4), COUNT(*), ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kohan_4f', COUNT(kohan_4f), COUNT(*), ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kohan_3f', COUNT(kohan_3f), COUNT(*), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'aiteuma_joho_1', COUNT(aiteuma_joho_1), COUNT(*), ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'aiteuma_joho_2', COUNT(aiteuma_joho_2), COUNT(*), ROUND(COUNT(aiteuma_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'aiteuma_joho_3', COUNT(aiteuma_joho_3), COUNT(*), ROUND(COUNT(aiteuma_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'time_sa', COUNT(time_sa), COUNT(*), ROUND(COUNT(time_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'record_koshin_kubun', COUNT(record_koshin_kubun), COUNT(*), ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'mining_kubun', COUNT(mining_kubun), COUNT(*), ROUND(COUNT(mining_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yoso_soha_time', COUNT(yoso_soha_time), COUNT(*), ROUND(COUNT(yoso_soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yoso_gosa_plus', COUNT(yoso_gosa_plus), COUNT(*), ROUND(COUNT(yoso_gosa_plus)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yoso_gosa_minus', COUNT(yoso_gosa_minus), COUNT(*), ROUND(COUNT(yoso_gosa_minus)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'yoso_juni', COUNT(yoso_juni), COUNT(*), ROUND(COUNT(yoso_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kyakushitsu_hantei', COUNT(kyakushitsu_hantei), COUNT(*), ROUND(COUNT(kyakushitsu_hantei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 2. JVD_CK (106カラム)
-- ============================================================================
-- 実行後、結果を jvd_ck_fillrate.csv で保存してください

SELECT 'jvd_ck' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'heichi_honshokin_ruikei', COUNT(heichi_honshokin_ruikei), COUNT(*), ROUND(COUNT(heichi_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_honshokin_ruikei', COUNT(shogai_honshokin_ruikei), COUNT(*), ROUND(COUNT(shogai_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'heichi_fukashokin_ruikei', COUNT(heichi_fukashokin_ruikei), COUNT(*), ROUND(COUNT(heichi_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_fukashokin_ruikei', COUNT(shogai_fukashokin_ruikei), COUNT(*), ROUND(COUNT(shogai_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'heichi_shutokushokin_ruikei', COUNT(heichi_shutokushokin_ruikei), COUNT(*), ROUND(COUNT(heichi_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_shutokushokin_ruikei', COUNT(shogai_shutokushokin_ruikei), COUNT(*), ROUND(COUNT(shogai_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'sogo', COUNT(sogo), COUNT(*), ROUND(COUNT(sogo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'chuo_gokei', COUNT(chuo_gokei), COUNT(*), ROUND(COUNT(chuo_gokei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_choku', COUNT(shiba_choku), COUNT(*), ROUND(COUNT(shiba_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_migi', COUNT(shiba_migi), COUNT(*), ROUND(COUNT(shiba_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_hidari', COUNT(shiba_hidari), COUNT(*), ROUND(COUNT(shiba_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_choku', COUNT(dirt_choku), COUNT(*), ROUND(COUNT(dirt_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_migi', COUNT(dirt_migi), COUNT(*), ROUND(COUNT(dirt_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_hidari', COUNT(dirt_hidari), COUNT(*), ROUND(COUNT(dirt_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai', COUNT(shogai), COUNT(*), ROUND(COUNT(shogai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_ryo', COUNT(shiba_ryo), COUNT(*), ROUND(COUNT(shiba_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_yayaomo', COUNT(shiba_yayaomo), COUNT(*), ROUND(COUNT(shiba_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_omo', COUNT(shiba_omo), COUNT(*), ROUND(COUNT(shiba_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_furyo', COUNT(shiba_furyo), COUNT(*), ROUND(COUNT(shiba_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_ryo', COUNT(dirt_ryo), COUNT(*), ROUND(COUNT(dirt_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_yayaomo', COUNT(dirt_yayaomo), COUNT(*), ROUND(COUNT(dirt_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_omo', COUNT(dirt_omo), COUNT(*), ROUND(COUNT(dirt_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_furyo', COUNT(dirt_furyo), COUNT(*), ROUND(COUNT(dirt_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_ryo', COUNT(shogai_ryo), COUNT(*), ROUND(COUNT(shogai_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_yayaomo', COUNT(shogai_yayaomo), COUNT(*), ROUND(COUNT(shogai_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_omo', COUNT(shogai_omo), COUNT(*), ROUND(COUNT(shogai_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_furyo', COUNT(shogai_furyo), COUNT(*), ROUND(COUNT(shogai_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_1200_ika', COUNT(shiba_1200_ika), COUNT(*), ROUND(COUNT(shiba_1200_ika)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_1201_1400', COUNT(shiba_1201_1400), COUNT(*), ROUND(COUNT(shiba_1201_1400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_1401_1600', COUNT(shiba_1401_1600), COUNT(*), ROUND(COUNT(shiba_1401_1600)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_1601_1800', COUNT(shiba_1601_1800), COUNT(*), ROUND(COUNT(shiba_1601_1800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_1801_2000', COUNT(shiba_1801_2000), COUNT(*), ROUND(COUNT(shiba_1801_2000)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_2001_2200', COUNT(shiba_2001_2200), COUNT(*), ROUND(COUNT(shiba_2001_2200)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_2201_2400', COUNT(shiba_2201_2400), COUNT(*), ROUND(COUNT(shiba_2201_2400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_2401_2800', COUNT(shiba_2401_2800), COUNT(*), ROUND(COUNT(shiba_2401_2800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_2801_ijo', COUNT(shiba_2801_ijo), COUNT(*), ROUND(COUNT(shiba_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_1200_ika', COUNT(dirt_1200_ika), COUNT(*), ROUND(COUNT(dirt_1200_ika)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_1201_1400', COUNT(dirt_1201_1400), COUNT(*), ROUND(COUNT(dirt_1201_1400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_1401_1600', COUNT(dirt_1401_1600), COUNT(*), ROUND(COUNT(dirt_1401_1600)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_1601_1800', COUNT(dirt_1601_1800), COUNT(*), ROUND(COUNT(dirt_1601_1800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_1801_2000', COUNT(dirt_1801_2000), COUNT(*), ROUND(COUNT(dirt_1801_2000)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_2001_2200', COUNT(dirt_2001_2200), COUNT(*), ROUND(COUNT(dirt_2001_2200)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_2201_2400', COUNT(dirt_2201_2400), COUNT(*), ROUND(COUNT(dirt_2201_2400)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_2401_2800', COUNT(dirt_2401_2800), COUNT(*), ROUND(COUNT(dirt_2401_2800)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_2801_ijo', COUNT(dirt_2801_ijo), COUNT(*), ROUND(COUNT(dirt_2801_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_sapporo', COUNT(shiba_sapporo), COUNT(*), ROUND(COUNT(shiba_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_hakodate', COUNT(shiba_hakodate), COUNT(*), ROUND(COUNT(shiba_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_fukushima', COUNT(shiba_fukushima), COUNT(*), ROUND(COUNT(shiba_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_niigata', COUNT(shiba_niigata), COUNT(*), ROUND(COUNT(shiba_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_tokyo', COUNT(shiba_tokyo), COUNT(*), ROUND(COUNT(shiba_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_nakayama', COUNT(shiba_nakayama), COUNT(*), ROUND(COUNT(shiba_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_chukyo', COUNT(shiba_chukyo), COUNT(*), ROUND(COUNT(shiba_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_kyoto', COUNT(shiba_kyoto), COUNT(*), ROUND(COUNT(shiba_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_hanshin', COUNT(shiba_hanshin), COUNT(*), ROUND(COUNT(shiba_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shiba_kokura', COUNT(shiba_kokura), COUNT(*), ROUND(COUNT(shiba_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_sapporo', COUNT(dirt_sapporo), COUNT(*), ROUND(COUNT(dirt_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_hakodate', COUNT(dirt_hakodate), COUNT(*), ROUND(COUNT(dirt_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_fukushima', COUNT(dirt_fukushima), COUNT(*), ROUND(COUNT(dirt_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_niigata', COUNT(dirt_niigata), COUNT(*), ROUND(COUNT(dirt_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_tokyo', COUNT(dirt_tokyo), COUNT(*), ROUND(COUNT(dirt_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_nakayama', COUNT(dirt_nakayama), COUNT(*), ROUND(COUNT(dirt_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_chukyo', COUNT(dirt_chukyo), COUNT(*), ROUND(COUNT(dirt_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_kyoto', COUNT(dirt_kyoto), COUNT(*), ROUND(COUNT(dirt_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_hanshin', COUNT(dirt_hanshin), COUNT(*), ROUND(COUNT(dirt_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'dirt_kokura', COUNT(dirt_kokura), COUNT(*), ROUND(COUNT(dirt_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_sapporo', COUNT(shogai_sapporo), COUNT(*), ROUND(COUNT(shogai_sapporo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_hakodate', COUNT(shogai_hakodate), COUNT(*), ROUND(COUNT(shogai_hakodate)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_fukushima', COUNT(shogai_fukushima), COUNT(*), ROUND(COUNT(shogai_fukushima)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_niigata', COUNT(shogai_niigata), COUNT(*), ROUND(COUNT(shogai_niigata)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_tokyo', COUNT(shogai_tokyo), COUNT(*), ROUND(COUNT(shogai_tokyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_nakayama', COUNT(shogai_nakayama), COUNT(*), ROUND(COUNT(shogai_nakayama)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_chukyo', COUNT(shogai_chukyo), COUNT(*), ROUND(COUNT(shogai_chukyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_kyoto', COUNT(shogai_kyoto), COUNT(*), ROUND(COUNT(shogai_kyoto)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_hanshin', COUNT(shogai_hanshin), COUNT(*), ROUND(COUNT(shogai_hanshin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'shogai_kokura', COUNT(shogai_kokura), COUNT(*), ROUND(COUNT(shogai_kokura)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kyakushitsu_keiko', COUNT(kyakushitsu_keiko), COUNT(*), ROUND(COUNT(kyakushitsu_keiko)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'toroku_race_su', COUNT(toroku_race_su), COUNT(*), ROUND(COUNT(toroku_race_su)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kishu_code', COUNT(kishu_code), COUNT(*), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'kishumei', COUNT(kishumei), COUNT(*), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_kishu_1', COUNT(seiseki_joho_kishu_1), COUNT(*), ROUND(COUNT(seiseki_joho_kishu_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_kishu_2', COUNT(seiseki_joho_kishu_2), COUNT(*), ROUND(COUNT(seiseki_joho_kishu_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'chokyoshimei', COUNT(chokyoshimei), COUNT(*), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_chokyoshi_1', COUNT(seiseki_joho_chokyoshi_1), COUNT(*), ROUND(COUNT(seiseki_joho_chokyoshi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_chokyoshi_2', COUNT(seiseki_joho_chokyoshi_2), COUNT(*), ROUND(COUNT(seiseki_joho_chokyoshi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'banushi_code', COUNT(banushi_code), COUNT(*), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'banushimei_hojinkaku', COUNT(banushimei_hojinkaku), COUNT(*), ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'banushimei', COUNT(banushimei), COUNT(*), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_banushi_1', COUNT(seiseki_joho_banushi_1), COUNT(*), ROUND(COUNT(seiseki_joho_banushi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_banushi_2', COUNT(seiseki_joho_banushi_2), COUNT(*), ROUND(COUNT(seiseki_joho_banushi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seisansha_code', COUNT(seisansha_code), COUNT(*), ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seisanshamei_hojinkaku', COUNT(seisanshamei_hojinkaku), COUNT(*), ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seisanshamei', COUNT(seisanshamei), COUNT(*), ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_seisansha_1', COUNT(seiseki_joho_seisansha_1), COUNT(*), ROUND(COUNT(seiseki_joho_seisansha_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ck', 'seiseki_joho_seisansha_2', COUNT(seiseki_joho_seisansha_2), COUNT(*), ROUND(COUNT(seiseki_joho_seisansha_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ck WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 3. JVD_RA (62カラム)
-- ============================================================================
-- 実行後、結果を jvd_ra_fillrate.csv で保存してください

SELECT 'jvd_ra' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'yobi_code', COUNT(yobi_code), COUNT(*), ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'tokubetsu_kyoso_bango', COUNT(tokubetsu_kyoso_bango), COUNT(*), ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_hondai', COUNT(kyosomei_hondai), COUNT(*), ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_fukudai', COUNT(kyosomei_fukudai), COUNT(*), ROUND(COUNT(kyosomei_fukudai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_kakkonai', COUNT(kyosomei_kakkonai), COUNT(*), ROUND(COUNT(kyosomei_kakkonai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_hondai_eur', COUNT(kyosomei_hondai_eur), COUNT(*), ROUND(COUNT(kyosomei_hondai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_fukudai_eur', COUNT(kyosomei_fukudai_eur), COUNT(*), ROUND(COUNT(kyosomei_fukudai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_kakkonai_eur', COUNT(kyosomei_kakkonai_eur), COUNT(*), ROUND(COUNT(kyosomei_kakkonai_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_ryakusho_10', COUNT(kyosomei_ryakusho_10), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_10)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_ryakusho_6', COUNT(kyosomei_ryakusho_6), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_6)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_ryakusho_3', COUNT(kyosomei_ryakusho_3), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyosomei_kubun', COUNT(kyosomei_kubun), COUNT(*), ROUND(COUNT(kyosomei_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'jusho_kaiji', COUNT(jusho_kaiji), COUNT(*), ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'grade_code', COUNT(grade_code), COUNT(*), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'grade_code_henkomae', COUNT(grade_code_henkomae), COUNT(*), ROUND(COUNT(grade_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_shubetsu_code', COUNT(kyoso_shubetsu_code), COUNT(*), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_kigo_code', COUNT(kyoso_kigo_code), COUNT(*), ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'juryo_shubetsu_code', COUNT(juryo_shubetsu_code), COUNT(*), ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_code_2sai', COUNT(kyoso_joken_code_2sai), COUNT(*), ROUND(COUNT(kyoso_joken_code_2sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_code_3sai', COUNT(kyoso_joken_code_3sai), COUNT(*), ROUND(COUNT(kyoso_joken_code_3sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_code_4sai', COUNT(kyoso_joken_code_4sai), COUNT(*), ROUND(COUNT(kyoso_joken_code_4sai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_code_5sai_ijo', COUNT(kyoso_joken_code_5sai_ijo), COUNT(*), ROUND(COUNT(kyoso_joken_code_5sai_ijo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_code', COUNT(kyoso_joken_code), COUNT(*), ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyoso_joken_meisho', COUNT(kyoso_joken_meisho), COUNT(*), ROUND(COUNT(kyoso_joken_meisho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyori', COUNT(kyori), COUNT(*), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kyori_henkomae', COUNT(kyori_henkomae), COUNT(*), ROUND(COUNT(kyori_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'track_code', COUNT(track_code), COUNT(*), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'track_code_henkomae', COUNT(track_code_henkomae), COUNT(*), ROUND(COUNT(track_code_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'course_kubun', COUNT(course_kubun), COUNT(*), ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'course_kubun_henkomae', COUNT(course_kubun_henkomae), COUNT(*), ROUND(COUNT(course_kubun_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'honshokin', COUNT(honshokin), COUNT(*), ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'honshokin_henkomae', COUNT(honshokin_henkomae), COUNT(*), ROUND(COUNT(honshokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'fukashokin', COUNT(fukashokin), COUNT(*), ROUND(COUNT(fukashokin)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'fukashokin_henkomae', COUNT(fukashokin_henkomae), COUNT(*), ROUND(COUNT(fukashokin_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'hasso_jikoku', COUNT(hasso_jikoku), COUNT(*), ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'hasso_jikoku_henkomae', COUNT(hasso_jikoku_henkomae), COUNT(*), ROUND(COUNT(hasso_jikoku_henkomae)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'nyusen_tosu', COUNT(nyusen_tosu), COUNT(*), ROUND(COUNT(nyusen_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'tenko_code', COUNT(tenko_code), COUNT(*), ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'babajotai_code_shiba', COUNT(babajotai_code_shiba), COUNT(*), ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'babajotai_code_dirt', COUNT(babajotai_code_dirt), COUNT(*), ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'lap_time', COUNT(lap_time), COUNT(*), ROUND(COUNT(lap_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'shogai_mile_time', COUNT(shogai_mile_time), COUNT(*), ROUND(COUNT(shogai_mile_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'zenhan_3f', COUNT(zenhan_3f), COUNT(*), ROUND(COUNT(zenhan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'zenhan_4f', COUNT(zenhan_4f), COUNT(*), ROUND(COUNT(zenhan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kohan_3f', COUNT(kohan_3f), COUNT(*), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'kohan_4f', COUNT(kohan_4f), COUNT(*), ROUND(COUNT(kohan_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'corner_tsuka_juni_1', COUNT(corner_tsuka_juni_1), COUNT(*), ROUND(COUNT(corner_tsuka_juni_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'corner_tsuka_juni_2', COUNT(corner_tsuka_juni_2), COUNT(*), ROUND(COUNT(corner_tsuka_juni_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'corner_tsuka_juni_3', COUNT(corner_tsuka_juni_3), COUNT(*), ROUND(COUNT(corner_tsuka_juni_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'corner_tsuka_juni_4', COUNT(corner_tsuka_juni_4), COUNT(*), ROUND(COUNT(corner_tsuka_juni_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_ra', 'record_koshin_kubun', COUNT(record_koshin_kubun), COUNT(*), ROUND(COUNT(record_koshin_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ra WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 4. JVD_HR (158カラム)
-- ============================================================================
-- 実行後、結果を jvd_hr_fillrate.csv で保存してください

SELECT 'jvd_hr' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_tansho', COUNT(fuseiritsu_flag_tansho), COUNT(*), ROUND(COUNT(fuseiritsu_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_fukusho', COUNT(fuseiritsu_flag_fukusho), COUNT(*), ROUND(COUNT(fuseiritsu_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_wakuren', COUNT(fuseiritsu_flag_wakuren), COUNT(*), ROUND(COUNT(fuseiritsu_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_umaren', COUNT(fuseiritsu_flag_umaren), COUNT(*), ROUND(COUNT(fuseiritsu_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_wide', COUNT(fuseiritsu_flag_wide), COUNT(*), ROUND(COUNT(fuseiritsu_flag_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_umatan', COUNT(fuseiritsu_flag_umatan), COUNT(*), ROUND(COUNT(fuseiritsu_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_sanrenpuku', COUNT(fuseiritsu_flag_sanrenpuku), COUNT(*), ROUND(COUNT(fuseiritsu_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'fuseiritsu_flag_sanrentan', COUNT(fuseiritsu_flag_sanrentan), COUNT(*), ROUND(COUNT(fuseiritsu_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_tansho', COUNT(tokubarai_flag_tansho), COUNT(*), ROUND(COUNT(tokubarai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_fukusho', COUNT(tokubarai_flag_fukusho), COUNT(*), ROUND(COUNT(tokubarai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_wakuren', COUNT(tokubarai_flag_wakuren), COUNT(*), ROUND(COUNT(tokubarai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_umaren', COUNT(tokubarai_flag_umaren), COUNT(*), ROUND(COUNT(tokubarai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_wide', COUNT(tokubarai_flag_wide), COUNT(*), ROUND(COUNT(tokubarai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_2', COUNT(yobi_2), COUNT(*), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_umatan', COUNT(tokubarai_flag_umatan), COUNT(*), ROUND(COUNT(tokubarai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_sanrenpuku', COUNT(tokubarai_flag_sanrenpuku), COUNT(*), ROUND(COUNT(tokubarai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'tokubarai_flag_sanrentan', COUNT(tokubarai_flag_sanrentan), COUNT(*), ROUND(COUNT(tokubarai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_tansho', COUNT(henkan_flag_tansho), COUNT(*), ROUND(COUNT(henkan_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_fukusho', COUNT(henkan_flag_fukusho), COUNT(*), ROUND(COUNT(henkan_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_wakuren', COUNT(henkan_flag_wakuren), COUNT(*), ROUND(COUNT(henkan_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_umaren', COUNT(henkan_flag_umaren), COUNT(*), ROUND(COUNT(henkan_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_wide', COUNT(henkan_flag_wide), COUNT(*), ROUND(COUNT(henkan_flag_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_3', COUNT(yobi_3), COUNT(*), ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_umatan', COUNT(henkan_flag_umatan), COUNT(*), ROUND(COUNT(henkan_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_sanrenpuku', COUNT(henkan_flag_sanrenpuku), COUNT(*), ROUND(COUNT(henkan_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_flag_sanrentan', COUNT(henkan_flag_sanrentan), COUNT(*), ROUND(COUNT(henkan_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_umaban_joho', COUNT(henkan_umaban_joho), COUNT(*), ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_wakuban_joho', COUNT(henkan_wakuban_joho), COUNT(*), ROUND(COUNT(henkan_wakuban_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'henkan_dowaku_joho', COUNT(henkan_dowaku_joho), COUNT(*), ROUND(COUNT(henkan_dowaku_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_1a', COUNT(haraimodoshi_tansho_1a), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_1b', COUNT(haraimodoshi_tansho_1b), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_1c', COUNT(haraimodoshi_tansho_1c), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_2a', COUNT(haraimodoshi_tansho_2a), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_2b', COUNT(haraimodoshi_tansho_2b), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_2c', COUNT(haraimodoshi_tansho_2c), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_3a', COUNT(haraimodoshi_tansho_3a), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_3b', COUNT(haraimodoshi_tansho_3b), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_tansho_3c', COUNT(haraimodoshi_tansho_3c), COUNT(*), ROUND(COUNT(haraimodoshi_tansho_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_1a', COUNT(haraimodoshi_fukusho_1a), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_1b', COUNT(haraimodoshi_fukusho_1b), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_1c', COUNT(haraimodoshi_fukusho_1c), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_2a', COUNT(haraimodoshi_fukusho_2a), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_2b', COUNT(haraimodoshi_fukusho_2b), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_2c', COUNT(haraimodoshi_fukusho_2c), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_3a', COUNT(haraimodoshi_fukusho_3a), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_3b', COUNT(haraimodoshi_fukusho_3b), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_3c', COUNT(haraimodoshi_fukusho_3c), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_4a', COUNT(haraimodoshi_fukusho_4a), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_4a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_4b', COUNT(haraimodoshi_fukusho_4b), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_4b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_4c', COUNT(haraimodoshi_fukusho_4c), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_4c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_5a', COUNT(haraimodoshi_fukusho_5a), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_5a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_5b', COUNT(haraimodoshi_fukusho_5b), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_5b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_fukusho_5c', COUNT(haraimodoshi_fukusho_5c), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho_5c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_1a', COUNT(haraimodoshi_wakuren_1a), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_1b', COUNT(haraimodoshi_wakuren_1b), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_1c', COUNT(haraimodoshi_wakuren_1c), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_2a', COUNT(haraimodoshi_wakuren_2a), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_2b', COUNT(haraimodoshi_wakuren_2b), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_2c', COUNT(haraimodoshi_wakuren_2c), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_3a', COUNT(haraimodoshi_wakuren_3a), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_3b', COUNT(haraimodoshi_wakuren_3b), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wakuren_3c', COUNT(haraimodoshi_wakuren_3c), COUNT(*), ROUND(COUNT(haraimodoshi_wakuren_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_1a', COUNT(haraimodoshi_umaren_1a), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_1b', COUNT(haraimodoshi_umaren_1b), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_1c', COUNT(haraimodoshi_umaren_1c), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_2a', COUNT(haraimodoshi_umaren_2a), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_2b', COUNT(haraimodoshi_umaren_2b), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_2c', COUNT(haraimodoshi_umaren_2c), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_3a', COUNT(haraimodoshi_umaren_3a), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_3b', COUNT(haraimodoshi_umaren_3b), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umaren_3c', COUNT(haraimodoshi_umaren_3c), COUNT(*), ROUND(COUNT(haraimodoshi_umaren_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_1a', COUNT(haraimodoshi_wide_1a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_1b', COUNT(haraimodoshi_wide_1b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_1c', COUNT(haraimodoshi_wide_1c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_2a', COUNT(haraimodoshi_wide_2a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_2b', COUNT(haraimodoshi_wide_2b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_2c', COUNT(haraimodoshi_wide_2c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_3a', COUNT(haraimodoshi_wide_3a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_3b', COUNT(haraimodoshi_wide_3b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_3c', COUNT(haraimodoshi_wide_3c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_4a', COUNT(haraimodoshi_wide_4a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_4a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_4b', COUNT(haraimodoshi_wide_4b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_4b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_4c', COUNT(haraimodoshi_wide_4c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_4c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_5a', COUNT(haraimodoshi_wide_5a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_5a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_5b', COUNT(haraimodoshi_wide_5b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_5b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_5c', COUNT(haraimodoshi_wide_5c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_5c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_6a', COUNT(haraimodoshi_wide_6a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_6a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_6b', COUNT(haraimodoshi_wide_6b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_6b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_6c', COUNT(haraimodoshi_wide_6c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_6c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_7a', COUNT(haraimodoshi_wide_7a), COUNT(*), ROUND(COUNT(haraimodoshi_wide_7a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_7b', COUNT(haraimodoshi_wide_7b), COUNT(*), ROUND(COUNT(haraimodoshi_wide_7b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_wide_7c', COUNT(haraimodoshi_wide_7c), COUNT(*), ROUND(COUNT(haraimodoshi_wide_7c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_1a', COUNT(yobi_4_1a), COUNT(*), ROUND(COUNT(yobi_4_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_1b', COUNT(yobi_4_1b), COUNT(*), ROUND(COUNT(yobi_4_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_1c', COUNT(yobi_4_1c), COUNT(*), ROUND(COUNT(yobi_4_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_2a', COUNT(yobi_4_2a), COUNT(*), ROUND(COUNT(yobi_4_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_2b', COUNT(yobi_4_2b), COUNT(*), ROUND(COUNT(yobi_4_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_2c', COUNT(yobi_4_2c), COUNT(*), ROUND(COUNT(yobi_4_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_3a', COUNT(yobi_4_3a), COUNT(*), ROUND(COUNT(yobi_4_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_3b', COUNT(yobi_4_3b), COUNT(*), ROUND(COUNT(yobi_4_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'yobi_4_3c', COUNT(yobi_4_3c), COUNT(*), ROUND(COUNT(yobi_4_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_1a', COUNT(haraimodoshi_umatan_1a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_1b', COUNT(haraimodoshi_umatan_1b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_1c', COUNT(haraimodoshi_umatan_1c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_2a', COUNT(haraimodoshi_umatan_2a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_2b', COUNT(haraimodoshi_umatan_2b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_2c', COUNT(haraimodoshi_umatan_2c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_3a', COUNT(haraimodoshi_umatan_3a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_3b', COUNT(haraimodoshi_umatan_3b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_3c', COUNT(haraimodoshi_umatan_3c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_4a', COUNT(haraimodoshi_umatan_4a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_4a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_4b', COUNT(haraimodoshi_umatan_4b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_4b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_4c', COUNT(haraimodoshi_umatan_4c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_4c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_5a', COUNT(haraimodoshi_umatan_5a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_5a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_5b', COUNT(haraimodoshi_umatan_5b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_5b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_5c', COUNT(haraimodoshi_umatan_5c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_5c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_6a', COUNT(haraimodoshi_umatan_6a), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_6a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_6b', COUNT(haraimodoshi_umatan_6b), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_6b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_umatan_6c', COUNT(haraimodoshi_umatan_6c), COUNT(*), ROUND(COUNT(haraimodoshi_umatan_6c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_1a', COUNT(haraimodoshi_sanrenpuku_1a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_1b', COUNT(haraimodoshi_sanrenpuku_1b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_1c', COUNT(haraimodoshi_sanrenpuku_1c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_2a', COUNT(haraimodoshi_sanrenpuku_2a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_2b', COUNT(haraimodoshi_sanrenpuku_2b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_2c', COUNT(haraimodoshi_sanrenpuku_2c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_3a', COUNT(haraimodoshi_sanrenpuku_3a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_3b', COUNT(haraimodoshi_sanrenpuku_3b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrenpuku_3c', COUNT(haraimodoshi_sanrenpuku_3c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrenpuku_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_1a', COUNT(haraimodoshi_sanrentan_1a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_1a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_1b', COUNT(haraimodoshi_sanrentan_1b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_1b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_1c', COUNT(haraimodoshi_sanrentan_1c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_1c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_2a', COUNT(haraimodoshi_sanrentan_2a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_2a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_2b', COUNT(haraimodoshi_sanrentan_2b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_2b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_2c', COUNT(haraimodoshi_sanrentan_2c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_2c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_3a', COUNT(haraimodoshi_sanrentan_3a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_3a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_3b', COUNT(haraimodoshi_sanrentan_3b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_3b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_3c', COUNT(haraimodoshi_sanrentan_3c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_3c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_4a', COUNT(haraimodoshi_sanrentan_4a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_4a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_4b', COUNT(haraimodoshi_sanrentan_4b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_4b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_4c', COUNT(haraimodoshi_sanrentan_4c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_4c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_5a', COUNT(haraimodoshi_sanrentan_5a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_5a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_5b', COUNT(haraimodoshi_sanrentan_5b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_5b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_5c', COUNT(haraimodoshi_sanrentan_5c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_5c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_6a', COUNT(haraimodoshi_sanrentan_6a), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_6a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_6b', COUNT(haraimodoshi_sanrentan_6b), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_6b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_hr', 'haraimodoshi_sanrentan_6c', COUNT(haraimodoshi_sanrentan_6c), COUNT(*), ROUND(COUNT(haraimodoshi_sanrentan_6c)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hr WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 5. JVD_H1 (43カラム)
-- ============================================================================
-- 実行後、結果を jvd_h1_fillrate.csv で保存してください

SELECT 'jvd_h1' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_tansho', COUNT(hatsubai_flag_tansho), COUNT(*), ROUND(COUNT(hatsubai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_fukusho', COUNT(hatsubai_flag_fukusho), COUNT(*), ROUND(COUNT(hatsubai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_wakuren', COUNT(hatsubai_flag_wakuren), COUNT(*), ROUND(COUNT(hatsubai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_umaren', COUNT(hatsubai_flag_umaren), COUNT(*), ROUND(COUNT(hatsubai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_wide', COUNT(hatsubai_flag_wide), COUNT(*), ROUND(COUNT(hatsubai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_umatan', COUNT(hatsubai_flag_umatan), COUNT(*), ROUND(COUNT(hatsubai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hatsubai_flag_sanrenpuku', COUNT(hatsubai_flag_sanrenpuku), COUNT(*), ROUND(COUNT(hatsubai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'fukusho_chakubarai_key', COUNT(fukusho_chakubarai_key), COUNT(*), ROUND(COUNT(fukusho_chakubarai_key)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_umaban_joho', COUNT(henkan_umaban_joho), COUNT(*), ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_wakuban_joho', COUNT(henkan_wakuban_joho), COUNT(*), ROUND(COUNT(henkan_wakuban_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_dowaku_joho', COUNT(henkan_dowaku_joho), COUNT(*), ROUND(COUNT(henkan_dowaku_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_tansho', COUNT(hyosu_tansho), COUNT(*), ROUND(COUNT(hyosu_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_fukusho', COUNT(hyosu_fukusho), COUNT(*), ROUND(COUNT(hyosu_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_wakuren', COUNT(hyosu_wakuren), COUNT(*), ROUND(COUNT(hyosu_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_umaren', COUNT(hyosu_umaren), COUNT(*), ROUND(COUNT(hyosu_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_wide', COUNT(hyosu_wide), COUNT(*), ROUND(COUNT(hyosu_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_umatan', COUNT(hyosu_umatan), COUNT(*), ROUND(COUNT(hyosu_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_sanrenpuku', COUNT(hyosu_sanrenpuku), COUNT(*), ROUND(COUNT(hyosu_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_tansho', COUNT(hyosu_gokei_tansho), COUNT(*), ROUND(COUNT(hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_fukusho', COUNT(hyosu_gokei_fukusho), COUNT(*), ROUND(COUNT(hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_wakuren', COUNT(hyosu_gokei_wakuren), COUNT(*), ROUND(COUNT(hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_umaren', COUNT(hyosu_gokei_umaren), COUNT(*), ROUND(COUNT(hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_wide', COUNT(hyosu_gokei_wide), COUNT(*), ROUND(COUNT(hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_umatan', COUNT(hyosu_gokei_umatan), COUNT(*), ROUND(COUNT(hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'hyosu_gokei_sanrenpuku', COUNT(hyosu_gokei_sanrenpuku), COUNT(*), ROUND(COUNT(hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_tansho', COUNT(henkan_hyosu_gokei_tansho), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_fukusho', COUNT(henkan_hyosu_gokei_fukusho), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_wakuren', COUNT(henkan_hyosu_gokei_wakuren), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_umaren', COUNT(henkan_hyosu_gokei_umaren), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_wide', COUNT(henkan_hyosu_gokei_wide), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_umatan', COUNT(henkan_hyosu_gokei_umatan), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h1', 'henkan_hyosu_gokei_sanrenpuku', COUNT(henkan_hyosu_gokei_sanrenpuku), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h1 WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 6. JVD_H6 (16カラム)
-- ============================================================================
-- 実行後、結果を jvd_h6_fillrate.csv で保存してください

SELECT 'jvd_h6' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'hatsubai_flag_sanrentan', COUNT(hatsubai_flag_sanrentan), COUNT(*), ROUND(COUNT(hatsubai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'henkan_umaban_joho', COUNT(henkan_umaban_joho), COUNT(*), ROUND(COUNT(henkan_umaban_joho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'hyosu_sanrentan', COUNT(hyosu_sanrentan), COUNT(*), ROUND(COUNT(hyosu_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'hyosu_gokei_sanrentan', COUNT(hyosu_gokei_sanrentan), COUNT(*), ROUND(COUNT(hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_h6', 'henkan_hyosu_gokei_sanrentan', COUNT(henkan_hyosu_gokei_sanrentan), COUNT(*), ROUND(COUNT(henkan_hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_h6 WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 7. JVD_DM (28カラム)
-- ============================================================================
-- 実行後、結果を jvd_dm_fillrate.csv で保存してください

SELECT 'jvd_dm' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'data_sakusei_jifun', COUNT(data_sakusei_jifun), COUNT(*), ROUND(COUNT(data_sakusei_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_01', COUNT(mining_yoso_01), COUNT(*), ROUND(COUNT(mining_yoso_01)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_02', COUNT(mining_yoso_02), COUNT(*), ROUND(COUNT(mining_yoso_02)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_03', COUNT(mining_yoso_03), COUNT(*), ROUND(COUNT(mining_yoso_03)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_04', COUNT(mining_yoso_04), COUNT(*), ROUND(COUNT(mining_yoso_04)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_05', COUNT(mining_yoso_05), COUNT(*), ROUND(COUNT(mining_yoso_05)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_06', COUNT(mining_yoso_06), COUNT(*), ROUND(COUNT(mining_yoso_06)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_07', COUNT(mining_yoso_07), COUNT(*), ROUND(COUNT(mining_yoso_07)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_08', COUNT(mining_yoso_08), COUNT(*), ROUND(COUNT(mining_yoso_08)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_09', COUNT(mining_yoso_09), COUNT(*), ROUND(COUNT(mining_yoso_09)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_10', COUNT(mining_yoso_10), COUNT(*), ROUND(COUNT(mining_yoso_10)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_11', COUNT(mining_yoso_11), COUNT(*), ROUND(COUNT(mining_yoso_11)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_12', COUNT(mining_yoso_12), COUNT(*), ROUND(COUNT(mining_yoso_12)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_13', COUNT(mining_yoso_13), COUNT(*), ROUND(COUNT(mining_yoso_13)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_14', COUNT(mining_yoso_14), COUNT(*), ROUND(COUNT(mining_yoso_14)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_15', COUNT(mining_yoso_15), COUNT(*), ROUND(COUNT(mining_yoso_15)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_16', COUNT(mining_yoso_16), COUNT(*), ROUND(COUNT(mining_yoso_16)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_17', COUNT(mining_yoso_17), COUNT(*), ROUND(COUNT(mining_yoso_17)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_dm', 'mining_yoso_18', COUNT(mining_yoso_18), COUNT(*), ROUND(COUNT(mining_yoso_18)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_dm WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 8. JVD_WF (266カラム)
-- ============================================================================
-- 実行後、結果を jvd_wf_fillrate.csv で保存してください

SELECT 'jvd_wf' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'race_joho_1', COUNT(race_joho_1), COUNT(*), ROUND(COUNT(race_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'race_joho_2', COUNT(race_joho_2), COUNT(*), ROUND(COUNT(race_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'race_joho_3', COUNT(race_joho_3), COUNT(*), ROUND(COUNT(race_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'race_joho_4', COUNT(race_joho_4), COUNT(*), ROUND(COUNT(race_joho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'race_joho_5', COUNT(race_joho_5), COUNT(*), ROUND(COUNT(race_joho_5)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yobi_2', COUNT(yobi_2), COUNT(*), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'win5_hyosu_gokei', COUNT(win5_hyosu_gokei), COUNT(*), ROUND(COUNT(win5_hyosu_gokei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yuko_hyosu_1', COUNT(yuko_hyosu_1), COUNT(*), ROUND(COUNT(yuko_hyosu_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yuko_hyosu_2', COUNT(yuko_hyosu_2), COUNT(*), ROUND(COUNT(yuko_hyosu_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yuko_hyosu_3', COUNT(yuko_hyosu_3), COUNT(*), ROUND(COUNT(yuko_hyosu_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yuko_hyosu_4', COUNT(yuko_hyosu_4), COUNT(*), ROUND(COUNT(yuko_hyosu_4)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'yuko_hyosu_5', COUNT(yuko_hyosu_5), COUNT(*), ROUND(COUNT(yuko_hyosu_5)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'henkan_flag', COUNT(henkan_flag), COUNT(*), ROUND(COUNT(henkan_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'fuseiritsu_flag', COUNT(fuseiritsu_flag), COUNT(*), ROUND(COUNT(fuseiritsu_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'tekichu_nashi_flag', COUNT(tekichu_nashi_flag), COUNT(*), ROUND(COUNT(tekichu_nashi_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'carry_over', COUNT(carry_over), COUNT(*), ROUND(COUNT(carry_over)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'carry_over_zandaka', COUNT(carry_over_zandaka), COUNT(*), ROUND(COUNT(carry_over_zandaka)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_001', COUNT(haraimodoshi_win5_001), COUNT(*), ROUND(COUNT(haraimodoshi_win5_001)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_002', COUNT(haraimodoshi_win5_002), COUNT(*), ROUND(COUNT(haraimodoshi_win5_002)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_003', COUNT(haraimodoshi_win5_003), COUNT(*), ROUND(COUNT(haraimodoshi_win5_003)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_004', COUNT(haraimodoshi_win5_004), COUNT(*), ROUND(COUNT(haraimodoshi_win5_004)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_005', COUNT(haraimodoshi_win5_005), COUNT(*), ROUND(COUNT(haraimodoshi_win5_005)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_006', COUNT(haraimodoshi_win5_006), COUNT(*), ROUND(COUNT(haraimodoshi_win5_006)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_007', COUNT(haraimodoshi_win5_007), COUNT(*), ROUND(COUNT(haraimodoshi_win5_007)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_008', COUNT(haraimodoshi_win5_008), COUNT(*), ROUND(COUNT(haraimodoshi_win5_008)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_009', COUNT(haraimodoshi_win5_009), COUNT(*), ROUND(COUNT(haraimodoshi_win5_009)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_010', COUNT(haraimodoshi_win5_010), COUNT(*), ROUND(COUNT(haraimodoshi_win5_010)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_011', COUNT(haraimodoshi_win5_011), COUNT(*), ROUND(COUNT(haraimodoshi_win5_011)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_012', COUNT(haraimodoshi_win5_012), COUNT(*), ROUND(COUNT(haraimodoshi_win5_012)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_013', COUNT(haraimodoshi_win5_013), COUNT(*), ROUND(COUNT(haraimodoshi_win5_013)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_014', COUNT(haraimodoshi_win5_014), COUNT(*), ROUND(COUNT(haraimodoshi_win5_014)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_015', COUNT(haraimodoshi_win5_015), COUNT(*), ROUND(COUNT(haraimodoshi_win5_015)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_016', COUNT(haraimodoshi_win5_016), COUNT(*), ROUND(COUNT(haraimodoshi_win5_016)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_017', COUNT(haraimodoshi_win5_017), COUNT(*), ROUND(COUNT(haraimodoshi_win5_017)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_018', COUNT(haraimodoshi_win5_018), COUNT(*), ROUND(COUNT(haraimodoshi_win5_018)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_019', COUNT(haraimodoshi_win5_019), COUNT(*), ROUND(COUNT(haraimodoshi_win5_019)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_020', COUNT(haraimodoshi_win5_020), COUNT(*), ROUND(COUNT(haraimodoshi_win5_020)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_021', COUNT(haraimodoshi_win5_021), COUNT(*), ROUND(COUNT(haraimodoshi_win5_021)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_022', COUNT(haraimodoshi_win5_022), COUNT(*), ROUND(COUNT(haraimodoshi_win5_022)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_023', COUNT(haraimodoshi_win5_023), COUNT(*), ROUND(COUNT(haraimodoshi_win5_023)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_024', COUNT(haraimodoshi_win5_024), COUNT(*), ROUND(COUNT(haraimodoshi_win5_024)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_025', COUNT(haraimodoshi_win5_025), COUNT(*), ROUND(COUNT(haraimodoshi_win5_025)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_026', COUNT(haraimodoshi_win5_026), COUNT(*), ROUND(COUNT(haraimodoshi_win5_026)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_027', COUNT(haraimodoshi_win5_027), COUNT(*), ROUND(COUNT(haraimodoshi_win5_027)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_028', COUNT(haraimodoshi_win5_028), COUNT(*), ROUND(COUNT(haraimodoshi_win5_028)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_029', COUNT(haraimodoshi_win5_029), COUNT(*), ROUND(COUNT(haraimodoshi_win5_029)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_030', COUNT(haraimodoshi_win5_030), COUNT(*), ROUND(COUNT(haraimodoshi_win5_030)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_031', COUNT(haraimodoshi_win5_031), COUNT(*), ROUND(COUNT(haraimodoshi_win5_031)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_032', COUNT(haraimodoshi_win5_032), COUNT(*), ROUND(COUNT(haraimodoshi_win5_032)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_033', COUNT(haraimodoshi_win5_033), COUNT(*), ROUND(COUNT(haraimodoshi_win5_033)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_034', COUNT(haraimodoshi_win5_034), COUNT(*), ROUND(COUNT(haraimodoshi_win5_034)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_035', COUNT(haraimodoshi_win5_035), COUNT(*), ROUND(COUNT(haraimodoshi_win5_035)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_036', COUNT(haraimodoshi_win5_036), COUNT(*), ROUND(COUNT(haraimodoshi_win5_036)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_037', COUNT(haraimodoshi_win5_037), COUNT(*), ROUND(COUNT(haraimodoshi_win5_037)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_038', COUNT(haraimodoshi_win5_038), COUNT(*), ROUND(COUNT(haraimodoshi_win5_038)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_039', COUNT(haraimodoshi_win5_039), COUNT(*), ROUND(COUNT(haraimodoshi_win5_039)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_040', COUNT(haraimodoshi_win5_040), COUNT(*), ROUND(COUNT(haraimodoshi_win5_040)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_041', COUNT(haraimodoshi_win5_041), COUNT(*), ROUND(COUNT(haraimodoshi_win5_041)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_042', COUNT(haraimodoshi_win5_042), COUNT(*), ROUND(COUNT(haraimodoshi_win5_042)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_043', COUNT(haraimodoshi_win5_043), COUNT(*), ROUND(COUNT(haraimodoshi_win5_043)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_044', COUNT(haraimodoshi_win5_044), COUNT(*), ROUND(COUNT(haraimodoshi_win5_044)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_045', COUNT(haraimodoshi_win5_045), COUNT(*), ROUND(COUNT(haraimodoshi_win5_045)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_046', COUNT(haraimodoshi_win5_046), COUNT(*), ROUND(COUNT(haraimodoshi_win5_046)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_047', COUNT(haraimodoshi_win5_047), COUNT(*), ROUND(COUNT(haraimodoshi_win5_047)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_048', COUNT(haraimodoshi_win5_048), COUNT(*), ROUND(COUNT(haraimodoshi_win5_048)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_049', COUNT(haraimodoshi_win5_049), COUNT(*), ROUND(COUNT(haraimodoshi_win5_049)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_050', COUNT(haraimodoshi_win5_050), COUNT(*), ROUND(COUNT(haraimodoshi_win5_050)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_051', COUNT(haraimodoshi_win5_051), COUNT(*), ROUND(COUNT(haraimodoshi_win5_051)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_052', COUNT(haraimodoshi_win5_052), COUNT(*), ROUND(COUNT(haraimodoshi_win5_052)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_053', COUNT(haraimodoshi_win5_053), COUNT(*), ROUND(COUNT(haraimodoshi_win5_053)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_054', COUNT(haraimodoshi_win5_054), COUNT(*), ROUND(COUNT(haraimodoshi_win5_054)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_055', COUNT(haraimodoshi_win5_055), COUNT(*), ROUND(COUNT(haraimodoshi_win5_055)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_056', COUNT(haraimodoshi_win5_056), COUNT(*), ROUND(COUNT(haraimodoshi_win5_056)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_057', COUNT(haraimodoshi_win5_057), COUNT(*), ROUND(COUNT(haraimodoshi_win5_057)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_058', COUNT(haraimodoshi_win5_058), COUNT(*), ROUND(COUNT(haraimodoshi_win5_058)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_059', COUNT(haraimodoshi_win5_059), COUNT(*), ROUND(COUNT(haraimodoshi_win5_059)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_060', COUNT(haraimodoshi_win5_060), COUNT(*), ROUND(COUNT(haraimodoshi_win5_060)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_061', COUNT(haraimodoshi_win5_061), COUNT(*), ROUND(COUNT(haraimodoshi_win5_061)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_062', COUNT(haraimodoshi_win5_062), COUNT(*), ROUND(COUNT(haraimodoshi_win5_062)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_063', COUNT(haraimodoshi_win5_063), COUNT(*), ROUND(COUNT(haraimodoshi_win5_063)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_064', COUNT(haraimodoshi_win5_064), COUNT(*), ROUND(COUNT(haraimodoshi_win5_064)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_065', COUNT(haraimodoshi_win5_065), COUNT(*), ROUND(COUNT(haraimodoshi_win5_065)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_066', COUNT(haraimodoshi_win5_066), COUNT(*), ROUND(COUNT(haraimodoshi_win5_066)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_067', COUNT(haraimodoshi_win5_067), COUNT(*), ROUND(COUNT(haraimodoshi_win5_067)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_068', COUNT(haraimodoshi_win5_068), COUNT(*), ROUND(COUNT(haraimodoshi_win5_068)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_069', COUNT(haraimodoshi_win5_069), COUNT(*), ROUND(COUNT(haraimodoshi_win5_069)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_070', COUNT(haraimodoshi_win5_070), COUNT(*), ROUND(COUNT(haraimodoshi_win5_070)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_071', COUNT(haraimodoshi_win5_071), COUNT(*), ROUND(COUNT(haraimodoshi_win5_071)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_072', COUNT(haraimodoshi_win5_072), COUNT(*), ROUND(COUNT(haraimodoshi_win5_072)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_073', COUNT(haraimodoshi_win5_073), COUNT(*), ROUND(COUNT(haraimodoshi_win5_073)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_074', COUNT(haraimodoshi_win5_074), COUNT(*), ROUND(COUNT(haraimodoshi_win5_074)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_075', COUNT(haraimodoshi_win5_075), COUNT(*), ROUND(COUNT(haraimodoshi_win5_075)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_076', COUNT(haraimodoshi_win5_076), COUNT(*), ROUND(COUNT(haraimodoshi_win5_076)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_077', COUNT(haraimodoshi_win5_077), COUNT(*), ROUND(COUNT(haraimodoshi_win5_077)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_078', COUNT(haraimodoshi_win5_078), COUNT(*), ROUND(COUNT(haraimodoshi_win5_078)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_079', COUNT(haraimodoshi_win5_079), COUNT(*), ROUND(COUNT(haraimodoshi_win5_079)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_080', COUNT(haraimodoshi_win5_080), COUNT(*), ROUND(COUNT(haraimodoshi_win5_080)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_081', COUNT(haraimodoshi_win5_081), COUNT(*), ROUND(COUNT(haraimodoshi_win5_081)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_082', COUNT(haraimodoshi_win5_082), COUNT(*), ROUND(COUNT(haraimodoshi_win5_082)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_083', COUNT(haraimodoshi_win5_083), COUNT(*), ROUND(COUNT(haraimodoshi_win5_083)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_084', COUNT(haraimodoshi_win5_084), COUNT(*), ROUND(COUNT(haraimodoshi_win5_084)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_085', COUNT(haraimodoshi_win5_085), COUNT(*), ROUND(COUNT(haraimodoshi_win5_085)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_086', COUNT(haraimodoshi_win5_086), COUNT(*), ROUND(COUNT(haraimodoshi_win5_086)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_087', COUNT(haraimodoshi_win5_087), COUNT(*), ROUND(COUNT(haraimodoshi_win5_087)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_088', COUNT(haraimodoshi_win5_088), COUNT(*), ROUND(COUNT(haraimodoshi_win5_088)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_089', COUNT(haraimodoshi_win5_089), COUNT(*), ROUND(COUNT(haraimodoshi_win5_089)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_090', COUNT(haraimodoshi_win5_090), COUNT(*), ROUND(COUNT(haraimodoshi_win5_090)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_091', COUNT(haraimodoshi_win5_091), COUNT(*), ROUND(COUNT(haraimodoshi_win5_091)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_092', COUNT(haraimodoshi_win5_092), COUNT(*), ROUND(COUNT(haraimodoshi_win5_092)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_093', COUNT(haraimodoshi_win5_093), COUNT(*), ROUND(COUNT(haraimodoshi_win5_093)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_094', COUNT(haraimodoshi_win5_094), COUNT(*), ROUND(COUNT(haraimodoshi_win5_094)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_095', COUNT(haraimodoshi_win5_095), COUNT(*), ROUND(COUNT(haraimodoshi_win5_095)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_096', COUNT(haraimodoshi_win5_096), COUNT(*), ROUND(COUNT(haraimodoshi_win5_096)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_097', COUNT(haraimodoshi_win5_097), COUNT(*), ROUND(COUNT(haraimodoshi_win5_097)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_098', COUNT(haraimodoshi_win5_098), COUNT(*), ROUND(COUNT(haraimodoshi_win5_098)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_099', COUNT(haraimodoshi_win5_099), COUNT(*), ROUND(COUNT(haraimodoshi_win5_099)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_100', COUNT(haraimodoshi_win5_100), COUNT(*), ROUND(COUNT(haraimodoshi_win5_100)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_101', COUNT(haraimodoshi_win5_101), COUNT(*), ROUND(COUNT(haraimodoshi_win5_101)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_102', COUNT(haraimodoshi_win5_102), COUNT(*), ROUND(COUNT(haraimodoshi_win5_102)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_103', COUNT(haraimodoshi_win5_103), COUNT(*), ROUND(COUNT(haraimodoshi_win5_103)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_104', COUNT(haraimodoshi_win5_104), COUNT(*), ROUND(COUNT(haraimodoshi_win5_104)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_105', COUNT(haraimodoshi_win5_105), COUNT(*), ROUND(COUNT(haraimodoshi_win5_105)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_106', COUNT(haraimodoshi_win5_106), COUNT(*), ROUND(COUNT(haraimodoshi_win5_106)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_107', COUNT(haraimodoshi_win5_107), COUNT(*), ROUND(COUNT(haraimodoshi_win5_107)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_108', COUNT(haraimodoshi_win5_108), COUNT(*), ROUND(COUNT(haraimodoshi_win5_108)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_109', COUNT(haraimodoshi_win5_109), COUNT(*), ROUND(COUNT(haraimodoshi_win5_109)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_110', COUNT(haraimodoshi_win5_110), COUNT(*), ROUND(COUNT(haraimodoshi_win5_110)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_111', COUNT(haraimodoshi_win5_111), COUNT(*), ROUND(COUNT(haraimodoshi_win5_111)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_112', COUNT(haraimodoshi_win5_112), COUNT(*), ROUND(COUNT(haraimodoshi_win5_112)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_113', COUNT(haraimodoshi_win5_113), COUNT(*), ROUND(COUNT(haraimodoshi_win5_113)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_114', COUNT(haraimodoshi_win5_114), COUNT(*), ROUND(COUNT(haraimodoshi_win5_114)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_115', COUNT(haraimodoshi_win5_115), COUNT(*), ROUND(COUNT(haraimodoshi_win5_115)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_116', COUNT(haraimodoshi_win5_116), COUNT(*), ROUND(COUNT(haraimodoshi_win5_116)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_117', COUNT(haraimodoshi_win5_117), COUNT(*), ROUND(COUNT(haraimodoshi_win5_117)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_118', COUNT(haraimodoshi_win5_118), COUNT(*), ROUND(COUNT(haraimodoshi_win5_118)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_119', COUNT(haraimodoshi_win5_119), COUNT(*), ROUND(COUNT(haraimodoshi_win5_119)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_120', COUNT(haraimodoshi_win5_120), COUNT(*), ROUND(COUNT(haraimodoshi_win5_120)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_121', COUNT(haraimodoshi_win5_121), COUNT(*), ROUND(COUNT(haraimodoshi_win5_121)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_122', COUNT(haraimodoshi_win5_122), COUNT(*), ROUND(COUNT(haraimodoshi_win5_122)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_123', COUNT(haraimodoshi_win5_123), COUNT(*), ROUND(COUNT(haraimodoshi_win5_123)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_124', COUNT(haraimodoshi_win5_124), COUNT(*), ROUND(COUNT(haraimodoshi_win5_124)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_125', COUNT(haraimodoshi_win5_125), COUNT(*), ROUND(COUNT(haraimodoshi_win5_125)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_126', COUNT(haraimodoshi_win5_126), COUNT(*), ROUND(COUNT(haraimodoshi_win5_126)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_127', COUNT(haraimodoshi_win5_127), COUNT(*), ROUND(COUNT(haraimodoshi_win5_127)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_128', COUNT(haraimodoshi_win5_128), COUNT(*), ROUND(COUNT(haraimodoshi_win5_128)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_129', COUNT(haraimodoshi_win5_129), COUNT(*), ROUND(COUNT(haraimodoshi_win5_129)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_130', COUNT(haraimodoshi_win5_130), COUNT(*), ROUND(COUNT(haraimodoshi_win5_130)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_131', COUNT(haraimodoshi_win5_131), COUNT(*), ROUND(COUNT(haraimodoshi_win5_131)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_132', COUNT(haraimodoshi_win5_132), COUNT(*), ROUND(COUNT(haraimodoshi_win5_132)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_133', COUNT(haraimodoshi_win5_133), COUNT(*), ROUND(COUNT(haraimodoshi_win5_133)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_134', COUNT(haraimodoshi_win5_134), COUNT(*), ROUND(COUNT(haraimodoshi_win5_134)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_135', COUNT(haraimodoshi_win5_135), COUNT(*), ROUND(COUNT(haraimodoshi_win5_135)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_136', COUNT(haraimodoshi_win5_136), COUNT(*), ROUND(COUNT(haraimodoshi_win5_136)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_137', COUNT(haraimodoshi_win5_137), COUNT(*), ROUND(COUNT(haraimodoshi_win5_137)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_138', COUNT(haraimodoshi_win5_138), COUNT(*), ROUND(COUNT(haraimodoshi_win5_138)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_139', COUNT(haraimodoshi_win5_139), COUNT(*), ROUND(COUNT(haraimodoshi_win5_139)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_140', COUNT(haraimodoshi_win5_140), COUNT(*), ROUND(COUNT(haraimodoshi_win5_140)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_141', COUNT(haraimodoshi_win5_141), COUNT(*), ROUND(COUNT(haraimodoshi_win5_141)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_142', COUNT(haraimodoshi_win5_142), COUNT(*), ROUND(COUNT(haraimodoshi_win5_142)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_143', COUNT(haraimodoshi_win5_143), COUNT(*), ROUND(COUNT(haraimodoshi_win5_143)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_144', COUNT(haraimodoshi_win5_144), COUNT(*), ROUND(COUNT(haraimodoshi_win5_144)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_145', COUNT(haraimodoshi_win5_145), COUNT(*), ROUND(COUNT(haraimodoshi_win5_145)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_146', COUNT(haraimodoshi_win5_146), COUNT(*), ROUND(COUNT(haraimodoshi_win5_146)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_147', COUNT(haraimodoshi_win5_147), COUNT(*), ROUND(COUNT(haraimodoshi_win5_147)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_148', COUNT(haraimodoshi_win5_148), COUNT(*), ROUND(COUNT(haraimodoshi_win5_148)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_149', COUNT(haraimodoshi_win5_149), COUNT(*), ROUND(COUNT(haraimodoshi_win5_149)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_150', COUNT(haraimodoshi_win5_150), COUNT(*), ROUND(COUNT(haraimodoshi_win5_150)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_151', COUNT(haraimodoshi_win5_151), COUNT(*), ROUND(COUNT(haraimodoshi_win5_151)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_152', COUNT(haraimodoshi_win5_152), COUNT(*), ROUND(COUNT(haraimodoshi_win5_152)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_153', COUNT(haraimodoshi_win5_153), COUNT(*), ROUND(COUNT(haraimodoshi_win5_153)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_154', COUNT(haraimodoshi_win5_154), COUNT(*), ROUND(COUNT(haraimodoshi_win5_154)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_155', COUNT(haraimodoshi_win5_155), COUNT(*), ROUND(COUNT(haraimodoshi_win5_155)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_156', COUNT(haraimodoshi_win5_156), COUNT(*), ROUND(COUNT(haraimodoshi_win5_156)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_157', COUNT(haraimodoshi_win5_157), COUNT(*), ROUND(COUNT(haraimodoshi_win5_157)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_158', COUNT(haraimodoshi_win5_158), COUNT(*), ROUND(COUNT(haraimodoshi_win5_158)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_159', COUNT(haraimodoshi_win5_159), COUNT(*), ROUND(COUNT(haraimodoshi_win5_159)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_160', COUNT(haraimodoshi_win5_160), COUNT(*), ROUND(COUNT(haraimodoshi_win5_160)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_161', COUNT(haraimodoshi_win5_161), COUNT(*), ROUND(COUNT(haraimodoshi_win5_161)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_162', COUNT(haraimodoshi_win5_162), COUNT(*), ROUND(COUNT(haraimodoshi_win5_162)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_163', COUNT(haraimodoshi_win5_163), COUNT(*), ROUND(COUNT(haraimodoshi_win5_163)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_164', COUNT(haraimodoshi_win5_164), COUNT(*), ROUND(COUNT(haraimodoshi_win5_164)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_165', COUNT(haraimodoshi_win5_165), COUNT(*), ROUND(COUNT(haraimodoshi_win5_165)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_166', COUNT(haraimodoshi_win5_166), COUNT(*), ROUND(COUNT(haraimodoshi_win5_166)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_167', COUNT(haraimodoshi_win5_167), COUNT(*), ROUND(COUNT(haraimodoshi_win5_167)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_168', COUNT(haraimodoshi_win5_168), COUNT(*), ROUND(COUNT(haraimodoshi_win5_168)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_169', COUNT(haraimodoshi_win5_169), COUNT(*), ROUND(COUNT(haraimodoshi_win5_169)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_170', COUNT(haraimodoshi_win5_170), COUNT(*), ROUND(COUNT(haraimodoshi_win5_170)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_171', COUNT(haraimodoshi_win5_171), COUNT(*), ROUND(COUNT(haraimodoshi_win5_171)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_172', COUNT(haraimodoshi_win5_172), COUNT(*), ROUND(COUNT(haraimodoshi_win5_172)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_173', COUNT(haraimodoshi_win5_173), COUNT(*), ROUND(COUNT(haraimodoshi_win5_173)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_174', COUNT(haraimodoshi_win5_174), COUNT(*), ROUND(COUNT(haraimodoshi_win5_174)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_175', COUNT(haraimodoshi_win5_175), COUNT(*), ROUND(COUNT(haraimodoshi_win5_175)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_176', COUNT(haraimodoshi_win5_176), COUNT(*), ROUND(COUNT(haraimodoshi_win5_176)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_177', COUNT(haraimodoshi_win5_177), COUNT(*), ROUND(COUNT(haraimodoshi_win5_177)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_178', COUNT(haraimodoshi_win5_178), COUNT(*), ROUND(COUNT(haraimodoshi_win5_178)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_179', COUNT(haraimodoshi_win5_179), COUNT(*), ROUND(COUNT(haraimodoshi_win5_179)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_180', COUNT(haraimodoshi_win5_180), COUNT(*), ROUND(COUNT(haraimodoshi_win5_180)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_181', COUNT(haraimodoshi_win5_181), COUNT(*), ROUND(COUNT(haraimodoshi_win5_181)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_182', COUNT(haraimodoshi_win5_182), COUNT(*), ROUND(COUNT(haraimodoshi_win5_182)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_183', COUNT(haraimodoshi_win5_183), COUNT(*), ROUND(COUNT(haraimodoshi_win5_183)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_184', COUNT(haraimodoshi_win5_184), COUNT(*), ROUND(COUNT(haraimodoshi_win5_184)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_185', COUNT(haraimodoshi_win5_185), COUNT(*), ROUND(COUNT(haraimodoshi_win5_185)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_186', COUNT(haraimodoshi_win5_186), COUNT(*), ROUND(COUNT(haraimodoshi_win5_186)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_187', COUNT(haraimodoshi_win5_187), COUNT(*), ROUND(COUNT(haraimodoshi_win5_187)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_188', COUNT(haraimodoshi_win5_188), COUNT(*), ROUND(COUNT(haraimodoshi_win5_188)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_189', COUNT(haraimodoshi_win5_189), COUNT(*), ROUND(COUNT(haraimodoshi_win5_189)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_190', COUNT(haraimodoshi_win5_190), COUNT(*), ROUND(COUNT(haraimodoshi_win5_190)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_191', COUNT(haraimodoshi_win5_191), COUNT(*), ROUND(COUNT(haraimodoshi_win5_191)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_192', COUNT(haraimodoshi_win5_192), COUNT(*), ROUND(COUNT(haraimodoshi_win5_192)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_193', COUNT(haraimodoshi_win5_193), COUNT(*), ROUND(COUNT(haraimodoshi_win5_193)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_194', COUNT(haraimodoshi_win5_194), COUNT(*), ROUND(COUNT(haraimodoshi_win5_194)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_195', COUNT(haraimodoshi_win5_195), COUNT(*), ROUND(COUNT(haraimodoshi_win5_195)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_196', COUNT(haraimodoshi_win5_196), COUNT(*), ROUND(COUNT(haraimodoshi_win5_196)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_197', COUNT(haraimodoshi_win5_197), COUNT(*), ROUND(COUNT(haraimodoshi_win5_197)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_198', COUNT(haraimodoshi_win5_198), COUNT(*), ROUND(COUNT(haraimodoshi_win5_198)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_199', COUNT(haraimodoshi_win5_199), COUNT(*), ROUND(COUNT(haraimodoshi_win5_199)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_200', COUNT(haraimodoshi_win5_200), COUNT(*), ROUND(COUNT(haraimodoshi_win5_200)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_201', COUNT(haraimodoshi_win5_201), COUNT(*), ROUND(COUNT(haraimodoshi_win5_201)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_202', COUNT(haraimodoshi_win5_202), COUNT(*), ROUND(COUNT(haraimodoshi_win5_202)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_203', COUNT(haraimodoshi_win5_203), COUNT(*), ROUND(COUNT(haraimodoshi_win5_203)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_204', COUNT(haraimodoshi_win5_204), COUNT(*), ROUND(COUNT(haraimodoshi_win5_204)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_205', COUNT(haraimodoshi_win5_205), COUNT(*), ROUND(COUNT(haraimodoshi_win5_205)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_206', COUNT(haraimodoshi_win5_206), COUNT(*), ROUND(COUNT(haraimodoshi_win5_206)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_207', COUNT(haraimodoshi_win5_207), COUNT(*), ROUND(COUNT(haraimodoshi_win5_207)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_208', COUNT(haraimodoshi_win5_208), COUNT(*), ROUND(COUNT(haraimodoshi_win5_208)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_209', COUNT(haraimodoshi_win5_209), COUNT(*), ROUND(COUNT(haraimodoshi_win5_209)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_210', COUNT(haraimodoshi_win5_210), COUNT(*), ROUND(COUNT(haraimodoshi_win5_210)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_211', COUNT(haraimodoshi_win5_211), COUNT(*), ROUND(COUNT(haraimodoshi_win5_211)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_212', COUNT(haraimodoshi_win5_212), COUNT(*), ROUND(COUNT(haraimodoshi_win5_212)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_213', COUNT(haraimodoshi_win5_213), COUNT(*), ROUND(COUNT(haraimodoshi_win5_213)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_214', COUNT(haraimodoshi_win5_214), COUNT(*), ROUND(COUNT(haraimodoshi_win5_214)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_215', COUNT(haraimodoshi_win5_215), COUNT(*), ROUND(COUNT(haraimodoshi_win5_215)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_216', COUNT(haraimodoshi_win5_216), COUNT(*), ROUND(COUNT(haraimodoshi_win5_216)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_217', COUNT(haraimodoshi_win5_217), COUNT(*), ROUND(COUNT(haraimodoshi_win5_217)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_218', COUNT(haraimodoshi_win5_218), COUNT(*), ROUND(COUNT(haraimodoshi_win5_218)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_219', COUNT(haraimodoshi_win5_219), COUNT(*), ROUND(COUNT(haraimodoshi_win5_219)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_220', COUNT(haraimodoshi_win5_220), COUNT(*), ROUND(COUNT(haraimodoshi_win5_220)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_221', COUNT(haraimodoshi_win5_221), COUNT(*), ROUND(COUNT(haraimodoshi_win5_221)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_222', COUNT(haraimodoshi_win5_222), COUNT(*), ROUND(COUNT(haraimodoshi_win5_222)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_223', COUNT(haraimodoshi_win5_223), COUNT(*), ROUND(COUNT(haraimodoshi_win5_223)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_224', COUNT(haraimodoshi_win5_224), COUNT(*), ROUND(COUNT(haraimodoshi_win5_224)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_225', COUNT(haraimodoshi_win5_225), COUNT(*), ROUND(COUNT(haraimodoshi_win5_225)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_226', COUNT(haraimodoshi_win5_226), COUNT(*), ROUND(COUNT(haraimodoshi_win5_226)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_227', COUNT(haraimodoshi_win5_227), COUNT(*), ROUND(COUNT(haraimodoshi_win5_227)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_228', COUNT(haraimodoshi_win5_228), COUNT(*), ROUND(COUNT(haraimodoshi_win5_228)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_229', COUNT(haraimodoshi_win5_229), COUNT(*), ROUND(COUNT(haraimodoshi_win5_229)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_230', COUNT(haraimodoshi_win5_230), COUNT(*), ROUND(COUNT(haraimodoshi_win5_230)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_231', COUNT(haraimodoshi_win5_231), COUNT(*), ROUND(COUNT(haraimodoshi_win5_231)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_232', COUNT(haraimodoshi_win5_232), COUNT(*), ROUND(COUNT(haraimodoshi_win5_232)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_233', COUNT(haraimodoshi_win5_233), COUNT(*), ROUND(COUNT(haraimodoshi_win5_233)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_234', COUNT(haraimodoshi_win5_234), COUNT(*), ROUND(COUNT(haraimodoshi_win5_234)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_235', COUNT(haraimodoshi_win5_235), COUNT(*), ROUND(COUNT(haraimodoshi_win5_235)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_236', COUNT(haraimodoshi_win5_236), COUNT(*), ROUND(COUNT(haraimodoshi_win5_236)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_237', COUNT(haraimodoshi_win5_237), COUNT(*), ROUND(COUNT(haraimodoshi_win5_237)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_238', COUNT(haraimodoshi_win5_238), COUNT(*), ROUND(COUNT(haraimodoshi_win5_238)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_239', COUNT(haraimodoshi_win5_239), COUNT(*), ROUND(COUNT(haraimodoshi_win5_239)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_240', COUNT(haraimodoshi_win5_240), COUNT(*), ROUND(COUNT(haraimodoshi_win5_240)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_241', COUNT(haraimodoshi_win5_241), COUNT(*), ROUND(COUNT(haraimodoshi_win5_241)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_242', COUNT(haraimodoshi_win5_242), COUNT(*), ROUND(COUNT(haraimodoshi_win5_242)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_wf', 'haraimodoshi_win5_243', COUNT(haraimodoshi_win5_243), COUNT(*), ROUND(COUNT(haraimodoshi_win5_243)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wf WHERE kaisai_nen BETWEEN '2016' AND '2025'
;

-- ============================================================================
-- 9. JVD_HC (14カラム)
-- ============================================================================
-- 実行後、結果を jvd_hc_fillrate.csv で保存してください

SELECT 'jvd_hc' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'tracen_kubun', COUNT(tracen_kubun), COUNT(*), ROUND(COUNT(tracen_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'chokyo_nengappi', COUNT(chokyo_nengappi), COUNT(*), ROUND(COUNT(chokyo_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'chokyo_jikoku', COUNT(chokyo_jikoku), COUNT(*), ROUND(COUNT(chokyo_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'time_gokei_4f', COUNT(time_gokei_4f), COUNT(*), ROUND(COUNT(time_gokei_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'lap_time_4f', COUNT(lap_time_4f), COUNT(*), ROUND(COUNT(lap_time_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'time_gokei_3f', COUNT(time_gokei_3f), COUNT(*), ROUND(COUNT(time_gokei_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'lap_time_3f', COUNT(lap_time_3f), COUNT(*), ROUND(COUNT(lap_time_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'time_gokei_2f', COUNT(time_gokei_2f), COUNT(*), ROUND(COUNT(time_gokei_2f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'lap_time_2f', COUNT(lap_time_2f), COUNT(*), ROUND(COUNT(lap_time_2f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
UNION ALL SELECT 'jvd_hc', 'lap_time_1f', COUNT(lap_time_1f), COUNT(*), ROUND(COUNT(lap_time_1f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hc
;

-- ============================================================================
-- 10. JVD_JG (14カラム)
-- ============================================================================
-- 実行後、結果を jvd_jg_fillrate.csv で保存してください

SELECT 'jvd_jg' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'shutsuba_tohyo_uketsuke', COUNT(shutsuba_tohyo_uketsuke), COUNT(*), ROUND(COUNT(shutsuba_tohyo_uketsuke)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'shusso_kubun', COUNT(shusso_kubun), COUNT(*), ROUND(COUNT(shusso_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
UNION ALL SELECT 'jvd_jg', 'jogai_jotai_kubun', COUNT(jogai_jotai_kubun), COUNT(*), ROUND(COUNT(jogai_jotai_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_jg
;

-- ============================================================================
-- 11. JVD_SK (26カラム)
-- ============================================================================
-- 実行後、結果を jvd_sk_fillrate.csv で保存してください

SELECT 'jvd_sk' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'seinengappi', COUNT(seinengappi), COUNT(*), ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'seibetsu_code', COUNT(seibetsu_code), COUNT(*), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'hinshu_code', COUNT(hinshu_code), COUNT(*), ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'moshoku_code', COUNT(moshoku_code), COUNT(*), ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'mochikomi_kubun', COUNT(mochikomi_kubun), COUNT(*), ROUND(COUNT(mochikomi_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'yunyu_nen', COUNT(yunyu_nen), COUNT(*), ROUND(COUNT(yunyu_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'seisansha_code', COUNT(seisansha_code), COUNT(*), ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'sanchimei', COUNT(sanchimei), COUNT(*), ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_01a', COUNT(ketto_joho_01a), COUNT(*), ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_02a', COUNT(ketto_joho_02a), COUNT(*), ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_03a', COUNT(ketto_joho_03a), COUNT(*), ROUND(COUNT(ketto_joho_03a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_04a', COUNT(ketto_joho_04a), COUNT(*), ROUND(COUNT(ketto_joho_04a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_05a', COUNT(ketto_joho_05a), COUNT(*), ROUND(COUNT(ketto_joho_05a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_06a', COUNT(ketto_joho_06a), COUNT(*), ROUND(COUNT(ketto_joho_06a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_07a', COUNT(ketto_joho_07a), COUNT(*), ROUND(COUNT(ketto_joho_07a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_08a', COUNT(ketto_joho_08a), COUNT(*), ROUND(COUNT(ketto_joho_08a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_09a', COUNT(ketto_joho_09a), COUNT(*), ROUND(COUNT(ketto_joho_09a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_10a', COUNT(ketto_joho_10a), COUNT(*), ROUND(COUNT(ketto_joho_10a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_11a', COUNT(ketto_joho_11a), COUNT(*), ROUND(COUNT(ketto_joho_11a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_12a', COUNT(ketto_joho_12a), COUNT(*), ROUND(COUNT(ketto_joho_12a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_13a', COUNT(ketto_joho_13a), COUNT(*), ROUND(COUNT(ketto_joho_13a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
UNION ALL SELECT 'jvd_sk', 'ketto_joho_14a', COUNT(ketto_joho_14a), COUNT(*), ROUND(COUNT(ketto_joho_14a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_sk
;

-- ============================================================================
-- 12. JVD_UM (89カラム)
-- ============================================================================
-- 実行後、結果を jvd_um_fillrate.csv で保存してください

SELECT 'jvd_um' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_um
UNION ALL SELECT 'jvd_um', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'massho_kubun', COUNT(massho_kubun), COUNT(*), ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'toroku_nengappi', COUNT(toroku_nengappi), COUNT(*), ROUND(COUNT(toroku_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'massho_nengappi', COUNT(massho_nengappi), COUNT(*), ROUND(COUNT(massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'seinengappi', COUNT(seinengappi), COUNT(*), ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'bamei_hankaku_kana', COUNT(bamei_hankaku_kana), COUNT(*), ROUND(COUNT(bamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'bamei_eur', COUNT(bamei_eur), COUNT(*), ROUND(COUNT(bamei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'zaikyu_flag', COUNT(zaikyu_flag), COUNT(*), ROUND(COUNT(zaikyu_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'umakigo_code', COUNT(umakigo_code), COUNT(*), ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'seibetsu_code', COUNT(seibetsu_code), COUNT(*), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'hinshu_code', COUNT(hinshu_code), COUNT(*), ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'moshoku_code', COUNT(moshoku_code), COUNT(*), ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_01a', COUNT(ketto_joho_01a), COUNT(*), ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_01b', COUNT(ketto_joho_01b), COUNT(*), ROUND(COUNT(ketto_joho_01b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_02a', COUNT(ketto_joho_02a), COUNT(*), ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_02b', COUNT(ketto_joho_02b), COUNT(*), ROUND(COUNT(ketto_joho_02b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_03a', COUNT(ketto_joho_03a), COUNT(*), ROUND(COUNT(ketto_joho_03a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_03b', COUNT(ketto_joho_03b), COUNT(*), ROUND(COUNT(ketto_joho_03b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_04a', COUNT(ketto_joho_04a), COUNT(*), ROUND(COUNT(ketto_joho_04a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_04b', COUNT(ketto_joho_04b), COUNT(*), ROUND(COUNT(ketto_joho_04b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_05a', COUNT(ketto_joho_05a), COUNT(*), ROUND(COUNT(ketto_joho_05a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_05b', COUNT(ketto_joho_05b), COUNT(*), ROUND(COUNT(ketto_joho_05b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_06a', COUNT(ketto_joho_06a), COUNT(*), ROUND(COUNT(ketto_joho_06a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_06b', COUNT(ketto_joho_06b), COUNT(*), ROUND(COUNT(ketto_joho_06b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_07a', COUNT(ketto_joho_07a), COUNT(*), ROUND(COUNT(ketto_joho_07a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_07b', COUNT(ketto_joho_07b), COUNT(*), ROUND(COUNT(ketto_joho_07b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_08a', COUNT(ketto_joho_08a), COUNT(*), ROUND(COUNT(ketto_joho_08a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_08b', COUNT(ketto_joho_08b), COUNT(*), ROUND(COUNT(ketto_joho_08b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_09a', COUNT(ketto_joho_09a), COUNT(*), ROUND(COUNT(ketto_joho_09a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_09b', COUNT(ketto_joho_09b), COUNT(*), ROUND(COUNT(ketto_joho_09b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_10a', COUNT(ketto_joho_10a), COUNT(*), ROUND(COUNT(ketto_joho_10a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_10b', COUNT(ketto_joho_10b), COUNT(*), ROUND(COUNT(ketto_joho_10b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_11a', COUNT(ketto_joho_11a), COUNT(*), ROUND(COUNT(ketto_joho_11a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_11b', COUNT(ketto_joho_11b), COUNT(*), ROUND(COUNT(ketto_joho_11b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_12a', COUNT(ketto_joho_12a), COUNT(*), ROUND(COUNT(ketto_joho_12a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_12b', COUNT(ketto_joho_12b), COUNT(*), ROUND(COUNT(ketto_joho_12b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_13a', COUNT(ketto_joho_13a), COUNT(*), ROUND(COUNT(ketto_joho_13a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_13b', COUNT(ketto_joho_13b), COUNT(*), ROUND(COUNT(ketto_joho_13b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_14a', COUNT(ketto_joho_14a), COUNT(*), ROUND(COUNT(ketto_joho_14a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'ketto_joho_14b', COUNT(ketto_joho_14b), COUNT(*), ROUND(COUNT(ketto_joho_14b)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'tozai_shozoku_code', COUNT(tozai_shozoku_code), COUNT(*), ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'chokyoshimei_ryakusho', COUNT(chokyoshimei_ryakusho), COUNT(*), ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shotai_chiikimei', COUNT(shotai_chiikimei), COUNT(*), ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'seisansha_code', COUNT(seisansha_code), COUNT(*), ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'seisanshamei', COUNT(seisanshamei), COUNT(*), ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'sanchimei', COUNT(sanchimei), COUNT(*), ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'banushi_code', COUNT(banushi_code), COUNT(*), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'banushimei', COUNT(banushimei), COUNT(*), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'heichi_honshokin_ruikei', COUNT(heichi_honshokin_ruikei), COUNT(*), ROUND(COUNT(heichi_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_honshokin_ruikei', COUNT(shogai_honshokin_ruikei), COUNT(*), ROUND(COUNT(shogai_honshokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'heichi_fukashokin_ruikei', COUNT(heichi_fukashokin_ruikei), COUNT(*), ROUND(COUNT(heichi_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_fukashokin_ruikei', COUNT(shogai_fukashokin_ruikei), COUNT(*), ROUND(COUNT(shogai_fukashokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'heichi_shutokushokin_ruikei', COUNT(heichi_shutokushokin_ruikei), COUNT(*), ROUND(COUNT(heichi_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_shutokushokin_ruikei', COUNT(shogai_shutokushokin_ruikei), COUNT(*), ROUND(COUNT(shogai_shutokushokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'sogo', COUNT(sogo), COUNT(*), ROUND(COUNT(sogo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'chuo_gokei', COUNT(chuo_gokei), COUNT(*), ROUND(COUNT(chuo_gokei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_choku', COUNT(shiba_choku), COUNT(*), ROUND(COUNT(shiba_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_migi', COUNT(shiba_migi), COUNT(*), ROUND(COUNT(shiba_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_hidari', COUNT(shiba_hidari), COUNT(*), ROUND(COUNT(shiba_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_choku', COUNT(dirt_choku), COUNT(*), ROUND(COUNT(dirt_choku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_migi', COUNT(dirt_migi), COUNT(*), ROUND(COUNT(dirt_migi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_hidari', COUNT(dirt_hidari), COUNT(*), ROUND(COUNT(dirt_hidari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai', COUNT(shogai), COUNT(*), ROUND(COUNT(shogai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_ryo', COUNT(shiba_ryo), COUNT(*), ROUND(COUNT(shiba_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_yayaomo', COUNT(shiba_yayaomo), COUNT(*), ROUND(COUNT(shiba_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_omo', COUNT(shiba_omo), COUNT(*), ROUND(COUNT(shiba_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_furyo', COUNT(shiba_furyo), COUNT(*), ROUND(COUNT(shiba_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_ryo', COUNT(dirt_ryo), COUNT(*), ROUND(COUNT(dirt_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_yayaomo', COUNT(dirt_yayaomo), COUNT(*), ROUND(COUNT(dirt_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_omo', COUNT(dirt_omo), COUNT(*), ROUND(COUNT(dirt_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_furyo', COUNT(dirt_furyo), COUNT(*), ROUND(COUNT(dirt_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_ryo', COUNT(shogai_ryo), COUNT(*), ROUND(COUNT(shogai_ryo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_yayaomo', COUNT(shogai_yayaomo), COUNT(*), ROUND(COUNT(shogai_yayaomo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_omo', COUNT(shogai_omo), COUNT(*), ROUND(COUNT(shogai_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shogai_furyo', COUNT(shogai_furyo), COUNT(*), ROUND(COUNT(shogai_furyo)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_short', COUNT(shiba_short), COUNT(*), ROUND(COUNT(shiba_short)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_middle', COUNT(shiba_middle), COUNT(*), ROUND(COUNT(shiba_middle)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'shiba_long', COUNT(shiba_long), COUNT(*), ROUND(COUNT(shiba_long)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_short', COUNT(dirt_short), COUNT(*), ROUND(COUNT(dirt_short)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_middle', COUNT(dirt_middle), COUNT(*), ROUND(COUNT(dirt_middle)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'dirt_long', COUNT(dirt_long), COUNT(*), ROUND(COUNT(dirt_long)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'kyakushitsu_keiko', COUNT(kyakushitsu_keiko), COUNT(*), ROUND(COUNT(kyakushitsu_keiko)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
UNION ALL SELECT 'jvd_um', 'toroku_race_su', COUNT(toroku_race_su), COUNT(*), ROUND(COUNT(toroku_race_su)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_um
;

-- ============================================================================
-- 13. JVD_HY (6カラム)
-- ============================================================================
-- 実行後、結果を jvd_hy_fillrate.csv で保存してください

SELECT 'jvd_hy' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_hy
UNION ALL SELECT 'jvd_hy', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hy
UNION ALL SELECT 'jvd_hy', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hy
UNION ALL SELECT 'jvd_hy', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hy
UNION ALL SELECT 'jvd_hy', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hy
UNION ALL SELECT 'jvd_hy', 'bamei_imi_yurai', COUNT(bamei_imi_yurai), COUNT(*), ROUND(COUNT(bamei_imi_yurai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hy
;

-- ============================================================================
-- 14. JVD_HN (19カラム)
-- ============================================================================
-- 実行後、結果を jvd_hn_fillrate.csv で保存してください

SELECT 'jvd_hn' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'hanshoku_toroku_bango', COUNT(hanshoku_toroku_bango), COUNT(*), ROUND(COUNT(hanshoku_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'yobi_2', COUNT(yobi_2), COUNT(*), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'bamei_hankaku_kana', COUNT(bamei_hankaku_kana), COUNT(*), ROUND(COUNT(bamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'bamei_eur', COUNT(bamei_eur), COUNT(*), ROUND(COUNT(bamei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'seinen', COUNT(seinen), COUNT(*), ROUND(COUNT(seinen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'seibetsu_code', COUNT(seibetsu_code), COUNT(*), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'hinshu_code', COUNT(hinshu_code), COUNT(*), ROUND(COUNT(hinshu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'moshoku_code', COUNT(moshoku_code), COUNT(*), ROUND(COUNT(moshoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'mochikomi_kubun', COUNT(mochikomi_kubun), COUNT(*), ROUND(COUNT(mochikomi_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'yunyu_nen', COUNT(yunyu_nen), COUNT(*), ROUND(COUNT(yunyu_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'sanchimei', COUNT(sanchimei), COUNT(*), ROUND(COUNT(sanchimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'ketto_joho_01a', COUNT(ketto_joho_01a), COUNT(*), ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
UNION ALL SELECT 'jvd_hn', 'ketto_joho_02a', COUNT(ketto_joho_02a), COUNT(*), ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hn
;

-- ============================================================================
-- 15. JVD_O1 (22カラム)
-- ============================================================================
-- 実行後、結果を jvd_o1_fillrate.csv で保存してください

SELECT 'jvd_o1' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hatsubai_flag_tansho', COUNT(hatsubai_flag_tansho), COUNT(*), ROUND(COUNT(hatsubai_flag_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hatsubai_flag_fukusho', COUNT(hatsubai_flag_fukusho), COUNT(*), ROUND(COUNT(hatsubai_flag_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hatsubai_flag_wakuren', COUNT(hatsubai_flag_wakuren), COUNT(*), ROUND(COUNT(hatsubai_flag_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'fukusho_chakubarai_key', COUNT(fukusho_chakubarai_key), COUNT(*), ROUND(COUNT(fukusho_chakubarai_key)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'odds_tansho', COUNT(odds_tansho), COUNT(*), ROUND(COUNT(odds_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'odds_fukusho', COUNT(odds_fukusho), COUNT(*), ROUND(COUNT(odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'odds_wakuren', COUNT(odds_wakuren), COUNT(*), ROUND(COUNT(odds_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hyosu_gokei_tansho', COUNT(hyosu_gokei_tansho), COUNT(*), ROUND(COUNT(hyosu_gokei_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hyosu_gokei_fukusho', COUNT(hyosu_gokei_fukusho), COUNT(*), ROUND(COUNT(hyosu_gokei_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
UNION ALL SELECT 'jvd_o1', 'hyosu_gokei_wakuren', COUNT(hyosu_gokei_wakuren), COUNT(*), ROUND(COUNT(hyosu_gokei_wakuren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o1
;

-- ============================================================================
-- 16. JVD_O2 (15カラム)
-- ============================================================================
-- 実行後、結果を jvd_o2_fillrate.csv で保存してください

SELECT 'jvd_o2' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'hatsubai_flag_umaren', COUNT(hatsubai_flag_umaren), COUNT(*), ROUND(COUNT(hatsubai_flag_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'odds_umaren', COUNT(odds_umaren), COUNT(*), ROUND(COUNT(odds_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
UNION ALL SELECT 'jvd_o2', 'hyosu_gokei_umaren', COUNT(hyosu_gokei_umaren), COUNT(*), ROUND(COUNT(hyosu_gokei_umaren)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o2
;

-- ============================================================================
-- 17. JVD_O3 (15カラム)
-- ============================================================================
-- 実行後、結果を jvd_o3_fillrate.csv で保存してください

SELECT 'jvd_o3' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'hatsubai_flag_wide', COUNT(hatsubai_flag_wide), COUNT(*), ROUND(COUNT(hatsubai_flag_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'odds_wide', COUNT(odds_wide), COUNT(*), ROUND(COUNT(odds_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
UNION ALL SELECT 'jvd_o3', 'hyosu_gokei_wide', COUNT(hyosu_gokei_wide), COUNT(*), ROUND(COUNT(hyosu_gokei_wide)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o3
;

-- ============================================================================
-- 18. JVD_O4 (15カラム)
-- ============================================================================
-- 実行後、結果を jvd_o4_fillrate.csv で保存してください

SELECT 'jvd_o4' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'hatsubai_flag_umatan', COUNT(hatsubai_flag_umatan), COUNT(*), ROUND(COUNT(hatsubai_flag_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'odds_umatan', COUNT(odds_umatan), COUNT(*), ROUND(COUNT(odds_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
UNION ALL SELECT 'jvd_o4', 'hyosu_gokei_umatan', COUNT(hyosu_gokei_umatan), COUNT(*), ROUND(COUNT(hyosu_gokei_umatan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o4
;

-- ============================================================================
-- 19. JVD_O5 (15カラム)
-- ============================================================================
-- 実行後、結果を jvd_o5_fillrate.csv で保存してください

SELECT 'jvd_o5' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'hatsubai_flag_sanrenpuku', COUNT(hatsubai_flag_sanrenpuku), COUNT(*), ROUND(COUNT(hatsubai_flag_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'odds_sanrenpuku', COUNT(odds_sanrenpuku), COUNT(*), ROUND(COUNT(odds_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
UNION ALL SELECT 'jvd_o5', 'hyosu_gokei_sanrenpuku', COUNT(hyosu_gokei_sanrenpuku), COUNT(*), ROUND(COUNT(hyosu_gokei_sanrenpuku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o5
;

-- ============================================================================
-- 20. JVD_O6 (15カラム)
-- ============================================================================
-- 実行後、結果を jvd_o6_fillrate.csv で保存してください

SELECT 'jvd_o6' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'happyo_tsukihi_jifun', COUNT(happyo_tsukihi_jifun), COUNT(*), ROUND(COUNT(happyo_tsukihi_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'shusso_tosu', COUNT(shusso_tosu), COUNT(*), ROUND(COUNT(shusso_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'hatsubai_flag_sanrentan', COUNT(hatsubai_flag_sanrentan), COUNT(*), ROUND(COUNT(hatsubai_flag_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'odds_sanrentan', COUNT(odds_sanrentan), COUNT(*), ROUND(COUNT(odds_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
UNION ALL SELECT 'jvd_o6', 'hyosu_gokei_sanrentan', COUNT(hyosu_gokei_sanrentan), COUNT(*), ROUND(COUNT(hyosu_gokei_sanrentan)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_o6
;

-- ============================================================================
-- 21. JVD_TM (28カラム)
-- ============================================================================
-- 実行後、結果を jvd_tm_fillrate.csv で保存してください

SELECT 'jvd_tm' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'data_sakusei_jifun', COUNT(data_sakusei_jifun), COUNT(*), ROUND(COUNT(data_sakusei_jifun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_01', COUNT(mining_yoso_01), COUNT(*), ROUND(COUNT(mining_yoso_01)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_02', COUNT(mining_yoso_02), COUNT(*), ROUND(COUNT(mining_yoso_02)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_03', COUNT(mining_yoso_03), COUNT(*), ROUND(COUNT(mining_yoso_03)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_04', COUNT(mining_yoso_04), COUNT(*), ROUND(COUNT(mining_yoso_04)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_05', COUNT(mining_yoso_05), COUNT(*), ROUND(COUNT(mining_yoso_05)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_06', COUNT(mining_yoso_06), COUNT(*), ROUND(COUNT(mining_yoso_06)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_07', COUNT(mining_yoso_07), COUNT(*), ROUND(COUNT(mining_yoso_07)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_08', COUNT(mining_yoso_08), COUNT(*), ROUND(COUNT(mining_yoso_08)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_09', COUNT(mining_yoso_09), COUNT(*), ROUND(COUNT(mining_yoso_09)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_10', COUNT(mining_yoso_10), COUNT(*), ROUND(COUNT(mining_yoso_10)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_11', COUNT(mining_yoso_11), COUNT(*), ROUND(COUNT(mining_yoso_11)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_12', COUNT(mining_yoso_12), COUNT(*), ROUND(COUNT(mining_yoso_12)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_13', COUNT(mining_yoso_13), COUNT(*), ROUND(COUNT(mining_yoso_13)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_14', COUNT(mining_yoso_14), COUNT(*), ROUND(COUNT(mining_yoso_14)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_15', COUNT(mining_yoso_15), COUNT(*), ROUND(COUNT(mining_yoso_15)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_16', COUNT(mining_yoso_16), COUNT(*), ROUND(COUNT(mining_yoso_16)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_17', COUNT(mining_yoso_17), COUNT(*), ROUND(COUNT(mining_yoso_17)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
UNION ALL SELECT 'jvd_tm', 'mining_yoso_18', COUNT(mining_yoso_18), COUNT(*), ROUND(COUNT(mining_yoso_18)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_tm
;

-- ============================================================================
-- 22. JVD_HS (14カラム)
-- ============================================================================
-- 実行後、結果を jvd_hs_fillrate.csv で保存してください

SELECT 'jvd_hs' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'ketto_joho_01a', COUNT(ketto_joho_01a), COUNT(*), ROUND(COUNT(ketto_joho_01a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'ketto_joho_02a', COUNT(ketto_joho_02a), COUNT(*), ROUND(COUNT(ketto_joho_02a)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'seinen', COUNT(seinen), COUNT(*), ROUND(COUNT(seinen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'shusaisha_shijo_code', COUNT(shusaisha_shijo_code), COUNT(*), ROUND(COUNT(shusaisha_shijo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'shusaisha_meisho', COUNT(shusaisha_meisho), COUNT(*), ROUND(COUNT(shusaisha_meisho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'shijo_meisho', COUNT(shijo_meisho), COUNT(*), ROUND(COUNT(shijo_meisho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'kaisai_kikan_min', COUNT(kaisai_kikan_min), COUNT(*), ROUND(COUNT(kaisai_kikan_min)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'kaisai_kikan_max', COUNT(kaisai_kikan_max), COUNT(*), ROUND(COUNT(kaisai_kikan_max)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'torihikiji_nenrei', COUNT(torihikiji_nenrei), COUNT(*), ROUND(COUNT(torihikiji_nenrei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
UNION ALL SELECT 'jvd_hs', 'torihiki_kakaku', COUNT(torihiki_kakaku), COUNT(*), ROUND(COUNT(torihiki_kakaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_hs
;

-- ============================================================================
-- 23. JVD_WC (29カラム)
-- ============================================================================
-- 実行後、結果を jvd_wc_fillrate.csv で保存してください

SELECT 'jvd_wc' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'tracen_kubun', COUNT(tracen_kubun), COUNT(*), ROUND(COUNT(tracen_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'chokyo_nengappi', COUNT(chokyo_nengappi), COUNT(*), ROUND(COUNT(chokyo_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'chokyo_jikoku', COUNT(chokyo_jikoku), COUNT(*), ROUND(COUNT(chokyo_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'course', COUNT(course), COUNT(*), ROUND(COUNT(course)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'babamawari', COUNT(babamawari), COUNT(*), ROUND(COUNT(babamawari)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_10f', COUNT(time_gokei_10f), COUNT(*), ROUND(COUNT(time_gokei_10f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_10f', COUNT(lap_time_10f), COUNT(*), ROUND(COUNT(lap_time_10f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_9f', COUNT(time_gokei_9f), COUNT(*), ROUND(COUNT(time_gokei_9f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_9f', COUNT(lap_time_9f), COUNT(*), ROUND(COUNT(lap_time_9f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_8f', COUNT(time_gokei_8f), COUNT(*), ROUND(COUNT(time_gokei_8f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_8f', COUNT(lap_time_8f), COUNT(*), ROUND(COUNT(lap_time_8f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_7f', COUNT(time_gokei_7f), COUNT(*), ROUND(COUNT(time_gokei_7f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_7f', COUNT(lap_time_7f), COUNT(*), ROUND(COUNT(lap_time_7f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_6f', COUNT(time_gokei_6f), COUNT(*), ROUND(COUNT(time_gokei_6f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_6f', COUNT(lap_time_6f), COUNT(*), ROUND(COUNT(lap_time_6f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_5f', COUNT(time_gokei_5f), COUNT(*), ROUND(COUNT(time_gokei_5f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_5f', COUNT(lap_time_5f), COUNT(*), ROUND(COUNT(lap_time_5f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_4f', COUNT(time_gokei_4f), COUNT(*), ROUND(COUNT(time_gokei_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_4f', COUNT(lap_time_4f), COUNT(*), ROUND(COUNT(lap_time_4f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_3f', COUNT(time_gokei_3f), COUNT(*), ROUND(COUNT(time_gokei_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_3f', COUNT(lap_time_3f), COUNT(*), ROUND(COUNT(lap_time_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'time_gokei_2f', COUNT(time_gokei_2f), COUNT(*), ROUND(COUNT(time_gokei_2f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_2f', COUNT(lap_time_2f), COUNT(*), ROUND(COUNT(lap_time_2f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
UNION ALL SELECT 'jvd_wc', 'lap_time_1f', COUNT(lap_time_1f), COUNT(*), ROUND(COUNT(lap_time_1f)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_wc
;

-- ============================================================================
-- 24. JVD_BN (11カラム)
-- ============================================================================
-- 実行後、結果を jvd_bn_fillrate.csv で保存してください

SELECT 'jvd_bn' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'banushi_code', COUNT(banushi_code), COUNT(*), ROUND(COUNT(banushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'banushimei_hojinkaku', COUNT(banushimei_hojinkaku), COUNT(*), ROUND(COUNT(banushimei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'banushimei', COUNT(banushimei), COUNT(*), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'banushimei_hankaku_kana', COUNT(banushimei_hankaku_kana), COUNT(*), ROUND(COUNT(banushimei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'banushimei_eur', COUNT(banushimei_eur), COUNT(*), ROUND(COUNT(banushimei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'fukushoku_hyoji', COUNT(fukushoku_hyoji), COUNT(*), ROUND(COUNT(fukushoku_hyoji)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'seiseki_joho_1', COUNT(seiseki_joho_1), COUNT(*), ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
UNION ALL SELECT 'jvd_bn', 'seiseki_joho_2', COUNT(seiseki_joho_2), COUNT(*), ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bn
;

-- ============================================================================
-- 25. JVD_BR (11カラム)
-- ============================================================================
-- 実行後、結果を jvd_br_fillrate.csv で保存してください

SELECT 'jvd_br' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_br
UNION ALL SELECT 'jvd_br', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisansha_code', COUNT(seisansha_code), COUNT(*), ROUND(COUNT(seisansha_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisanshamei_hojinkaku', COUNT(seisanshamei_hojinkaku), COUNT(*), ROUND(COUNT(seisanshamei_hojinkaku)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisanshamei', COUNT(seisanshamei), COUNT(*), ROUND(COUNT(seisanshamei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisanshamei_hankaku_kana', COUNT(seisanshamei_hankaku_kana), COUNT(*), ROUND(COUNT(seisanshamei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisanshamei_eur', COUNT(seisanshamei_eur), COUNT(*), ROUND(COUNT(seisanshamei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seisansha_jusho_jichishomei', COUNT(seisansha_jusho_jichishomei), COUNT(*), ROUND(COUNT(seisansha_jusho_jichishomei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seiseki_joho_1', COUNT(seiseki_joho_1), COUNT(*), ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
UNION ALL SELECT 'jvd_br', 'seiseki_joho_2', COUNT(seiseki_joho_2), COUNT(*), ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_br
;

-- ============================================================================
-- 26. JVD_YS (12カラム)
-- ============================================================================
-- 実行後、結果を jvd_ys_fillrate.csv で保存してください

SELECT 'jvd_ys' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'yobi_code', COUNT(yobi_code), COUNT(*), ROUND(COUNT(yobi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'jusho_joho_1', COUNT(jusho_joho_1), COUNT(*), ROUND(COUNT(jusho_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'jusho_joho_2', COUNT(jusho_joho_2), COUNT(*), ROUND(COUNT(jusho_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
UNION ALL SELECT 'jvd_ys', 'jusho_joho_3', COUNT(jusho_joho_3), COUNT(*), ROUND(COUNT(jusho_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ys
;

-- ============================================================================
-- 27. JVD_RC (24カラム)
-- ============================================================================
-- 実行後、結果を jvd_rc_fillrate.csv で保存してください

SELECT 'jvd_rc' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_shikibetsu_kubun', COUNT(record_shikibetsu_kubun), COUNT(*), ROUND(COUNT(record_shikibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'tokubetsu_kyoso_bango', COUNT(tokubetsu_kyoso_bango), COUNT(*), ROUND(COUNT(tokubetsu_kyoso_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kyosomei_hondai', COUNT(kyosomei_hondai), COUNT(*), ROUND(COUNT(kyosomei_hondai)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'grade_code', COUNT(grade_code), COUNT(*), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kyoso_shubetsu_code', COUNT(kyoso_shubetsu_code), COUNT(*), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'kyori', COUNT(kyori), COUNT(*), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'track_code', COUNT(track_code), COUNT(*), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_kubun', COUNT(record_kubun), COUNT(*), ROUND(COUNT(record_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_time', COUNT(record_time), COUNT(*), ROUND(COUNT(record_time)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'tenko_code', COUNT(tenko_code), COUNT(*), ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'babajotai_code_shiba', COUNT(babajotai_code_shiba), COUNT(*), ROUND(COUNT(babajotai_code_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'babajotai_code_dirt', COUNT(babajotai_code_dirt), COUNT(*), ROUND(COUNT(babajotai_code_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_hojiuma_joho_1', COUNT(record_hojiuma_joho_1), COUNT(*), ROUND(COUNT(record_hojiuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_hojiuma_joho_2', COUNT(record_hojiuma_joho_2), COUNT(*), ROUND(COUNT(record_hojiuma_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
UNION ALL SELECT 'jvd_rc', 'record_hojiuma_joho_3', COUNT(record_hojiuma_joho_3), COUNT(*), ROUND(COUNT(record_hojiuma_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_rc
;

-- ============================================================================
-- 28. JVD_KS (30カラム)
-- ============================================================================
-- 実行後、結果を jvd_ks_fillrate.csv で保存してください

SELECT 'jvd_ks' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishu_code', COUNT(kishu_code), COUNT(*), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'massho_kubun', COUNT(massho_kubun), COUNT(*), ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'menkyo_kofu_nengappi', COUNT(menkyo_kofu_nengappi), COUNT(*), ROUND(COUNT(menkyo_kofu_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'menkyo_massho_nengappi', COUNT(menkyo_massho_nengappi), COUNT(*), ROUND(COUNT(menkyo_massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'seinengappi', COUNT(seinengappi), COUNT(*), ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishumei', COUNT(kishumei), COUNT(*), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishumei_hankaku_kana', COUNT(kishumei_hankaku_kana), COUNT(*), ROUND(COUNT(kishumei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishumei_ryakusho', COUNT(kishumei_ryakusho), COUNT(*), ROUND(COUNT(kishumei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishumei_eur', COUNT(kishumei_eur), COUNT(*), ROUND(COUNT(kishumei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'seibetsu_kubun', COUNT(seibetsu_kubun), COUNT(*), ROUND(COUNT(seibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kijo_shikaku_code', COUNT(kijo_shikaku_code), COUNT(*), ROUND(COUNT(kijo_shikaku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'kishu_minarai_code', COUNT(kishu_minarai_code), COUNT(*), ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'tozai_shozoku_code', COUNT(tozai_shozoku_code), COUNT(*), ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'shotai_chiikimei', COUNT(shotai_chiikimei), COUNT(*), ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'chokyoshimei_ryakusho', COUNT(chokyoshimei_ryakusho), COUNT(*), ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'hatsukijo_joho_1', COUNT(hatsukijo_joho_1), COUNT(*), ROUND(COUNT(hatsukijo_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'hatsukijo_joho_2', COUNT(hatsukijo_joho_2), COUNT(*), ROUND(COUNT(hatsukijo_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'hatsushori_joho_1', COUNT(hatsushori_joho_1), COUNT(*), ROUND(COUNT(hatsushori_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'hatsushori_joho_2', COUNT(hatsushori_joho_2), COUNT(*), ROUND(COUNT(hatsushori_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'jushoshori_joho_1', COUNT(jushoshori_joho_1), COUNT(*), ROUND(COUNT(jushoshori_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'jushoshori_joho_2', COUNT(jushoshori_joho_2), COUNT(*), ROUND(COUNT(jushoshori_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'jushoshori_joho_3', COUNT(jushoshori_joho_3), COUNT(*), ROUND(COUNT(jushoshori_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'seiseki_joho_1', COUNT(seiseki_joho_1), COUNT(*), ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'seiseki_joho_2', COUNT(seiseki_joho_2), COUNT(*), ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
UNION ALL SELECT 'jvd_ks', 'seiseki_joho_3', COUNT(seiseki_joho_3), COUNT(*), ROUND(COUNT(seiseki_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ks
;

-- ============================================================================
-- 29. JVD_CH (21カラム)
-- ============================================================================
-- 実行後、結果を jvd_ch_fillrate.csv で保存してください

SELECT 'jvd_ch' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'massho_kubun', COUNT(massho_kubun), COUNT(*), ROUND(COUNT(massho_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'menkyo_kofu_nengappi', COUNT(menkyo_kofu_nengappi), COUNT(*), ROUND(COUNT(menkyo_kofu_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'menkyo_massho_nengappi', COUNT(menkyo_massho_nengappi), COUNT(*), ROUND(COUNT(menkyo_massho_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'seinengappi', COUNT(seinengappi), COUNT(*), ROUND(COUNT(seinengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'chokyoshimei', COUNT(chokyoshimei), COUNT(*), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'chokyoshimei_hankaku_kana', COUNT(chokyoshimei_hankaku_kana), COUNT(*), ROUND(COUNT(chokyoshimei_hankaku_kana)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'chokyoshimei_ryakusho', COUNT(chokyoshimei_ryakusho), COUNT(*), ROUND(COUNT(chokyoshimei_ryakusho)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'chokyoshimei_eur', COUNT(chokyoshimei_eur), COUNT(*), ROUND(COUNT(chokyoshimei_eur)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'seibetsu_kubun', COUNT(seibetsu_kubun), COUNT(*), ROUND(COUNT(seibetsu_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'tozai_shozoku_code', COUNT(tozai_shozoku_code), COUNT(*), ROUND(COUNT(tozai_shozoku_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'shotai_chiikimei', COUNT(shotai_chiikimei), COUNT(*), ROUND(COUNT(shotai_chiikimei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'jushoshori_joho_1', COUNT(jushoshori_joho_1), COUNT(*), ROUND(COUNT(jushoshori_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'jushoshori_joho_2', COUNT(jushoshori_joho_2), COUNT(*), ROUND(COUNT(jushoshori_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'jushoshori_joho_3', COUNT(jushoshori_joho_3), COUNT(*), ROUND(COUNT(jushoshori_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'seiseki_joho_1', COUNT(seiseki_joho_1), COUNT(*), ROUND(COUNT(seiseki_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'seiseki_joho_2', COUNT(seiseki_joho_2), COUNT(*), ROUND(COUNT(seiseki_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
UNION ALL SELECT 'jvd_ch', 'seiseki_joho_3', COUNT(seiseki_joho_3), COUNT(*), ROUND(COUNT(seiseki_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_ch
;

-- ============================================================================
-- 30. JVD_CS (8カラム)
-- ============================================================================
-- 実行後、結果を jvd_cs_fillrate.csv で保存してください

SELECT 'jvd_cs' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'kyori', COUNT(kyori), COUNT(*), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'track_code', COUNT(track_code), COUNT(*), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'course_kaishu_nengappi', COUNT(course_kaishu_nengappi), COUNT(*), ROUND(COUNT(course_kaishu_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
UNION ALL SELECT 'jvd_cs', 'course_setsumei', COUNT(course_setsumei), COUNT(*), ROUND(COUNT(course_setsumei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_cs
;

-- ============================================================================
-- 31. JVD_BT (7カラム)
-- ============================================================================
-- 実行後、結果を jvd_bt_fillrate.csv で保存してください

SELECT 'jvd_bt' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'data_sakusei_nengappi', COUNT(data_sakusei_nengappi), COUNT(*), ROUND(COUNT(data_sakusei_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'hanshoku_toroku_bango', COUNT(hanshoku_toroku_bango), COUNT(*), ROUND(COUNT(hanshoku_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'keito_id', COUNT(keito_id), COUNT(*), ROUND(COUNT(keito_id)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'keito_mei', COUNT(keito_mei), COUNT(*), ROUND(COUNT(keito_mei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
UNION ALL SELECT 'jvd_bt', 'keito_setsumei', COUNT(keito_setsumei), COUNT(*), ROUND(COUNT(keito_setsumei)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_bt
;

-- ============================================================================
-- 32. JRD_KYI (132カラム)
-- ============================================================================
-- 実行後、結果を jrd_kyi_fillrate.csv で保存してください

SELECT 'jrd_kyi' AS table_name, 'keibajo_code' AS column_name, COUNT(keibajo_code) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'race_shikonen', COUNT(race_shikonen), COUNT(*), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'umaban', COUNT(umaban), COUNT(*), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'idm', COUNT(idm), COUNT(*), ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_shisu', COUNT(kishu_shisu), COUNT(*), ROUND(COUNT(kishu_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'joho_shisu', COUNT(joho_shisu), COUNT(*), ROUND(COUNT(joho_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_shisu', COUNT(sogo_shisu), COUNT(*), ROUND(COUNT(sogo_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyakushitsu_code', COUNT(kyakushitsu_code), COUNT(*), ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyori_tekisei_code', COUNT(kyori_tekisei_code), COUNT(*), ROUND(COUNT(kyori_tekisei_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'joshodo_code', COUNT(joshodo_code), COUNT(*), ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'rotation', COUNT(rotation), COUNT(*), ROUND(COUNT(rotation)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kijun_odds_tansho', COUNT(kijun_odds_tansho), COUNT(*), ROUND(COUNT(kijun_odds_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kijun_ninkijun_tansho', COUNT(kijun_ninkijun_tansho), COUNT(*), ROUND(COUNT(kijun_ninkijun_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kijun_odds_fukusho', COUNT(kijun_odds_fukusho), COUNT(*), ROUND(COUNT(kijun_odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kijun_ninkijun_fukusho', COUNT(kijun_ninkijun_fukusho), COUNT(*), ROUND(COUNT(kijun_ninkijun_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tokutei_joho_1', COUNT(tokutei_joho_1), COUNT(*), ROUND(COUNT(tokutei_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tokutei_joho_2', COUNT(tokutei_joho_2), COUNT(*), ROUND(COUNT(tokutei_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tokutei_joho_3', COUNT(tokutei_joho_3), COUNT(*), ROUND(COUNT(tokutei_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tokutei_joho_4', COUNT(tokutei_joho_4), COUNT(*), ROUND(COUNT(tokutei_joho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tokutei_joho_5', COUNT(tokutei_joho_5), COUNT(*), ROUND(COUNT(tokutei_joho_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_joho_1', COUNT(sogo_joho_1), COUNT(*), ROUND(COUNT(sogo_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_joho_2', COUNT(sogo_joho_2), COUNT(*), ROUND(COUNT(sogo_joho_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_joho_3', COUNT(sogo_joho_3), COUNT(*), ROUND(COUNT(sogo_joho_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_joho_4', COUNT(sogo_joho_4), COUNT(*), ROUND(COUNT(sogo_joho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sogo_joho_5', COUNT(sogo_joho_5), COUNT(*), ROUND(COUNT(sogo_joho_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ninki_shisu', COUNT(ninki_shisu), COUNT(*), ROUND(COUNT(ninki_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'chokyo_shisu', COUNT(chokyo_shisu), COUNT(*), ROUND(COUNT(chokyo_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyusha_shisu', COUNT(kyusha_shisu), COUNT(*), ROUND(COUNT(kyusha_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'chokyo_yajirushi_code', COUNT(chokyo_yajirushi_code), COUNT(*), ROUND(COUNT(chokyo_yajirushi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyusha_hyoka_code', COUNT(kyusha_hyoka_code), COUNT(*), ROUND(COUNT(kyusha_hyoka_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_kitai_rentai_ritsu', COUNT(kishu_kitai_rentai_ritsu), COUNT(*), ROUND(COUNT(kishu_kitai_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'gekiso_shisu', COUNT(gekiso_shisu), COUNT(*), ROUND(COUNT(gekiso_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'hizume_code', COUNT(hizume_code), COUNT(*), ROUND(COUNT(hizume_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tekisei_code_omo', COUNT(tekisei_code_omo), COUNT(*), ROUND(COUNT(tekisei_code_omo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'class_code', COUNT(class_code), COUNT(*), ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yobi_2', COUNT(yobi_2), COUNT(*), ROUND(COUNT(yobi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'blinker_shiyo_kubun', COUNT(blinker_shiyo_kubun), COUNT(*), ROUND(COUNT(blinker_shiyo_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishumei', COUNT(kishumei), COUNT(*), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'futan_juryo', COUNT(futan_juryo), COUNT(*), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_minarai_code', COUNT(kishu_minarai_code), COUNT(*), ROUND(COUNT(kishu_minarai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'chokyoshimei', COUNT(chokyoshimei), COUNT(*), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'chokyoshi_shozoku', COUNT(chokyoshi_shozoku), COUNT(*), ROUND(COUNT(chokyoshi_shozoku)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako1_kyoso_seiseki_key', COUNT(kako1_kyoso_seiseki_key), COUNT(*), ROUND(COUNT(kako1_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako2_kyoso_seiseki_key', COUNT(kako2_kyoso_seiseki_key), COUNT(*), ROUND(COUNT(kako2_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako3_kyoso_seiseki_key', COUNT(kako3_kyoso_seiseki_key), COUNT(*), ROUND(COUNT(kako3_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako4_kyoso_seiseki_key', COUNT(kako4_kyoso_seiseki_key), COUNT(*), ROUND(COUNT(kako4_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako5_kyoso_seiseki_key', COUNT(kako5_kyoso_seiseki_key), COUNT(*), ROUND(COUNT(kako5_kyoso_seiseki_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako1_race_key', COUNT(kako1_race_key), COUNT(*), ROUND(COUNT(kako1_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako2_race_key', COUNT(kako2_race_key), COUNT(*), ROUND(COUNT(kako2_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako3_race_key', COUNT(kako3_race_key), COUNT(*), ROUND(COUNT(kako3_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako4_race_key', COUNT(kako4_race_key), COUNT(*), ROUND(COUNT(kako4_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kako5_race_key', COUNT(kako5_race_key), COUNT(*), ROUND(COUNT(kako5_race_key)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'wakuban', COUNT(wakuban), COUNT(*), ROUND(COUNT(wakuban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yobi_3', COUNT(yobi_3), COUNT(*), ROUND(COUNT(yobi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_1', COUNT(shirushi_code_1), COUNT(*), ROUND(COUNT(shirushi_code_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_2', COUNT(shirushi_code_2), COUNT(*), ROUND(COUNT(shirushi_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_3', COUNT(shirushi_code_3), COUNT(*), ROUND(COUNT(shirushi_code_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_4', COUNT(shirushi_code_4), COUNT(*), ROUND(COUNT(shirushi_code_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_5', COUNT(shirushi_code_5), COUNT(*), ROUND(COUNT(shirushi_code_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_6', COUNT(shirushi_code_6), COUNT(*), ROUND(COUNT(shirushi_code_6)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shirushi_code_7', COUNT(shirushi_code_7), COUNT(*), ROUND(COUNT(shirushi_code_7)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tekisei_code_shiba', COUNT(tekisei_code_shiba), COUNT(*), ROUND(COUNT(tekisei_code_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tekisei_code_dirt', COUNT(tekisei_code_dirt), COUNT(*), ROUND(COUNT(tekisei_code_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_code', COUNT(kishu_code), COUNT(*), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yobi_4', COUNT(yobi_4), COUNT(*), ROUND(COUNT(yobi_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kakutoku_shokin_ruikei', COUNT(kakutoku_shokin_ruikei), COUNT(*), ROUND(COUNT(kakutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'shutoku_shokin_ruikei', COUNT(shutoku_shokin_ruikei), COUNT(*), ROUND(COUNT(shutoku_shokin_ruikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'joken_class_code', COUNT(joken_class_code), COUNT(*), ROUND(COUNT(joken_class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ten_shisu', COUNT(ten_shisu), COUNT(*), ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'pace_shisu', COUNT(pace_shisu), COUNT(*), ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'agari_shisu', COUNT(agari_shisu), COUNT(*), ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ichi_shisu', COUNT(ichi_shisu), COUNT(*), ROUND(COUNT(ichi_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'pace_yoso', COUNT(pace_yoso), COUNT(*), ROUND(COUNT(pace_yoso)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'dochu_juni', COUNT(dochu_juni), COUNT(*), ROUND(COUNT(dochu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'dochu_sa', COUNT(dochu_sa), COUNT(*), ROUND(COUNT(dochu_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'dochu_uchisoto', COUNT(dochu_uchisoto), COUNT(*), ROUND(COUNT(dochu_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kohan_3f_juni', COUNT(kohan_3f_juni), COUNT(*), ROUND(COUNT(kohan_3f_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kohan_3f_sa', COUNT(kohan_3f_sa), COUNT(*), ROUND(COUNT(kohan_3f_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kohan_3f_uchisoto', COUNT(kohan_3f_uchisoto), COUNT(*), ROUND(COUNT(kohan_3f_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'goal_juni', COUNT(goal_juni), COUNT(*), ROUND(COUNT(goal_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'goal_sa', COUNT(goal_sa), COUNT(*), ROUND(COUNT(goal_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'goal_uchisoto', COUNT(goal_uchisoto), COUNT(*), ROUND(COUNT(goal_uchisoto)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'tenkai_kigo_code', COUNT(tenkai_kigo_code), COUNT(*), ROUND(COUNT(tenkai_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyori_tekisei_code_2', COUNT(kyori_tekisei_code_2), COUNT(*), ROUND(COUNT(kyori_tekisei_code_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'bataiju', COUNT(bataiju), COUNT(*), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'bataiju_zogen', COUNT(bataiju_zogen), COUNT(*), ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'torikeshi_flag', COUNT(torikeshi_flag), COUNT(*), ROUND(COUNT(torikeshi_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'seibetsu_code', COUNT(seibetsu_code), COUNT(*), ROUND(COUNT(seibetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'banushimei', COUNT(banushimei), COUNT(*), ROUND(COUNT(banushimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'banushikai_code', COUNT(banushikai_code), COUNT(*), ROUND(COUNT(banushikai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'umakigo_code', COUNT(umakigo_code), COUNT(*), ROUND(COUNT(umakigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'gekiso_juni', COUNT(gekiso_juni), COUNT(*), ROUND(COUNT(gekiso_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ls_shisu_juni', COUNT(ls_shisu_juni), COUNT(*), ROUND(COUNT(ls_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ten_shisu_juni', COUNT(ten_shisu_juni), COUNT(*), ROUND(COUNT(ten_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'pace_shisu_juni', COUNT(pace_shisu_juni), COUNT(*), ROUND(COUNT(pace_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'agari_shisu_juni', COUNT(agari_shisu_juni), COUNT(*), ROUND(COUNT(agari_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'ichi_shisu_juni', COUNT(ichi_shisu_juni), COUNT(*), ROUND(COUNT(ichi_shisu_juni)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_kitai_tansho_ritsu', COUNT(kishu_kitai_tansho_ritsu), COUNT(*), ROUND(COUNT(kishu_kitai_tansho_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kishu_kitai_sanchakunai_ritsu', COUNT(kishu_kitai_sanchakunai_ritsu), COUNT(*), ROUND(COUNT(kishu_kitai_sanchakunai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yuso_kubun', COUNT(yuso_kubun), COUNT(*), ROUND(COUNT(yuso_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'soho', COUNT(soho), COUNT(*), ROUND(COUNT(soho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'taikei', COUNT(taikei), COUNT(*), ROUND(COUNT(taikei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'taikei_sogo_1', COUNT(taikei_sogo_1), COUNT(*), ROUND(COUNT(taikei_sogo_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'taikei_sogo_2', COUNT(taikei_sogo_2), COUNT(*), ROUND(COUNT(taikei_sogo_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'taikei_sogo_3', COUNT(taikei_sogo_3), COUNT(*), ROUND(COUNT(taikei_sogo_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'uma_tokki_1', COUNT(uma_tokki_1), COUNT(*), ROUND(COUNT(uma_tokki_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'uma_tokki_2', COUNT(uma_tokki_2), COUNT(*), ROUND(COUNT(uma_tokki_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'uma_tokki_3', COUNT(uma_tokki_3), COUNT(*), ROUND(COUNT(uma_tokki_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'uma_start_shisu', COUNT(uma_start_shisu), COUNT(*), ROUND(COUNT(uma_start_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'uma_deokure_ritsu', COUNT(uma_deokure_ritsu), COUNT(*), ROUND(COUNT(uma_deokure_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sanko_zenso', COUNT(sanko_zenso), COUNT(*), ROUND(COUNT(sanko_zenso)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'sanko_zenso_kishu_code', COUNT(sanko_zenso_kishu_code), COUNT(*), ROUND(COUNT(sanko_zenso_kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'manken_shisu', COUNT(manken_shisu), COUNT(*), ROUND(COUNT(manken_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'manken_shirushi', COUNT(manken_shirushi), COUNT(*), ROUND(COUNT(manken_shirushi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kokyu_flag', COUNT(kokyu_flag), COUNT(*), ROUND(COUNT(kokyu_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'gekiso_type', COUNT(gekiso_type), COUNT(*), ROUND(COUNT(gekiso_type)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyuyo_riyu_bunrui_code', COUNT(kyuyo_riyu_bunrui_code), COUNT(*), ROUND(COUNT(kyuyo_riyu_bunrui_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'flag', COUNT(flag), COUNT(*), ROUND(COUNT(flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'nyukyu_nansome', COUNT(nyukyu_nansome), COUNT(*), ROUND(COUNT(nyukyu_nansome)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'nyukyu_nengappi', COUNT(nyukyu_nengappi), COUNT(*), ROUND(COUNT(nyukyu_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'nyukyu_nannichimae', COUNT(nyukyu_nannichimae), COUNT(*), ROUND(COUNT(nyukyu_nannichimae)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'hobokusaki', COUNT(hobokusaki), COUNT(*), ROUND(COUNT(hobokusaki)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'hobokusaki_rank', COUNT(hobokusaki_rank), COUNT(*), ROUND(COUNT(hobokusaki_rank)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'kyusha_rank', COUNT(kyusha_rank), COUNT(*), ROUND(COUNT(kyusha_rank)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
UNION ALL SELECT 'jrd_kyi', 'yobi_5', COUNT(yobi_5), COUNT(*), ROUND(COUNT(yobi_5)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_kyi
;

-- ============================================================================
-- 33. JRD_SED (80カラム)
-- ============================================================================
-- 実行後、結果を jrd_sed_fillrate.csv で保存してください

SELECT 'jrd_sed' AS table_name, 'keibajo_code' AS column_name, COUNT(keibajo_code) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race_shikonen', COUNT(race_shikonen), COUNT(*), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'umaban', COUNT(umaban), COUNT(*), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyori', COUNT(kyori), COUNT(*), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'track_code', COUNT(track_code), COUNT(*), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'babajotai_code', COUNT(babajotai_code), COUNT(*), ROUND(COUNT(babajotai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyoso_shubetsu_code', COUNT(kyoso_shubetsu_code), COUNT(*), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyoso_joken_code', COUNT(kyoso_joken_code), COUNT(*), ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyoso_kigo_code', COUNT(kyoso_kigo_code), COUNT(*), ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'juryo_shubetsu_code', COUNT(juryo_shubetsu_code), COUNT(*), ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'grade_code', COUNT(grade_code), COUNT(*), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyosomei', COUNT(kyosomei), COUNT(*), ROUND(COUNT(kyosomei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyosomei_ryakusho_4', COUNT(kyosomei_ryakusho_4), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kakutei_chakujun', COUNT(kakutei_chakujun), COUNT(*), ROUND(COUNT(kakutei_chakujun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'ijo_kubun_code', COUNT(ijo_kubun_code), COUNT(*), ROUND(COUNT(ijo_kubun_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'soha_time', COUNT(soha_time), COUNT(*), ROUND(COUNT(soha_time)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'futan_juryo', COUNT(futan_juryo), COUNT(*), ROUND(COUNT(futan_juryo)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kishumei', COUNT(kishumei), COUNT(*), ROUND(COUNT(kishumei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'chokyoshimei', COUNT(chokyoshimei), COUNT(*), ROUND(COUNT(chokyoshimei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'tansho_odds', COUNT(tansho_odds), COUNT(*), ROUND(COUNT(tansho_odds)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'tansho_ninkijun', COUNT(tansho_ninkijun), COUNT(*), ROUND(COUNT(tansho_ninkijun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'idm', COUNT(idm), COUNT(*), ROUND(COUNT(idm)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'soten', COUNT(soten), COUNT(*), ROUND(COUNT(soten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'babasa', COUNT(babasa), COUNT(*), ROUND(COUNT(babasa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'pace', COUNT(pace), COUNT(*), ROUND(COUNT(pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'deokure', COUNT(deokure), COUNT(*), ROUND(COUNT(deokure)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'ichidori', COUNT(ichidori), COUNT(*), ROUND(COUNT(ichidori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'furi', COUNT(furi), COUNT(*), ROUND(COUNT(furi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'furi_1', COUNT(furi_1), COUNT(*), ROUND(COUNT(furi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'furi_2', COUNT(furi_2), COUNT(*), ROUND(COUNT(furi_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'furi_3', COUNT(furi_3), COUNT(*), ROUND(COUNT(furi_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race', COUNT(race), COUNT(*), ROUND(COUNT(race)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'course_dori_code', COUNT(course_dori_code), COUNT(*), ROUND(COUNT(course_dori_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'joshodo_code', COUNT(joshodo_code), COUNT(*), ROUND(COUNT(joshodo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'class_code', COUNT(class_code), COUNT(*), ROUND(COUNT(class_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'batai_code', COUNT(batai_code), COUNT(*), ROUND(COUNT(batai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kehai_code', COUNT(kehai_code), COUNT(*), ROUND(COUNT(kehai_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race_pace', COUNT(race_pace), COUNT(*), ROUND(COUNT(race_pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'uma_pace', COUNT(uma_pace), COUNT(*), ROUND(COUNT(uma_pace)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'ten_shisu', COUNT(ten_shisu), COUNT(*), ROUND(COUNT(ten_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'agari_shisu', COUNT(agari_shisu), COUNT(*), ROUND(COUNT(agari_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'pace_shisu', COUNT(pace_shisu), COUNT(*), ROUND(COUNT(pace_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race_p_shisu', COUNT(race_p_shisu), COUNT(*), ROUND(COUNT(race_p_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'aiteuma_joho_1', COUNT(aiteuma_joho_1), COUNT(*), ROUND(COUNT(aiteuma_joho_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'zenhan_3f_taimu', COUNT(zenhan_3f_taimu), COUNT(*), ROUND(COUNT(zenhan_3f_taimu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kohan_3f', COUNT(kohan_3f), COUNT(*), ROUND(COUNT(kohan_3f)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'biko', COUNT(biko), COUNT(*), ROUND(COUNT(biko)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'odds_fukusho', COUNT(odds_fukusho), COUNT(*), ROUND(COUNT(odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'odds_tansho_10am', COUNT(odds_tansho_10am), COUNT(*), ROUND(COUNT(odds_tansho_10am)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'odds_fukusho_10am', COUNT(odds_fukusho_10am), COUNT(*), ROUND(COUNT(odds_fukusho_10am)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'corner_1', COUNT(corner_1), COUNT(*), ROUND(COUNT(corner_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'corner_2', COUNT(corner_2), COUNT(*), ROUND(COUNT(corner_2)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'corner_3', COUNT(corner_3), COUNT(*), ROUND(COUNT(corner_3)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'corner_4', COUNT(corner_4), COUNT(*), ROUND(COUNT(corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'zenhan_3f_sento_sa', COUNT(zenhan_3f_sento_sa), COUNT(*), ROUND(COUNT(zenhan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kohan_3f_sento_sa', COUNT(kohan_3f_sento_sa), COUNT(*), ROUND(COUNT(kohan_3f_sento_sa)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kishu_code', COUNT(kishu_code), COUNT(*), ROUND(COUNT(kishu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'chokyoshi_code', COUNT(chokyoshi_code), COUNT(*), ROUND(COUNT(chokyoshi_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'bataiju', COUNT(bataiju), COUNT(*), ROUND(COUNT(bataiju)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'bataiju_zogen', COUNT(bataiju_zogen), COUNT(*), ROUND(COUNT(bataiju_zogen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'tenko_code', COUNT(tenko_code), COUNT(*), ROUND(COUNT(tenko_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'course_kubun', COUNT(course_kubun), COUNT(*), ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'kyakushitsu_code', COUNT(kyakushitsu_code), COUNT(*), ROUND(COUNT(kyakushitsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'haraimodoshi_tansho', COUNT(haraimodoshi_tansho), COUNT(*), ROUND(COUNT(haraimodoshi_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'haraimodoshi_fukusho', COUNT(haraimodoshi_fukusho), COUNT(*), ROUND(COUNT(haraimodoshi_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'honshokin', COUNT(honshokin), COUNT(*), ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'shutoku_shokin', COUNT(shutoku_shokin), COUNT(*), ROUND(COUNT(shutoku_shokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'race_pace_nagare', COUNT(race_pace_nagare), COUNT(*), ROUND(COUNT(race_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'uma_pace_nagare', COUNT(uma_pace_nagare), COUNT(*), ROUND(COUNT(uma_pace_nagare)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'corse_dori_code_corner_4', COUNT(corse_dori_code_corner_4), COUNT(*), ROUND(COUNT(corse_dori_code_corner_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
UNION ALL SELECT 'jrd_sed', 'hasso_jikoku', COUNT(hasso_jikoku), COUNT(*), ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_sed
;

-- ============================================================================
-- 34. JRD_JOA (24カラム)
-- ============================================================================
-- 実行後、結果を jrd_joa_fillrate.csv で保存してください

SELECT 'jrd_joa' AS table_name, 'keibajo_code' AS column_name, COUNT(keibajo_code) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'race_shikonen', COUNT(race_shikonen), COUNT(*), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'umaban', COUNT(umaban), COUNT(*), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'ketto_toroku_bango', COUNT(ketto_toroku_bango), COUNT(*), ROUND(COUNT(ketto_toroku_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'bamei', COUNT(bamei), COUNT(*), ROUND(COUNT(bamei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kijun_odds_tansho', COUNT(kijun_odds_tansho), COUNT(*), ROUND(COUNT(kijun_odds_tansho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kijun_odds_fukusho', COUNT(kijun_odds_fukusho), COUNT(*), ROUND(COUNT(kijun_odds_fukusho)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'cid_chokyo_soten', COUNT(cid_chokyo_soten), COUNT(*), ROUND(COUNT(cid_chokyo_soten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'cid_kyusha_soten', COUNT(cid_kyusha_soten), COUNT(*), ROUND(COUNT(cid_kyusha_soten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'cid_soten', COUNT(cid_soten), COUNT(*), ROUND(COUNT(cid_soten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'cid', COUNT(cid), COUNT(*), ROUND(COUNT(cid)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'ls_shisu', COUNT(ls_shisu), COUNT(*), ROUND(COUNT(ls_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'ls_hyoka', COUNT(ls_hyoka), COUNT(*), ROUND(COUNT(ls_hyoka)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'em', COUNT(em), COUNT(*), ROUND(COUNT(em)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kyusha_bb_shirushi', COUNT(kyusha_bb_shirushi), COUNT(*), ROUND(COUNT(kyusha_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kyusha_bb_nijumaru_tansho_kaishuritsu', COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu), COUNT(*), ROUND(COUNT(kyusha_bb_nijumaru_tansho_kaishuritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kyusha_bb_nijumaru_rentai_ritsu', COUNT(kyusha_bb_nijumaru_rentai_ritsu), COUNT(*), ROUND(COUNT(kyusha_bb_nijumaru_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kishu_bb_shirushi', COUNT(kishu_bb_shirushi), COUNT(*), ROUND(COUNT(kishu_bb_shirushi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kishu_bb_nijumaru_tansho_kaishuritsu', COUNT(kishu_bb_nijumaru_tansho_kaishuritsu), COUNT(*), ROUND(COUNT(kishu_bb_nijumaru_tansho_kaishuritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'kishu_bb_nijumaru_rentai_ritsu', COUNT(kishu_bb_nijumaru_rentai_ritsu), COUNT(*), ROUND(COUNT(kishu_bb_nijumaru_rentai_ritsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
UNION ALL SELECT 'jrd_joa', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_joa
;

-- ============================================================================
-- 35. JRD_CYB (27カラム)
-- ============================================================================
-- 実行後、結果を jrd_cyb_fillrate.csv で保存してください

SELECT 'jrd_cyb' AS table_name, 'keibajo_code' AS column_name, COUNT(keibajo_code) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'race_shikonen', COUNT(race_shikonen), COUNT(*), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'umaban', COUNT(umaban), COUNT(*), ROUND(COUNT(umaban)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_type', COUNT(chokyo_type), COUNT(*), ROUND(COUNT(chokyo_type)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_shubetsu', COUNT(chokyo_corse_shubetsu), COUNT(*), ROUND(COUNT(chokyo_corse_shubetsu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_hanro', COUNT(chokyo_corse_hanro), COUNT(*), ROUND(COUNT(chokyo_corse_hanro)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_wood', COUNT(chokyo_corse_wood), COUNT(*), ROUND(COUNT(chokyo_corse_wood)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_dirt', COUNT(chokyo_corse_dirt), COUNT(*), ROUND(COUNT(chokyo_corse_dirt)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_shiba', COUNT(chokyo_corse_shiba), COUNT(*), ROUND(COUNT(chokyo_corse_shiba)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_pool', COUNT(chokyo_corse_pool), COUNT(*), ROUND(COUNT(chokyo_corse_pool)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_shogai', COUNT(chokyo_corse_shogai), COUNT(*), ROUND(COUNT(chokyo_corse_shogai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_corse_polytrack', COUNT(chokyo_corse_polytrack), COUNT(*), ROUND(COUNT(chokyo_corse_polytrack)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_kyori', COUNT(chokyo_kyori), COUNT(*), ROUND(COUNT(chokyo_kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_juten', COUNT(chokyo_juten), COUNT(*), ROUND(COUNT(chokyo_juten)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'oikiri_shisu', COUNT(oikiri_shisu), COUNT(*), ROUND(COUNT(oikiri_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'shiage_shisu', COUNT(shiage_shisu), COUNT(*), ROUND(COUNT(shiage_shisu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_ryo_hyoka', COUNT(chokyo_ryo_hyoka), COUNT(*), ROUND(COUNT(chokyo_ryo_hyoka)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'shiage_shisu_henka', COUNT(shiage_shisu_henka), COUNT(*), ROUND(COUNT(shiage_shisu_henka)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_comment', COUNT(chokyo_comment), COUNT(*), ROUND(COUNT(chokyo_comment)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'comment_nengappi', COUNT(comment_nengappi), COUNT(*), ROUND(COUNT(comment_nengappi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'chokyo_hyoka', COUNT(chokyo_hyoka), COUNT(*), ROUND(COUNT(chokyo_hyoka)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'oikiri_shisu_isshumae', COUNT(oikiri_shisu_isshumae), COUNT(*), ROUND(COUNT(oikiri_shisu_isshumae)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'oikiri_corse_isshumae', COUNT(oikiri_corse_isshumae), COUNT(*), ROUND(COUNT(oikiri_corse_isshumae)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
UNION ALL SELECT 'jrd_cyb', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_cyb
;

-- ============================================================================
-- 36. JRD_BAC (27カラム)
-- ============================================================================
-- 実行後、結果を jrd_bac_fillrate.csv で保存してください

SELECT 'jrd_bac' AS table_name, 'keibajo_code' AS column_name, COUNT(keibajo_code) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'race_shikonen', COUNT(race_shikonen), COUNT(*), ROUND(COUNT(race_shikonen)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kaisai_kai', COUNT(kaisai_kai), COUNT(*), ROUND(COUNT(kaisai_kai)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kaisai_nichime', COUNT(kaisai_nichime), COUNT(*), ROUND(COUNT(kaisai_nichime)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'race_bango', COUNT(race_bango), COUNT(*), ROUND(COUNT(race_bango)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'hasso_jikoku', COUNT(hasso_jikoku), COUNT(*), ROUND(COUNT(hasso_jikoku)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyori', COUNT(kyori), COUNT(*), ROUND(COUNT(kyori)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'track_code', COUNT(track_code), COUNT(*), ROUND(COUNT(track_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyoso_shubetsu_code', COUNT(kyoso_shubetsu_code), COUNT(*), ROUND(COUNT(kyoso_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyoso_joken_code', COUNT(kyoso_joken_code), COUNT(*), ROUND(COUNT(kyoso_joken_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyoso_kigo_code', COUNT(kyoso_kigo_code), COUNT(*), ROUND(COUNT(kyoso_kigo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'juryo_shubetsu_code', COUNT(juryo_shubetsu_code), COUNT(*), ROUND(COUNT(juryo_shubetsu_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'grade_code', COUNT(grade_code), COUNT(*), ROUND(COUNT(grade_code)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyosomei', COUNT(kyosomei), COUNT(*), ROUND(COUNT(kyosomei)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'jusho_kaiji', COUNT(jusho_kaiji), COUNT(*), ROUND(COUNT(jusho_kaiji)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'toroku_tosu', COUNT(toroku_tosu), COUNT(*), ROUND(COUNT(toroku_tosu)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'course_kubun', COUNT(course_kubun), COUNT(*), ROUND(COUNT(course_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kaisai_kubun', COUNT(kaisai_kubun), COUNT(*), ROUND(COUNT(kaisai_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyosomei_ryakusho_4', COUNT(kyosomei_ryakusho_4), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_4)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'kyosomei_ryakusho_9', COUNT(kyosomei_ryakusho_9), COUNT(*), ROUND(COUNT(kyosomei_ryakusho_9)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'honshokin', COUNT(honshokin), COUNT(*), ROUND(COUNT(honshokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'fukashokin', COUNT(fukashokin), COUNT(*), ROUND(COUNT(fukashokin)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'baken_hatsubai_flag', COUNT(baken_hatsubai_flag), COUNT(*), ROUND(COUNT(baken_hatsubai_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'win5_flag', COUNT(win5_flag), COUNT(*), ROUND(COUNT(win5_flag)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
UNION ALL SELECT 'jrd_bac', 'yobi_1', COUNT(yobi_1), COUNT(*), ROUND(COUNT(yobi_1)::NUMERIC / COUNT(*) * 100, 2) FROM jrd_bac
;

-- ====================================================================================================
-- 合計: 36テーブルのSQL
-- ====================================================================================================
