#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 1-C: 血統登録番号フォーマット修正
JRA-VAN (10桁) と JRDB (7-8桁) の血統登録番号を10桁に統一します。
"""

import pandas as pd
import logging
from pathlib import Path
from datetime import datetime

# ログ設定
log_dir = Path('logs')
log_dir.mkdir(exist_ok=True)
log_file = log_dir / 'fix_ketto_format.log'

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

def normalize_ketto_to_10digit(value):
    """
    血統登録番号を10桁に正規化
    
    フォーマット:
    - JRA-VAN: 10桁 (YYYY + 6桁登録番号) 例: 2013105621
    - JRDB:    8桁 (YY + 6桁登録番号)   例: 13105621
    - JRDB:    7桁 (Y + 6桁登録番号)    例: 9101967 (1990年代)
    
    変換ルール:
    - 10桁: そのまま
    - 8桁: 先頭に '20' を追加
    - 7桁: 先頭の1桁が年代、1990年代なら '19', 2000年代なら '20' を追加
    - 6桁以下: ゼロパディングして10桁化
    """
    if pd.isna(value):
        return value
    
    value_str = str(value).strip()
    
    # すでに10桁の場合
    if len(value_str) == 10:
        return value_str
    
    # 8桁の場合（JRDB形式: YY + 6桁）
    if len(value_str) == 8:
        # 先頭に '20' を追加
        return '20' + value_str
    
    # 7桁の場合（JRDB形式: Y + 6桁、1990年代の馬）
    if len(value_str) == 7:
        year_digit = int(value_str[0])
        # 1990年代（9で始まる）なら '19' を追加、2000年代なら '20' を追加
        if year_digit >= 8:  # 8, 9 → 1980年代, 1990年代
            return '19' + value_str
        else:
            return '20' + value_str
    
    # 9桁の場合（想定外だがゼロパディング）
    if len(value_str) == 9:
        logging.warning(f"⚠️  想定外の血統登録番号形式: {value_str} (長さ: {len(value_str)})")
        return value_str.zfill(10)
    
    # 6桁以下の場合（ゼロパディング）
    if len(value_str) <= 6:
        logging.warning(f"⚠️  想定外の血統登録番号形式: {value_str} (長さ: {len(value_str)})")
        # 2020年代と仮定して '20' を追加してゼロパディング
        return ('20' + value_str).zfill(10)
    
    # その他の想定外の長さ
    logging.warning(f"⚠️  想定外の血統登録番号形式: {value_str} (長さ: {len(value_str)})")
    return value_str

def main():
    start_time = datetime.now()
    
    logging.info("="*70)
    logging.info("Phase 1-C 血統登録番号フォーマット修正（完全版）")
    logging.info("="*70)
    
    try:
        # データ読み込み
        input_file = Path('data/raw/jravan_jrdb_merged.csv')
        logging.info(f"📖 データ読み込み: {input_file}")
        
        df = pd.read_csv(input_file, dtype=str)
        logging.info(f"   読み込み件数: {len(df):,}件")
        logging.info(f"   列数: {len(df.columns)}列")
        
        # 血統登録番号列を特定
        ketto_cols = [col for col in df.columns if 'ketto_toroku_bango' in col]
        
        if len(ketto_cols) < 2:
            raise ValueError(f"血統登録番号列が2つ見つかりません: {ketto_cols}")
        
        jravan_col = next((col for col in ketto_cols if 'jravan' in col), ketto_cols[0])
        jrdb_col = next((col for col in ketto_cols if 'jrdb' in col), ketto_cols[1])
        
        logging.info(f"\n🔧 血統登録番号を10桁に統一中...")
        
        # JRA-VAN側の処理（すでに10桁のはずだが念のため）
        before_jravan = df[jravan_col].head(3).tolist()
        df[jravan_col] = df[jravan_col].apply(normalize_ketto_to_10digit)
        after_jravan = df[jravan_col].head(3).tolist()
        logging.info(f"   JRA-VAN: {before_jravan} → {after_jravan}")
        
        # 桁数分布を表示
        jravan_lengths = df[jravan_col].str.len().value_counts().to_dict()
        logging.info(f"   JRA-VAN 桁数分布: {jravan_lengths}")
        
        # JRDB側の処理（7-8桁 → 10桁）
        before_jrdb_lengths = df[jrdb_col].str.len().value_counts().to_dict()
        logging.info(f"   JRDB 変換前の桁数分布: {before_jrdb_lengths}")
        
        # 変換例を表示（最初の10件）
        logging.info(f"   JRDB 変換例（最初の10件）:")
        for i, val in enumerate(df[jrdb_col].head(10), 1):
            before = val
            after = normalize_ketto_to_10digit(val)
            logging.info(f"      {i:2d}. '{before}' ({len(before)}桁) → '{after}' ({len(after)}桁)")
        
        df[jrdb_col] = df[jrdb_col].apply(normalize_ketto_to_10digit)
        
        after_jrdb_lengths = df[jrdb_col].str.len().value_counts().to_dict()
        logging.info(f"   JRDB 変換後の桁数分布: {after_jrdb_lengths}")
        
        # 一致率検証
        logging.info(f"\n🔍 一致率検証中...")
        matches = df[jravan_col] == df[jrdb_col]
        match_count = matches.sum()
        total_count = len(df)
        match_rate = match_count / total_count
        
        logging.info(f"   検証対象: {total_count:,}件")
        logging.info(f"   一致: {match_count:,}件")
        logging.info(f"   不一致: {total_count - match_count:,}件")
        logging.info(f"   一致率: {match_rate*100:.2f}%")
        
        if match_rate >= 0.99:
            logging.info(f"   ✅ 一致率 ≥99% （完璧！）")
        elif match_rate >= 0.9:
            logging.info(f"   ✅ 一致率 ≥90% （良好）")
        else:
            logging.warning(f"   ⚠️  一致率 <90% （要確認）")
        
        # 不一致サンプル表示
        if match_count < total_count:
            mismatches = df[~matches][[jravan_col, jrdb_col]].head(10)
            logging.info(f"\n   不一致サンプル（最初の10件 / 全{total_count - match_count:,}件）:")
            for _, row in mismatches.iterrows():
                logging.info(f"      JRA-VAN: '{row[jravan_col]}', JRDB: '{row[jrdb_col]}'")
        
        # 出力
        output_file = Path('data/raw/jravan_jrdb_merged_fixed.csv')
        logging.info(f"\n💾 CSV出力中: {output_file}")
        df.to_csv(output_file, index=False, encoding='utf-8')
        
        # サマリー
        file_size_mb = output_file.stat().st_size / (1024 * 1024)
        elapsed_time = (datetime.now() - start_time).total_seconds()
        
        logging.info("="*70)
        logging.info("✅ 修正完了")
        logging.info("="*70)
        logging.info(f"出力ファイル: {output_file}")
        logging.info(f"総レコード数: {len(df):,}件")
        logging.info(f"列数: {len(df.columns)}列")
        logging.info(f"ファイルサイズ: {file_size_mb:.1f} MB")
        logging.info(f"血統登録番号一致率: {match_rate*100:.2f}%")
        logging.info("="*70)
        logging.info("\n🎉 Phase 1-C（データ結合）が完全に完了しました！")
        logging.info("   次のステップ: Phase 1-D（特徴量エンジニアリング）")
        
    except Exception as e:
        logging.error(f"❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        raise

if __name__ == '__main__':
    main()
