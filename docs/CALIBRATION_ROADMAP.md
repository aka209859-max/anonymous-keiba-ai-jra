# JRA競馬予測システム：確率較正（Calibration）実装ロードマップ

## 📋 プロジェクト概要

### 現状の問題
- **症状**：予測スコアが0.85-0.99に極端に集中、大半がSランク判定
- **原因1**：二値分類モデルの確率が過信状態（Overconfidence）
- **原因2**：レース内Min-Max正規化により絶対評価が消失
- **影響**：レース間比較不可、投資判断に使えない

### 解決策
**二段階リキャリブレーション（Two-stage Recalibration）**
1. **メタモデル統合（Stacking）**：3モデル出力 + 差分特徴量 → 絶対的3着以内確率
2. **温度スケーリング（Temperature Scaling）**：過信を補正し真の確率に較正

### 目標
- スコア分布：0.85-0.99 → **0.10-0.90**
- Brier Score：未測定 → **< 0.18**
- Sランク（≥0.85）：5-8頭/レース → **1-2頭/レース**
- レース間の絶対評価を実現

---

## 🗺️ 全体ロードマップ

### Phase 1: 現状分析とベースライン測定 ✅（完了）
**目的**：改修前の状態を定量的に把握

**実施項目**：
- [x] 必要ファイルの存在確認
  - ✅ `models/jra_binary_model_eval.txt` (16.7 MB, 2026-02-22)
  - ✅ `models/jra_regression_model_eval.txt` (9.3 MB, 2026-02-22)
  - ✅ `data/features/all_tracks_2016-2025_features.csv` (337.6 MB)
  - ✅ `results/predictions_20260222.csv` (139.6 KB)
- [ ] スコア分布の測定スクリプト作成
- [ ] Brier Score、Reliability Diagram作成
- [ ] ベースライン指標の記録

**成果物**：
- `scripts/analysis/measure_calibration_baseline.py`
- `results/calibration_analysis/score_distribution_baseline.png`
- `results/calibration_analysis/baseline_metrics.txt`

**所要時間**：1-2時間

---

### Phase 2: 評価用データセットの準備 🔄（次のステップ）
**目的**：較正モデル学習用の2025年データを準備

**実施項目**：
- [ ] 2025年データの抽出
  - 入力：`data/features/all_tracks_2016-2025_features.csv`
  - 出力：`data/evaluation/features_2025_for_calibration.csv`
- [ ] 評価用モデルで2025年を予測
  - 使用モデル：`models/jra_binary_model_eval.txt` (2016-2024学習)
  - 出力：`data/evaluation/predictions_2025_eval_model.csv`
- [ ] 実績データ（actual_top3）の紐付け
  - `kakutei_chakujun <= 3` → `actual_top3 = 1`

**成果物**：
- `scripts/data_preparation/extract_2025_data.py`
- `scripts/evaluation/generate_eval_predictions.py`
- `data/evaluation/features_2025_for_calibration.csv`
- `data/evaluation/predictions_2025_eval_model.csv`

**所要時間**：1-2時間

---

### Phase 3: メタモデル学習と温度パラメータ推定 🔜（Phase 2完了後）
**目的**：較正モデルの構築

#### Step 3-1: メタ特徴量エンジニアリング
**実施項目**：
- [ ] レース内差分特徴量の生成
  ```python
  # 生成する特徴量
  - binary_logit = log(p/(1-p))  # 二値確率の対数オッズ
  - ranking_z                     # ランキングスコアのZスコア
  - time_z                        # タイム予測のZスコア
  - rank_margin_1_2               # 1位と2位のランキング差
  - time_margin_1_2               # 1位と2位のタイム差
  - field_size                    # レース頭数
  ```

#### Step 3-2: メタモデル学習（Stacking）
**実施項目**：
- [ ] ロジスティック回帰でメタモデル学習
  ```python
  from sklearn.linear_model import LogisticRegression
  meta_model = LogisticRegression(max_iter=1000, random_state=42)
  meta_model.fit(X_meta, y_true)
  ```
