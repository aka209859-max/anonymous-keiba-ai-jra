#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 2C結果をランク別に集計・分析
"""
import pandas as pd
import sys

def analyze_by_rank(csv_path, bet_type):
    """ランク別にオッズ範囲ごとの結果を集計"""
    df = pd.read_csv(csv_path)
    
    # 100倍以上を除外
    if bet_type == 'tansho':
        df = df[df['tansho_odds_band'] != '100.0+']
    else:
        df = df[df['fukusho_odds_band'] != '20.0+']
    
    print(f"\n{'=' * 80}")
    print(f"{'単勝' if bet_type == 'tansho' else '複勝'} - ランク別オッズ範囲分析（100倍以上除外）")
    print('=' * 80)
    
    ranks = ['S', 'A', 'B', 'C', 'D', 'E']
    
    for rank in ranks:
        rank_df = df[df['hensachi_rank'] == rank].copy()
        
        if len(rank_df) == 0:
            continue
            
        print(f"\n■ 偏差値ランク: {rank}")
        print("-" * 80)
        
        # オッズ帯でソート
        odds_col = 'tansho_odds_band' if bet_type == 'tansho' else 'fukusho_odds_band'
        
        # オッズ帯を数値順にソート
        def sort_key(odds):
            if '-' in odds:
                return float(odds.split('-')[0])
            else:
                return float(odds.replace('+', ''))
        
        rank_df['sort_key'] = rank_df[odds_col].apply(sort_key)
        rank_df = rank_df.sort_values('sort_key')
        
        for _, row in rank_df.iterrows():
            odds_band = row[odds_col]
            target = int(row['target_count'])
            hit = int(row['hit_count'])
            hit_rate = row['hit_rate']
            recovery = row['recovery_rate']
            roi = row['roi']
            rec = row['recommendation']
            
            print(f"  オッズ {odds_band:12s} | "
                  f"対象:{target:5d}頭 | "
                  f"的中:{hit:4d}頭 ({hit_rate:5.1f}%) | "
                  f"回収率:{recovery:6.1f}% | "
                  f"ROI:{roi:+7.1f}% | "
                  f"{rec}")
        
        # ランク別サマリー
        total_target = rank_df['target_count'].sum()
        total_hit = rank_df['hit_count'].sum()
        total_investment = rank_df['total_investment'].sum()
        total_payout = rank_df['total_payout'].sum()
        avg_hit_rate = (total_hit / total_target * 100) if total_target > 0 else 0
        avg_recovery = (total_payout / total_investment * 100) if total_investment > 0 else 0
        avg_roi = avg_recovery - 100
        
        print(f"\n  【{rank}ランク合計】")
        print(f"    対象馬数: {int(total_target):,}頭")
        print(f"    的中数: {int(total_hit):,}頭")
        print(f"    平均的中率: {avg_hit_rate:.1f}%")
        print(f"    平均回収率: {avg_recovery:.1f}%")
        print(f"    平均ROI: {avg_roi:+.1f}%")

if __name__ == '__main__':
    tansho_path = '/home/user/uploaded_files/tansho_hensachi_odds_matrix.csv'
    fukusho_path = '/home/user/uploaded_files/fukusho_hensachi_odds_matrix.csv'
    
    analyze_by_rank(tansho_path, 'tansho')
    analyze_by_rank(fukusho_path, 'fukusho')
    
    print("\n" + "=" * 80)
    print("分析完了")
    print("=" * 80)
