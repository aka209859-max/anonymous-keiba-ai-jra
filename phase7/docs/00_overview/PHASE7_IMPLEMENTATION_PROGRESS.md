# Phase 7 実装進捗管理

**作成日**: 2026-03-03  
**最終更新**: 2026-03-03  
**プロジェクト期間**: 2026年3月 ~ 2026年6月（15週間）

---

## 📊 全体進捗サマリー

| フェーズ | 状態 | 進捗率 | 予定完了日 | 実際完了日 |
|---------|------|--------|-----------|-----------|
| **Phase 7-A** | 🟡 準備中 | 0% | Week 1 | - |
| **Phase 7-B** | ⚪ 未着手 | 0% | Week 2-3 | - |
| **Phase 7-C** | ⚪ 未着手 | 0% | Week 4-5 | - |
| **Phase 7-D** | ⚪ 未着手 | 0% | Week 6-7 | - |
| **Phase 7-E** | ⚪ 未着手 | 0% | Week 8 | - |
| **Phase 7-F** | ⚪ 未着手 | 0% | Week 9 | - |
| **Phase 7-G** | ⚪ 未着手 | 0% | Week 10-11 | - |
| **Phase 7-H** | ⚪ 未着手 | 0% | Week 12-13 | - |
| **Phase 7-I** | ⚪ 未着手 | 0% | Week 14 | - |
| **Phase 7-J** | ⚪ 未着手 | 0% | Week 15 | - |

**全体進捗**: 0% (0 / 10 フェーズ完了)

---

## 📋 Phase 7-A: 特徴量拡張（Week 1）

### 🎯 目標
JRA-VAN 139次元 + JRDB 60~80次元 = **220次元基盤** の構築

### ✅ タスクリスト

#### 1. データソース確認
- [ ] JRA-VANデータ現状確認
  - [ ] データ保有形式（DB? CSV?）
  - [ ] データ範囲（2016~2025年）
  - [ ] テーブル構造確認
  - [ ] 139次元の詳細リスト作成
  
- [ ] JRDBデータ現状確認
  - [ ] データ保有形式（DB? CSV?）
  - [ ] データ範囲（2016~2025年）
  - [ ] 利用可能ファイル確認
  - [ ] 60~80次元の候補リスト作成

#### 2. 特徴量マスター作成
- [ ] `jravan_available_features.csv` 作成
  - [ ] カラム: feature_id, feature_name, data_type, table_name, description
  - [ ] JRA-VAN 139次元の完全リスト
  
- [ ] `jrdb_available_features.csv` 作成
  - [ ] カラム: feature_id, feature_name, data_type, file_name, description
  - [ ] JRDB 60~80次元の完全リスト

- [ ] `combined_features_master.csv` 作成
  - [ ] JRA-VAN + JRDB 統合
  - [ ] 重複チェック
  - [ ] データ型統一

#### 3. クロスソース候補生成
- [ ] `cross_source_feature_candidates.csv` 作成
  - [ ] JRA-VAN × JRDB の組み合わせ候補
  - [ ] 期待される相乗効果の記述
  - [ ] 優先度付け

#### 4. データ結合検証
- [ ] SQL結合クエリ作成
  - [ ] race_date, track_code, race_no, horse_no でのJOIN
  - [ ] 結合成功率確認（目標: ≥ 95%）
  
- [ ] サンプルデータ作成
  - [ ] 2024年データで結合テスト
  - [ ] 欠損値パターン分析

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `jravan_available_features.csv` | `phase7/results/phase7a_features/` | ⚪ 未作成 | 139次元リスト |
| `jrdb_available_features.csv` | `phase7/results/phase7a_features/` | ⚪ 未作成 | 60~80次元リスト |
| `combined_features_master.csv` | `phase7/results/phase7a_features/` | ⚪ 未作成 | 220次元統合マスター |
| `cross_source_feature_candidates.csv` | `phase7/results/phase7a_features/` | ⚪ 未作成 | クロスソース候補 |

### 🚧 ブロッカー・課題
- なし（準備中）

### 📅 進捗履歴
- **2026-03-03**: Phase 7-A タスクリスト作成

---

## 📋 Phase 7-B: ファクターROI分析（Week 2-3）

### 🎯 目標
全220ファクターの単体ROIを計算し、S/A/B/Cランクに分類

### ✅ タスクリスト

