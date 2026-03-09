#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
2025年レース予測生成バッチ（Phase 2C専用版）

Phase 6 スクリプト（Phase 2C専用モデル使用）を使って2025年1月～12月の予測を生成し、
検証用フォルダに整理して保存する

モデル: 2016-2024年訓練モデル（Phase 2C検証用）
  - models/jra_binary_model_2016_2024.txt
  - models/jra_ranking_model_2016_2024.txt
  - models/jra_regression_model_2016_2024.txt

出力先:
  results/validation/predictions_2025_phase2c/
    ├── csv/
    │   ├── predictions_20250105.csv
    │   ├── predictions_20250106.csv
    │   └── ...
    └── markdown/
        ├── 20250105_note.md
        ├── 20250105_bookers.md
        └── ...

JRA中央競馬のみを対象とし、地方競馬は除外
"""

import subprocess
import psycopg2
import yaml
import shutil
from pathlib import Path
from datetime import datetime

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def get_race_dates_by_month(year='2025', month=None):
    """指定年月の開催日一覧を取得（JRA中央競馬のみ）"""
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    # JRA競馬場コード（中央競馬のみ）
    jra_codes = ('01','02','03','04','05','06','07','08','09','10')
    
    if month:
        # 特定月のみ（JRA競馬場、レース数12以上の日のみ）
        month_str = f"{int(month):02d}"
        cursor.execute("""
            SELECT kaisai_tsukihi
            FROM jvd_se
            WHERE kaisai_nen = %s 
              AND SUBSTRING(kaisai_tsukihi, 1, 2) = %s
              AND keibajo_code IN %s
              AND kakutei_chakujun IS NOT NULL
              AND kakutei_chakujun != ''
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
            ORDER BY kaisai_tsukihi;
        """, (year, month_str, jra_codes))
    else:
        # 全月（JRA競馬場、レース数12以上の日のみ）
        cursor.execute("""
            SELECT kaisai_tsukihi
            FROM jvd_se
            WHERE kaisai_nen = %s
              AND keibajo_code IN %s
              AND kakutei_chakujun IS NOT NULL
              AND kakutei_chakujun != ''
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
            ORDER BY kaisai_tsukihi;
        """, (year, jra_codes))
    
    dates = [row[0] for row in cursor.fetchall()]
    
    cursor.close()
    conn.close()
    
    return dates

def get_monthly_summary(year='2025'):
    """月別のレース日数を取得（JRA中央競馬のみ）"""
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    # JRA競馬場コード（中央競馬のみ）
    jra_codes = ('01','02','03','04','05','06','07','08','09','10')
    
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
              AND keibajo_code IN %s
              AND kakutei_chakujun IS NOT NULL
              AND kakutei_chakujun != ''
            GROUP BY kaisai_tsukihi
            HAVING COUNT(DISTINCT keibajo_code || race_bango) >= 12
        ) as valid_days
        GROUP BY SUBSTRING(kaisai_tsukihi, 1, 2)
        ORDER BY month;
    """, (year, jra_codes))
    
    summary = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return summary

def setup_output_directories():
    """出力ディレクトリを作成"""
    base_dir = Path("results/validation/predictions_2025_phase2c")
    csv_dir = base_dir / "csv"
    md_dir = base_dir / "markdown"
    
    csv_dir.mkdir(parents=True, exist_ok=True)
    md_dir.mkdir(parents=True, exist_ok=True)
    
    print("=" * 80)
    print("📁 出力ディレクトリを作成")
    print("=" * 80)
    print(f"✅ CSV出力先: {csv_dir}")
    print(f"✅ Markdown出力先: {md_dir}")
    
    return csv_dir, md_dir

