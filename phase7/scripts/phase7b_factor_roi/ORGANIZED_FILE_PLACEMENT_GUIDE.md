# Phase 7-B スクリプト配置ガイド（既存構造に合わせた整理版）

**作成日**: 2026-03-09  
**目的**: 既存のフォルダ構造に合わせてPhase 7-Bスクリプトを配置

---

## 📁 **あなたのPCの現在の構造（確認済み）**

```
E:\anonymous-keiba-ai-JRA\
├── data/                      # データ保存
├── models/                    # モデル保存
├── scripts/                   # Phase 1-6 スクリプト
│   ├── phase1/
│   ├── phase2/
│   ├── phase3/
│   ├── phase4/
│   ├── phase5/
│   ├── phase6/
│   └── utils/
├── results/                   # Phase 1-6 結果
├── phase7/                    # ✅ Phase 7 専用（既に整理済み）
│   ├── docs/
│   │   ├── 00_overview/
│   │   ├── 01_workflow/
│   │   └── 02_roadmap/
│   ├── scripts/               # ✅ Phase 7 スクリプト
│   │   ├── phase7a_feature_expansion/
│   │   ├── phase7b_factor_roi/      # ← ここに配置すべき！
│   │   ├── phase7c_2factor_combination/
│   │   ├── phase7d_3factor_ga/
│   │   ├── phase7e_4to5factor/
│   │   └── utils/
│   ├── results/               # ✅ Phase 7 結果
│   │   ├── phase7a_features/
│   │   ├── phase7b_factor_roi/      # ← 結果の保存先！
│   │   ├── phase7c_2factor/
│   │   └── ...
│   ├── models/
│   ├── data/
│   ├── config/
│   └── logs/
└── ...
```

---

## ✅ **推奨配置場所（既存構造に合わせる）**

### **スクリプトの保存先**

```
E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi\
```

**理由**:
- ✅ 既に `phase7b_factor_roi` フォルダが存在
- ✅ Phase 7-B専用フォルダとして整理済み
- ✅ 他のフェーズ（7a, 7c, 7d...）と統一感がある

---

### **結果の保存先**

```
E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_factor_roi\
```

**理由**:
- ✅ 既に `phase7b_factor_roi` フォルダが存在
- ✅ Phase 7-B の結果を一元管理
- ✅ 他のフェーズ結果と同じ構造

---

## 📝 **Phase 7-B スクリプト配置手順（PowerShell）**

### **ステップ1: スクリプトファイル作成**

