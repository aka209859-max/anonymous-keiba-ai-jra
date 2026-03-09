#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-C: データ結合（6キー版・修正版）
kaisai_nen を4桁に統一し、kaisai_nichime の a/b/c を変換して6キー結合を実行します。
"""

import pandas as pd
import logging
from pathlib import Path
from datetime import datetime

# ログ設定
log_dir = Path('logs')
log_dir.mkdir(exist_ok=True)
log_file = log_dir / 'phase1c_final_6key_fixed.log'

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

# 結合キー定義（6キー）
MERGE_KEYS = ['kaisai_nen', 'keibajo_code', 'kaisai_kai', 'kaisai_nichime', 'race_bango', 'umaban']

def convert_kaisai_nen_to_4digit(value):
    """kaisai_nen を4桁に変換（JRDB: 2桁 → 4桁）"""
    if pd.isna(value):
        return value
    
    value_str = str(value).strip()
    
    # すでに4桁の場合
    if len(value_str) == 4:
        return value_str
    
    # 2桁の場合（16 → 2016）
    if len(value_str) == 2:
        year_int = int(value_str)
        # 00-49 → 2000-2049, 50-99 → 1950-1999
        if year_int <= 49:
            return f"20{value_str}"
        else:
            return f"19{value_str}"
    
    logging.warning(f"⚠️  想定外の kaisai_nen 形式: {value_str} (長さ: {len(value_str)})")
    return value_str

def convert_kaisai_nichime(value):
    """kaisai_nichime の a/b/c を 10/11/12 に変換し、数字はゼロパディング"""
    if pd.isna(value):
        return value
    
    value_str = str(value).strip().lower()
    
    # a/b/c を 10/11/12 に変換（0a, 0b, 0c も対応）
    mapping = {
        'a': '10', '0a': '10',
        'b': '11', '0b': '11',
        'c': '12', '0c': '12'
    }
    
    if value_str in mapping:
        return mapping[value_str]
    
    # 数字の場合は2桁ゼロパディング
    if value_str.isdigit():
        return value_str.zfill(2)
    
    logging.warning(f"⚠️  想定外の kaisai_nichime 値: {value_str}")
    return value_str

def normalize_key_column(value):
    """キー列を2桁ゼロパディング"""
    if pd.isna(value):
        return value
    return str(value).strip().zfill(2)

def load_and_prepare_jravan(file_path):
    """JRA-VAN データを読み込み、キー列を正規化"""
    logging.info(f"📖 JRA-VAN データ読み込み: {file_path}")
    df = pd.read_csv(file_path, dtype=str)
    logging.info(f"   読み込み件数: {len(df):,}件")
    
    # キー列の正規化
    df['kaisai_nen'] = df['kaisai_nen'].apply(str)  # すでに4桁
    df['keibajo_code'] = df['keibajo_code'].apply(normalize_key_column)
    df['kaisai_kai'] = df['kaisai_kai'].apply(normalize_key_column)
    df['kaisai_nichime'] = df['kaisai_nichime'].apply(convert_kaisai_nichime)
    df['race_bango'] = df['race_bango'].apply(normalize_key_column)
    df['umaban'] = df['umaban'].apply(normalize_key_column)
    
    logging.info(f"   🔑 キー列の値範囲:")
    logging.info(f"      kaisai_nen: {sorted(df['kaisai_nen'].unique())}")
    logging.info(f"      keibajo_code: {sorted(df['keibajo_code'].unique())}")
    logging.info(f"      kaisai_kai: {sorted(df['kaisai_kai'].unique())}")
    logging.info(f"      kaisai_nichime: {sorted(df['kaisai_nichime'].unique())}")
    
    return df

def load_and_prepare_jrdb(file_path):
    """JRDB データを読み込み、キー列を正規化"""
    logging.info(f"📖 JRDB データ読み込み: {file_path}")
    df = pd.read_csv(file_path, dtype=str)
    logging.info(f"   読み込み件数: {len(df):,}件")
    
    # キー列の正規化
    df['kaisai_nen'] = df['kaisai_nen'].apply(convert_kaisai_nen_to_4digit)  # 2桁 → 4桁
    df['keibajo_code'] = df['keibajo_code'].apply(normalize_key_column)
    df['kaisai_kai'] = df['kaisai_kai'].apply(normalize_key_column)
    df['kaisai_nichime'] = df['kaisai_nichime'].apply(convert_kaisai_nichime)
    df['race_bango'] = df['race_bango'].apply(normalize_key_column)
    df['umaban'] = df['umaban'].apply(normalize_key_column)
    
    logging.info(f"   🔑 キー列の値範囲:")
    logging.info(f"      kaisai_nen: {sorted(df['kaisai_nen'].unique())}")
    logging.info(f"      keibajo_code: {sorted(df['keibajo_code'].unique())}")
    logging.info(f"      kaisai_kai: {sorted(df['kaisai_kai'].unique())}")
    logging.info(f"      kaisai_nichime: {sorted(df['kaisai_nichime'].unique())}")
    
    return df

def check_duplicate_keys(df, source_name):
    """重複キーをチェック"""
    logging.info(f"\n🔍 {source_name} の重複キーチェック...")
    
    duplicates = df[df.duplicated(subset=MERGE_KEYS, keep=False)]
    
    if len(duplicates) > 0:
        logging.warning(f"⚠️  重複キー検出: {len(duplicates):,}件")
        
        # サンプル表示（最初の5件）
        sample = duplicates.groupby(MERGE_KEYS).size().head()
        logging.warning(f"   重複例（最初の5件）:")
        for keys, count in sample.items():
            key_dict = dict(zip(MERGE_KEYS, keys))
            logging.warning(f"      {key_dict}: {count}件")
        
        # 重複が多すぎる場合はエラー
        if len(duplicates) > 100:
            raise ValueError(
                f"重複キーが多すぎます（{len(duplicates):,}件）\n"
                f"kaisai_nen を追加キーにする必要があります"
            )
    else:
        logging.info(f"   ✅ 重複キーなし")

def merge_data(df_jravan, df_jrdb):
    """6キーでデータを結合"""
    logging.info(f"\n🔗 データ結合開始（6キー結合）")
    logging.info(f"   結合キー: {MERGE_KEYS}")
    logging.info(f"   JRA-VAN: {len(df_jravan):,}件")
    logging.info(f"   JRDB: {len(df_jrdb):,}件")
    
    # 結合実行
    merged = pd.merge(
        df_jravan,
        df_jrdb,
        on=MERGE_KEYS,
        how='inner',
        suffixes=('_jravan', '_jrdb')
    )
    
    logging.info(f"✅ 結合完了: {len(merged):,}件")
    logging.info(f"   結合率（対JRA-VAN）: {len(merged)/len(df_jravan)*100:.2f}%")
    logging.info(f"   結合率（対JRDB）: {len(merged)/len(df_jrdb)*100:.2f}%")
    
    # 結合率チェック
    merge_rate = len(merged) / len(df_jravan)
    if merge_rate < 0.8:
        logging.warning(f"⚠️  結合率が低い（{merge_rate*100:.1f}%）")
    elif merge_rate > 1.05:
        logging.warning(f"⚠️  結合率が100%を超えています（{merge_rate*100:.1f}%）- 重複キーの可能性")
    else:
        logging.info(f"✅ 結合率が正常範囲内（80-105%）")
    
    return merged

def verify_ketto_match(merged):
    """血統登録番号の一致率を検証"""
    logging.info(f"🔍 血統登録番号一致率検証中...")
    
    # 両方の列が存在するか確認
    ketto_cols = [col for col in merged.columns if 'ketto_toroku_bango' in col]
    
    if len(ketto_cols) < 2:
        logging.warning(f"⚠️  血統登録番号列が見つかりません: {ketto_cols}")
        return
    
    # JRA-VAN と JRDB の列を特定
    jravan_col = next((col for col in ketto_cols if 'jravan' in col), ketto_cols[0])
    jrdb_col = next((col for col in ketto_cols if 'jrdb' in col), ketto_cols[1])
    
    # 一致率計算
    matches = merged[jravan_col] == merged[jrdb_col]
    match_count = matches.sum()
    total_count = len(merged)
    match_rate = match_count / total_count if total_count > 0 else 0
    
    logging.info(f"   検証対象: {total_count:,}件")
    logging.info(f"   一致: {match_count:,}件")
    logging.info(f"   不一致: {total_count - match_count:,}件")
    logging.info(f"   一致率: {match_rate*100:.2f}%")
    
    if match_rate < 0.8:
        logging.warning(f"⚠️  一致率 <80% （要確認）")
    elif match_rate >= 0.9:
        logging.info(f"✅ 一致率 ≥90% （良好）")
    else:
        logging.info(f"⚠️  一致率 80-90% （許容範囲）")

def main():
    start_time = datetime.now()
    
    logging.info("="*70)
    logging.info("Phase 1-C: JRA-VAN & JRDB データ結合（6キー版・修正版）")
    logging.info("="*70)
    
    try:
        # データ読み込みと準備
        df_jravan = load_and_prepare_jravan('data/raw/jra_jravan_central_only.csv')
        df_jrdb = load_and_prepare_jrdb('data/raw/jrdb_48cols.csv')
        
        # 重複キーチェック
        check_duplicate_keys(df_jravan, 'JRA-VAN')
        check_duplicate_keys(df_jrdb, 'JRDB')
        
        # データ結合
        merged = merge_data(df_jravan, df_jrdb)
        
        # 血統登録番号一致率検証
        verify_ketto_match(merged)
        
        # 出力
        output_file = Path('data/raw/jravan_jrdb_merged.csv')
        output_file.parent.mkdir(parents=True, exist_ok=True)
        
        logging.info(f"\n💾 CSV出力中: {output_file}")
        merged.to_csv(output_file, index=False, encoding='utf-8')
        
        # サマリー
        file_size_mb = output_file.stat().st_size / (1024 * 1024)
        elapsed_time = (datetime.now() - start_time).total_seconds()
        
        logging.info("="*70)
        logging.info("✅ Phase 1-C 完了")
        logging.info("="*70)
        logging.info(f"出力ファイル: {output_file}")
        logging.info(f"総レコード数: {len(merged):,}件")
        logging.info(f"列数: {len(merged.columns)}列")
        logging.info(f"ファイルサイズ: {file_size_mb:.1f} MB")
        logging.info(f"⏱️  実行時間: {elapsed_time:.1f}秒")
        logging.info("="*70)
        logging.info("📌 次のステップ: Phase 1-D（特徴量エンジニアリング）")
        logging.info("="*70)
        
    except Exception as e:
        logging.error(f"❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        raise

if __name__ == '__main__':
    main()
