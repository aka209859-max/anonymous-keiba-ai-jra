# ルートディレクトリPythonファイル詳細分類表

**作成日**: 2026-03-02  
**総ファイル数**: 25個  
**分類基準**: 保持/移動/削除

---

## 📊 分類サマリー

| 分類 | 件数 | 処理 |
|------|------|------|
| **A. 現在使用中（保持）** | 2個 | ルートに残す |
| **B. 検証・分析ツール（移動）** | 8個 | `scripts/analysis/` へ移動 |
| **C. テスト・デバッグ（移動）** | 10個 | `scripts/test/` へ移動 |
| **D. 一時・重複スクリプト（削除）** | 5個 | 削除 |

---

## A. 現在使用中（保持）- 2個

**処理**: ルートディレクトリに残す

| ファイル名 | サイズ | 用途 | 理由 |
|-----------|--------|------|------|
| `phase6_daily_prediction.py` | 51K | **Phase 6本番予測システム** | 現在稼働中（絶対保持） |
| `phase0_setup.py` | 9.9K | 環境構築・接続確認 | セットアップ時に使用 |

---

## B. 検証・分析ツール（移動）- 8個

**移動先**: `scripts/analysis/`

| ファイル名 | サイズ | 用途 | 移動先 |
|-----------|--------|------|--------|
| `analyze_model_features.py` | 12K | モデル特徴量分析（JRA-VAN/JRDB分類） | `scripts/analysis/analyze_model_features.py` |
| `analyze_phase2c_by_rank.py` | 3.2K | Phase 2C結果ランク別分析 | `scripts/analysis/analyze_phase2c_by_rank.py` |
| `batch_predict_2025_phase2c.py` | 15K | **2025年一括予測（Phase 2C検証用）** | `scripts/validation/batch_predict_2025_phase2c.py` |
| `check_phase2c_data.py` | 10K | Phase 2Cデータ確認 | `scripts/validation/check_phase2c_data.py` |
| `count_features.py` | 7.1K | 特徴量カウント | `scripts/analysis/count_features.py` |
| `correct_feature_count.py` | 4.5K | 特徴量カウント（修正版） | `scripts/analysis/correct_feature_count.py` |
| `analyze_model_features.py` | 12K | モデル特徴量分析 | `scripts/analysis/deep_check_jrdb_features.py` |
| `verify_jrdb_usage.py` | 5.0K | JRDB使用状況検証 | `scripts/analysis/verify_jrdb_usage.py` |

---

## C. テスト・デバッグ（移動）- 10個

**移動先**: `scripts/test/`

| ファイル名 | サイズ | 用途 | 移動先 |
|-----------|--------|------|--------|
| `check_jrd_sed.py` | 3.8K | jrd_sedテーブル診断 | `scripts/test/check_jrd_sed.py` |
| `check_jrdb_data.py` | 4.2K | JRDBデータ確認 | `scripts/test/check_jrdb_data.py` |
| `check_jrdb_features_in_models.py` | 2.9K | モデルJRDB特徴量確認 | `scripts/test/check_jrdb_features_in_models.py` |
| `check_odds_detail.py` | 8.7K | オッズ・払戻データ確認 | `scripts/test/check_odds_detail.py` |
| `check_similar_columns.py` | 5.7K | 類似カラム検索 | `scripts/test/check_similar_columns.py` |
| `debug_merge_keys.py` | 3.8K | マージキー検証 | `scripts/test/debug_merge_keys.py` |
| `find_alternative_columns.py` | 4.0K | 代替カラム検索 | `scripts/test/find_alternative_columns.py` |
| `find_odds_tables.py` | 5.3K | オッズテーブル特定 | `scripts/test/find_odds_tables.py` |
| `test_odds_parser.py` | 6.4K | オッズパーサーテスト | `scripts/test/test_odds_parser.py` |
| `test_umaban_query.py` | 4.4K | umaban型・フィルター確認 | `scripts/test/test_umaban_query.py` |
| `verify_merge.py` | 2.2K | マージキー検証（シンプル版） | `scripts/test/verify_merge.py` |
| `verify_sanrenpuku.py` | 1.4K | 三連複フォーマット検証 | `scripts/test/verify_sanrenpuku.py` |

---

## D. 一時・重複スクリプト（削除）- 5個

**理由**: 古いバージョン・一時的な検証スクリプト

| ファイル名 | サイズ | 削除理由 |
|-----------|--------|---------|
| `batch_predict_2025.py` | 5.0K | 古いバージョン（`batch_predict_2025_phase2c.py`で代替） |
| `batch_predict_2025_monthly.py` | 9.5K | 月別版（phase2c版で代替） |
| `batch_predict_2025_organized.py` | 15K | 整理版（phase2c版で代替） |
| `deep_check_jrdb_features.py` | 12K | `analyze_model_features.py`と重複 |
| `correct_feature_count.py` | 4.5K | `count_features.py`と機能重複 |

