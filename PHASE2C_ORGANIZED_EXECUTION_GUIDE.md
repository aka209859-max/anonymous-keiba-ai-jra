# Phase 2C 実行手順（整理版）

**更新日**: 2026-03-01  
**Phase**: Phase 2C 準備 + 実行  
**Status**: ✅ 整理版スクリプト準備完了

---

## 🎯 概要

以下の2ステップでPhase 2Cを実行します：

1. **ステップ1**: 2025年1-12月の予測CSV・Markdownを**整理されたフォルダ**に生成（JRA中央競馬のみ）
2. **ステップ2**: Phase 2C の偏差値×オッズ マトリクス分析を実行

---

## 📁 新しいフォルダ構造

### 従来の問題点

❌ `results/` 直下にすべてのファイルが混在
- 予測CSV、Markdown、地方競馬ファイルが混ざっている
- Phase 2C で使うファイルが見つけにくい

### 新しい構造（整理版）

✅ `results/validation/predictions_2025/` に整理

```
results/
└── validation/
    ├── predictions_2025/          # 予測データ（JRA中央競馬のみ）
    │   ├── csv/
    │   │   ├── predictions_20250105.csv
    │   │   ├── predictions_20250106.csv
    │   │   ├── predictions_20250111.csv
    │   │   └── ... (約100ファイル)
    │   └── markdown/
    │       ├── 阪神_20250105_note.txt
    │       ├── 阪神_20250105_bookers.txt
    │       ├── 阪神_20250105_tweet.txt
    │       └── ... (約300ファイル)
    └── hensachi_odds_matrix/      # Phase 2C 分析結果
        ├── tansho_hensachi_odds_matrix.csv
        ├── fukusho_hensachi_odds_matrix.csv
        ├── tansho_hensachi_odds_heatmap.png
        ├── fukusho_hensachi_odds_heatmap.png
        └── hensachi_odds_matrix_report.md
```

---

## 🚀 ステップ1: 予測CSV・Markdown生成（整理版）

### 1-1. 最新コードを取得

```powershell
cd E:\anonymous-keiba-ai-JRA

# 最新コードをpull
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer
```

**期待される出力**:
```
Updating c0f4c42..2f6e25c
Fast-forward
 batch_predict_2025_organized.py | 445 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 445 insertions(+)
```

### 1-2. 整理版スクリプトを実行

#### オプション A: 1月のみ生成（推奨）

```powershell
cd E:\anonymous-keiba-ai-JRA
python batch_predict_2025_organized.py
# プロンプトで「1」を入力
# 確認で「yes」を入力
```

**推定実行時間**: 約1分（9日分）

#### オプション B: 全月生成（1-12月）

```powershell
cd E:\anonymous-keiba-ai-JRA
python batch_predict_2025_organized.py
# プロンプトで「0」を入力
# 確認で「yes」を入力
```

**推定実行時間**: 約1-2時間（約100日分）

### 1-3. 出力確認

```powershell
# CSV数を確認（1月の場合は9個）
ls results\validation\predictions_2025\csv\*.csv | Measure-Object | Select-Object Count

# Markdown数を確認（1月の場合は27個 = 9日 × 3種類）
ls results\validation\predictions_2025\markdown\*.txt | Measure-Object | Select-Object Count
```

**期待結果（1月の場合）**:
- CSV: 9個
- Markdown: 27個（note, bookers, tweet × 9日）

---

## 🔍 ステップ2: Phase 2C マトリクス分析実行

### 2-1. Phase 2C スクリプトを実行

```powershell
cd E:\anonymous-keiba-ai-JRA

python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --month 1 `
    --predictions-dir results\validation\predictions_2025\csv `
    --output results\validation\hensachi_odds_matrix `
    --db-config config\db_config.yaml
```

**重要**: `--predictions-dir` を新しい整理されたフォルダに指定

**推定実行時間**: 約2-5分

### 2-2. 実行ログの確認

正常に実行されると、以下のようなログが表示されます：

```
2026-03-01 15:00:00 - INFO - ================================================================================
2026-03-01 15:00:00 - INFO - Phase 2C: Hensachi x Odds Matrix Analysis
2026-03-01 15:00:00 - INFO - ================================================================================
2026-03-01 15:00:01 - INFO - Found 9 prediction CSV files
2026-03-01 15:00:01 - INFO - Loaded: predictions_20250105.csv (216 rows)
...
2026-03-01 15:00:10 - INFO - Tansho matrix generated: 24 cells
2026-03-01 15:00:11 - INFO - Fukusho matrix generated: 24 cells
2026-03-01 15:00:17 - INFO - Analysis completed successfully!
2026-03-01 15:00:17 - INFO - 
✅ Phase 2C analysis completed successfully!
```

### 2-3. 出力ファイルの確認

```powershell
# 出力ディレクトリを開く
start results\validation\hensachi_odds_matrix

# レポートを開く
notepad results\validation\hensachi_odds_matrix\hensachi_odds_matrix_report.md

