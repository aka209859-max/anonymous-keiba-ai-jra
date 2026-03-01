#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
2025年全レースの予測CSVを一括生成

Phase 6 スクリプトを使って2025年1月～12月の全レース予測を生成
"""

import subprocess
import psycopg2
import yaml
from pathlib import Path
from datetime import datetime, timedelta

def load_db_config():
    """データベース設定を読み込み"""
    config_path = Path("config/db_config.yaml")
    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    return config.get('jravan', {})

def get_race_dates_2025():
    """2025年の開催日一覧を取得"""
    db_config = load_db_config()
    conn = psycopg2.connect(
        host=db_config.get('host', 'localhost'),
        port=db_config.get('port', 5432),
        database=db_config.get('database', 'pckeiba'),
        user=db_config.get('user', 'postgres'),
        password=db_config.get('password', '')
    )
    
    cursor = conn.cursor()
    
    # 2025年の開催日一覧を取得（重複なし、昇順）
    cursor.execute("""
        SELECT DISTINCT kaisai_tsukihi
        FROM jvd_se
        WHERE kaisai_nen = '2025'
        ORDER BY kaisai_tsukihi;
    """)
    
    dates = [row[0] for row in cursor.fetchall()]
    
    cursor.close()
    conn.close()
    
    return dates

def main():
    print("=" * 80)
    print("🚀 2025年全レース予測生成バッチ")
    print("=" * 80)
    
    # 2025年の開催日を取得
    print("\n📅 2025年の開催日を取得中...")
    race_dates = get_race_dates_2025()
    
    if not race_dates:
        print("❌ 2025年の開催日が見つかりません")
        return
    
    print(f"✅ 開催日数: {len(race_dates)}日")
    print(f"   期間: 2025年{race_dates[0][:2]}月{race_dates[0][2:4]}日 ~ {race_dates[-1][:2]}月{race_dates[-1][2:4]}日")
    
    # 確認
    print("\n" + "=" * 80)
    print(f"⚠️  Phase 6 スクリプトを {len(race_dates)}回 実行します")
    print("=" * 80)
    
    response = input("\n続行しますか？ (yes/no): ")
    if response.lower() not in ['yes', 'y']:
        print("❌ キャンセルしました")
        return
    
    # バッチ実行
    print("\n" + "=" * 80)
    print("🔄 予測生成を開始...")
    print("=" * 80)
    
    success_count = 0
    error_count = 0
    error_dates = []
    
    for idx, date_str in enumerate(race_dates, 1):
        # 日付フォーマット変換: "0105" → "20250105"
        target_date = f"2025{date_str}"
        
        print(f"\n[{idx}/{len(race_dates)}] {target_date[:4]}年{target_date[4:6]}月{target_date[6:8]}日")
        print("-" * 80)
        
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
                print(f"✅ 成功")
                success_count += 1
            else:
                print(f"❌ エラー（終了コード: {result.returncode}）")
                if result.stderr:
                    print(f"   エラー内容: {result.stderr[:200]}")
                error_count += 1
                error_dates.append(target_date)
        
        except subprocess.TimeoutExpired:
            print(f"⏱️  タイムアウト（5分経過）")
            error_count += 1
            error_dates.append(target_date)
        
        except Exception as e:
            print(f"❌ 例外発生: {e}")
            error_count += 1
            error_dates.append(target_date)
    
    # 結果サマリー
    print("\n" + "=" * 80)
    print("📊 実行結果サマリー")
    print("=" * 80)
    print(f"総開催日数: {len(race_dates)}日")
    print(f"成功: {success_count}日")
    print(f"失敗: {error_count}日")
    
    if error_dates:
        print(f"\n❌ 失敗した日付:")
        for date in error_dates[:10]:
            print(f"   - {date}")
        if len(error_dates) > 10:
            print(f"   ... 他 {len(error_dates)-10}日")
    
    # 生成されたファイルを確認
    print("\n" + "=" * 80)
    print("📁 生成されたファイルを確認")
    print("=" * 80)
    
    results_dir = Path("results")
    prediction_files = sorted(results_dir.glob("predictions_2025*.csv"))
    
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
