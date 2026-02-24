#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 0: 環境構築・データベース接続確認

【目的】
- PostgreSQL（JRA-VAN + JRDB）への接続確認
- Python環境の動作確認
- 必須ライブラリのインストール確認

【実行方法】
python scripts/phase0_setup.py

【注意】
- このスクリプトはユーザーのローカルPC（E:\anonymous-keiba-ai-JRA）で実行します
- config/db_config.yaml の設定を事前に確認してください
"""

import sys
import os
from pathlib import Path

# プロジェクトルートをPythonパスに追加
project_root = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(project_root))

print("=" * 70)
print("Phase 0: 環境構築・データベース接続確認")
print("=" * 70)
print(f"プロジェクトルート: {project_root}")
print()

# ===== 必須ライブラリのインポート確認 =====
print("📦 必須ライブラリのインポート確認中...")

required_packages = {
    'yaml': 'pyyaml',
    'pandas': 'pandas',
    'numpy': 'numpy',
    'sklearn': 'scikit-learn',
    'lightgbm': 'lightgbm',
    'optuna': 'optuna',
    'boruta': 'boruta',
    'psycopg2': 'psycopg2-binary',
    'sqlalchemy': 'sqlalchemy',
    'matplotlib': 'matplotlib',
    'seaborn': 'seaborn',
    'tqdm': 'tqdm',
    'joblib': 'joblib'
}

missing_packages = []

for package, pip_name in required_packages.items():
    try:
        __import__(package)
        print(f"  ✅ {pip_name}")
    except ImportError:
        print(f"  ❌ {pip_name} が見つかりません")
        missing_packages.append(pip_name)

if missing_packages:
    print(f"\n⚠️  不足パッケージ: {', '.join(missing_packages)}")
    print(f"以下のコマンドでインストールしてください:")
    print(f"pip install {' '.join(missing_packages)}")
    sys.exit(1)

print("\n✅ 全ての必須ライブラリが正常にインポートできました\n")

# ===== 設定ファイル読み込み =====
import yaml

def load_db_config(config_path='config/db_config.yaml'):
    """データベース設定ファイル読み込み"""
    config_file = project_root / config_path
    
    if not config_file.exists():
        print(f"❌ 設定ファイルが見つかりません: {config_file}")
        print(f"config/db_config.yaml を作成してください")
        sys.exit(1)
    
    with open(config_file, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

print("📂 設定ファイル読み込み中...")
db_config = load_db_config()
print("✅ 設定ファイル読み込み完了\n")

# ===== データベース接続テスト =====
import psycopg2
from sqlalchemy import create_engine, text

def test_jravan_connection(config):
    """JRA-VAN DB接続テスト"""
    print("🔌 JRA-VAN DB接続テスト中...")
    
    try:
        # psycopg2での接続テスト
        conn = psycopg2.connect(
            host=config['jravan']['host'],
            port=config['jravan']['port'],
            database=config['jravan']['database'],
            user=config['jravan']['user'],
            password=config['jravan']['password'],
            connect_timeout=10
        )
        
        cursor = conn.cursor()
        
        # テーブル存在確認
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name LIKE 'jvd_%'
            ORDER BY table_name
            LIMIT 10;
        """)
        
        tables = cursor.fetchall()
        
        if tables:
            print(f"  ✅ JRA-VAN DB接続成功")
            print(f"  📊 検出されたテーブル（最初の10件）:")
            for table in tables:
                print(f"     - {table[0]}")
            
            # レコード数確認（jvd_ra: レース基本情報）
            cursor.execute("SELECT COUNT(*) FROM jvd_ra;")
            count = cursor.fetchone()[0]
            print(f"  📊 jvd_ra レコード数: {count:,}件")
        else:
            print(f"  ⚠️  JRA-VANテーブルが見つかりません（jvd_*）")
            print(f"     データベースが正しくセットアップされているか確認してください")
        
        conn.close()
        return True
        
    except psycopg2.OperationalError as e:
        print(f"  ❌ JRA-VAN DB接続失敗（接続エラー）")
        print(f"     エラー詳細: {e}")
        print(f"     設定を確認してください:")
        print(f"       - host: {config['jravan']['host']}")
        print(f"       - port: {config['jravan']['port']}")
        print(f"       - database: {config['jravan']['database']}")
        print(f"       - user: {config['jravan']['user']}")
        return False
    except Exception as e:
        print(f"  ❌ JRA-VAN DB接続失敗（予期しないエラー）")
        print(f"     エラー詳細: {e}")
        return False