#### 1. ROI計算スクリプト作成
- [ ] `calculate_factor_roi.py` 作成
  - [ ] 2016~2025年データ読み込み
  - [ ] ファクターごとの条件分岐（上位20%など）
  - [ ] 生ROI計算: (的中率 × 平均オッズ) × 100
  
#### 2. 全ファクターROI計算
- [ ] 並列処理実装（multiprocessing）
- [ ] 220ファクター全計算
- [ ] 進捗ログ出力

#### 3. ランク分類
- [ ] Sランク（ROI ≥ 110%）: 10~20個想定
- [ ] Aランク（ROI 100~110%）: 20~40個想定
- [ ] Bランク（ROI 90~100%）: 50~80個想定
- [ ] Cランク（ROI < 90%）: 50~100個想定

#### 4. レポート生成
- [ ] `factor_ranking_report.txt` 作成
  - [ ] ランクごとのサマリー
  - [ ] トップ10ファクター詳細
  
- [ ] `factor_ranking_data.csv` 作成
  - [ ] 全220ファクターの詳細データ

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `factor_single_roi_analysis.csv` | `phase7/results/phase7b_factor_roi/` | ⚪ 未作成 | 全ファクターROI詳細 |
| `factor_ranking_report.txt` | `phase7/results/phase7b_factor_roi/` | ⚪ 未作成 | ランク別サマリー |
| `factor_ranking_data.csv` | `phase7/results/phase7b_factor_roi/` | ⚪ 未作成 | ランク付きデータ |
| `factor_roi_summary.txt` | `phase7/results/phase7b_factor_roi/` | ⚪ 未作成 | 実行サマリー |

### 🚧 ブロッカー・課題
- Phase 7-A完了が前提

---

## 📋 Phase 7-C: 2ファクター組み合わせ（Week 4-5）

### 🎯 目標
C(220,2) = 24,090通りの組み合わせROIを計算

### ✅ タスクリスト

- [ ] 全探索スクリプト作成
- [ ] 並列処理実装（8コア想定）
- [ ] 高ROI組み合わせ抽出（ROI ≥ 100%, 改善 ≥ 15%）
- [ ] クロスソース組み合わせ特別抽出

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `combination_2factors_roi.csv` | `phase7/results/phase7c_2factor/` | ⚪ 未作成 | 24,090通り全結果 |
| `high_improvement_combinations.csv` | `phase7/results/phase7c_2factor/` | ⚪ 未作成 | トップ100組み合わせ |
| `cross_source_high_roi_combinations.csv` | `phase7/results/phase7c_2factor/` | ⚪ 未作成 | クロスソース限定 |
| `combination_2factors_report.txt` | `phase7/results/phase7c_2factor/` | ⚪ 未作成 | 実行サマリー |

### 🚧 ブロッカー・課題
- Phase 7-B完了が前提

---

## 📋 Phase 7-D: 3ファクターGA探索（Week 6-7）

### 🎯 目標
GA（遺伝的アルゴリズム）で約170万通りの探索空間から最適な3ファクター組み合わせを発見

### ✅ タスクリスト

- [ ] DEAP（遺伝的アルゴリズムライブラリ）セットアップ
- [ ] GAパラメータ設定
  - [ ] Population: 300
  - [ ] Generations: 150
  - [ ] Crossover rate: 0.7
  - [ ] Mutation rate: 0.2
- [ ] 適応度関数実装（ROI最大化）
- [ ] 制約条件実装（サンプル数 ≥ 50）
- [ ] GA実行（収束ログ記録）
- [ ] トップ50抽出（ROI ≥ 105%）

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `ga_3factors_log.txt` | `phase7/results/phase7d_3factor_ga/` | ⚪ 未作成 | GA実行ログ |
| `ga_3factors_convergence.csv` | `phase7/results/phase7d_3factor_ga/` | ⚪ 未作成 | 世代ごとの収束データ |
| `ga_3factors_best50.csv` | `phase7/results/phase7d_3factor_ga/` | ⚪ 未作成 | トップ50組み合わせ |
| `combination_3factors_report.txt` | `phase7/results/phase7d_3factor_ga/` | ⚪ 未作成 | 実行サマリー |

### 🚧 ブロッカー・課題
- Phase 7-C完了が前提

---

## 📋 Phase 7-E: 4-5ファクタービームサーチ（Week 8）【オプション】

### 🎯 目標
トップ20の3ファクター組み合わせを4-5ファクターに拡張（目標ROI > 110%）

### ✅ タスクリスト