- [ ] メタモデルの性能評価
  - AUC、Precision、Recall、F1-Score
  - Brier Score（較正前）

#### Step 3-3: 温度パラメータ推定
**実施項目**：
- [ ] 温度スケーリングの最適化
  ```python
  from scipy.optimize import minimize
  
  def temperature_loss(T):
      scaled_logits = logits / T
      scaled_probs = 1 / (1 + np.exp(-scaled_logits))
      return log_loss(y_true, scaled_probs)
  
  res = minimize(temperature_loss, x0=[1.5], bounds=[(1.0, 10.0)])
  optimal_T = res.x[0]
  ```
- [ ] 最適温度の保存

**成果物**：
- `scripts/calibration/train_meta_model.py`
- `models/meta_calibration_model.pkl`
- `models/optimal_temperature.txt`
- `results/calibration_training_report.txt`

**所要時間**：2-3時間

---

### Phase 4: Phase 6スクリプト改修 🔜（Phase 3完了後）
**目的**：日次予測にメタモデル + 温度スケーリングを組み込む

**実施項目**：
- [ ] `scripts/phase6/phase6_daily_prediction.py` の改修
  - 既存のMin-Max正規化を廃止
  - Zスコア標準化を導入
  - メタ特徴量の生成処理を追加
  - メタモデル読み込みと予測
  - 温度スケーリング適用
- [ ] 旧スコア（`ensemble_score_old`）の保存（比較用）
- [ ] 新スコア（`ensemble_score_calibrated`）の生成
- [ ] ランク判定（S/A/B/C/D）の更新

**改修箇所**：
```python
# 改修前（660-670行目）
for race_id, group in result_df.groupby('race_id'):
    group['ranking_norm'] = (score - min) / (max - min)  # Min-Max
    group['ensemble_score'] = 0.30*binary + 0.40*ranking_norm + 0.30*time_norm

# 改修後
for race_id, group in result_df.groupby('race_id'):
    # Zスコア標準化
    group['ranking_z'] = stats.zscore(group['ranking_pred'])
    group['time_z'] = stats.zscore(group['time_pred'])
    
    # メタ特徴量生成
    group['binary_logit'] = np.log(p / (1 - p))
    group['rank_margin_1_2'] = ...
    
    # メタモデル予測
    X_meta = group[['binary_logit', 'ranking_z', 'time_z', ...]].values
    p_meta = meta_model.predict_proba(X_meta)[:, 1]
    
    # 温度スケーリング
    meta_logits = np.log(p_meta / (1 - p_meta))
    scaled_logits = meta_logits / OPTIMAL_T
    group['ensemble_score_calibrated'] = 1 / (1 + np.exp(-scaled_logits))
```

**成果物**：
- 改修版 `scripts/phase6/phase6_daily_prediction.py`
- バックアップ `scripts/phase6/phase6_daily_prediction_v1_backup.py`

**所要時間**：3-4時間

---

### Phase 5: 検証とチューニング 🔜（Phase 4完了後）
**目的**：改修効果の測定と最終調整

#### Step 5-1: 複数日データでの検証
**実施項目**：
- [ ] 2026年2月22日（土）の予測実行
- [ ] 2026年2月23日（日）の予測実行
- [ ] スコア分布の比較
  - 改修前 vs 改修後
  - ヒストグラム、箱ひげ図

#### Step 5-2: キャリブレーション指標の測定
**実施項目**：
- [ ] **Reliability Diagram（信頼性曲線）**
  - 対角線（y=x）への一致度を確認
  - 改修前：対角線より下方に垂れ下がる
  - 改修後：対角線上に整列
- [ ] **Brier Score**
  - 目標：< 0.18
- [ ] **ECE（Expected Calibration Error）**
  - 目標：< 0.08
