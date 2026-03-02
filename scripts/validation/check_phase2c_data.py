#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 2C データ確認スクリプト

2025年のデータ（予測CSV + 実績DB）が揃っているか確認します。
"""

import sys
import psycopg2
from pathlib import Path
from datetime import datetime
import yaml

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    
    if not config_path.exists():
        print(f"❌ 設定ファイルが見つかりません: {config_path}")
        print("\n💡 ヒント: config/db_config.yaml を確認してください")
        return None
    
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    return config.get('jravan', {})

def check_database_connection(db_config):
    """データベース接続をテスト"""
    print("=" * 80)
    print("📡 データベース接続テスト")
    print("=" * 80)
    
    if not db_config:
        return None
    
    try:
        conn = psycopg2.connect(
            host=db_config.get('host', 'localhost'),
            port=db_config.get('port', 5432),
            database=db_config.get('database', 'pckeiba'),
            user=db_config.get('user', 'postgres'),
            password=db_config.get('password', '')
        )
        
        print(f"✅ データベース接続成功")
        print(f"   - Host: {db_config.get('host')}")
        print(f"   - Port: {db_config.get('port')}")
        print(f"   - Database: {db_config.get('database')}")
        print(f"   - User: {db_config.get('user')}")
        
        return conn
        
    except psycopg2.OperationalError as e:
        print(f"❌ データベース接続エラー")
        print(f"   エラー内容: {e}")
        print("\n💡 確認事項:")
        print("   1. PostgreSQLサービスが起動しているか")
        print("   2. config/db_config.yaml のパスワードが正しいか")
        print("   3. データベース名 'pckeiba' が存在するか")
        return None

def check_table_structure(conn, table_name):
    """テーブル構造を確認"""
    print(f"\n📋 テーブル構造確認: {table_name}")
    print("-" * 80)
    
    try:
        cursor = conn.cursor()
        
        # テーブルが存在するか確認
        cursor.execute("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = %s
            );
        """, (table_name,))
        
        exists = cursor.fetchone()[0]
        
        if not exists:
            print(f"❌ テーブル '{table_name}' が見つかりません")
            return False
        
        print(f"✅ テーブル '{table_name}' が存在します")
        
        # カラム一覧を取得
        cursor.execute("""
            SELECT column_name, data_type 
            FROM information_schema.columns 
            WHERE table_name = %s
            ORDER BY ordinal_position;
        """, (table_name,))
        
        columns = cursor.fetchall()
        print(f"\n📊 カラム一覧 (全{len(columns)}列):")
        
        # 重要なカラムをチェック
        required_columns_jvd_se = [
            'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code',
            'umaban', 'kakutei_chakujun',
            'kakutei_tansho_odds', 'kakutei_fukusho_odds_min', 'kakutei_fukusho_odds_max',
            'tansho_haito', 'fukusho_haito'
        ]
        
        column_names = [col[0] for col in columns]
        
        for req_col in required_columns_jvd_se:
            if req_col in column_names:
                data_type = [col[1] for col in columns if col[0] == req_col][0]
                print(f"   ✅ {req_col:<30} ({data_type})")
            else:
                print(f"   ❌ {req_col:<30} (存在しない)")
        
        cursor.close()
        return True
        
    except Exception as e:
        print(f"❌ エラー: {e}")
        return False

def check_2025_data(conn, table_name):
    """2025年のデータ件数を確認"""
    print(f"\n📅 2025年データ確認: {table_name}")
    print("-" * 80)
    
    try:
        cursor = conn.cursor()
        
        # 2025年のデータ件数
        cursor.execute(f"""
            SELECT COUNT(*) 
            FROM {table_name}
            WHERE kaisai_nen = '2025';
        """)
        
        count_2025 = cursor.fetchone()[0]
        print(f"✅ 2025年データ件数: {count_2025:,}件")
        
        if count_2025 == 0:
            print("\n⚠️  2025年のデータが存在しません")
            cursor.close()
            return False
        
        # 月別データ件数
        cursor.execute(f"""
            SELECT 
                SUBSTRING(kaisai_tsukihi, 1, 2) AS month,
                COUNT(*) as count
            FROM {table_name}
            WHERE kaisai_nen = '2025'
            GROUP BY SUBSTRING(kaisai_tsukihi, 1, 2)
            ORDER BY month;
        """)
        
        monthly_data = cursor.fetchall()
        
        print(f"\n📊 月別データ件数:")
        for month, count in monthly_data:
            print(f"   {month}月: {count:>6,}件")
        
        # サンプルデータを表示
        cursor.execute(f"""
            SELECT 
                kaisai_nen, kaisai_tsukihi, keibajo_code, umaban,
                kakutei_chakujun, kakutei_tansho_odds, tansho_haito
            FROM {table_name}
            WHERE kaisai_nen = '2025' AND kakutei_chakujun = '01'
            LIMIT 5;
        """)
        
        samples = cursor.fetchall()
        
        if samples:
            print(f"\n📝 サンプルデータ（1着馬）:")
            print(f"   {'年':<6} {'月日':<8} {'場':<4} {'馬番':<6} {'着順':<6} {'単勝オッズ':<12} {'単勝払戻':<10}")
            print("   " + "-" * 70)
            for row in samples:
                print(f"   {row[0]:<6} {row[1]:<8} {row[2]:<4} {row[3]:<6} {row[4]:<6} {row[5]:<12} {row[6]:<10}")
        
        cursor.close()
        return True
        
    except Exception as e:
        print(f"❌ エラー: {e}")
        return False