- [ ] ビームサーチアルゴリズム実装
- [ ] ビーム幅: 30
- [ ] 4ファクター探索
- [ ] 5ファクター探索（オプション）

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `combination_4to5factors.csv` | `phase7/results/phase7e_4to5factor/` | ⚪ 未作成 | 4-5ファクター結果 |
| `combination_4to5factors_report.txt` | `phase7/results/phase7e_4to5factor/` | ⚪ 未作成 | 実行サマリー |

### 🚧 ブロッカー・課題
- Phase 7-D完了が前提
- **オプション**: ROI目標未達の場合スキップ可能

---

## 📋 Phase 7-F: 組み合わせ特徴量生成（Week 9）

### 🎯 目標
高ROI組み合わせを新特徴量として明示化（50~100個追加）

### ✅ タスクリスト

- [ ] 組み合わせ特徴量定義
  - [ ] 2ファクターから30~50個
  - [ ] 3ファクターから20~30個
  - [ ] 4-5ファクターから5~10個
  
- [ ] `generate_combination_features.py` 作成
  - [ ] 条件分岐ロジック実装
  - [ ] バリデーション機能
  
- [ ] 特徴量定義CSV作成
- [ ] 全データ（2016~2025年）への適用

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `combination_feature_definitions.csv` | `phase7/results/phase7f_features/` | ⚪ 未作成 | 50~100特徴量定義 |
| `generate_combination_features.py` | `phase7/scripts/phase7f_combo_features/` | ⚪ 未作成 | 特徴量生成スクリプト |

### 🚧 ブロッカー・課題
- Phase 7-C, D, E の結果が必要

---

## 📋 Phase 7-G: ROI特化モデル構築（Week 10-11）

### 🎯 目標
LightGBM ROI特化モデル + Benter統合のアンサンブル構築

### ✅ タスクリスト

#### 1. LightGBM ROI特化モデル
- [ ] カスタム損失関数実装
  - [ ] `loss = -(win_rate × odds - 1)`
- [ ] ハイパーパラメータチューニング
- [ ] Walk-forward検証
- [ ] Early Stopping実装

#### 2. Benter統合モデル（オプション）
- [ ] α=0.7, β=0.3 設定
- [ ] 前日オッズ統合
- [ ] 効果検証（+5~10% ROI改善目標）

#### 3. アンサンブル設定
- [ ] LightGBM 60% + Benter 40%
- [ ] 最終予測確率計算
- [ ] 期待ROI計算

#### 4. 特徴量重要度分析
- [ ] SHAP値計算
- [ ] トップ50特徴量可視化

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `phase7_lightgbm_model.txt` | `phase7/models/lightgbm/` | ⚪ 未作成 | LightGBMモデル |
| `phase7_benter_model.txt` | `phase7/models/benter/` | ⚪ 未作成 | Benterパラメータ |
| `phase7_ensemble_weights.csv` | `phase7/models/ensemble/` | ⚪ 未作成 | アンサンブル重み |
| `feature_importance.csv` | `phase7/results/phase7g_models/` | ⚪ 未作成 | 特徴量重要度 |
| `training_log.txt` | `phase7/results/phase7g_models/` | ⚪ 未作成 | 訓練ログ |

### 🚧 ブロッカー・課題
- Phase 7-F完了が前提

---

## 📋 Phase 7-H: バックテスト（Week 12-13）

### 🎯 目標
2025年データでバックテスト実施、年間ROI ≥ 105% 達成確認

### ✅ タスクリスト

#### 1. 資金管理方式実装
- [ ] PAT残高 × 8% 方式
- [ ] Fractional Kelly (係数0.25) 方式
- [ ] 比較分析

#### 2. バックテスト実行
- [ ] 2025年1月~12月 全レース
- [ ] 取引ログ記録（全レコード）
- [ ] 日次・月次集計

#### 3. 評価指標計算
- [ ] 年間ROI
- [ ] Sharpe Ratio
- [ ] 最大ドローダウン
- [ ] 的中率
- [ ] 平均払戻倍率
- [ ] 月次ROI推移

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `backtest_metrics.csv` | `phase7/results/phase7h_backtest/` | ⚪ 未作成 | 評価指標サマリー |
| `money_management_comparison.txt` | `phase7/results/phase7h_backtest/` | ⚪ 未作成 | PAT vs Kelly比較 |
| `money_management_comparison.csv` | `phase7/results/phase7h_backtest/` | ⚪ 未作成 | 比較詳細データ |
| `backtest_transaction_log.csv` | `phase7/results/phase7h_backtest/` | ⚪ 未作成 | 全取引ログ |

