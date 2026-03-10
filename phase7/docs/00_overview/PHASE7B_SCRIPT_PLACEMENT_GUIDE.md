# Phase 7-B スクリプト配置ガイド（整理版）

**作成日**: 2026-03-09  
**目的**: GitHubからスクリプトをPullして、ローカルPCで実行

---

## 📁 **現在のファイル構造（GitHub上）**

```
E:\anonymous-keiba-ai-JRA\
├── phase7/
│   ├── scripts/
│   │   ├── phase7b/                    ← Phase 7-B スクリプト置き場
│   │   │   ├── create_merged_dataset_334cols.py  ✅ 既に存在
│   │   │   ├── README_EXECUTION.md                ✅ 既に存在
│   │   │   └── POWERSHELL_DIRECT_EXECUTION.md     ✅ 既に存在
│   │   ├── phase7b_factor_roi/         ← ROI分析スクリプト置き場（今後使用）
│   │   ├── phase7c_2factor_combination/ ← Week 3 用
│   │   ├── phase7d_3factor_ga/         ← Week 4 用
│   │   └── ...
│   └── results/
│       ├── phase7b_roi/                ← Phase 7-B 出力先 ✅ 既に存在
│       ├── phase7b_factor_roi/         ← ROI分析結果置き場
│       └── ...
```

---

## 🎯 **推奨手順: GitHubからPull**

### **ステップ1: GitHubから最新コードをPull**

```powershell
# 1. リポジトリディレクトリに移動
cd E:\anonymous-keiba-ai-JRA

# 2. 現在のブランチ確認
git status

# 3. ブランチ切り替え（必要な場合）
git checkout genspark_ai_developer

# 4. 最新コードをPull
git pull origin genspark_ai_developer
```

**期待結果**:
```
Updating xxxxx..xxxxx
Fast-forward
 phase7/scripts/phase7b/create_merged_dataset_334cols.py    | 251 +++++++++++
 phase7/scripts/phase7b/README_EXECUTION.md                  | 115 +++++
 phase7/scripts/phase7b/POWERSHELL_DIRECT_EXECUTION.md       | 423 +++++++++++++++++
 3 files changed, 789 insertions(+)
```

---

### **ステップ2: スクリプト存在確認**

```powershell
# スクリプトファイル確認
Test-Path "E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b\create_merged_dataset_334cols.py"
```

**期待結果**: `True`

---

### **ステップ3: スクリプト実行**

```powershell
# 1. ディレクトリ移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b

# 2. スクリプト確認
ls

# 3. スクリプト実行
python create_merged_dataset_334cols.py
```

---

## 🔄 **代替方法: スクリプトを手動作成（Pullできない場合）**

### **ステップ1: ディレクトリ作成**

```powershell
# Phase 7-B ディレクトリ作成
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b" -Force
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi" -Force
```

---

### **ステップ2: スクリプト作成**

```powershell
# カレントディレクトリ移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b

# Pythonスクリプト作成（圧縮版）
@"
"""Phase 7-B: JRA-VAN + JRDB 統合データセット作成"""
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
    
    query = """
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
    WHERE kyi.race_shikonen ~ '^[0-9]+$' AND CAST(kyi.race_shikonen AS INTEGER) < 260201 
      AND se.kakutei_chakujun IS NOT NULL AND se.kakutei_chakujun != ''
    ORDER BY se.kaisai_nengappi, se.keibajo_code, se.race_bango, se.umaban
    """
    
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
```

---

### **ステップ3: スクリプト実行**

```powershell
python create_merged_dataset_334cols.py
```

---

## 📂 **Phase 7 全体のディレクトリ構造（整理版）**