def check_prediction_csv():
    """予測CSVファイルの存在を確認"""
    print("\n" + "=" * 80)
    print("📁 予測CSVファイル確認")
    print("=" * 80)
    
    results_dir = Path("results")
    
    if not results_dir.exists():
        print(f"❌ resultsディレクトリが存在しません: {results_dir}")
        return False
    
    # 2025年の予測CSVを検索
    prediction_files = list(results_dir.glob("predictions_2025*.csv"))
    
    if not prediction_files:
        print(f"❌ 2025年の予測CSVが見つかりません")
        print(f"   検索パス: {results_dir}/predictions_2025*.csv")
        print("\n💡 予測CSVの生成方法:")
        print("   1. Phase 6 スクリプトで予測を実行")
        print("   2. または、2024年データで検証する")
        return False
    
    print(f"✅ 2025年の予測CSV: {len(prediction_files)}ファイル")
    
    # 日付範囲を確認
    dates = []
    for f in prediction_files:
        try:
            date_str = f.stem.replace('predictions_', '')
            date_obj = datetime.strptime(date_str, '%Y%m%d')
            dates.append(date_obj)
        except:
            continue
    
    if dates:
        dates.sort()
        print(f"   期間: {dates[0].strftime('%Y年%m月%d日')} ~ {dates[-1].strftime('%Y年%m月%d日')}")
        print(f"   ファイル例:")
        for f in sorted(prediction_files)[:5]:
            print(f"     - {f.name}")
        if len(prediction_files) > 5:
            print(f"     ... 他 {len(prediction_files)-5}ファイル")
    
    return True

def main():
    """メイン処理"""
    print("\n" + "=" * 80)
    print("🔍 Phase 2C データ確認スクリプト")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y年%m月%d日 %H:%M:%S')}")
    print("=" * 80)
    
    # 1. 予測CSV確認
    csv_ok = check_prediction_csv()
    
    # 2. データベース接続
    db_config = load_db_config()
    conn = check_database_connection(db_config)
    
    if conn is None:
        print("\n" + "=" * 80)
        print("⚠️  データベース接続に失敗しました")
        print("=" * 80)
        print("\n次のステップ:")
        print("1. config/db_config.yaml のパスワードを確認")
        print("2. PostgreSQL サービスが起動しているか確認")
        print("3. データベース 'pckeiba' が存在するか確認")
        sys.exit(1)
    
    # 3. テーブル構造確認
    table_ok = check_table_structure(conn, 'jvd_se')
    
    # 4. 2025年データ確認
    data_ok = False
    if table_ok:
        data_ok = check_2025_data(conn, 'jvd_se')
    
    conn.close()
    
    # 最終判定
    print("\n" + "=" * 80)
    print("📊 確認結果サマリー")
    print("=" * 80)
    print(f"{'項目':<30} {'状態':<10}")
    print("-" * 80)
    print(f"{'予測CSV (2025年)':<30} {'✅ OK' if csv_ok else '❌ NG':<10}")
    print(f"{'データベース接続':<30} {'✅ OK':<10}")
    print(f"{'テーブル構造 (jvd_se)':<30} {'✅ OK' if table_ok else '❌ NG':<10}")
    print(f"{'2025年実績データ':<30} {'✅ OK' if data_ok else '❌ NG':<10}")
    
    print("\n" + "=" * 80)
    
    if csv_ok and data_ok:
        print("✅ Phase 2C 実装の準備が整っています！")
        print("\n次のステップ:")
        print("  1. scripts/validation/validate_hensachi_odds_matrix.py を実装")
        print("  2. 2025年データでマトリクス分析を実行")
        print("  3. 結果レポートとヒートマップを生成")
    else:
        print("⚠️  Phase 2C に必要なデータが不足しています")
        print("\n対応が必要な項目:")
        if not csv_ok:
            print("  - 2025年の予測CSVを生成してください")
        if not data_ok:
            print("  - 2025年の実績データをデータベースに取り込んでください")
    
    print("=" * 80)

if __name__ == "__main__":
    main()
