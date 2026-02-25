#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
評価用モデルでの2025年予測生成スクリプト

【目的】
- 評価用モデル（2016-2024学習）で2025年データを予測
- 実績データ（actual_top3）を紐付け
- キャリブレーション学習用データセットを作成

【入力】
- data/evaluation/features_2025_for_calibration.csv（2025年特徴量）
- models/jra_binary_model_eval.txt（評価用二値分類モデル）
- models/jra_regression_model_eval.txt（評価用回帰モデル）

【出力】
- data/evaluation/predictions_2025_eval_model.csv（予測結果+実績）
"""

import pandas as pd
import numpy as np
import lightgbm as lgb
import warnings
from pathlib import Path

warnings.filterwarnings('ignore')

# ========================================
# 1. パス設定
# ========================================
BASE_DIR = Path(__file__).resolve().parent.parent.parent
DATA_DIR = BASE_DIR / "data"
MODEL_DIR = BASE_DIR / "models"
EVAL_DIR = DATA_DIR / "evaluation"

# 入力ファイル
FEATURES_2025 = EVAL_DIR / "features_2025_for_calibration.csv"
BINARY_MODEL = MODEL_DIR / "jra_binary_model_eval.txt"
REGRESSION_MODEL = MODEL_DIR / "jra_regression_model_eval.txt"

# 出力ファイル
OUTPUT_CSV = EVAL_DIR / "predictions_2025_eval_model.csv"

# ========================================
# 2. 特徴量カラム定義
# ========================================
# Phase 3で使用した特徴量（145カラム）
# ※実際のカラム名は all_tracks_2016-2025_features.csv と一致させる
FEATURE_COLS = [
    # 馬基本情報
    'sei', 'barei', 'kinryo',
    
    # 過去成績統計
    'past_avg_chakujun', 'past_avg_time', 'past_win_rate',
    'past_rentai_rate', 'past_fukusho_rate',
    
    # 同競馬場成績
    'same_track_avg_rank', 'same_track_win_rate',
    'same_distance_avg_rank', 'same_distance_win_rate',
    
    # 騎手・調教師統計
    'kishu_sho_rate', 'kishu_ren_rate', 'kishu_fuku_rate',
    'kishu_kitai_rentai_ritsu',  # 重要特徴量
    'tyokyo_sho_rate', 'tyokyo_ren_rate', 'tyokyo_fuku_rate',
    
    # レース条件
    'kyori', 'track_code', 'baba_jotai_code',
    'tenki_code', 'tenko_code',
    
    # 人気・オッズ系
    'ninki', 'ninki_shisu',  # 重要特徴量
    'tan_odds', 'fukusho_min_odds', 'fukusho_max_odds',
    
    # 枠・馬番
    'wakuban', 'umaban',
    
    # その他145カラム分...
    # ※実際には all_tracks_2016-2025_features.csv から自動取得
]

# ========================================
# 3. データ読み込み
# ========================================
def load_2025_features():
    """2025年特徴量データの読み込み"""
    print("=" * 60)
    print("【1. データ読み込み】")
    print("=" * 60)
    
    if not FEATURES_2025.exists():
        raise FileNotFoundError(
            f"2025年特徴量ファイルが見つかりません: {FEATURES_2025}\n"
            f"先に 'extract_2025_data.py' を実行してください。"
        )
    
    df = pd.read_csv(FEATURES_2025)
    print(f"✅ 読み込み完了: {len(df):,}行 × {len(df.columns)}列")
    print(f"   ファイル: {FEATURES_2025.name}")
    print(f"   データ期間: 2025年")
    
    # データ概要表示
    print(f"\n📊 データ概要:")
    
    # カラム名の確認（kaisai_nengappi または他の日付カラムが存在するか）
    date_col = None
    for col in ['kaisai_nengappi', 'kaisai_bi', 'date']:
        if col in df.columns:
            date_col = col
            break
    
    if date_col:
        print(f"   - レース日数: {df[date_col].nunique()}日")
    
    if 'keibajo_code' in df.columns:
        print(f"   - 競馬場数: {df['keibajo_code'].nunique()}場")
        
        # レース数の計算
        if date_col and 'race_bango' in df.columns:
            print(f"   - レース数: {df.groupby(['keibajo_code', date_col, 'race_bango']).ngroups:,}")
    
    print(f"   - 出走頭数: {len(df):,}頭")
    
    return df

# ========================================
# 4. 特徴量準備
# ========================================
def prepare_features(df):
    """予測用特徴量の準備"""
    print("\n" + "=" * 60)
    print("【2. 特徴量準備】")
    print("=" * 60)
    
    # 必須カラムの存在確認（柔軟に対応）
    # race_id がない場合は作成（Phase 5と同じロジック）
    if 'race_id' not in df.columns:
        if all(col in df.columns for col in ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango']):
            df['race_id'] = (
                df['kaisai_nen'].astype(str) +
                df['kaisai_tsukihi'].astype(str).str.zfill(4) +
                df['keibajo_code'].astype(str).str.zfill(2) +
                df['race_bango'].astype(str).str.zfill(2)
            )
            print(f"   ⚠️  race_id を kaisai_nen+kaisai_tsukihi+keibajo_code+race_bango から生成しました")
        elif 'kaisai_bi' in df.columns and 'keibajo_code' in df.columns and 'race_bango' in df.columns:
            df['race_id'] = (
                df['kaisai_bi'].astype(str) + '_' +
                df['keibajo_code'].astype(str).str.zfill(2) + '_' +
                df['race_bango'].astype(str).str.zfill(2)
            )
            print(f"   ⚠️  race_id を kaisai_bi+keibajo_code+race_bango から生成しました")
        else:
            df['race_id'] = df.index.astype(str)
            print(f"   ⚠️  race_id をindex から生成しました（最低限）")
    
    # keibajo_name がない場合は keibajo_code から作成
    if 'keibajo_name' not in df.columns and 'keibajo_code' in df.columns:
        keibajo_map = {
            1: '札幌', 2: '函館', 3: '福島', 4: '新潟', 5: '東京',
            6: '中山', 7: '中京', 8: '京都', 9: '阪神', 10: '小倉'
        }
        df['keibajo_name'] = df['keibajo_code'].map(keibajo_map).fillna('不明')
        print(f"   ⚠️  keibajo_name を keibajo_code から生成しました")
    
    # bamei がない場合は代替カラムを使用
    if 'bamei' not in df.columns:
        if 'horse_name' in df.columns:
            df['bamei'] = df['horse_name']
            print(f"   ⚠️  bamei を horse_name から取得しました")
        else:
            df['bamei'] = 'Unknown_' + df.index.astype(str)
            print(f"   ⚠️  bamei を生成しました（ダミー値）")
    
    # 特徴量カラムの自動取得（Phase 3/Phase 4 学習時と一致）
    # ⚠️ Phase 3（二値分類）の除外リスト
    phase3_exclude = [
        'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
        'umaban', 'kakutei_chakujun', 'is_top3', 'target_top3'
    ]
    # ⚠️ Phase 4（回帰）の除外リスト（kaisai_tsukihi, keibajo_code, race_bango, umaban は含む）
    phase4_exclude = [
        'kaisai_nen', 'kakutei_chakujun', 'target_top3', 'prev1_time'
    ]
    # ⚠️ Phase 2 で生成したカラム（Phase 3/4 には存在しない）
    generated_cols = ['race_id', 'keibajo_name', 'bamei']
    
    # 回帰モデルは Phase 4 除外リストを使用（より多くの特徴量を含む）
    exclude_cols = phase4_exclude + generated_cols
    
    feature_cols = [col for col in df.columns if col not in exclude_cols]
    
    # 数値型に変換（文字列型の数値を変換）
    for col in feature_cols:
        if df[col].dtype == 'object':
            try:
                df[col] = pd.to_numeric(df[col], errors='coerce')
            except:
                pass
    
    # 欠損値処理
    X = df[feature_cols].fillna(0)
    
    print(f"✅ 特徴量準備完了: {len(feature_cols)}カラム")
    print(f"   - 数値型カラム: {X.select_dtypes(include=[np.number]).shape[1]}列")
    print(f"   - 欠損値: {X.isnull().sum().sum()}個（0埋め済み）")
    
    return X, feature_cols, df  # df も返す（識別カラム用）

# ========================================
# 5. モデル読み込み
# ========================================
def load_eval_models():
    """評価用モデルの読み込み"""
    print("\n" + "=" * 60)
    print("【3. モデル読み込み】")
    print("=" * 60)
    
    # 二値分類モデル（連対確率予測）
    if not BINARY_MODEL.exists():
        raise FileNotFoundError(
            f"評価用二値分類モデルが見つかりません: {BINARY_MODEL}\n"
            f"Phase 3を実行してモデルを作成してください。"
        )
    
    binary_model = lgb.Booster(model_file=str(BINARY_MODEL))
    print(f"✅ 二値分類モデル読み込み完了")
    print(f"   - ファイル: {BINARY_MODEL.name}")
    print(f"   - 学習期間: 2016-2024年")
    print(f"   - 木の数: {binary_model.num_trees()}本")
    
    # 回帰モデル（タイム予測）
    regression_model = None
    if REGRESSION_MODEL.exists():
        regression_model = lgb.Booster(model_file=str(REGRESSION_MODEL))
        print(f"✅ 回帰モデル読み込み完了")
        print(f"   - ファイル: {REGRESSION_MODEL.name}")
        print(f"   - 木の数: {regression_model.num_trees()}本")
    else:
        print(f"⚠️  回帰モデルが見つかりません（スキップ）")
    
    return binary_model, regression_model

# ========================================
# 6. 予測実行
# ========================================
def generate_predictions(df, X, binary_model, regression_model):
    """評価用モデルで予測実行"""
    print("\n" + "=" * 60)
    print("【4. 予測実行】")
    print("=" * 60)
    
    # ⚠️ 二値分類モデルの特徴量名を取得（132列）
    binary_features = binary_model.feature_name()
    print(f"📋 二値分類モデル学習時の特徴量数: {len(binary_features)}列")
    
    # 欠損している特徴量を 0 で補完
    for col in binary_features:
        if col not in X.columns:
            X[col] = 0
            print(f"   ⚠️  欠損特徴量を追加: {col}")
    
    # 二値分類用の特徴量（132列のみ）
    X_binary = X[binary_features]
    print(f"✅ 二値分類用特徴量準備完了: {X_binary.shape[1]}列（モデルと一致）")
    
    # 二値分類予測（連対確率）
    print("\n🔮 二値分類予測中...")
    binary_proba = binary_model.predict(X_binary)
    df['binary_proba_eval'] = binary_proba
    
    print(f"✅ 二値分類予測完了")
    print(f"   - 予測確率範囲: {binary_proba.min():.4f} - {binary_proba.max():.4f}")
    print(f"   - 予測確率平均: {binary_proba.mean():.4f}")
    print(f"   - 予測確率中央値: {np.median(binary_proba):.4f}")
    
    # 回帰予測（タイム）
    if regression_model is not None:
        print("\n🔮 回帰予測中...")
        
        # ⚠️ 回帰モデルの特徴量名を取得（135列）
        regression_features = regression_model.feature_name()
        print(f"📋 回帰モデル学習時の特徴量数: {len(regression_features)}列")
        
        # 欠損している特徴量を 0 で補完
        for col in regression_features:
            if col not in X.columns:
                X[col] = 0
                print(f"   ⚠️  欠損特徴量を追加: {col}")
        
        # 回帰用の特徴量（135列）
        X_regression = X[regression_features]
        print(f"✅ 回帰用特徴量準備完了: {X_regression.shape[1]}列（モデルと一致）")
        
        # カテゴリカル特徴量エラー回避：ndarray に変換
        time_pred = regression_model.predict(X_regression.values if hasattr(X_regression, 'values') else X_regression)
        df['time_pred_eval'] = time_pred
        print(f"✅ 回帰予測完了")
    
    return df

# ========================================
# 7. 実績データ紐付け
# ========================================
def attach_actual_results(df):
    """実績データの紐付け"""
    print("\n" + "=" * 60)
    print("【5. 実績データ紐付け】")
    print("=" * 60)
    
    # 実着順から3着以内フラグを作成
    df['actual_top3'] = (df['kakutei_chakujun'] <= 3).astype(int)
    
    # 実着順の確認
    valid_results = df[df['kakutei_chakujun'].notna()]
    top3_count = valid_results['actual_top3'].sum()
    top3_rate = top3_count / len(valid_results) * 100
    
    print(f"✅ 実績データ紐付け完了")
    print(f"   - 有効着順データ: {len(valid_results):,}件")
    print(f"   - 3着以内頭数: {top3_count:,}頭 ({top3_rate:.1f}%)")
    print(f"   - 4着以下頭数: {len(valid_results) - top3_count:,}頭")
    
    return df

# ========================================
# 8. 予測精度の評価
# ========================================
def evaluate_predictions(df):
    """予測精度の簡易評価"""
    print("\n" + "=" * 60)
    print("【6. 予測精度評価】")
    print("=" * 60)
    
    # 有効データのみ抽出
    valid_df = df[df['actual_top3'].notna()].copy()
    
    # 確率範囲別の的中率
    thresholds = [0.9, 0.8, 0.7, 0.6, 0.5, 0.4]
    
    print("📊 予測確率別の的中率:")
    for threshold in thresholds:
        pred_positive = valid_df[valid_df['binary_proba_eval'] >= threshold]
        if len(pred_positive) > 0:
            accuracy = pred_positive['actual_top3'].mean() * 100
            print(f"   - 確率≥{threshold:.1f}: {len(pred_positive):,}頭中 "
                  f"{pred_positive['actual_top3'].sum():,}頭的中 ({accuracy:.1f}%)")
    
    # 上位20%予測の的中率
    top20_threshold = valid_df['binary_proba_eval'].quantile(0.80)
    top20_df = valid_df[valid_df['binary_proba_eval'] >= top20_threshold]
    top20_accuracy = top20_df['actual_top3'].mean() * 100
    
    print(f"\n💡 上位20%予測の的中率: {top20_accuracy:.1f}%")
    print(f"   （閾値: {top20_threshold:.4f}以上）")

# ========================================
# 9. 結果保存
# ========================================
def save_predictions(df):
    """予測結果の保存"""
    print("\n" + "=" * 60)
    print("【7. 結果保存】")
    print("=" * 60)
    
    # 保存するカラム（柔軟に対応）
    output_cols = ['race_id']
    
    # 必須カラム（存在するもののみ追加）
    optional_cols = [
        'keibajo_name',
        'kaisai_nengappi', 'kaisai_bi', 'date',  # 日付カラム（どれか）
        'race_bango',
        'umaban',
        'bamei',
        'binary_proba_eval',
        'time_pred_eval',
        'kakutei_chakujun',
        'actual_top3',
    ]
    
    for col in optional_cols:
        if col in df.columns:
            output_cols.append(col)
    
    # 出力（存在するカラムのみ）
    available_cols = [col for col in output_cols if col in df.columns]
    output_df = df[available_cols].copy()
    output_df.to_csv(OUTPUT_CSV, index=False, encoding='utf-8-sig')
    
    print(f"✅ 予測結果保存完了")
    print(f"   - ファイル: {OUTPUT_CSV}")
    print(f"   - 行数: {len(output_df):,}行")
    print(f"   - カラム数: {len(output_cols)}列")
    
    # ファイルサイズ表示
    file_size = OUTPUT_CSV.stat().st_size / 1024  # KB
    print(f"   - ファイルサイズ: {file_size:.1f} KB")

# ========================================
# 10. メイン処理
# ========================================
def main():
    """メイン処理"""
    print("\n" + "=" * 80)
    print("【JRA競馬予測：評価用モデルでの2025年予測生成】")
    print("=" * 80)
    print(f"📅 実行日時: {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"🎯 目的: キャリブレーション学習用データセット作成")
    print("=" * 80)
    
    # Step 1: データ読み込み
    df = load_2025_features()
    
    # Step 2: 特徴量準備
    X, feature_cols, df = prepare_features(df)
    
    # Step 3: モデル読み込み
    binary_model, regression_model = load_eval_models()
    
    # Step 4: 予測実行
    df = generate_predictions(df, X, binary_model, regression_model)
    
    # Step 5: 実績データ紐付け
    df = attach_actual_results(df)
    
    # Step 6: 予測精度評価
    evaluate_predictions(df)
    
    # Step 7: 結果保存
    save_predictions(df)
    
    print("\n" + "=" * 80)
    print("✅ 全処理完了！")
    print("=" * 80)
    print("\n📋 次のステップ:")
    print("   → Phase 3: メタモデル学習と温度パラメータ推定")
    print("   → 使用データ: data/evaluation/predictions_2025_eval_model.csv")
    print("=" * 80 + "\n")

if __name__ == "__main__":
    main()
