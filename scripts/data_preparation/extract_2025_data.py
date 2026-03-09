#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI予想システム - 2025年データ抽出
=============================================================

目的:
    all_tracks_2016-2025_features.csv から2025年データのみを抽出
    キャリブレーション用の評価データセットを作成

機能:
    1. 全年度の特徴量データを読み込み
    2. 2025年（kaisai_nen='2025'）のみフィルタ
    3. 評価用データセットとして保存

入力:
    - data/features/all_tracks_2016-2025_features.csv

出力:
    - data/evaluation/features_2025_for_calibration.csv

作成日: 2026-02-25
バージョン: 1.0
"""

import os
import sys
import pandas as pd
import numpy as np
from pathlib import Path
from datetime import datetime

# ================================================================================
# 設定
# ================================================================================

INPUT_CSV = 'data/features/all_tracks_2016-2025_features.csv'
OUTPUT_DIR = 'data/evaluation'
OUTPUT_CSV = 'data/evaluation/features_2025_for_calibration.csv'

# ================================================================================
# ディレクトリ作成
# ================================================================================

def ensure_output_dir():
    """出力ディレクトリを作成"""
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    print(f"✅ 出力ディレクトリ: {OUTPUT_DIR}")

# ================================================================================
# データ読み込みと抽出
# ================================================================================

def extract_2025_data(input_csv, output_csv):
    """
    全年度データから2025年のみを抽出
    
    Parameters:
    -----------
    input_csv : str
        入力CSVファイルパス
    output_csv : str
        出力CSVファイルパス
    """
    print("=" * 80)
    print("📂 特徴量データ読み込み")
    print("=" * 80)
    
    if not os.path.exists(input_csv):
        print(f"❌ ファイルが見つかりません: {input_csv}")
        sys.exit(1)
    
    print(f"読み込み中: {input_csv}")
    print("⏳ 処理中... (大容量ファイルのため時間がかかります)")
    
    # 混合型カラムの警告を抑制
    df = pd.read_csv(input_csv, encoding='utf-8', low_memory=False)
    
    print(f"✅ 全データ読み込み完了")
    print(f"   - 全体行数: {len(df):,}行")
    print(f"   - 列数: {len(df.columns)}列")
    print(f"   - ファイルサイズ: {os.path.getsize(input_csv) / (1024**2):.1f} MB")
    
    # kaisai_nen カラムの確認
    if 'kaisai_nen' not in df.columns:
        print("\n❌ エラー: 'kaisai_nen' カラムが見つかりません")
        print(f"利用可能なカラム（最初の20個）:")
        print(df.columns.tolist()[:20])
        sys.exit(1)
    
    # 年度別の件数確認
    print("\n" + "=" * 80)
    print("📊 年度別データ件数")
    print("=" * 80)
    
    year_counts = df['kaisai_nen'].value_counts().sort_index()
    for year, count in year_counts.items():
        print(f"   {year}年: {count:,}行")
    
    # 2025年のみフィルタ
    print("\n" + "=" * 80)
    print("🔍 2025年データ抽出")
    print("=" * 80)
    
    # kaisai_nen を文字列型に変換して比較
    df['kaisai_nen'] = df['kaisai_nen'].astype(str)
    df_2025 = df[df['kaisai_nen'] == '2025'].copy()
    
    if len(df_2025) == 0:
        print("❌ エラー: 2025年のデータが見つかりません")
        print("\nkaisai_nen の値の例（最初の10件）:")
        print(df['kaisai_nen'].head(10).tolist())
        sys.exit(1)
    
    print(f"✅ 2025年データ抽出完了: {len(df_2025):,}行")
    
    # 基本統計情報
    print("\n[2025年データの基本情報]")
    if 'keibajo_code' in df_2025.columns:
        print("  競馬場別:")
        keibajo_counts = df_2025['keibajo_code'].value_counts().sort_index()
        for code, count in keibajo_counts.items():
            print(f"    競馬場コード {code}: {count:,}頭")
    
    if 'kaisai_tsukihi' in df_2025.columns:
        print(f"  開催日数: {df_2025['kaisai_tsukihi'].nunique()}日")
    
    # 保存
    print("\n" + "=" * 80)
    print("💾 2025年データ保存中...")
    print("=" * 80)
    
    df_2025.to_csv(output_csv, index=False, encoding='utf-8')
    
    output_size = os.path.getsize(output_csv) / (1024**2)
    print(f"✅ 保存完了: {output_csv}")
    print(f"   - 行数: {len(df_2025):,}行")
    print(f"   - 列数: {len(df_2025.columns)}列")
    print(f"   - ファイルサイズ: {output_size:.1f} MB")
    
    return df_2025

# ================================================================================
# メイン処理
# ================================================================================

def main():
    """メイン処理"""
    print("\n" + "=" * 80)
    print("🎯 JRA競馬AI予想システム - 2025年データ抽出")
    print("=" * 80)
    print(f"開始時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    # 出力ディレクトリ作成
    ensure_output_dir()
    
    # 2025年データ抽出
    df_2025 = extract_2025_data(INPUT_CSV, OUTPUT_CSV)
    
    print("\n" + "=" * 80)
    print("✅ 2025年データ抽出完了！")
    print("=" * 80)
    print(f"終了時刻: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("\n次のステップ:")
    print("  1. 評価用モデルで2025年を予測")
    print("     → scripts/evaluation/generate_eval_predictions.py")
    print("  2. キャリブレーション用データセットの準備完了")
    print("=" * 80 + "\n")

if __name__ == '__main__':
    main()
