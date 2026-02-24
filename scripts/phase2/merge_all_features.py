#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JRA競馬AI Phase 2-B: 全競馬場データ統合
================================================

【目的】
11個の競馬場別CSVファイルを1つに統合し、全国統一モデルの学習を可能にする

【入力】
- data/features/*_2016-2025_features.csv（11ファイル）
  01: 札幌、02: 函館、03: 福島、04: 新潟、05: 東京
  06: 中山、07: 中京、08: 京都、09: 阪神
  10_summer: 小倉夏季（6-9月）、10_winter: 小倉冬季（1-3月）

【出力】
- data/features/all_tracks_2016-2025_features.csv（統合ファイル）
- 期待行数: 480,000 ～ 485,000
- 期待列数: 139

【所要時間】
約30分

【作成日】
2026-02-22

【参考】
JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md
"""

import pandas as pd
import glob
from pathlib import Path
import logging
from datetime import datetime
import sys

# ログ設定
def setup_logging():
    """ログ設定を初期化"""
    log_dir = Path('logs')
    log_dir.mkdir(exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_file = log_dir / f"phase2b_merge_{timestamp}.log"
    
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file, encoding='utf-8'),
            logging.StreamHandler(sys.stdout)
        ]
    )
    return logging.getLogger(__name__)

def merge_all_features():
    """11個の競馬場CSVを1つに統合"""
    
    logger = setup_logging()
    
    logger.info("=" * 80)
    logger.info("Phase 2-B: 全競馬場データ統合開始")
    logger.info("=" * 80)
    
    # 1. データファイル検索
    logger.info("\n[Step 1] CSVファイル検索...")
    csv_pattern = 'data/features/*_2016-2025_features.csv'
    csv_files = sorted(glob.glob(csv_pattern))
    
    if len(csv_files) == 0:
        logger.error(f"❌ エラー: CSVファイルが見つかりません（パターン: {csv_pattern}）")
        logger.error("データファイルが存在することを確認してください")
        sys.exit(1)
    
    logger.info(f"✅ 検出ファイル: {len(csv_files)}個")
    
    if len(csv_files) != 11:
        logger.warning(f"⚠️ 警告: 期待ファイル数は11個ですが、{len(csv_files)}個見つかりました")
    
    for f in csv_files:
        logger.info(f"  - {Path(f).name}")
    
    # 2. 全CSVを読み込み
    logger.info("\n[Step 2] CSVファイル読み込み...")
    dfs = []
    total_rows = 0
    
    for f in csv_files:
        try:
            df = pd.read_csv(f, encoding='utf-8')
            row_count = len(df)
            total_rows += row_count
            
            logger.info(f"  {Path(f).name}: {row_count:,}行 × {len(df.columns)}列")
            dfs.append(df)
            
        except Exception as e:
            logger.error(f"❌ エラー: {Path(f).name} の読み込みに失敗")
            logger.error(f"  詳細: {str(e)}")
            sys.exit(1)
    
    logger.info(f"\n  読み込み完了: 合計 {total_rows:,}行")
    
    # 3. データ統合
    logger.info("\n[Step 3] データ統合中...")
    try:
        all_df = pd.concat(dfs, ignore_index=True)
        logger.info(f"✅ 統合完了")
    except Exception as e:
        logger.error(f"❌ エラー: データ統合に失敗")
        logger.error(f"  詳細: {str(e)}")
        sys.exit(1)
    
    # 4. 基本情報表示
    logger.info("\n[Step 4] 統合データ基本情報")
    logger.info("=" * 80)
    logger.info(f"  総行数: {len(all_df):,}行")
    logger.info(f"  総列数: {len(all_df.columns)}列")
    
    # 重複チェック
    duplicate_count = all_df.duplicated().sum()
    duplicate_rate = (duplicate_count / len(all_df)) * 100
    logger.info(f"  重複行数: {duplicate_count:,}行（{duplicate_rate:.4f}%）")
    
    if duplicate_rate > 0.01:
        logger.warning(f"⚠️ 警告: 重複率が0.01%を超えています（{duplicate_rate:.4f}%）")
    
    # 期待範囲チェック
    expected_min = 480000
    expected_max = 485000
    if expected_min <= len(all_df) <= expected_max:
        logger.info(f"✅ 行数チェック: OK（期待範囲: {expected_min:,} ～ {expected_max:,}）")
    else:
        logger.warning(f"⚠️ 警告: 行数が期待範囲外です（期待: {expected_min:,} ～ {expected_max:,}、実際: {len(all_df):,}）")
    
    if len(all_df.columns) == 139:
        logger.info(f"✅ 列数チェック: OK（期待: 139列）")
    else:
        logger.warning(f"⚠️ 警告: 列数が期待値と異なります（期待: 139列、実際: {len(all_df.columns)}列）")
    
    # 5. 保存
    logger.info("\n[Step 5] 統合ファイル保存中...")
    output_path = 'data/features/all_tracks_2016-2025_features.csv'
    
    try:
        all_df.to_csv(output_path, index=False, encoding='utf-8')
        logger.info(f"✅ 保存完了: {output_path}")
    except Exception as e:
        logger.error(f"❌ エラー: ファイル保存に失敗")
        logger.error(f"  詳細: {str(e)}")
        sys.exit(1)
    
    # 6. ファイルサイズ確認
    file_size_bytes = Path(output_path).stat().st_size
    file_size_mb = file_size_bytes / (1024 * 1024)
    file_size_gb = file_size_bytes / (1024 * 1024 * 1024)
    
    logger.info(f"  ファイルサイズ: {file_size_mb:.1f} MB ({file_size_gb:.2f} GB)")
    
    if 300 <= file_size_mb <= 400:
        logger.info(f"✅ ファイルサイズチェック: OK（期待範囲: 300-400 MB）")
    else:
        logger.warning(f"⚠️ 警告: ファイルサイズが期待範囲外です（期待: 300-400 MB、実際: {file_size_mb:.1f} MB）")
    
    # 7. 年ごとの分布確認
    if 'kaisai_nen' in all_df.columns:
        logger.info("\n[Step 6] 年別データ分布:")
        logger.info("-" * 60)
        year_counts = all_df['kaisai_nen'].value_counts().sort_index()
        for year, count in year_counts.items():
            percentage = (count / len(all_df)) * 100
            logger.info(f"  {year}年: {count:,}行（{percentage:.2f}%）")
    
    # 8. 競馬場別分布確認
    if 'keibajo_season_code' in all_df.columns:
        logger.info("\n[Step 7] 競馬場別データ分布:")
        logger.info("-" * 60)
        # 文字列型に統一してからソート
        all_df['keibajo_season_code'] = all_df['keibajo_season_code'].astype(str)
        track_counts = all_df['keibajo_season_code'].value_counts().sort_index()
        
        track_names = {
            '01': '札幌',
            '02': '函館',
            '03': '福島',
            '04': '新潟',
            '05': '東京',
            '06': '中山',
            '07': '中京',
            '08': '京都',
            '09': '阪神',
            '10_summer': '小倉夏季',
            '10_winter': '小倉冬季'
        }
        
        for code, count in track_counts.items():
            name = track_names.get(code, code)
            percentage = (count / len(all_df)) * 100
            logger.info(f"  {code}（{name}）: {count:,}行（{percentage:.2f}%）")
    
    # 9. 欠損値チェック（上位10列のみ）
    logger.info("\n[Step 8] 欠損値レポート（上位10列）:")
    logger.info("-" * 60)
    missing_rate = (all_df.isnull().sum() / len(all_df) * 100).sort_values(ascending=False)
    
    for col, rate in missing_rate.head(10).items():
        missing_count = all_df[col].isnull().sum()
        logger.info(f"  {col}: {rate:.2f}%（{missing_count:,}件）")
    
    if missing_rate.max() > 50:
        logger.warning(f"⚠️ 警告: 50%以上の欠損率を持つ列があります")
    
    # 10. 完了メッセージ
    logger.info("\n" + "=" * 80)
    logger.info("✅ Phase 2-B 完了！")
    logger.info("=" * 80)
    logger.info(f"\n📂 出力ファイル: {output_path}")
    logger.info(f"📊 統合データ: {len(all_df):,}行 × {len(all_df.columns)}列")
    logger.info(f"💾 ファイルサイズ: {file_size_mb:.1f} MB")
    logger.info(f"\n次のステップ: Phase 3（二値分類モデル構築）")
    logger.info("詳細は JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md を参照")
    
    return all_df

if __name__ == '__main__':
    try:
        df = merge_all_features()
    except KeyboardInterrupt:
        print("\n\n⚠️ ユーザーによる中断")
        sys.exit(1)
    except Exception as e:
        print(f"\n\n❌ 予期しないエラー: {str(e)}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
