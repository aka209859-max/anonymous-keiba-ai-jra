"""
Phase 7-A: 全テーブル構造確認スクリプト
目的: JRA-VAN 38テーブル + JRDB 5テーブルの全カラムを取得し、
      2016～2025年にデータがあるカラムを特定する
"""

# スクリーンショットから確認できたテーブルレコード数
table_records = {
    "jvd_se": None,  # 要確認
    "jvd_ra": None,  # 要確認
    "jvd_ck": None,  # 要確認
    "jvd_um": None,  # 要確認
    "jrd_kyi": None,  # 要確認
    "jrd_sed": 3696,  # 既に確認済み
    "jrd_bac": 110,   # 既知
    "jrd_cyb": 3081,  # 既知
    "jrd_joa": 4828   # スクリーンショットで確認
}

print("=" * 80)
print("Phase 7-A: 全テーブル構造確認")
print("=" * 80)

print("\n📊 確認済みテーブルレコード数:")
for table, records in table_records.items():
    if records:
        print(f"   {table}: {records:,} records")
    else:
        print(f"   {table}: 要確認")

print("\n" + "=" * 80)
print("次のステップ:")
print("=" * 80)
print("1. pgAdmin4で各テーブルの年次範囲を確認")
print("2. 全カラムリストを取得（CSV出力）")
print("3. 2016～2025年のデータが入っているカラムを特定")
print("4. 充填率80%以上のカラムを抽出")
print("5. 最終的に200～220カラムのデータセットを生成")

# pgAdmin4で実行すべきSQLクエリを生成
sql_queries = """
-- ==========================================
-- Phase 7-A: 全テーブル詳細調査SQL
-- ==========================================

-- 1. JRA-VANテーブルの年次範囲確認
SELECT 'jvd_se' as table_name, MIN(kaisai_nen) as min_year, MAX(kaisai_nen) as max_year, COUNT(*) as total_records FROM jvd_se;
SELECT 'jvd_ra' as table_name, MIN(kaisai_nen) as min_year, MAX(kaisai_nen) as max_year, COUNT(*) as total_records FROM jvd_ra;
SELECT 'jvd_ck' as table_name, MIN(kaisai_nen) as min_year, MAX(kaisai_nen) as max_year, COUNT(*) as total_records FROM jvd_ck;
SELECT 'jvd_um' as table_name, 'N/A' as min_year, 'N/A' as max_year, COUNT(*) as total_records FROM jvd_um;

-- 2. JRDBテーブルのレコード数確認
SELECT 'jrd_kyi' as table_name, COUNT(*) as total_records FROM jrd_kyi;
SELECT 'jrd_sed' as table_name, COUNT(*) as total_records FROM jrd_sed;
SELECT 'jrd_bac' as table_name, COUNT(*) as total_records FROM jrd_bac;
SELECT 'jrd_cyb' as table_name, COUNT(*) as total_records FROM jrd_cyb;
SELECT 'jrd_joa' as table_name, COUNT(*) as total_records FROM jrd_joa;

-- 3. 全カラムリスト取得（9テーブル）
SELECT 'jvd_se' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jvd_se' ORDER BY ordinal_position;
SELECT 'jvd_ra' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jvd_ra' ORDER BY ordinal_position;
SELECT 'jvd_ck' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jvd_ck' ORDER BY ordinal_position;
SELECT 'jvd_um' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jvd_um' ORDER BY ordinal_position;
SELECT 'jrd_kyi' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jrd_kyi' ORDER BY ordinal_position;
SELECT 'jrd_sed' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jrd_sed' ORDER BY ordinal_position;
SELECT 'jrd_bac' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jrd_bac' ORDER BY ordinal_position;
SELECT 'jrd_cyb' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jrd_cyb' ORDER BY ordinal_position;
SELECT 'jrd_joa' as table_name, column_name, data_type FROM information_schema.columns WHERE table_name = 'jrd_joa' ORDER BY ordinal_position;
"""

print("\n📝 実行すべきSQLクエリ:")
print(sql_queries)