def test_jrdb_connection(config):
    """JRDB DB接続テスト"""
    print("\n🔌 JRDB DB接続テスト中...")
    
    try:
        # psycopg2での接続テスト
        conn = psycopg2.connect(
            host=config['jrdb']['host'],
            port=config['jrdb']['port'],
            database=config['jrdb']['database'],
            user=config['jrdb']['user'],
            password=config['jrdb']['password'],
            connect_timeout=10
        )
        
        cursor = conn.cursor()
        
        # テーブル存在確認
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name LIKE 'jrd_%'
            ORDER BY table_name
            LIMIT 10;
        """)
        
        tables = cursor.fetchall()
        
        if tables:
            print(f"  ✅ JRDB DB接続成功")
            print(f"  📊 検出されたテーブル（最初の10件）:")
            for table in tables:
                print(f"     - {table[0]}")
            
            # レコード数確認（jrd_kyi: 予測データ）
            cursor.execute("SELECT COUNT(*) FROM jrd_kyi;")
            count = cursor.fetchone()[0]
            print(f"  📊 jrd_kyi レコード数: {count:,}件")
        else:
            print(f"  ⚠️  JRDBテーブルが見つかりません（jrd_*）")
            print(f"     データベースが正しくセットアップされているか確認してください")
        
        conn.close()
        return True
        
    except psycopg2.OperationalError as e:
        print(f"  ❌ JRDB DB接続失敗（接続エラー）")
        print(f"     エラー詳細: {e}")
        print(f"     設定を確認してください:")
        print(f"       - host: {config['jrdb']['host']}")
        print(f"       - port: {config['jrdb']['port']}")
        print(f"       - database: {config['jrdb']['database']}")
        print(f"       - user: {config['jrdb']['user']}")
        return False
    except Exception as e:
        print(f"  ❌ JRDB DB接続失敗（予期しないエラー）")
        print(f"     エラー詳細: {e}")
        return False

def test_sqlalchemy_connection(config):
    """SQLAlchemy接続テスト（Phase 1で使用）"""
    print("\n🔌 SQLAlchemy接続テスト中...")
    
    try:
        # JRA-VAN
        jravan_url = (
            f"postgresql://{config['jravan']['user']}:{config['jravan']['password']}@"
            f"{config['jravan']['host']}:{config['jravan']['port']}/{config['jravan']['database']}"
        )
        engine_jravan = create_engine(jravan_url, pool_pre_ping=True)
        
        with engine_jravan.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            result.fetchone()
        
        print(f"  ✅ SQLAlchemy (JRA-VAN) 接続成功")
        
        # JRDB
        jrdb_url = (
            f"postgresql://{config['jrdb']['user']}:{config['jrdb']['password']}@"
            f"{config['jrdb']['host']}:{config['jrdb']['port']}/{config['jrdb']['database']}"
        )
        engine_jrdb = create_engine(jrdb_url, pool_pre_ping=True)
        
        with engine_jrdb.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            result.fetchone()
        
        print(f"  ✅ SQLAlchemy (JRDB) 接続成功")
        
        return True
        
    except Exception as e:
        print(f"  ❌ SQLAlchemy接続失敗")
        print(f"     エラー詳細: {e}")
        return False

# ===== メイン実行 =====
def main():
    """メイン実行"""
    
    # JRA-VAN接続確認
    jravan_ok = test_jravan_connection(db_config)
    
    # JRDB接続確認
    jrdb_ok = test_jrdb_connection(db_config)
    
    # SQLAlchemy接続確認
    sqlalchemy_ok = test_sqlalchemy_connection(db_config)
    
    # 結果サマリー
    print("\n" + "=" * 70)
    print("Phase 0 実行結果")
    print("=" * 70)
    print(f"JRA-VAN DB接続: {'✅ 成功' if jravan_ok else '❌ 失敗'}")
    print(f"JRDB DB接続:    {'✅ 成功' if jrdb_ok else '❌ 失敗'}")
    print(f"SQLAlchemy接続: {'✅ 成功' if sqlalchemy_ok else '❌ 失敗'}")
    print("=" * 70)
    
    if jravan_ok and jrdb_ok and sqlalchemy_ok:
        print("\n✅ Phase 0 完了: 全てのDB接続が成功しました")
        print("\n次のステップ:")
        print("  1. config/feature_config.yaml を確認")
        print("  2. Phase 1（データ抽出）に進む準備完了")
        print("  3. AIに「Phase 0完了」と報告してください")
        return 0
    else:
        print("\n❌ Phase 0 失敗: DB接続エラーがあります")
        print("\n対処方法:")
        print("  1. config/db_config.yaml の設定を確認")
        print("  2. PostgreSQLサービスが起動しているか確認")
        print("  3. データベースとテーブルが正しく作成されているか確認")
        return 1

if __name__ == "__main__":
    sys.exit(main())
