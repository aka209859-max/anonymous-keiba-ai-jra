-- ============================================================
-- Phase 7-A: 年次カラムがあるテーブル レコード数確認SQL（修正版）
-- 作成日: 2026-03-03
-- 目的: kaisai_nenカラムがあるテーブルの2016～2025年レコード数を確認
-- ============================================================

-- 各テーブルを個別に実行（エラー回避）
-- ============================================================

-- 1. jvd_se
SELECT 'jvd_se' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_se;

-- 2. jvd_ra
SELECT 'jvd_ra' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_ra;

-- 3. jvd_ck
SELECT 'jvd_ck' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_ck;

-- 4. jvd_tk
SELECT 'jvd_tk' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_tk;

-- 5. jvd_wf
SELECT 'jvd_wf' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_wf;

-- 6. jvd_hr
SELECT 'jvd_hr' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_hr;

-- 7. jvd_h1
SELECT 'jvd_h1' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_h1;

-- 8. jvd_h6
SELECT 'jvd_h6' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_h6;

-- 9. jvd_dm
SELECT 'jvd_dm' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_dm;

-- 10. jvd_wh
SELECT 'jvd_wh' AS table_name, 
       COUNT(*) AS total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_wh;

-- ============================================================
-- JRDB 5テーブル - 総レコード数のみ
-- ============================================================

-- 11. jrd_kyi
SELECT 'jrd_kyi' AS table_name, 
       COUNT(*) AS total_records,
       0 AS records_2016_2025
FROM jrd_kyi;

-- 12. jrd_sed
SELECT 'jrd_sed' AS table_name, 
       COUNT(*) AS total_records,
       0 AS records_2016_2025
FROM jrd_sed;

-- 13. jrd_bac
SELECT 'jrd_bac' AS table_name, 
       COUNT(*) AS total_records,
       0 AS records_2016_2025
FROM jrd_bac;

-- 14. jrd_cyb
SELECT 'jrd_cyb' AS table_name, 
       COUNT(*) AS total_records,
       0 AS records_2016_2025
FROM jrd_cyb;

-- 15. jrd_joa
SELECT 'jrd_joa' AS table_name, 
       COUNT(*) AS total_records,
       0 AS records_2016_2025
FROM jrd_joa;

-- ============================================================
-- 実行手順:
-- 1. 上記15個のSQLを順番に実行
-- 2. 各結果をメモまたはスクリーンショット
-- 3. エラーが出たテーブルは、そのテーブルにkaisai_nenカラムがない
-- ============================================================