### 🚧 ブロッカー・課題
- Phase 7-G完了が前提
- **重要**: ROI ≥ 105% 未達の場合、Phase 7-Gに戻り再調整

---

## 📋 Phase 7-I: 日次予測システム（Week 14）

### 🎯 目標
前日情報のみを使用した日次予測スクリプト作成

### ✅ タスクリスト

#### 1. 日次予測スクリプト
- [ ] `daily_phase7_prediction.py` 作成
  - [ ] JRA-VAN + JRDB データ取得
  - [ ] 220次元基礎特徴量計算
  - [ ] 50~100次元組み合わせ特徴量生成
  - [ ] Phase 7モデル予測
  - [ ] 期待ROI ≥ 100% フィルタ

#### 2. 出力フォーマット実装
- [ ] Note形式（TXT）
- [ ] ブッカーズ形式（TXT）
- [ ] Twitter形式（TXT）
- [ ] CSV形式（詳細データ）

#### 3. 運用フロー確認
- [ ] 毎日21時実行想定
- [ ] エラーハンドリング
- [ ] ログ記録

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `daily_phase7_prediction.py` | `phase7/scripts/phase7i_daily_prediction/` | ⚪ 未作成 | 日次予測スクリプト |
| `prediction_YYYYMMDD_racecourse.txt` | `phase7/results/phase7i_predictions/` | ⚪ 未作成 | TXT形式出力例 |
| `prediction_YYYYMMDD_racecourse.csv` | `phase7/results/phase7i_predictions/` | ⚪ 未作成 | CSV形式出力例 |

### 🚧 ブロッカー・課題
- Phase 7-H完了が前提

---

## 📋 Phase 7-J: ドキュメント整備（Week 15）

### 🎯 目標
Phase 7の完全なドキュメントセット作成

### ✅ タスクリスト

- [ ] **PHASE7_ARCHITECTURE.md** 作成
  - [ ] システム全体設計
  - [ ] データフロー図
  - [ ] モデルアーキテクチャ
  
- [ ] **PHASE7_OPERATION_MANUAL.md** 作成
  - [ ] 日次予測の実行手順
  - [ ] トラブルシューティング
  - [ ] FAQ
  
- [ ] **PHASE7_PERFORMANCE_REPORT.md** 作成
  - [ ] バックテスト結果サマリー
  - [ ] Phase 6 / 卍氏との比較
  - [ ] 特徴量重要度分析
  
- [ ] **PHASE7_RETRAINING_GUIDE.md** 作成
  - [ ] モデル再学習手順
  - [ ] データ更新方法
  - [ ] パラメータ調整ガイド

### 📦 成果物（Deliverables）

| ファイル名 | 保存先 | 状態 | 備考 |
|-----------|--------|------|------|
| `PHASE7_ARCHITECTURE.md` | `phase7/docs/03_architecture/` | ⚪ 未作成 | アーキテクチャドキュメント |
| `PHASE7_OPERATION_MANUAL.md` | `phase7/docs/04_operation/` | ⚪ 未作成 | 運用マニュアル |
| `PHASE7_PERFORMANCE_REPORT.md` | `phase7/docs/05_performance/` | ⚪ 未作成 | パフォーマンスレポート |
| `PHASE7_RETRAINING_GUIDE.md` | `phase7/docs/06_retraining/` | ⚪ 未作成 | 再学習ガイド |

### 🚧 ブロッカー・課題
- 全Phase完了が前提

---

## 📊 成功基準（Success Criteria）

### ✅ Must（必須）
- [ ] **年間ROI ≥ 105%**（2025年バックテスト）
- [ ] **最大ドローダウン < 30%**
- [ ] **全成果物（約40ファイル）納品完了**
- [ ] **運用マニュアル完成**

### 🎯 Should（推奨）
- [ ] **Sharpe Ratio ≥ 1.5**
- [ ] **クロスソースROI ≥ 110% の組み合わせ発見**
- [ ] **Phase 6との比較レポート作成**

### 💡 Could（オプション）
- [ ] **4-5ファクター組み合わせ発見（Phase 7-E）**
- [ ] **Benter統合による+5~10% ROI改善**
- [ ] **WebUI作成（Phase 8へ）**

---

## 📝 更新履歴

- **2026-03-03**: Phase 7実装進捗管理ドキュメント作成

---

**次のアクション**: Phase 7-A（Week 1）開始 - JRDBデータ現状確認 🚀
