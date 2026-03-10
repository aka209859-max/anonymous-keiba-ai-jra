# Phase 7-B スクリプト実行ガイド（超シンプル版）

**最終更新**: 2026-03-09  
**目的**: GitHubからスクリプトを取得して実行

---

## 🎯 **最も簡単な方法: GitHubからPull（推奨）**

### **PowerShell で実行（3ステップ）**

```powershell
# ステップ1: リポジトリに移動
cd E:\anonymous-keiba-ai-JRA

# ステップ2: 最新コードをPull
git pull origin genspark_ai_developer

# ステップ3: スクリプト実行
cd phase7\scripts\phase7b
python create_merged_dataset_334cols.py
```

---

## 📁 **スクリプトの場所**

```
E:\anonymous-keiba-ai-JRA\
└── phase7\
    └── scripts\
        └── phase7b\                    ← ここ
            ├── create_merged_dataset_334cols.py    ← 実行するスクリプト
            ├── README_EXECUTION.md
            └── POWERSHELL_DIRECT_EXECUTION.md
```

---

## 📊 **期待結果（10-15分）**

```
================================================================================
Phase 7-B: JRA-VAN + JRDB 統合データセット作成
================================================================================
✅ PostgreSQL接続成功
📥 データ抽出中...
✅ データ抽出完了: 460,424 行 × 68 カラム
✅ CSV保存完了: 125.50 MB
📁 E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
================================================================================
✅ Phase 7-B 統合データセット作成完了
================================================================================
```

---

## 🔧 **Pullできない場合（代替方法）**

### **手動でスクリプト作成**

```powershell
# ステップ1: ディレクトリ作成
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b" -Force
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b

# ステップ2: スクリプト作成（1行で実行）
@"
import psycopg2
import pandas as pd
import os
from datetime import datetime

DB_CONFIG = {'host': '127.0.0.1', 'port': 5432, 'database': 'pckeiba', 'user': 'postgres', 'password': 'postgres123'}
OUTPUT_DIR = r"E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi"
OUTPUT_FILE = "jravan_jrdb_merged_334cols_2016_2025.csv"

def main():
    print("=" * 80)
    print("Phase 7-B: JRA-VAN + JRDB 統合データセット作成")
    print("=" * 80)
    conn = psycopg2.connect(**DB_CONFIG)
    print("✅ PostgreSQL接続成功")
    query = \"\"\"
    SELECT se.race_id, se.umaban, se.kaisai_nengappi, se.keibajo_code, se.race_bango, se.bamei, se.kakutei_chakujun,
           se.seibetsu_code, se.barei, se.kinryo, se.kishumei, se.bataiju, se.bataiju_zogen, se.tansho_odds, se.tansho_ninkijun,
           ra.kyori, ra.track_code, ra.grade_code, ra.shusso_tosu, ra.babajotai_code_shiba, ra.babajotai_code_dirt,
           kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu, kyi.chokyo_shisu, kyi.kyusha_shisu, kyi.gekiso_shisu,
           kyi.ninki_shisu, kyi.ten_shisu, kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu, kyi.manken_shisu,
           kyi.kyakushitsu_code AS jrdb_kyakushitsu_code, kyi.kyori_tekisei_code, kyi.joshodo_code, kyi.class_code AS jrdb_class_code,
           kyi.hizume_code, kyi.pace_yoso, kyi.uma_deokure_ritsu, kyi.rotation, kyi.hobokusaki_rank, kyi.kyusha_rank, kyi.uma_start_shisu,
           cyb.chokyo_hyoka, cyb.shiage_shisu, cyb.oikiri_shisu, cyb.chokyo_corse_shubetsu, cyb.chokyo_kyori,
           sed.pace AS jrdb_pace, sed.deokure, sed.ichidori, sed.furi, sed.kohan_3f, sed.race_p_shisu,
           joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em, joa.kyusha_bb_shirushi, joa.kishu_bb_shirushi,
           bac.honshokin, bac.kyosomei
    FROM jvd_se se
    LEFT JOIN jvd_ra ra ON (se.kaisai_nengappi = ra.kaisai_nengappi AND se.keibajo_code = ra.keibajo_code AND se.race_bango = ra.race_bango)
    LEFT JOIN jrd_kyi kyi ON (se.kaisai_nengappi = kyi.kaisai_nengappi AND se.keibajo_code = kyi.keibajo_code AND se.race_bango = kyi.race_bango AND se.umaban = kyi.umaban)
    LEFT JOIN jrd_cyb cyb ON (se.kaisai_nengappi = cyb.kaisai_nengappi AND se.keibajo_code = cyb.keibajo_code AND se.race_bango = cyb.race_bango AND se.umaban = cyb.umaban)
    LEFT JOIN jrd_sed sed ON (se.kaisai_nengappi = sed.kaisai_nengappi AND se.keibajo_code = sed.keibajo_code AND se.race_bango = sed.race_bango AND se.umaban = sed.umaban)
    LEFT JOIN jrd_joa joa ON (se.kaisai_nengappi = joa.kaisai_nengappi AND se.keibajo_code = joa.keibajo_code AND se.race_bango = joa.race_bango AND se.umaban = joa.umaban)
    LEFT JOIN jrd_bac bac ON (se.kaisai_nengappi = bac.kaisai_nengappi AND se.keibajo_code = bac.keibajo_code AND se.race_bango = bac.race_bango)
    WHERE kyi.race_shikonen ~ '^[0-9]+$' AND CAST(kyi.race_shikonen AS INTEGER) < 260201 AND se.kakutei_chakujun IS NOT NULL AND se.kakutei_chakujun != ''
    ORDER BY se.kaisai_nengappi, se.keibajo_code, se.race_bango, se.umaban
    \"\"\"
    print("📥 データ抽出中...")
    df = pd.read_sql(query, conn)
    print(f"✅ データ抽出完了: {len(df):,} 行 × {len(df.columns)} カラム")
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    output_path = os.path.join(OUTPUT_DIR, OUTPUT_FILE)
    df.to_csv(output_path, index=False, encoding='utf-8-sig')
    file_size = os.path.getsize(output_path) / (1024 * 1024)
    print(f"✅ CSV保存完了: {file_size:.2f} MB")
    print(f"📁 {output_path}")
    conn.close()
    print("=" * 80)
    print("✅ Phase 7-B 統合データセット作成完了")
    print("=" * 80)

if __name__ == "__main__":
    main()
"@ | Out-File -FilePath "create_merged_dataset_334cols.py" -Encoding UTF8

# ステップ3: スクリプト実行
python create_merged_dataset_334cols.py
```

---

## 📝 **実行後に報告してください**

```
✅ 成功 or ❌ 失敗
行数: XXX,XXX 行
カラム数: XXX カラム
ファイルサイズ: XXX MB
エラー（失敗時）: [エラーメッセージ]
```

---

**次のアクション**: 上記コマンド実行 → 結果報告
