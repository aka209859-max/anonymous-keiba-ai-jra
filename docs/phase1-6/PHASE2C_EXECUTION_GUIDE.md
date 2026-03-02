# Phase 2C 実装完了 - 実行ガイド

**作成日**: 2026-03-01  
**Phase**: Phase 2C (偏差値×オッズ マトリクス分析)  
**Status**: ✅ 実装完了、実行準備完了

---

## 📋 実装完了内容

### ✅ 新規追加ファイル

**`scripts/validation/validate_hensachi_odds_matrix.py`** (約860行)

Phase 2C の完全実装スクリプト：

#### 主要機能

1. **オッズデータのパース**
   - `jvd_o1` テーブルの固定長文字列をパース
   - 単勝オッズ: 6文字単位（馬番2桁 + オッズ4桁）
   - 複勝オッズ: 8文字単位（馬番2桁 + 最小3桁 + 最大3桁）

2. **偏差値計算**
   - 各レース内で相対評価
   - Z-スコア → 偏差値 (50 + 10*Z)
   - ランク付与 (S/A/B/C/D/E)

3. **2次元マトリクス生成**
   - 偏差値ランク × オッズ帯
   - 的中率、回収率、ROI を算出
   - 推奨度を★で表示

4. **出力ファイル**
   - CSV形式（単勝・複勝マトリクス）
   - ヒートマップ画像（PNG形式）
   - Markdownレポート

---

## 🚀 実行方法

### 前提条件

1. **2025年1月の予測CSVファイルが存在**
   - 場所: `E:\anonymous-keiba-ai-JRA\results\predictions_202501*.csv`
   - 確認方法:
     ```powershell
     cd E:\anonymous-keiba-ai-JRA
     ls results\predictions_202501*.csv | Measure-Object | Select-Object Count
     ```
   - 期待結果: `Count : 9` （正常な開催日9日分）

2. **データベース接続が正常**
   - PC-KEIBA (PostgreSQL) が起動中
   - `config/db_config.yaml` の設定が正しい

3. **必要なPythonパッケージがインストール済**
   - pandas, numpy, psycopg2, matplotlib, seaborn, PyYAML

### ステップ1: 最新コードを取得

```powershell
cd E:\anonymous-keiba-ai-JRA

# 最新コードをpull
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer
```

**期待される出力**:
```
remote: Enumerating objects: X, done.
remote: Counting objects: 100% (X/X), done.
...
Updating 3496b42..3fabc1d
Fast-forward
 scripts/validation/validate_hensachi_odds_matrix.py | 863 +++++++++++++++++++
 1 file changed, 863 insertions(+)
 create mode 100644 scripts/validation/validate_hensachi_odds_matrix.py
```

### ステップ2: Phase 2C スクリプトを実行

#### オプション A: 2025年1月のみ（推奨）

```powershell
cd E:\anonymous-keiba-ai-JRA

python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --month 1 `
    --predictions-dir results `
    --output results\validation\hensachi_odds_matrix `
    --db-config config\db_config.yaml
```

**推定実行時間**: 約2〜5分

#### オプション B: 2025年全月（データがある場合）

```powershell
cd E:\anonymous-keiba-ai-JRA

python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --predictions-dir results `
    --output results\validation\hensachi_odds_matrix `
    --db-config config\db_config.yaml