- [ ] **Log Loss（対数損失）**
  - 改修前後の比較

#### Step 5-3: 精度指標の確認（安全性チェック）
**実施項目**：
- [ ] **AUC**：改修前後で不変を確認
- [ ] **Top-3 Accuracy（的中率）**：改修前後で不変または微増
- [ ] **順位相関（Spearman）**：改修前後で高相関（≥0.95）

#### Step 5-4: 実用性評価
**実施項目**：
- [ ] レース別スコア分布の確認
  - G1レース：スコア高い（0.70-0.90）
  - 未勝利戦：スコア低い（0.30-0.60）
- [ ] Sランク（≥0.85）頭数の確認
  - 目標：1-2頭/レース
- [ ] レース間比較の可否確認
  - 東京1Rと中京1Rで異なるスコア分布

**成果物**：
- `scripts/evaluation/validate_calibration.py`
- `results/calibration_analysis/reliability_diagram_comparison.png`
- `results/calibration_analysis/score_distribution_comparison.png`
- `results/calibration_analysis/calibration_metrics_report.txt`

**所要時間**：4-6時間

---

### Phase 6: ドキュメント化とGitHub更新 🔜（Phase 5完了後）
**目的**：成果の記録とバージョン管理

**実施項目**：
- [ ] キャリブレーション完了レポート作成
  - `docs/CALIBRATION_COMPLETION_REPORT.md`
  - 改修前後の比較表
  - 検証指標の結果
  - Before/After スクリーンショット
- [ ] README更新
  - キャリブレーション機能の追加説明
  - 使用方法ガイド
- [ ] コミット＆PR作成
  - ブランチ：`genspark_ai_developer`
  - コミットメッセージ：`feat(phase6): Implement two-stage calibration (meta-model + temperature scaling) to fix score concentration issue`
- [ ] PR説明の作成
  - 問題の背景
  - 解決策の概要
  - 改修内容の詳細
  - 検証結果のサマリー

**成果物**：
- `docs/CALIBRATION_COMPLETION_REPORT.md`
- 更新版 `README.md`
- GitHub Pull Request

**所要時間**：2-3時間

---

## 📊 成功基準（検証指標）

### 必須達成項目（Phase 5で確認）

| 指標 | 改修前（推定） | 目標値 | 測定方法 |
|------|---------------|--------|---------|
| **スコア分布範囲** | 0.85-0.99 | **0.10-0.90** | ヒストグラム、Percentile |
| **Brier Score** | 0.20-0.25 | **< 0.18** | `sklearn.metrics.brier_score_loss` |
| **ECE** | 0.15-0.25 | **< 0.08** | カスタム実装 |
| **Sランク頭数/レース** | 5-8頭 | **1-2頭** | 集計 |
| **AUC** | 0.75-0.80 | **不変（±0.01）** | `sklearn.metrics.roc_auc_score` |
| **Top-3 Accuracy** | 45-55% | **不変または微増** | カスタム実装 |

### 理想達成項目

| 指標 | 目標 |
|------|------|
| **Reliability Diagram** | 対角線（y=x）に完全整列 |
| **Log Loss** | 改修前より10%以上改善 |
| **レース間比較** | G1と未勝利戦で明確なスコア差 |

---

## 🛠️ 使用技術スタック

### 機械学習ライブラリ
- **scikit-learn**：ロジスティック回帰、較正評価、メトリクス
- **scipy**：温度パラメータ最適化（`minimize`）
- **numpy**：数値計算、ロジット変換
- **pandas**：データ操作

### 可視化
- **matplotlib**：ヒストグラム、Reliability Diagram
- **seaborn**：箱ひげ図、分布図

### モデル保存
- **joblib**：メタモデルのシリアライズ

---

## ⏱️ 総所要時間見積もり

