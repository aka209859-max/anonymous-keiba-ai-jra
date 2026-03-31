-- ============================================================
-- Phase 7-A: JRA-VAN 全38テーブル完全確認SQL
-- 作成日: 2026-03-03
-- 目的: JRA-VAN全テーブルのテーブル名・カラム数・レコード数を取得
-- ============================================================

-- ============================================================
-- 1. JRA-VAN 全テーブル一覧（テーブル名のみ）
-- ============================================================
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name LIKE 'jvd_%'
ORDER BY table_name;

-- ============================================================
-- 2. JRA-VAN 全テーブルのカラム数集計
-- ============================================================
SELECT 
    table_name,
    COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name LIKE 'jvd_%'
GROUP BY table_name
ORDER BY table_name;

-- ============================================================
-- 3. JRDB 全テーブル一覧（テーブル名のみ）
-- ============================================================
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name LIKE 'jrd_%'
ORDER BY table_name;

-- ============================================================
-- 4. JRDB 全テーブルのカラム数集計
-- ============================================================
SELECT 
    table_name,
    COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name LIKE 'jrd_%'
GROUP BY table_name
ORDER BY table_name;

-- ============================================================
-- 5. 全テーブル（JRA-VAN + JRDB）のカラム数合計
-- ============================================================
SELECT 
    'JRA-VAN' AS data_source,
    COUNT(DISTINCT table_name) AS table_count,
    SUM(column_count) AS total_columns
FROM (
    SELECT 
        table_name,
        COUNT(*) AS column_count
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name LIKE 'jvd_%'
    GROUP BY table_name
) jravan_tables

UNION ALL

SELECT 
    'JRDB' AS data_source,
    COUNT(DISTINCT table_name) AS table_count,
    SUM(column_count) AS total_columns
FROM (
    SELECT 
        table_name,
        COUNT(*) AS column_count
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name LIKE 'jrd_%'
    GROUP BY table_name
) jrdb_tables

UNION ALL

SELECT 
    'TOTAL' AS data_source,
    COUNT(DISTINCT table_name) AS table_count,
    SUM(column_count) AS total_columns
FROM (
    SELECT 
        table_name,
        COUNT(*) AS column_count
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND (table_name LIKE 'jvd_%' OR table_name LIKE 'jrd_%')
    GROUP BY table_name
) all_tables;

-- ============================================================
-- 実行手順:
-- 1. 上記5つのSQLを順番に実行
-- 2. 結果をCSVエクスポート
-- 3. JRA-VANが38テーブル・1,649カラムかを確認
-- 4. JRDBが5テーブル・290カラムかを確認
-- ============================================================
