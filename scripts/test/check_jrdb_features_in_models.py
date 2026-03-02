#!/usr/bin/env python3
"""
モデルが実際に使用しているJRDB特徴量を確認
"""
import lightgbm as lgb
from pathlib import Path
import re

print("=" * 80)
print("🔍 モデルが使用しているJRDB特徴量の検証")
print("=" * 80)

# モデルファイルを探す
model_dir = Path("models")
model_files = list(model_dir.glob("*.txt")) + list(model_dir.glob("*.model"))

if not model_files:
    print("\n❌ モデルファイルが見つかりません")
    exit(1)

print(f"\n📁 検出されたモデルファイル: {len(model_files)}個")
for f in model_files:
    print(f"   - {f.name}")

# 各モデルの特徴量を確認
jrdb_tables = ['jrd_kyi', 'jrd_sed', 'jrd_joa', 'jrd_cyb', 'jrd_bac']
jrdb_feature_patterns = [
    'idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 'ninki_shisu',
    'chokyo_shisu', 'kyusha_shisu', 'gekiso_shisu', 'ten_shisu', 
    'pace_shisu', 'agari_shisu', 'ichi_shisu', 'rotation',
    'kyakushitsu', 'kyori_tekisei', 'joshodo', 'tekisei_code',
    'kijun_odds', 'tokutei_joho', 'sogo_joho', 'bataiju',
    'kako.*_key', 'kishu_kitai', 'ls_shisu', 'manken', 'taikei'
]

for model_file in model_files[:3]:  # 最初の3つのモデルを確認
    try:
        print("\n" + "=" * 80)
        print(f"📊 モデル: {model_file.name}")
        print("-" * 80)
        
        booster = lgb.Booster(model_file=str(model_file))
        features = booster.feature_name()
        
        print(f"\n総特徴量数: {len(features)}")
        
        # JRDB由来の特徴量を検出
        jrdb_features = []
        for feat in features:
            feat_lower = feat.lower()
            for pattern in jrdb_feature_patterns:
                if re.search(pattern, feat_lower):
                    jrdb_features.append(feat)
                    break
        
        if jrdb_features:
            print(f"\n✅ JRDB関連特徴量: {len(jrdb_features)}個")
            print("\n📋 JRDB特徴量の例（最初の20個）:")
            for i, feat in enumerate(jrdb_features[:20], 1):
                print(f"   {i:2d}. {feat}")
            
            if len(jrdb_features) > 20:
                print(f"   ... 他 {len(jrdb_features) - 20}個")
        else:
            print("\n⚠️ JRDB関連特徴量が見つかりません")
            print("\n📋 全特徴量の例（最初の20個）:")
            for i, feat in enumerate(features[:20], 1):
                print(f"   {i:2d}. {feat}")
        
        # JRA-VAN特徴量の割合
        jrdb_ratio = len(jrdb_features) / len(features) * 100 if features else 0
        print(f"\n📊 特徴量の内訳:")
        print(f"   - JRDB関連: {len(jrdb_features)}個 ({jrdb_ratio:.1f}%)")
        print(f"   - その他/JRA-VAN: {len(features) - len(jrdb_features)}個 ({100-jrdb_ratio:.1f}%)")
        
    except Exception as e:
        print(f"   ❌ エラー: {e}")

print("\n" + "=" * 80)
print("✅ 検証完了")
print("=" * 80)
