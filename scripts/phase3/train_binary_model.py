#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - Phase 3: 二値分類モデル構築（改善版）
=============================================================

目的:
    3着以内予測のためのLightGBM二値分類モデルを構築
    評価用モデルと実運用モデルの2つを作成

機能:
    1. データ読み込み (all_tracks_2016-2025_features.csv)
    2. 前処理 (欠損値処理、型変換、エンコーディング)
    3. 【評価用モデル】時系列分割 (2016-2024訓練, 2025テスト)
    4. LightGBMベースラインモデル訓練
    5. Optunaハイパーパラメータ最適化 (100 trials)
    6. 評価用モデル訓練・評価・保存
    7. 【実運用モデル】全データ (2016-2025) で再訓練
    8. 実運用モデル保存

生成ファイル:
    - models/jra_binary_model_eval.txt (評価用: 2016-2024訓練)
    - models/jra_binary_model.txt (実運用: 2016-2025全データ)
    - results/phase3_binary_model_report.txt (評価レポート)

成功基準:
    - 評価用モデル テストAUC ≥ 0.70
    - 実運用モデル生成完了

作成日: 2026-02-22
バージョン: 2.0 (オプションB: 2モデル作成方式)
"""

import os
import sys
import logging
import warnings
import pandas as pd
import numpy as np
from datetime import datetime
from pathlib import Path

# 機械学習ライブラリ
import lightgbm as lgb
from sklearn.metrics import (
    roc_auc_score, accuracy_score, precision_score, 
    recall_score, f1_score, confusion_matrix, classification_report
)
from sklearn.model_selection import train_test_split
import optuna
from boruta import BorutaPy
from sklearn.ensemble import RandomForestClassifier

# 警告抑制
warnings.filterwarnings('ignore')

# ================================================================================
# ロガー設定
# ================================================================================

def setup_logger(log_dir='logs'):
    """ロガーの設定"""
    os.makedirs(log_dir, exist_ok=True)
    log_file = os.path.join(log_dir, f'phase3_binary_model_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log')
    
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file, encoding='utf-8'),
            logging.StreamHandler(sys.stdout)
        ]
    )
    return logging.getLogger(__name__)

logger = setup_logger()

# ================================================================================
# データ読み込み
# ================================================================================

def load_data(file_path):
    """統合データCSVを読み込む"""
    logger.info("=" * 80)
    logger.info("[Step 1] データ読み込み")
    logger.info("=" * 80)
    
    if not os.path.exists(file_path):
        logger.error(f"❌ ファイルが見つかりません: {file_path}")
        sys.exit(1)
    
    logger.info(f"📂 読み込み中: {file_path}")
    # 混合型カラムの警告を抑制し、すべてobject型として読み込む
    df = pd.read_csv(file_path, encoding='utf-8', low_memory=False, dtype=str)
    
    logger.info(f"✅ データ読み込み完了")
    logger.info(f"   - 行数: {len(df):,}行")
    logger.info(f"   - 列数: {len(df.columns)}列")
    logger.info(f"   - ファイルサイズ: {os.path.getsize(file_path) / (1024**2):.1f} MB")
    
    return df

# ================================================================================
# 前処理
# ================================================================================

def preprocess_data(df):
    """データ前処理"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 2] データ前処理")
    logger.info("=" * 80)
    
    # 除外カラム (識別子、目的変数、リーク情報)
    exclude_cols = [
        'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
        'umaban', 'kakutei_chakujun', 'target_top3'  # target_top3を除外
    ]
    
    # 目的変数作成: 3着以内=1, 4着以下=0
    logger.info("\n[2.1] 目的変数作成: is_top3 (3着以内=1, 4着以下=0)")
    if 'kakutei_chakujun' not in df.columns:
        logger.error("❌ 'kakutei_chakujun'カラムが存在しません")
        sys.exit(1)
    
    df['is_top3'] = (df['kakutei_chakujun'].astype(float) <= 3).astype(int)
    top3_ratio = df['is_top3'].mean() * 100
    logger.info(f"   - 3着以内の割合: {top3_ratio:.2f}%")
    logger.info(f"   - 4着以下の割合: {100 - top3_ratio:.2f}%")
    
    # クラス不均衡の計算（後でLightGBMのscale_pos_weightに使用）
    pos_weight = (df['is_top3'] == 0).sum() / (df['is_top3'] == 1).sum()
    logger.info(f"   - クラス不均衡比率: {pos_weight:.2f} (4着以下 / 3着以内)")
    
    # 数値型カラムを先に識別（dtype=strで読み込んだため）
    logger.info("\n[2.2] データ型変換")
    numeric_candidate_cols = []
    for col in df.columns:
        if col in exclude_cols or col == 'is_top3':
            continue
        # 数値に変換可能かチェック
        try:
            pd.to_numeric(df[col], errors='raise')
            numeric_candidate_cols.append(col)
        except:
            pass
    
    # 数値型カラムを変換
    for col in numeric_candidate_cols:
        df[col] = pd.to_numeric(df[col], errors='coerce')
    
    logger.info(f"   - 数値型変換: {len(numeric_candidate_cols)}列")
    
    # 欠損値処理
    logger.info("\n[2.3] 欠損値処理")
    missing_before = df.isnull().sum().sum()
    logger.info(f"   - 処理前の欠損値数: {missing_before:,}")
    
    # 数値型カラムは平均値補完
    numeric_cols = df.select_dtypes(include=[np.number]).columns
    numeric_cols = [col for col in numeric_cols if col not in exclude_cols + ['is_top3']]
    
    for col in numeric_cols:
        if df[col].isnull().sum() > 0:
            mean_val = df[col].mean()
            df[col].fillna(mean_val, inplace=True)
    
    # カテゴリ型カラムは'unknown'で補完
    categorical_cols = df.select_dtypes(include=['object']).columns
    categorical_cols = [col for col in categorical_cols if col not in exclude_cols]
    
    for col in categorical_cols:
        if df[col].isnull().sum() > 0:
            df[col].fillna('unknown', inplace=True)
    
    missing_after = df.isnull().sum().sum()
    logger.info(f"   - 処理後の欠損値数: {missing_after:,}")
    logger.info(f"   - 除去した欠損値: {missing_before - missing_after:,}")
    
    # カテゴリ変数のラベルエンコーディング
    logger.info("\n[2.4] カテゴリ変数のエンコーディング")
    categorical_cols = df.select_dtypes(include=['object']).columns
    categorical_cols = [col for col in categorical_cols if col not in exclude_cols]
    
    from sklearn.preprocessing import LabelEncoder
    label_encoders = {}
    
    for col in categorical_cols:
        le = LabelEncoder()
        df[col] = le.fit_transform(df[col].astype(str))
        label_encoders[col] = le
        logger.info(f"   - {col}: {len(le.classes_)} カテゴリ")
    
    logger.info(f"✅ エンコーディング完了: {len(categorical_cols)}列")
    
    # 無限大・NaN値の最終チェック
    logger.info("\n[2.5] 無限大・NaN値の最終チェック")
    df.replace([np.inf, -np.inf], np.nan, inplace=True)
    final_missing = df.isnull().sum().sum()
    if final_missing > 0:
        logger.warning(f"⚠️  残存欠損値: {final_missing:,} → 0で補完")
        df.fillna(0, inplace=True)
    else:
        logger.info("✅ 欠損値・無限大値なし")
    
    return df, label_encoders, pos_weight

