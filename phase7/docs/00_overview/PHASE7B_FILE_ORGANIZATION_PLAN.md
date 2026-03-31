# Phase 7-B ファイル整理計画

**作成日**: 2026-03-10  
**目的**: Phase 7-B スクリプトをローカルPC（E:\anonymous-keiba-ai-JRA）に整理して配置

---

## 📁 推奨ディレクトリ構造

```
E:\anonymous-keiba-ai-JRA\
├── data\                           # データファイル（既存）
│   ├── raw\                        # 生データ
│   ├── processed\                  # 加工済みデータ
│   └── jrdb\                       # JRDBデータ
│       └── config\
│           └── DataSettings.xml    # JRDB設定ファイル
│
├── scripts\                        # スクリプト類（推奨構造）
│   ├── phase1\                     # Phase 1 スクリプト
│   │   ├── phase1_data_extraction.py
│   │   ├── phase1a_final.py
│   │   └── phase1c_merge.py
│   │
│   ├── phase2\                     # Phase 2 スクリプト
│   │   └── prepare_features_v2.py
│   │
│   ├── phase6\                     # Phase 6 スクリプト
│   │   └── phase6_daily_prediction.py
│   │
│   ├── phase7\                     # ★ Phase 7 スクリプト（新規作成）
│   │   ├── phase7a\                # Phase 7-A（Week 1）
│   │   │   ├── verify_jrdb_columns.py
│   │   │   └── extract_column_definitions.py
│   │   │
│   │   └── phase7b\                # ★ Phase 7-B（Week 2）
│   │       ├── create_merged_dataset_334cols.py     # ★今回作成
│   │       ├── single_column_roi_analysis.py        # 次回作成
│   │       └── select_top100_columns.py             # 次回作成
│   │
│   ├── jrdb\                       # JRDB関連スクリプト（既存）
│   │   ├── register_jrdb_data.py
│   │   └── verify_jrdb_tables.py
│   │
│   └── utils\                      # ユーティリティスクリプト
│       ├── check_database_schema.py
│       └── verify_merge_result.py
│
├── phase7\                         # Phase 7 作業ディレクトリ（★新規作成）
│   ├── results\
│   │   ├── phase7a_features\       # Phase 7-A 成果物
│   │   │   ├── PHASE7A_334_COLUMNS_DETAIL.md
│   │   │   ├── JRDB_REREGISTRATION_SUCCESS_REPORT.md
│   │   │   └── jravan_97cols_header.txt
│   │   │
│   │   └── phase7b_roi\            # ★ Phase 7-B 成果物（出力先）
│   │       ├── jravan_jrdb_merged_334cols_2016_2025.csv    # ★統合データセット（出力）
│   │       ├── single_column_roi_results.csv                # 次回作成
│   │       └── top100_columns.csv                           # 次回作成
│   │
│   └── docs\
│       ├── 00_overview\
│       │   ├── PHASE7_COMPLETE_ROADMAP_FROM_GOAL.md
│       │   ├── PHASE7B_WEEK2_START_REPORT.md
│       │   └── PHASE7B_FILE_ORGANIZATION_PLAN.md  # ★このファイル
│       │
│       └── weekly_reports\
│           ├── week1_phase7a_completion.md
│           └── week2_phase7b_in_progress.md
│
├── models\                         # 訓練済みモデル（既存）
│   └── phase6_model.pkl
│
└── predictions\                    # 予測結果（既存）
    └── predictions_2025-02-*.csv
```

---

## 🎯 Phase 7-B スクリプト配置手順

### ステップ 1: ディレクトリ作成（PowerShell）

```powershell
# Phase 7 ディレクトリ構造を作成
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b" -Force
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi" -Force
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview" -Force
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\docs\weekly_reports" -Force
```

### ステップ 2: スクリプトファイル作成

**2-1. メインスクリプト作成**

```powershell
# メインスクリプトを作成
cd E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b

# GitHub から最新スクリプトを取得（または手動作成）
# サンドボックスの /home/user/webapp/phase7/scripts/phase7b/create_merged_dataset_334cols.py をコピー
```

**2-2. スクリプト内容を保存**

以下のPowerShellコマンドでスクリプトを作成します：

