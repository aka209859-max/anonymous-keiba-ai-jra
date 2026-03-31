-- ============================================================
-- Phase 7-A: JRA-VAN 主要10テーブル 年次・レコード数確認SQL
-- 作成日: 2026-03-03
-- 対象: 確認済み4テーブル + 優先度S/Aの6テーブル = 10テーブル
-- ============================================================

-- ============================================================
-- 【確認済みテーブル】- 念のため再確認
-- ============================================================

-- 1. jvd_se (70カラム) - 出走馬情報
SELECT 'jvd_se' AS table_name, 
       COUNT(*) AS total_records,
       MIN(kaisai_nen) AS min_year,
       MAX(kaisai_nen) AS max_year,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_se;

-- 2. jvd_ra (62カラム) - レース情報
SELECT 'jvd_ra' AS table_name,
       COUNT(*) AS total_records,
       MIN(kaisai_nen) AS min_year,
       MAX(kaisai_nen) AS max_year,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_ra;

-- 3. jvd_ck (106カラム) - 調教情報
SELECT 'jvd_ck' AS table_name,
       COUNT(*) AS total_records,
       MIN(kaisai_nen) AS min_year,
       MAX(kaisai_nen) AS max_year,
       COUNT(CASE WHEN kaisai_nen BETWEEN '2016' AND '2025' THEN 1 END) AS records_2016_2025
FROM jvd_ck;

-- 4. jvd_um (89カラム) - 馬マスタ
SELECT 'jvd_um' AS table_name,
       COUNT(*) AS total_records,
       'N/A' AS min_year,
       'N/A' AS max_year,
       COUNT(*) AS records_2016_2025
FROM jvd_um;

-- ============================================================
-- 【優先度S】- 重要度が最も高いテーブル
-- ============================================================

-- 5. jvd_tk (336カラム) - 払戻金・配当データ
-- まず年次カラムの有無を確認
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_tk'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- 6. jvd_wf (266カラム) - Win5・馬券データ
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_wf'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- 7. jvd_hr (158カラム) - 血統・繁殖
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_hr'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- ============================================================
-- 【優先度A】- 重要度が高いテーブル
-- ============================================================

-- 8. jvd_h1 (43カラム) - 馬柱詳細
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_h1'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- 9. jvd_ks (30カラム) - 競走成績
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_ks'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- 10. jvd_dm (28カラム) - 騎手・調教師データ
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'jvd_dm'
  AND (column_name LIKE '%nen%' OR column_name LIKE '%year%')
ORDER BY ordinal_position;

-- ============================================================
-- 実行手順:
-- 1. 上記10個のSQLを順番に実行
-- 2. 年次カラムが見つかったテーブルは、レコード数をカウント
-- 3. 年次カラムがないテーブルは、総レコード数のみカウント
-- ============================================================
