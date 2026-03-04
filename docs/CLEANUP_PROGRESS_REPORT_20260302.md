# Phase 7開始前の整理作業 進捗レポート

**作成日時**: 2026-03-02  
**作業担当**: AI Assistant  
**作業状況**: Phase 1完了（現状調査中）

---

## 🎯 全体タスク

### **1️⃣ Phase 7 ドキュメント作成・保存（✅ 完了）**

#### 実施内容
- Phase 7の3つの専用ドキュメントを作成
- GitHubへコミット・プッシュ完了
- サンドボックスにも保存完了

#### 成果物
| ファイル | サイズ | 保存場所 |
|---------|--------|---------|
| PHASE7_WORKFLOW.md | 9.5KB | `/home/user/webapp/docs/phase7/` |
| PHASE7_ROADMAP.md | 9.6KB | `/home/user/webapp/docs/phase7/` |
| PHASE7_STRATEGY.md | 13KB | `/home/user/webapp/docs/phase7/` |

#### GitHubコミット情報
- **コミットID**: `7dbf730`
- **ブランチ**: `genspark_ai_developer`
- **GitHub URL**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/tree/genspark_ai_developer/docs/phase7
- **プッシュ状態**: ✅ 完了

#### 重要決定事項
- **GitHubリポジトリ**: 既存リポジトリ（anonymous-keiba-ai-jra）を継続使用
- **理由**: 
  - 将来のアプリ化を考慮（モノレポ構成が最適）
  - データベース・特徴量エンジン共有
  - Phase 6 vs Phase 7 比較検証が容易

---

### **2️⃣ 既存リポジトリ整理（Phase 1~6）（🔄 進行中）**

#### 現在の進捗: Phase 1 - 現状調査中

---

## 📊 現状調査結果（Phase 1~6）

### **ディレクトリ構造（現状）**

```
/home/user/webapp/
├── .git/
├── docs/
│   ├── phase7/（✅ 新規作成済み）
│   └── （その他未整理）
├── scripts/
│   ├── phase1/
│   │   ├── README_EXTRACT_FEATURES.md
│   │   ├── SCRIPT_STRUCTURE.md
│   │   └── extract_jra_features_v1.py
│   ├── phase2/
│   │   └── merge_all_features.py
│   ├── phase3/
│   │   ├── adjust_threshold.py
│   │   └── train_binary_model.py
│   ├── phase4/
│   │   ├── analyze_ranking_model.py
│   │   ├── train_ranking_model.py
│   │   ├── train_ranking_model_eval.py
│   │   ├── train_regression_model.py
│   │   └── train_regression_model_optimized.py
│   ├── phase5/
│   │   └── ensemble_prediction.py
│   ├── phase6/
│   │   ├── README_PHASE6.md
│   │   ├── fetch_today_data.py
│   │   ├── fetch_today_data_v2.py
│   │   ├── inspect_database.py
│   │   ├── phase6_daily_prediction.py
│   │   ├── phase6_daily_prediction_phase2c.py
│   │   └── run_phase6_test.ps1
│   ├── jrdb/
│   ├── utils/
│   ├── analysis/
│   ├── data_preparation/
│   ├── evaluation/
│   └── validation/
├── models/（空ディレクトリ）
├── results/
├── logs/
├── data/
├── config/
├── sql/
└── ルートディレクトリ:
    ├── *.md ファイル: 65個 ← 要整理
    └── *.py ファイル: 25個 ← 要整理
```

### **Phase 1~6 の主要スクリプト**

| Phase | 主要スクリプト | 役割 |
|-------|---------------|------|
| **Phase 1** | `extract_jra_features_v1.py` | JRA-VANから特徴量抽出 |
| **Phase 2** | `merge_all_features.py` | 特徴量マージ（139次元） |
| **Phase 3** | `train_binary_model.py` | 二値分類モデル訓練 |
| **Phase 4** | `train_ranking_model_eval.py`<br>`train_regression_model_optimized.py` | ランキング・回帰モデル訓練 |
| **Phase 5** | `ensemble_prediction.py` | 3モデルアンサンブル予測 |
| **Phase 6** | `phase6_daily_prediction.py` | 日次予測システム（本番運用） |