| Phase | 内容 | 所要時間 | 累積時間 |
|-------|------|---------|---------|
| Phase 1 | 現状分析とベースライン測定 | 1-2時間 | 1-2h |
| Phase 2 | 評価用データセット準備 | 1-2時間 | 2-4h |
| Phase 3 | メタモデル学習と温度推定 | 2-3時間 | 4-7h |
| Phase 4 | Phase 6スクリプト改修 | 3-4時間 | 7-11h |
| Phase 5 | 検証とチューニング | 4-6時間 | 11-17h |
| Phase 6 | ドキュメント化とGitHub更新 | 2-3時間 | 13-20h |
| **合計** | | **13-20時間** | **2-3日** |

---

## 📁 プロジェクト構造（改修後）

```
E:\anonymous-keiba-ai-JRA\
├── scripts/
│   ├── phase6/
│   │   ├── phase6_daily_prediction.py                # ★改修対象
│   │   └── phase6_daily_prediction_v1_backup.py      # バックアップ
│   ├── calibration/                                   # ★新規作成
│   │   ├── train_meta_model.py                        # メタモデル学習
│   │   └── optimize_temperature.py                    # 温度推定
│   ├── data_preparation/                              # ★新規作成
│   │   └── extract_2025_data.py                       # 2025年データ抽出
│   ├── evaluation/                                    # ★新規作成
│   │   ├── generate_eval_predictions.py               # 評価用予測
│   │   └── validate_calibration.py                    # 較正検証
│   └── analysis/                                      # ★新規作成
│       └── measure_calibration_baseline.py            # ベースライン測定
│
├── models/
│   ├── jra_binary_model_eval.txt                     # ✅既存
│   ├── jra_regression_model_eval.txt                 # ✅既存
│   ├── meta_calibration_model.pkl                    # ★新規
│   └── optimal_temperature.txt                       # ★新規
│
├── data/
│   ├── features/
│   │   └── all_tracks_2016-2025_features.csv         # ✅既存
│   └── evaluation/                                    # ★新規作成
│       ├── features_2025_for_calibration.csv          # 2025年特徴量
│       └── predictions_2025_eval_model.csv            # 2025年予測結果
│
├── results/
│   ├── predictions_20260222.csv                      # ✅既存
│   └── calibration_analysis/                         # ★新規作成
│       ├── baseline_metrics.txt                       # ベースライン指標
│       ├── score_distribution_baseline.png            # 改修前分布
│       ├── score_distribution_comparison.png          # 改修前後比較
│       ├── reliability_diagram_comparison.png         # 較正曲線比較
│       └── calibration_metrics_report.txt             # 検証結果レポート
│
└── docs/
    ├── CALIBRATION_ROADMAP.md                        # ★本ドキュメント
    └── CALIBRATION_COMPLETION_REPORT.md              # ★完了レポート（Phase 6作成）
```

---

## 🚀 次のアクション

### 即座実行（Phase 1開始）

```powershell
# PowerShell（ローカル環境）
cd E:\anonymous-keiba-ai-JRA

# Phase 1のスクリプト作成を待つ
# サンドボックスでスクリプト作成 → GitHubにコミット → ローカルでpull実行
```

---

## 📝 備考

### リスク管理
- **既存精度への影響**：温度スケーリングは順序を保存するため、AUC・的中率は不変
- **計算コスト**：メタモデルはロジスティック回帰（高速）、温度スケーリングは単純演算
- **ロールバック**：改修前のスクリプトをバックアップ、いつでも元に戻せる

### 参考文献
- Temperature Scaling: "On Calibration of Modern Neural Networks" (Guo et al., 2017)
- Platt Scaling: "Probabilistic Outputs for Support Vector Machines" (Platt, 1999)
- Stacking: "Stacked Generalization" (Wolpert, 1992)
- Brier Score: "Verification of Forecasts Expressed in Terms of Probability" (Brier, 1950)

---

**作成日**：2026-02-25  
**バージョン**：1.0  
**作成者**：GenSpark AI Developer  
**最終更新**：2026-02-25
