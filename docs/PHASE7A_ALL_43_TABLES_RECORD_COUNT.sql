-- ============================================================
-- Phase 7-A: 全43テーブル レコード数確認SQL
-- 作成日: 2026-03-03
-- 目的: 全テーブルの総レコード数と2016～2025年のレコード数を確認
-- ============================================================

-- ============================================================
-- 【重要】各テーブルの年次カラムを確認してから実行してください
-- kaisai_nen カラムがあるテーブルのみ年次フィルタ可能
-- ============================================================

-- ============================================================
-- JRA-VAN 38テーブル - レコード数確認
-- ============================================================

-- 年次カラム（kaisai_nen）があるテーブル
SELECT 'jvd_se' AS table_name, COUNT(*) AS total_records, 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025 FROM jvd_se
UNION ALL
SELECT 'jvd_ra', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_ra
UNION ALL
SELECT 'jvd_ck', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_ck
UNION ALL
SELECT 'jvd_tk', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_tk
UNION ALL
SELECT 'jvd_wf', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_wf
UNION ALL
SELECT 'jvd_hr', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_hr
UNION ALL
SELECT 'jvd_h1', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_h1
UNION ALL
SELECT 'jvd_h6', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_h6
UNION ALL
SELECT 'jvd_dm', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_dm
UNION ALL
SELECT 'jvd_wh', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_wh
UNION ALL
SELECT 'jvd_wc', COUNT(*), 
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) FROM jvd_wc;

-- 年次カラムがないテーブル（総レコード数のみ）
SELECT 'jvd_um' AS table_name, COUNT(*) AS total_records, 0 AS records_2016_2025 FROM jvd_um
UNION ALL
SELECT 'jvd_ks', COUNT(*), 0 FROM jvd_ks
UNION ALL
SELECT 'jvd_sk', COUNT(*), 0 FROM jvd_sk
UNION ALL
SELECT 'jvd_rc', COUNT(*), 0 FROM jvd_rc
UNION ALL
SELECT 'jvd_o1', COUNT(*), 0 FROM jvd_o1
UNION ALL
SELECT 'jvd_o2', COUNT(*), 0 FROM jvd_o2
UNION ALL
SELECT 'jvd_o3', COUNT(*), 0 FROM jvd_o3
UNION ALL
SELECT 'jvd_o4', COUNT(*), 0 FROM jvd_o4
UNION ALL
SELECT 'jvd_o5', COUNT(*), 0 FROM jvd_o5
UNION ALL
SELECT 'jvd_o6', COUNT(*), 0 FROM jvd_o6
UNION ALL
SELECT 'jvd_ch', COUNT(*), 0 FROM jvd_ch
UNION ALL
SELECT 'jvd_jc', COUNT(*), 0 FROM jvd_jc
UNION ALL
SELECT 'jvd_hn', COUNT(*), 0 FROM jvd_hn
UNION ALL
SELECT 'jvd_we', COUNT(*), 0 FROM jvd_we
UNION ALL
SELECT 'jvd_cc', COUNT(*), 0 FROM jvd_cc
UNION ALL
SELECT 'jvd_hc', COUNT(*), 0 FROM jvd_hc
UNION ALL
SELECT 'jvd_hs', COUNT(*), 0 FROM jvd_hs
UNION ALL
SELECT 'jvd_jg', COUNT(*), 0 FROM jvd_jg
UNION ALL
SELECT 'jvd_av', COUNT(*), 0 FROM jvd_av
UNION ALL
SELECT 'jvd_tc', COUNT(*), 0 FROM jvd_tc
UNION ALL
SELECT 'jvd_ys', COUNT(*), 0 FROM jvd_ys
UNION ALL
SELECT 'jvd_bn', COUNT(*), 0 FROM jvd_bn
UNION ALL
SELECT 'jvd_br', COUNT(*), 0 FROM jvd_br
UNION ALL
SELECT 'jvd_cs', COUNT(*), 0 FROM jvd_cs
UNION ALL
SELECT 'jvd_bt', COUNT(*), 0 FROM jvd_bt
UNION ALL
SELECT 'jvd_hy', COUNT(*), 0 FROM jvd_hy
UNION ALL
SELECT 'jvd_tm', COUNT(*), 0 FROM jvd_tm;

-- ============================================================
-- JRDB 5テーブル - レコード数確認（全件）
-- ============================================================
SELECT 'jrd_kyi' AS table_name, COUNT(*) AS total_records, 0 AS records_2016_2025 FROM jrd_kyi
UNION ALL
SELECT 'jrd_sed', COUNT(*), 0 FROM jrd_sed
UNION ALL
SELECT 'jrd_bac', COUNT(*), 0 FROM jrd_bac
UNION ALL
SELECT 'jrd_cyb', COUNT(*), 0 FROM jrd_cyb
UNION ALL
SELECT 'jrd_joa', COUNT(*), 0 FROM jrd_joa;

-- ============================================================
-- 実行結果をCSVエクスポート: all_43_tables_record_count.csv
-- ============================================================