# ================================================================================
# 時系列分割
# ================================================================================

def split_train_test(df):
    """時系列分割: 2016-2024訓練, 2025テスト"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 3] 時系列分割")
    logger.info("=" * 80)
    
    if 'kaisai_nen' not in df.columns:
        logger.error("❌ 'kaisai_nen'カラムが存在しません")
        sys.exit(1)
    
    # 年度を数値型に変換
    df['kaisai_nen'] = df['kaisai_nen'].astype(str).str[:4].astype(int)
    
    train_df = df[df['kaisai_nen'] <= 2024].copy()
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    logger.info(f"📊 訓練データ (2016-2024): {len(train_df):,}行")
    logger.info(f"📊 テストデータ (2025): {len(test_df):,}行")
    logger.info(f"   - 訓練/テスト比率: {len(train_df) / len(df) * 100:.1f}% / {len(test_df) / len(df) * 100:.1f}%")
    
    # 年度分布確認
    logger.info("\n📅 訓練データ年度分布:")
    year_dist = train_df['kaisai_nen'].value_counts().sort_index()
    for year, count in year_dist.items():
        logger.info(f"   - {year}年: {count:,}行 ({count / len(train_df) * 100:.2f}%)")
    
    return train_df, test_df

# ================================================================================
# 特徴量・目的変数分離
# ================================================================================

def prepare_features(train_df, test_df):
    """特徴量と目的変数を分離"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 4] 特徴量・目的変数分離")
    logger.info("=" * 80)
    
    # 除外カラム（リーク情報も含む）
    exclude_cols = [
        'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
        'umaban', 'kakutei_chakujun', 'is_top3', 'target_top3'  # target_top3も除外
    ]
    
    feature_cols = [col for col in train_df.columns if col not in exclude_cols]
    
    X_train = train_df[feature_cols]
    y_train = train_df['is_top3']
    
    X_test = test_df[feature_cols]
    y_test = test_df['is_top3']
    
    logger.info(f"✅ 特徴量分離完了")
    logger.info(f"   - 訓練特徴量: {X_train.shape}")
    logger.info(f"   - テスト特徴量: {X_test.shape}")
    logger.info(f"   - 使用特徴量数: {len(feature_cols)}列")
    logger.info(f"\n📋 使用特徴量リスト (最初の20列):")
    for i, col in enumerate(feature_cols[:20], 1):
        logger.info(f"   {i:2d}. {col}")
    if len(feature_cols) > 20:
        logger.info(f"   ... 他{len(feature_cols) - 20}列")
    
    return X_train, y_train, X_test, y_test, feature_cols

