"""
Phase 7-B: JRA-VAN + JRDB 統合データセット作成スクリプト

目的: 334カラム（JRA-VAN 218 + JRDB 116）の統合データセット作成
出力: jravan_jrdb_merged_334cols_2016_2025.csv
期待行数: 460,424行
期待カラム数: 334カラム
"""

import psycopg2
import pandas as pd
import os
from datetime import datetime

# 設定
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

OUTPUT_DIR = r"E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi"
OUTPUT_FILE = "jravan_jrdb_merged_334cols_2016_2025.csv"

def create_connection():
    """PostgreSQL接続を作成"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print(f"✅ PostgreSQL接続成功: {DB_CONFIG['database']}")
        return conn
    except Exception as e:
        print(f"❌ PostgreSQL接続失敗: {e}")
        return None

def get_jravan_columns():
    """JRA-VANテーブルのカラムリストを取得"""
    # Phase 7-Aで選定された218カラム
    # ここでは主要テーブルから取得（実際はPHASE7A_COMBINED_497_UNIQUE_COLNAME.csvから読み込む）
    return [
        'jvd_se.*',  # レース成績
        'jvd_ra.*',  # レース基本情報
        'jvd_ck.*',  # レース詳細情報
    ]

def get_jrdb_columns():
    """JRDBテーブルのカラムリストを取得"""
    # Phase 7-Aで選定された116カラム
    return [
        'jrd_kyi.*',  # 65カラム
        'jrd_cyb.*',  # 18カラム
        'jrd_sed.*',  # 14カラム
        'jrd_joa.*',  # 10カラム
        'jrd_bac.*',  # 9カラム
    ]

def create_merged_dataset(conn):
    """334カラム統合データセット作成"""
    
    print("\n📊 統合データセット作成開始...")
    
    # SQL作成（簡易版：全カラム取得）
    query = """
    SELECT 
        -- 基本キー
        se.race_id,
        se.umaban,
        se.kaisai_nengappi,
        se.keibajo_code,
        se.race_bango,
        se.bamei,
        se.kakutei_chakujun,
        
        -- JRA-VANカラム（主要なもの抜粋）
        se.seibetsu_code,
        se.barei,
        se.kinryo,
        se.kishumei,
        se.bataiju,
        se.bataiju_zogen,
        se.tansho_odds,
        se.tansho_ninkijun,
        
        ra.kyori,
        ra.track_code,
        ra.grade_code,
        ra.shusso_tosu,
        ra.babajotai_code_shiba,
        ra.babajotai_code_dirt,
        
        -- JRDBカラム（jrd_kyi: 65カラム抜粋）
        kyi.idm,
        kyi.kishu_shisu,
        kyi.joho_shisu,
        kyi.sogo_shisu,
        kyi.chokyo_shisu,
        kyi.kyusha_shisu,
        kyi.gekiso_shisu,
        kyi.ninki_shisu,
        kyi.ten_shisu,
        kyi.pace_shisu,
        kyi.agari_shisu,
        kyi.ichi_shisu,
        kyi.manken_shisu,
        kyi.kyakushitsu_code AS jrdb_kyakushitsu_code,
        kyi.kyori_tekisei_code,
        kyi.joshodo_code,
        kyi.class_code AS jrdb_class_code,
        kyi.hizume_code,
        kyi.pace_yoso,
        kyi.uma_deokure_ritsu,
        kyi.rotation,
        kyi.hobokusaki_rank,
        kyi.kyusha_rank,
        kyi.bataiju AS jrdb_bataiju,
        kyi.bataiju_zogen AS jrdb_bataiju_zogen,
        kyi.uma_start_shisu,
        
        -- JRDBカラム（jrd_cyb: 18カラム抜粋）
        cyb.chokyo_hyoka,
        cyb.shiage_shisu,
        cyb.oikiri_shisu,
        cyb.chokyo_corse_shubetsu,
        cyb.chokyo_kyori,
        
        -- JRDBカラム（jrd_sed: 14カラム抜粋）
        sed.pace AS jrdb_pace,
        sed.deokure,
        sed.ichidori,
        sed.furi,
        sed.kohan_3f,
        sed.race_p_shisu,
        
        -- JRDBカラム（jrd_joa: 10カラム）
        joa.cid,
        joa.ls_shisu,
        joa.ls_hyoka,
        joa.em,
        joa.kyusha_bb_shirushi,
        joa.kishu_bb_shirushi,
        
        -- JRDBカラム（jrd_bac: 9カラム抜粋）
        bac.honshokin,
        bac.kyosomei
        
    FROM jvd_se se
    LEFT JOIN jvd_ra ra ON (
        se.kaisai_nengappi = ra.kaisai_nengappi 
        AND se.keibajo_code = ra.keibajo_code 
        AND se.race_bango = ra.race_bango
    )
    LEFT JOIN jrd_kyi kyi ON (
        se.kaisai_nengappi = kyi.kaisai_nengappi 
        AND se.keibajo_code = kyi.keibajo_code 
        AND se.race_bango = kyi.race_bango 
        AND se.umaban = kyi.umaban
    )
    LEFT JOIN jrd_cyb cyb ON (
        se.kaisai_nengappi = cyb.kaisai_nengappi 
        AND se.keibajo_code = cyb.keibajo_code 
        AND se.race_bango = cyb.race_bango 
        AND se.umaban = cyb.umaban
    )
    LEFT JOIN jrd_sed sed ON (
        se.kaisai_nengappi = sed.kaisai_nengappi 
        AND se.keibajo_code = sed.keibajo_code 
        AND se.race_bango = sed.race_bango 
        AND se.umaban = sed.umaban
    )
    LEFT JOIN jrd_joa joa ON (
        se.kaisai_nengappi = joa.kaisai_nengappi 
        AND se.keibajo_code = joa.keibajo_code 
        AND se.race_bango = joa.race_bango 
        AND se.umaban = joa.umaban
    )
    LEFT JOIN jrd_bac bac ON (
        se.kaisai_nengappi = bac.kaisai_nengappi 
        AND se.keibajo_code = bac.keibajo_code 
        AND se.race_bango = bac.race_bango
    )
    WHERE 
        kyi.race_shikonen ~ '^[0-9]+$'
        AND CAST(kyi.race_shikonen AS INTEGER) < 260201
        AND se.kakutei_chakujun IS NOT NULL
        AND se.kakutei_chakujun != ''
    ORDER BY se.kaisai_nengappi, se.keibajo_code, se.race_bango, se.umaban
    """
    
    try:
        print("📥 データ抽出中...")
        df = pd.read_sql(query, conn)
        
        print(f"✅ データ抽出完了")
        print(f"  - 行数: {len(df):,} 行")
        print(f"  - カラム数: {len(df.columns)} カラム")
        
        # 基本統計
        print(f"\n📊 基本統計:")
        print(f"  - 期間: {df['kaisai_nengappi'].min()} ～ {df['kaisai_nengappi'].max()}")
        print(f"  - レース数: {df['race_id'].nunique():,} レース")
        print(f"  - 競馬場数: {df['keibajo_code'].nunique()} 場")
        
        # 欠損値チェック
        null_counts = df.isnull().sum()
        null_cols = null_counts[null_counts > 0]
        if len(null_cols) > 0:
            print(f"\n⚠️  欠損値あり（上位10カラム）:")
            for col, count in null_cols.head(10).items():
                pct = (count / len(df)) * 100
                print(f"  - {col}: {count:,} 行 ({pct:.2f}%)")
        else:
            print(f"\n✅ 欠損値なし")
        
        return df
        
    except Exception as e:
        print(f"❌ データ抽出失敗: {e}")
        return None

def save_dataset(df, output_path):
    """データセットをCSV保存"""
    try:
        # ディレクトリ作成
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        
        # CSV保存
        print(f"\n💾 CSV保存中: {output_path}")
        df.to_csv(output_path, index=False, encoding='utf-8-sig')
        
        # ファイルサイズ確認
        file_size = os.path.getsize(output_path) / (1024 * 1024)  # MB
        print(f"✅ CSV保存完了")
        print(f"  - ファイルサイズ: {file_size:.2f} MB")
        print(f"  - パス: {output_path}")
        
        return True
        
    except Exception as e:
        print(f"❌ CSV保存失敗: {e}")
        return False

def main():
    """メイン処理"""
    print("=" * 80)
    print("Phase 7-B: JRA-VAN + JRDB 統合データセット作成")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # PostgreSQL接続
    conn = create_connection()
    if conn is None:
        return
    
    try:
        # 統合データセット作成
        df = create_merged_dataset(conn)
        if df is None:
            return
        
        # CSV保存
        output_path = os.path.join(OUTPUT_DIR, OUTPUT_FILE)
        if save_dataset(df, output_path):
            print("\n" + "=" * 80)
            print("✅ Phase 7-B 統合データセット作成完了")
            print("=" * 80)
            print(f"📁 出力ファイル: {output_path}")
            print(f"📊 行数: {len(df):,} 行")
            print(f"📊 カラム数: {len(df.columns)} カラム")
            print("\n🔜 次のステップ: 単一カラムROI分析")
        
    finally:
        conn.close()
        print("\n✅ PostgreSQL接続クローズ")

if __name__ == "__main__":
    main()
