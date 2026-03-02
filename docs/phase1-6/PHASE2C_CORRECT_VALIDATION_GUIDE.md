# Phase 2C 正しい検証実施手順書

**作成日**: 2026-03-01  
**目的**: データリークを防いだ正しいPhase 2C分析の実施  
**推定所要時間**: 約20-30分（1月のみ）または 1-2時間（全月）

---

## 📋 概要

### 問題点
現在のPhase 2C分析では、2016-2025年訓練モデルで2025年を予測しているため、**データリーク**が発生しています。

### 解決策
**既存の評価用モデル**（`*_eval.txt`）を使用します。これらは訓練スクリプトで自動的に2016-2024年データで訓練されたモデルです。

---

## 🎯 使用ファイル

### モデルファイル（Phase 2C専用 - 既存の評価用モデル）
```
models/
├── jra_binary_model_eval.txt          # 二値分類（2016-2024訓練）
├── jra_ranking_model_eval.txt         # ランキング（2016-2024訓練）
└── jra_regression_model_eval.txt      # 回帰（2016-2024訓練）
```
**注意**: これらのファイルは既に存在しています（訓練スクリプトで自動生成済み）

### 予測結果ファイル
```
results/validation/predictions_2025_phase2c/
├── csv/
│   ├── predictions_20250105.csv
│   ├── predictions_20250106.csv
│   └── ... (約100ファイル)
└── markdown/
    ├── 20250105_note.md
    ├── 20250105_bookers.md
    └── ... (約300ファイル)
```

### Phase 2C分析結果
```
results/validation/hensachi_odds_matrix_phase2c/
├── tansho_hensachi_odds_matrix.csv
├── fukusho_hensachi_odds_matrix.csv
├── tansho_hensachi_odds_heatmap.png
├── fukusho_hensachi_odds_heatmap.png
└── hensachi_odds_matrix_report.md
```

---

## 🚀 実行手順

### 前提条件
- Git最新版を取得済み
- Python環境が正常動作
- PostgreSQLデータベースが起動中
- ディスク空き容量: 最低10GB

---

### Step 1: 評価用モデルの確認（1分）

評価用モデル（`*_eval.txt`）が既に存在することを確認します。

```powershell
cd E:\anonymous-keiba-ai-JRA
Get-ChildItem models\*_eval.txt | Format-Table Name, Length, LastWriteTime
```

**期待される出力**:
```
Name                           Length  LastWriteTime
----                           ------  -------------
jra_binary_model_eval.txt      16.5 MB 2026/02/27 23:02
jra_ranking_model_eval.txt      1.4 MB 2026/02/27 23:32
jra_regression_model_eval.txt   9.3 MB 2026/02/22 21:38
```

**重要**: これらのファイルは **2016-2024年データで訓練済み** なので、新たなモデル訓練は不要です。

---

### Step 2: GitHubから最新コードを取得（5分）

```powershell
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer
```

**確認**:
```powershell
# 以下のファイルが存在することを確認
Test-Path train_phase2c_models.ps1
Test-Path batch_predict_2025_phase2c.py
Test-Path scripts\phase6\phase6_daily_prediction_phase2c.py
```

---

### Step 2: GitHubから最新コードを取得（5分）

```powershell
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer
```

**確認**:
```powershell
# 以下のファイルが存在することを確認
Test-Path batch_predict_2025_phase2c.py
Test-Path scripts\phase6\phase6_daily_prediction_phase2c.py
```

すべて `True` を返せばOK。

---

### Step 3: 2025年予測を再生成（評価用モデル使用、1月のみ: 5-10分）

#### Option A: 1月のみ（推奨、約5-10分）
```powershell
cd E:\anonymous-keiba-ai-JRA
python batch_predict_2025_phase2c.py
# プロンプトで "1" を入力（1月のみ）
# 確認プロンプトで "yes" を入力
```

#### Option B: 全月（1-2時間）
```powershell
cd E:\anonymous-keiba-ai-JRA
python batch_predict_2025_phase2c.py
# プロンプトで "0" を入力（全月）
# 確認プロンプトで "yes" を入力
```

**完了確認**:
```powershell
Get-ChildItem results\validation\predictions_2025_phase2c\csv\*.csv | Measure-Object

# 1月のみ: Count = 9
# 全月: Count = 約100
```

---

### Step 4: Phase 2C分析を実行（5-10分）