def organize_prediction_files(target_date, csv_dir, md_dir):
    """
    Phase 6 が results/ 直下に生成したファイルを整理して移動
    
    Args:
        target_date: YYYYMMDD形式の日付 (例: "20250105")
        csv_dir: CSV移動先ディレクトリ
        md_dir: Markdown移動先ディレクトリ
    """
    results_dir = Path("results")
    date_str = target_date[4:8]  # "0105"
    
    # CSVファイルを移動
    csv_file = results_dir / f"predictions_{target_date}.csv"
    if csv_file.exists():
        dest = csv_dir / csv_file.name
        shutil.move(str(csv_file), str(dest))
        print(f"  📄 CSV移動: {csv_file.name} → csv/")
    
    # Markdownファイルを移動（note, bookers, tweet）
    # 投稿用フォルダが存在する場合
    post_dir = results_dir / "投稿用"
    if post_dir.exists():
        # noteファイル
        for pattern in [f"*_{date_str}_note.txt", f"*_{target_date}_note.txt"]:
            for md_file in post_dir.glob(pattern):
                dest = md_dir / md_file.name
                shutil.copy2(str(md_file), str(dest))
                print(f"  📝 Markdown移動: {md_file.name} → markdown/")
        
        # bookersファイル
        for pattern in [f"*_{date_str}_bookers.txt", f"*_{target_date}_bookers.txt"]:
            for md_file in post_dir.glob(pattern):
                dest = md_dir / md_file.name
                shutil.copy2(str(md_file), str(dest))
                print(f"  📝 Markdown移動: {md_file.name} → markdown/")
        
        # tweetファイル
        for pattern in [f"*_{date_str}_tweet.txt", f"*_{target_date}_tweet.txt"]:
            for md_file in post_dir.glob(pattern):
                dest = md_dir / md_file.name
                shutil.copy2(str(md_file), str(dest))
                print(f"  📝 Markdown移動: {md_file.name} → markdown/")