### **Phase 6 の主要機能**

#### スクリプト: `phase6_daily_prediction.py`

**主要関数**:
```
setup_logging()                    # ログ初期化
get_db_connection()                # DB接続
fetch_today_data()                 # 当日データ取得
load_models()                      # 3モデル読み込み
ensemble_predict()                 # アンサンブル予測
calculate_hensachi_for_race()      # 偏差値計算
assign_hensachi_rank()             # ランク割り当て（S/A/B/C/D/E）
should_recommend_purchase()        # 購入推奨判定
generate_betting_recommendations() # 買い目生成
save_predictions()                 # 予測結果保存
generate_note_format()             # Note形式出力
generate_bookers_format()          # ブッカーズ形式出力
generate_twitter_format()          # Twitter形式出力
```

**出力形式**:
- Markdown: `results/{競馬場}_{日付}_note.txt`
- Markdown: `results/{競馬場}_{日付}_bookers.txt`
- Markdown: `results/{競馬場}_{日付}_tweet.txt`
- CSV: `results/predictions_{日付}.csv`

**特徴量数**: 139次元（JRA-VAN）

---

## 🚨 整理が必要な項目

### **ルートディレクトリの混在ファイル**

#### MDファイル（65個）
```
# Phase 0関連
- PHASE0_*.md（5個）

# Phase 1関連
- PHASE1A_*.md
- PHASE1B_*.md
- PHASE1C_*.md（複数）
- PHASE1_5_*.md

# Phase 2関連
- PHASE2C_*.md（複数）

# Phase 5関連
- PHASE5_*.md

# Phase 6関連
- PHASE6_*.md（複数）

# JRDB関連
- JRDB_*.md（多数）

# PC-KEIBA関連
- PCKEIBA_*.md（複数）

# その他
- PROJECT_ROADMAP_STATUS.md
- INTEGRATED_FEATURE_SPECIFICATION_FINAL.md
- JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md
- README.md
- CLEANUP_PLAN.md
- GIT_CONFLICT_RESOLUTION.md
- 等...
```

#### Pythonファイル（25個）
```
- phase0_setup.py
- phase6_daily_prediction.py
- analyze_model_features.py
- analyze_phase2c_by_rank.py
- batch_predict_2025*.py（複数バージョン）
- check_*.py（多数の検証スクリプト）
- verify_*.py
- count_features.py
- debug_*.py
- find_*.py
- fix_*.py
- test_*.py
- train_phase2c_models.ps1
等...
```

---

## 📋 次のステップ（2️⃣ の続き）

### **Phase 2: ファイル詳細分類（これから実施）**

#### 実施予定
1. **ルートディレクトリの全MDファイルリスト作成**
   - 各ファイルの目的・重要度を分類
   - 保持すべきファイル特定
   - 削除すべきファイル特定
   - `docs/phase1-6/` への移動対象特定

2. **ルートディレクトリの全Pythonファイルリスト作成**
   - 各ファイルの目的・使用状況を分類
   - 現在使用中のスクリプト特定
   - 廃止・テスト用スクリプト特定
   - 削除対象の特定

3. **ユーザー確認**
   - 分類結果をユーザーに提示
   - 削除・移動の承認を得る
   - **自動判定は危険なため、必ず事実確認**

### **Phase 3: 整理実行（Phase 2承認後）**

1. `docs/phase1-6/` ディレクトリ作成
2. 必要なドキュメント移動
3. 不要ファイル削除
4. Phase 1~6の統合ドキュメント作成
   - `OVERVIEW.md`
   - `PHASE1-6_WORKFLOW.md`
   - `FEATURES_SPECIFICATION.md`（139次元詳細）
   - `EXECUTION_FLOWCHART.md`