# ヒートマップを開く
start results\validation\hensachi_odds_matrix\tansho_hensachi_odds_heatmap.png
start results\validation\hensachi_odds_matrix\fukusho_hensachi_odds_heatmap.png
```

---

## 📊 整理版スクリプトの機能

### ✅ 機能1: JRA中央競馬のみ対象

**フィルタリング**:
- JRA競馬場コード 01-10 のみ
- 地方競馬場（帯広、門別、盛岡、水沢、浦和、船橋、大井、川崎、金沢、笠松、名古屋、園田、姫路、高知、佐賀）を除外

**自動削除**:
- 生成後、地方競馬ファイルを自動削除

### ✅ 機能2: 整理されたフォルダ構造

**自動移動**:
- Phase 6 が `results/` 直下に生成したファイルを自動的に整理フォルダへ移動
- CSV → `results/validation/predictions_2025/csv/`
- Markdown → `results/validation/predictions_2025/markdown/`

**クリーンアップ**:
- `results/` 直下の一時ファイルを自動削除

### ✅ 機能3: 月別実行

**柔軟な実行オプション**:
- 月別（1-12月）: 特定月のみ生成
- 全月（0）: 1-12月を一括生成

---

## 🔧 トラブルシューティング

### エラー1: `FileNotFoundError: config/db_config.yaml`

**原因**: カレントディレクトリが間違っている

**解決策**:
```powershell
cd E:\anonymous-keiba-ai-JRA
pwd  # E:\anonymous-keiba-ai-JRA であることを確認
```

### エラー2: `ModuleNotFoundError: No module named 'yaml'`

**原因**: 必要なPythonパッケージが不足

**解決策**:
```powershell
pip install pyyaml psycopg2 pandas numpy matplotlib seaborn
```

### エラー3: `psycopg2.OperationalError: password authentication failed`

**原因**: データベース接続エラー

**解決策**:
1. PC-KEIBAが起動しているか確認
2. PostgreSQLサービスが起動しているか確認:
   ```powershell
   Get-Service -Name postgresql*
   ```
3. `config\db_config.yaml` のパスワードを確認

### エラー4: 地方競馬ファイルが残っている

**原因**: 古いスクリプトで生成済み

**解決策**:
```powershell
# 手動で地方競馬ファイルを削除
cd E:\anonymous-keiba-ai-JRA\results
Remove-Item *中元* -Recurse
Remove-Item *門別* -Recurse
Remove-Item *盛岡* -Recurse
# （他の地方競馬場も同様に削除）
```

---

## 📝 実行チェックリスト

### ステップ1: 準備

- [ ] 最新コードを取得 (`git pull`)
- [ ] PC-KEIBA / PostgreSQL が起動中
- [ ] Pythonパッケージがインストール済

### ステップ2: 予測CSV生成

- [ ] `batch_predict_2025_organized.py` を実行
- [ ] 月を選択（1月のみ推奨）
- [ ] 生成完了を確認（CSV 9個、Markdown 27個）

### ステップ3: Phase 2C 実行

- [ ] `validate_hensachi_odds_matrix.py` を実行
- [ ] `--predictions-dir` を整理フォルダに指定
- [ ] 出力ファイル5個を確認

### ステップ4: 結果確認

- [ ] レポート `hensachi_odds_matrix_report.md` を開く
- [ ] ヒートマップ画像を確認
- [ ] TOP 5 パターンを把握

---

## 🎯 次のステップ

### Phase 2C 完了後

1. **結果の分析**
   - レポートを読んで最優秀パターンを確認
   - 回収率が高い組み合わせを把握
   - 避けるべき組み合わせを把握

2. **Phase 3 への反映**
   - 購入推奨ロジックの確立
   - Phase 6 日次予測スクリプトへの統合

3. **全月データでの再検証（オプション）**
   - 1月データで問題なければ、全月データで実行
   - より信頼性の高い統計データを取得

---

## 📚 関連ファイル

**新規作成**:
- `batch_predict_2025_organized.py` - 整理版予測生成スクリプト

**既存**:
- `batch_predict_2025_monthly.py` - 旧版（整理なし）
- `scripts/validation/validate_hensachi_odds_matrix.py` - Phase 2C 分析スクリプト
- `PHASE2C_EXECUTION_GUIDE.md` - Phase 2C 実行ガイド

---

## 📝 Git情報

**最新コミット**: `2f6e25c`  
**ブランチ**: `genspark_ai_developer`  
**PR**: #1 (OPEN) - https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1

**コミット履歴**:
```
2f6e25c - feat: Add organized batch prediction script for 2025 JRA races
c0f4c42 - docs: Add Phase 2C execution guide
3fabc1d - feat: Implement Phase 2C Hensachi x Odds Matrix Analysis
```

---

**最終更新**: 2026-03-01 15:00  
**作成者**: anonymous  
**Phase**: Phase 2C 準備 + 実行  
**Status**: ✅ 準備完了、実行可能
