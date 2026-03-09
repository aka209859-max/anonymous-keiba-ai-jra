#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - Phase 4-B: 回帰モデル構築（走破タイム予測）
=============================================================

目的:
    LightGBM Regressorを使用した走破タイム予測モデルを構築
    レース結果の走破タイム（秒）を予測

参考:
    JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md の Phase 4-B

成功基準:
    - RMSE < 5.0 秒
    - R² > 0.70
    - モデル保存: models/jra_regression_model.txt

作成日: 2026-02-22
"""

import pandas as pd
import lightgbm as lgb
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
import numpy as np
import os
from pathlib import Path

def prepare_regression_data():
    """回帰学習用データ準備"""
    print("📂 Phase 4-B: 回帰モデル構築開始...")
    
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
    # タイムフォーマット: "1:23.4" → 83.4秒 or "56.7" → 56.7秒
    print("\n🔧 走破タイムを秒に変換中...")
    
    def time_to_seconds(time_str):
        """走破タイムを秒に変換"""
        if pd.isna(time_str):
            return np.nan
        
        # 既に数値の場合
        if isinstance(time_str, (int, float)):
            # 0.0 は欠損値として扱う
            if time_str == 0.0:
                return np.nan
            # 10分の1秒単位（例: 1334.0 = 133.4秒）を秒に変換
            # ただし、値が大きすぎる場合（例: > 3000 = 300秒）は10分の1秒単位と判断
            return float(time_str) / 10.0
        
        time_str = str(time_str).strip()
        
        # 空文字列
        if time_str == '' or time_str == 'nan':
            return np.nan
        
        # "1:23.4" 形式
        if ':' in time_str:
            try:
                parts = time_str.split(':')
                minutes = int(parts[0])
                seconds = float(parts[1])
                return minutes * 60 + seconds
            except:
                return np.nan
        # "56.7" 形式（文字列）
        else:
            try:
                val = float(time_str)
                if val == 0.0:
                    return np.nan
                # 10分の1秒単位の可能性
                if val > 300:  # 300秒以上なら10分の1秒単位
                    return val / 10.0
                return val
            except:
                return np.nan
    
    # タイム列を確認（データによって列名が異なる可能性）
    time_columns = ['time', 'haronjikan', 'タイム', '走破時間']
    time_col = None
    
    for col in time_columns:
        if col in df.columns:
            time_col = col
            break
    
    if time_col is None:
        # 列名を表示してユーザーに確認を促す
        print(f"⚠️  走破タイム列が見つかりません。利用可能な列:")
        print(f"  {', '.join([c for c in df.columns if 'time' in c.lower() or 'タイム' in c or '時間' in c])}")
        
        # 仮に 'prev1_time', 'prev2_time' などがある場合は prev1_time を使用
        if 'prev1_time' in df.columns:
            print(f"  → 'prev1_time' を走破タイムとして使用します")
            time_col = 'prev1_time'
        else:
            raise ValueError("走破タイム列が見つかりません")
    
    print(f"  使用する列: {time_col}")
    
    # データのサンプルを表示（デバッグ用）
    print(f"\n🔍 データサンプル確認:")
    sample_values = df[time_col].dropna().head(10).tolist()
    print(f"  最初の10件: {sample_values}")
    print(f"  データ型: {df[time_col].dtype}")
    
    df['target_time_seconds'] = df[time_col].apply(time_to_seconds)
    
    # 欠損値・異常値の確認
    missing_count = df['target_time_seconds'].isnull().sum()
    print(f"\n📊 目的変数統計:")
    print(f"  欠損値: {missing_count:,}行 ({missing_count/len(df)*100:.1f}%)")
    
    if missing_count > 0:
        print(f"  → 欠損値を除外します")
        df = df.dropna(subset=['target_time_seconds'])
    
    # 異常値除外（50秒未満、または250秒以上）
    # 競馬の走破タイムは通常 55秒～200秒程度
    valid_mask = (df['target_time_seconds'] >= 50) & (df['target_time_seconds'] <= 250)
    outlier_count = len(df) - valid_mask.sum() - missing_count  # 欠損値を除いた異常値
    
    if outlier_count > 0:
        print(f"  異常値: {outlier_count:,}行 → 除外")
        df = df[valid_mask]
    
    # データが残っているか確認
    if len(df) == 0:
        # 元のデータを再読み込みしてデバッグ
        df_debug = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
        print(f"\n❌ エラー: 有効なデータがありません")
        print(f"\n🔍 デバッグ情報:")
        print(f"  元のデータ型: {df_debug[time_col].dtype}")
        print(f"  ユニークな値の例（最初の20件）:")
        unique_values = df_debug[time_col].value_counts().head(20)
        print(unique_values)
        raise ValueError("有効なデータが0件です。走破タイム列の形式を確認してください。")
    
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
    
    # カテゴリ列をcategory型に変換
    for col in categorical_cols:
        if col != 'race_id':
            df[col] = df[col].astype('category')
    
    print(f"✅ 欠損値処理完了")
    
    # 時系列分割（2016-2023: 訓練、2024: 検証、2025: テスト）
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

def train_regression_model(train_df, valid_df, test_df, feature_cols):
    """回帰モデル学習"""
    print("\n" + "=" * 80)
    print("🚀 Phase 4-B: 回帰モデル学習（走破タイム予測）")
    print("=" * 80)
    
    # データセット作成
    X_train = train_df[feature_cols]
    y_train = train_df['target_time_seconds']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target_time_seconds']
    
    X_test = test_df[feature_cols]
    y_test = test_df['target_time_seconds']
    
    # LightGBM Regressor パラメータ
    params = {
        'objective': 'regression',
        'metric': 'rmse',
        'boosting_type': 'gbdt',
        'num_leaves': 50,
        'learning_rate': 0.05,
        'feature_fraction': 0.8,
        'bagging_fraction': 0.8,
        'bagging_freq': 5,
        'verbosity': -1,
        'random_state': 42
    }
    
    print("\n📊 訓練パラメータ:")
    for key, val in params.items():
        print(f"  - {key}: {val}")
    
    # LightGBM データセット作成
    print("\n🔧 LightGBM データセット作成中...")
    train_data = lgb.Dataset(X_train, y_train)
    valid_data = lgb.Dataset(X_valid, y_valid, reference=train_data)
    
    # モデル訓練
    print("\n🚀 モデル訓練開始...")
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[train_data, valid_data],
        valid_names=['train', 'valid'],
        callbacks=[lgb.early_stopping(stopping_rounds=50), lgb.log_evaluation(100)]
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
    
    # 予測誤差の分布
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
    
    # パーセンタイル
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
    
    if rmse < 5.0 and r2 > 0.70:
        print(f"\n🎉 成功基準達成!")
    else:
        print(f"\n⚠️  成功基準未達")
        if rmse >= 5.0:
            print(f"  → RMSE が目標値を超えています（{rmse:.4f} ≥ 5.0）")
        if r2 <= 0.70:
            print(f"  → R² が目標値を下回っています（{r2:.4f} ≤ 0.70）")
    
    # モデル保存
    print("\n" + "=" * 80)
    print("💾 モデル保存")
    print("=" * 80)
    
    os.makedirs('models', exist_ok=True)
    
    # 評価用モデル（テスト評価済み）
    eval_model_path = 'models/jra_regression_model_eval.txt'
    model.save_model(eval_model_path)
    eval_model_size_mb = Path(eval_model_path).stat().st_size / (1024 ** 2)
    print(f"✅ 評価用モデル保存: {eval_model_path}")
    print(f"  ファイルサイズ: {eval_model_size_mb:.2f} MB")
    
    # 本番用モデル（全データで再訓練）
    print("\n🔧 本番用モデルを全データで再訓練中...")
    full_data = lgb.Dataset(
        pd.concat([X_train, X_valid, X_test]),
        pd.concat([y_train, y_valid, y_test])
    )
    
    full_model = lgb.train(
        params,
        full_data,
        num_boost_round=model.best_iteration,
        callbacks=[lgb.log_evaluation(0)]
    )
    
    full_model_path = 'models/jra_regression_model.txt'
    full_model.save_model(full_model_path)
    full_model_size_mb = Path(full_model_path).stat().st_size / (1024 ** 2)
    print(f"✅ 本番用モデル保存: {full_model_path}")
    print(f"  ファイルサイズ: {full_model_size_mb:.2f} MB")
    
    # レポート保存
    print("\n🔧 評価レポートを保存中...")
    report_lines = []
    report_lines.append("=" * 80)
    report_lines.append("Phase 4-B: 回帰モデル（走破タイム予測）評価レポート")
    report_lines.append("=" * 80)
    report_lines.append("")
    report_lines.append("生成日時: 2026-02-22")
    report_lines.append("")
    report_lines.append("【モデル情報】")
    report_lines.append(f"  - モデルタイプ: LightGBM Regressor")
    report_lines.append(f"  - ツリー数: {model.best_iteration}")
    report_lines.append(f"  - 特徴量数: {len(feature_cols)}")
    report_lines.append("")
    report_lines.append("【テストデータ評価】")
    report_lines.append(f"  - RMSE: {rmse:.4f} 秒 {rmse_pass}")
    report_lines.append(f"  - MAE: {mae:.4f} 秒")
    report_lines.append(f"  - R²: {r2:.4f} {r2_pass}")
    report_lines.append("")
    report_lines.append("【予測誤差の分布】")
    report_lines.append(f"  - 平均誤差: {errors.mean():.4f} 秒")
    report_lines.append(f"  - 標準偏差: {errors.std():.4f} 秒")
    report_lines.append(f"  - 最小誤差: {errors.min():.4f} 秒")
    report_lines.append(f"  - 最大誤差: {errors.max():.4f} 秒")
    report_lines.append("")
    report_lines.append("【成功基準】")
    report_lines.append(f"  - RMSE < 5.0秒: {rmse_pass}")
    report_lines.append(f"  - R² > 0.70: {r2_pass}")
    report_lines.append("")
    report_lines.append("【保存ファイル】")
    report_lines.append(f"  - 評価用: {eval_model_path} ({eval_model_size_mb:.2f} MB)")
    report_lines.append(f"  - 本番用: {full_model_path} ({full_model_size_mb:.2f} MB)")
    report_lines.append("")
    report_lines.append("=" * 80)
    
    report_text = "\n".join(report_lines)
    
    os.makedirs('results', exist_ok=True)
    report_path = 'results/phase4b_regression_model_report.txt'
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write(report_text)
    
    print(f"✅ レポート保存完了: {report_path}")
    
    return model, rmse, r2

if __name__ == '__main__':
    print("\n" + "=" * 80)
    print("🏇 JRA競馬AI - Phase 4-B: 回帰モデル構築（走破タイム予測）")
    print("=" * 80)
    print("\n参考: JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md")
    print("成功基準: RMSE < 5.0秒, R² > 0.70\n")
    
    try:
        train_df, valid_df, test_df, feature_cols = prepare_regression_data()
        model, rmse, r2 = train_regression_model(train_df, valid_df, test_df, feature_cols)
        
        print("\n" + "=" * 80)
        print("✅ Phase 4-B 完了!")
        print("=" * 80)
        print("\n🎯 次のステップ:")
        print("  - Phase 5: アンサンブル統合")
        print("    - Phase 3: 二値分類モデル")
        print("    - Phase 4-A: ランキングモデル")
        print("    - Phase 4-B: 回帰モデル")
        print("  → 3つのモデルを統合して最終予測を生成\n")
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
