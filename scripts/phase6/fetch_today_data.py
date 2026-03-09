#!/usr/bin/env python3
"""
Phase 6: 当日データ取得スクリプト（テスト版）

目的:
- PC-KEIBA PostgreSQLから指定日のレースデータを取得
- JRA-VAN出馬表データ（jra_shutsuba）とJRDBデータ（jrdb_bac等）を結合
- Phase 2-Bと同じ形式のCSVを出力

テスト日付: 2026-02-21（金）、2026-02-22（土）
"""

import psycopg2
import pandas as pd
from datetime import datetime
import sys
import os

# データベース接続情報
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

def connect_db():
    """PostgreSQLに接続"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("✅ PostgreSQL接続成功")
        return conn
    except Exception as e:
        print(f"❌ PostgreSQL接続失敗: {e}")
        sys.exit(1)

def fetch_race_data(target_date):
    """
    指定日のレースデータを取得
    
    Args:
        target_date: YYYYMMDD形式の文字列（例: '20260221'）
    
    Returns:
        DataFrame: 取得したレースデータ
    """
    conn = connect_db()
    
    year = target_date[:4]
    month_day = target_date[4:]
    
    print(f"\n{'='*80}")
    print(f"📅 対象日: {target_date} ({year}年{month_day[:2]}月{month_day[2:]}日)")
    print(f"{'='*80}")
    
    # まず、出馬表データの件数を確認
    check_query = f"""
        SELECT COUNT(*) as cnt
        FROM jra_shutsuba
        WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{target_date}'
    """
    
    df_check = pd.read_sql(check_query, conn)
    record_count = df_check['cnt'].iloc[0]
    
    print(f"📊 jra_shutsuba テーブル: {record_count:,} 件")
    
    if record_count == 0:
        print(f"⚠️  {target_date} のデータが見つかりません")
        print(f"   PC-KEIBAで該当日のデータが取り込まれているか確認してください")
        conn.close()
        return None
    
    # JRDBデータの確認
    jrdb_check_query = f"""
        SELECT COUNT(*) as cnt
        FROM jrdb_bac
        WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{target_date}'
    """
    
    try:
        df_jrdb_check = pd.read_sql(jrdb_check_query, conn)
        jrdb_count = df_jrdb_check['cnt'].iloc[0]
        print(f"📊 jrdb_bac テーブル: {jrdb_count:,} 件")
        has_jrdb = jrdb_count > 0
    except Exception as e:
        print(f"⚠️  jrdb_bac テーブルが存在しないか、アクセスできません: {e}")
        has_jrdb = False
    
    # メインクエリ: JRA-VAN出馬表データを取得（JRDBデータは後で結合）
    main_query = f"""
        SELECT 
            kaisai_nen,
            kaisai_tsukihi,
            keiba_jo_code,
            race_ban,
            uma_ban,
            wakuban,
            kishumei_ryakusho,
            futan_juryo,
            blinker_shiyoku,
            prev1_chakujun,
            prev2_chakujun,
            prev3_chakujun,
            prev4_chakujun,
            prev5_chakujun,
            prev1_time,
            prev2_time,
            prev3_time,
            uma_age,
            sex_code
        FROM jra_shutsuba
        WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{target_date}'
        ORDER BY race_ban, uma_ban
    """
    
    print(f"\n🔄 データ取得中...")
    df = pd.read_sql(main_query, conn)
    
    # JRDBデータが存在する場合は結合
    if has_jrdb:
        jrdb_query = f"""
            SELECT 
                kaisai_nen,
                kaisai_tsukihi,
                keiba_jo_code,
                race_ban,
                uma_ban,
                idm_shisu,
                jockey_shisu,
                info_shisu,
                sogo_shisu,
                pace_shisu
            FROM jrdb_bac
            WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{target_date}'
        """
        
        df_jrdb = pd.read_sql(jrdb_query, conn)
        
        # 結合
        df = df.merge(
            df_jrdb,
            on=['kaisai_nen', 'kaisai_tsukihi', 'keiba_jo_code', 'race_ban', 'uma_ban'],
            how='left'
        )
        
        print(f"✅ JRDBデータを結合しました")
    
    conn.close()
    
    # レースIDを生成
    df['race_id'] = df['kaisai_nen'].astype(str) + \
                    df['kaisai_tsukihi'].astype(str) + \
                    df['keiba_jo_code'].astype(str).str.zfill(2) + \
                    df['race_ban'].astype(str).str.zfill(2)
    
    # 統計情報を表示
    print(f"\n{'='*80}")
    print(f"📈 取得データ統計")
    print(f"{'='*80}")
    print(f"  総レコード数: {len(df):,} 件")
    print(f"  レース数: {df['race_id'].nunique()} レース")
    print(f"  競馬場数: {df['keiba_jo_code'].nunique()} 場")
    print(f"  カラム数: {len(df.columns)} 列")
    
    # レースごとの出走頭数
    race_counts = df.groupby('race_ban').size()
    print(f"\n  レースごとの出走頭数:")
    for race_num, count in race_counts.items():
        print(f"    {race_num:2d}R: {count:2d}頭")
    
    return df

def save_data(df, target_date):
    """データをCSVに保存"""
    if df is None or len(df) == 0:
        print("⚠️  保存するデータがありません")
        return
    
    # 出力ディレクトリ作成
    output_dir = "data/phase6_test"
    os.makedirs(output_dir, exist_ok=True)
    
    # ファイル名
    output_file = f"{output_dir}/race_data_{target_date}.csv"
    
    # CSV保存
    df.to_csv(output_file, index=False, encoding='utf-8-sig')
    
    file_size = os.path.getsize(output_file) / 1024  # KB
    
    print(f"\n{'='*80}")
    print(f"💾 データ保存完了")
    print(f"{'='*80}")
    print(f"  ファイル: {output_file}")
    print(f"  サイズ: {file_size:.1f} KB")
    print(f"  レコード数: {len(df):,} 件")
    print(f"  カラム数: {len(df.columns)} 列")
    
    # カラム一覧を表示
    print(f"\n  カラム一覧:")
    for i, col in enumerate(df.columns, 1):
        null_count = df[col].isnull().sum()
        null_pct = null_count / len(df) * 100
        print(f"    {i:2d}. {col:<30} (NULL: {null_count:,} / {null_pct:.1f}%)")

def main():
    print("=" * 80)
    print("Phase 6: 当日データ取得テスト")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    # テスト対象日
    test_dates = ['20260221', '20260222']
    
    for target_date in test_dates:
        try:
            # データ取得
            df = fetch_race_data(target_date)
            
            # データ保存
            if df is not None:
                save_data(df, target_date)
            
            print()
        
        except Exception as e:
            print(f"❌ エラーが発生しました: {e}")
            import traceback
            traceback.print_exc()
            continue
    
    print("=" * 80)
    print("✅ テスト完了")
    print("=" * 80)

if __name__ == "__main__":
    main()
