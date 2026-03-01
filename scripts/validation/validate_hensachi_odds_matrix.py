#!/usr/bin/env python3
"""
Phase 2C: 偏差値×オッズ マトリクス分析スクリプト

目的:
  - 偏差値ランク別 × オッズ帯別の回収率を2次元マトリクスで分析
  - 単勝・複勝の最適な購入パターンを特定
  - 避けるべき組み合わせを明確化

実行方法:
  python scripts/validation/validate_hensachi_odds_matrix.py \
      --year 2025 \
      --month 1 \
      --output results/validation/hensachi_odds_matrix/

作成日: 2026-03-01
作成者: anonymous
"""

import argparse
import logging
import sys
from pathlib import Path
from datetime import datetime
import yaml

import psycopg2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# プロジェクトのルートディレクトリをパスに追加
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))

# ログ設定
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(
            project_root / 'logs' / f'phase2c_hensachi_odds_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'
        )
    ]
)
logger = logging.getLogger(__name__)

# 日本語フォント設定（matplotlib）
plt.rcParams['font.sans-serif'] = ['DejaVu Sans', 'Arial', 'Hiragino Sans', 'Yu Gothic', 'Meirio']
plt.rcParams['axes.unicode_minus'] = False


class OddsParser:
    """jvd_o1テーブルのオッズ文字列をパースするクラス"""
    
    @staticmethod
    def parse_tansho_odds(odds_str):
        """
        単勝オッズをパース
        
        形式: 6文字単位（馬番2桁 + オッズ4桁）
        例: "010123" → 馬01, オッズ12.3倍
        
        Returns:
            dict: {馬番: オッズ倍率}
        """
        if not odds_str or pd.isna(odds_str):
            return {}
        
        result = {}
        odds_str = str(odds_str).strip()
        
        # 6文字ずつ分割
        for i in range(0, len(odds_str), 6):
            chunk = odds_str[i:i+6]
            if len(chunk) < 6:
                break
            
            try:
                umaban = int(chunk[0:2])
                odds_raw = int(chunk[2:6])
                odds_val = odds_raw / 10.0  # 整数を10で割る
                result[umaban] = odds_val
            except ValueError:
                continue
        
        return result
    
    @staticmethod
    def parse_fukusho_odds(odds_str):
        """
        複勝オッズをパース
        
        形式: 8文字単位（馬番2桁 + 最小オッズ3桁 + 最大オッズ3桁）
        例: "01035107" → 馬01, 最小3.5倍, 最大10.7倍
        
        Returns:
            dict: {馬番: (最小オッズ, 最大オッズ)}
        """
        if not odds_str or pd.isna(odds_str):
            return {}
        
        result = {}
        odds_str = str(odds_str).strip()
        
        # 8文字ずつ分割
        for i in range(0, len(odds_str), 8):
            chunk = odds_str[i:i+8]
            if len(chunk) < 8:
                break
            
            try:
                umaban = int(chunk[0:2])
                odds_min_raw = int(chunk[2:5])
                odds_max_raw = int(chunk[5:8])
                odds_min = odds_min_raw / 10.0
                odds_max = odds_max_raw / 10.0
                result[umaban] = (odds_min, odds_max)
            except ValueError:
                continue
        
        return result


