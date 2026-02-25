#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - 評価用モデルで2025年予測
=============================================================

目的:
    評価用モデル（2016-2024学習）で2025年データを予測
    キャリブレーション用の予測結果と実績データを紐付け

機能:
    1. 2025年特徴量データを読み込み
    2. 評価用二値分類モデルで予測
    3. 評価用ランキングモデルで予測（存在する場合）
    4. 評価用回帰モデルで予測（存在する場合）
    5. 実績データ（actual_top3）を紐付け
    6. キャリブレーション用データセットとして保存

入力:
    - data/evaluation/features_2025_for_calibration.csv
    - models/jra_binary_model_eval.txt（必須）
    - models/jra_ranking_model_eval.txt（オプション）
    - models/jra_regression_model_eval.txt（必須）

出力:
    - data/evaluation/predictions_2025_eval_model.csv

作成日: 2026-02-25
バージョン: 1.0
"""

import os
import sys
import pandas as pd
import numpy as np
import lightgbm as lgb
from pathlib import Path
from datetime import datetime

# ================================================================================
# 設定
# ================================================================================

INPUT_CSV = 'data/evaluation/features_2025_for_calibration.csv'
OUTPUT_CSV = 'data/evaluation/predictions_2025_eval_model.csv'

# モデルファイルパス
BINARY_MODEL_PATH = 'models/jra_binary_model_eval.txt'
RANKING_MODEL_PATH = 'models/jra_ranking_model_eval.txt'  # オプション
REGRESSION_MODEL_PATH = 'models/jra_regression_model_eval.txt'

# ================================================================================
# モデル読み込み
# ================================================================================

def load_models():
    """評価用モデルを読み込み"""
    print("=" * 80)
    print("🤖 評価用モデル読み込み")
    print("=" * 80)
    
    models = {}
    
    # 二値分類モデル（必須）
    if not os.path.exists(BINARY_MODEL_PATH):
        print(f"❌ エラー: 二値分類モデルが見つかりません: {BINARY_MODEL_PATH}")
        print("\nPhase 3を実行して評価用モデルを作成してください:")
        print("  python scripts/phase3/train_binary_model.py")
        sys.exit(1)
    
    print(f"読み込み中: {BINARY_MODEL_PATH}")
    models['binary'] = lgb.Booster(model_file=BINARY_MODEL_PATH)
    print(f"✅ 二値分類モデル読み込み完了")
    print(f"   - 特徴量数: {models['binary'].num_feature()}")
    
    # 回帰モデル（必須）
    if not os.path.exists(REGRESSION_MODEL_PATH):
        print(f"❌ エラー: 回帰モデルが見つかりません: {REGRESSION_MODEL_PATH}")
        print("\nPhase 4を実行して評価用モデルを作成してください:")
        print("  python scripts/phase4/train_regression_model.py")
        sys.exit(1)
    
    print(f"読み込み中: {REGRESSION_MODEL_PATH}")
    models['regression'] = lgb.Booster(model_file=REGRESSION_MODEL_PATH)
    print(f"✅ 回帰モデル読み込み完了")
    print(f"   - 特徴量数: {models['regression'].num_feature()}")
    
    # ランキングモデル（オプション）
    if os.path.exists(RANKING_MODEL_PATH):
        print(f"読み込み中: {RANKING_MODEL_PATH}")
        models['ranking'] = lgb.Booster(model_file=RANKING_MODEL_PATH)
        print(f"✅ ランキングモデル読み込み完了")
        print(f"   - 特徴量数: {models['ranking'].num_feature()}")
    else:
        print(f"⚠️  ランキングモデルが見つかりません（スキップ）: {RANKING_MODEL_PATH}")
        models['ranking'] = None
    
    return models

# ================================================================================
# データ読み込みと前処理
# ================================================================================

def load_and_preprocess_data(input_csv, models):
    """
    2025年データを読み込み、予測用に前処理
    
    Parameters:
    -----------
    input_csv : str
        入力CSVファイルパス
    models : dict
        モデル辞書
    """
    print("\n" + "=" * 80)
    print("📂 2025年特徴量データ読み込み")
    print("=" * 80)
    
    if not os.path.exists(input_csv):
        print(f"❌ エラー: ファイルが見つかりません: {input_csv}")
        print("\n先にステップ1を実行してください:")
        print("  python scripts/data_preparation/extract_2025_data.py")
        sys.exit(1)
    
    print(f"読み込み中: {input_csv}")
    df = pd.read_csv(input_csv, encoding='utf-8', low_memory=False)
    
    print(f"✅ データ読み込み完了")
    print(f"   - 行数: {len(df):,}行")
    print(f"   - 列数: {len(df.columns)}列")
    
    # 実績データ（actual_top3）を作成
    print("\n[実績データ作成]")
    if 'kakutei_chakujun' in df.columns:
        # 確定着順を数値に変換
        df['kakutei_chakujun_num'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')
        
        # 3着以内フラグ
        df['actual_top3'] = (df['kakutei_chakujun_num'] <= 3).astype(int)
        
        top3_count = df['actual_top3'].sum()
        top3_rate = top3_count / len(df) * 100
        
        print(f"  3着以内の馬: {top3_count}頭 ({top3_rate:.1f}%)")
        print(f"  4着以下の馬: {len(df) - top3_count}頭 ({100 - top3_rate:.1f}%)")
    else:
        print("⚠️  'kakutei_chakujun' カラムが見つかりません")
        print("  actual_top3 は作成できません")
        df['actual_top3'] = np.nan
    
    return df

# ================================================================================
# 予測実行
# ================================================================================

def generate_predictions(df, models):
    """
    評価用モデルで2025年データを予測
    
    Parameters:
    -----------
    df : pd.DataFrame
        2025年特徴量データ
    models : dict
        モデル辞書
    """
    print("\n" + "=" * 80)
    print("🔮 予測実行中...")
    print("=" * 80)
    
    # 二値分類予測
    print("\n[1] 二値分類予測（3着以内確率）")
    binary_features = models['binary'].feature_name()
    
    # 特徴量カラムの存在確認
    missing_cols = [col for col in binary_features if col not in df.columns]
    if missing_cols:
        print(f"⚠️  警告: 以下の特徴量が見つかりません（0で埋めます）:")
        print(f"  欠損数: {len(missing_cols)}個")
        if len(missing_cols) <= 10:
            for col in missing_cols:
                print(f"    - {col}")
        
        # 欠損カラムを0で埋める
        for col in missing_cols:
            df[col] = 0
    
    X_binary = df[binary_features].fillna(0)
    print(f"  特徴量行列: {X_binary.shape}")
    
    df['binary_proba_eval'] = models['binary'].predict(X_binary)
    print(f"  ✅ 予測完了")
    print(f"  予測確率の範囲: {df['binary_proba_eval'].min():.4f} - {df['binary_proba_eval'].max():.4f}")
    print(f"  予測確率の平均: {df['binary_proba_eval'].mean():.4f}")
    
    # 回帰予測（タイム予測）
    print("\n[2] 回帰予測（走破タイム）")
    regression_features = models['regression'].feature_name()
    
    missing_cols = [col for col in regression_features if col not in df.columns]
    if missing_cols:
        print(f"⚠️  警告: {len(missing_cols)}個の特徴量が欠損（0で埋めます）")
        for col in missing_cols:
            df[col] = 0
    
    X_regression = df[regression_features].fillna(0)
    print(f"  特徴量行列: {X_regression.shape}")
    
    df['time_pred_eval'] = models['regression'].predict(X_regression)
    print(f"  ✅ 予測完了")
    print(f"  予測タイムの範囲: {df['time_pred_eval'].min():.2f}秒 - {df['time_pred_eval'].max():.2f}秒")
    print(f"  予測タイムの平均: {df['time_pred_eval'].mean():.2f}秒")
    
    # ランキング予測（オプション）
    if models['ranking'] is not None:
        print("\n[3] ランキング予測（順位予測）")
        ranking_features = models['ranking'].feature_name()
        
        missing_cols = [col for col in ranking_features if col not in df.columns]
        if missing_cols:
            print(f"⚠️  警告: {len(missing_cols)}個の特徴量が欠損（0で埋めます）")
            for col in missing_cols:
                df[col] = 0
        
        X_ranking = df[ranking_features].fillna(0)
        print(f"  特徴量行列: {X_ranking.shape}")
        
        df['ranking_pred_eval'] = models['ranking'].predict(X_ranking)
        print(f"  ✅ 予測完了")
        print(f"  予測順位の範囲: {df['ranking_pred_eval'].min():.2f} - {df['ranking_pred_eval'].max():.2f}")
        print(f"  予測順位の平均: {df['ranking_pred_eval'].mean():.2f}")
    else:
        print("\n[3] ランキング予測（スキップ）")
        df['ranking_pred_eval'] = np.nan
    
    return df

# ================================================================================
# 結果保存
# ================================================================================

def save_predictions(df, output_csv):
    """
    予測結果を保存
    
    Parameters:
    -----------
    df : pd.DataFrame
        予測結果を含むデータフレーム
    output_csv : str
        出力CSVファイルパス
    """
    print("\n" + "=" * 80)
    print("💾 予測結果保存中...")
    print("=" * 80)
    
    # 保存するカラムを選択
    output_columns = [
        'race_id', 'kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime',
        'race_bango', 'umaban', 'bamei', 'kishu_mei', 'chokyo_shi_mei',
        'binary_proba_eval', 'ranking_pred_eval', 'time_pred_eval',
        'actual_top3', 'kakutei_chakujun'
    ]
    
    # 存在するカラムのみ選択
    available_columns = [col for col in output_columns if col in df.columns]
    
    # race_id がない場合は生成
    if 'race_id' not in df.columns:
        print("  ⚠️  race_id が見つかりません（生成します）")
        if all(col in df.columns for col in ['kaisai_nen', 'keibajo_code', 'kaisai_kai', 
                                               'kaisai_nichime', 'race_bango']):
            df['race_id'] = (
                df['kaisai_nen'].astype(str) + 
                df['keibajo_code'].astype(str).str.zfill(2) +
                df['kaisai_kai'].astype(str).str.zfill(2) +
                df['kaisai_nichime'].astype(str).str.zfill(2) +
                df['race_bango'].astype(str).str.zfill(2)
            )
            if 'race_id' not in available_columns:
                available_columns.insert(0, 'race_id')
    
    df_output = df[available_columns].copy()
    
    # 保存
    df_output.to_csv(output_csv, index=False, encoding='utf-8')
    
    output_size = os.path.getsize(output_csv) / (1024**2)
    print(f"✅ 保存完了: {output_csv}")
    print(f"   - 行数: {len(df_output):,}行")
    print(f"   - 列数: {len(df_output.columns)}列")
    print(f"   - ファイルサイズ: {output_size:.1f} MB")
    
    # 保存されたカラム一覧
    print("\n[保存されたカラム]")
    for i, col in enumerate(df_output.columns, 1):
        print(f"  {i:2d}. {col}")
    
    # 統計サマリー
    print("\n[予測統計サマリー]")
    if 'binary_proba_eval' in df_output.columns:
        print(f"  binary_proba_eval:")
        print(f"    平均: {df_output['binary_proba_eval'].mean():.4f}")
        print(f"    中央値: {df_output['binary_proba_eval'].median():.4f}")
        print(f"    標準偏差: {df_output['binary_proba_eval'].std():.4f}")
    
    if 'actual_top3' in df_output.columns:
        print(f"  actual_top3:")
        print(f"    3着以内: {df_output['actual_top3'].sum():,}頭")
        print(f"    4着以下: {(df_output['actual_top3'] == 0).sum():,}頭")
    
    return df_output

# ================================================================================
# メイン処理
# ================================================================================

def main():
    """メイン処理"""
    print("\n" + "=" * 80)
    print("🎯 JRA競馬AI予想システム - 評価用モデルで2025年予測")
    print("=" * 80)
    print(f"開始時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    # モデル読み込み
    models = load_models()
    
    # データ読み込みと前処理
    df = load_and_preprocess_data(INPUT_CSV, models)
    
    # 予測実行
    df = generate_predictions(df, models)
    
    # 結果保存
    df_output = save_predictions(df, OUTPUT_CSV)
    
    print("\n" + "=" * 80)
    print("✅ 評価用モデルでの2025年予測完了！")
    print("=" * 80)
    print(f"終了時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("\n次のステップ:")
    print("  1. キャリブレーション用データセットが準備完了")
    print("  2. Phase 3へ進む:")
    print("     → scripts/calibration/train_meta_model.py")
    print("  3. メタモデル学習と温度スケーリングの実装")
    print("=" * 80 + "\n")

if __name__ == '__main__':
    main()
