#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 2C データ要件確認スクリプト
===============================================

【目的】
Phase 2C（偏差値×オッズマトリクス分析）に必要なデータが
データベースに存在するかを確認する

【確認項目】
1. 2025年の予測結果CSVの有無
2. データベース接続確認
3. 必要なテーブルの存在確認
4. 必要なカラムの存在確認
5. 2025年の確定オッズ・払戻データの有無

【実行方法】
python scripts/validation/check_phase2c_data_requirements.py

【作成日】2026-02-28
"""

import sys
import os
import yaml
import psycopg2
import pandas as pd
from pathlib import Path
from datetime import datetime

# ============================================================================
# 設定
# ============================================================================

# DB設定ファイルのパス
DB_CONFIG_PATH = Path('config/db_config.yaml')

# 必要なテーブルとカラムの定義
REQUIRED_TABLES = {
    'jvd_se': {
        'description': 'JRA-VAN 成績データ',
        'required_columns': [
            'kaisai_nen',
            'kaisai_tsukihi',
            'keibajo_code',
            'kaisai_kai',
            'kaisai_nichime',
            'race_bango',
            'umaban',
            'kakutei_chakujun',  # 確定着順
        ],
        'optional_columns': [
            'kakutei_tansho_odds',      # 確定単勝オッズ
            'kakutei_fukusho_odds_min',  # 確定複勝オッズ下限
            'kakutei_fukusho_odds_max',  # 確定複勝オッズ上限
            'tansho_haito',              # 単勝払戻
            'fukusho_haito',             # 複勝払戻
        ]
    },
    'jvd_ra': {
        'description': 'JRA-VAN レースデータ',
        'required_columns': [
            'kaisai_nen',
            'kaisai_tsukihi',
            'keibajo_code',
            'kaisai_kai',
            'kaisai_nichime',
            'race_bango',
        ]
    }
}

# ============================================================================
# データベース接続
# ============================================================================

def load_db_config():
    """DB設定を読み込む"""
    if not DB_CONFIG_PATH.exists():
        print(f"❌ DB設定ファイルが見つかりません: {DB_CONFIG_PATH}")
        print(f"   デフォルト設定を使用します")
        return {
            'host': 'localhost',
            'port': 5432,
            'database': 'pc_keiba',
            'user': 'postgres',
            'password': 'postgres'
        }
    
    with open(DB_CONFIG_PATH, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config['database']

def connect_database():
    """データベースに接続"""
    try:
        config = load_db_config()
        conn = psycopg2.connect(
            host=config['host'],
            port=config['port'],
            database=config['database'],
            user=config['user'],
            password=config['password']
        )
        return conn
    except Exception as e:
        print(f"❌ データベース接続エラー: {e}")
        return None

# ============================================================================
# テーブル・カラム確認
# ============================================================================

def check_table_exists(conn, table_name):
    """テーブルの存在を確認"""
    query = """
    SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = %s
    );
    """
    cursor = conn.cursor()
    cursor.execute(query, (table_name,))
    exists = cursor.fetchone()[0]
    cursor.close()
    return exists

def get_table_columns(conn, table_name):
    """テーブルのカラム一覧を取得"""
    query = """
    SELECT column_name 
    FROM information_schema.columns 
    WHERE table_name = %s
    ORDER BY ordinal_position;
    """
    cursor = conn.cursor()
    cursor.execute(query, (table_name,))
    columns = [row[0] for row in cursor.fetchall()]
    cursor.close()
    return columns

def check_table_structure(conn, table_name, table_info):
    """テーブル構造を確認"""
    print(f"\n### テーブル: {table_name} ({table_info['description']})")
    
    # テーブルの存在確認
    if not check_table_exists(conn, table_name):
        print(f"   ❌ テーブルが存在しません")
        return False
    
    print(f"   ✅ テーブル存在")
    
    # カラム一覧取得
    actual_columns = get_table_columns(conn, table_name)
    print(f"   📊 カラム数: {len(actual_columns)}")
    
    # 必須カラムの確認
    missing_required = []
    for col in table_info['required_columns']:
        if col not in actual_columns:
            missing_required.append(col)
    
    if missing_required:
        print(f"   ❌ 必須カラムが不足:")
        for col in missing_required:
            print(f"      - {col}")
        return False
    else:
        print(f"   ✅ 必須カラム全て存在")
    
    # オプションカラムの確認
    if 'optional_columns' in table_info:
        found_optional = []
        missing_optional = []
        for col in table_info['optional_columns']:
            if col in actual_columns:
                found_optional.append(col)
            else:
                missing_optional.append(col)
        
        print(f"   📋 オプションカラム:")
        if found_optional:
            print(f"      ✅ 存在: {', '.join(found_optional)}")
        if missing_optional:
            print(f"      ⚠️  不在: {', '.join(missing_optional)}")
    
    return True

# ============================================================================
# データ存在確認
# ============================================================================

def check_2025_data(conn):
    """2025年のデータ存在を確認"""
    print(f"\n## 📅 2025年データの確認")
    
    # jvd_seテーブルで2025年のレコード数を確認
    query = """
    SELECT COUNT(*) 
    FROM jvd_se 
    WHERE kaisai_nen = '2025';
    """
    
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        count = cursor.fetchone()[0]
        cursor.close()
        
        if count > 0:
            print(f"   ✅ 2025年データ: {count:,}件")
            
            # 月別の確認
            query_monthly = """
            SELECT 
                SUBSTRING(kaisai_tsukihi, 1, 2) AS month,
                COUNT(*) AS count
            FROM jvd_se
            WHERE kaisai_nen = '2025'
            GROUP BY SUBSTRING(kaisai_tsukihi, 1, 2)
            ORDER BY month;
            """
            cursor = conn.cursor()
            cursor.execute(query_monthly)
            monthly_data = cursor.fetchall()
            cursor.close()
            
            print(f"   📊 月別データ:")
            for month, cnt in monthly_data:
                print(f"      - {month}月: {cnt:,}件")
            
            return True
        else:
            print(f"   ❌ 2025年データが存在しません")
            return False
            
    except Exception as e:
        print(f"   ❌ エラー: {e}")
        return False

def check_odds_payout_data(conn):
    """確定オッズ・払戻データの確認"""
    print(f"\n## 💰 確定オッズ・払戻データの確認")
    
    # オッズ・払戻カラムの存在確認
    columns = get_table_columns(conn, 'jvd_se')
    
    odds_columns = {
        'kakutei_tansho_odds': '確定単勝オッズ',
        'kakutei_fukusho_odds_min': '確定複勝オッズ下限',
        'kakutei_fukusho_odds_max': '確定複勝オッズ上限'
    }
    
    payout_columns = {
        'tansho_haito': '単勝払戻',
        'fukusho_haito': '複勝払戻'
    }
    
    # オッズカラムの確認
    print(f"\n### オッズデータ")
    odds_exists = False
    for col, desc in odds_columns.items():
        if col in columns:
            print(f"   ✅ {desc} ({col}): 存在")
            odds_exists = True
        else:
            print(f"   ❌ {desc} ({col}): 不在")
    
    # 払戻カラムの確認
    print(f"\n### 払戻データ")
    payout_exists = False
    for col, desc in payout_columns.items():
        if col in columns:
            print(f"   ✅ {desc} ({col}): 存在")
            payout_exists = True
        else:
            print(f"   ❌ {desc} ({col}): 不在")
    
    if not odds_exists and not payout_exists:
        print(f"\n   ⚠️  重要: オッズ・払戻データが jvd_se テーブルに存在しません")
        print(f"   ")
        print(f"   【代替案】")
        print(f"   1. TARGET frontier JV でオッズCSV・配当CSVをエクスポート")
        print(f"   2. 別テーブル（n_uma_race, n_haito等）が存在する可能性")
        print(f"   3. JRDBデータ（jrd_*）にオッズ・配当が含まれている可能性")
        return False
    
    # データのサンプル確認（2025年）
    if odds_exists or payout_exists:
        sample_cols = ['kaisai_nen', 'kaisai_tsukihi', 'race_bango', 'umaban', 'kakutei_chakujun']
        if odds_exists:
            sample_cols.extend([col for col in odds_columns.keys() if col in columns])
        if payout_exists:
            sample_cols.extend([col for col in payout_columns.keys() if col in columns])
        
        query = f"""
        SELECT {', '.join(sample_cols)}
        FROM jvd_se
        WHERE kaisai_nen = '2025'
        AND kakutei_chakujun = 1
        LIMIT 5;
        """
        
        try:
            df = pd.read_sql(query, conn)
            if not df.empty:
                print(f"\n   📋 サンプルデータ（2025年・1着馬）:")
                print(df.to_string(index=False))
            else:
                print(f"\n   ⚠️  2025年の1着馬データがありません")
        except Exception as e:
            print(f"\n   ❌ サンプルデータ取得エラー: {e}")
    
    return odds_exists or payout_exists

def check_prediction_csv():
    """予測結果CSVの確認"""
    print(f"\n## 📄 予測結果CSVの確認")
    
    results_dir = Path('results')
    if not results_dir.exists():
        print(f"   ❌ results/ ディレクトリが存在しません")
        return False
    
    # 2025年のCSVファイルを検索
    csv_files = list(results_dir.glob('predictions_2025*.csv'))
    
    if not csv_files:
        print(f"   ❌ 2025年の予測CSVが見つかりません")
        print(f"   📝 期待されるファイル名: predictions_20250101.csv など")
        return False
    
    print(f"   ✅ 予測CSVファイル: {len(csv_files)}件")
    for csv_file in sorted(csv_files)[:10]:  # 最大10件表示
        size_kb = csv_file.stat().st_size / 1024
        print(f"      - {csv_file.name} ({size_kb:.1f} KB)")
    
    # 最新のCSVを確認
    latest_csv = sorted(csv_files)[-1]
    try:
        df = pd.read_csv(latest_csv)
        print(f"\n   📊 最新CSV: {latest_csv.name}")
        print(f"      - 行数: {len(df):,}")
        print(f"      - カラム数: {len(df.columns)}")
        
        required_cols = ['race_id', 'umaban', 'ensemble_score']
        missing_cols = [col for col in required_cols if col not in df.columns]
        
        if missing_cols:
            print(f"      ❌ 必須カラムが不足: {', '.join(missing_cols)}")
            return False
        else:
            print(f"      ✅ 必須カラム全て存在")
        
        # サンプルデータ表示
        print(f"\n   📋 サンプルデータ:")
        print(df.head(3).to_string(index=False))
        
        return True
        
    except Exception as e:
        print(f"   ❌ CSV読み込みエラー: {e}")
        return False

# ============================================================================
# メイン処理
# ============================================================================

def main():
    """メイン処理"""
    print("=" * 80)
    print("Phase 2C データ要件確認")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("")
    
    # 1. 予測CSVの確認
    csv_ok = check_prediction_csv()
    
    # 2. データベース接続
    print(f"\n## 🔌 データベース接続")
    conn = connect_database()
    
    if conn is None:
        print("\n" + "=" * 80)
        print("❌ データベース接続失敗")
        print("=" * 80)
        return 1
    
    print(f"   ✅ データベース接続成功")
    
    # 3. テーブル構造の確認
    print(f"\n## 🗄️  テーブル構造の確認")
    
    all_tables_ok = True
    for table_name, table_info in REQUIRED_TABLES.items():
        table_ok = check_table_structure(conn, table_name, table_info)
        if not table_ok:
            all_tables_ok = False
    
    # 4. 2025年データの確認
    data_2025_ok = check_2025_data(conn)
    
    # 5. オッズ・払戻データの確認
    odds_payout_ok = check_odds_payout_data(conn)
    
    conn.close()
    
    # 6. 結果サマリー
    print("\n" + "=" * 80)
    print("📊 確認結果サマリー")
    print("=" * 80)
    
    results = {
        '予測CSVファイル': csv_ok,
        'データベース接続': True,
        'テーブル構造': all_tables_ok,
        '2025年データ': data_2025_ok,
        'オッズ・払戻データ': odds_payout_ok
    }
    
    for item, status in results.items():
        status_icon = "✅" if status else "❌"
        print(f"   {status_icon} {item}")
    
    all_ok = all(results.values())
    
    if all_ok:
        print("\n✅ 全ての要件を満たしています！")
        print("   Phase 2C の実装を開始できます。")
        return 0
    else:
        print("\n⚠️  一部の要件が満たされていません")
        print("\n【次のアクション】")
        
        if not csv_ok:
            print("   1. Phase 6 で2025年の予測を実行してください")
        
        if not data_2025_ok:
            print("   2. 2025年のJRA-VANデータをインポートしてください")
        
        if not odds_payout_ok:
            print("   3. オッズ・払戻データの取得方法を確認してください:")
            print("      - TARGET frontier JV でCSVエクスポート")
            print("      - 別テーブル（n_uma_race, n_haito等）の確認")
            print("      - JRDBデータの確認")
        
        return 1

if __name__ == '__main__':
    sys.exit(main())