```
E:\anonymous-keiba-ai-JRA\phase7\
│
├── scripts/                              ← Pythonスクリプト置き場
│   ├── phase7b/                          ← Week 2: 統合データセット作成
│   │   ├── create_merged_dataset_334cols.py
│   │   ├── README_EXECUTION.md
│   │   └── POWERSHELL_DIRECT_EXECUTION.md
│   ├── phase7b_factor_roi/               ← Week 2: 単一カラムROI分析
│   ├── phase7c_2factor_combination/      ← Week 3: 2カラム組み合わせ
│   ├── phase7d_3factor_ga/               ← Week 4: 3カラムGA探索
│   ├── phase7e_4to5factor/               ← Week 5-6: 4-5カラムビームサーチ
│   ├── phase7f_combo_features/           ← Week 7-8: LightGBMモデル
│   ├── phase7g_roi_model/                ← Week 9: Benterモデル統合
│   ├── phase7h_backtest/                 ← Week 10: バックテスト
│   ├── phase7i_daily_prediction/         ← Week 11-15: 最適化・運用
│   └── utils/                            ← 共通ユーティリティ
│
├── results/                              ← 出力結果置き場
│   ├── phase7b_roi/                      ← Week 2: 統合データセット（CSV）
│   ├── phase7b_factor_roi/               ← Week 2: ROI分析結果
│   ├── phase7c_2factor/                  ← Week 3: 2カラム組み合わせ結果
│   ├── phase7d_3factor_ga/               ← Week 4: 3カラムGA結果
│   ├── phase7e_4to5factor/               ← Week 5-6: 4-5カラム結果
│   ├── phase7f_features/                 ← Week 7-8: LightGBM結果
│   ├── phase7g_models/                   ← Week 9: Benterモデル
│   ├── phase7h_backtest/                 ← Week 10: バックテスト結果
│   └── phase7i_predictions/              ← Week 11-15: 毎日の予測結果
│
├── docs/                                 ← ドキュメント置き場
│   ├── 00_overview/                      ← 全体計画・進捗レポート
│   ├── 01_workflow/                      ← ワークフロー
│   └── 02_roadmap/                       ← ロードマップ
│
├── models/                               ← 学習済みモデル置き場
├── notebooks/                            ← Jupyterノートブック置き場
├── config/                               ← 設定ファイル置き場
└── logs/                                 ← ログファイル置き場
```

---

## ✅ **推奨方法: GitHubからPull（最もクリーン）**

### **メリット**
- ✅ GitHub上の最新コードが取得できる
- ✅ ファイル構造が自動的に整理される
- ✅ 手動コピーのミスがない
- ✅ バージョン管理が効く

### **実行コマンド**

```powershell
# 1. ディレクトリ移動
cd E:\anonymous-keiba-ai-JRA

# 2. 最新コードをPull
git pull origin genspark_ai_developer

# 3. スクリプト確認
ls phase7\scripts\phase7b

# 4. スクリプト実行
cd phase7\scripts\phase7b
python create_merged_dataset_334cols.py
```

---

## 🔧 **Git Pullでエラーが出る場合**

### **エラー1: ローカルに変更がある**

```
error: Your local changes to the following files would be overwritten by merge
```

**対応**:
```powershell
# 1. 変更を一時保存
git stash

# 2. Pull実行
git pull origin genspark_ai_developer

# 3. 変更を戻す（必要な場合）
git stash pop
```

---

### **エラー2: ブランチが違う**

```
fatal: couldn't find remote ref genspark_ai_developer
```

**対応**:
```powershell
# 1. ブランチ一覧確認
git branch -a

# 2. 正しいブランチに切り替え
git checkout genspark_ai_developer

# 3. Pull実行
git pull origin genspark_ai_developer
```

---

## 📝 **まとめ: どちらの方法を選ぶか？**

| 方法 | メリット | デメリット | 推奨度 |
|---|---|---|---|
| **Git Pull** | ・自動で整理<br>・バージョン管理<br>・最新コード取得 | ・Gitの知識必要 | ⭐⭐⭐⭐⭐ |
| **手動作成** | ・Gitなしで実行可能<br>・すぐ実行できる | ・手動コピー<br>・ミスの可能性 | ⭐⭐⭐ |

---

## 🎯 **次のアクション**

1. **Git Pullを試す**（推奨）
   ```powershell
   cd E:\anonymous-keiba-ai-JRA
   git pull origin genspark_ai_developer
   cd phase7\scripts\phase7b
   python create_merged_dataset_334cols.py
   ```

2. **失敗したら手動作成**
   ```powershell
   # ステップ2のスクリプト作成コマンドを実行
   ```

3. **実行結果を報告**
   - ✅ 成功 or ❌ 失敗
   - 行数、カラム数、ファイルサイズ

---

**作成者**: AI Assistant  
**最終更新**: 2026-03-09  
**次のアクション**: Git Pull → スクリプト実行 → 結果報告