def run_predictions_for_month(year, month, csv_dir, md_dir):
    """指定月の予測を実行（JRA中央競馬のみ）"""
    print("\n" + "=" * 80)
    print(f"📅 {year}年{month}月の予測生成を開始（JRA中央競馬のみ）")
    print("=" * 80)
    
    # 開催日を取得
    race_dates = get_race_dates_by_month(year, month)
    
    if not race_dates:
        print(f"⚠️  {year}年{month}月の開催日が見つかりません")
        return 0, 0, []
    
    print(f"✅ 開催日数: {len(race_dates)}日（JRA中央競馬のみ）")
    
    success_count = 0
    error_count = 0
    error_dates = []
    
    for idx, date_str in enumerate(race_dates, 1):
        # 日付フォーマット変換: "0105" → "20250105"
        target_date = f"{year}{date_str}"
        
        print(f"\n[{idx}/{len(race_dates)}] {target_date[:4]}年{target_date[4:6]}月{target_date[6:8]}日")
        
        # Phase 6 スクリプトを実行
        cmd = [
            "python",
            "scripts/phase6/phase6_daily_prediction_phase2c.py",
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
                print("  ✅ 予測生成成功")
                
                # ファイルを整理して移動
                organize_prediction_files(target_date, csv_dir, md_dir)
                
                success_count += 1
            else:
                print(f"  ❌ 予測生成失敗 (終了コード: {result.returncode})")
                if result.stderr:
                    print(f"  エラー: {result.stderr[:200]}")
                error_count += 1
                error_dates.append(target_date)
        
        except subprocess.TimeoutExpired:
            print("  ⏱️ タイムアウト（5分超過）")
            error_count += 1
            error_dates.append(target_date)
        
        except Exception as e:
            print(f"  ❌ 例外発生: {e}")
            error_count += 1
            error_dates.append(target_date)
    
    return success_count, error_count, error_dates

def cleanup_temp_files():
    """results/ 直下の一時ファイルをクリーンアップ"""
    results_dir = Path("results")
    
    print("\n" + "=" * 80)
    print("🧹 一時ファイルのクリーンアップ")
    print("=" * 80)
    
    # 地方競馬ファイルを削除
    local_keiba_patterns = [
        "*中元*",  # 帯広（ばんえい）
        "*門別*",  # 門別
        "*盛岡*",  # 盛岡
        "*水沢*",  # 水沢
        "*浦和*",  # 浦和
        "*船橋*",  # 船橋
        "*大井*",  # 大井
        "*川崎*",  # 川崎
        "*金沢*",  # 金沢
        "*笠松*",  # 笠松
        "*名古屋*", # 名古屋
        "*園田*",  # 園田
        "*姫路*",  # 姫路
        "*高知*",  # 高知
        "*佐賀*",  # 佐賀
    ]
    
    deleted_count = 0
    for pattern in local_keiba_patterns:
        for file_path in results_dir.rglob(pattern):
            if file_path.is_file():
                print(f"  🗑️ 削除: {file_path.name}")
                file_path.unlink()
                deleted_count += 1
    
    if deleted_count > 0:
        print(f"✅ 地方競馬ファイル {deleted_count}個を削除")
    else:
        print("✅ 削除対象ファイルなし")

def main():
    print("=" * 80)
    print("🚀 2025年JRA中央競馬予測生成バッチ（整理版）")
    print("=" * 80)
    print("📌 JRA中央競馬のみを対象（地方競馬は除外）")
    print("📌 出力先: results/validation/predictions_2025/")
    print("=" * 80)
    
    year = '2025'
    
    # 出力ディレクトリを作成
    csv_dir, md_dir = setup_output_directories()
    
    # 月別サマリーを表示
    print("\n📊 2025年の開催日サマリー（JRA中央競馬のみ）")
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
        print("\n⚠️  1月～12月の全開催日を実行します（JRA中央競馬のみ）")
        response = input("続行しますか？ (yes/no): ")
        
        if response.lower() not in ['yes', 'y']:
            print("❌ キャンセルしました")
            return
        
        for month in range(1, 13):
            success, errors, error_dates = run_predictions_for_month(year, month, csv_dir, md_dir)
            all_success += success
            all_errors += errors
            all_error_dates.extend(error_dates)
    
    else:
        # 特定月のみ
        month = choice
        print(f"\n⚠️  {year}年{month}月のみ実行します（JRA中央競馬のみ）")
        response = input("続行しますか？ (yes/no): ")
        
        if response.lower() not in ['yes', 'y']:
            print("❌ キャンセルしました")
            return
        
        success, errors, error_dates = run_predictions_for_month(year, month, csv_dir, md_dir)
        all_success += success
        all_errors += errors
        all_error_dates.extend(error_dates)
    
    # 一時ファイルをクリーンアップ
    cleanup_temp_files()
    
    # 結果サマリー
    print("\n" + "=" * 80)
    print("📊 実行結果サマリー")
    print("=" * 80)
    print(f"✅ 成功: {all_success}日")
    print(f"❌ 失敗: {all_errors}日")
    
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
    
    csv_files = sorted(csv_dir.glob(f"predictions_{year}*.csv"))
    md_files = sorted(md_dir.glob("*.txt"))
    
    print(f"✅ 予測CSVファイル: {len(csv_files)}個")
    print(f"   保存先: {csv_dir}")
    
    if csv_files:
        print(f"\n   最初の5ファイル:")
        for f in csv_files[:5]:
            print(f"     - {f.name}")
        if len(csv_files) > 5:
            print(f"     ... 他 {len(csv_files)-5}ファイル")
    
    print(f"\n✅ Markdownファイル: {len(md_files)}個")
    print(f"   保存先: {md_dir}")
    
    if md_files:
        print(f"\n   最初の5ファイル:")
        for f in md_files[:5]:
            print(f"     - {f.name}")
        if len(md_files) > 5:
            print(f"     ... 他 {len(md_files)-5}ファイル")
    
    print("\n" + "=" * 80)
    print("✅ バッチ実行完了")
    print("=" * 80)
    print(f"\n📂 出力ディレクトリ:")
    print(f"   {Path('results/validation/predictions_2025').absolute()}")

if __name__ == "__main__":
    main()
