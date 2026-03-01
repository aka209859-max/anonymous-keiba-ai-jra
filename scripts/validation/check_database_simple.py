#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
データベース構造とデータ確認スクリプト（簡易版）
"""

import psycopg2
import pandas as pd
from pathlib import Path

def main():
    print("=" * 80)
    print("データベース確認スクリプト")
    print("=" * 80)
    
    # データベース接続
    try:
        conn = psycopg2.connect(
            host="localhost",
            port=5432,
            database="pc_keiba",
            user="postgres",
            password="postgres"
        )
        print("✅ データベース接続成功\n")
    except Exception as e:
        print(f"❌ データベース接続エラー: {e}")
        return
    
    cursor = conn.cursor()
    
    # 1. 2025年データの確認
    print("【1. 2025年データの確認】")
    try:
        query = "SELECT COUNT(*) FROM jvd_se WHERE kaisai_nen = '2025';"
        cursor.execute(query)
        count = cursor.fetchone()[0]
        print(f"   2025年データ: {count:,}件\n")
        
        if count > 0:
            # 月別データ
            query_monthly = """
            SELECT 
                SUBSTRING(kaisai_tsukihi, 1, 2) as month, 
                COUNT(*) as count
            FROM jvd_se
            WHERE kaisai_nen = '2025'
            GROUP BY SUBSTRING(kaisai_tsukihi, 1, 2)
            ORDER BY month;
            """
            df_monthly = pd.read_sql(query_monthly, conn)
            print("   月別データ件数:")
            for _, row in df_monthly.iterrows():
                print(f"      {row['month']}月: {row['count']:,}件")
    except Exception as e:
        print(f"   ❌ エラー: {e}")
    
    print("\n" + "-" * 80 + "\n")
    
    # 2. jvd_se テーブルのカラム一覧
    print("【2. jvd_se テーブルのカラム一覧】")
    try:
        query = """
        SELECT column_name, data_type, character_maximum_length
        FROM information_schema.columns
        WHERE table_name = 'jvd_se'
        ORDER BY ordinal_position;
        """
        df_columns = pd.read_sql(query, conn)
        
        print(f"   カラム数: {len(df_columns)}\n")
        
        # オッズ・払戻関連カラムをチェック
        important_cols = [
            'kakutei_tansho_odds',
            'kakutei_fukusho_odds_min',
            'kakutei_fukusho_odds_max',
            'tansho_haito',
            'fukusho_haito'
        ]
        
        print("   【重要】オッズ・払戻カラムの確認:")
        for col in important_cols:
            if col in df_columns['column_name'].values:
                dtype = df_columns[df_columns['column_name'] == col]['data_type'].values[0]
                print(f"      ✅ {col} ({dtype})")
            else:
                print(f"      ❌ {col} (存在しない)")
        
        print("\n   全カラム一覧:")
        for idx, row in df_columns.iterrows():
            max_len = f"({row['character_maximum_length']})" if pd.notna(row['character_maximum_length']) else ""
            print(f"      {idx+1:3d}. {row['column_name']:<40} {row['data_type']}{max_len}")
    
    except Exception as e:
        print(f"   ❌ エラー: {e}")
    
    print("\n" + "-" * 80 + "\n")
    
    # 3. 2025年データのサンプル（オッズ・払戻カラムがある場合）
    print("【3. 2025年データのサンプル（1着馬）】")
    try:
        # 基本カラム
        cols = ['kaisai_nen', 'kaisai_tsukihi', 'race_bango', 'umaban', 'kakutei_chakujun']
        
        # オプションカラム（存在する場合のみ追加）
        optional_cols = [
            'kakutei_tansho_odds',
            'kakutei_fukusho_odds_min',
            'tansho_haito',
            'fukusho_haito'
        ]
        
        for col in optional_cols:
            if col in df_columns['column_name'].values:
                cols.append(col)
        
        query = f"""
        SELECT {', '.join(cols)}
        FROM jvd_se
        WHERE kaisai_nen = '2025'
        AND kakutei_chakujun = 1
        ORDER BY kaisai_tsukihi, race_bango
        LIMIT 10;
        """
        
        df_sample = pd.read_sql(query, conn)
        if not df_sample.empty:
            print(df_sample.to_string(index=False))
        else:
            print("   データなし")
    
    except Exception as e:
        print(f"   ❌ エラー: {e}")
    
    conn.close()
    
    print("\n" + "=" * 80)
    print("確認完了")
    print("=" * 80)

if __name__ == '__main__':
    main()
