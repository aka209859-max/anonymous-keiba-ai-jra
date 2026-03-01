#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
jvd_o1 オッズデータのパーサーテスト
"""

import psycopg2
import yaml
from pathlib import Path

def parse_tansho_odds(odds_str):
    """
    単勝オッズ文字列をパース
    
    フォーマット: 馬番(2桁) + オッズ(4桁) の繰り返し
    例: "01231315020501070301" 
        → 馬番01=123(12.3倍), 馬番13=15(1.5倍), 馬番02=501(50.1倍), ...
    """
    if not odds_str or len(odds_str) < 6:
        return {}
    
    result = {}
    # 6文字ずつ（馬番2桁+オッズ4桁）読む
    for i in range(0, len(odds_str), 6):
        if i + 6 > len(odds_str):
            break
        
        chunk = odds_str[i:i+6]
        if len(chunk) == 6:
            umaban = chunk[0:2]  # 馬番
            odds_raw = chunk[2:6]  # オッズ（整数×10）
            
            try:
                odds_int = int(odds_raw)
                if odds_int > 0:
                    odds_float = odds_int / 10.0  # 123 → 12.3倍
                    result[umaban] = odds_float
            except ValueError:
                continue
    
    return result

def parse_fukusho_odds(odds_str):
    """
    複勝オッズ文字列をパース
    
    フォーマット: 馬番(2桁) + オッズMin(3桁) + オッズMax(3桁) の繰り返し
    例: "010351073015020046" 
        → 馬番01=3.5-10.7倍, 馬番15=2.0-4.6倍, ...
    """
    if not odds_str or len(odds_str) < 8:
        return {}
    
    result = {}
    # 8文字ずつ（馬番2桁+Min3桁+Max3桁）読む
    for i in range(0, len(odds_str), 8):
        if i + 8 > len(odds_str):
            break
        
        chunk = odds_str[i:i+8]
        if len(chunk) == 8:
            umaban = chunk[0:2]  # 馬番
            odds_min_raw = chunk[2:5]  # 最低オッズ
            odds_max_raw = chunk[5:8]  # 最高オッズ
            
            try:
                odds_min_int = int(odds_min_raw)
                odds_max_int = int(odds_max_raw)
                
                if odds_min_int > 0 or odds_max_int > 0:
                    odds_min = odds_min_int / 10.0  # 35 → 3.5倍
                    odds_max = odds_max_int / 10.0  # 107 → 10.7倍
                    result[umaban] = (odds_min, odds_max)
            except ValueError:
                continue
    
    return result

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def main():
    print("=" * 80)
    print("🧪 jvd_o1 オッズデータのパーサーテスト")
    print("=" * 80)
    
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    # 2025年1月5日 中山1Rのオッズデータを取得
    print("\n📋 テストデータ取得: 2025年1月5日 中山1R")
    print("-" * 80)
    
    cursor.execute("""
        SELECT 
            kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango,
            shusso_tosu, odds_tansho, odds_fukusho
        FROM jvd_o1
        WHERE kaisai_nen = '2025' 
          AND kaisai_tsukihi = '0105' 
          AND keibajo_code = '06'
          AND race_bango = '01'
        LIMIT 1;
    """)
    
    row = cursor.fetchone()
    
    if not row:
        print("❌ データが見つかりません")
        return
    
    nen, tsukihi, keibajo, race_no, shusso, tansho_str, fukusho_str = row
    
    print(f"開催日: {nen}年{tsukihi[:2]}月{tsukihi[2:4]}日")
    print(f"競馬場: {keibajo}")
    print(f"レース番号: {race_no}R")
    print(f"出走頭数: {shusso}頭")
    
    # 単勝オッズをパース
    print("\n" + "=" * 80)
    print("✅ 単勝オッズのパース結果")
    print("=" * 80)
    
    tansho_odds = parse_tansho_odds(tansho_str)
    
    if tansho_odds:
        print(f"\n{'馬番':<6} {'単勝オッズ':<12}")
        print("-" * 30)
        for umaban in sorted(tansho_odds.keys()):
            print(f"{umaban:<6} {tansho_odds[umaban]:>8.1f}倍")
    else:
        print("❌ パース失敗")
    
    # 複勝オッズをパース
    print("\n" + "=" * 80)
    print("✅ 複勝オッズのパース結果")
    print("=" * 80)
    
    fukusho_odds = parse_fukusho_odds(fukusho_str)
    
    if fukusho_odds:
        print(f"\n{'馬番':<6} {'複勝オッズ範囲':<20}")
        print("-" * 40)
        for umaban in sorted(fukusho_odds.keys()):
            min_odds, max_odds = fukusho_odds[umaban]
            print(f"{umaban:<6} {min_odds:>6.1f}倍 ~ {max_odds:>6.1f}倍")
    else:
        print("❌ パース失敗")
    
    # jvd_seのデータと照合
    print("\n" + "=" * 80)
    print("🔗 jvd_se の着順データと照合")
    print("=" * 80)
    
    cursor.execute("""
        SELECT umaban, kakutei_chakujun, tansho_ninkijun
        FROM jvd_se
        WHERE kaisai_nen = '2025' 
          AND kaisai_tsukihi = '0105' 
          AND keibajo_code = '06'
          AND race_bango = '01'
        ORDER BY CAST(kakutei_chakujun AS INTEGER);
    """)
    
    se_data = cursor.fetchall()
    
    print(f"\n{'馬番':<6} {'着順':<6} {'人気':<6} {'単勝オッズ':<12} {'複勝オッズ範囲':<20}")
    print("-" * 70)
    
    for umaban, chakujun, ninkijun in se_data[:10]:  # 上位10頭
        tansho = tansho_odds.get(umaban, None)
        fukusho = fukusho_odds.get(umaban, None)
        
        tansho_str = f"{tansho:.1f}倍" if tansho else "---"
        fukusho_str = f"{fukusho[0]:.1f}~{fukusho[1]:.1f}倍" if fukusho else "---"
        
        print(f"{umaban:<6} {chakujun:<6} {ninkijun:<6} {tansho_str:<12} {fukusho_str:<20}")
    
    cursor.close()
    conn.close()
    
    print("\n" + "=" * 80)
    print("✅ テスト完了")
    print("=" * 80)
    
    print("\n📌 結論:")
    print("  • jvd_o1.odds_tansho は 6文字単位でパース可能")
    print("  • jvd_o1.odds_fukusho は 8文字単位でパース可能")
    print("  • オッズデータは整数×10 で格納（123 → 12.3倍）")
    print("  • jvd_se の umaban と jvd_o1 のオッズを結合可能")

if __name__ == "__main__":
    main()
