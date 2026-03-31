-- ============================================================
-- Phase 7-A: JRDB 5テーブル 詳細確認 SQL
-- 作成日: 2026-03-03
-- 目的: JRDB全テーブルの年次範囲・レコード数・カラムリストを確認
-- ============================================================

-- ============================================================
-- 1. jrd_kyi (132カラム) - 年次範囲確認
-- ============================================================

-- 1-1. 総レコード数と年次範囲
SELECT 
    'jrd_kyi' AS table_name,
    COUNT(*) AS total_records,
    MIN(LEFT(race_shikonen::text, 4)) AS min_year,
    MAX(LEFT(race_shikonen::text, 4)) AS max_year
FROM jrd_kyi;

-- 1-2. 2016～2025年のレコード数
SELECT 
    'jrd_kyi' AS table_name,
    COUNT(*) AS records_2016_2025
FROM jrd_kyi
WHERE LEFT(race_shikonen::text, 4) BETWEEN '2016' AND '2025';

-- ============================================================
-- 2. jrd_sed (80カラム) - 年次範囲確認
-- ============================================================

-- 2-1. 総レコード数と年次範囲（race_shikonenの実際の形式を確認）
SELECT 
    'jrd_sed' AS table_name,
    COUNT(*) AS total_records,
    MIN(race_shikonen) AS min_race_shikonen,
    MAX(race_shikonen) AS max_race_shikonen
FROM jrd_sed;

-- 2-2. race_shikonenの形式を調査（最初の20件）
SELECT 
    race_shikonen,
    COUNT(*) AS record_count
FROM jrd_sed
GROUP BY race_shikonen
ORDER BY race_shikonen DESC
LIMIT 20;

-- ============================================================
-- 3. jrd_bac (27カラム) - 年次範囲確認
-- ============================================================

-- 3-1. 総レコード数と年次範囲
SELECT 
    'jrd_bac' AS table_name,
    COUNT(*) AS total_records
FROM jrd_bac;

-- 3-2. テーブル内に年次カラムがあるか確認
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'jrd_bac' 
AND (column_name LIKE '%nen%' OR column_name LIKE '%year%' OR column_name LIKE '%shikonen%')
ORDER BY ordinal_position;

-- ============================================================
-- 4. jrd_cyb (27カラム) - 年次範囲確認
-- ============================================================

-- 4-1. 総レコード数と年次範囲
SELECT 
    'jrd_cyb' AS table_name,
    COUNT(*) AS total_records
FROM jrd_cyb;

-- 4-2. テーブル内に年次カラムがあるか確認
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'jrd_cyb' 
AND (column_name LIKE '%nen%' OR column_name LIKE '%year%' OR column_name LIKE '%shikonen%')
ORDER BY ordinal_position;

-- ============================================================
-- 5. jrd_joa (24カラム) - 年次範囲確認
-- ============================================================

-- 5-1. 総レコード数と年次範囲
SELECT 
    'jrd_joa' AS table_name,
    COUNT(*) AS total_records
FROM jrd_joa;

-- 5-2. テーブル内に年次カラムがあるか確認
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'jrd_joa' 
AND (column_name LIKE '%nen%' OR column_name LIKE '%year%' OR column_name LIKE '%shikonen%')
ORDER BY ordinal_position;

-- ============================================================
-- 6. 全JRDBテーブルのカラムリスト取得
-- ============================================================

-- 6-1. jrd_kyi の全カラム
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jrd_kyi'
ORDER BY ordinal_position;

-- 6-2. jrd_sed の全カラム
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jrd_sed'
ORDER BY ordinal_position;

-- 6-3. jrd_bac の全カラム
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jrd_bac'
ORDER BY ordinal_position;

-- 6-4. jrd_cyb の全カラム
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jrd_cyb'
ORDER BY ordinal_position;

-- 6-5. jrd_joa の全カラム
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jrd_joa'
ORDER BY ordinal_position;

-- ============================================================
-- 実行手順:
-- 1. 上記SQLを順番に実行
-- 2. 各結果をCSVまたはスクリーンショットで保存
-- 3. 年次範囲とカラム名を確認後、完全版充填率SQLを作成
-- ============================================================