```powershell
# 1. phase7b_factor_roi フォルダに移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi

# 2. Pythonスクリプト作成
@"
"""
Phase 7-B: JRA-VAN + JRDB 統合データセット作成

保存先: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_factor_roi\
出力ファイル: jravan_jrdb_merged_334cols_2016_2025.csv
期待行数: 460,424行
期待カラム数: 68カラム（簡易版）
"""

import psycopg2
import pandas as pd
import os
from datetime import datetime

# 設定
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

# 出力先（Phase 7-B results フォルダ）
OUTPUT_DIR = r"E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_factor_roi"
OUTPUT_FILE = "jravan_jrdb_merged_334cols_2016_2025.csv"

def create_connection():
    """PostgreSQL接続"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print(f"✅ PostgreSQL接続成功: {DB_CONFIG['database']}")
        return conn
    except Exception as e:
        print(f"❌ PostgreSQL接続失敗: {e}")
        return None

def create_merged_dataset(conn):
    """統合データセット作成"""
    print("\n📊 統合データセット作成開始...")
    
    query = """
    SELECT 
        se.race_id, se.umaban, se.kaisai_nengappi, se.keibajo_code, se.race_bango,
        se.bamei, se.kakutei_chakujun, se.seibetsu_code, se.barei, se.kinryo,
        se.kishumei, se.bataiju, se.bataiju_zogen, se.tansho_odds, se.tansho_ninkijun,
        ra.kyori, ra.track_code, ra.grade_code, ra.shusso_tosu,
        ra.babajotai_code_shiba, ra.babajotai_code_dirt,
        kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu, kyi.chokyo_shisu,
        kyi.kyusha_shisu, kyi.gekiso_shisu, kyi.ninki_shisu, kyi.ten_shisu,
        kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu, kyi.manken_shisu,
        kyi.kyakushitsu_code AS jrdb_kyakushitsu_code, kyi.kyori_tekisei_code,
        kyi.joshodo_code, kyi.class_code AS jrdb_class_code, kyi.hizume_code,
        kyi.pace_yoso, kyi.uma_deokure_ritsu, kyi.rotation, kyi.hobokusaki_rank,
        kyi.kyusha_rank, kyi.uma_start_shisu,
        cyb.chokyo_hyoka, cyb.shiage_shisu, cyb.oikiri_shisu,
        cyb.chokyo_corse_shubetsu, cyb.chokyo_kyori,
        sed.pace AS jrdb_pace, sed.deokure, sed.ichidori, sed.furi,
        sed.kohan_3f, sed.race_p_shisu,
        joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em,
        joa.kyusha_bb_shirushi, joa.kishu_bb_shirushi,
        bac.honshokin, bac.kyosomei
    FROM jvd_se se
    LEFT JOIN jvd_ra ra ON (se.kaisai_nengappi = ra.kaisai_nengappi 
        AND se.keibajo_code = ra.keibajo_code AND se.race_bango = ra.race_bango)
    LEFT JOIN jrd_kyi kyi ON (se.kaisai_nengappi = kyi.kaisai_nengappi 
        AND se.keibajo_code = kyi.keibajo_code AND se.race_bango = kyi.race_bango 
        AND se.umaban = kyi.umaban)
    LEFT JOIN jrd_cyb cyb ON (se.kaisai_nengappi = cyb.kaisai_nengappi 
        AND se.keibajo_code = cyb.keibajo_code AND se.race_bango = cyb.race_bango 
        AND se.umaban = cyb.umaban)
    LEFT JOIN jrd_sed sed ON (se.kaisai_nengappi = sed.kaisai_nengappi 
        AND se.keibajo_code = sed.keibajo_code AND se.race_bango = sed.race_bango 
        AND se.umaban = sed.umaban)
    LEFT JOIN jrd_joa joa ON (se.kaisai_nengappi = joa.kaisai_nengappi 
        AND se.keibajo_code = joa.keibajo_code AND se.race_bango = joa.race_bango 
        AND se.umaban = joa.umaban)
    LEFT JOIN jrd_bac bac ON (se.kaisai_nengappi = bac.kaisai_nengappi 
        AND se.keibajo_code = bac.keibajo_code AND se.race_bango = bac.race_bango)
    WHERE kyi.race_shikonen ~ '^[0-9]+$'
        AND CAST(kyi.race_shikonen AS INTEGER) < 260201
        AND se.kakutei_chakujun IS NOT NULL
        AND se.kakutei_chakujun != ''
    ORDER BY se.kaisai_nengappi, se.keibajo_code, se.race_bango, se.umaban
    """
    
    try:
        print("📥 データ抽出中...")
        df = pd.read_sql(query, conn)
        print(f"✅ データ抽出完了: {len(df):,} 行 × {len(df.columns)} カラム")
        
        # 基本統計
        print(f"\n📊 基本統計:")
        print(f"  - 期間: {df['kaisai_nengappi'].min()} ～ {df['kaisai_nengappi'].max()}")
        print(f"  - レース数: {df['race_id'].nunique():,} レース")
        print(f"  - 競馬場数: {df['keibajo_code'].nunique()} 場")
        
        # 欠損値チェック
        null_counts = df.isnull().sum()
        null_cols = null_counts[null_counts > 0]
        if len(null_cols) > 0:
            print(f"\n⚠️  欠損値あり（上位10カラム）:")
            for col, count in null_cols.head(10).items():
                pct = (count / len(df)) * 100
                print(f"  - {col}: {count:,} 行 ({pct:.2f}%)")
        else:
            print(f"\n✅ 欠損値なし")
        
        return df
    except Exception as e:
        print(f"❌ データ抽出失敗: {e}")
        import traceback
        traceback.print_exc()
        return None

def save_dataset(df, output_path):
    """CSV保存"""
    try:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        print(f"\n💾 CSV保存中: {output_path}")
        df.to_csv(output_path, index=False, encoding='utf-8-sig')
        file_size = os.path.getsize(output_path) / (1024 * 1024)
        print(f"✅ CSV保存完了: {file_size:.2f} MB")
        return True
    except Exception as e:
        print(f"❌ CSV保存失敗: {e}")
        return False

def main():
    print("=" * 80)
    print("Phase 7-B: JRA-VAN + JRDB 統合データセット作成")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    conn = create_connection()
    if conn is None:
        return
    
    try:
        df = create_merged_dataset(conn)
        if df is None:
            return
        
        output_path = os.path.join(OUTPUT_DIR, OUTPUT_FILE)
        if save_dataset(df, output_path):
            print("\n" + "=" * 80)
            print("✅ Phase 7-B 統合データセット作成完了")
            print("=" * 80)
            print(f"📁 出力ファイル: {output_path}")
            print(f"📊 行数: {len(df):,} 行")
            print(f"📊 カラム数: {len(df.columns)} カラム")
            print("\n🔜 次のステップ: 単一カラムROI分析")
    finally:
        conn.close()
        print("\n✅ PostgreSQL接続クローズ")

if __name__ == "__main__":
    main()
"@ | Out-File -FilePath "create_merged_dataset.py" -Encoding UTF8

Write-Host "✅ スクリプト作成完了: E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi\create_merged_dataset.py"
```

---

### **ステップ2: スクリプト実行**

```powershell
# phase7b_factor_roi フォルダで実行
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi
python create_merged_dataset.py
```

---

## 📊 **実行後のファイル配置（期待結果）**

```
E:\anonymous-keiba-ai-JRA\phase7\
├── scripts\
│   └── phase7b_factor_roi\
│       └── create_merged_dataset.py          ← 今回作成
│
└── results\
    └── phase7b_factor_roi\
        └── jravan_jrdb_merged_334cols_2016_2025.csv  ← 実行後に作成される
```

---

## ✅ **整理されたフォルダ構造の利点**

1. **Phase 7専用フォルダで管理**
   - Phase 1-6 と Phase 7 が分離
   - 各フェーズ（7a, 7b, 7c...）ごとに整理

2. **scriptsとresultsが対応**
   - `scripts/phase7b_factor_roi/` → スクリプト保存
   - `results/phase7b_factor_roi/` → 結果保存
   - 対応関係が明確

3. **拡張性が高い**
   - Phase 7-C, 7-D... も同じ構造で追加可能
   - 一貫性のあるプロジェクト構造

---

## 🔜 **次のステップ**

1. **上記のPowerShellコマンドを実行**
2. **スクリプト実行結果を報告**
3. **次のスクリプト（単一カラムROI分析）を作成**

---

**推奨ファイル名**: `create_merged_dataset.py`  
**保存先**: `E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi\`  
**結果保存先**: `E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_factor_roi\`
