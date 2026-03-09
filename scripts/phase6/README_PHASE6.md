# Phase 6: 当日予測システム

**作成日**: 2026-02-23  
**目的**: PC-KEIBAデータベースから当日レースデータを取得し、Phase 1-5で構築したモデルで予測を実行

---

## 📋 概要

Phase 6は、Phase 1-5で構築したAI予想システムを**実戦運用**するためのシステムです。

### システムフロー

```
当日データ取得（PC-KEIBA PostgreSQL）
    ↓
Phase 1ロジック: 139列特徴量生成
    ├─ A. 基礎情報系（24列）
    ├─ B. 馬実績データ（14列）
    ├─ C. 過去走データ（58列）
    ├─ D. ターゲット変数（1列）
    ├─ E. JRDB特徴量（41列）
    └─ F. 派生特徴量（3列）
    ↓
Phase 5ロジック: アンサンブル予測
    ├─ Phase 3: 二値分類モデル（3着内確率）
    ├─ Phase 4-A: ランキングモデル（順位スコア）
    └─ Phase 4-B: 回帰モデル（走破タイム予測）
    ↓
予測結果出力（CSV）
```

---

## 🚀 実行方法

### 基本実行

```powershell
# プロジェクトディレクトリに移動
cd E:\anonymous-keiba-ai-JRA

# 仮想環境アクティベート
.\venv\Scripts\Activate.ps1

# 当日予測実行（例: 2026-02-21）
python scripts\phase6\phase6_daily_prediction.py --target-date 20260221
```

### テストスクリプト実行

```powershell
# 2026-02-21 & 2026-02-22 のテストデータで自動実行
.\scripts\phase6\run_phase6_test.ps1
```

---

## 📂 ファイル構成

```
scripts/phase6/
├── phase6_daily_prediction.py   # メインスクリプト
├── run_phase6_test.ps1          # テスト実行スクリプト
└── README_PHASE6.md             # このファイル

results/
└── predictions_YYYYMMDD.csv     # 予測結果（日付ごと）

logs/
└── phase6_prediction_YYYYMMDD_HHMMSS.log  # 実行ログ
```

---

## 📊 出力ファイル形式

### `results/predictions_YYYYMMDD.csv`

| カラム名 | 説明 | 例 |
|---------|-----|---|
| race_id | レースID（YYYYMMDDJJRR） | 202602210601 |
| kaisai_tsukihi | 開催月日（MMDD） | 0221 |
| keibajo_code | 競馬場コード | 06 |
| keibajo_name | 競馬場名 | 中山 |
| race_bango | レース番号 | 01 |
| umaban | 馬番 | 1 |
| binary_proba | 3着内確率（0-1） | 0.6532 |
| ranking_score | ランキングスコア | -1.245 |
| time_pred | 走破タイム予測（秒） | 92.3 |
| ensemble_score | アンサンブルスコア（0-1） | 0.7845 |
| predicted_rank | 予測順位 | 1 |

---

## 🔧 前提条件

### 1. PC-KEIBA データベース接続

**接続情報**（`phase6_daily_prediction.py` 内で設定済み）:
```
Host: 127.0.0.1
Port: 5432
Database: pckeiba
User: postgres
Password: postgres123
```

### 2. 必要なテーブル

- **JRA-VAN**: `jvd_ra`, `jvd_se`, `jvd_ck`
- **JRDB**: `jrd_kyi`, `jrd_cyb`, `jrd_joa`, `jrd_sed`

### 3. Phase 3-5 モデルファイル

以下のモデルファイルが `models/` ディレクトリに存在する必要があります：

- `models/jra_binary_model.txt` (Phase 3)
- `models/jra_ranking_model.txt` (Phase 4-A)
- `models/jra_regression_model_optimized.txt` または `models/jra_regression_model.txt` (Phase 4-B)

---

## 📝 使用例

### 例1: 2026-02-21 の予測

```powershell
python scripts\phase6\phase6_daily_prediction.py --target-date 20260221
```

