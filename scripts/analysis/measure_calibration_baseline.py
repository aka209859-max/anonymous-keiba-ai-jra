#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - キャリブレーションベースライン測定
=============================================================

目的:
    現状の予測スコア分布とキャリブレーション状態を定量的に測定
    改修前のベースライン指標を記録

機能:
    1. Phase 6の予測結果CSVを読み込み
    2. スコア分布の統計量を計算
    3. ヒストグラムとボックスプロットを作成
    4. ベースライン指標をテキストファイルに保存

入力:
    - results/predictions_YYYYMMDD.csv (Phase 6の予測結果)

出力:
    - results/calibration_analysis/baseline_metrics.txt
    - results/calibration_analysis/score_distribution_baseline.png
    - results/calibration_analysis/score_distribution_by_race.png

作成日: 2026-02-25
バージョン: 1.0
"""

import os
import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path
from datetime import datetime

# 日本語フォント設定（Windows環境）
plt.rcParams['font.family'] = 'MS Gothic'
plt.rcParams['axes.unicode_minus'] = False

# ================================================================================
# 設定
# ================================================================================

OUTPUT_DIR = 'results/calibration_analysis'
PREDICTIONS_CSV = 'results/predictions_20260222.csv'

# ================================================================================
# ディレクトリ作成
# ================================================================================

def ensure_output_dir():
    """出力ディレクトリを作成"""
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    print(f"✅ 出力ディレクトリ: {OUTPUT_DIR}")

# ================================================================================
# データ読み込み
# ================================================================================

def load_predictions(csv_path):
    """予測結果CSVを読み込み"""
    print("=" * 80)
    print("📂 予測結果データ読み込み")
    print("=" * 80)
    
    if not os.path.exists(csv_path):
        print(f"❌ ファイルが見つかりません: {csv_path}")
        sys.exit(1)
    
    print(f"読み込み中: {csv_path}")
    df = pd.read_csv(csv_path, encoding='utf-8')
    
    print(f"✅ 読み込み完了")
    print(f"   - 行数: {len(df):,}行")
    print(f"   - 列数: {len(df.columns)}列")
    print(f"   - レース数: {df['race_id'].nunique()}レース")
    
    return df

# ================================================================================
# スコア分布分析
# ================================================================================

def analyze_score_distribution(df):
    """スコア分布の統計量を計算"""
    print("\n" + "=" * 80)
    print("📊 スコア分布分析")
    print("=" * 80)
    
    results = {}
    
    # binary_proba の分布
    if 'binary_proba' in df.columns:
        print("\n[1] binary_proba（二値分類確率）")
        print("-" * 40)
        binary_stats = df['binary_proba'].describe()
        print(binary_stats)
        
        # 高スコア割合
        count_085 = (df['binary_proba'] >= 0.85).sum()
        count_090 = (df['binary_proba'] >= 0.90).sum()
        count_095 = (df['binary_proba'] >= 0.95).sum()
        
        pct_085 = count_085 / len(df) * 100
        pct_090 = count_090 / len(df) * 100
        pct_095 = count_095 / len(df) * 100
        
        print(f"\n≥0.85（Sランク相当）: {count_085}頭 ({pct_085:.1f}%)")
        print(f"≥0.90: {count_090}頭 ({pct_090:.1f}%)")
        print(f"≥0.95: {count_095}頭 ({pct_095:.1f}%)")
        
        results['binary_proba'] = {
            'stats': binary_stats.to_dict(),
            'count_085': count_085,
            'count_090': count_090,
            'count_095': count_095,
            'pct_085': pct_085,
            'pct_090': pct_090,
            'pct_095': pct_095
        }
    
    # ensemble_score の分布
    if 'ensemble_score' in df.columns:
        print("\n[2] ensemble_score（アンサンブルスコア）")
        print("-" * 40)
        ensemble_stats = df['ensemble_score'].describe()
        print(ensemble_stats)
        
        # 高スコア割合
        count_085 = (df['ensemble_score'] >= 0.85).sum()
        count_090 = (df['ensemble_score'] >= 0.90).sum()
        count_095 = (df['ensemble_score'] >= 0.95).sum()
        
        pct_085 = count_085 / len(df) * 100
        pct_090 = count_090 / len(df) * 100
        pct_095 = count_095 / len(df) * 100
        
        print(f"\n≥0.85（Sランク相当）: {count_085}頭 ({pct_085:.1f}%)")
        print(f"≥0.90: {count_090}頭 ({pct_090:.1f}%)")
        print(f"≥0.95: {count_095}頭 ({pct_095:.1f}%)")
        
        results['ensemble_score'] = {
            'stats': ensemble_stats.to_dict(),
            'count_085': count_085,
            'count_090': count_090,
            'count_095': count_095,
            'pct_085': pct_085,
            'pct_090': pct_090,
            'pct_095': pct_095
        }
    
    # レース内での1位馬のスコア分布
    if 'ensemble_score' in df.columns:
        print("\n[3] レース内1位馬のスコア分布")
        print("-" * 40)
        top_scores = df.groupby('race_id')['ensemble_score'].max()
        top_stats = top_scores.describe()
        print(top_stats)
        
        results['top_horse_scores'] = {
            'stats': top_stats.to_dict(),
            'values': top_scores.values.tolist()
        }
    
    # ランク別集計
    if 'score_rank' in df.columns:
        print("\n[4] ランク別集計")
        print("-" * 40)
        rank_counts = df['score_rank'].value_counts().sort_index()
        print(rank_counts)
        print(f"\n合計: {rank_counts.sum()}頭")
        
        results['rank_distribution'] = rank_counts.to_dict()
    
    return results

# ================================================================================
# レース別分析
# ================================================================================

def analyze_by_race(df):
    """レース別のスコア分布を分析"""
    print("\n" + "=" * 80)
    print("🏇 レース別スコア分析")
    print("=" * 80)
    
    race_summary = []
    
    for race_id in df['race_id'].unique():
        race_df = df[df['race_id'] == race_id].copy()
        
        # 基本情報
        keibajo = race_df['keibajo_name'].iloc[0] if 'keibajo_name' in race_df.columns else 'N/A'
        race_bango = race_df['race_bango'].iloc[0] if 'race_bango' in race_df.columns else 'N/A'
        
        # スコア統計
        if 'ensemble_score' in race_df.columns:
            top_score = race_df['ensemble_score'].max()
            avg_score = race_df['ensemble_score'].mean()
            std_score = race_df['ensemble_score'].std()
            count_s_rank = (race_df['ensemble_score'] >= 0.85).sum()
            
            race_summary.append({
                'race_id': race_id,
                'keibajo_name': keibajo,
                'race_bango': race_bango,
                'horse_count': len(race_df),
                'top_score': top_score,
                'avg_score': avg_score,
                'std_score': std_score,
                's_rank_count': count_s_rank
            })
    
    summary_df = pd.DataFrame(race_summary)
    
    if len(summary_df) > 0:
        print(f"\nレース数: {len(summary_df)}")
        print(f"Sランク（≥0.85）頭数の平均: {summary_df['s_rank_count'].mean():.1f}頭/レース")
        print(f"Sランク頭数の範囲: {summary_df['s_rank_count'].min()}-{summary_df['s_rank_count'].max()}頭")
        print(f"\nトップスコアの統計:")
        print(summary_df['top_score'].describe())
    
    return summary_df

# ================================================================================
# 可視化
# ================================================================================

def plot_distributions(df, race_summary_df):
    """スコア分布の可視化"""
    print("\n" + "=" * 80)
    print("📈 可視化作成中...")
    print("=" * 80)
    
    # 図1: スコア分布（ヒストグラムとボックスプロット）
    fig, axes = plt.subplots(2, 3, figsize=(18, 10))
    fig.suptitle('予測スコア分布分析（改修前ベースライン）', fontsize=16, fontweight='bold')
    
    # binary_proba ヒストグラム
    if 'binary_proba' in df.columns:
        axes[0, 0].hist(df['binary_proba'], bins=50, edgecolor='black', color='steelblue', alpha=0.7)
        axes[0, 0].axvline(0.85, color='red', linestyle='--', linewidth=2, label='Sランク閾値 (0.85)')
        axes[0, 0].set_title('binary_proba 分布', fontsize=12, fontweight='bold')
        axes[0, 0].set_xlabel('確率')
        axes[0, 0].set_ylabel('頻度')
        axes[0, 0].legend()
        axes[0, 0].grid(True, alpha=0.3)
    
    # ensemble_score ヒストグラム
    if 'ensemble_score' in df.columns:
        axes[0, 1].hist(df['ensemble_score'], bins=50, edgecolor='black', color='coral', alpha=0.7)
        axes[0, 1].axvline(0.85, color='red', linestyle='--', linewidth=2, label='Sランク閾値 (0.85)')
        axes[0, 1].set_title('ensemble_score 分布', fontsize=12, fontweight='bold')
        axes[0, 1].set_xlabel('スコア')
        axes[0, 1].set_ylabel('頻度')
        axes[0, 1].legend()
        axes[0, 1].grid(True, alpha=0.3)
    
    # レース内1位馬のスコア分布
    if len(race_summary_df) > 0:
        axes[0, 2].hist(race_summary_df['top_score'], bins=30, edgecolor='black', color='mediumseagreen', alpha=0.7)
        axes[0, 2].set_title('レース内1位馬のスコア分布', fontsize=12, fontweight='bold')
        axes[0, 2].set_xlabel('スコア')
        axes[0, 2].set_ylabel('頻度')
        axes[0, 2].grid(True, alpha=0.3)
    
    # binary_proba ボックスプロット
    if 'binary_proba' in df.columns:
        axes[1, 0].boxplot([df['binary_proba']], vert=True, patch_artist=True,
                           boxprops=dict(facecolor='steelblue', alpha=0.7))
        axes[1, 0].axhline(0.85, color='red', linestyle='--', linewidth=2)
        axes[1, 0].set_title('binary_proba ボックスプロット', fontsize=12, fontweight='bold')
        axes[1, 0].set_ylabel('確率')
        axes[1, 0].set_xticklabels(['binary_proba'])
        axes[1, 0].grid(True, alpha=0.3, axis='y')
    
    # ensemble_score ボックスプロット
    if 'ensemble_score' in df.columns:
        axes[1, 1].boxplot([df['ensemble_score']], vert=True, patch_artist=True,
                           boxprops=dict(facecolor='coral', alpha=0.7))
        axes[1, 1].axhline(0.85, color='red', linestyle='--', linewidth=2)
        axes[1, 1].set_title('ensemble_score ボックスプロット', fontsize=12, fontweight='bold')
        axes[1, 1].set_ylabel('スコア')
        axes[1, 1].set_xticklabels(['ensemble_score'])
        axes[1, 1].grid(True, alpha=0.3, axis='y')
    
    # Sランク頭数/レース
    if len(race_summary_df) > 0:
        axes[1, 2].hist(race_summary_df['s_rank_count'], bins=range(0, int(race_summary_df['s_rank_count'].max()) + 2),
                        edgecolor='black', color='gold', alpha=0.7)
        axes[1, 2].set_title('Sランク（≥0.85）頭数/レース', fontsize=12, fontweight='bold')
        axes[1, 2].set_xlabel('Sランク頭数')
        axes[1, 2].set_ylabel('レース数')
        axes[1, 2].grid(True, alpha=0.3)
    
    plt.tight_layout()
    output_path = os.path.join(OUTPUT_DIR, 'score_distribution_baseline.png')
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    print(f"✅ 保存: {output_path}")
    plt.close()
    
    # 図2: レース別スコア分布
    if len(race_summary_df) > 0:
        fig, axes = plt.subplots(1, 2, figsize=(16, 6))
        fig.suptitle('レース別スコア分析', fontsize=16, fontweight='bold')
        
        # レース別トップスコア
        race_ids = range(len(race_summary_df))
        axes[0].bar(race_ids, race_summary_df['top_score'], color='steelblue', alpha=0.7, edgecolor='black')
        axes[0].axhline(0.85, color='red', linestyle='--', linewidth=2, label='Sランク閾値')
        axes[0].set_title('レース別トップスコア', fontsize=12, fontweight='bold')
        axes[0].set_xlabel('レースID')
        axes[0].set_ylabel('トップスコア')
        axes[0].legend()
        axes[0].grid(True, alpha=0.3, axis='y')
        
        # レース別平均スコア vs 標準偏差
        axes[1].scatter(race_summary_df['avg_score'], race_summary_df['std_score'], 
                       s=100, alpha=0.6, c=race_summary_df['s_rank_count'], 
                       cmap='YlOrRd', edgecolors='black')
        axes[1].set_title('レース別：平均スコア vs 標準偏差', fontsize=12, fontweight='bold')
        axes[1].set_xlabel('平均スコア')
        axes[1].set_ylabel('標準偏差')
        axes[1].grid(True, alpha=0.3)
        cbar = plt.colorbar(axes[1].collections[0], ax=axes[1])
        cbar.set_label('Sランク頭数', rotation=270, labelpad=15)
        
        plt.tight_layout()
        output_path = os.path.join(OUTPUT_DIR, 'score_distribution_by_race.png')
        plt.savefig(output_path, dpi=150, bbox_inches='tight')
        print(f"✅ 保存: {output_path}")
        plt.close()

# ================================================================================
# レポート保存
# ================================================================================

def save_baseline_report(results, race_summary_df):
    """ベースライン指標をテキストファイルに保存"""
    print("\n" + "=" * 80)
    print("💾 ベースラインレポート保存中...")
    print("=" * 80)
    
    report_path = os.path.join(OUTPUT_DIR, 'baseline_metrics.txt')
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("JRA競馬予測システム - キャリブレーションベースライン指標\n")
        f.write("=" * 80 + "\n")
        f.write(f"測定日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"対象データ: {PREDICTIONS_CSV}\n")
        f.write("=" * 80 + "\n\n")
        
        # binary_proba
        if 'binary_proba' in results:
            f.write("[1] binary_proba（二値分類確率）\n")
            f.write("-" * 40 + "\n")
            stats = results['binary_proba']['stats']
            f.write(f"平均: {stats['mean']:.4f}\n")
            f.write(f"標準偏差: {stats['std']:.4f}\n")
            f.write(f"最小値: {stats['min']:.4f}\n")
            f.write(f"25%点: {stats['25%']:.4f}\n")
            f.write(f"中央値: {stats['50%']:.4f}\n")
            f.write(f"75%点: {stats['75%']:.4f}\n")
            f.write(f"最大値: {stats['max']:.4f}\n\n")
            f.write(f"≥0.85（Sランク相当）: {results['binary_proba']['count_085']}頭 ({results['binary_proba']['pct_085']:.1f}%)\n")
            f.write(f"≥0.90: {results['binary_proba']['count_090']}頭 ({results['binary_proba']['pct_090']:.1f}%)\n")
            f.write(f"≥0.95: {results['binary_proba']['count_095']}頭 ({results['binary_proba']['pct_095']:.1f}%)\n\n")
        
        # ensemble_score
        if 'ensemble_score' in results:
            f.write("[2] ensemble_score（アンサンブルスコア）\n")
            f.write("-" * 40 + "\n")
            stats = results['ensemble_score']['stats']
            f.write(f"平均: {stats['mean']:.4f}\n")
            f.write(f"標準偏差: {stats['std']:.4f}\n")
            f.write(f"最小値: {stats['min']:.4f}\n")
            f.write(f"25%点: {stats['25%']:.4f}\n")
            f.write(f"中央値: {stats['50%']:.4f}\n")
            f.write(f"75%点: {stats['75%']:.4f}\n")
            f.write(f"最大値: {stats['max']:.4f}\n\n")
            f.write(f"≥0.85（Sランク相当）: {results['ensemble_score']['count_085']}頭 ({results['ensemble_score']['pct_085']:.1f}%)\n")
            f.write(f"≥0.90: {results['ensemble_score']['count_090']}頭 ({results['ensemble_score']['pct_090']:.1f}%)\n")
            f.write(f"≥0.95: {results['ensemble_score']['count_095']}頭 ({results['ensemble_score']['pct_095']:.1f}%)\n\n")
        
        # レース別分析
        if len(race_summary_df) > 0:
            f.write("[3] レース別分析\n")
            f.write("-" * 40 + "\n")
            f.write(f"レース数: {len(race_summary_df)}\n")
            f.write(f"Sランク（≥0.85）頭数の平均: {race_summary_df['s_rank_count'].mean():.1f}頭/レース\n")
            f.write(f"Sランク頭数の範囲: {race_summary_df['s_rank_count'].min()}-{race_summary_df['s_rank_count'].max()}頭\n\n")
            f.write("トップスコアの統計:\n")
            top_stats = race_summary_df['top_score'].describe()
            f.write(f"  平均: {top_stats['mean']:.4f}\n")
            f.write(f"  標準偏差: {top_stats['std']:.4f}\n")
            f.write(f"  最小値: {top_stats['min']:.4f}\n")
            f.write(f"  最大値: {top_stats['max']:.4f}\n\n")
        
        # ランク分布
        if 'rank_distribution' in results:
            f.write("[4] ランク分布\n")
            f.write("-" * 40 + "\n")
            for rank, count in sorted(results['rank_distribution'].items()):
                f.write(f"{rank}: {count}頭\n")
            f.write("\n")
        
        f.write("=" * 80 + "\n")
        f.write("📝 備考\n")
        f.write("=" * 80 + "\n")
        f.write("このベースライン指標は、キャリブレーション改修前の状態を記録したものです。\n")
        f.write("改修後にこの指標と比較することで、改善効果を定量的に評価します。\n\n")
        f.write("【問題点】\n")
        f.write("- スコアが0.85-0.99に極端に集中\n")
        f.write("- Sランク（≥0.85）の頭数が多すぎる（目標: 1-2頭/レース）\n")
        f.write("- レース間の絶対評価ができない\n\n")
        f.write("【改修目標】\n")
        f.write("- スコア分布: 0.10-0.90に拡散\n")
        f.write("- Sランク頭数: 1-2頭/レース\n")
        f.write("- Brier Score: < 0.18\n")
        f.write("=" * 80 + "\n")
    
    print(f"✅ 保存: {report_path}")

# ================================================================================
# メイン処理
# ================================================================================

def main():
    """メイン処理"""
    print("\n" + "=" * 80)
    print("🎯 JRA競馬予測システム - キャリブレーションベースライン測定")
    print("=" * 80)
    print(f"開始時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    # 出力ディレクトリ作成
    ensure_output_dir()
    
    # データ読み込み
    df = load_predictions(PREDICTIONS_CSV)
    
    # スコア分布分析
    results = analyze_score_distribution(df)
    
    # レース別分析
    race_summary_df = analyze_by_race(df)
    
    # 可視化
    plot_distributions(df, race_summary_df)
    
    # レポート保存
    save_baseline_report(results, race_summary_df)
    
    print("\n" + "=" * 80)
    print("✅ ベースライン測定完了！")
    print("=" * 80)
    print(f"終了時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("\n次のステップ:")
    print("  1. results/calibration_analysis/ 内の画像を確認")
    print("  2. baseline_metrics.txt で指標を確認")
    print("  3. Phase 2（評価用データセット準備）へ進む")
    print("=" * 80 + "\n")

if __name__ == '__main__':
    main()
