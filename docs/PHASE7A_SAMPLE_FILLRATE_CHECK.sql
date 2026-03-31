-- ====================================================================================================
-- Phase 7-A: 主要テーブルのカラム充填率確認（サンプル版）
-- ====================================================================================================
-- 主要8テーブルの全カラムのNULL率を確認
-- ====================================================================================================

-- 1. jvd_se (70カラム) - 2016-2025年データ
SELECT 
    'jvd_se' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(record_id) AS filled_record_id,
    COUNT(kaisai_nen) AS filled_kaisai_nen,
    COUNT(umaban) AS filled_umaban,
    COUNT(ketto_toroku_bango) AS filled_ketto_toroku_bango,
    COUNT(kakutei_chakujun) AS filled_kakutei_chakujun,
    COUNT(kishu_code) AS filled_kishu_code,
    COUNT(chokyoshi_code) AS filled_chokyoshi_code,
    COUNT(bataiju) AS filled_bataiju,
    COUNT(futan_juryo) AS filled_futan_juryo,
    -- 主要カラムのみ確認
    ROUND(100.0 * COUNT(record_id) / COUNT(*), 2) AS fillrate_record_id,
    ROUND(100.0 * COUNT(kaisai_nen) / COUNT(*), 2) AS fillrate_kaisai_nen,
    ROUND(100.0 * COUNT(umaban) / COUNT(*), 2) AS fillrate_umaban,
    ROUND(100.0 * COUNT(kakutei_chakujun) / COUNT(*), 2) AS fillrate_kakutei_chakujun
FROM jvd_se 
WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- 結果をCSVでエクスポートしてアップロードしてください
