#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - Phase 4-B: 回帰モデル最適化版（Optuna）
=============================================================

目的:
    Optunaを使用したハイパーパラメータ最適化で RMSE < 5.0秒 を達成

改善点:
    - Optuna による自動ハイパーパラメータ探索（100 trials）
    - より広い探索空間
    - 目標: RMSE < 5.0秒

作成日: 2026-02-22
"""

import pandas as pd
import lightgbm as lgb
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
import numpy as np
import os
from pathlib import Path
import optuna
from optuna.integration import LightGBMPruningCallback

def prepare_regression_data():
    """回帰学習用データ準備"""
    print("📂 Phase 4-B: 回帰モデル構築開始（最適化版）...")
    
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    print(f"✅ データ読み込み: {len(df):,}行 × {len(df.columns)}列")
    
    # race_idを生成
    if 'race_id' not in df.columns:
        print("\n🔧 race_id を生成中...")
        df['race_id'] = (
            df['kaisai_nen'].astype(str) +
            df['kaisai_tsukihi'].astype(str).str.zfill(4) +
            df['keibajo_code'].astype(str).str.zfill(2) +
            df['race_bango'].astype(str).str.zfill(2)
        )
        print(f"✅ race_id 生成完了: {df['race_id'].nunique():,}レース")
    
    # 目的変数: 走破タイム（秒）
    print("\n🔧 走破タイムを秒に変換中...")
    
    def time_to_seconds(time_str):
        """走破タイムを秒に変換"""
        if pd.isna(time_str):
            return np.nan
        
        if isinstance(time_str, (int, float)):
            if time_str == 0.0:
                return np.nan
            return float(time_str) / 10.0
        
        time_str = str(time_str).strip()
        
        if time_str == '' or time_str == 'nan':
            return np.nan
        
        if ':' in time_str:
            try:
                parts = time_str.split(':')
                minutes = int(parts[0])
                seconds = float(parts[1])
                return minutes * 60 + seconds
            except:
                return np.nan
        else:
            try:
                val = float(time_str)
                if val == 0.0:
                    return np.nan
                if val > 300:
                    return val / 10.0
                return val
            except:
                return np.nan
    
    time_col = 'prev1_time'
    print(f"  使用する列: {time_col}")
    
    df['target_time_seconds'] = df[time_col].apply(time_to_seconds)
    
    # 欠損値・異常値の確認
    missing_count = df['target_time_seconds'].isnull().sum()
    print(f"\n📊 目的変数統計:")
    print(f"  欠損値: {missing_count:,}行 ({missing_count/len(df)*100:.1f}%)")
    
    if missing_count > 0:
        print(f"  → 欠損値を除外します")
        df = df.dropna(subset=['target_time_seconds'])
    
    # 異常値除外（50秒～250秒）
    valid_mask = (df['target_time_seconds'] >= 50) & (df['target_time_seconds'] <= 250)
    outlier_count = len(df) - valid_mask.sum() - missing_count
    
    if outlier_count > 0:
        print(f"  異常値: {outlier_count:,}行 → 除外")
        df = df[valid_mask]
    
    print(f"  有効データ: {len(df):,}行")
    print(f"  走破タイム範囲: {df['target_time_seconds'].min():.1f}秒 ~ {df['target_time_seconds'].max():.1f}秒")
    print(f"  走破タイム平均: {df['target_time_seconds'].mean():.1f}秒")
    print(f"  走破タイム標準偏差: {df['target_time_seconds'].std():.1f}秒")
    
    # 欠損値処理
    print("\n🔧 欠損値処理中...")
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    for col in categorical_cols:
        if col != 'race_id':
            df[col] = df[col].astype('category')
    
    print(f"✅ 欠損値処理完了")
    
    # 時系列分割
    print("\n🔧 時系列分割中...")
    train_df = df[df['kaisai_nen'] <= 2023].copy()
    valid_df = df[df['kaisai_nen'] == 2024].copy()
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    print(f"✅ データ分割:")
    print(f"  訓練: {len(train_df):,}行（2016-2023）")
    print(f"  検証: {len(valid_df):,}行（2024）")
    print(f"  テスト: {len(test_df):,}行（2025）")
    
    # 特徴量とターゲット分離
    feature_cols = [c for c in df.columns 
                    if c not in ['target_time_seconds', 'kakutei_chakujun', 'kaisai_nen', 
                                 'race_id', 'target_top3', time_col]]
    
    print(f"\n✅ 使用特徴量: {len(feature_cols)}列")
    
    return train_df, valid_df, test_df, feature_cols

def objective(trial, X_train, y_train, X_valid, y_valid):
    """Optuna の目的関数"""
    
    # ハイパーパラメータの探索空間
    params = {
        'objective': 'regression',
        'metric': 'rmse',
        'boosting_type': 'gbdt',
        'verbosity': -1,
        'random_state': 42,
        
        # Optuna で探索するパラメータ
        'num_leaves': trial.suggest_int('num_leaves', 20, 100),
        'learning_rate': trial.suggest_float('learning_rate', 0.01, 0.2, log=True),
        'feature_fraction': trial.suggest_float('feature_fraction', 0.5, 1.0),
        'bagging_fraction': trial.suggest_float('bagging_fraction', 0.5, 1.0),
        'bagging_freq': trial.suggest_int('bagging_freq', 1, 10),
        'min_child_samples': trial.suggest_int('min_child_samples', 5, 100),
        'max_depth': trial.suggest_int('max_depth', 3, 12),
        'lambda_l1': trial.suggest_float('lambda_l1', 1e-8, 10.0, log=True),
        'lambda_l2': trial.suggest_float('lambda_l2', 1e-8, 10.0, log=True),
    }
    
    # LightGBM データセット作成
    train_data = lgb.Dataset(X_train, y_train)
    valid_data = lgb.Dataset(X_valid, y_valid, reference=train_data)
    
    # モデル訓練（Pruning callback 付き）
    pruning_callback = LightGBMPruningCallback(trial, 'rmse', valid_name='valid')
    
    model = lgb.train(
        params,
        train_data,
        num_boost_round=2000,
        valid_sets=[valid_data],
        valid_names=['valid'],
        callbacks=[
            lgb.early_stopping(stopping_rounds=100),
            lgb.log_evaluation(0),
            pruning_callback
        ]
    )
    
    # 検証データで予測
    y_pred = model.predict(X_valid)
    rmse = np.sqrt(mean_squared_error(y_valid, y_pred))
    
    return rmse

def train_optimized_model(train_df, valid_df, test_df, feature_cols):
    """最適化された回帰モデル学習"""
    print("\n" + "=" * 80)
    print("🚀 Phase 4-B: 回帰モデル学習（Optuna最適化版）")
    print("=" * 80)
    
    # データセット作成
    X_train = train_df[feature_cols]
    y_train = train_df['target_time_seconds']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target_time_seconds']
    
    X_test = test_df[feature_cols]
    y_test = test_df['target_time_seconds']
    
    # Optuna によるハイパーパラメータ最適化
    print("\n🔧 Optuna でハイパーパラメータを最適化中...")
    print("  試行回数: 100 trials")
    print("  目標: RMSE の最小化")
    print("  推定時間: 約30分-1時間\n")
    
    study = optuna.create_study(
        direction='minimize',
        study_name='lightgbm_regression_optimization',
        pruner=optuna.pruners.MedianPruner(n_warmup_steps=10)
    )
    
    study.optimize(
        lambda trial: objective(trial, X_train, y_train, X_valid, y_valid),
        n_trials=100,
        show_progress_bar=True
    )
    
    print(f"\n✅ 最適化完了!")
    print(f"  最良 RMSE: {study.best_value:.4f} 秒")
    print(f"  最良パラメータ:")
    for key, value in study.best_params.items():
        print(f"    - {key}: {value}")
    
    # 最良パラメータでモデル再訓練
    print("\n🔧 最良パラメータでモデルを再訓練中...")
    
    best_params = study.best_params
    best_params.update({
        'objective': 'regression',
        'metric': 'rmse',
        'boosting_type': 'gbdt',
        'verbosity': -1,
        'random_state': 42
    })
    
    train_data = lgb.Dataset(X_train, y_train)
    valid_data = lgb.Dataset(X_valid, y_valid, reference=train_data)
    
    model = lgb.train(
        best_params,
        train_data,
        num_boost_round=2000,
        valid_sets=[train_data, valid_data],
        valid_names=['train', 'valid'],
        callbacks=[lgb.early_stopping(stopping_rounds=100), lgb.log_evaluation(100)]
    )
    
    print(f"✅ 訓練完了 (Best iteration: {model.best_iteration})")
    
    # テストデータで評価
    print("\n" + "=" * 80)
    print("📊 テストデータ評価")
    print("=" * 80)
    
    print("\n🔧 テストデータで予測を実行中...")
    y_pred = model.predict(X_test)
    
    # 評価指標計算
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    mae = mean_absolute_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    
    errors = y_pred - y_test
    
    print(f"\n📈 テストデータ評価結果:")
    print(f"  RMSE: {rmse:.4f} 秒")
    print(f"  MAE: {mae:.4f} 秒")
    print(f"  R²: {r2:.4f}")
    
    print(f"\n📊 予測誤差の分布:")
    print(f"  平均誤差: {errors.mean():.4f} 秒")
    print(f"  標準偏差: {errors.std():.4f} 秒")
    print(f"  最小誤差: {errors.min():.4f} 秒")
    print(f"  最大誤差: {errors.max():.4f} 秒")
    
    print(f"\n📊 誤差のパーセンタイル:")
    for p in [10, 25, 50, 75, 90, 95, 99]:
        val = np.percentile(np.abs(errors), p)
        print(f"  {p:2d}%: {val:.4f} 秒")
    
    # 成功基準判定
    print(f"\n📋 成功基準判定:")
    rmse_pass = "✅" if rmse < 5.0 else "❌"
    r2_pass = "✅" if r2 > 0.70 else "❌"
    
    print(f"  RMSE < 5.0秒: {rmse_pass} ({rmse:.4f})")
    print(f"  R² > 0.70: {r2_pass} ({r2:.4f})")
    
    if rmse < 5.0:
        improvement = 5.0280 - rmse
        print(f"\n🎉 成功基準達成！")
        print(f"  前回からの改善: {improvement:.4f} 秒")
    else:
        print(f"\n⚠️  成功基準未達")
        print(f"  目標まであと: {rmse - 5.0:.4f} 秒")
    
    # モデル保存
    print("\n" + "=" * 80)
    print("💾 モデル保存")
    print("=" * 80)
    
    os.makedirs('models', exist_ok=True)
    
    # 最適化版モデル
    optimized_model_path = 'models/jra_regression_model_optimized.txt'
    model.save_model(optimized_model_path)
    model_size_mb = Path(optimized_model_path).stat().st_size / (1024 ** 2)
    print(f"✅ 最適化モデル保存: {optimized_model_path}")
    print(f"  ファイルサイズ: {model_size_mb:.2f} MB")
    
    # レポート保存
    report_lines = []
    report_lines.append("=" * 80)
    report_lines.append("Phase 4-B: 回帰モデル最適化版（Optuna）評価レポート")
    report_lines.append("=" * 80)
    report_lines.append("")
    report_lines.append("生成日時: 2026-02-22")
    report_lines.append("")
    report_lines.append("【最適化情報】")
    report_lines.append(f"  - 最適化手法: Optuna（100 trials）")
    report_lines.append(f"  - 最良検証 RMSE: {study.best_value:.4f} 秒")
    report_lines.append("")
    report_lines.append("【最良パラメータ】")
    for key, value in study.best_params.items():
        report_lines.append(f"  - {key}: {value}")
    report_lines.append("")
    report_lines.append("【テストデータ評価】")
    report_lines.append(f"  - RMSE: {rmse:.4f} 秒 {rmse_pass}")
    report_lines.append(f"  - MAE: {mae:.4f} 秒")
    report_lines.append(f"  - R²: {r2:.4f} {r2_pass}")
    report_lines.append("")
    if rmse < 5.0:
        improvement = 5.0280 - rmse
        report_lines.append(f"【改善結果】")
        report_lines.append(f"  - 前回 RMSE: 5.0280秒")
        report_lines.append(f"  - 今回 RMSE: {rmse:.4f}秒")
        report_lines.append(f"  - 改善幅: {improvement:.4f}秒")
    report_lines.append("")
    report_lines.append("=" * 80)
    
    report_text = "\n".join(report_lines)
    
    os.makedirs('results', exist_ok=True)
    report_path = 'results/phase4b_regression_optimized_report.txt'
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write(report_text)
    
    print(f"✅ レポート保存完了: {report_path}")
    
    return model, rmse, r2, study

if __name__ == '__main__':
    print("\n" + "=" * 80)
    print("🏇 JRA競馬AI - Phase 4-B: 回帰モデル最適化版（Optuna）")
    print("=" * 80)
    print("\n目標: RMSE < 5.0秒 を確実に達成")
    print("前回: RMSE = 5.0280秒 → 改善目標\n")
    
    try:
        train_df, valid_df, test_df, feature_cols = prepare_regression_data()
        model, rmse, r2, study = train_optimized_model(train_df, valid_df, test_df, feature_cols)
        
        print("\n" + "=" * 80)
        print("✅ Phase 4-B 最適化版完了!")
        print("=" * 80)
        
        if rmse < 5.0:
            print(f"\n🎉🎉🎉 目標達成！RMSE = {rmse:.4f} < 5.0秒")
        else:
            print(f"\n📊 現在の RMSE = {rmse:.4f}秒（目標: < 5.0秒）")
        
        print("\n🎯 次のステップ: Phase 5（アンサンブル統合）に進む\n")
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