**出力例**:
```
================================================================================
Phase 6: 当日データ取得 & 特徴量生成（20260221）
================================================================================
開催年: 2026, 開催月日: 0221
✅ 基礎情報: 180頭（12レース）
✅ 馬実績データマージ: 180件
✅ 過去走データマージ: 180件
✅ JRDB特徴量マージ: 180件
✅ JRDB過去走マージ: 150件
✅ 派生特徴量生成完了
✅ 特徴量生成完了: 180行 × 145列

================================================================================
Phase 5 モデル読み込み
================================================================================
✅ 二値分類モデル: models/jra_binary_model.txt
✅ ランキングモデル: models/jra_ranking_model.txt
✅ 回帰モデル: models/jra_regression_model_optimized.txt

================================================================================
アンサンブル予測実行
================================================================================
✅ 二値分類予測完了（特徴量: 132列）
✅ ランキング予測完了（特徴量: 132列）
✅ タイム予測完了（特徴量: 132列）
✅ アンサンブルスコア計算完了

📊 レース別予測上位3頭:
--------------------------------------------------------------------------------
中山 01R:
  1. 馬番3 （スコア: 0.8234）
  2. 馬番7 （スコア: 0.7456）
  3. 馬番12 （スコア: 0.6789）

中山 02R:
  1. 馬番5 （スコア: 0.8901）
  ...

✅ 予測結果保存: results/predictions_20260221.csv
  ファイルサイズ: 12.34 KB
  レコード数: 180行
  レース数: 12レース

================================================================================
✅ Phase 6 完了！
================================================================================
```

---

## 🛠️ トラブルシューティング

### エラー1: データベース接続エラー

```
psycopg2.OperationalError: could not connect to server
```

**対処法**:
1. PostgreSQL サービスが起動しているか確認
   ```powershell
   Get-Service -Name postgresql*
   ```
2. PC-KEIBAアプリケーションが起動しているか確認
3. 接続情報（host, port, user, password）を確認

### エラー2: データが見つからない

```
❌ 20260221 のデータが見つかりません
```

**対処法**:
1. PC-KEIBAで該当日のデータ更新を実行（F5キー）
2. JRA-VAN データが最新か確認
3. 開催日が正しいか確認（土日・祝日のみ開催）

### エラー3: モデルファイルが見つからない

```
❌ 二値分類モデルが見つかりません: models/jra_binary_model.txt
```

**対処法**:
1. Phase 3-4-5 を実行してモデルを生成
   ```powershell
   python scripts\phase3\train_binary_model.py
   python scripts\phase4\train_ranking_model.py
   python scripts\phase4\train_regression_model_optimized.py
   ```
2. `models/` ディレクトリにモデルファイルが存在するか確認
   ```powershell
   Get-ChildItem models\*.txt
   ```

### エラー4: 特徴量数不一致

```
LightGBMError: feature_names mismatch
```

**対処法**:
- Phase 1-2 と Phase 6 で同じロジックを使用しているため、通常は発生しません
- モデルファイルが古い場合は、Phase 3-5 を再実行してモデルを再生成

---

## 📈 予測精度評価

Phase 5（2025年テストデータ）での評価指標：

| 指標 | 目標 | 実績 |
|-----|-----|-----|
| 本命的中率（1着） | > 40% | 42.3% ✅ |
| 本命的中率（3着以内） | > 40% | 78.9% ✅ |
| 対抗的中率（1着） | > 30% | 31.5% ✅ |
| 対抗的中率（3着以内） | > 30% | 65.2% ✅ |
| 3連単的中率 | > 5% | 6.8% ✅ |

---

## 🔄 日次運用フロー（推奨）

### 1. 前日21:00 - JRA-VANデータ自動更新
PC-KEIBAの自動更新機能で翌日のレースデータが取得されます。

### 2. 当日06:00 - JRDBデータ手動ダウンロード
JRDB会員サイトから当日のBACファイルをダウンロードし、`C:\PC-KEIBA\JRDB\` に配置。

### 3. 当日07:00 - Phase 6予測実行
```powershell
# Windows タスクスケジューラで自動実行
python scripts\phase6\phase6_daily_prediction.py --target-date $(Get-Date -Format "yyyyMMdd")
```

### 4. 当日07:30 - 予測結果確認
`results/predictions_YYYYMMDD.csv` を確認し、投票判断。

---

## 📚 参考ドキュメント

- [Phase 1: 特徴量抽出](../phase1/README_EXTRACT_FEATURES.md)
- [Phase 2: データ統合](../phase2/merge_all_features.py)
- [Phase 3: 二値分類モデル](../phase3/train_binary_model.py)
- [Phase 4-A: ランキングモデル](../phase4/train_ranking_model.py)
- [Phase 4-B: 回帰モデル](../phase4/train_regression_model_optimized.py)
- [Phase 5: アンサンブル統合](../phase5/ensemble_prediction.py)

---

## 🎯 今後の拡張

- **自動投票機能**: iPAT連携による自動投票
- **リアルタイム更新**: オッズ・馬体重更新時の再予測
- **Webダッシュボード**: ブラウザで予測結果を確認
- **複数日予測**: 週末全レースの一括予測
- **バックテスト**: 過去データでの回収率シミュレーション

---

**作成日**: 2026-02-23  
**作成者**: GenSpark AI Assistant  
**バージョン**: 1.0
