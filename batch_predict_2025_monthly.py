#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
2025年レース予測生成バッチ（月別実行版）

Phase 6 スクリプトを使って2025年1月～12月の予測を月別に生成
データ量が多いため、月ごとに分割実行する
"""

import subprocess
import psycopg2
import yaml
from pathlib import Path
from datetime import datetime

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def get_race_dates_by_month(year='2025', month=None):
    """指定年月の開催日一覧を取得"""
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    if month:
        # 特定月のみ（レース数12以上の日のみ）
        month_str = f"{int(month):02d}"
        cursor.execute("""
            SELECT kaisai_tsukihi
            FROM jvd_se
            WHERE kaisai_nen = %s AND SUBSTRING(kaisai_tsukihi, 1, 2) = %s
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
            ORDER BY kaisai_tsukihi;
        """, (year, month_str))
    else:
        # 全月（レース数12以上の日のみ）
        cursor.execute("""
            SELECT kaisai_tsukihi
            FROM jvd_se
            WHERE kaisai_nen = %s
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
            ORDER BY kaisai_tsukihi;
        """, (year,))
    
    dates = [row[0] for row in cursor.fetchall()]
    
    cursor.close()
    conn.close()
    
    return dates

def get_monthly_summary(year='2025'):
    """月別のレース日数を取得"""
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT 
            SUBSTRING(kaisai_tsukihi, 1, 2) as month,
            COUNT(DISTINCT kaisai_tsukihi) as days,
            SUM(race_count) as races
        FROM (
            SELECT 
                kaisai_tsukihi,
                COUNT(DISTINCT keibajo_code || race_bango) as race_count
            FROM jvd_se
            WHERE kaisai_nen = %s
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
        ) as valid_days
        GROUP BY SUBSTRING(kaisai_tsukihi, 1, 2)
        ORDER BY month;
    """, (year,))
    
    summary = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return summary

def run_predictions_for_month(year, month):
    """指定月の予測を実行"""
    print("\n" + "=" * 80)
    print(f"📅 {year}年{month}月の予測生成を開始")
    print("=" * 80)
    
    # 開催日を取得
    race_dates = get_race_dates_by_month(year, month)
    
    if not race_dates:
        print(f"⚠️  {year}年{month}月の開催日が見つかりません")
        return 0, 0, []
    
    print(f"✅ 開催日数: {len(race_dates)}日")
    
    success_count = 0
    error_count = 0
    error_dates = []
    
    for idx, date_str in enumerate(race_dates, 1):
        # 日付フォーマット変換: "0105" → "20250105"
        target_date = f"{year}{date_str}"
        
        print(f"\n[{idx}/{len(race_dates)}] {target_date[:4]}年{target_date[4:6]}月{target_date[6:8]}日", end=" ")
        
        # Phase 6 スクリプトを実行
        cmd = [
            "python",
            "scripts/phase6/phase6_daily_prediction.py",
            "--target-date",
            target_date
        ]
        
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=300  # 5分タイムアウト
            )
            
            if result.returncode == 0:
                print("✅")
                success_count += 1
            else:
                print(f"❌ (終了コード: {result.returncode})")
                error_count += 1
                error_dates.append(target_date)
        
        except subprocess.TimeoutExpired:
            print("⏱️ タイムアウト")
            error_count += 1
            error_dates.append(target_date)
        
        except Exception as e:
            print(f"❌ 例外: {e}")
            error_count += 1
            error_dates.append(target_date)
    
    return success_count, error_count, error_dates

def main():
    print("=" * 80)
    print("🚀 2025年全レース予測生成バッチ（月別実行版）")
    print("=" * 80)
    
    year = '2025'
    
    # 月別サマリーを表示
    print("\n📊 2025年の開催日サマリー")
    print("-" * 80)
    
    monthly_summary = get_monthly_summary(year)
    
    print(f"{'月':<6} {'開催日数':<10} {'レース数':<10}")
    print("-" * 40)
    
    total_days = 0
    total_races = 0
    
    for month, days, races in monthly_summary:
        print(f"{month}月   {days:>6}日    {races:>8}レース")
        total_days += days
        total_races += races
    
    print("-" * 40)
    print(f"合計   {total_days:>6}日    {total_races:>8}レース")
    
    # 推定時間を計算
    estimated_time_min = total_days * 0.5  # 1日あたり30秒
    estimated_time_max = total_days * 1.5  # 1日あたり90秒
    
    print("\n⏱️  推定実行時間:")
    print(f"   最短: {estimated_time_min/60:.1f}分 ({estimated_time_min:.0f}秒)")
    print(f"   最長: {estimated_time_max/60:.1f}分 ({estimated_time_max:.0f}秒)")
    
    # 実行月を選択
    print("\n" + "=" * 80)
    print("📅 実行する月を選択してください")
    print("=" * 80)
    print("  0: 全月（1月～12月）を一括実行")
    print("  1～12: 特定の月のみ実行")
    print("  例: '1' を入力すると1月のみ実行")
    
    choice = input("\n選択 (0-12): ").strip()
    
    if not choice.isdigit() or int(choice) < 0 or int(choice) > 12:
        print("❌ 無効な選択です")
        return
    
    choice = int(choice)
    
    # 実行
    all_success = 0
    all_errors = 0
    all_error_dates = []
    
    if choice == 0:
        # 全月実行
        print("\n⚠️  1月～12月の全開催日を実行します")
        response = input("続行しますか？ (yes/no): ")
        
        if response.lower() not in ['yes', 'y']:
            print("❌ キャンセルしました")
            return
        
        for month in range(1, 13):
            success, errors, error_dates = run_predictions_for_month(year, month)
            all_success += success
            all_errors += errors
            all_error_dates.extend(error_dates)
    
    else:
        # 特定月のみ
        month = choice
        print(f"\n⚠️  {year}年{month}月のみ実行します")
        response = input("続行しますか？ (yes/no): ")
        
        if response.lower() not in ['yes', 'y']:
            print("❌ キャンセルしました")
            return
        
        success, errors, error_dates = run_predictions_for_month(year, month)
        all_success += success
        all_errors += errors
        all_error_dates.extend(error_dates)
    
    # 結果サマリー
    print("\n" + "=" * 80)
    print("📊 実行結果サマリー")
    print("=" * 80)
    print(f"成功: {all_success}日")
    print(f"失敗: {all_errors}日")
    
    if all_error_dates:
        print(f"\n❌ 失敗した日付:")
        for date in all_error_dates[:10]:
            print(f"   - {date}")
        if len(all_error_dates) > 10:
            print(f"   ... 他 {len(all_error_dates)-10}日")
    
    # 生成されたファイルを確認
    print("\n" + "=" * 80)
    print("📁 生成されたファイルを確認")
    print("=" * 80)
    
    results_dir = Path("results")
    prediction_files = sorted(results_dir.glob(f"predictions_{year}*.csv"))
    
    print(f"✅ 予測CSVファイル: {len(prediction_files)}個")
    
    if prediction_files:
        print(f"\n最初の5ファイル:")
        for f in prediction_files[:5]:
            print(f"  - {f.name}")
        if len(prediction_files) > 5:
            print(f"  ... 他 {len(prediction_files)-5}ファイル")
    
    print("\n" + "=" * 80)
    print("✅ バッチ実行完了")
    print("=" * 80)

if __name__ == "__main__":
    main()
