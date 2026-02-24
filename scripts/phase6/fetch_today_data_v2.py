#!/usr/bin/env python3
"""
Phase 6: 当日データ取得スクリプト（修正版）

テーブル構造判明:
- jvd_se: JRA-VAN 出走馬データ（出馬表相当）
- jvd_ra: JRA-VAN レースデータ
- jrd_bac: JRDBデータ（IDM指数等）
- jrd_sed: JRDB成績データ

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
    
    # jvd_se（出走馬データ）の件数を確認
    check_query = f"""
        SELECT COUNT(*) as cnt
        FROM jvd_se
        WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{month_day}'
    """
    
    df_check = pd.read_sql(check_query, conn)
    record_count = df_check['cnt'].iloc[0]
    
    print(f"📊 jvd_se テーブル: {record_count:,} 件")
    
    if record_count == 0:
        print(f"⚠️  {target_date} のデータが見つかりません")
        print(f"   PC-KEIBAで該当日のデータが取り込まれているか確認してください")
        conn.close()
        return None
    
    # JRDBデータの確認
    jrdb_check_query = f"""
        SELECT COUNT(*) as cnt
        FROM jrd_bac
        WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{month_day}'
    """
    
    try:
        df_jrdb_check = pd.read_sql(jrdb_check_query, conn)
        jrdb_count = df_jrdb_check['cnt'].iloc[0]
        print(f"📊 jrd_bac テーブル: {jrdb_count:,} 件")
        has_jrdb = jrdb_count > 0
    except Exception as e:
        print(f"⚠️  jrd_bac テーブルにアクセスできません: {e}")
        has_jrdb = False
    
    # メインクエリ: jvd_se（出走馬データ）とjvd_ra（レースデータ）を結合
    main_query = f"""
        SELECT 
            se.kaisai_nen,
            se.kaisai_tsukihi,
            se.keibajo_code,
            se.race_bango,
            se.umaban,
            se.wakuban,
            se.ketto_toroku_bango,
            se.bamei,
            se.uma_kigocd,
            se.sex_cd,
            se.hinba,
            se.barei,
            se.moshikomi_bataiju,
            se.kishu_code,
            se.kishumei_ryakusho,
            se.futan_juryo,
            se.minarai_cd,
            se.chokyoshi_code,
            se.chokyoshimei_ryakusho,
            se.banushi_code,
            se.banushimei,
            se.kakutei_chakujun,
            se.ijyo_kubun_cd,
            se.time,
            se.chakusa,
            se.corner_tsuka_jun,
            se.zenpan_3f,
            se.kohan_3f,
            se.jocky_cd,
            se.kinryo,
            se.bataiju,
            se.zogen,
            se.tyokyosi_cd,
            se.tyokyosi,
            se.bagu_cd,
            se.idowaku,
            se.idokeiba,
            se.kyori_tekisei_cd,
            se.zen_so_cd,
            se.ashi_iro_cd,
            ra.race_meisho_ryaku,
            ra.kyori,
            ra.track_cd,
            ra.baba_jotai_naimen,
            ra.baba_jotai_gaimen,
            ra.shubetsu_cd,
            ra.joken_cd,
            ra.kigo_cd,
            ra.juryo_shubetsu_cd,
            ra.grade_cd,
            ra.race_joken_cd,
            ra.hasso_jikoku
        FROM jvd_se se
        LEFT JOIN jvd_ra ra 
            ON se.kaisai_nen = ra.kaisai_nen
            AND se.kaisai_tsukihi = ra.kaisai_tsukihi
            AND se.keibajo_code = ra.keibajo_code
            AND se.race_bango = ra.race_bango
        WHERE se.kaisai_nen = '{year}' AND se.kaisai_tsukihi = '{month_day}'
        ORDER BY se.race_bango, se.umaban
    """
    
    print(f"\n🔄 データ取得中...")
    df = pd.read_sql(main_query, conn)
    
    # JRDBデータが存在する場合は結合
    if has_jrdb:
        jrdb_query = f"""
            SELECT 
                kaisai_nen,
                kaisai_tsukihi,
                keibajo_code,
                race_bango,
                umaban,
                idm_shisu,
                jocky_shisu,
                info_shisu,
                sogo_shisu,
                pace_shisu,
                basho_shisu
            FROM jrd_bac
            WHERE kaisai_nen = '{year}' AND kaisai_tsukihi = '{month_day}'
        """
        
        df_jrdb = pd.read_sql(jrdb_query, conn)
        
        # 結合
        df = df.merge(
            df_jrdb,
            on=['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban'],
            how='left'
        )
        
        print(f"✅ JRDBデータを結合しました")
    
    conn.close()
    
    # レースIDを生成
    df['race_id'] = df['kaisai_nen'].astype(str) + \
                    df['kaisai_tsukihi'].astype(str) + \
                    df['keibajo_code'].astype(str).str.zfill(2) + \
                    df['race_bango'].astype(str).str.zfill(2)
    
    # 統計情報を表示
    print(f"\n{'='*80}")
    print(f"📈 取得データ統計")
    print(f"{'='*80}")
    print(f"  総レコード数: {len(df):,} 件")
    print(f"  レース数: {df['race_id'].nunique()} レース")
    print(f"  競馬場数: {df['keibajo_code'].nunique()} 場")
    print(f"  カラム数: {len(df.columns)} 列")
    
    # レースごとの出走頭数
    race_counts = df.groupby('race_bango').size()
    print(f"\n  レースごとの出走頭数:")
    for race_num, count in race_counts.items():
        print(f"    {int(race_num):2d}R: {count:2d}頭")
    
    # JRDBデータの有無を確認
    if has_jrdb and 'idm_shisu' in df.columns:
        idm_exists = df['idm_shisu'].notna().sum()
        print(f"\n  JRDB IDM指数: {idm_exists}/{len(df)} 件存在")
    
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
    
    # 主要カラムの欠損率を表示
    print(f"\n  主要カラムの欠損率:")
    important_cols = ['bamei', 'kishumei_ryakusho', 'futan_juryo', 'bataiju', 
                     'kyori', 'track_cd', 'idm_shisu', 'jocky_shisu']
    for col in important_cols:
        if col in df.columns:
            null_count = df[col].isnull().sum()
            null_pct = null_count / len(df) * 100
            print(f"    {col:<25} NULL: {null_count:4,} ({null_pct:5.1f}%)")

def main():
    print("=" * 80)
    print("Phase 6: 当日データ取得テスト（修正版）")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"使用テーブル: jvd_se (出走馬), jvd_ra (レース), jrd_bac (JRDB)")
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
