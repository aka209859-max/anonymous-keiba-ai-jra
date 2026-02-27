#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - Phase 4-A: ランキングモデル構築（評価用）
=============================================================

目的:
    LightGBM LambdaRankを使用したランキングモデルを構築
    **評価用モデル**: 2016-2024年のデータのみで学習
    2025年を予測してキャリブレーション学習に使用

参考:
    JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md の Phase 4-A

成功基準:
    - NDCG@3 > 0.50
    - モデル保存: models/jra_ranking_model_eval.txt

作成日: 2026-02-27
"""

import pandas as pd
import lightgbm as lgb
from sklearn.metrics import ndcg_score
import numpy as np
import os
from pathlib import Path

def prepare_ranking_data_eval():
    """ランキング学習用データ準備（評価用：2016-2024のみ）"""
    print("=" * 80)
    print("📂 Phase 4-A: ランキング評価用モデル構築開始")
    print("=" * 80)
    print("🎯 学習期間: 2016-2024年")
    print("🎯 評価目的: 2025年予測でキャリブレーション学習\n")
    
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    print(f"✅ データ読み込み: {len(df):,}行 × {len(df.columns)}列")
    
    # race_idを生成: YYYYMMDDJJRR (年月日 + 競馬場コード + レース番号)
    if 'race_id' not in df.columns:
        print("\n🔧 race_id を生成中...")
        df['race_id'] = (
            df['kaisai_nen'].astype(str) +
            df['kaisai_tsukihi'].astype(str).str.zfill(4) +
            df['keibajo_code'].astype(str).str.zfill(2) +
            df['race_bango'].astype(str).str.zfill(2)
        )
        print(f"✅ race_id 生成完了: {df['race_id'].nunique():,}レース")
    
    # 目的変数: 着順（1位=1, 2位=2, ...）
    df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')
    
    # 着順の欠損値処理
    missing_count = df['target'].isnull().sum()
    if missing_count > 0:
        print(f"⚠️  着順欠損: {missing_count}行 → 除外")
        df = df.dropna(subset=['target'])
    
    print(f"✅ 目的変数作成: 着順範囲 {df['target'].min():.0f} ~ {df['target'].max():.0f}")
    
    # 欠損値処理
    print("\n🔧 欠損値処理中...")
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    # カテゴリ列をcategory型に変換（LightGBM高速化）
    for col in categorical_cols:
        if col != 'race_id':
            df[col] = df[col].astype('category')
    
    print(f"✅ 欠損値処理完了")
    
    # 時系列分割（評価用：2016-2023訓練、2024検証、2025除外）
    print("\n🔧 時系列分割中（評価用設定）...")
    train_df = df[df['kaisai_nen'] <= 2023].copy()
    valid_df = df[df['kaisai_nen'] == 2024].copy()
    # 2025年データは学習に使用しない（後でgenerate_eval_predictions.pyで予測）
    
    print(f"✅ データ分割（評価用）:")
    print(f"  訓練: {len(train_df):,}行（2016-2023）, {train_df['race_id'].nunique():,}レース")
    print(f"  検証: {len(valid_df):,}行（2024）, {valid_df['race_id'].nunique():,}レース")
    print(f"  ⚠️  2025年データは学習に使用しません（キャリブレーション評価用）")
    
    # 特徴量とターゲット分離
    feature_cols = [c for c in df.columns if c not in ['target', 'kakutei_chakujun', 'kaisai_nen', 'race_id', 'target_top3']]
    
    print(f"\n✅ 使用特徴量: {len(feature_cols)}列")
    
    return train_df, valid_df, feature_cols

def train_ranking_model_eval(train_df, valid_df, feature_cols):
    """ランキングモデル学習（評価用）"""
    print("\n" + "=" * 80)
    print("🚀 Phase 4-A: ランキング評価用モデル学習")
    print("=" * 80)
    
    # グループ情報（race_idごとの馬数）
    print("\n🔧 グループ情報作成中...")
    train_groups = train_df.groupby('race_id').size().values
    valid_groups = valid_df.groupby('race_id').size().values
    
    print(f"✅ グループ情報:")
    print(f"  訓練グループ数: {len(train_groups):,}レース")
    print(f"  検証グループ数: {len(valid_groups):,}レース")
    
    # データセット作成
    X_train = train_df[feature_cols]
    y_train = train_df['target']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target']
    
    # LightGBM LambdaRank パラメータ
    params = {
        'objective': 'lambdarank',
        'metric': 'ndcg',
        'ndcg_eval_at': [1, 3, 5, 10],
        'boosting_type': 'gbdt',
        'num_leaves': 50,
        'learning_rate': 0.05,
        'verbosity': -1,
        'random_state': 42
    }
    
    print("\n📊 訓練パラメータ:")
    for key, val in params.items():
        print(f"  - {key}: {val}")
    
    # LightGBM データセット作成
    print("\n🔧 LightGBM データセット作成中...")
    train_data = lgb.Dataset(X_train, y_train, group=train_groups)
    valid_data = lgb.Dataset(X_valid, y_valid, group=valid_groups, reference=train_data)
    
    # モデル訓練
    print("\n🚀 モデル訓練開始...")
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[valid_data],
        callbacks=[lgb.early_stopping(stopping_rounds=50), lgb.log_evaluation(100)]
    )
    
    print(f"✅ 訓練完了 (Best iteration: {model.best_iteration})")
    
    # 検証データで評価
    print("\n" + "=" * 80)
    print("📊 検証データ（2024年）での性能評価")
    print("=" * 80)
    
    # 予測
    y_pred_valid = model.predict(X_valid)
    
    # レースごとにNDCGを計算
    ndcg_scores = []
    for race_id in valid_df['race_id'].unique():
        race_mask = valid_df['race_id'] == race_id
        y_true_race = y_valid[race_mask].values
        y_pred_race = y_pred_valid[race_mask]
        
        # 着順を逆順スコア化（1位=最高点）
        max_rank = y_true_race.max()
        y_true_relevance = max_rank - y_true_race + 1
        
        # NDCG@3計算（レース内で3頭以上いる場合のみ）
        if len(y_true_race) >= 3:
            try:
                ndcg = ndcg_score([y_true_relevance], [y_pred_race], k=3)
                ndcg_scores.append(ndcg)
            except:
                pass
    
    mean_ndcg = np.mean(ndcg_scores) if ndcg_scores else 0.0
    print(f"\n✅ 検証データ（2024年）NDCG@3: {mean_ndcg:.4f}")
    
    if mean_ndcg > 0.50:
        print(f"✅ 成功基準クリア（NDCG@3 > 0.50）")
    else:
        print(f"⚠️  成功基準未達（目標: 0.50）")
    
    return model, mean_ndcg

def save_eval_model(model, ndcg_score):
    """評価用モデルの保存"""
    print("\n" + "=" * 80)
    print("💾 評価用モデル保存")
    print("=" * 80)
    
    # modelsディレクトリ作成
    os.makedirs('models', exist_ok=True)
    
    # モデル保存
    model_path = 'models/jra_ranking_model_eval.txt'
    model.save_model(model_path)
    
    # ファイルサイズ取得
    file_size = os.path.getsize(model_path) / (1024 * 1024)  # MB
    
    print(f"✅ 評価用モデル保存完了")
    print(f"  - ファイル: {model_path}")
    print(f"  - サイズ: {file_size:.2f} MB")
    print(f"  - 学習期間: 2016-2024年")
    print(f"  - 検証NDCG@3: {ndcg_score:.4f}")
    print(f"  - 用途: 2025年予測 → キャリブレーション学習")
    
    # レポート作成
    report_path = 'results/ranking_model_eval_training_report.txt'
    os.makedirs('results', exist_ok=True)
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("ランキング評価用モデル学習レポート\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"学習日時: {pd.Timestamp.now()}\n")
        f.write(f"学習期間: 2016-2024年\n")
        f.write(f"用途: キャリブレーション学習用（2025年予測）\n\n")
        f.write(f"モデルファイル: {model_path}\n")
        f.write(f"ファイルサイズ: {file_size:.2f} MB\n")
        f.write(f"木の数: {model.num_trees()}\n\n")
        f.write(f"検証データ（2024年）性能:\n")
        f.write(f"  NDCG@3: {ndcg_score:.4f}\n")
        f.write(f"  成功基準: {'✅ クリア' if ndcg_score > 0.50 else '⚠️ 未達'}\n\n")
        f.write("=" * 80 + "\n")
        f.write("次のステップ:\n")
        f.write("=" * 80 + "\n")
        f.write("1. generate_eval_predictions.py を実行\n")
        f.write("2. 2025年データで予測 → predictions_2025_eval_model.csv\n")
        f.write("3. ranking_pred_eval カラムが追加されることを確認\n")
        f.write("4. Phase 3: メタモデル学習へ進む\n")
    
    print(f"\n✅ レポート保存: {report_path}")

def main():
    """メイン実行関数"""
    try:
        # データ準備
        train_df, valid_df, feature_cols = prepare_ranking_data_eval()
        
        # モデル学習
        model, ndcg_score = train_ranking_model_eval(train_df, valid_df, feature_cols)
        
        # モデル保存
        save_eval_model(model, ndcg_score)
        
        print("\n" + "=" * 80)
        print("✅ 全処理完了！")
        print("=" * 80)
        print("\n次のステップ:")
        print("  1. python scripts/evaluation/generate_eval_predictions.py")
        print("  2. predictions_2025_eval_model.csv に ranking_pred_eval が追加される")
        print("  3. Phase 3: メタモデル学習へ進む")
        print("=" * 80)
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        return 1
    
    return 0

if __name__ == "__main__":
    exit(main())