```

**推定実行時間**: 約10〜20分（全月の場合）

---

## 📊 実行ログの見方

### 正常実行時のログ

```
2026-03-01 14:30:00 - INFO - ================================================================================
2026-03-01 14:30:00 - INFO - Phase 2C: Hensachi x Odds Matrix Analysis
2026-03-01 14:30:00 - INFO - ================================================================================
2026-03-01 14:30:00 - INFO - HensachiOddsMatrixAnalyzer initialized: year=2025, month=1
2026-03-01 14:30:01 - INFO - Found 9 prediction CSV files
2026-03-01 14:30:01 - INFO - Loaded: predictions_20250105.csv (216 rows)
2026-03-01 14:30:01 - INFO - Loaded: predictions_20250106.csv (232 rows)
...
2026-03-01 14:30:02 - INFO - Total predictions loaded: 1944 rows
2026-03-01 14:30:02 - INFO - Columns: ['race_id', 'umaban', 'ensemble_score', ...]
2026-03-01 14:30:03 - INFO - Loading odds data from jvd_o1...
2026-03-01 14:30:04 - INFO - Loaded 240 odds records
2026-03-01 14:30:04 - INFO - Loading results data from jvd_se...
2026-03-01 14:30:05 - INFO - Loaded 1944 result records
2026-03-01 14:30:05 - INFO - Parsing odds data...
2026-03-01 14:30:06 - INFO - Parsed odds data: 3456 horse-odds records
2026-03-01 14:30:06 - INFO - Merging prediction, odds, and results data...
2026-03-01 14:30:07 - INFO - After merging with odds: 1944 rows
2026-03-01 14:30:07 - INFO - After merging with results: 1944 rows
2026-03-01 14:30:07 - INFO - Final merged data: 1944 rows
2026-03-01 14:30:07 - INFO - Unique races: 240
2026-03-01 14:30:08 - INFO - Calculating hensachi (deviation scores)...
2026-03-01 14:30:08 - INFO - Hensachi calculation completed
2026-03-01 14:30:08 - INFO - Hensachi range: 32.45 - 78.12
2026-03-01 14:30:09 - INFO - Assigning hensachi ranks and odds bands...
2026-03-01 14:30:09 - INFO - 
=== Hensachi Rank Distribution ===
S    245
A    389
B    456
C    512
D    342
E     0
Name: hensachi_rank, dtype: int64
2026-03-01 14:30:09 - INFO - 
=== Tansho Odds Band Distribution ===
1.0-2.9      487
3.0-4.9      298
5.0-9.9      412
10.0-19.9    289
20.0-49.9    234
50.0-100.0   224
Name: tansho_odds_band, dtype: int64
2026-03-01 14:30:10 - INFO - Generating tansho (win) matrix...
2026-03-01 14:30:10 - INFO - Tansho matrix generated: 24 cells
2026-03-01 14:30:11 - INFO - Generating fukusho (place) matrix...
2026-03-01 14:30:11 - INFO - Fukusho matrix generated: 24 cells
2026-03-01 14:30:12 - INFO - Saved: results\validation\hensachi_odds_matrix\tansho_hensachi_odds_matrix.csv
2026-03-01 14:30:12 - INFO - Saved: results\validation\hensachi_odds_matrix\fukusho_hensachi_odds_matrix.csv
2026-03-01 14:30:13 - INFO - Creating tansho recovery rate heatmap...
2026-03-01 14:30:14 - INFO - Saved: results\validation\hensachi_odds_matrix\tansho_hensachi_odds_heatmap.png
2026-03-01 14:30:15 - INFO - Creating fukusho recovery rate heatmap...
2026-03-01 14:30:16 - INFO - Saved: results\validation\hensachi_odds_matrix\fukusho_hensachi_odds_heatmap.png
2026-03-01 14:30:17 - INFO - Saved: results\validation\hensachi_odds_matrix\hensachi_odds_matrix_report.md
2026-03-01 14:30:17 - INFO - ================================================================================
2026-03-01 14:30:17 - INFO - Analysis completed successfully!
2026-03-01 14:30:17 - INFO - Output directory: results\validation\hensachi_odds_matrix
2026-03-01 14:30:17 - INFO - ================================================================================
2026-03-01 14:30:17 - INFO - 
✅ Phase 2C analysis completed successfully!
```

---

## 📁 出力ファイル

### 出力ディレクトリ

```
E:\anonymous-keiba-ai-JRA\results\validation\hensachi_odds_matrix\
```

### ファイル一覧

#### 1. **tansho_hensachi_odds_matrix.csv**

単勝マトリクス（CSV形式）

**列構造**:
- `hensachi_rank`: 偏差値ランク (S/A/B/C/D/E)
- `tansho_odds_band`: 単勝オッズ帯 (1.0-2.9, 3.0-4.9, ...)
- `target_count`: 対象馬数
- `hit_count`: 的中数
- `hit_rate`: 的中率 (%)
- `avg_odds`: 平均オッズ (倍)
- `total_investment`: 総購入金額 (円)
- `total_payout`: 総払戻金額 (円)
- `recovery_rate`: 回収率 (%)
- `roi`: ROI (%) = 回収率 - 100
- `recommendation`: 推奨度 (★★★★★ ～ ☆)

**サンプル**:
```csv
hensachi_rank,tansho_odds_band,target_count,hit_count,hit_rate,avg_odds,recovery_rate,roi,recommendation
S,1.0-2.9,45,33,73.3,1.8,132.0,32.0,★★★
S,3.0-4.9,38,18,47.4,4.2,198.9,98.9,★★★★★
S,5.0-9.9,28,9,32.1,7.5,240.8,140.8,★★★★★
...
```

#### 2. **fukusho_hensachi_odds_matrix.csv**

複勝マトリクス（CSV形式）

**列構造**: 単勝マトリクスと同様
- `fukusho_odds_band`: 複勝オッズ帯 (1.0-1.4, 1.5-1.9, ...)

#### 3. **tansho_hensachi_odds_heatmap.png**

単勝回収率ヒートマップ（PNG画像）

- 縦軸: 偏差値ランク (S/A/B/C/D/E)
- 横軸: 単勝オッズ帯
- 色: 回収率 (緑=高回収率、赤=低回収率)
- 数値: 各セルの回収率 (%)

#### 4. **fukusho_hensachi_odds_heatmap.png**

複勝回収率ヒートマップ（PNG画像）

- 単勝ヒートマップと同様の構造

#### 5. **hensachi_odds_matrix_report.md**

総合レポート（Markdown形式）

**内容**:
- 分析期間・対象レース数・対象馬数
- エグゼクティブサマリー
  - 最優秀パターン TOP 5 (単勝・複勝)
  - 非推奨パターン (ROI -20%以下)
- 単勝マトリクス詳細テーブル
- 複勝マトリクス詳細テーブル

---

## 🎯 結果の読み方

### 推奨度の見方

| 推奨度 | ROI範囲 | 意味 |
|--------|---------|------|
| ★★★★★ | +150%以上 | 超高回収率、最優先で購入 |
| ★★★★ | +80% ～ +149% | 高回収率、優先的に購入 |
| ★★★ | +20% ～ +79% | プラス収支、購入推奨 |
| ★★ | 0% ～ +19% | 微プラス、条件次第 |
| ★ | -20% ～ -1% | マイナス小、非推奨 |
| ☆ | -20%以下 | 大幅マイナス、購入禁止 |

### 期待される結果パターン

#### 単勝（想定）

- **偏差値S × オッズ5〜20倍**: ROI +100% ～ +150%（★★★★★）
- **偏差値A × オッズ3〜10倍**: ROI +80% ～ +120%（★★★★★）
- **偏差値S × オッズ1〜3倍**: ROI 0% ～ +10%（★★）← 低オッズ本命は回収率低い

#### 複勝（想定）

- **偏差値S × オッズ5〜20倍**: ROI +200% ～ +300%（★★★★★）
- **偏差値A〜B × オッズ3〜10倍**: ROI +100% ～ +200%（★★★★★）
- **偏差値S × オッズ1〜1.5倍**: ROI 0% ～ +5%（★★）← 超低オッズは非効率

---

## 🔧 トラブルシューティング

### エラー1: `FileNotFoundError: No prediction CSV files found`

**原因**: 2025年1月の予測CSVファイルが存在しない

**解決策**:
```powershell
cd E:\anonymous-keiba-ai-JRA
python batch_predict_2025_monthly.py
# プロンプトで「1」を入力（1月のみ生成）
```

### エラー2: `psycopg2.OperationalError: password authentication failed`

**原因**: データベース接続エラー

**解決策**:
1. PC-KEIBAが起動しているか確認
2. `config\db_config.yaml` のパスワードを確認
3. PostgreSQLサービスが起動しているか確認:
   ```powershell
   Get-Service -Name postgresql*
   ```

### エラー3: `column "kakutei_chakujun" does not exist`

**原因**: テーブル名が間違っている、またはカラム名が異なる

**解決策**:
1. `check_phase2c_data.py` を実行してテーブル構造を確認
2. スクリプトのテーブル名・カラム名を修正

### エラー4: `ModuleNotFoundError: No module named 'seaborn'`

**原因**: 必要なPythonパッケージが不足

**解決策**:
```powershell
pip install seaborn matplotlib
```

---

## 📊 次のステップ

### Phase 2C 完了後のアクション

1. **結果の確認**
   - レポート `hensachi_odds_matrix_report.md` を開く
   - ヒートマップ画像を確認
   - TOP 5パターンを把握

2. **Phase 3 へ反映**
   - 購入推奨ロジックの確立
   - 偏差値1位がオッズ3倍未満 → 見送り
   - 偏差値1位がオッズ5倍以上 → 推奨
   - 偏差値2〜5位でオッズ3〜10倍 → 複勝推奨

3. **Phase 6 へ統合**
   - 日次予測スクリプトに推奨ロジックを追加
   - note/bookers/tweet ファイルに推奨度を追加
   - 注意事項セクションに回収率データを記載

---

## 📝 Git情報

**コミット**: `3fabc1d`  
**ブランチ**: `genspark_ai_developer`  
**PR**: #1 (OPEN) - https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1  
**コミットメッセージ**: `feat: Implement Phase 2C Hensachi x Odds Matrix Analysis`

---

**最終更新**: 2026-03-01 14:30  
**作成者**: anonymous  
**Phase**: Phase 2C  
**Status**: ✅ 実装完了、実行準備完了
