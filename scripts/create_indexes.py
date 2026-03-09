#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
インデックス作成スクリプト
"""
import yaml
from sqlalchemy import create_engine, text

def main():
    # 設定読み込み
    with open('config/db_config.yaml', 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    jravan_cfg = config['databases']['jravan']
    
    # エンジン作成
    engine = create_engine(
        f"postgresql://{jravan_cfg['user']}:{jravan_cfg['password']}@"
        f"{jravan_cfg['host']}:{jravan_cfg['port']}/{jravan_cfg['database']}"
    )
    
    print("インデックス作成開始...")
    
    with engine.connect() as conn:
        # インデックス1: jvd_se (馬登録番号 + 開催日)
        print("  idx_se_ketto_date 作成中...")
        conn.execute(text('''
            CREATE INDEX IF NOT EXISTS idx_se_ketto_date 
            ON jvd_se (ketto_toroku_bango, kaisai_nen, kaisai_tsukihi)
        '''))
        conn.commit()
        print("  ✅ idx_se_ketto_date 完了")
        
        # インデックス2: jvd_ra (開催日 + 競馬場 + レース番号)
        print("  idx_ra_date 作成中...")
        conn.execute(text('''
            CREATE INDEX IF NOT EXISTS idx_ra_date 
            ON jvd_ra (kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango)
        '''))
        conn.commit()
        print("  ✅ idx_ra_date 完了")
    
    print("✅ 全インデックス作成完了")

if __name__ == "__main__":
    main()
