-- ====================================================================================================
-- Phase 7-A: 全1,939カラムの充填率チェック（シンプル版）
-- ====================================================================================================
-- 各テーブルごとに個別にSQLを実行してください
-- ====================================================================================================

-- 【実行方法】
-- 1. 以下のテーブルごとのSQLを1つずつpgAdmin4で実行
-- 2. 各結果をCSVでエクスポート
-- 3. すべてのCSVを統合
-- ====================================================================================================

-- ============================================================================
-- 1. jvd_se の充填率チェック
-- ============================================================================
-- 実行コマンド: 以下をpgAdmin4で実行し、結果を jvd_se_fillrate.csv で保存
SELECT 'jvd_se' AS table_name, 'record_id' AS column_name, COUNT(record_id) AS filled_count, COUNT(*) AS total_count, ROUND(COUNT(record_id)::NUMERIC / COUNT(*) * 100, 2) AS fillrate FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'data_kubun', COUNT(data_kubun), COUNT(*), ROUND(COUNT(data_kubun)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_nen', COUNT(kaisai_nen), COUNT(*), ROUND(COUNT(kaisai_nen)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'kaisai_tsukihi', COUNT(kaisai_tsukihi), COUNT(*), ROUND(COUNT(kaisai_tsukihi)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025'
UNION ALL SELECT 'jvd_se', 'keibajo_code', COUNT(keibajo_code), COUNT(*), ROUND(COUNT(keibajo_code)::NUMERIC / COUNT(*) * 100, 2) FROM jvd_se WHERE kaisai_nen BETWEEN '2016' AND '2025';

-- 上記は最初の5カラムのみのサンプルです
-- すべてのカラムを含む完全版SQLは別途生成します

