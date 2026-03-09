#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
特徴量重要度確認スクリプト
"""

import lightgbm as lgb
import pandas as pd

# モデルを読み込み
print("=" * 80)
print("特徴量重要度確認")
print("=" * 80)

models = {
    'binary': 'models/jra_binary_model.txt',
    'ranking': 'models/jra_ranking_model.txt',
    'regression': 'models/jra_regression_model_optimized.txt'
}

for model_name, model_path in models.items():
    print(f"\n{'=' * 80}")
    print(f"📊 {model_name.upper()} モデル")
    print(f"{'=' * 80}")
    
    try:
        model = lgb.Booster(model_file=model_path)
        
        # 特徴量重要度を取得
        importance = model.feature_importance(importance_type='gain')
        feature_names = model.feature_name()
        
        # DataFrameに変換してソート
        df_importance = pd.DataFrame({
            'feature': feature_names,
            'importance': importance
        }).sort_values('importance', ascending=False)
        
        # 総重要度
        total_importance = df_importance['importance'].sum()
        df_importance['percentage'] = (df_importance['importance'] / total_importance * 100)
        
        print(f"\n✅ 総特徴量数: {len(df_importance)}")
        print(f"✅ 総重要度: {total_importance:,.0f}")
        
        # 上位20特徴量
        print(f"\n🏆 上位20特徴量:")
        print(df_importance.head(20).to_string(index=False))
        
        # JRDB関連の特徴量を抽出
        jrdb_features = df_importance[
            df_importance['feature'].str.contains('idm|kishu_shisu|joho_shisu|sogo_shisu|chokyo_shisu|kyusha_shisu|jrdb|pace_shisu|agari_shisu', case=False, na=False)
        ].copy()
        
        if len(jrdb_features) > 0:
            print(f"\n📈 JRDB特徴量の重要度（上位20）:")
            print(jrdb_features.head(20).to_string(index=False))
            
            jrdb_total = jrdb_features['importance'].sum()
            jrdb_percentage = (jrdb_total / total_importance) * 100
            print(f"\n✅ JRDB特徴量の合計重要度: {jrdb_total:,.0f} ({jrdb_percentage:.2f}%)")
        else:
            print("\n⚠️ JRDB特徴量が見つかりませんでした")
            
    except Exception as e:
        print(f"❌ エラー: {e}")

print("\n" + "=" * 80)
print("✅ 分析完了")
print("=" * 80)
