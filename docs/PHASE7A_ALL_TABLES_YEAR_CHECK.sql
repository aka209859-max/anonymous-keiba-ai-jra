-- ==========================================
-- Phase 7-A: 全テーブルの年次範囲確認
-- 目的: 2016～2025年にデータが入っているテーブルを特定
-- ==========================================

-- 1. JRA-VANテーブル（kaisai_nen カラムを持つテーブル）
-- jvd_se
SELECT 'jvd_se' as table_name, 
       MIN(kaisai_nen) as min_year, 
       MAX(kaisai_nen) as max_year, 
       COUNT(*) as total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jvd_se;

-- jvd_ra
SELECT 'jvd_ra' as table_name, 
       MIN(kaisai_nen) as min_year, 
       MAX(kaisai_nen) as max_year, 
       COUNT(*) as total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jvd_ra;

-- jvd_ck
SELECT 'jvd_ck' as table_name, 
       MIN(kaisai_nen) as min_year, 
       MAX(kaisai_nen) as max_year, 
       COUNT(*) as total_records,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jvd_ck;

-- jvd_um (馬マスタ - 年次カラムがない場合は全件)
SELECT 'jvd_um' as table_name, 
       'N/A' as min_year, 
       'N/A' as max_year, 
       COUNT(*) as total_records,
       COUNT(*) as records_2016_2025
FROM jvd_um;

-- 2. JRDBテーブル（race_shikonen カラムを持つテーブル）
-- jrd_kyi
SELECT 'jrd_kyi' as table_name,
       MIN(LEFT(race_shikonen::text, 4)) as min_year,
       MAX(LEFT(race_shikonen::text, 4)) as max_year,
       COUNT(*) as total_records,
       COUNT(CASE WHEN LEFT(race_shikonen::text, 4) BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jrd_kyi;

-- jrd_sed
SELECT 'jrd_sed' as table_name,
       MIN(LEFT(race_shikonen::text, 4)) as min_year,
       MAX(LEFT(race_shikonen::text, 4)) as max_year,
       COUNT(*) as total_records,
       COUNT(CASE WHEN LEFT(race_shikonen::text, 4) BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jrd_sed;

-- jrd_bac
SELECT 'jrd_bac' as table_name,
       MIN(LEFT(kaisai_nen::text, 4)) as min_year,
       MAX(LEFT(kaisai_nen::text, 4)) as max_year,
       COUNT(*) as total_records,
       COUNT(CASE WHEN LEFT(kaisai_nen::text, 4) BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jrd_bac;

-- jrd_cyb
SELECT 'jrd_cyb' as table_name,
       MIN(LEFT(kaisai_nen::text, 4)) as min_year,
       MAX(LEFT(kaisai_nen::text, 4)) as max_year,
       COUNT(*) as total_records,
       COUNT(CASE WHEN LEFT(kaisai_nen::text, 4) BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jrd_cyb;

-- jrd_joa
SELECT 'jrd_joa' as table_name,
       MIN(LEFT(kaisai_nen::text, 4)) as min_year,
       MAX(LEFT(kaisai_nen::text, 4)) as max_year,
       COUNT(*) as total_records,
       COUNT(CASE WHEN LEFT(kaisai_nen::text, 4) BETWEEN '2016' AND '2025' THEN 1 END) as records_2016_2025
FROM jrd_joa;

-- ==========================================
-- 3. 各テーブルの全カラム充填率チェック（2016～2025年のみ）
-- ==========================================

-- jvd_se の全70カラムの充填率（サンプル：最初の10カラム）
SELECT 
    COUNT(*) as total_records,
    COUNT(kaisai_nen) as kaisai_nen_filled,
    COUNT(kaisai_tsukihi) as kaisai_tsukihi_filled,
    COUNT(keibajo_code) as keibajo_code_filled,
    COUNT(race_bango) as race_bango_filled,
    COUNT(umaban) as umaban_filled,
    COUNT(ketto_toroku_bango) as ketto_toroku_bango_filled,
    COUNT(wakuban) as wakuban_filled,
    COUNT(seibetsu_code) as seibetsu_code_filled,
    COUNT(barei) as barei_filled,
    COUNT(kishu_code) as kishu_code_filled
FROM jvd_se
WHERE kaisai_nen BETWEEN '2016' AND '2025';