# ================================================================================
# LightGBMベースラインモデル
# ================================================================================

def train_baseline_model(X_train, y_train, X_test, y_test, pos_weight):
    """LightGBMベースラインモデル訓練"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 5] LightGBMベースラインモデル訓練")
    logger.info("=" * 80)
    
    # デフォルトパラメータ（クラス不均衡対策）
    params = {
        'objective': 'binary',
        'metric': 'auc',
        'boosting_type': 'gbdt',
        'num_leaves': 31,
        'learning_rate': 0.05,
        'feature_fraction': 0.9,
        'bagging_fraction': 0.8,
        'bagging_freq': 5,
        'scale_pos_weight': pos_weight,  # クラス不均衡対策
        'verbose': -1,
        'random_state': 42
    }
    
    logger.info("📊 訓練パラメータ:")
    for key, val in params.items():
        if key == 'scale_pos_weight':
            logger.info(f"   - {key}: {val:.2f} (クラス不均衡対策)")
        else:
            logger.info(f"   - {key}: {val}")
    
    # データセット作成
    train_data = lgb.Dataset(X_train, label=y_train)
    test_data = lgb.Dataset(X_test, label=y_test, reference=train_data)
    
    # モデル訓練
    logger.info("\n🚀 モデル訓練開始...")
    start_time = datetime.now()
    
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[train_data, test_data],
        valid_names=['train', 'test'],
        callbacks=[
            lgb.early_stopping(stopping_rounds=50),
            lgb.log_evaluation(period=100)
        ]
    )
    
    elapsed = (datetime.now() - start_time).total_seconds()
    logger.info(f"✅ 訓練完了 (所要時間: {elapsed:.1f}秒)")
    logger.info(f"   - Best iteration: {model.best_iteration}")
    
    # 予測
    y_pred_train = model.predict(X_train, num_iteration=model.best_iteration)
    y_pred_test = model.predict(X_test, num_iteration=model.best_iteration)
    
    # 評価
    train_auc = roc_auc_score(y_train, y_pred_train)
    test_auc = roc_auc_score(y_test, y_pred_test)
    
    # 2値予測 (閾値0.5)
    y_pred_test_binary = (y_pred_test >= 0.5).astype(int)
    test_acc = accuracy_score(y_test, y_pred_test_binary)
    test_precision = precision_score(y_test, y_pred_test_binary)
    test_recall = recall_score(y_test, y_pred_test_binary)
    test_f1 = f1_score(y_test, y_pred_test_binary)
    
    logger.info("\n📈 ベースラインモデル評価:")
    logger.info(f"   - 訓練AUC: {train_auc:.4f}")
    logger.info(f"   - テストAUC: {test_auc:.4f}")
    logger.info(f"   - テスト精度: {test_acc:.4f}")
    logger.info(f"   - テスト適合率: {test_precision:.4f}")
    logger.info(f"   - テスト再現率: {test_recall:.4f}")
    logger.info(f"   - テストF1: {test_f1:.4f}")
    
    # 混同行列
    cm = confusion_matrix(y_test, y_pred_test_binary)
    logger.info("\n📊 混同行列:")
    logger.info(f"   - 真陰性 (TN): {cm[0][0]:,}")
    logger.info(f"   - 偽陽性 (FP): {cm[0][1]:,}")
    logger.info(f"   - 偽陰性 (FN): {cm[1][0]:,}")
    logger.info(f"   - 真陽性 (TP): {cm[1][1]:,}")
    
    return model, test_auc

# ================================================================================
# Boruta特徴選択
# ================================================================================

def boruta_feature_selection(X_train, y_train, feature_cols, max_iter=100):
    """Boruta特徴選択"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 6] Boruta特徴選択")
    logger.info("=" * 80)
    
    logger.info(f"🔍 Boruta実行中 (max_iter={max_iter})...")
    logger.info("   ⚠️  この処理には数分～数十分かかる場合があります")
    
    start_time = datetime.now()
    
    # RandomForestをベースモデルとして使用
    rf = RandomForestClassifier(
        n_jobs=-1,
        max_depth=5,
        random_state=42
    )
    
    boruta_selector = BorutaPy(
        rf,
        n_estimators='auto',
        max_iter=max_iter,
        random_state=42,
        verbose=0
    )
    
    # Boruta実行
    boruta_selector.fit(X_train.values, y_train.values)
    
    elapsed = (datetime.now() - start_time).total_seconds() / 60
    logger.info(f"✅ Boruta完了 (所要時間: {elapsed:.1f}分)")
    
    # 選択された特徴量
    selected_features = [feat for feat, support in zip(feature_cols, boruta_selector.support_) if support]
    rejected_features = [feat for feat, support in zip(feature_cols, boruta_selector.support_) if not support]
    
    logger.info(f"\n📊 Boruta特徴選択結果:")
    logger.info(f"   - 選択特徴量: {len(selected_features)}列 ({len(selected_features) / len(feature_cols) * 100:.1f}%)")
    logger.info(f"   - 除外特徴量: {len(rejected_features)}列 ({len(rejected_features) / len(feature_cols) * 100:.1f}%)")
    
    if len(rejected_features) > 0 and len(rejected_features) <= 20:
        logger.info("\n🗑️  除外された特徴量:")
        for feat in rejected_features:
            logger.info(f"   - {feat}")
    elif len(rejected_features) > 20:
        logger.info(f"\n🗑️  除外された特徴量 (最初の20列):")
        for feat in rejected_features[:20]:
            logger.info(f"   - {feat}")
        logger.info(f"   ... 他{len(rejected_features) - 20}列")
    
    return selected_features

