#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
オッズ・払戻データの詳細確認スクリプト

jvd_se, jvd_o1, jvd_hr の実際のデータを確認
"""

import psycopg2
import yaml
from pathlib import Path

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def main():
    print("=" * 80)
    print("🔍 オッズ・払戻データの詳細確認")
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
    
    # ================================================================
    # 1. jvd_se テーブルの詳細（成績データ）
    # ================================================================
    print("\n" + "=" * 80)
    print("📋 1. jvd_se テーブル（成績データ）")
    print("=" * 80)
    
    # 全カラムを取得
    cursor.execute("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = 'jvd_se'
        ORDER BY ordinal_position;
    """)
    
    se_columns = cursor.fetchall()
    print(f"\n全カラム数: {len(se_columns)}")
    print("\n重要カラム:")
    
    important_cols_se = [
        'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'kaisai_kai', 
        'kaisai_nichime', 'race_bango', 'umaban', 'kakutei_chakujun',
        'tansho_odds', 'tansho_ninkijun', 'fukushoku_hyoji'
    ]
    
    for col in important_cols_se:
        matching = [c for c in se_columns if c[0] == col]
        if matching:
            print(f"  ✅ {col:<30} ({matching[0][1]})")
        else:
            print(f"  ❌ {col:<30} (存在しない)")
    
    # サンプルデータ（1着馬）
    print("\n📝 サンプルデータ（2025年1着馬、最初の5件）:")
    cursor.execute("""
        SELECT 
            kaisai_yen || kaisai_tsukihi as date,
            keibajo_code, race_bango, umaban, kakutei_chakujun,
            tansho_odds, tansho_ninkijun
        FROM jvd_se
        WHERE kaisai_nen = '2025' AND kakutei_chakujun = '01'
        ORDER BY kaisai_tsukihi, keibajo_code, race_bango
        LIMIT 5;
    """)
    
    results = cursor.fetchall()
    if results:
        print(f"{'日付':<10} {'場':<4} {'R':<4} {'馬番':<6} {'着順':<6} {'単勝オッズ':<12} {'人気':<6}")
        print("-" * 70)
        for row in results:
            print(f"{row[0]:<10} {row[1]:<4} {row[2]:<4} {row[3]:<6} {row[4]:<6} {row[5]:<12} {row[6]:<6}")
    
    # ================================================================
    # 2. jvd_o1 テーブルの詳細（オッズデータ）
    # ================================================================
    print("\n" + "=" * 80)
    print("📋 2. jvd_o1 テーブル（オッズデータ）")
    print("=" * 80)
    
    cursor.execute("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = 'jvd_o1'
        ORDER BY ordinal_position;
    """)
    
    o1_columns = cursor.fetchall()
    print(f"\n全カラム数: {len(o1_columns)}")
    print("\n全カラム一覧:")
    
    for i, (col_name, col_type) in enumerate(o1_columns, 1):
        print(f"  {i:2}. {col_name:<40} ({col_type})")
    
    # サンプルデータ
    print("\n📝 サンプルデータ（2025年、最初の5件）:")
    cursor.execute("""
        SELECT *
        FROM jvd_o1
        WHERE kaisai_nen = '2025'
        ORDER BY kaisai_tsukihi, keibajo_code, race_bango
        LIMIT 5;
    """)
    
    results = cursor.fetchall()
    col_names = [desc[0] for desc in cursor.description]
    
    if results:
        for idx, row in enumerate(results[:2], 1):  # 最初の2行のみ
            print(f"\n--- レコード {idx} ---")
            for col_name, val in zip(col_names, row):
                if val is not None and str(val).strip():
                    print(f"  {col_name:<30} = {val}")
    
    # ================================================================
    # 3. jvd_hr テーブルの詳細（払戻データ）
    # ================================================================
    print("\n" + "=" * 80)
    print("📋 3. jvd_hr テーブル（払戻データ）")
    print("=" * 80)
    
    cursor.execute("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = 'jvd_hr'
        ORDER BY ordinal_position;
    """)
    
    hr_columns = cursor.fetchall()
    print(f"\n全カラム数: {len(hr_columns)}")
    print("\n払戻関連カラム:")
    
    haito_cols = [col for col in hr_columns if 'haraimodoshi' in col[0]]
    for col_name, col_type in haito_cols[:15]:  # 最初の15個
        print(f"  • {col_name:<40} ({col_type})")
    
    if len(haito_cols) > 15:
        print(f"  ... 他 {len(haito_cols)-15}カラム")
    
    # サンプルデータ
    print("\n📝 サンプルデータ（2025年、最初の3件）:")
    cursor.execute("""
        SELECT 
            kaisai_nen || kaisai_tsukihi as date,
            keibajo_code, race_bango,
            haraimodoshi_tansho_1a, haraimodoshi_tansho_1b,
            haraimodoshi_fukusho_1a, haraimodoshi_fukusho_2a, haraimodoshi_fukusho_3a
        FROM jvd_hr
        WHERE kaisai_nen = '2025'
        ORDER BY kaisai_tsukihi, keibajo_code, race_bango
        LIMIT 3;
    """)
    
    results = cursor.fetchall()
    if results:
        print(f"{'日付':<10} {'場':<4} {'R':<4} {'単勝払戻(1a)':<12} {'単勝払戻(1b)':<12} {'複勝1a':<10} {'複勝2a':<10} {'複勝3a':<10}")
        print("-" * 80)
        for row in results:
            print(f"{row[0]:<10} {row[1]:<4} {row[2]:<4} {row[3]:<12} {row[4]:<12} {row[5]:<10} {row[6]:<10} {row[7]:<10}")
    
    # ================================================================
    # 4. テーブル間の結合キーを確認
    # ================================================================
    print("\n" + "=" * 80)
    print("🔗 4. テーブル結合キーの確認")
    print("=" * 80)
    
    print("\n結合キー（共通カラム）:")
    print("  • kaisai_nen      (開催年)")
    print("  • kaisai_tsukihi  (開催月日)")
    print("  • keibajo_code    (競馬場コード)")
    print("  • kaisai_kai      (開催回)")
    print("  • kaisai_nichime  (開催日目)")
    print("  • race_bango      (レース番号)")
    
    print("\nテーブル別の粒度:")
    print("  • jvd_se: 馬単位（umaban あり）")
    print("  • jvd_o1: 馬単位（ただし構造が異なる可能性）")
    print("  • jvd_hr: レース単位（umaban なし、複数着の払戻を1行に格納）")
    
    # ================================================================
    # 5. 2025年1月5日のデータで結合テスト
    # ================================================================
    print("\n" + "=" * 80)
    print("🧪 5. データ結合テスト（2025年1月5日）")
    print("=" * 80)
    
    print("\njvd_se のレース数:")
    cursor.execute("""
        SELECT COUNT(DISTINCT keibajo_code || race_bango)
        FROM jvd_se
        WHERE kaisai_nen = '2025' AND kaisai_tsukihi = '0105';
    """)
    se_races = cursor.fetchone()[0]
    print(f"  jvd_se: {se_races}レース")
    
    print("\njvd_o1 のレース数:")
    cursor.execute("""
        SELECT COUNT(DISTINCT keibajo_code || race_bango)
        FROM jvd_o1
        WHERE kaisai_nen = '2025' AND kaisai_tsukihi = '0105';
    """)
    o1_races = cursor.fetchone()[0]
    print(f"  jvd_o1: {o1_races}レース")
    
    print("\njvd_hr のレース数:")
    cursor.execute("""
        SELECT COUNT(*)
        FROM jvd_hr
        WHERE kaisai_nen = '2025' AND kaisai_tsukihi = '0105';
    """)
    hr_races = cursor.fetchone()[0]
    print(f"  jvd_hr: {hr_races}レース")
    
    cursor.close()
    conn.close()
    
    print("\n" + "=" * 80)
    print("✅ 調査完了")
    print("=" * 80)
    
    print("\n📌 Phase 2C のデータソース案:")
    print("  1. 予測データ: results/predictions_2025*.csv")
    print("  2. 着順データ: jvd_se.kakutei_chakujun")
    print("  3. オッズデータ: jvd_se.tansho_odds または jvd_o1.odds_tansho")
    print("  4. 払戻データ: jvd_hr.haraimodoshi_* (レース単位)")
    print("\n⚠️ 注意: 複勝オッズは jvd_se にないため、jvd_o1 を使用する必要があります")

if __name__ == "__main__":
    main()