class HensachiOddsMatrixAnalyzer:
    """偏差値×オッズ マトリクス分析クラス"""
    
    # 偏差値ランクの定義
    HENSACHI_RANKS = {
        'S': (70.0, float('inf'), '超本命'),
        'A': (65.0, 70.0, '本命'),
        'B': (60.0, 65.0, '対抗'),
        'C': (55.0, 60.0, '穴'),
        'D': (50.0, 55.0, '普通'),
        'E': (float('-inf'), 50.0, '低評価')
    }
    
    # 単勝オッズ帯の定義
    TANSHO_ODDS_BANDS = [
        (1.0, 3.0, '1.0-2.9'),
        (3.0, 5.0, '3.0-4.9'),
        (5.0, 10.0, '5.0-9.9'),
        (10.0, 20.0, '10.0-19.9'),
        (20.0, 50.0, '20.0-49.9'),
        (50.0, 100.0, '50.0-100.0')
    ]
    
    # 複勝オッズ帯の定義
    FUKUSHO_ODDS_BANDS = [
        (1.0, 1.5, '1.0-1.4'),
        (1.5, 2.0, '1.5-1.9'),
        (2.0, 3.0, '2.0-2.9'),
        (3.0, 5.0, '3.0-4.9'),
        (5.0, 10.0, '5.0-9.9'),
        (10.0, 20.0, '10.0-20.0')
    ]
    
    def __init__(self, db_config_path, year, month=None):
        """
        初期化
        
        Args:
            db_config_path: データベース設定ファイルのパス
            year: 分析対象年（例: 2025）
            month: 分析対象月（例: 1）、Noneの場合は全月
        """
        self.db_config = self._load_db_config(db_config_path)
        self.year = year
        self.month = month
        self.predictions = None
        self.odds_data = None
        self.results_data = None
        self.merged_data = None
        
        logger.info(f"HensachiOddsMatrixAnalyzer initialized: year={year}, month={month}")
    
    def _load_db_config(self, config_path):
        """データベース設定を読み込み"""
        with open(config_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
        return config
    
    def load_prediction_csvs(self, predictions_dir):
        """
        予測CSVファイルを読み込み
        
        Args:
            predictions_dir: 予測CSVファイルが格納されているディレクトリ
        """
        predictions_dir = Path(predictions_dir)
        
        # ファイル名パターン: predictions_YYYYMMDD.csv
        if self.month:
            pattern = f"predictions_{self.year}{self.month:02d}*.csv"
        else:
            pattern = f"predictions_{self.year}*.csv"
        
        csv_files = sorted(predictions_dir.glob(pattern))
        
        if not csv_files:
            raise FileNotFoundError(f"No prediction CSV files found: {predictions_dir / pattern}")
        
        logger.info(f"Found {len(csv_files)} prediction CSV files")
        
        # 全CSVファイルを読み込んで結合
        df_list = []
        for csv_file in csv_files:
            try:
                df = pd.read_csv(csv_file)
                df_list.append(df)
                logger.info(f"Loaded: {csv_file.name} ({len(df)} rows)")
            except Exception as e:
                logger.warning(f"Failed to load {csv_file.name}: {e}")
        
        self.predictions = pd.concat(df_list, ignore_index=True)
        
        logger.info(f"Total predictions loaded: {len(self.predictions)} rows")
        logger.info(f"Columns: {list(self.predictions.columns)}")
        
        # 必須カラムの確認
        required_cols = ['race_id', 'umaban', 'ensemble_score']
        missing_cols = [col for col in required_cols if col not in self.predictions.columns]
        if missing_cols:
            raise ValueError(f"Missing required columns: {missing_cols}")
    
    def load_jravan_data(self):
        """JRA-VAN TARGETデータベースからオッズ・結果データを読み込み"""
        conn = psycopg2.connect(
            host=self.db_config['host'],
            port=self.db_config['port'],
            database=self.db_config['database'],
            user=self.db_config['user'],
            password=self.db_config['password']
        )
        
        try:
            # jvd_o1テーブルからオッズデータを取得
            logger.info("Loading odds data from jvd_o1...")
            
            odds_query = """
            SELECT
                kaisai_nen,
                kaisai_tsukihi,
                keibajo_code,
                race_bango,
                odds_tansho,
                odds_fukusho
            FROM jvd_o1
            WHERE kaisai_nen = %s
            """
            
            params = [str(self.year)]
            
            if self.month:
                odds_query += " AND SUBSTRING(kaisai_tsukihi, 1, 2) = %s"
                params.append(f"{self.month:02d}")
            
            # JRA競馬場のみ（01-10）
            odds_query += """
            AND keibajo_code IN ('01','02','03','04','05','06','07','08','09','10')
            ORDER BY kaisai_tsukihi, keibajo_code, race_bango
            """
            
            self.odds_data = pd.read_sql_query(odds_query, conn, params=params)
            logger.info(f"Loaded {len(self.odds_data)} odds records")
            
            # jvd_seテーブルから結果データを取得
            logger.info("Loading results data from jvd_se...")
            
            results_query = """
            SELECT
                kaisai_nen,
                kaisai_tsukihi,
                keibajo_code,
                race_bango,
                umaban,
                kakutei_chakujun
            FROM jvd_se
            WHERE kaisai_nen = %s
            AND kakutei_chakujun IS NOT NULL
            """
            
            params = [str(self.year)]
            
            if self.month:
                results_query += " AND SUBSTRING(kaisai_tsukihi, 1, 2) = %s"
                params.append(f"{self.month:02d}")
            
            # JRA競馬場のみ
            results_query += """
            AND keibajo_code IN ('01','02','03','04','05','06','07','08','09','10')
            ORDER BY kaisai_tsukihi, keibajo_code, race_bango, umaban
            """
            
            self.results_data = pd.read_sql_query(results_query, conn, params=params)
            logger.info(f"Loaded {len(self.results_data)} result records")
            
            # jvd_hrテーブルから払戻データを取得
            logger.info("Loading payout data from jvd_hr...")
            
            payout_query = """
            SELECT
                kaisai_nen,
                kaisai_tsukihi,
                keibajo_code,
                race_bango,
                haraimodoshi_tansho_1a AS tansho_haito,
                haraimodoshi_fukusho_1a AS fukusho_haito_1,
                haraimodoshi_fukusho_2a AS fukusho_haito_2,
                haraimodoshi_fukusho_3a AS fukusho_haito_3
            FROM jvd_hr
            WHERE kaisai_nen = %s
            """
            
            params = [str(self.year)]
            
            if self.month:
                payout_query += " AND SUBSTRING(kaisai_tsukihi, 1, 2) = %s"
                params.append(f"{self.month:02d}")
            
            payout_query += """
            AND keibajo_code IN ('01','02','03','04','05','06','07','08','09','10')
            ORDER BY kaisai_tsukihi, keibajo_code, race_bango
            """
            
            self.payout_data = pd.read_sql_query(payout_query, conn, params=params)
            logger.info(f"Loaded {len(self.payout_data)} payout records")
            
        finally:
            conn.close()
    
    def parse_odds(self):
        """オッズデータをパースして展開"""
        logger.info("Parsing odds data...")
        
        parser = OddsParser()
        
        # 各レースごとにオッズをパース
        rows = []
        for _, row in self.odds_data.iterrows():
            race_key = (row['kaisai_nen'], row['kaisai_tsukihi'], 
                       row['keibajo_code'], row['race_bango'])
            
            # 単勝オッズをパース
            tansho_dict = parser.parse_tansho_odds(row['odds_tansho'])
            
            # 複勝オッズをパース
            fukusho_dict = parser.parse_fukusho_odds(row['odds_fukusho'])
            
            # 各馬のオッズを展開
            all_umaban = set(tansho_dict.keys()) | set(fukusho_dict.keys())
            
            for umaban in all_umaban:
                odds_row = {
                    'kaisai_nen': race_key[0],
                    'kaisai_tsukihi': race_key[1],
                    'keibajo_code': race_key[2],
                    'race_bango': race_key[3],
                    'umaban': umaban,
                    'tansho_odds': tansho_dict.get(umaban, np.nan),
                    'fukusho_odds_min': fukusho_dict.get(umaban, (np.nan, np.nan))[0],
                    'fukusho_odds_max': fukusho_dict.get(umaban, (np.nan, np.nan))[1]
                }
                rows.append(odds_row)
        
        self.odds_expanded = pd.DataFrame(rows)
        logger.info(f"Parsed odds data: {len(self.odds_expanded)} horse-odds records")
    
    def merge_data(self):
        """予測結果、オッズ、結果データをマージ"""
        logger.info("Merging prediction, odds, and results data...")
        
        # race_idから年月日・競馬場・レース番号を抽出
        # race_id形式: YYYYMMDDJJRR (例: 202501050601 = 2025年1月5日、競馬場06、レース01)
        self.predictions['kaisai_nen'] = self.predictions['race_id'].astype(str).str[0:4]
        self.predictions['kaisai_tsukihi'] = self.predictions['race_id'].astype(str).str[4:8]
        self.predictions['keibajo_code'] = self.predictions['race_id'].astype(str).str[8:10]
        self.predictions['race_bango'] = self.predictions['race_id'].astype(str).str[10:12]
        
        # データ型を統一
        for df in [self.predictions, self.odds_expanded, self.results_data]:
            df['umaban'] = df['umaban'].astype(int)
            df['race_bango'] = df['race_bango'].astype(str).str.zfill(2)
        
        # 予測 + オッズ
        merged = pd.merge(
            self.predictions,
            self.odds_expanded,
            on=['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban'],
            how='inner'
        )
        logger.info(f"After merging with odds: {len(merged)} rows")
        
        # + 結果
        merged = pd.merge(
            merged,
            self.results_data,
            on=['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban'],
            how='inner'
        )
        logger.info(f"After merging with results: {len(merged)} rows")
        
        # 着順を整数に変換
        merged['chakujun'] = pd.to_numeric(merged['kakutei_chakujun'], errors='coerce')
        
        # 払戻データをマージ（レース単位）
        merged = pd.merge(
            merged,
            self.payout_data,
            on=['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango'],
            how='left'
        )
        logger.info(f"After merging with payouts: {len(merged)} rows")
        
        self.merged_data = merged
        
        logger.info(f"Final merged data: {len(self.merged_data)} rows")
        logger.info(f"Unique races: {self.merged_data['race_id'].nunique()}")
    
    def calculate_hensachi(self):
        """各レース内で偏差値を計算"""
        logger.info("Calculating hensachi (deviation scores)...")
        
        def calc_hensachi_group(group):
            """グループ内で偏差値を計算"""
            mean = group['ensemble_score'].mean()
            std = group['ensemble_score'].std()
            
            if std == 0 or pd.isna(std):
                # 標準偏差が0の場合は全て偏差値50
                group['hensachi'] = 50.0
            else:
                group['z_score'] = (group['ensemble_score'] - mean) / std
                group['hensachi'] = 50 + 10 * group['z_score']
            
            return group
        
        self.merged_data = self.merged_data.groupby('race_id').apply(calc_hensachi_group)
        self.merged_data = self.merged_data.reset_index(drop=True)
        
        logger.info("Hensachi calculation completed")
        logger.info(f"Hensachi range: {self.merged_data['hensachi'].min():.2f} - {self.merged_data['hensachi'].max():.2f}")
    
    def assign_ranks_and_bands(self):
        """偏差値ランクとオッズ帯を付与"""
        logger.info("Assigning hensachi ranks and odds bands...")
        
        # 偏差値ランクを付与
        def assign_hensachi_rank(hensachi):
            for rank, (lower, upper, _) in self.HENSACHI_RANKS.items():
                if lower <= hensachi < upper:
                    return rank
            return 'E'  # デフォルト
        
        self.merged_data['hensachi_rank'] = self.merged_data['hensachi'].apply(assign_hensachi_rank)
        
        # 単勝オッズ帯を付与
        def assign_tansho_odds_band(odds):
            if pd.isna(odds):
                return None
            for lower, upper, label in self.TANSHO_ODDS_BANDS:
                if lower <= odds < upper:
                    return label
            return '100.0+'
        
        self.merged_data['tansho_odds_band'] = self.merged_data['tansho_odds'].apply(assign_tansho_odds_band)
        
        # 複勝オッズ帯を付与（最小オッズを使用）
        def assign_fukusho_odds_band(odds_min):
            if pd.isna(odds_min):
                return None
            for lower, upper, label in self.FUKUSHO_ODDS_BANDS:
                if lower <= odds_min < upper:
                    return label
            return '20.0+'
        
        self.merged_data['fukusho_odds_band'] = self.merged_data['fukusho_odds_min'].apply(assign_fukusho_odds_band)
        
        logger.info("Rank and band assignment completed")
        
        # 分布を表示
        logger.info("\n=== Hensachi Rank Distribution ===")
        logger.info(self.merged_data['hensachi_rank'].value_counts().sort_index())
        
        logger.info("\n=== Tansho Odds Band Distribution ===")
        logger.info(self.merged_data['tansho_odds_band'].value_counts())
    
    def generate_tansho_matrix(self):
        """単勝マトリクスを生成"""
        logger.info("Generating tansho (win) matrix...")
        
        # オッズバンドがNoneでないデータのみ
        data = self.merged_data[self.merged_data['tansho_odds_band'].notna()].copy()
        
        # 単勝的中フラグ
        data['tansho_hit'] = (data['chakujun'] == 1).astype(int)
        
        # 単勝払戻（的中時のみ）
        # 払戻データは文字列の可能性があるので数値化
        data['tansho_haito_val'] = pd.to_numeric(data['tansho_haito'], errors='coerce')
        
        # グループ化して集計
        matrix = data.groupby(['hensachi_rank', 'tansho_odds_band']).agg(
            target_count=('umaban', 'count'),
            hit_count=('tansho_hit', 'sum'),
            total_investment=('umaban', lambda x: len(x) * 100),  # 1頭100円
        ).reset_index()
        
        # 的中率
        matrix['hit_rate'] = (matrix['hit_count'] / matrix['target_count'] * 100).round(1)
        
        # 平均オッズを計算（簡易）
        avg_odds = data.groupby(['hensachi_rank', 'tansho_odds_band'])['tansho_odds'].mean().reset_index()
        avg_odds.columns = ['hensachi_rank', 'tansho_odds_band', 'avg_odds']
        matrix = pd.merge(matrix, avg_odds, on=['hensachi_rank', 'tansho_odds_band'])
        
        # 期待払戻（的中数 × 平均オッズ × 100円）
        matrix['total_payout'] = matrix['hit_count'] * matrix['avg_odds'] * 100
        
        # 回収率
        matrix['recovery_rate'] = (matrix['total_payout'] / matrix['total_investment'] * 100).round(1)
        
        # ROI
        matrix['roi'] = (matrix['recovery_rate'] - 100).round(1)
        
        # 推奨度を付与
        def assign_recommendation(roi):
            if roi >= 150:
                return '★★★★★'
            elif roi >= 80:
                return '★★★★'
            elif roi >= 20:
                return '★★★'
            elif roi >= 0:
                return '★★'
            elif roi >= -20:
                return '★'
            else:
                return '☆'
        
        matrix['recommendation'] = matrix['roi'].apply(assign_recommendation)
        
        self.tansho_matrix = matrix
        logger.info(f"Tansho matrix generated: {len(matrix)} cells")
        
        return matrix
    
    def generate_fukusho_matrix(self):
        """複勝マトリクスを生成"""
        logger.info("Generating fukusho (place) matrix...")
        
        # オッズバンドがNoneでないデータのみ
        data = self.merged_data[self.merged_data['fukusho_odds_band'].notna()].copy()
        
        # 複勝的中フラグ（3着以内）
        data['fukusho_hit'] = (data['chakujun'] <= 3).astype(int)
        
        # グループ化して集計
        matrix = data.groupby(['hensachi_rank', 'fukusho_odds_band']).agg(
            target_count=('umaban', 'count'),
            hit_count=('fukusho_hit', 'sum'),
            total_investment=('umaban', lambda x: len(x) * 100),
        ).reset_index()
        
        # 的中率
        matrix['hit_rate'] = (matrix['hit_count'] / matrix['target_count'] * 100).round(1)
        
        # 平均オッズを計算（最小オッズを使用）
        avg_odds = data.groupby(['hensachi_rank', 'fukusho_odds_band'])['fukusho_odds_min'].mean().reset_index()
        avg_odds.columns = ['hensachi_rank', 'fukusho_odds_band', 'avg_odds']
        matrix = pd.merge(matrix, avg_odds, on=['hensachi_rank', 'fukusho_odds_band'])
        
        # 期待払戻
        matrix['total_payout'] = matrix['hit_count'] * matrix['avg_odds'] * 100
        
        # 回収率
        matrix['recovery_rate'] = (matrix['total_payout'] / matrix['total_investment'] * 100).round(1)
        
        # ROI
        matrix['roi'] = (matrix['recovery_rate'] - 100).round(1)
        
        # 推奨度を付与
        def assign_recommendation(roi):
            if roi >= 150:
                return '★★★★★'
            elif roi >= 80:
                return '★★★★'
            elif roi >= 20:
                return '★★★'
            elif roi >= 0:
                return '★★'
            elif roi >= -20:
                return '★'
            else:
                return '☆'
        
        matrix['recommendation'] = matrix['roi'].apply(assign_recommendation)
        
        self.fukusho_matrix = matrix
        logger.info(f"Fukusho matrix generated: {len(matrix)} cells")
        
        return matrix
    
    def export_csv(self, output_dir):
        """CSV形式で出力"""
        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # 単勝マトリクス
        tansho_csv = output_dir / 'tansho_hensachi_odds_matrix.csv'
        self.tansho_matrix.to_csv(tansho_csv, index=False, encoding='utf-8-sig')
        logger.info(f"Saved: {tansho_csv}")
        
        # 複勝マトリクス
        fukusho_csv = output_dir / 'fukusho_hensachi_odds_matrix.csv'
        self.fukusho_matrix.to_csv(fukusho_csv, index=False, encoding='utf-8-sig')
        logger.info(f"Saved: {fukusho_csv}")
    
    def plot_heatmap(self, output_dir):
        """ヒートマップを生成"""
        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # 単勝回収率ヒートマップ
        logger.info("Creating tansho recovery rate heatmap...")
        
        pivot_tansho = self.tansho_matrix.pivot(
            index='hensachi_rank',
            columns='tansho_odds_band',
            values='recovery_rate'
        )
        
        # ランクの順序を設定
        rank_order = ['S', 'A', 'B', 'C', 'D', 'E']
        pivot_tansho = pivot_tansho.reindex(rank_order)
        
        plt.figure(figsize=(14, 8))
        sns.heatmap(
            pivot_tansho,
            annot=True,
            fmt='.1f',
            cmap='RdYlGn',
            center=100,
            cbar_kws={'label': 'Recovery Rate (%)'},
            linewidths=0.5,
            vmin=0,
            vmax=200
        )
        plt.title('Tansho Recovery Rate Heatmap (Hensachi x Odds)', fontsize=16, pad=20)
        plt.xlabel('Tansho Odds Band', fontsize=12)
        plt.ylabel('Hensachi Rank', fontsize=12)
        plt.tight_layout()
        
        tansho_heatmap_file = output_dir / 'tansho_hensachi_odds_heatmap.png'
        plt.savefig(tansho_heatmap_file, dpi=300, bbox_inches='tight')
        plt.close()
        logger.info(f"Saved: {tansho_heatmap_file}")
        
        # 複勝回収率ヒートマップ
        logger.info("Creating fukusho recovery rate heatmap...")
        
        pivot_fukusho = self.fukusho_matrix.pivot(
            index='hensachi_rank',
            columns='fukusho_odds_band',
            values='recovery_rate'
        )
        
        pivot_fukusho = pivot_fukusho.reindex(rank_order)
        
        plt.figure(figsize=(14, 8))
        sns.heatmap(
            pivot_fukusho,
            annot=True,
            fmt='.1f',
            cmap='RdYlGn',
            center=100,
            cbar_kws={'label': 'Recovery Rate (%)'},
            linewidths=0.5,
            vmin=0,
            vmax=200
        )
        plt.title('Fukusho Recovery Rate Heatmap (Hensachi x Odds)', fontsize=16, pad=20)
        plt.xlabel('Fukusho Odds Band', fontsize=12)
        plt.ylabel('Hensachi Rank', fontsize=12)
        plt.tight_layout()
        
        fukusho_heatmap_file = output_dir / 'fukusho_hensachi_odds_heatmap.png'
        plt.savefig(fukusho_heatmap_file, dpi=300, bbox_inches='tight')
        plt.close()
        logger.info(f"Saved: {fukusho_heatmap_file}")
    
    def export_markdown_report(self, output_dir):
        """Markdownレポートを出力"""
        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        
        report_file = output_dir / 'hensachi_odds_matrix_report.md'
        
        # レポート作成
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write(f"# 偏差値×オッズ マトリクス分析レポート\n\n")
            f.write(f"**分析期間**: {self.year}年{self.month if self.month else '全'}月\n")
            f.write(f"**対象レース数**: {self.merged_data['race_id'].nunique()}レース\n")
            f.write(f"**対象馬数**: {len(self.merged_data)}頭\n")
            f.write(f"**作成日**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            
            f.write("---\n\n")
            
            # エグゼクティブサマリー
            f.write("## 📊 エグゼクティブサマリー\n\n")
            
            # TOP 5 ROI（単勝）
            f.write("### 🏆 最優秀パターン TOP 5（単勝 ROI順）\n\n")
            top5_tansho = self.tansho_matrix.nlargest(5, 'roi')
            f.write("| 順位 | 偏差値ランク | オッズ帯 | 対象馬数 | 的中率 | 回収率 | ROI | 推奨度 |\n")
            f.write("|------|--------------|----------|----------|--------|--------|-----|--------|\n")
            for idx, (i, row) in enumerate(top5_tansho.iterrows(), 1):
                f.write(f"| {idx} | {row['hensachi_rank']} | {row['tansho_odds_band']} | "
                       f"{row['target_count']} | {row['hit_rate']:.1f}% | {row['recovery_rate']:.1f}% | "
                       f"{row['roi']:+.1f}% | {row['recommendation']} |\n")
            f.write("\n")
            
            # TOP 5 ROI（複勝）
            f.write("### 🏆 最優秀パターン TOP 5（複勝 ROI順）\n\n")
            top5_fukusho = self.fukusho_matrix.nlargest(5, 'roi')
            f.write("| 順位 | 偏差値ランク | オッズ帯 | 対象馬数 | 的中率 | 回収率 | ROI | 推奨度 |\n")
            f.write("|------|--------------|----------|----------|--------|--------|-----|--------|\n")
            for idx, (i, row) in enumerate(top5_fukusho.iterrows(), 1):
                f.write(f"| {idx} | {row['hensachi_rank']} | {row['fukusho_odds_band']} | "
                       f"{row['target_count']} | {row['hit_rate']:.1f}% | {row['recovery_rate']:.1f}% | "
                       f"{row['roi']:+.1f}% | {row['recommendation']} |\n")
            f.write("\n")
            
            # 非推奨パターン（単勝）
            f.write("### ⚠️ 非推奨パターン（単勝 ROI -20%以下）\n\n")
            worst_tansho = self.tansho_matrix[self.tansho_matrix['roi'] <= -20].nsmallest(5, 'roi')
            if len(worst_tansho) > 0:
                f.write("| 順位 | 偏差値ランク | オッズ帯 | 対象馬数 | 的中率 | 回収率 | ROI | 推奨度 |\n")
                f.write("|------|--------------|----------|----------|--------|--------|-----|--------|\n")
                for idx, (i, row) in enumerate(worst_tansho.iterrows(), 1):
                    f.write(f"| {idx} | {row['hensachi_rank']} | {row['tansho_odds_band']} | "
                           f"{row['target_count']} | {row['hit_rate']:.1f}% | {row['recovery_rate']:.1f}% | "
                           f"{row['roi']:+.1f}% | {row['recommendation']} |\n")
            else:
                f.write("該当なし\n")
            f.write("\n")
            
            f.write("---\n\n")
            
            # 単勝マトリクス詳細
            f.write("## 📊 単勝マトリクス（偏差値×オッズ）\n\n")
            f.write("### 詳細テーブル\n\n")
            f.write("| 偏差値ランク | オッズ帯 | 対象馬数 | 的中数 | 的中率 | 平均オッズ | 回収率 | ROI | 推奨度 |\n")
            f.write("|--------------|----------|----------|--------|--------|------------|--------|-----|--------|\n")
            for _, row in self.tansho_matrix.iterrows():
                f.write(f"| {row['hensachi_rank']} | {row['tansho_odds_band']} | "
                       f"{row['target_count']} | {row['hit_count']} | {row['hit_rate']:.1f}% | "
                       f"{row['avg_odds']:.1f}倍 | {row['recovery_rate']:.1f}% | "
                       f"{row['roi']:+.1f}% | {row['recommendation']} |\n")
            f.write("\n")
            
            # 複勝マトリクス詳細
            f.write("## 📊 複勝マトリクス（偏差値×オッズ）\n\n")
            f.write("### 詳細テーブル\n\n")
            f.write("| 偏差値ランク | オッズ帯 | 対象馬数 | 的中数 | 的中率 | 平均オッズ | 回収率 | ROI | 推奨度 |\n")
            f.write("|--------------|----------|----------|--------|--------|------------|--------|-----|--------|\n")
            for _, row in self.fukusho_matrix.iterrows():
                f.write(f"| {row['hensachi_rank']} | {row['fukusho_odds_band']} | "
                       f"{row['target_count']} | {row['hit_count']} | {row['hit_rate']:.1f}% | "
                       f"{row['avg_odds']:.1f}倍 | {row['recovery_rate']:.1f}% | "
                       f"{row['roi']:+.1f}% | {row['recommendation']} |\n")
            f.write("\n")
            
            f.write("---\n\n")
            f.write(f"**最終更新**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"**作成者**: anonymous\n")
            f.write(f"**プロジェクト**: JRA中央競馬AIシステム Phase 2C\n")
        
        logger.info(f"Saved: {report_file}")
    
    def run_analysis(self, predictions_dir, output_dir):
        """分析を実行"""
        logger.info("=" * 80)
        logger.info("Phase 2C: Hensachi x Odds Matrix Analysis")
        logger.info("=" * 80)
        
        # ステップ1: 予測CSVを読み込み
        self.load_prediction_csvs(predictions_dir)
        
        # ステップ2: JRA-VANデータを読み込み
        self.load_jravan_data()
        
        # ステップ3: オッズをパース
        self.parse_odds()
        
        # ステップ4: データをマージ
        self.merge_data()
        
        # ステップ5: 偏差値を計算
        self.calculate_hensachi()
        
        # ステップ6: ランクとバンドを付与
        self.assign_ranks_and_bands()
        
        # ステップ7: 単勝マトリクスを生成
        self.generate_tansho_matrix()
        
        # ステップ8: 複勝マトリクスを生成
        self.generate_fukusho_matrix()
        
        # ステップ9: CSVを出力
        self.export_csv(output_dir)
        
        # ステップ10: ヒートマップを生成
        self.plot_heatmap(output_dir)
        
        # ステップ11: Markdownレポートを出力
        self.export_markdown_report(output_dir)
        
        logger.info("=" * 80)
        logger.info("Analysis completed successfully!")
        logger.info(f"Output directory: {output_dir}")
        logger.info("=" * 80)


def main():
    parser = argparse.ArgumentParser(description='Phase 2C: 偏差値×オッズ マトリクス分析')
    parser.add_argument('--year', type=int, required=True, help='分析対象年（例: 2025）')
    parser.add_argument('--month', type=int, default=None, help='分析対象月（例: 1）、指定しない場合は全月')
    parser.add_argument('--predictions-dir', type=str, default='results',
                       help='予測CSVファイルのディレクトリ（デフォルト: results）')
    parser.add_argument('--output', type=str, default='results/validation/hensachi_odds_matrix',
                       help='出力ディレクトリ（デフォルト: results/validation/hensachi_odds_matrix）')
    parser.add_argument('--db-config', type=str, default='config/db_config.yaml',
                       help='データベース設定ファイル（デフォルト: config/db_config.yaml）')
    
    args = parser.parse_args()
    
    try:
        # アナライザーを初期化
        analyzer = HensachiOddsMatrixAnalyzer(
            db_config_path=args.db_config,
            year=args.year,
            month=args.month
        )
        
        # 分析を実行
        analyzer.run_analysis(
            predictions_dir=args.predictions_dir,
            output_dir=args.output
        )
        
        logger.info("\n✅ Phase 2C analysis completed successfully!")
        
    except Exception as e:
        logger.error(f"\n❌ Error during analysis: {e}", exc_info=True)
        sys.exit(1)


if __name__ == '__main__':
    main()
