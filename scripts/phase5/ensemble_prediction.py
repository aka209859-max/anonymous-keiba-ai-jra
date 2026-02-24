#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - Phase 5: アンサンブル統合
=============================================================

目的:
    3つのモデルを統合して最終予測を生成
    - Phase 3: 二値分類モデル（3着内予測）
    - Phase 4-A: ランキングモデル（順位付け）
    - Phase 4-B: 回帰モデル（走破タイム予測）

目標:
    - 本命的中率: > 40%
    - 対抗的中率: > 30%
    - 3連単的中率: > 5%

作成日: 2026-02-22
"""

import pandas as pd
import lightgbm as lgb
import numpy as np
from pathlib import Path
import os

def load_models():
    """3つのモデルを読み込み"""
    print("=" * 80)
    print("📂 Phase 5: アンサンブル統合 - モデル読み込み")
    print("=" * 80)
    
    models = {}
    
    # Phase 3: 二値分類モデル
    binary_model_path = 'models/jra_binary_model.txt'
    if Path(binary_model_path).exists():
        models['binary'] = lgb.Booster(model_file=binary_model_path)
        print(f"✅ Phase 3 二値分類モデル読み込み: {binary_model_path}")
    else:
        print(f"⚠️  Phase 3 モデルが見つかりません: {binary_model_path}")
    
    # Phase 4-A: ランキングモデル
    ranking_model_path = 'models/jra_ranking_model.txt'
    if Path(ranking_model_path).exists():
        models['ranking'] = lgb.Booster(model_file=ranking_model_path)
        print(f"✅ Phase 4-A ランキングモデル読み込み: {ranking_model_path}")
    else:
        print(f"⚠️  Phase 4-A モデルが見つかりません: {ranking_model_path}")
    
    # Phase 4-B: 回帰モデル（最適化版があれば優先）
    regression_model_paths = [
        'models/jra_regression_model_optimized.txt',
        'models/jra_regression_model.txt'
    ]
    
    for path in regression_model_paths:
        if Path(path).exists():
            models['regression'] = lgb.Booster(model_file=path)
            print(f"✅ Phase 4-B 回帰モデル読み込み: {path}")
            break
    else:
        print(f"⚠️  Phase 4-B モデルが見つかりません")
    
    if len(models) < 3:
        raise FileNotFoundError(f"モデルが不足しています。必要: 3個、検出: {len(models)}個")
    
    print(f"\n✅ 全モデル読み込み完了: {len(models)}個")
    return models

def prepare_test_data():
    """テストデータ準備"""
    print("\n" + "=" * 80)
    print("📊 テストデータ準備（2025年）")
    print("=" * 80)
    
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    print(f"✅ データ読み込み: {len(df):,}行 × {len(df.columns)}列")
    
    # 2025年データのみ抽出
    test_df = df[df['kaisai_nen'] == 2025].copy()
    print(f"✅ 2025年データ抽出: {len(test_df):,}行")
    
    # race_id生成
    if 'race_id' not in test_df.columns:
        test_df['race_id'] = (
            test_df['kaisai_nen'].astype(str) +
            test_df['kaisai_tsukihi'].astype(str).str.zfill(4) +
            test_df['keibajo_code'].astype(str).str.zfill(2) +
            test_df['race_bango'].astype(str).str.zfill(2)
        )
    
    print(f"  レース数: {test_df['race_id'].nunique():,}レース")
    
    # 欠損値処理
    numeric_cols = test_df.select_dtypes(include=['int64', 'float64']).columns
    test_df[numeric_cols] = test_df[numeric_cols].fillna(-1)
    
    categorical_cols = test_df.select_dtypes(include=['object']).columns
    test_df[categorical_cols] = test_df[categorical_cols].fillna('unknown')
    
    # カテゴリカル列を数値エンコーディング（文字列型を整数に変換）
    # LightGBMは int, float, bool のみ受け付けるため、全てのobject型を変換
    for col in categorical_cols:
        if col not in ['race_id', 'kakutei_chakujun']:  # IDと正解ラベルは除外
            # Label Encoding: カテゴリを整数コードに変換
            test_df[col] = test_df[col].astype('category').cat.codes
    
    # 特徴量カラム
    exclude_cols = ['target_top3', 'kakutei_chakujun', 'kaisai_nen', 'race_id', 'prev1_time']
    feature_cols = [c for c in test_df.columns if c not in exclude_cols]
    
    print(f"✅ 特徴量: {len(feature_cols)}列")
    print(f"✅ データ準備完了")
    
    return test_df, feature_cols

def ensemble_predict(models, test_df, feature_cols):
    """アンサンブル予測"""
    print("\n" + "=" * 80)
    print("🔮 アンサンブル予測実行")
    print("=" * 80)
    
    # 各モデルで予測（モデルごとに個別の特徴量リストを使用）
    print("\n🔧 各モデルで予測中...")
    
    # 1. 二値分類モデル（3着内確率）
    try:
        binary_feature_names = models['binary'].feature_name()
        print(f"  Phase 3 特徴量: {len(binary_feature_names)}列")
        
        # Phase 3用の特徴量を準備（不足分は-1で埋める）
        for feat in binary_feature_names:
            if feat not in test_df.columns:
                test_df[feat] = -1
        
        X_binary = test_df[binary_feature_names].to_numpy()
        binary_proba = models['binary'].predict(X_binary)
        print(f"✅ Phase 3 二値分類: 3着内確率予測完了")
    except Exception as e:
        print(f"❌ Phase 3 予測エラー: {e}")
        binary_proba = np.zeros(len(test_df))
    
    # 2. ランキングモデル（順位スコア）
    try:
        ranking_feature_names = models['ranking'].feature_name()
        print(f"  Phase 4-A 特徴量: {len(ranking_feature_names)}列")
        
        # Phase 4-A用の特徴量を準備（不足分は-1で埋める）
        for feat in ranking_feature_names:
            if feat not in test_df.columns:
                test_df[feat] = -1
        
        X_ranking = test_df[ranking_feature_names].to_numpy()
        ranking_score = models['ranking'].predict(X_ranking)
        print(f"✅ Phase 4-A ランキング: 順位スコア予測完了")
    except Exception as e:
        print(f"❌ Phase 4-A 予測エラー: {e}")
        ranking_score = np.zeros(len(test_df))
    
    # 3. 回帰モデル（走破タイム予測）
    try:
        regression_feature_names = models['regression'].feature_name()
        print(f"  Phase 4-B 特徴量: {len(regression_feature_names)}列")
        
        # Phase 4-B用の特徴量を準備（不足分は-1で埋める）
        for feat in regression_feature_names:
            if feat not in test_df.columns:
                test_df[feat] = -1
        
        X_regression = test_df[regression_feature_names].to_numpy()
        time_pred = models['regression'].predict(X_regression)
        print(f"✅ Phase 4-B 回帰: 走破タイム予測完了")
    except Exception as e:
        print(f"❌ Phase 4-B 予測エラー: {e}")
        time_pred = np.zeros(len(test_df))
    
    # 予測結果を DataFrame に追加
    test_df['binary_proba'] = binary_proba
    test_df['ranking_score'] = ranking_score
    test_df['time_pred'] = time_pred
    
    # アンサンブルスコア計算
    print("\n🔧 アンサンブルスコア計算中...")
    
    # スコアの正規化
    test_df['binary_proba_norm'] = test_df['binary_proba']  # 既に0-1
    test_df['ranking_score_inv'] = -test_df['ranking_score']  # 低い方が良い順位
    
    # レース単位で正規化
    race_normalized = []
    
    for race_id, group in test_df.groupby('race_id'):
        group = group.copy()
        
        # ランキングスコアを0-1に正規化（レース内）
        ranking_min = group['ranking_score'].min()
        ranking_max = group['ranking_score'].max()
        if ranking_max > ranking_min:
            group['ranking_norm'] = 1 - (group['ranking_score'] - ranking_min) / (ranking_max - ranking_min)
        else:
            group['ranking_norm'] = 0.5
        
        # タイムスコアを0-1に正規化（レース内、早い方が高スコア）
        time_min = group['time_pred'].min()
        time_max = group['time_pred'].max()
        if time_max > time_min:
            group['time_norm'] = 1 - (group['time_pred'] - time_min) / (time_max - time_min)
        else:
            group['time_norm'] = 0.5
        
        # アンサンブルスコア（重み付け平均）
        # 重み: 二値分類 30%, ランキング 40%, タイム 30%
        group['ensemble_score'] = (
            0.30 * group['binary_proba_norm'] +
            0.40 * group['ranking_norm'] +
            0.30 * group['time_norm']
        )
        
        # レース内順位
        group['predicted_rank'] = group['ensemble_score'].rank(ascending=False, method='first')
        
        race_normalized.append(group)
    
    result_df = pd.concat(race_normalized, ignore_index=True)
    
    print(f"✅ アンサンブルスコア計算完了")
    
    return result_df

def evaluate_predictions(result_df):
    """予測精度評価"""
    print("\n" + "=" * 80)
    print("📊 予測精度評価")
    print("=" * 80)
    
    # 実際の順位を取得
    actual_rank = pd.to_numeric(result_df['kakutei_chakujun'], errors='coerce')
    result_df['actual_rank'] = actual_rank
    
    # 欠損値を除外
    valid_df = result_df.dropna(subset=['actual_rank'])
    print(f"\n✅ 評価対象: {len(valid_df):,}頭（{valid_df['race_id'].nunique():,}レース）")
    
    # 本命・対抗・単穴の定義
    # 本命: アンサンブルスコア1位
    # 対抗: アンサンブルスコア2位
    # 単穴: アンサンブルスコア3位
    
    # 本命的中（2パターン）
    honmei_1st_correct = 0  # 予測1位が実際に1着
    honmei_top3_correct = 0  # 予測1位が実際に3着以内
    
    # 対抗的中（2パターン）
    taiko_1st_correct = 0  # 予測2位が実際に1着
    taiko_top3_correct = 0  # 予測2位が実際に3着以内
    
    tansho_correct = 0
    sanrentan_correct = 0
    
    total_races = valid_df['race_id'].nunique()
    
    for race_id, group in valid_df.groupby('race_id'):
        group = group.sort_values('ensemble_score', ascending=False)
        
        if len(group) < 3:
            continue
        
        # 予測
        pred_1st = group.iloc[0]
        pred_2nd = group.iloc[1]
        pred_3rd = group.iloc[2]
        
        # 本命的中（予測1位）
        if pred_1st['actual_rank'] == 1:
            honmei_1st_correct += 1
        if pred_1st['actual_rank'] <= 3:
            honmei_top3_correct += 1
        
        # 対抗的中（予測2位）
        if pred_2nd['actual_rank'] == 1:
            taiko_1st_correct += 1
        if pred_2nd['actual_rank'] <= 3:
            taiko_top3_correct += 1
        
        # 単穴的中（予測3位が実際に1-3着）
        if pred_3rd['actual_rank'] <= 3:
            tansho_correct += 1
        
        # 3連単的中（予測1-2-3が実際に1-2-3）
        if (pred_1st['actual_rank'] == 1 and 
            pred_2nd['actual_rank'] == 2 and 
            pred_3rd['actual_rank'] == 3):
            sanrentan_correct += 1
    
    # 的中率計算
    honmei_1st_rate = honmei_1st_correct / total_races * 100
    honmei_top3_rate = honmei_top3_correct / total_races * 100
    taiko_1st_rate = taiko_1st_correct / total_races * 100
    taiko_top3_rate = taiko_top3_correct / total_races * 100
    tansho_rate = tansho_correct / total_races * 100
    sanrentan_rate = sanrentan_correct / total_races * 100
    
    print(f"\n📈 的中率:")
    print(f"  本命的中率（1着）: {honmei_1st_rate:.2f}% ({honmei_1st_correct}/{total_races}レース)")
    print(f"  本命的中率（3着以内）: {honmei_top3_rate:.2f}% ({honmei_top3_correct}/{total_races}レース)")
    print(f"  対抗的中率（1着）: {taiko_1st_rate:.2f}% ({taiko_1st_correct}/{total_races}レース)")
    print(f"  対抗的中率（3着以内）: {taiko_top3_rate:.2f}% ({taiko_top3_correct}/{total_races}レース)")
    print(f"  単穴的中率（3着以内）: {tansho_rate:.2f}% ({tansho_correct}/{total_races}レース)")
    print(f"  3連単的中率: {sanrentan_rate:.2f}% ({sanrentan_correct}/{total_races}レース)")
    
    # 成功基準判定
    print(f"\n📋 成功基準判定:")
    honmei_1st_pass = "✅" if honmei_1st_rate > 40 else "❌"
    honmei_top3_pass = "✅" if honmei_top3_rate > 40 else "❌"
    taiko_1st_pass = "✅" if taiko_1st_rate > 30 else "❌"
    taiko_top3_pass = "✅" if taiko_top3_rate > 30 else "❌"
    sanrentan_pass = "✅" if sanrentan_rate > 5 else "❌"
    
    print(f"  本命的中率（1着）> 40%: {honmei_1st_pass} ({honmei_1st_rate:.2f}%)")
    print(f"  本命的中率（3着以内）> 40%: {honmei_top3_pass} ({honmei_top3_rate:.2f}%)")
    print(f"  対抗的中率（1着）> 30%: {taiko_1st_pass} ({taiko_1st_rate:.2f}%)")
    print(f"  対抗的中率（3着以内）> 30%: {taiko_top3_pass} ({taiko_top3_rate:.2f}%)")
    print(f"  3連単的中率 > 5%: {sanrentan_pass} ({sanrentan_rate:.2f}%)")
    
    # 総合判定（いずれかのパターンで成功基準達成すればOK）
    honmei_pass = honmei_1st_rate > 40 or honmei_top3_rate > 40
    taiko_pass = taiko_1st_rate > 30 or taiko_top3_rate > 30
    sanrentan_pass_bool = sanrentan_rate > 5
    
    success_list = [honmei_pass, taiko_pass, sanrentan_pass_bool]
    success_count = success_list.count(True)
    
    print(f"\n📊 総合判定:")
    print(f"  本命基準達成: {'✅' if honmei_pass else '❌'}")
    print(f"  対抗基準達成: {'✅' if taiko_pass else '❌'}")
    print(f"  3連単基準達成: {'✅' if sanrentan_pass_bool else '❌'}")
    
    if success_count == 3:
        print(f"\n🎉 全成功基準達成!")
    elif success_count >= 2:
        print(f"\n✅ {success_count}/3 の成功基準達成")
    else:
        print(f"\n⚠️  成功基準未達（達成: {success_count}/3）")
    
    return {
        'honmei_1st_rate': honmei_1st_rate,
        'honmei_top3_rate': honmei_top3_rate,
        'taiko_1st_rate': taiko_1st_rate,
        'taiko_top3_rate': taiko_top3_rate,
        'tansho_rate': tansho_rate,
        'sanrentan_rate': sanrentan_rate,
        'total_races': total_races
    }

def save_predictions(result_df, metrics):
    """予測結果を保存"""
    print("\n" + "=" * 80)
    print("💾 予測結果保存")
    print("=" * 80)
    
    os.makedirs('results', exist_ok=True)
    
    # 予測結果CSV
    output_cols = [
        'race_id', 'umaban', 'kaisai_tsukihi', 'keibajo_code', 'race_bango',
        'binary_proba', 'ranking_score', 'time_pred', 'ensemble_score',
        'predicted_rank', 'actual_rank', 'kakutei_chakujun'
    ]
    
    output_df = result_df[[c for c in output_cols if c in result_df.columns]]
    output_path = 'results/phase5_ensemble_predictions_2025.csv'
    output_df.to_csv(output_path, index=False, encoding='utf-8')
    
    file_size_mb = Path(output_path).stat().st_size / (1024 ** 2)
    print(f"✅ 予測結果保存: {output_path}")
    print(f"  ファイルサイズ: {file_size_mb:.2f} MB")
    print(f"  レコード数: {len(output_df):,}行")
    
    # レポート
    report_lines = []
    report_lines.append("=" * 80)
    report_lines.append("Phase 5: アンサンブル統合 評価レポート")
    report_lines.append("=" * 80)
    report_lines.append("")
    report_lines.append("生成日時: 2026-02-22")
    report_lines.append("")
    report_lines.append("【使用モデル】")
    report_lines.append("  - Phase 3: 二値分類モデル（3着内予測）")
    report_lines.append("  - Phase 4-A: ランキングモデル（順位付け）")
    report_lines.append("  - Phase 4-B: 回帰モデル（走破タイム予測）")
    report_lines.append("")
    report_lines.append("【アンサンブル手法】")
    report_lines.append("  - 重み付け平均スコア")
    report_lines.append("  - 重み: 二値分類 30%, ランキング 40%, タイム 30%")
    report_lines.append("")
    report_lines.append("【評価結果】")
    report_lines.append(f"  - 評価レース数: {metrics['total_races']}レース")
    report_lines.append(f"  - 本命的中率（1着）: {metrics['honmei_1st_rate']:.2f}%")
    report_lines.append(f"  - 本命的中率（3着以内）: {metrics['honmei_top3_rate']:.2f}%")
    report_lines.append(f"  - 対抗的中率（1着）: {metrics['taiko_1st_rate']:.2f}%")
    report_lines.append(f"  - 対抗的中率（3着以内）: {metrics['taiko_top3_rate']:.2f}%")
    report_lines.append(f"  - 単穴的中率: {metrics['tansho_rate']:.2f}%")
    report_lines.append(f"  - 3連単的中率: {metrics['sanrentan_rate']:.2f}%")
    report_lines.append("")
    report_lines.append("【成功基準】")
    honmei_1st_pass = "✅" if metrics['honmei_1st_rate'] > 40 else "❌"
    honmei_top3_pass = "✅" if metrics['honmei_top3_rate'] > 40 else "❌"
    taiko_1st_pass = "✅" if metrics['taiko_1st_rate'] > 30 else "❌"
    taiko_top3_pass = "✅" if metrics['taiko_top3_rate'] > 30 else "❌"
    sanrentan_pass = "✅" if metrics['sanrentan_rate'] > 5 else "❌"
    report_lines.append(f"  - 本命的中率（1着）> 40%: {honmei_1st_pass}")
    report_lines.append(f"  - 本命的中率（3着以内）> 40%: {honmei_top3_pass}")
    report_lines.append(f"  - 対抗的中率（1着）> 30%: {taiko_1st_pass}")
    report_lines.append(f"  - 対抗的中率（3着以内）> 30%: {taiko_top3_pass}")
    report_lines.append(f"  - 3連単的中率 > 5%: {sanrentan_pass}")
    report_lines.append("")
    report_lines.append("=" * 80)
    
    report_text = "\n".join(report_lines)
    
    report_path = 'results/phase5_ensemble_report.txt'
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write(report_text)
    
    print(f"✅ レポート保存: {report_path}")

if __name__ == '__main__':
    print("\n" + "=" * 80)
    print("🏇 JRA競馬AI - Phase 5: アンサンブル統合")
    print("=" * 80)
    print("\n目標: 本命 > 40%, 対抗 > 30%, 3連単 > 5%\n")
    
    try:
        # 1. モデル読み込み
        models = load_models()
        
        # 2. テストデータ準備
        test_df, feature_cols = prepare_test_data()
        
        # 3. アンサンブル予測
        result_df = ensemble_predict(models, test_df, feature_cols)
        
        # 4. 精度評価
        metrics = evaluate_predictions(result_df)
        
        # 5. 結果保存
        save_predictions(result_df, metrics)
        
        print("\n" + "=" * 80)
        print("✅ Phase 5 完了!")
        print("=" * 80)
        print("\n🎯 JRA競馬AI予想システム完成！\n")
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