**合計削除**: 5個

---

## 📊 処理サマリー

### **ルート保持: 2個**
```
phase6_daily_prediction.py（現在稼働中）
phase0_setup.py（セットアップ用）
```

### **移動するファイル: 18個**
```
scripts/analysis/     4個
scripts/validation/   2個
scripts/test/        12個
```

### **削除するファイル: 5個**
- 古いバージョン・重複スクリプト

---

## ✅ ユーザー承認が必要

### **承認事項**

1. **削除対象5個の確認**
   ```
   1. batch_predict_2025.py
   2. batch_predict_2025_monthly.py
   3. batch_predict_2025_organized.py
   4. deep_check_jrdb_features.py（analyze_model_features.pyと重複）
   5. correct_feature_count.py（count_features.pyと重複）
   ```
   削除してよろしいですか？

2. **移動先ディレクトリ構成の確認**
   ```
   scripts/
   ├── phase1/
   ├── phase2/
   ├── phase3/
   ├── phase4/
   ├── phase5/
   ├── phase6/
   ├── analysis/（新規）
   │   ├── analyze_model_features.py
   │   ├── analyze_phase2c_by_rank.py
   │   ├── count_features.py
   │   └── verify_jrdb_usage.py
   ├── validation/（既存）
   │   ├── batch_predict_2025_phase2c.py
   │   └── check_phase2c_data.py
   └── test/（新規）
       ├── check_*.py（8個）
       ├── debug_merge_keys.py
       ├── find_*.py（2個）
       ├── test_*.py（2個）
       └── verify_*.py（2個）
   ```
   この構成でよろしいですか？

3. **phase6_daily_prediction.pyの扱い**
   - ルートに残す（現在稼働中のため）
   - または `scripts/phase6/` へ移動して、ルートにシンボリックリンク作成
   
   どちらが良いですか？

---

## 🖥️ PC側の削除コマンド（サンドボックス整理後に実行）

### **MDファイル削除（16個）**
```powershell
cd E:\anonymous-keiba-ai-JRA

# 削除対象MDファイル
Remove-Item -Path @(
    "CLEANUP_PLAN.md",
    "PHASE0_PROGRESS_REPORT_20260219.md",
    "PHASE1C_SCRIPT_CLEANUP_REPORT.md",
    "PHASE2C_DATA_PREPARATION_REPORT.md",
    "PHASE2C_ORGANIZED_EXECUTION_GUIDE.md",
    "PHASE6_INVESTIGATION_RESULTS.md",
    "KOKURA_SEASON_UPDATE.md",
    "DEEP_SEARCH_PC_KEIBA_WORKFLOW.md",
    "PCKEIBA_JRDB_INVESTIGATION_PROMPT.md",
    "PCKEIBA_JRDB_OPTIMIZATION_IMPLEMENTATION_PLAN.md",
    "PCKEIBA_JRDB_REGISTRATION_DEEPSEARCH_INSTRUCTION.md",
    "PCKEIBA_JRDB_REGISTRATION_OPTIMIZATION_INVESTIGATION.md",
    "PCKEIBA_PHASE1_5_IMPLEMENTATION_INVESTIGATION.md",
    "PCKEIBA_PHASE1_5_INVESTIGATION_FINAL_VERDICT.md",
    "PHASE1_5_PCKEIBA_INVESTIGATION_REVIEW.md",
    "SEARCH_INSTRUCTIONS.md"
) -Force

Write-Host "✅ MDファイル16個削除完了"
```

### **Pythonファイル削除（5個）**
```powershell
cd E:\anonymous-keiba-ai-JRA

# 削除対象Pythonファイル
Remove-Item -Path @(
    "batch_predict_2025.py",
    "batch_predict_2025_monthly.py",
    "batch_predict_2025_organized.py",
    "deep_check_jrdb_features.py",
    "correct_feature_count.py"
) -Force

Write-Host "✅ Pythonファイル5個削除完了"
```

### **削除確認**
```powershell
# 削除されたことを確認
cd E:\anonymous-keiba-ai-JRA
Get-ChildItem -Filter *.md | Measure-Object
Get-ChildItem -Filter *.py | Measure-Object
```

**期待結果**:
- MDファイル: 65個 → 49個（16個削除）
- Pythonファイル: 25個 → 20個（5個削除）

---

**更新履歴**:
- 2026-03-02 15:15: 初版作成（全25個分類完了）
