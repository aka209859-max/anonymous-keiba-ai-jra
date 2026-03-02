#!/usr/bin/env python3
"""
JRDBデータが本当にPhase 6予測に使われているか検証
"""
import pandas as pd
import psycopg2
from pathlib import Path

# PostgreSQL接続
conn = psycopg2.connect(
    host='127.0.0.1',
    port=5432,
    database='pckeiba',
    user='postgres',
    password='postgres123'
)

print("=" * 80)
print("🔍 JRDB データ使用状況の完全検証")
print("=" * 80)

# 1. JRDBテーブルのデータ確認
print("\n【1】PostgreSQL内のJRDBデータ確認")
print("-" * 80)

jrdb_tables = ['jrd_kyi', 'jrd_sed', 'jrd_joa', 'jrd_cyb', 'jrd_bac']
for table in jrdb_tables:
    try:
        query = f"""
        SELECT COUNT(*) as total,
               COUNT(DISTINCT race_shikonen) as dates,
               MIN(race_shikonen) as min_date,
               MAX(race_shikonen) as max_date
        FROM {table}
        WHERE race_shikonen LIKE '2602%'
        """
        df = pd.read_sql(query, conn)
        print(f"\n📊 {table}:")
        print(f"   総件数: {df['total'][0]}件")
        print(f"   日付数: {df['dates'][0]}日")
        print(f"   期間: {df['min_date'][0]} ～ {df['max_date'][0]}")
    except Exception as e:
        print(f"   ⚠️ エラー: {e}")

# 2. 2月28日の具体的なJRDBデータサンプル
print("\n" + "=" * 80)
print("【2】2月28日の実際のJRDBデータサンプル（jrd_kyi）")
print("-" * 80)

query_sample = """
SELECT 
    keibajo_code,
    race_shikonen,
    race_bango,
    umaban,
    bamei,
    idm,
    kishu_shisu,
    joho_shisu,
    sogo_shisu,
    pace_shisu,
    ten_shisu
FROM jrd_kyi
WHERE race_shikonen = '260228'
ORDER BY keibajo_code, race_bango, umaban
LIMIT 10
"""

df_sample = pd.read_sql(query_sample, conn)
print("\n📋 JRDBデータサンプル（最初の10件）:")
print(df_sample.to_string(index=False))

# 3. Phase 6予測結果の確認
print("\n" + "=" * 80)
print("【3】Phase 6予測CSVの確認")
print("-" * 80)

pred_file = Path("results/predictions_20260228.csv")
if pred_file.exists():
    df_pred = pd.read_csv(pred_file)
    print(f"\n✅ 予測ファイル存在: {pred_file}")
    print(f"   総件数: {len(df_pred)}件")
    print(f"   カラム数: {len(df_pred.columns)}個")
    print(f"\n📊 カラム一覧:")
    print(df_pred.columns.tolist())
    
    # サンプルデータ表示
    print(f"\n📋 予測データサンプル（最初の3件）:")
    sample_cols = ['race_id', 'keibajo_code', 'race_bango', 'umaban', 'bamei', 
                   'binary_proba', 'ranking_score', 'ensemble_score', 'predicted_rank']
    available_cols = [col for col in sample_cols if col in df_pred.columns]
    print(df_pred[available_cols].head(3).to_string(index=False))
else:
    print(f"❌ 予測ファイルが見つかりません: {pred_file}")

# 4. Phase 6スクリプトでのJRDB特徴量使用確認
print("\n" + "=" * 80)
print("【4】Phase 6スクリプトのJRDB特徴量参照確認")
print("-" * 80)

phase6_script = Path("scripts/phase6/phase6_daily_prediction.py")
if phase6_script.exists():
    with open(phase6_script, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # JRDBテーブル参照の検索
    jrdb_refs = []
    for table in jrdb_tables:
        if table in content:
            jrdb_refs.append(table)
    
    if jrdb_refs:
        print(f"\n✅ Phase 6スクリプトが参照しているJRDBテーブル:")
        for ref in jrdb_refs:
            count = content.count(ref)
            print(f"   - {ref}: {count}回参照")
    else:
        print("\n⚠️ Phase 6スクリプトでJRDBテーブルの明示的な参照が見つかりません")
    
    # JRDB由来の特徴量名を検索
    jrdb_features = ['idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 
                     'pace_shisu', 'ten_shisu', 'agari_shisu']
    found_features = [f for f in jrdb_features if f in content]
    if found_features:
        print(f"\n✅ JRDB由来の特徴量が使用されています:")
        for feat in found_features:
            print(f"   - {feat}")
else:
    print(f"❌ Phase 6スクリプトが見つかりません: {phase6_script}")

# 5. 特徴量CSVの確認
print("\n" + "=" * 80)
print("【5】生成された特徴量ファイルの確認")
print("-" * 80)

feature_files = list(Path("data/features").glob("*20260228*.csv"))
if feature_files:
    for f in feature_files:
        df_feat = pd.read_csv(f, nrows=1)
        jrdb_cols = [col for col in df_feat.columns if any(
            jrdb in col.lower() for jrdb in ['idm', 'kishu_shisu', 'joho', 'sogo', 'pace', 'ten', 'agari']
        )]
        print(f"\n📁 {f.name}")
        print(f"   総カラム数: {len(df_feat.columns)}")
        if jrdb_cols:
            print(f"   ✅ JRDB関連カラム: {len(jrdb_cols)}個")
            print(f"      例: {jrdb_cols[:5]}")
        else:
            print(f"   ⚠️ JRDB関連カラムが見つかりません")
else:
    print("⚠️ 2月28日の特徴量ファイルが見つかりません")

conn.close()

print("\n" + "=" * 80)
print("✅ 検証完了")
print("=" * 80)
