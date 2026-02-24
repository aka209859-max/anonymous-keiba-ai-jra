# JRDBデータ自動取得・取り込みスクリプト
# Phase 6 当日予測システム用
# ================================================

"""
JRDBデータの日次自動取得と PC-KEIBA への取り込み

【使用方法】
python scripts/jrdb/download_jrdb_daily.py --target-date 20260221

【前提条件】
1. JRDB会員登録済み
2. PC-KEIBAインストール済み
3. PostgreSQL pckeiba データベースが起動中

【出力】
- data/jrdb/KYI{date}.txt
- data/jrdb/CYB{date}.txt  
- data/jrdb/JOA{date}.txt
- data/jrdb/SED{date}.txt
→ PC-KEIBAが自動取り込み → PostgreSQL jrd_* テーブルに保存
"""

import argparse
import logging
import sys
import os
import time
import requests
from pathlib import Path
from datetime import datetime, timedelta

# ============================================================================
# ログ設定
# ============================================================================

def setup_logging():
    """ログ初期化"""
    log_dir = Path('logs')
    log_dir.mkdir(exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_file = log_dir / f"jrdb_download_{timestamp}.log"
    
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
# JRDB設定
# ============================================================================

class JRDBConfig:
    """JRDB接続設定"""
    
    # JRDB会員情報（環境変数から取得）
    USERNAME = os.getenv('JRDB_USERNAME', '')
    PASSWORD = os.getenv('JRDB_PASSWORD', '')
    
    # JRDBダウンロードURL
    BASE_URL = 'https://www.jrdb.com/member/datazip/download.asp'
    
    # 必要なファイル
    FILES = ['KYI', 'CYB', 'JOA', 'SED']
    
    # ダウンロード先ディレクトリ
    OUTPUT_DIR = Path('data/jrdb')
    
    # PC-KEIBA監視フォルダ（PC-KEIBAで設定したフォルダ）
    PCKEIBA_WATCH_DIR = Path('C:/PC-KEIBA/jrdb_watch')

# ============================================================================
# JRDBダウンロード
# ============================================================================

def download_jrdb_file(file_type: str, target_date: str, logger) -> bool:
    """
    JRDBファイルをダウンロード
    
    Args:
        file_type: ファイル種別 ('KYI', 'CYB', 'JOA', 'SED')
        target_date: 対象日 ('YYYYMMDD')
        logger: ロガー
    
    Returns:
        成功: True, 失敗: False
    """
    # YYYYMMDDからYYMMDDに変換（JRDBの形式）
    jrdb_date = target_date[2:]  # '20260221' → '260221'
    filename = f"{file_type}{jrdb_date}.txt"
    
    url = f"{JRDBConfig.BASE_URL}?file={filename}"
    output_path = JRDBConfig.OUTPUT_DIR / filename
    
    logger.info(f"📥 {file_type} ダウンロード開始: {filename}")
    
    try:
        # Basic認証でダウンロード
        response = requests.get(
            url,
            auth=(JRDBConfig.USERNAME, JRDBConfig.PASSWORD),
            timeout=60
        )
        
        if response.status_code == 200:
            # ファイル保存
            with open(output_path, 'wb') as f:
                f.write(response.content)
            
            file_size_kb = output_path.stat().st_size / 1024
            logger.info(f"✅ {file_type} ダウンロード完了: {output_path} ({file_size_kb:.2f} KB)")
            
            # PC-KEIBA監視フォルダにもコピー
            if JRDBConfig.PCKEIBA_WATCH_DIR.exists():
                pckeiba_path = JRDBConfig.PCKEIBA_WATCH_DIR / filename
                with open(pckeiba_path, 'wb') as f:
                    f.write(response.content)
                logger.info(f"📂 PC-KEIBA監視フォルダにコピー: {pckeiba_path}")
            
            return True
        
        elif response.status_code == 404:
            logger.error(f"❌ {file_type} ダウンロード失敗: ファイルが見つかりません（404）")
            logger.error(f"   → JRDBサイトで {target_date} のデータが公開されているか確認してください")
            return False
        
        elif response.status_code == 401:
            logger.error(f"❌ {file_type} ダウンロード失敗: 認証エラー（401）")
            logger.error(f"   → JRDB_USERNAME と JRDB_PASSWORD を確認してください")
            return False
        
        else:
            logger.error(f"❌ {file_type} ダウンロード失敗: HTTPステータス {response.status_code}")
            return False
    
    except requests.exceptions.Timeout:
        logger.error(f"❌ {file_type} ダウンロード失敗: タイムアウト")
        return False
    
    except Exception as e:
        logger.error(f"❌ {file_type} ダウンロード失敗: {e}")
        return False

def download_all_jrdb_files(target_date: str, logger) -> bool:
    """
    全JRDBファイルをダウンロード
    
    Args:
        target_date: 対象日 ('YYYYMMDD')
        logger: ロガー
    
    Returns:
        全て成功: True, 1つでも失敗: False
    """
    logger.info("=" * 80)
    logger.info(f"JRDBデータ一括ダウンロード（{target_date}）")
    logger.info("=" * 80)
    
    # 出力ディレクトリ作成
    JRDBConfig.OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    # PC-KEIBA監視フォルダ作成
    if not JRDBConfig.PCKEIBA_WATCH_DIR.exists():
        logger.warning(f"⚠️  PC-KEIBA監視フォルダが存在しません: {JRDBConfig.PCKEIBA_WATCH_DIR}")
        logger.warning(f"⚠️  PC-KEIBAの設定で監視フォルダを設定してください")
    
    results = []
    
    for file_type in JRDBConfig.FILES:
        success = download_jrdb_file(file_type, target_date, logger)
        results.append(success)
        time.sleep(1)  # サーバー負荷軽減
    
    logger.info("")
    logger.info("=" * 80)
    logger.info("ダウンロード結果")
    logger.info("=" * 80)
    
    for i, file_type in enumerate(JRDBConfig.FILES):
        status = "✅ 成功" if results[i] else "❌ 失敗"
        logger.info(f"  {file_type}: {status}")
    
    all_success = all(results)
    
    if all_success:
        logger.info("")
        logger.info("✅ 全ファイルのダウンロード完了！")
        logger.info("")
        logger.info("📌 次のステップ:")
        logger.info("  1. PC-KEIBAを起動")
        logger.info("  2. 「JRDB取り込み」を実行（または自動取り込みを待つ）")
        logger.info("  3. Phase 6 予測スクリプトを実行")
        logger.info(f"     python scripts/phase6/phase6_daily_prediction.py --target-date {target_date}")
    else:
        logger.error("")
        logger.error("❌ 一部のファイルダウンロードに失敗しました")
        logger.error("")
        logger.error("📌 トラブルシューティング:")
        logger.error("  1. JRDB会員IDとパスワードを確認")
        logger.error("  2. JRDBサイトで該当日のデータが公開されているか確認")
        logger.error("  3. インターネット接続を確認")
    
    return all_success

# ============================================================================
# メイン処理
# ============================================================================

def main():
    """メイン処理フロー"""
    parser = argparse.ArgumentParser(description='JRDBデータ日次自動ダウンロード')
    parser.add_argument('--target-date', type=str, required=False,
                        help='対象日（YYYYMMDD形式、省略時は翌日）')
    
    args = parser.parse_args()
    
    # 対象日決定（省略時は翌日）
    if args.target_date:
        target_date = args.target_date
    else:
        tomorrow = datetime.now() + timedelta(days=1)
        target_date = tomorrow.strftime('%Y%m%d')
    
    # 入力検証
    if len(target_date) != 8 or not target_date.isdigit():
        print(f"❌ エラー: 無効な日付形式です（期待: YYYYMMDD、入力: {target_date}）")
        sys.exit(1)
    
    # ログ初期化
    logger = setup_logging()
    
    # 認証情報確認
    if not JRDBConfig.USERNAME or not JRDBConfig.PASSWORD:
        logger.error("❌ エラー: JRDB認証情報が設定されていません")
        logger.error("")
        logger.error("以下の環境変数を設定してください:")
        logger.error("  Windows PowerShell:")
        logger.error("    $env:JRDB_USERNAME='your_username'")
        logger.error("    $env:JRDB_PASSWORD='your_password'")
        logger.error("")
        logger.error("  または、.envファイルに記載:")
        logger.error("    JRDB_USERNAME=your_username")
        logger.error("    JRDB_PASSWORD=your_password")
        sys.exit(1)
    
    logger.info("")
    logger.info("=" * 80)
    logger.info(f"JRDBデータ自動ダウンロード")
    logger.info("=" * 80)
    logger.info(f"対象日: {target_date}")
    logger.info(f"ユーザー: {JRDBConfig.USERNAME}")
    logger.info(f"出力先: {JRDBConfig.OUTPUT_DIR}")
    logger.info("")
    
    # ダウンロード実行
    try:
        success = download_all_jrdb_files(target_date, logger)
        
        if success:
            logger.info("")
            logger.info("=" * 80)
            logger.info("✅ JRDBデータダウンロード完了！")
            logger.info("=" * 80)
            sys.exit(0)
        else:
            logger.error("")
            logger.error("=" * 80)
            logger.error("❌ JRDBデータダウンロード失敗")
            logger.error("=" * 80)
            sys.exit(1)
    
    except Exception as e:
        logger.error(f"\n❌ エラー発生: {str(e)}", exc_info=True)
        sys.exit(1)

if __name__ == '__main__':
    main()