# ================================================================================
# Optunaハイパーパラメータ最適化
# ================================================================================

def optimize_hyperparameters(X_train, y_train, pos_weight, n_trials=100):
    """Optunaでハイパーパラメータ最適化"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 7] Optunaハイパーパラメータ最適化")
    logger.info("=" * 80)
    
    logger.info(f"🔧 Optuna実行中 (trials={n_trials})...")
    logger.info("   ⚠️  この処理には数十分～数時間かかる場合があります")
    
    # 訓練/検証分割 (時系列を考慮せず、ランダム分割)
    X_tr, X_val, y_tr, y_val = train_test_split(
        X_train, y_train, test_size=0.2, random_state=42, stratify=y_train
    )
    
    def objective(trial):
        """Optuna目的関数"""
        params = {
            'objective': 'binary',
            'metric': 'auc',
            'boosting_type': 'gbdt',
            'num_leaves': trial.suggest_int('num_leaves', 20, 150),
            'learning_rate': trial.suggest_loguniform('learning_rate', 0.01, 0.3),
            'feature_fraction': trial.suggest_uniform('feature_fraction', 0.6, 1.0),
            'bagging_fraction': trial.suggest_uniform('bagging_fraction', 0.6, 1.0),
            'bagging_freq': trial.suggest_int('bagging_freq', 1, 10),
            'min_child_samples': trial.suggest_int('min_child_samples', 5, 100),
            'lambda_l1': trial.suggest_loguniform('lambda_l1', 1e-8, 10.0),
            'lambda_l2': trial.suggest_loguniform('lambda_l2', 1e-8, 10.0),
            'scale_pos_weight': pos_weight,  # クラス不均衡対策
            'verbose': -1,
            'random_state': 42
        }
        
        train_data = lgb.Dataset(X_tr, label=y_tr)
        val_data = lgb.Dataset(X_val, label=y_val, reference=train_data)
        
        model = lgb.train(
            params,
            train_data,
            num_boost_round=1000,
            valid_sets=[val_data],
            callbacks=[
                lgb.early_stopping(stopping_rounds=50),
                lgb.log_evaluation(period=0)
            ]
        )
        
        y_pred = model.predict(X_val, num_iteration=model.best_iteration)
        auc = roc_auc_score(y_val, y_pred)
        
        return auc
    
    start_time = datetime.now()
    
    # Optuna実行
    optuna.logging.set_verbosity(optuna.logging.WARNING)
    study = optuna.create_study(direction='maximize', sampler=optuna.samplers.TPESampler(seed=42))
    study.optimize(objective, n_trials=n_trials, show_progress_bar=True)
    
    elapsed = (datetime.now() - start_time).total_seconds() / 60
    logger.info(f"✅ Optuna完了 (所要時間: {elapsed:.1f}分)")
    
    # 最適パラメータ
    best_params = study.best_params
    best_params['objective'] = 'binary'
    best_params['metric'] = 'auc'
    best_params['boosting_type'] = 'gbdt'
    best_params['scale_pos_weight'] = pos_weight  # クラス不均衡対策を追加
    best_params['verbose'] = -1
    best_params['random_state'] = 42
    
    logger.info(f"\n🏆 最適パラメータ (Best AUC: {study.best_value:.4f}):")
    for key, val in best_params.items():
        if key == 'scale_pos_weight':
            logger.info(f"   - {key}: {val:.2f} (クラス不均衡対策)")
        else:
            logger.info(f"   - {key}: {val}")
    
    return best_params

# ================================================================================
# 最終モデル訓練
# ================================================================================

def train_final_model(X_train, y_train, X_test, y_test, best_params, feature_cols):
    """最適パラメータで最終モデル訓練"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 8] 最終モデル訓練")
    logger.info("=" * 80)
    
    train_data = lgb.Dataset(X_train, label=y_train)
    test_data = lgb.Dataset(X_test, label=y_test, reference=train_data)
    
    logger.info("🚀 最終モデル訓練開始...")
    start_time = datetime.now()
    
    model = lgb.train(
        best_params,
        train_data,
        num_boost_round=2000,
        valid_sets=[train_data, test_data],
        valid_names=['train', 'test'],
        callbacks=[
            lgb.early_stopping(stopping_rounds=100),
            lgb.log_evaluation(period=100)
        ]
    )
    
    elapsed = (datetime.now() - start_time).total_seconds()
    logger.info(f"✅ 訓練完了 (所要時間: {elapsed:.1f}秒)")
    logger.info(f"   - Best iteration: {model.best_iteration}")
    
    # 予測
    y_pred_train = model.predict(X_train, num_iteration=model.best_iteration)
    y_pred_test = model.predict(X_test, num_iteration=model.best_iteration)
    
    # 評価
    train_auc = roc_auc_score(y_train, y_pred_train)
    test_auc = roc_auc_score(y_test, y_pred_test)
    
    y_pred_test_binary = (y_pred_test >= 0.5).astype(int)
    test_acc = accuracy_score(y_test, y_pred_test_binary)
    test_precision = precision_score(y_test, y_pred_test_binary)
    test_recall = recall_score(y_test, y_pred_test_binary)
    test_f1 = f1_score(y_test, y_pred_test_binary)
    
    logger.info("\n📈 最終モデル評価:")
    logger.info(f"   - 訓練AUC: {train_auc:.4f}")
    logger.info(f"   - テストAUC: {test_auc:.4f}")
    logger.info(f"   - テスト精度: {test_acc:.4f}")
    logger.info(f"   - テスト適合率: {test_precision:.4f}")
    logger.info(f"   - テスト再現率: {test_recall:.4f}")
    logger.info(f"   - テストF1: {test_f1:.4f}")
    
    # 混同行列
    cm = confusion_matrix(y_test, y_pred_test_binary)
    logger.info("\n📊 混同行列:")
    logger.info(f"   - 真陰性 (TN): {cm[0][0]:,}")
    logger.info(f"   - 偽陽性 (FP): {cm[0][1]:,}")
    logger.info(f"   - 偽陰性 (FN): {cm[1][0]:,}")
    logger.info(f"   - 真陽性 (TP): {cm[1][1]:,}")
    
    # 特徴量重要度
    logger.info("\n🔝 特徴量重要度 Top 20:")
    importance = model.feature_importance(importance_type='gain')
    feature_importance = pd.DataFrame({
        'feature': feature_cols,
        'importance': importance
    }).sort_values('importance', ascending=False)
    
    for idx, row in feature_importance.head(20).iterrows():
        logger.info(f"   {idx + 1:2d}. {row['feature']}: {row['importance']:.2f}")
    
    # 詳細な分類レポート
    logger.info("\n📋 詳細分類レポート:")
    report = classification_report(y_test, y_pred_test_binary, target_names=['4着以下', '3着以内'])
    logger.info("\n" + report)
    
    return model, test_auc, feature_importance

