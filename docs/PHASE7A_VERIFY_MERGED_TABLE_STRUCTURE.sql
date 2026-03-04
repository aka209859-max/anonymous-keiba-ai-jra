-- ====================================================================================================
-- Phase 7-A: マージテーブル/ビューの構造確認SQL
-- ====================================================================================================
-- 目的: CSV (81カラム) と データベース (139カラム?) の差分を特定
-- 作成日: 2026-03-03
-- ====================================================================================================

-- ===========================
-- STEP 1: マージ関連のテーブル/ビューを検索
-- ===========================
SELECT 
    schemaname,
    tablename as name,
    'TABLE' as type
FROM pg_tables
WHERE schemaname = 'public'
  AND (tablename LIKE '%merged%' 
    OR tablename LIKE '%jravan_jrdb%'
    OR tablename LIKE '%features%')

UNION ALL

SELECT 
    schemaname,
    viewname as name,
    'VIEW' as type
FROM pg_views
WHERE schemaname = 'public'
  AND (viewname LIKE '%merged%' 
    OR viewname LIKE '%jravan_jrdb%'
    OR viewname LIKE '%features%')

UNION ALL

SELECT 
    schemaname,
    matviewname as name,
    'MATERIALIZED VIEW' as type
FROM pg_matviews
WHERE schemaname = 'public'
  AND (matviewname LIKE '%merged%' 
    OR matviewname LIKE '%jravan_jrdb%'
    OR matviewname LIKE '%features%')
ORDER BY name;

-- ===========================
-- STEP 2: 該当テーブルのカラム数確認
-- ===========================
-- 注意: STEP 1で見つかったテーブル名をここに入力して実行
-- 例: jravan_jrdb_merged_fixed

SELECT 
    table_name,
    COUNT(*) as column_count,
    string_agg(column_name, ', ' ORDER BY ordinal_position) as first_10_columns
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
    'jravan_jrdb_merged_fixed',
    -- ↑ STEP 1で見つかった他のテーブル名を追加
    'features_2016_2025',
    'merged_features'
  )
GROUP BY table_name;

-- ===========================
-- STEP 3: 特定テーブルの全カラムリスト取得
-- ===========================
-- 注意: STEP 2で139カラムのテーブルが見つかった場合、そのテーブル名で実行

SELECT 
    ordinal_position,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'jravan_jrdb_merged_fixed'  -- ← 該当テーブル名に変更
ORDER BY ordinal_position;

-- ===========================
-- STEP 4: ビュー定義の確認
-- ===========================
-- 注意: STEP 1でVIEWが見つかった場合のみ実行

SELECT 
    viewname,
    definition
FROM pg_views
WHERE schemaname = 'public'
  AND (viewname LIKE '%merged%' 
    OR viewname LIKE '%jravan_jrdb%'
    OR viewname LIKE '%features%');

-- ===========================
-- STEP 5: CSV生成履歴の確認 (可能性あり)
-- ===========================
-- 注意: ログテーブルが存在する場合のみ

SELECT * FROM pg_stat_statements
WHERE query LIKE '%COPY%'
  AND query LIKE '%jravan%'
ORDER BY calls DESC
LIMIT 10;

-- ===========================
-- 実行方法
-- ===========================
-- 1. STEP 1を実行 → マージテーブル/ビューの名前を確認
-- 2. STEP 2を実行 → カラム数を確認 (81 or 139?)
-- 3. STEP 3を実行 → 全カラムリストをCSV出力
-- 4. STEP 4を実行 (VIEWの場合) → 定義を確認
-- 5. 結果をCSV/スクリーンショットで報告
-- ===========================

