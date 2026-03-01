#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI Phase 6: 当日予測システム
=============================================

【目的】
PC-KEIBAデータベースから当日データを取得し、Phase 1-5と同じロジックで
139列特徴量を生成してアンサンブル予測を実行

【実行方法】
python scripts/phase6/phase6_daily_prediction.py --target-date 20260221

【出力】
- results/predictions_YYYYMMDD.csv（当日の予測結果）

【作成日】2026-02-23
"""

import argparse
import logging
import sys
import psycopg2
import pandas as pd
import numpy as np
import lightgbm as lgb
from pathlib import Path
from datetime import datetime

# ============================================================================
# ログ設定
# ============================================================================

def setup_logging(target_date: str):
    """ログ初期化"""
    log_dir = Path('logs')
    log_dir.mkdir(exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_file = log_dir / f"phase6_prediction_{target_date}_{timestamp}.log"
    
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file, encoding='utf-8'),
            logging.StreamHandler(sys.stdout)
        ]
    )
    return logging.getLogger(__name__)

# ============================================================================
# データベース接続
# ============================================================================

def get_db_connection():
    """PC-KEIBAデータベース接続"""
    conn = psycopg2.connect(
        host='127.0.0.1',
        port=5432,
        database='pckeiba',
        user='postgres',
        password='postgres123'
    )
    return conn

# ============================================================================
# Phase 1ロジック: 当日データ取得 & 139列特徴量生成
# ============================================================================

def fetch_today_data(conn, target_date: str):
    """
    当日データ取得（Phase 1と同じロジック）
    
    Args:
        conn: DB接続
        target_date: 対象日（'YYYYMMDD'形式、例: '20260221'）
    
    Returns:
        tuple: (DataFrame（139列特徴量）, dict（表示用データ）)
    """
    logger = logging.getLogger(__name__)
    logger.info(f"=" * 80)
    logger.info(f"Phase 6: 当日データ取得 & 特徴量生成（{target_date}）")
    logger.info(f"=" * 80)
    
    # YYYYMMDDから kaisai_nen, kaisai_tsukihi 分離
    kaisai_nen = target_date[:4]
    kaisai_tsukihi = target_date[4:8]
    
    logger.info(f"開催年: {kaisai_nen}, 開催月日: {kaisai_tsukihi}")
    
    # ===== A. 基礎情報系（24列）=====
    query_basic = f"""
    SELECT 
        -- キー列
        ra.kaisai_nen,
        ra.kaisai_tsukihi,
        ra.keibajo_code,
        ra.kaisai_kai,
        ra.kaisai_nichime,
        ra.race_bango,
        se.umaban,
        se.ketto_toroku_bango,
        
        -- A-1. レース基本情報（7列）
        CAST(SUBSTRING(ra.kaisai_tsukihi, 1, 2) AS INTEGER) AS month,
        ra.kyori,
        ra.track_code,
        ra.grade_code,
        ra.shusso_tosu,
        ra.tenko_code,
        
        -- A-2. 馬場状態（2列）
        ra.babajotai_code_shiba,
        ra.babajotai_code_dirt,
        
        -- A-3. 馬基本情報（5列 + 馬名）
        se.bamei,
        se.seibetsu_code,
        se.barei,
        se.moshoku_code,
        
        -- A-4. 騎手・調教師（6列）
        se.kishu_code,
        se.chokyoshi_code,
        se.kishumei_ryakusho,
        se.chokyoshimei_ryakusho,
        se.tozai_shozoku_code,
        se.kishu_minarai_code,
        
        -- A-5. 装備・枠・負担重量（3列）
        se.blinker_shiyo_kubun,
        se.wakuban,
        se.futan_juryo,
        
        -- A-6. 馬主・生産者（2列）
        se.banushi_code,
        se.banushimei,
        
        -- ターゲット変数用
        se.kakutei_chakujun
        
    FROM jvd_ra ra
    INNER JOIN jvd_se se ON (
        ra.kaisai_nen = se.kaisai_nen
        AND ra.kaisai_tsukihi = se.kaisai_tsukihi
        AND ra.keibajo_code = se.keibajo_code
        AND ra.kaisai_kai = se.kaisai_kai
        AND ra.kaisai_nichime = se.kaisai_nichime
        AND ra.race_bango = se.race_bango
    )
    WHERE ra.kaisai_nen = '{kaisai_nen}'
      AND ra.kaisai_tsukihi = '{kaisai_tsukihi}'
      AND CAST(se.umaban AS INTEGER) <= 18
    ORDER BY ra.kaisai_nen, ra.kaisai_tsukihi, ra.keibajo_code, ra.race_bango, se.umaban
    """
    
    df = pd.read_sql_query(query_basic, conn)
    
    # keibajo_code を文字列型として保持（'05' → 5 に変換されるのを防ぐ）
    if 'keibajo_code' in df.columns:
        df['keibajo_code'] = df['keibajo_code'].astype(str).str.zfill(2)
    
    if len(df) == 0:
        logger.error(f"❌ {target_date} のデータが見つかりません")
        sys.exit(1)
    
    logger.info(f"✅ 基礎情報: {len(df)}頭（{df['race_bango'].nunique()}レース）")
    
    # デバッグ: 競馬場コードと開催情報を確認
    logger.info(f"🔍 DEBUG: keibajo_code 型 = {df['keibajo_code'].dtype}")
    logger.info(f"🔍 DEBUG: 開催競馬場 = {df['keibajo_code'].unique()}")
    logger.info(f"🔍 DEBUG: レース番号範囲 = {df['race_bango'].min()}〜{df['race_bango'].max()}")
    
    # デバッグ: bamei の型と最初の5行を確認
    logger.info(f"🔍 DEBUG: bamei カラム型 = {df['bamei'].dtype}")
    logger.info(f"🔍 DEBUG: bamei サンプル（最初の5行）:")
    for idx, row in df.head(5).iterrows():
        logger.info(f"  {idx}: umaban={row['umaban']}, bamei='{row['bamei']}' (type={type(row['bamei'])}, len={len(str(row['bamei']))})")
    
    # keibajo_season_code生成
    def generate_keibajo_season_code(row):
        keibajo = row['keibajo_code']
        tsukihi = row['kaisai_tsukihi']
        month = int(tsukihi[:2])
        if keibajo == '10':
            if month in [6, 7, 8, 9]:
                return '10_summer'
            elif month in [1, 2, 3]:
                return '10_winter'
        return keibajo
    
    df['keibajo_season_code'] = df.apply(generate_keibajo_season_code, axis=1)
    
    # ===== B. 馬実績データ（14列）=====
    ketto_list = df['ketto_toroku_bango'].unique().tolist()
    
    query_ck = """
    SELECT 
        ck.ketto_toroku_bango,
        ck.kaisai_nen,
        ck.kaisai_tsukihi,
        ck.keibajo_code,
        ck.kaisai_kai,
        ck.kaisai_nichime,
        ck.race_bango,
        ck.sogo,
        ck.kyakushitsu_keiko,
        ck.shiba_ryo,
        ck.shiba_yayaomo,
        ck.shiba_omo,
        ck.shiba_furyo,
        ck.dirt_ryo,
        ck.dirt_yayaomo,
        ck.dirt_omo,
        ck.dirt_furyo,
        ck.shiba_1200_ika,
        ck.shiba_1201_1400,
        ck.dirt_1200_ika,
        ck.dirt_1201_1400
    FROM jvd_ck ck
    WHERE ck.ketto_toroku_bango = ANY(%s)
      AND ck.kaisai_nen = %s
      AND ck.kaisai_tsukihi = %s
    """
    
    df_ck = pd.read_sql_query(query_ck, conn, params=(ketto_list, kaisai_nen, kaisai_tsukihi))
    
    # マージ（馬番も含む）
    # jvd_ckには umaban がないので、ketto + 日付でマージ
    merge_keys_ck = ['ketto_toroku_bango', 'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 
                     'kaisai_kai', 'kaisai_nichime', 'race_bango']
    df = df.merge(df_ck, on=merge_keys_ck, how='left')
    
    logger.info(f"✅ 馬実績データマージ: {len(df_ck)}件")
    
    # ===== C. 過去走データ（58列）=====
    query_past = """
    WITH past_races AS (
        SELECT 
            se.ketto_toroku_bango,
            se.kaisai_nen,
            se.kaisai_tsukihi,
            se.keibajo_code,
            se.race_bango,
            se.kakutei_chakujun,
            se.soha_time,
            se.kohan_3f,
            se.corner_1,
            se.corner_4,
            se.bataiju,
            se.zogen_sa,
            se.time_sa,
            ra.kyori,
            ra.track_code,
            ra.babajotai_code_shiba,
            ra.babajotai_code_dirt,
            ra.keibajo_code AS past_keibajo,
            ra.kaisai_nen || ra.kaisai_tsukihi AS race_date,
            ROW_NUMBER() OVER (
                PARTITION BY se.ketto_toroku_bango 
                ORDER BY se.kaisai_nen DESC, se.kaisai_tsukihi DESC, se.race_bango DESC
            ) AS race_order
        FROM jvd_se se
        INNER JOIN jvd_ra ra ON (
            se.kaisai_nen = ra.kaisai_nen
            AND se.kaisai_tsukihi = ra.kaisai_tsukihi
            AND se.keibajo_code = ra.keibajo_code
            AND se.kaisai_kai = ra.kaisai_kai
            AND se.kaisai_nichime = ra.kaisai_nichime
            AND se.race_bango = ra.race_bango
        )
        WHERE se.ketto_toroku_bango = ANY(%s)
          AND (se.kaisai_nen < %s
               OR (se.kaisai_nen = %s AND se.kaisai_tsukihi < %s))
          AND TRIM(se.kakutei_chakujun) ~ '^[0-9]+$'
    )
    SELECT 
        ketto_toroku_bango,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS prev1_rank,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(soha_time), '')::FLOAT END) AS prev1_time,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(kohan_3f), '')::FLOAT END) AS prev1_last3f,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(corner_1), '')::INTEGER END) AS prev1_corner1,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(corner_4), '')::INTEGER END) AS prev1_corner4,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(bataiju), '')::INTEGER END) AS prev1_weight,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(zogen_sa), '')::INTEGER END) AS prev1_weight_diff,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(time_sa), '')::FLOAT END) AS prev1_time_diff,
        MAX(CASE WHEN race_order = 1 THEN NULLIF(TRIM(kyori), '')::INTEGER END) AS prev1_distance,
        MAX(CASE WHEN race_order = 1 THEN track_code END) AS prev1_track,
        MAX(CASE WHEN race_order = 1 THEN babajotai_code_shiba END) AS prev1_baba_shiba,
        MAX(CASE WHEN race_order = 1 THEN babajotai_code_dirt END) AS prev1_baba_dirt,
        MAX(CASE WHEN race_order = 1 THEN past_keibajo END) AS prev1_keibajo,
        MAX(CASE WHEN race_order = 1 THEN race_date END) AS prev1_race_date,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS prev2_rank,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(soha_time), '')::FLOAT END) AS prev2_time,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(kohan_3f), '')::FLOAT END) AS prev2_last3f,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(corner_1), '')::INTEGER END) AS prev2_corner1,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(corner_4), '')::INTEGER END) AS prev2_corner4,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(bataiju), '')::INTEGER END) AS prev2_weight,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(zogen_sa), '')::INTEGER END) AS prev2_weight_diff,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(time_sa), '')::FLOAT END) AS prev2_time_diff,
        MAX(CASE WHEN race_order = 2 THEN NULLIF(TRIM(kyori), '')::INTEGER END) AS prev2_distance,
        MAX(CASE WHEN race_order = 2 THEN track_code END) AS prev2_track,
        MAX(CASE WHEN race_order = 2 THEN babajotai_code_shiba END) AS prev2_baba_shiba,
        MAX(CASE WHEN race_order = 2 THEN babajotai_code_dirt END) AS prev2_baba_dirt,
        MAX(CASE WHEN race_order = 2 THEN past_keibajo END) AS prev2_keibajo,
        MAX(CASE WHEN race_order = 2 THEN race_date END) AS prev2_race_date,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS past5_rank_avg,
        MIN(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS past5_rank_best,
        MAX(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS past5_rank_worst,
        STDDEV(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS past5_rank_std,
        SUM(CASE WHEN race_order BETWEEN 1 AND 5 AND NULLIF(TRIM(kakutei_chakujun), '')::INTEGER <= 3 THEN 1 ELSE 0 END)::FLOAT 
            / NULLIF(COUNT(CASE WHEN race_order BETWEEN 1 AND 5 THEN 1 END), 0) AS past5_top3_rate,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(soha_time), '')::FLOAT END) AS past5_time_avg,
        MIN(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(soha_time), '')::FLOAT END) AS past5_time_best,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kohan_3f), '')::FLOAT END) AS past5_last3f_avg,
        MIN(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(kohan_3f), '')::FLOAT END) AS past5_last3f_best,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(bataiju), '')::INTEGER END) AS past5_weight_avg,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(corner_4), '')::INTEGER END) AS past5_avg_position,
        AVG(CASE WHEN race_order BETWEEN 1 AND 5 THEN NULLIF(TRIM(corner_1), '')::INTEGER END) AS past5_early_speed,
        COUNT(CASE WHEN race_order BETWEEN 1 AND 10 THEN 1 END) AS same_track_type_count,
        AVG(CASE WHEN race_order BETWEEN 1 AND 10 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS same_track_type_avg_rank,
        COUNT(CASE WHEN race_order BETWEEN 1 AND 10 THEN 1 END) AS same_distance_count,
        AVG(CASE WHEN race_order BETWEEN 1 AND 10 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS same_distance_avg_rank,
        COUNT(CASE WHEN race_order BETWEEN 1 AND 10 THEN 1 END) AS same_track_count,
        AVG(CASE WHEN race_order BETWEEN 1 AND 10 THEN NULLIF(TRIM(kakutei_chakujun), '')::INTEGER END) AS same_track_avg_rank
    FROM past_races
    GROUP BY ketto_toroku_bango
    """
    
    df_past = pd.read_sql_query(query_past, conn, params=(ketto_list, kaisai_nen, kaisai_nen, kaisai_tsukihi))
    
    df = df.merge(df_past, on='ketto_toroku_bango', how='left')
    
    logger.info(f"✅ 過去走データマージ: {len(df_past)}件")
    
    # ===== D. ターゲット変数（1列）=====
    def calc_target(chakujun):
        if pd.isna(chakujun) or chakujun == '':
            return -1
        try:
            rank = int(chakujun)
            return 1 if rank <= 3 else 0
        except:
            return -1
    
    df['target_top3'] = df['kakutei_chakujun'].apply(calc_target)
    
    # ===== E. JRDB特徴量（41列）+ G. JRDB過去走（4列）=====
    query_jrdb = """
    SELECT 
        '20' || kyi.race_shikonen AS kaisai_nen,
        kyi.keibajo_code,
        kyi.kaisai_kai,
        kyi.kaisai_nichime,
        kyi.race_bango,
        kyi.umaban,
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
        kyi.chokyo_yajirushi_code,
        kyi.kyusha_hyoka_code,
        kyi.kishu_kitai_rentai_ritsu,
        cyb.shiage_shisu,
        cyb.chokyo_hyoka,
        kyi.kyakushitsu_code,
        kyi.kyori_tekisei_code,
        kyi.joshodo_code,
        kyi.tekisei_code_omo,
        kyi.hizume_code,
        kyi.class_code,
        kyi.pace_yoso,
        kyi.uma_deokure_ritsu,
        kyi.rotation,
        kyi.hobokusaki_rank,
        kyi.kyusha_rank,
        kyi.bataiju AS bataiju_jrdb,
        kyi.bataiju_zogen,
        kyi.uma_start_shisu,
        joa.cid,
        joa.ls_shisu,
        joa.ls_hyoka,
        joa.em,
        joa.kyusha_bb_shirushi,
        joa.kishu_bb_shirushi,
        joa.kyusha_bb_nijumaru_tansho_kaishuritsu
    FROM jrd_kyi kyi
    LEFT JOIN jrd_cyb cyb ON (
        kyi.keibajo_code = cyb.keibajo_code
        AND kyi.race_shikonen = cyb.race_shikonen
        AND kyi.kaisai_kai = cyb.kaisai_kai
        AND kyi.kaisai_nichime = cyb.kaisai_nichime
        AND kyi.race_bango = cyb.race_bango
        AND kyi.umaban = cyb.umaban
    )
    LEFT JOIN jrd_joa joa ON (
        kyi.keibajo_code = joa.keibajo_code
        AND kyi.race_shikonen = joa.race_shikonen
        AND kyi.kaisai_kai = joa.kaisai_kai
        AND kyi.kaisai_nichime = joa.kaisai_nichime
        AND kyi.race_bango = joa.race_bango
        AND kyi.umaban = joa.umaban
    )
    WHERE kyi.race_shikonen LIKE %s
      AND kyi.keibajo_code = ANY(%s)
    """
    
    keibajo_codes = df['keibajo_code'].unique().tolist()
    # race_shikonenは 'YYMMDD' 形式 (例: '260222')
    # ただし実際のDBには 'YYMMDDXXXX' (10桁) の場合もあるため LIKE 検索
    race_shikonen_filter = kaisai_nen[2:4] + kaisai_tsukihi + '%'  # '26' + '0228' + '%' → '260228%'
    df_jrdb = pd.read_sql_query(query_jrdb, conn, params=(race_shikonen_filter, keibajo_codes))
    
    # ゼロパディング
    df_jrdb['kaisai_kai'] = df_jrdb['kaisai_kai'].astype(str).str.zfill(2)
    df_jrdb['kaisai_nichime'] = df_jrdb['kaisai_nichime'].astype(str).str.zfill(2)
    
    merge_keys_jrdb = ['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']
    df = df.merge(df_jrdb, on=merge_keys_jrdb, how='left')
    
    logger.info(f"✅ JRDB特徴量マージ: {len(df_jrdb)}件 (対象日: {kaisai_tsukihi})")
    
    if len(df_jrdb) == 0:
        logger.warning(f"⚠️  JRDBデータが見つかりません！")
        logger.warning(f"⚠️  以下を確認してください:")
        logger.warning(f"    1. JRDBサイトから {target_date} のデータをダウンロード済みか")
        logger.warning(f"    2. PC-KEIBAでJRDBデータを取り込み済みか")
        logger.warning(f"    3. PostgreSQLのjrd_kyi/cyb/joaテーブルにデータがあるか")
        logger.warning(f"")
        logger.warning(f"⚠️  JRDBデータなしで予測を続行しますが、精度が低下します！")
    
    # JRDB過去走（prev1_race_pace等）- 簡略版（前走のみ）
    query_jrdb_past = """
    WITH past_races_jrdb AS (
        SELECT 
            sed.ketto_toroku_bango,
            sed.kaisai_nen,
            sed.kaisai_tsukihi,
            sed.race_bango,
            sed.race_pace,
            sed.uma_pace,
            sed.pace_shisu,
            sed.batai_code,
            ROW_NUMBER() OVER (
                PARTITION BY sed.ketto_toroku_bango 
                ORDER BY sed.kaisai_nen DESC, sed.kaisai_tsukihi DESC, sed.race_bango DESC
            ) AS race_order
        FROM jrd_sed sed
        WHERE sed.ketto_toroku_bango = ANY(%s)
          AND (sed.kaisai_nen < %s
               OR (sed.kaisai_nen = %s AND sed.kaisai_tsukihi < %s))
    )
    SELECT 
        ketto_toroku_bango,
        MAX(CASE WHEN race_order = 1 THEN race_pace END) AS prev1_race_pace,
        MAX(CASE WHEN race_order = 1 THEN uma_pace END) AS prev1_uma_pace,
        MAX(CASE WHEN race_order = 1 THEN pace_shisu END) AS prev1_pace_shisu,
        MAX(CASE WHEN race_order = 1 THEN batai_code END) AS prev1_batai_code
    FROM past_races_jrdb
    GROUP BY ketto_toroku_bango
    """
    
    # JRDBは8桁なので、JRA-VAN10桁から変換
    ketto_short_list = [k[2:10] if len(k) >= 10 else k for k in ketto_list]
    
    df_jrdb_past = pd.read_sql_query(query_jrdb_past, conn, params=(ketto_short_list, kaisai_nen, kaisai_nen, kaisai_tsukihi))
    
    # JRA-VAN ketto（10桁）とマージするため、10桁に戻す（先頭に'01'など仮想コードを追加する方法もあるが、ここでは8桁のみマッチング）
    # 簡易実装: ketto_toroku_bango の後ろ8桁でマージ
    df['ketto_short'] = df['ketto_toroku_bango'].str[2:10]
    df_jrdb_past_renamed = df_jrdb_past.rename(columns={'ketto_toroku_bango': 'ketto_short'})
    
    df = df.merge(df_jrdb_past_renamed, on='ketto_short', how='left')
    df = df.drop(columns=['ketto_short'])
    
    logger.info(f"✅ JRDB過去走マージ: {len(df_jrdb_past)}件")
    
    # ===== F. 派生特徴量（3列）=====
    df['kyori'] = pd.to_numeric(df['kyori'], errors='coerce')
    df['prev1_distance'] = pd.to_numeric(df['prev1_distance'], errors='coerce')
    
    df['distance_change'] = (df['kyori'] - df['prev1_distance']).fillna(0).astype('Int32')
    df['track_change'] = ((df['track_code'] != df['prev1_track']) & 
                          df['track_code'].notna() & 
                          df['prev1_track'].notna()).astype('Int8')
    df['class_change'] = (df['grade_code'].notna() & (df['grade_code'] != '')).astype('Int8')
    
    logger.info(f"✅ 派生特徴量生成完了")
    
    # ===== race_id を先に生成（カテゴリエンコード前に） =====
    df['race_id'] = (
        df['kaisai_nen'].astype(str) +
        df['kaisai_tsukihi'].astype(str).str.zfill(4) +
        df['keibajo_code'].astype(str).str.zfill(2) +
        df['race_bango'].astype(str).str.zfill(2)
    )
    logger.info(f"✅ race_id 生成完了（サンプル: {df['race_id'].iloc[0] if len(df) > 0 else 'なし'}）")
    
    # ===== 表示用カラムを別途保存 =====
    display_col_names = ['bamei', 'kishumei_ryakusho', 'chokyoshimei_ryakusho', 'banushimei', 'keibajo_code', 'kaisai_tsukihi', 'race_bango', 'umaban']
    display_data = {}
    for col in display_col_names:
        if col in df.columns:
            display_data[col] = df[col].copy()
            logger.info(f"🔍 DEBUG: {col} を表示用として保存（サンプル: {df[col].iloc[0] if len(df) > 0 else 'なし'}）")
    
    # ===== 欠損値処理 =====
    # 数値列は -1 埋め
    numeric_cols = df.select_dtypes(include=['int64', 'float64', 'Int32', 'float32']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    # カテゴリ列は 'unknown' 埋め
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    # 学習に不要なカラム（数値化しないカラム）
    # keibajo_code, kaisai_tsukihi, race_bango, umaban は race_id 生成に必要なので保護
    exclude_cols = ['race_id', 'kakutei_chakujun', 'ketto_toroku_bango', 'keibajo_code', 'kaisai_tsukihi', 'race_bango', 'umaban']
    
    # カテゴリを数値エンコーディング（Phase 5と同じ）
    # 表示用カラムも含めて全て数値化（学習に必要）
    for col in categorical_cols:
        if col not in exclude_cols:
            df[col] = df[col].astype('category').cat.codes
    
    logger.info(f"✅ 特徴量生成完了: {len(df)}行 × {len(df.columns)}列")
    
    # 表示用データを別途返却
    return df, display_data

# ============================================================================
# Phase 5ロジック: アンサンブル予測
# ============================================================================

def load_models():
    """Phase 3-4-5 モデル読み込み"""
    logger = logging.getLogger(__name__)
    logger.info("\n" + "=" * 80)
    logger.info("Phase 5 モデル読み込み")
    logger.info("=" * 80)
    
    models = {}
    
    binary_path = 'models/jra_binary_model.txt'
    ranking_path = 'models/jra_ranking_model.txt'
    regression_paths = ['models/jra_regression_model_optimized.txt', 'models/jra_regression_model.txt']
    
    if Path(binary_path).exists():
        models['binary'] = lgb.Booster(model_file=binary_path)
        logger.info(f"✅ 二値分類モデル: {binary_path}")
    else:
        logger.error(f"❌ 二値分類モデルが見つかりません: {binary_path}")
        sys.exit(1)
    
    if Path(ranking_path).exists():
        models['ranking'] = lgb.Booster(model_file=ranking_path)
        logger.info(f"✅ ランキングモデル: {ranking_path}")
    else:
        logger.error(f"❌ ランキングモデルが見つかりません: {ranking_path}")
        sys.exit(1)
    
    for path in regression_paths:
        if Path(path).exists():
            models['regression'] = lgb.Booster(model_file=path)
            logger.info(f"✅ 回帰モデル: {path}")
            break
    else:
        logger.error(f"❌ 回帰モデルが見つかりません")
        sys.exit(1)
    
    return models

def ensemble_predict(models, df, display_data):
    """アンサンブル予測（Phase 5と同じロジック）"""
    logger = logging.getLogger(__name__)
    logger.info("\n" + "=" * 80)
    logger.info("アンサンブル予測実行")
    logger.info("=" * 80)
    
    # race_id は既に fetch_today_data() で生成済み
    if 'race_id' not in df.columns:
        logger.error("❌ race_id が見つかりません。fetch_today_data() で生成されているはずです。")
        raise ValueError("race_id カラムが存在しません")
    
    # 各モデルで予測
    try:
        binary_feature_names = models['binary'].feature_name()
        for feat in binary_feature_names:
            if feat not in df.columns:
                df[feat] = -1
        X_binary = df[binary_feature_names].to_numpy()
        binary_proba = models['binary'].predict(X_binary)
        logger.info(f"✅ 二値分類予測完了（特徴量: {len(binary_feature_names)}列）")
    except Exception as e:
        logger.error(f"❌ 二値分類予測エラー: {e}")
        binary_proba = np.zeros(len(df))
    
    try:
        ranking_feature_names = models['ranking'].feature_name()
        for feat in ranking_feature_names:
            if feat not in df.columns:
                df[feat] = -1
        X_ranking = df[ranking_feature_names].to_numpy()
        ranking_score = models['ranking'].predict(X_ranking)
        logger.info(f"✅ ランキング予測完了（特徴量: {len(ranking_feature_names)}列）")
    except Exception as e:
        logger.error(f"❌ ランキング予測エラー: {e}")
        ranking_score = np.zeros(len(df))
    
    try:
        regression_feature_names = models['regression'].feature_name()
        for feat in regression_feature_names:
            if feat not in df.columns:
                df[feat] = -1
        X_regression = df[regression_feature_names].to_numpy()
        time_pred = models['regression'].predict(X_regression)
        logger.info(f"✅ タイム予測完了（特徴量: {len(regression_feature_names)}列）")
    except Exception as e:
        logger.error(f"❌ タイム予測エラー: {e}")
        time_pred = np.zeros(len(df))
    
    df['binary_proba'] = binary_proba
    df['ranking_score'] = ranking_score
    df['time_pred'] = time_pred
    
    # アンサンブルスコア計算（Phase 5と同じ）
    logger.info("\n🔧 アンサンブルスコア計算中...")
    
    race_normalized = []
    
    for race_id, group in df.groupby('race_id'):
        group = group.copy()
        
        # ランキングスコア正規化
        ranking_min = group['ranking_score'].min()
        ranking_max = group['ranking_score'].max()
        if ranking_max > ranking_min:
            group['ranking_norm'] = 1 - (group['ranking_score'] - ranking_min) / (ranking_max - ranking_min)
        else:
            group['ranking_norm'] = 0.5
        
        # タイムスコア正規化
        time_min = group['time_pred'].min()
        time_max = group['time_pred'].max()
        if time_max > time_min:
            group['time_norm'] = 1 - (group['time_pred'] - time_min) / (time_max - time_min)
        else:
            group['time_norm'] = 0.5
        
        # アンサンブルスコア（重み: 二値30% + ランキング40% + タイム30%）
        group['ensemble_score'] = (
            0.30 * group['binary_proba'] +
            0.40 * group['ranking_norm'] +
            0.30 * group['time_norm']
        )
        
        # レース内順位
        group['predicted_rank'] = group['ensemble_score'].rank(ascending=False, method='first')
        
        race_normalized.append(group)
    
    result_df = pd.concat(race_normalized, ignore_index=True)
    
    logger.info(f"✅ アンサンブルスコア計算完了")
    
    # 偏差値計算（レース内で標準化）
    logger.info("\n🔧 偏差値計算中...")
    result_df = result_df.groupby('race_id').apply(calculate_hensachi_for_race)
    result_df = result_df.reset_index(drop=True)
    
    # 偏差値ランク付与
    result_df['hensachi_rank'] = result_df['hensachi'].apply(assign_hensachi_rank)
    
    logger.info(f"✅ 偏差値計算完了")
    logger.info(f"偏差値範囲: {result_df['hensachi'].min():.2f} - {result_df['hensachi'].max():.2f}")
    
    # 表示用データを復元
    for col_name, col_data in display_data.items():
        if len(col_data) == len(result_df):
            result_df[col_name] = col_data.values
            logger.info(f"🔍 DEBUG: {col_name} を復元（サンプル: {result_df[col_name].iloc[0] if len(result_df) > 0 else 'なし'}）")
    
    return result_df

# ============================================================================
# ユーティリティ関数
# ============================================================================

def calculate_hensachi_for_race(group):
    """レース内で偏差値を計算
    
    Args:
        group: レース内の全馬のDataFrame
    
    Returns:
        DataFrame: 偏差値が追加されたDataFrame
    """
    mean = group['ensemble_score'].mean()
    std = group['ensemble_score'].std()
    
    if std == 0 or pd.isna(std):
        # 標準偏差が0の場合は全て偏差値50
        group['hensachi'] = 50.0
    else:
        z_score = (group['ensemble_score'] - mean) / std
        group['hensachi'] = 50 + 10 * z_score
    
    return group

def assign_hensachi_rank(hensachi: float) -> str:
    """偏差値からランクを付与（S/A/B/C/D/E）
    
    Args:
        hensachi: 偏差値
    
    Returns:
        str: ランク（S/A/B/C/D/E）
    """
    if hensachi >= 70.0:
        return 'S'
    elif hensachi >= 65.0:
        return 'A'
    elif hensachi >= 60.0:
        return 'B'
    elif hensachi >= 55.0:
        return 'C'
    elif hensachi >= 50.0:
        return 'D'
    else:
        return 'E'

def get_score_rank(score: float) -> str:
    """スコアをランク評価（S/A/B/C/D）に変換（旧関数、互換性のため残す）"""
    if score >= 0.85:
        return 'S'
    elif score >= 0.70:
        return 'A'
    elif score >= 0.50:
        return 'B'
    elif score >= 0.30:
        return 'C'
    else:
        return 'D'

def should_recommend_purchase(hensachi_rank: str, tansho_odds: float) -> tuple:
    """購入推奨判定（Phase 2C分析結果に基づく）
    
    判定基準（回収率80%以上）:
    - Sランク: 問答無用で購入推奨
    - Aランク: オッズ5倍未満なら購入推奨
    - Bランク: オッズ3倍未満なら購入推奨
    
    Args:
        hensachi_rank: 偏差値ランク（S/A/B/C/D/E）
        tansho_odds: 単勝オッズ
    
    Returns:
        tuple: (bool, str) = (購入推奨フラグ, 推奨理由)
    """
    if pd.isna(tansho_odds):
        return False, ""
    
    if hensachi_rank == 'S':
        return True, "🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨"
    elif hensachi_rank == 'A' and tansho_odds < 5.0:
        return True, f"⭐ Aランク（偏差値65-70）× オッズ{tansho_odds:.1f}倍: 回収率80%以上"
    elif hensachi_rank == 'B' and tansho_odds < 3.0:
        return True, f"✅ Bランク（偏差値60-65）× オッズ{tansho_odds:.1f}倍: 回収率80%以上"
    else:
        return False, ""

def generate_betting_recommendations(top_horses):
    """購入推奨を生成"""
    recommendations = []
    
    if len(top_horses) >= 1:
        honmei = top_horses.iloc[0]
        recommendations.append(f"**🎯 本命軸**")
        recommendations.append(f"- 単勝: **{int(honmei['umaban'])}番**")
        
        if len(top_horses) >= 2:
            fukusho_list = ', '.join([f"{int(h['umaban'])}番" for h in [top_horses.iloc[0], top_horses.iloc[1]]])
            recommendations.append(f"- 複勝: **{fukusho_list}**")
        recommendations.append("")
    
    if len(top_horses) >= 3:
        recommendations.append(f"**🔄 相手候補**")
        uma1, uma2, uma3 = int(top_horses.iloc[0]['umaban']), int(top_horses.iloc[1]['umaban']), int(top_horses.iloc[2]['umaban'])
        uma4 = int(top_horses.iloc[3]['umaban']) if len(top_horses) >= 4 else None
        recommendations.append(f"- 馬単: {uma1}→{uma2}、{uma2}→{uma1}、{uma1}→{uma3}、{uma3}→{uma1}")
        
        if len(top_horses) >= 6:
            # 軸: 1位.2位
            jiku = f"{uma1}.{uma2}"
            # 相手1: 2.3.4位
            aite1 = f"{uma2}.{uma3}.{uma4}"
            # 相手2: 2~6位
            aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 6)])
            recommendations.append(f"- 三連複: {jiku} - {aite1} - {aite2}")
        else:
            box_nums = '.'.join([str(int(h['umaban'])) for _, h in top_horses.iterrows()])
            recommendations.append(f"- 三連複: {box_nums} ボックス")
    
    return '\n'.join(recommendations)

# ============================================================================
# 結果保存（Markdownレポート形式）
# ============================================================================

def save_predictions(result_df, target_date: str):
    """予測結果をMarkdownレポート形式で保存"""
    logger = logging.getLogger(__name__)
    logger.info("\n" + "=" * 80)
    logger.info("予測結果保存（Markdownレポート形式）")
    logger.info("=" * 80)
    
    output_dir = Path('results')
    output_dir.mkdir(exist_ok=True)
    
    # 競馬場名マッピング
    keibajo_names = {
        '01': '札幌', '02': '函館', '03': '福島', '04': '新潟', '05': '東京',
        '06': '中山', '07': '中京', '08': '京都', '09': '阪神', '10': '小倉'
    }
    
    # 馬番0を除外（データ異常）
    if 'umaban' in result_df.columns:
        try:
            result_df['umaban_int'] = pd.to_numeric(result_df['umaban'], errors='coerce')
            result_df = result_df[result_df['umaban_int'] >= 1].copy()
            result_df = result_df.drop(columns=['umaban_int'])
            logger.info(f"  馬番0を除外しました（残り: {len(result_df)}行）")
        except Exception as e:
            logger.warning(f"  馬番フィルタリングエラー: {e}")
    
    # keibajo_code を文字列型に統一（'05', '09', '10'）
    if 'keibajo_code' in result_df.columns:
        result_df['keibajo_code'] = result_df['keibajo_code'].astype(str).str.zfill(2)
    
    # 競馬場名追加
    result_df['keibajo_name'] = result_df['keibajo_code'].map(keibajo_names)
    
    # デバッグ: マッピング結果確認
    logger.info(f"🔍 DEBUG: keibajo_code ユニーク値 = {result_df['keibajo_code'].unique()}")
    logger.info(f"🔍 DEBUG: keibajo_name ユニーク値 = {result_df['keibajo_name'].unique()}")
    
    # レース別にMarkdownレポート生成
    report_lines = []
    report_lines.append(f"# 🏇 JRA競馬AI予想レポート")
    report_lines.append(f"")
    report_lines.append(f"**予想日**: {target_date[:4]}年{target_date[4:6]}月{target_date[6:8]}日")
    report_lines.append(f"**生成日時**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    report_lines.append(f"**モデル**: Phase 5 アンサンブル（二値30% + ランキング40% + 回帰30%）")
    report_lines.append(f"")
    report_lines.append(f"---")
    report_lines.append(f"")
    
    # レース別処理
    for race_id, group in result_df.groupby('race_id'):
        group = group.sort_values('predicted_rank').reset_index(drop=True)
        race_info = group.iloc[0]
        keibajo_name = race_info['keibajo_name']
        race_no = int(race_info['race_bango'])
        
        # レース情報ヘッダー
        report_lines.append(f"## 🏇 {keibajo_name} 第{race_no}R 予想")
        report_lines.append(f"")
        
        # 予想順位
        report_lines.append(f"### 📊 予想順位")
        report_lines.append(f"")
        
        for idx, row in group.iterrows():
            rank = int(row['predicted_rank'])
            umaban = int(row['umaban'])
            bamei_raw = row.get('bamei', f"{umaban}番馬")
            # bameiが整数型・float型・その他の場合を安全に処理
            if pd.isna(bamei_raw):
                bamei = f"{umaban}番馬"
            elif isinstance(bamei_raw, (int, float)):
                bamei = str(int(bamei_raw))
            else:
                bamei = str(bamei_raw).strip() if hasattr(bamei_raw, 'strip') else str(bamei_raw)
            # 元のスコアを使用（正規化なし）
            score = row['ensemble_score']
            score_rank = get_score_rank(score)
            
            if rank <= 3:
                report_lines.append(f"**{rank}. {umaban}番 {bamei}** （スコア: {score:.2f} / {score_rank}）")
            else:
                report_lines.append(f"{rank}. {umaban}番 {bamei} （スコア: {score:.2f} / {score_rank}）")
        
        report_lines.append(f"")
        
        # 購入推奨
        report_lines.append(f"### 💰 購入推奨")
        report_lines.append(f"")
        top_horses = group.head(min(6, len(group)))
        betting_text = generate_betting_recommendations(top_horses)
        report_lines.append(betting_text)
        report_lines.append(f"")
        report_lines.append(f"---")
        report_lines.append(f"")
        
        # コンソール出力
        logger.info(f"\n{keibajo_name} {race_no}R:")
        for idx, row in group.head(3).iterrows():
            bamei_raw = row.get('bamei', f"{int(row['umaban'])}番馬")
            # bameiが整数型・float型・その他の場合を安全に処理
            if pd.isna(bamei_raw):
                bamei = f"{int(row['umaban'])}番馬"
            elif isinstance(bamei_raw, (int, float)):
                bamei = str(int(bamei_raw))
            else:
                bamei = str(bamei_raw).strip() if hasattr(bamei_raw, 'strip') else str(bamei_raw)
            logger.info(f"  {int(row['predicted_rank'])}. {int(row['umaban'])}番 {bamei} "
                       f"（スコア: {row['ensemble_score']:.2f} / {get_score_rank(row['ensemble_score'])}）")
    
    # Markdownファイル保存
    report_path = output_dir / f"predictions_{target_date}.md"
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report_lines))
    
    # CSV形式も保存（バックアップ用）
    csv_path = output_dir / f"predictions_{target_date}.csv"
    output_cols = ['race_id', 'kaisai_tsukihi', 'keibajo_code', 'keibajo_name', 'race_bango', 'umaban']
    if 'bamei' in result_df.columns:
        output_cols.append('bamei')
    if 'kishumei_ryakusho' in result_df.columns:
        output_cols.append('kishumei_ryakusho')
    if 'banushimei' in result_df.columns:
        output_cols.append('banushimei')
    output_cols.extend(['binary_proba', 'ranking_score', 'time_pred', 'ensemble_score', 'predicted_rank'])
    
    available_cols = [c for c in output_cols if c in result_df.columns]
    result_df[available_cols].to_csv(csv_path, index=False, encoding='utf-8-sig')
    
    report_size_kb = report_path.stat().st_size / 1024
    csv_size_kb = csv_path.stat().st_size / 1024
    
    logger.info(f"\n✅ 予測結果保存完了:")
    logger.info(f"  📄 Markdownレポート: {report_path} ({report_size_kb:.2f} KB)")
    logger.info(f"  📊 CSV (バックアップ): {csv_path} ({csv_size_kb:.2f} KB)")
    logger.info(f"  レコード数: {len(result_df)}行")
    logger.info(f"  レース数: {result_df['race_id'].nunique()}レース")

# ============================================================================
# 追加出力フォーマット（note / ブッカーズ / Twitter）
# ============================================================================

def filter_valid_umaban(df):
    """馬番0を除外"""
    if 'umaban' in df.columns:
        try:
            df['umaban_int'] = pd.to_numeric(df['umaban'], errors='coerce')
            df = df[df['umaban_int'] >= 1].copy()
            df = df.drop(columns=['umaban_int'])
        except Exception as e:
            logging.getLogger(__name__).warning(f"  馬番フィルタリングエラー: {e}")
    return df

def generate_note_format(result_df, target_date: str, keibajo_name: str = "JRA"):
    """note形式の予想レポートを生成"""
    result_df = filter_valid_umaban(result_df)
    
    lines = []
    lines.append(f"# 🏇 {keibajo_name}競馬 AI予想")
    lines.append(f"")
    lines.append(f"**開催日**: {target_date[:4]}年{target_date[4:6]}月{target_date[6:8]}日  ")
    lines.append(f"**対象レース**: {result_df.groupby('race_id').ngroups}R  ")
    lines.append(f"")
    lines.append(f"---")
    lines.append(f"")
    lines.append(f"## 💰 購入推奨基準")
    lines.append(f"")
    lines.append(f"**偏差値ランク別・単勝推奨条件:**")
    lines.append(f"")
    lines.append(f"- **🌟 Sランク（偏差値70以上）**: 全オッズ帯で購入推奨")
    lines.append(f"- **⭐ Aランク（偏差値65-70）**: オッズ5倍未満で購入推奨")
    lines.append(f"- **✅ Bランク（偏差値60-65）**: オッズ3倍未満で購入推奨")
    lines.append(f"- **C/D/Eランク**: 推奨しない")
    lines.append(f"")
    lines.append(f"※ 偏差値はレース内での相対評価（平均50、標準偏差10）")
    lines.append(f"")
    lines.append(f"---")
    lines.append(f"")
    lines.append(f"## 📋 予想結果一覧")
    lines.append(f"")
    
    for race_id, group in result_df.groupby('race_id'):
        group = group.sort_values('predicted_rank').reset_index(drop=True)
        race_info = group.iloc[0]
        
        # 競馬場名とレース番号を取得
        keibajo_display = race_info.get('keibajo_name', keibajo_name)
        race_no = int(race_info['race_bango'])
        
        lines.append(f"")
        lines.append(f"## 🏇 {keibajo_display} 第{race_no}R 予想")
        lines.append(f"")
        lines.append(f"### 📊 予想順位（スコア / 偏差値[ランク]）")
        lines.append(f"")
        
        for idx, row in group.iterrows():
            rank = int(row['predicted_rank'])
            umaban = int(row['umaban'])
            bamei = str(row.get('bamei', f"{umaban}番馬")).strip()
            score = row['ensemble_score']
            hensachi = row.get('hensachi', np.nan)
            hensachi_rank = row.get('hensachi_rank', '')
            
            # シンプルな表示形式: スコア / 偏差値[ランク]
            if not pd.isna(hensachi):
                score_info = f"{score:.2f} / {hensachi:.1f}[{hensachi_rank}]"
            else:
                score_info = f"{score:.2f}"
            
            # 1位の馬の場合、購入推奨判定を追加
            recommendation_str = ""
            if rank == 1 and 'tansho_odds' in row:
                should_buy, reason = should_recommend_purchase(hensachi_rank, row.get('tansho_odds', np.nan))
                if should_buy:
                    recommendation_str = f"\n  💰 **購入推奨**: {reason}"
            
            if rank <= 3:
                lines.append(f"**{rank}. {umaban}番 {bamei}** {score_info}{recommendation_str}")
            else:
                lines.append(f"{rank}. {umaban}番 {bamei} {score_info}")
        
        lines.append(f"")
        lines.append(f"### 💰 購入推奨")
        lines.append(f"")
        
        top_horses = group.head(6)
        recommendations = generate_betting_recommendations(top_horses)
        lines.append(recommendations)
        lines.append(f"")
        lines.append(f"")
        lines.append(f"---")
        lines.append(f"")
    
    # 注意事項とランク評価基準を追加
    lines.append(f"")
    lines.append(f"## ⚠️ 注意事項")
    lines.append(f"")
    lines.append(f"> 本予想はAIによる分析結果です。")
    lines.append(f"> 投資判断は自己責任でお願いします。")
    lines.append(f"> 過去の成績は将来の結果を保証するものではありません。")
    lines.append(f"")
    lines.append(f"---")
    lines.append(f"")
    lines.append(f"### 📌 ランク評価基準")
    lines.append(f"")
    lines.append(f"- **S**: スコア0.80以上（最有力候補）")
    lines.append(f"- **A**: スコア0.70-0.79（有力候補）")
    lines.append(f"- **B**: スコア0.60-0.69（注目候補）")
    lines.append(f"- **C**: スコア0.50-0.59（穴候補）")
    lines.append(f"- **D**: スコア0.50未満（警戒候補）")
    lines.append(f"")
    lines.append(f"---")
    lines.append(f"")
    date_obj = datetime.strptime(target_date, '%Y%m%d')
    lines.append(f"*{keibajo_name}競馬 {date_obj.strftime('%Y年%m月%d日')} 開催分*  ")
    lines.append(f"*中央競馬AI予想システム v3*")
    
    return '\n'.join(lines)

def generate_bookers_format(result_df, target_date: str, keibajo_name: str = "JRA"):
    """ブッカーズ形式の予想レポートを生成"""
    result_df = filter_valid_umaban(result_df)
    
    lines = []
    race_count = result_df.groupby('race_id').ngroups
    lines.append(f"🏇 【競馬AI】{keibajo_name}競馬 全{race_count}R予想")
    lines.append(f"")
    
    date_obj = datetime.strptime(target_date, '%Y%m%d')
    lines.append(f"📅 {date_obj.strftime('%Y年%m月%d日')}({date_obj.strftime('%a')})")
    lines.append(f"")
    lines.append(f"本日はAI予想システムによる分析結果をお届けします。")
    lines.append(f"過去の膨大なレースデータから、今日の馬場状態と出走馬の相性を完全数値化しました。")
    lines.append(f"")
    lines.append(f"💰 購入推奨基準")
    lines.append(f"")
    lines.append(f"【偏差値ランク別・単勝推奨条件】")
    lines.append(f"🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨")
    lines.append(f"⭐ Aランク（偏差値65-70）: オッズ5倍未満で購入推奨")
    lines.append(f"✅ Bランク（偏差値60-65）: オッズ3倍未満で購入推奨")
    lines.append(f"※ C/D/Eランクは推奨しない")
    lines.append(f"※ 偏差値はレース内での相対評価（平均50、標準偏差10）")
    lines.append(f"")
    lines.append(f"---")
    
    for race_id, group in result_df.groupby('race_id'):
        group = group.sort_values('predicted_rank').reset_index(drop=True)
        race_info = group.iloc[0]
        
        # 競馬場名とレース番号を取得
        keibajo_display = race_info.get('keibajo_name', keibajo_name)
        race_no = int(race_info['race_bango'])
        top_horses = group.head(6)
        
        lines.append(f"")
        lines.append(f"")
        lines.append(f"🏁 {keibajo_display} 第{race_no}R 予想結果")
        lines.append(f"")
        lines.append(f"🎯 AI推奨馬")
        lines.append(f"")
        
        for idx, row in top_horses.iterrows():
            umaban = int(row['umaban'])
            bamei = str(row.get('bamei', f"{umaban}番馬")).strip()
            score = row['ensemble_score']
            rank = int(row['predicted_rank'])
            hensachi = row.get('hensachi', np.nan)
            hensachi_rank = row.get('hensachi_rank', '')
            
            # シンプルな表示形式: スコア / 偏差値[ランク]
            if not pd.isna(hensachi):
                score_info = f"{score:.2f} / {hensachi:.1f}[{hensachi_rank}]"
            else:
                score_info = f"{score:.2f}"
            
            if rank == 1:
                lines.append(f"◎ {umaban} {bamei} ({score_info})")
                # 購入推奨判定を追加
                if 'tansho_odds' in row:
                    should_buy, reason = should_recommend_purchase(hensachi_rank, row.get('tansho_odds', np.nan))
                    if should_buy:
                        lines.append(f"💰 購入推奨: {reason}")
            elif rank == 2:
                lines.append(f"")
                lines.append(f"○ {umaban} {bamei} ({score_info})")
            elif rank == 3:
                lines.append(f"")
                lines.append(f"▲ {umaban} {bamei} ({score_info})")
            elif rank == 4:
                lines.append(f"")
                lines.append(f"△ {umaban} {bamei}")
            elif rank == 5:
                lines.append(f"△ {umaban} {bamei}")
        
        lines.append(f"")
        lines.append(f"💰 購入推奨（買い目）")
        lines.append(f"")
        lines.append(f"【単勝/複勝】")
        
        honmei = top_horses.iloc[0]
        aite = top_horses.iloc[1] if len(top_horses) >= 2 else None
        lines.append(f"・単勝：{int(honmei['umaban'])}")
        if aite is not None:
            lines.append(f"・複勝：{int(honmei['umaban'])}, {int(aite['umaban'])}")
        
        if len(top_horses) >= 3:
            lines.append(f"")
            lines.append(f"【馬単/馬連】")
            uma1, uma2, uma3 = int(top_horses.iloc[0]['umaban']), int(top_horses.iloc[1]['umaban']), int(top_horses.iloc[2]['umaban'])
            lines.append(f"・{uma1} ↔ {uma2}, {uma3} (各2点)")
        
        if len(top_horses) >= 3:
            lines.append(f"")
            lines.append(f"【三連複】")
            if len(top_horses) >= 6:
                # 軸: 1位.2位
                jiku = f"{uma1}.{uma2}"
                # 相手1: 2.3.4位
                uma4 = int(top_horses.iloc[3]['umaban'])
                aite1 = f"{uma2}.{uma3}.{uma4}"
                # 相手2: 2~6位
                aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 6)])
                lines.append(f"・{jiku} - {aite1} - {aite2}")
            else:
                box_nums = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(len(top_horses))])
                lines.append(f"・{box_nums} ボックス")
        
        lines.append(f"")
        lines.append(f"")
        lines.append(f"---")
    
    return '\n'.join(lines)

def generate_twitter_format(result_df, target_date: str, keibajo_name: str = "JRA"):
    """Twitter形式の予想を生成"""
    result_df = filter_valid_umaban(result_df)
    
    lines = []
    
    date_obj = datetime.strptime(target_date, '%Y%m%d')
    month = date_obj.strftime('%m')
    day = date_obj.strftime('%d')
    weekday_short = date_obj.strftime('%a')
    weekday_map = {'Mon': '月', 'Tue': '火', 'Wed': '水', 'Thu': '木', 'Fri': '金', 'Sat': '土', 'Sun': '日'}
    weekday_ja = weekday_map.get(weekday_short, weekday_short)
    
    for race_id, group in result_df.groupby('race_id'):
        group = group.sort_values('predicted_rank').reset_index(drop=True)
        race_info = group.iloc[0]
        
        # 競馬場名とレース番号を取得
        keibajo_display = race_info.get('keibajo_name', keibajo_name)
        race_no = int(race_info['race_bango'])
        top_horses = group.head(6)
        
        lines.append(f"{month}/{day}（{weekday_ja}）{keibajo_display}{race_no}R")
        
        honmei = top_horses.iloc[0]
        aite = top_horses.iloc[1] if len(top_horses) >= 2 else None
        lines.append(f"単勝：{int(honmei['umaban'])}")
        if aite is not None:
            lines.append(f"複勝：{int(honmei['umaban'])}, {int(aite['umaban'])}")
        
        if len(top_horses) >= 3:
            uma1, uma2, uma3 = int(top_horses.iloc[0]['umaban']), int(top_horses.iloc[1]['umaban']), int(top_horses.iloc[2]['umaban'])
            lines.append(f"馬単：{uma1}→{uma2}、{uma2}→{uma1}、{uma1}→{uma3}、{uma3}→{uma1}")
        
        if len(top_horses) >= 6:
            uma4 = int(top_horses.iloc[3]['umaban'])
            # 軸: 1位.2位
            jiku = f"{uma1}.{uma2}"
            # 相手1: 2.3.4位
            aite1 = f"{uma2}.{uma3}.{uma4}"
            # 相手2: 2~6位
            aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 6)])
            lines.append(f"三連複：{jiku} - {aite1} - {aite2}")
        
        lines.append(f"")
        lines.append(f"=" * 50)
        lines.append(f"")
    
    return '\n'.join(lines)

def save_additional_formats(result_df, target_date: str):
    """競馬場別にnote/ブッカーズ/Twitter形式で保存"""
    logger = logging.getLogger(__name__)
    output_dir = Path('results')
    output_dir.mkdir(exist_ok=True)
    
    # 競馬場名マッピング
    keibajo_names = {
        '01': '札幌', '02': '函館', '03': '福島', '04': '新潟', '05': '東京',
        '06': '中山', '07': '中京', '08': '京都', '09': '阪神', '10': '小倉'
    }
    
    # keibajo_code を文字列型に統一（'05', '09', '10'）
    if 'keibajo_code' in result_df.columns:
        result_df['keibajo_code'] = result_df['keibajo_code'].astype(str).str.zfill(2)
    
    # keibajo_name カラムが無い場合は追加
    if 'keibajo_name' not in result_df.columns:
        result_df['keibajo_name'] = result_df['keibajo_code'].map(keibajo_names)
    
    # 競馬場別にグループ化
    for keibajo_code, keibajo_group in result_df.groupby('keibajo_code'):
        keibajo_name = keibajo_names.get(keibajo_code, f"競馬場{keibajo_code}")
        
        logger.info(f"\n📁 {keibajo_name}競馬の予想を生成中...")
        
        # note形式
        note_content = generate_note_format(keibajo_group, target_date, keibajo_name)
        note_path = output_dir / f"{keibajo_name}_{target_date}_note.txt"
        with open(note_path, 'w', encoding='utf-8') as f:
            f.write(note_content)
        logger.info(f"  📝 note形式: {note_path} ({note_path.stat().st_size / 1024:.2f} KB)")
        
        # ブッカーズ形式
        bookers_content = generate_bookers_format(keibajo_group, target_date, keibajo_name)
        bookers_path = output_dir / f"{keibajo_name}_{target_date}_bookers.txt"
        with open(bookers_path, 'w', encoding='utf-8') as f:
            f.write(bookers_content)
        logger.info(f"  📚 ブッカーズ形式: {bookers_path} ({bookers_path.stat().st_size / 1024:.2f} KB)")
        
        # Twitter形式
        twitter_content = generate_twitter_format(keibajo_group, target_date, keibajo_name)
        twitter_path = output_dir / f"{keibajo_name}_{target_date}_tweet.txt"
        with open(twitter_path, 'w', encoding='utf-8') as f:
            f.write(twitter_content)
        logger.info(f"  🐦 Twitter形式: {twitter_path} ({twitter_path.stat().st_size / 1024:.2f} KB)")

# ============================================================================
# メイン処理
# ============================================================================

def main():
    """メイン処理フロー"""
    parser = argparse.ArgumentParser(description='Phase 6: 当日予測システム')
    parser.add_argument('--target-date', type=str, required=True,
                        help='対象日（YYYYMMDD形式、例: 20260221）')
    
    args = parser.parse_args()
    
    target_date = args.target_date
    
    # 入力検証
    if len(target_date) != 8 or not target_date.isdigit():
        print(f"❌ エラー: 無効な日付形式です（期待: YYYYMMDD、入力: {target_date}）")
        sys.exit(1)
    
    logger = setup_logging(target_date)
    
    logger.info("=" * 80)
    logger.info(f"Phase 6: 当日予測システム（{target_date}）")
    logger.info("=" * 80)
    
    try:
        # 1. データベース接続
        conn = get_db_connection()
        logger.info("✅ データベース接続成功")
        
        # 2. 当日データ取得 & 139列特徴量生成
        df, display_data = fetch_today_data(conn, target_date)
        
        # 3. モデル読み込み
        models = load_models()
        
        # 4. アンサンブル予測
        result_df = ensemble_predict(models, df, display_data)
        
        # 5. 予測結果保存
        save_predictions(result_df, target_date)
        
        # 6. 追加フォーマット保存（note/ブッカーズ/Twitter）
        save_additional_formats(result_df, target_date)
        
        logger.info("\n" + "=" * 80)
        logger.info("✅ Phase 6 完了！")
        logger.info("=" * 80)
        
    except Exception as e:
        logger.error(f"\n❌ エラー発生: {str(e)}", exc_info=True)
        sys.exit(1)
    
    finally:
        if 'conn' in locals():
            conn.close()
            logger.info("\nデータベース接続クローズ完了")

if __name__ == '__main__':
    main()