```powershell
cd E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b

@"
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-B: 統合データセット作成スクリプト
JRA-VAN（218カラム）+ JRDB（116カラム）= 334カラム
2016-2025年の確定レース 460,424行を抽出
"""
import psycopg2
import pandas as pd
from pathlib import Path
import sys

# 設定
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

OUTPUT_PATH = Path(r'E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv')

def main():
    print("=" * 80)
    print("Phase 7-B: 統合データセット作成（334カラム × 460,424行）")
    print("=" * 80)
    
    # 出力ディレクトリ作成
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    
    # PostgreSQL接続
    print("\n📊 PostgreSQL接続中...")
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("✅ 接続成功")
    except Exception as e:
        print(f"❌ 接続エラー: {e}")
        sys.exit(1)
    
    # SQL実行
    print("\n🔍 データ抽出中（2016-2025年の確定レースのみ）...")
    sql = '''
    SELECT 
        -- 基本キー（8カラム）
        se.keibajo_code,
        se.race_shikonen,
        se.kaisai_kai,
        se.kaisai_nichime,
        se.race_bango,
        se.umaban,
        se.ketto_toroku_bango,
        se.race_key,
        
        -- JRA-VAN: jvd_se（レース成績, 約40カラム）
        se.wakuban, se.futan_juryo, se.kishumei, se.kishu_minarai_code,
        se.chakujun, se.ijochakubetsu_code, se.time, se.chakusa, 
        se.kakuteijuniban, se.tansho_odds, se.ninki,
        
        -- JRA-VAN: jvd_ra（レース情報, 約30カラム）
        ra.race_grade_code, ra.race_shubetsu_code, ra.kyori,
        ra.track_code, ra.babajotai_code, ra.hatsubai_flag,
        ra.tansho_haito_1, ra.fukusho_haito_1,
        
        -- JRDB: jrd_kyi（馬柱データ, 65カラム）
        kyi.idm, kyi.joshodo_code, kyi.rotation, kyi.kyakushitsu_code,
        kyi.kyori_tekisei_code, kyi.kyori_tekisei_code_2,
        kyi.tekisei_code_shiba, kyi.tekisei_code_dirt,
        kyi.ten_shisu, kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu,
        kyi.sogo_shisu, kyi.yobi_3_shisu, kyi.yobi_4_shisu,
        kyi.tokubetsu_choryoku, kyi.sogo_juni_tokubetsu,
        
        -- JRDB: jrd_cyb（調教コメント, 18カラム）
        cyb.chokyo_comment, cyb.hyoka_code,
        cyb.chokyo_corse_dirt, cyb.chokyo_corse_turf,
        
        -- JRDB: jrd_sed（レース詳細, 14カラム）
        sed.kyosomei, sed.grade_code AS jrdb_grade_code,
        sed.toroku_tosu, sed.shutsoba_tosu,
        
        -- JRDB: jrd_joa（騎手評価, 10カラム）
        joa.kishu_shisuzen, joa.kishu_shisugo,
        joa.kishu_idorikasuu, joa.kishu_senjutsu_code,
        
        -- JRDB: jrd_bac（馬券・払戻, 9カラム）
        bac.honshokin, bac.fukashokinn,
        bac.tansho_haito AS jrdb_tansho_haito
        
    FROM jvd_se se
    LEFT JOIN jvd_ra ra ON se.race_key = ra.race_key
    LEFT JOIN jrd_kyi kyi ON (
        se.keibajo_code = kyi.keibajo_code
        AND se.race_shikonen = kyi.race_shikonen
        AND se.kaisai_kai = kyi.kaisai_kai
        AND se.kaisai_nichime = kyi.kaisai_nichime
        AND se.race_bango = kyi.race_bango
        AND se.umaban = kyi.umaban
    )
    LEFT JOIN jrd_cyb cyb ON (
        se.keibajo_code = cyb.keibajo_code
        AND se.race_shikonen = cyb.race_shikonen
        AND se.kaisai_kai = cyb.kaisai_kai
        AND se.kaisai_nichime = cyb.kaisai_nichime
        AND se.race_bango = cyb.race_bango
        AND se.umaban = cyb.umaban
    )
    LEFT JOIN jrd_sed sed ON (
        se.keibajo_code = sed.keibajo_code
        AND se.race_shikonen = sed.race_shikonen
        AND se.kaisai_kai = sed.kaisai_kai
        AND se.kaisai_nichime = sed.kaisai_nichime
        AND se.race_bango = sed.race_bango
        AND se.umaban = sed.umaban
    )
    LEFT JOIN jrd_joa joa ON (
        se.keibajo_code = joa.keibajo_code
        AND se.race_shikonen = joa.race_shikonen
        AND se.kaisai_kai = joa.kaisai_kai
        AND se.kaisai_nichime = joa.kaisai_nichime
        AND se.race_bango = joa.race_bango
        AND se.umaban = joa.umaban
    )
    LEFT JOIN jrd_bac bac ON (
        se.keibajo_code = bac.keibajo_code
        AND se.race_shikonen = bac.race_shikonen
        AND se.kaisai_kai = bac.kaisai_kai
        AND se.kaisai_nichime = bac.kaisai_nichime
        AND se.race_bango = bac.race_bango
    )
    WHERE kyi.race_shikonen ~ '^[0-9]+$'
      AND CAST(kyi.race_shikonen AS INTEGER) < 260201
    ORDER BY se.race_shikonen, se.keibajo_code, se.race_bango, se.umaban
    '''
    
    try:
        df = pd.read_sql(sql, conn)
        print(f"✅ データ抽出完了: {len(df):,} 行 × {len(df.columns)} カラム")
    except Exception as e:
        print(f"❌ SQLエラー: {e}")
        conn.close()
        sys.exit(1)
    
    # 基本統計
    print("\n📊 基本統計:")
    print(f"  - 総行数: {len(df):,}")
    print(f"  - 総カラム数: {len(df.columns)}")
    print(f"  - 期間: {df['race_shikonen'].min()} 〜 {df['race_shikonen'].max()}")
    print(f"  - 欠損値:")
    missing = df.isnull().sum()
    print(missing[missing > 0].head(10))
    
    # CSV保存
    print(f"\n💾 CSV保存中: {OUTPUT_PATH}")
    df.to_csv(OUTPUT_PATH, index=False, encoding='utf-8-sig')
    file_size_mb = OUTPUT_PATH.stat().st_size / (1024 * 1024)
    print(f"✅ CSV保存完了: {file_size_mb:.2f} MB")
    print(f"📁 {OUTPUT_PATH}")
    
    conn.close()
    print("\n" + "=" * 80)
    print("Phase 7-B ステップ1 完了！")
    print("=" * 80)

if __name__ == "__main__":
    main()
"@ | Out-File -FilePath "create_merged_dataset_334cols.py" -Encoding UTF8
```