### **Phase 4: Git コミット・プッシュ**

1. 整理後の状態をコミット
2. GitHubにプッシュ
3. 整理完了レポート作成

---

## 🎯 Phase 7開始条件

以下が完了したらPhase 7開発を開始:

- ✅ 1️⃣ Phase 7ドキュメント作成・保存（完了）
- ⬜ 2️⃣ 既存リポジトリ整理（Phase 1~6）
  - ⬜ Phase 2-1: MDファイル詳細分類
  - ⬜ Phase 2-2: Pythonファイル詳細分類
  - ⬜ Phase 2-3: ユーザー承認
  - ⬜ Phase 3: 整理実行
  - ⬜ Phase 4: Git コミット

---

## 📝 重要な注意事項

### **自動判定は危険**
- ユーザー指示通り、**自動判定は行わない**
- 全ファイルの目的・重要度を事実確認
- ユーザーの承認を得てから削除・移動を実行

### **Phase 6の現行運用システム**
- `scripts/phase6/phase6_daily_prediction.py` は現在稼働中
- このファイルは絶対に削除しない
- Phase 6関連の重要ドキュメントも保持

### **Phase 7との関係**
- Phase 7は Phase 6の139次元特徴量を基盤として使用
- Phase 1~6のワークフローを Phase 7で参照する可能性
- 整理後も参照可能な状態を維持

---

## 📂 現在の作業ファイル

このレポート自体:
- サンドボックス: `/home/user/webapp/docs/CLEANUP_PROGRESS_REPORT_20260302.md`

---

## 🔄 次回作業再開時のチェックリスト

1. このレポートを読む
2. 現在地: **2️⃣ Phase 2-1（MDファイル詳細分類）**
3. 次のアクション: ルートディレクトリの全MDファイルの目的・重要度を一覧化
4. ユーザーに確認を求める

---

---

## ✅ 整理作業完了（2026-03-02 15:10）

### 実施内容サマリー

#### Phase 2: ファイル詳細分類 ✅
- MDファイル65件の分類完了 → `MD_FILES_CLASSIFICATION_REPORT.md`
- Pythonファイル25件の分類完了 → `PY_FILES_CLASSIFICATION_REPORT.md`
- ユーザー承認取得（削除対象21件、移動66件、保持3件）

#### Phase 3: 整理実行 ✅
**削除済み（21件）**:
- MDファイル 16件（一時レポート、調査指示、古い進捗）
- Pythonファイル 5件（旧バージョン、重複スクリプト）

**移動済み（66件）**:
- `docs/phase1-6/` → 14件（Phase 1-6重要ドキュメント）
- `docs/phase1-6/phase6/` → 15件（Phase 6運用ドキュメント）
- `docs/jrdb/` → 11件（JRDBデータ関連）
- `docs/troubleshooting/` → 8件（トラブルシューティング）
- `scripts/analysis/` → 4件
- `scripts/validation/` → 2件
- `scripts/test/` → 12件

**ルート保持（3件）**:
- README.md
- phase0_setup.py
- phase6_daily_prediction.py（本番運用中）

#### Phase 4: Git コミット・プッシュ ✅
- **コミットID**: `95e9163`
- **コミットメッセージ**: "refactor: Organize Phase 1-6 repository structure for Phase 7 preparation"
- **変更サマリー**: 91 files changed, 895 insertions(+), 5600 deletions(-)
- **プッシュ先**: origin/genspark_ai_developer
- **GitHub URL**: https://github.com/aka209859-max/anonymous-keiba-ai-jra

### 整理完了レポート
詳細は `docs/REPOSITORY_CLEANUP_SUMMARY.md` を参照

### Phase 7 開発開始準備完了 ✅

**PC側で実行すべきコマンド**:
```powershell
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git pull origin genspark_ai_developer
```

---

**更新履歴**:
- 2026-03-02 14:45: 初版作成（Phase 1調査完了時点）
- 2026-03-02 15:10: Phase 2-4 完了、整理作業完了