```powershell
cd E:\anonymous-keiba-ai-JRA

# 1月分のみの場合
python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --month 1 `
    --predictions-dir results\validation\predictions_2025_phase2c\csv `
    --output results\validation\hensachi_odds_matrix_phase2c

# 全月の場合（--month を省略）
python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --predictions-dir results\validation\predictions_2025_phase2c\csv `
    --output results\validation\hensachi_odds_matrix_phase2c
```

**完了確認**:
```powershell
Get-ChildItem results\validation\hensachi_odds_matrix_phase2c\

# 期待される出力（5ファイル）:
# tansho_hensachi_odds_matrix.csv
# fukusho_hensachi_odds_matrix.csv
# tansho_hensachi_odds_heatmap.png
# fukusho_hensachi_odds_heatmap.png
# hensachi_odds_matrix_report.md
```

---

### Step 5: 結果を確認

```powershell
cd E:\anonymous-keiba-ai-JRA

# Markdownレポートを開く
notepad results\validation\hensachi_odds_matrix_phase2c\hensachi_odds_matrix_report.md

# ヒートマップを開く
Invoke-Item results\validation\hensachi_odds_matrix_phase2c\tansho_hensachi_odds_heatmap.png
Invoke-Item results\validation\hensachi_odds_matrix_phase2c\fukusho_hensachi_odds_heatmap.png

# CSVをExcelで開く
Invoke-Item results\validation\hensachi_odds_matrix_phase2c\tansho_hensachi_odds_matrix.csv
```

---

## 🔍 結果の比較

### 旧結果（データリークあり、2016-2025年モデル）
- 偏差値S × オッズ100倍以上: **回収率8,893%**（異常に高い）
- サンプル数: 3,086頭（2025年1月）

### 新結果（正しい検証、2016-2024年モデル）
- 偏差値S × オッズ100倍以上: **回収率 ??%**（予測値）
- サンプル数: 同じ3,086頭

**期待される変化**:
- 回収率が大幅に低下（よりリアルな値になる）
- 的中率が若干低下
- 統計的に信頼できる結果が得られる

---

## ⚠️ トラブルシューティング

### Q1: モデル訓練でエラーが出る
```powershell
# ログファイルを確認
Get-Content logs\phase3_binary_model_*.log -Tail 50
Get-Content logs\phase4_ranking_model_*.log -Tail 50
```

### Q2: 予測生成でタイムアウトが多発
```powershell
# タイムアウト時間を延長（batch_predict_2025_phase2c.py の232行目）
# timeout=300 → timeout=600 に変更
```

### Q3: データベース接続エラー
```powershell
# PostgreSQLサービスを再起動
Restart-Service postgresql-x64-15

# 接続確認
psql -U postgres -d pckeiba -c "SELECT COUNT(*) FROM jvd_ra WHERE kaisai_nen = '2025';"
```

---

## 📊 期待される実行時間

| ステップ | 処理内容 | 所要時間 |
|---------|---------|---------|
| Step 1 | 評価用モデル確認 | 1分 |
| Step 2 | Git取得 | 5分 |
| Step 3 (1月のみ) | 予測生成 | 5-10分 |
| Step 3 (全月) | 予測生成 | 1-2時間 |
| Step 4 (1月のみ) | Phase 2C分析 | 2-5分 |
| Step 4 (全月) | Phase 2C分析 | 5-10分 |
| **合計（1月のみ）** | | **約15-20分** |
| **合計（全月）** | | **約1.5-2.5時間** |

---

## 📝 重要な注意事項

1. **本番用モデル（2016-2025年）は温存**
   - `jra_binary_model.txt`
   - `jra_ranking_model.txt`
   - `jra_regression_model_optimized.txt`
   - これらは Phase 2C に影響されません

2. **評価用モデル（2016-2024年）を使用**
   - `jra_binary_model_eval.txt`
   - `jra_ranking_model_eval.txt`
   - `jra_regression_model_eval.txt`
   - これらは訓練スクリプトで既に作成済み

3. **ディスク容量**
   - 評価用モデル: 約27 MB（既存）
   - 予測CSV（1月のみ）: 約10 MB
   - 予測CSV（全月）: 約100 MB
   - 合計: 最低5GB推奨

---

**最終更新**: 2026-03-01  
**作成者**: anonymous  
**プロジェクト**: JRA中央競馬AIシステム Phase 2C