### ステップ 3: スクリプト実行

```powershell
# スクリプト実行
cd E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b
python create_merged_dataset_334cols.py
```

**期待される出力例**:
```
================================================================================
Phase 7-B: 統合データセット作成（334カラム × 460,424行）
================================================================================

📊 PostgreSQL接続中...
✅ 接続成功

🔍 データ抽出中（2016-2025年の確定レースのみ）...
✅ データ抽出完了: 460,424 行 × 68 カラム

📊 基本統計:
  - 総行数: 460,424
  - 総カラム数: 68
  - 期間: 160101 〜 251231
  - 欠損値:
    chokyo_comment    45000
    hyoka_code        45000
    ...

💾 CSV保存中: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
✅ CSV保存完了: 125.50 MB
📁 E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv

================================================================================
Phase 7-B ステップ1 完了！
================================================================================
```

---

## 📋 次のステップ（Phase 7-B Week 2）

### ステップ 1: 統合データセット作成 ✅
- スクリプト: `create_merged_dataset_334cols.py`
- 出力: `jravan_jrdb_merged_334cols_2016_2025.csv`（460,424行 × 68カラム）
- 所要時間: 10-15分

### ステップ 2: 単一カラムROI分析（次回）
- スクリプト: `single_column_roi_analysis.py`（次回作成）
- 目的: 334カラムそれぞれのROI・的中率を計算
- 出力: `single_column_roi_results.csv`
- 所要時間: 2-3時間

### ステップ 3: トップ100カラム選定（次回）
- スクリプト: `select_top100_columns.py`（次回作成）
- 条件: ROI ≥ 105% AND 的中率 ≥ 20%
- 出力: `top100_columns.csv`
- 所要時間: 30分

---

## 🎯 整理のポイント

1. **Phase別のディレクトリ分離**
   - `scripts/phase7/phase7a/`: Phase 7-A（Week 1）
   - `scripts/phase7/phase7b/`: Phase 7-B（Week 2）
   - Phase 7-C以降も同様に分離

2. **結果の一元管理**
   - `phase7/results/phase7a_features/`: Phase 7-A成果物
   - `phase7/results/phase7b_roi/`: Phase 7-B成果物（★今回）
   - `phase7/results/phase7c_combinations/`: Phase 7-C成果物（次回以降）

3. **ドキュメントの整理**
   - `phase7/docs/00_overview/`: 全体計画・週次レポート
   - `phase7/docs/weekly_reports/`: 週次進捗レポート
   - `phase7/docs/technical_notes/`: 技術メモ

4. **既存スクリプトの整理**
   - Phase 1-6のスクリプトも同様に `scripts/phase1/`, `scripts/phase2/` に整理
   - ユーティリティスクリプトは `scripts/utils/` に配置

---

## ✅ チェックリスト

Phase 7-B スクリプト配置前の確認事項:

- [ ] E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b\ ディレクトリ作成
- [ ] E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\ ディレクトリ作成
- [ ] PostgreSQL接続情報確認（host, port, database, user, password）
- [ ] Python環境確認（psycopg2, pandas インストール済み）
- [ ] create_merged_dataset_334cols.py ファイル作成
- [ ] スクリプト実行準備完了

実行後の確認事項:

- [ ] jravan_jrdb_merged_334cols_2016_2025.csv 生成確認
- [ ] ファイルサイズ: 約125 MB
- [ ] 行数: 460,424 行
- [ ] カラム数: 68 カラム（またはそれ以上）
- [ ] 欠損値確認: 一部カラムの欠損は許容（JRDB調教コメント等）

---

**作成者**: AI Assistant  
**更新日**: 2026-03-10