# ================================================================================
# モデル保存
# ================================================================================

def save_model(model, model_path):
    """モデルをファイルに保存"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 9] モデル保存")
    logger.info("=" * 80)
    
    os.makedirs(os.path.dirname(model_path), exist_ok=True)
    model.save_model(model_path)
    
    file_size = os.path.getsize(model_path) / (1024 ** 2)
    logger.info(f"✅ モデル保存完了: {model_path}")
    logger.info(f"   - ファイルサイズ: {file_size:.2f} MB")

# ================================================================================
# レポート出力
# ================================================================================

def save_report(test_auc, feature_importance, report_path):
    """評価レポート保存"""
    logger.info("\n" + "=" * 80)
    logger.info("[Step 10] 評価レポート保存")
    logger.info("=" * 80)
    
    os.makedirs(os.path.dirname(report_path), exist_ok=True)
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("JRA競馬AI - Phase 3 二値分類モデル評価レポート\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"作成日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        f.write(f"テストAUC: {test_auc:.4f}\n\n")
        
        f.write("特徴量重要度 Top 50:\n")
        f.write("-" * 80 + "\n")
        for idx, row in feature_importance.head(50).iterrows():
            f.write(f"{idx + 1:3d}. {row['feature']:40s} {row['importance']:10.2f}\n")
    
    logger.info(f"✅ レポート保存完了: {report_path}")

# ================================================================================
# メイン処理
# ================================================================================

def main():
    """メイン処理"""
    logger.info("\n" + "=" * 80)
    logger.info("🏇 JRA競馬AI - Phase 3: 二値分類モデル構築（改善版）")
    logger.info("=" * 80)
    logger.info("📋 処理概要:")
    logger.info("   1. 評価用モデル: 2016-2024訓練 → 2025テスト")
    logger.info("   2. 実運用モデル: 2016-2025全データ訓練")
    logger.info(f"\n実行開始: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    # パス設定
    data_path = 'data/features/all_tracks_2016-2025_features.csv'
    eval_model_path = 'models/jra_binary_model_eval.txt'
    prod_model_path = 'models/jra_binary_model.txt'
    report_path = 'results/phase3_binary_model_report.txt'
    
    try:
        # ========================================================================
        # パート1: 評価用モデル (2016-2024訓練, 2025テスト)
        # ========================================================================
        logger.info("\n" + "=" * 80)
        logger.info("📊 パート1: 評価用モデル構築 (2016-2024訓練, 2025テスト)")
        logger.info("=" * 80)
        
        # データ読み込み
        df = load_data(data_path)
        
        # 前処理
        df, label_encoders, pos_weight = preprocess_data(df)
        
        # 時系列分割 (2016-2024 vs 2025)
        train_df, test_df = split_train_test(df)
        
        # 特徴量・目的変数分離
        X_train, y_train, X_test, y_test, feature_cols = prepare_features(train_df, test_df)
        
        # ベースラインモデル訓練
        baseline_model, baseline_auc = train_baseline_model(X_train, y_train, X_test, y_test, pos_weight)
        
        # Optunaハイパーパラメータ最適化
        best_params = optimize_hyperparameters(X_train, y_train, pos_weight, n_trials=100)
        
        # 評価用モデル訓練
        eval_model, eval_auc, feature_importance = train_final_model(
            X_train, y_train, X_test, y_test, best_params, feature_cols
        )
        
        # 評価用モデル保存
        save_model(eval_model, eval_model_path)
        
        # レポート保存
        save_report(eval_auc, feature_importance, report_path)
        
        # パート1結果
        logger.info("\n" + "=" * 80)
        logger.info("✅ パート1完了: 評価用モデル")
        logger.info("=" * 80)
        logger.info(f"📊 ベースラインAUC: {baseline_auc:.4f}")
        logger.info(f"📊 評価用モデルAUC: {eval_auc:.4f}")
        logger.info(f"📊 AUC改善率: {((eval_auc - baseline_auc) / baseline_auc * 100):.2f}%")
        
        if eval_auc >= 0.70:
            logger.info("\n🎉 成功基準達成! (AUC ≥ 0.70)")
        else:
            logger.warning(f"\n⚠️  成功基準未達 (AUC {eval_auc:.4f} < 0.70)")
        
        # ========================================================================
        # パート2: 実運用モデル (2016-2025全データ訓練)
        # ========================================================================
        logger.info("\n\n" + "=" * 80)
        logger.info("🚀 パート2: 実運用モデル構築 (2016-2025全データ訓練)")
        logger.info("=" * 80)
        logger.info("   ℹ️  このモデルはPhase 4, 5および実際の予測で使用されます")
        
        # 全データで特徴量・目的変数分離
        # feature_colsは既に prepare_features() で除外済みなのでそのまま使用
        X_all = df[feature_cols]
        y_all = df['is_top3']
        
        logger.info(f"\n📊 全データ:")
        logger.info(f"   - 総行数: {len(X_all):,}行")
        logger.info(f"   - 特徴量数: {len(feature_cols)}列")
        logger.info(f"   - 3着以内割合: {y_all.mean() * 100:.2f}%")
        
        # 実運用モデル訓練
        logger.info("\n🚀 実運用モデル訓練開始...")
        logger.info(f"   - 使用パラメータ: 評価用モデルの最適パラメータ")
        
        start_time = datetime.now()
        
        train_data_all = lgb.Dataset(X_all, label=y_all)
        
        prod_model = lgb.train(
            best_params,
            train_data_all,
            num_boost_round=2000,
            valid_sets=[train_data_all],
            valid_names=['train'],
            callbacks=[
                lgb.early_stopping(stopping_rounds=100),
                lgb.log_evaluation(period=100)
            ]
        )
        
        elapsed = (datetime.now() - start_time).total_seconds()
        logger.info(f"✅ 訓練完了 (所要時間: {elapsed:.1f}秒)")
        logger.info(f"   - Best iteration: {prod_model.best_iteration}")
        
        # 訓練データでの評価
        y_pred_all = prod_model.predict(X_all, num_iteration=prod_model.best_iteration)
        train_auc_all = roc_auc_score(y_all, y_pred_all)
        
        logger.info(f"\n📊 実運用モデル (全データ):")
        logger.info(f"   - 訓練AUC: {train_auc_all:.4f}")
        logger.info(f"   - 訓練データ行数: {len(X_all):,}行")
        
        # 実運用モデル保存
        save_model(prod_model, prod_model_path)
        
        # パート2結果
        logger.info("\n" + "=" * 80)
        logger.info("✅ パート2完了: 実運用モデル")
        logger.info("=" * 80)
        
        # ========================================================================
        # 最終結果サマリー
        # ========================================================================
        logger.info("\n\n" + "=" * 80)
        logger.info("🎉 Phase 3 完了!")
        logger.info("=" * 80)
        
        logger.info("\n📊 評価用モデル (2016-2024訓練, 2025テスト):")
        logger.info(f"   - テストAUC: {eval_auc:.4f}")
        logger.info(f"   - 保存先: {eval_model_path}")
        logger.info(f"   - 用途: モデル性能評価")
        
        logger.info("\n📊 実運用モデル (2016-2025全データ):")
        logger.info(f"   - 訓練AUC: {train_auc_all:.4f}")
        logger.info(f"   - 保存先: {prod_model_path}")
        logger.info(f"   - 用途: Phase 4, 5および実際の予測")
        
        logger.info(f"\n📁 生成ファイル:")
        logger.info(f"   - 評価用モデル: {eval_model_path}")
        logger.info(f"   - 実運用モデル: {prod_model_path}")
        logger.info(f"   - レポート: {report_path}")
        
        logger.info(f"\n🎯 次のステップ:")
        logger.info(f"   - Phase 4-A: ランキングモデル構築 ({prod_model_path}を参考)")
        logger.info(f"   - Phase 4-B: 回帰モデル構築")
        logger.info(f"   - Phase 5: アンサンブル統合")
        
        logger.info(f"\n実行終了: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
    except Exception as e:
        logger.error(f"\n❌ エラー発生: {e}", exc_info=True)
        sys.exit(1)

if __name__ == '__main__':
    main()
