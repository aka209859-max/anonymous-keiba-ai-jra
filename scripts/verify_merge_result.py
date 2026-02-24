#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-C: 結合結果検証スクリプト
血統登録番号の形式を確認し、不一致の原因を診断します。
"""

import pandas as pd
from pathlib import Path

def main():
    print("="*80)
    print("Phase 1-C 結合結果検証")
    print("="*80)
    
    # データ読み込み
    file_path = Path('data/raw/jravan_jrdb_merged.csv')
    print(f"\n📖 データ読み込み: {file_path}")
    
    df = pd.read_csv(file_path, dtype=str)
    
    print(f"\n📊 基本情報:")
    print(f"   総レコード数: {len(df):,}件")
    print(f"   総列数: {len(df.columns)}列")
    
    # 列名表示（最初の30列）
    print(f"\n📋 列名（最初の30列）:")
    for i, col in enumerate(df.columns[:30], 1):
        print(f"   {i:2d}. {col}")
    
    # 血統登録番号列を特定
    ketto_cols = [col for col in df.columns if 'ketto_toroku_bango' in col]
    print(f"\n🔍 血統登録番号列:")
    for col in ketto_cols:
        print(f"   • {col}")
    
    if len(ketto_cols) < 2:
        print(f"\n⚠️  血統登録番号列が2つ見つかりません")
        return
    
    # JRA-VAN と JRDB の列を特定
    jravan_col = next((col for col in ketto_cols if 'jravan' in col), ketto_cols[0])
    jrdb_col = next((col for col in ketto_cols if 'jrdb' in col), ketto_cols[1])
    
    print(f"\n   JRA-VAN列: {jravan_col}")
    print(f"   JRDB列: {jrdb_col}")
    
    # サンプルデータ表示
    print(f"\n📋 サンプルデータ（最初の5行）:")
    sample_cols = ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'kaisai_kai', 
                   'kaisai_nichime', 'race_bango', 'umaban', jravan_col, jrdb_col]
    
    existing_cols = [col for col in sample_cols if col in df.columns]
    
    for i, row in df[existing_cols].head(5).iterrows():
        print(f"\n   行 {i+1}:")
        for col in existing_cols:
            print(f"      {col}: {row[col]}")
    
    # 血統登録番号の詳細比較
    print(f"\n🔬 血統登録番号の詳細比較（最初の10行）:")
    for i, row in df[[jravan_col, jrdb_col]].head(10).iterrows():
        jravan_val = row[jravan_col]
        jrdb_val = row[jrdb_col]
        match = "✅" if jravan_val == jrdb_val else "❌"
        print(f"   {i+1}. {match} JRA-VAN: '{jravan_val}' (長さ: {len(jravan_val)}) "
              f"vs JRDB: '{jrdb_val}' (長さ: {len(jrdb_val)})")
        
        # 末尾6桁が一致するか確認
        if len(jravan_val) >= 6 and len(jrdb_val) >= 6:
            jravan_last6 = jravan_val[-6:]
            jrdb_last6 = jrdb_val[-6:]
            if jravan_last6 == jrdb_last6:
                print(f"       💡 末尾6桁は一致: {jravan_last6}")
    
    # 桁数分布
    print(f"\n📊 血統登録番号の桁数分布:")
    jravan_lengths = df[jravan_col].str.len().value_counts().sort_index()
    jrdb_lengths = df[jrdb_col].str.len().value_counts().sort_index()
    
    print(f"\n   JRA-VAN:")
    for length, count in jravan_lengths.items():
        print(f"      {length}桁: {count:,}件")
    
    print(f"\n   JRDB:")
    for length, count in jrdb_lengths.items():
        print(f"      {length}桁: {count:,}件")
    
    # NULL値チェック
    print(f"\n🔍 NULL値チェック:")
    print(f"   JRA-VAN NULL数: {df[jravan_col].isna().sum():,}件")
    print(f"   JRDB NULL数: {df[jrdb_col].isna().sum():,}件")
    
    # ユニーク値数
    print(f"\n📊 ユニーク値数:")
    print(f"   JRA-VAN: {df[jravan_col].nunique():,}件")
    print(f"   JRDB: {df[jrdb_col].nunique():,}件")
    
    print("\n✅ 検証完了")

if __name__ == '__main__':
    main()
