-- ============================================================
-- Phase 7-A: 全テーブルの全カラム名取得 SQL
-- 作成日: 2026-03-03
-- 目的: JRA-VAN 4テーブル + JRDB 5テーブルの全カラム名を取得
-- ============================================================

-- ============================================================
-- 1. jvd_se (70カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jvd_se' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jvd_se'
ORDER BY ordinal_position;

-- ============================================================
-- 2. jvd_ra (62カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jvd_ra' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jvd_ra'
ORDER BY ordinal_position;

-- ============================================================
-- 3. jvd_ck (106カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jvd_ck' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jvd_ck'
ORDER BY ordinal_position;

-- ============================================================
-- 4. jvd_um (89カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jvd_um' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jvd_um'
ORDER BY ordinal_position;

-- ============================================================
-- 5. jrd_kyi (132カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jrd_kyi' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_kyi'
ORDER BY ordinal_position;

-- ============================================================
-- 6. jrd_sed (80カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jrd_sed' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_sed'
ORDER BY ordinal_position;

-- ============================================================
-- 7. jrd_bac (27カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jrd_bac' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_bac'
ORDER BY ordinal_position;

-- ============================================================
-- 8. jrd_cyb (27カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jrd_cyb' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_cyb'
ORDER BY ordinal_position;

-- ============================================================
-- 9. jrd_joa (24カラム) - 全カラム名取得
-- ============================================================
SELECT 
    'jrd_joa' AS table_name,
    ordinal_position AS column_number,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_joa'
ORDER BY ordinal_position;

-- ============================================================
-- 実行方法:
-- 1. 各クエリを個別に実行
-- 2. 結果を CSV エクスポート（ファイル名: テーブル名_全カラム.csv）
-- 3. 9つのCSVファイルを全て提出
-- ============================================================
