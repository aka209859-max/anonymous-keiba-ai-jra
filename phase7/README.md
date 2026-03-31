# Phase 7 - 中央競馬回収率特化システム（ROI 100%超目標）

**プロジェクト期間**: 2026年3月 ~ 2026年6月（15週間）  
**最終更新**: 2026-03-03  
**GitHub Repository**: [anonymous-keiba-ai-jra](https://github.com/aka209859-max/anonymous-keiba-ai-jra)

---

## 🎯 プロジェクト目標

**年間ROI 100%超を達成**し、実運用可能な回収率特化システムを構築する。

### 目標指標

| 指標 | 目標値 | 備考 |
|------|--------|------|
| **年間ROI** | ≥ 105% | 目標レンジ: 105~120% |
| **Sharpe Ratio** | ≥ 1.5 | リスク調整後リターン |
| **最大ドローダウン** | < 30% | 資産減少許容範囲 |
| **的中率** | ≥ 15% | 三連複ベース |
| **平均払戻倍率** | ≥ 5.0倍 | 高配当狙い |

---

## 📊 データソース

### 統合データ基盤

```
JRA-VAN: 139次元（既存）
    ↓
  統合
    ↓
JRDB:   約70次元（新規）
    ↓
合計:   約220次元
```

### データ期間
- **訓練データ**: 2016年1月 ~ 2024年12月
- **バックテストデータ**: 2025年1月 ~ 2025年12月
- **使用情報**: **前日情報のみ**（当日リアルタイムデータ不使用）

---

## 📁 ディレクトリ構成

```
phase7/
├── README.md                          # このファイル
├── docs/                              # ドキュメント
│   ├── 00_overview/                   # プロジェクト概要
│   │   ├── PHASE7_STRATEGY.md         # 戦略骨組み（最終版）
│   │   └── README.md                  # Phase 7 概要説明
│   ├── 01_workflow/                   # 実装フロー
│   │   └── PHASE7_WORKFLOW.md         # 15週間実装フロー
│   ├── 02_roadmap/                    # ロードマップ
│   │   └── PHASE7_ROADMAP.md          # 週次ロードマップ
│   ├── 03_architecture/               # アーキテクチャ設計
│   ├── 04_operation/                  # 運用マニュアル
│   ├── 05_performance/                # パフォーマンスレポート
│   └── 06_retraining/                 # 再学習ガイド
│
├── scripts/                           # 実装スクリプト
│   ├── phase7a_feature_expansion/     # Phase 7-A: 特徴量拡張
│   ├── phase7b_factor_roi/            # Phase 7-B: ファクターROI分析
│   ├── phase7c_2factor_combination/   # Phase 7-C: 2ファクター組み合わせ
│   ├── phase7d_3factor_ga/            # Phase 7-D: 3ファクターGA探索
│   ├── phase7e_4to5factor/            # Phase 7-E: 4-5ファクタービームサーチ
│   ├── phase7f_combo_features/        # Phase 7-F: 組み合わせ特徴量生成
│   ├── phase7g_roi_model/             # Phase 7-G: ROI特化モデル構築
│   ├── phase7h_backtest/              # Phase 7-H: バックテスト
│   ├── phase7i_daily_prediction/      # Phase 7-I: 日次予測システム
│   └── utils/                         # 共通ユーティリティ
│
├── models/                            # 訓練済みモデル
│   ├── lightgbm/                      # LightGBM ROI特化モデル
│   ├── benter/                        # Benter統合モデル
│   └── ensemble/                      # アンサンブル設定
│
├── results/                           # 実行結果
│   ├── phase7a_features/              # 特徴量マスターファイル
│   ├── phase7b_factor_roi/            # ファクターROI分析結果
│   ├── phase7c_2factor/               # 2ファクター組み合わせ結果
│   ├── phase7d_3factor_ga/            # 3ファクターGA結果
│   ├── phase7e_4to5factor/            # 4-5ファクター結果
│   ├── phase7f_features/              # 組み合わせ特徴量定義
│   ├── phase7g_models/                # モデル訓練結果
│   ├── phase7h_backtest/              # バックテスト結果
│   └── phase7i_predictions/           # 日次予測結果
│
├── data/                              # データディレクトリ
│   ├── jra_van/                       # JRA-VANデータ
│   └── jrdb/                          # JRDBデータ
│
├── config/                            # 設定ファイル
│   ├── phase7_config.yaml             # Phase 7全体設定
│   └── factor_definitions.yaml        # ファクター定義
│
├── logs/                              # ログファイル
│
└── notebooks/                         # 分析ノートブック
    ├── exploratory/                   # 探索的分析
    └── visualization/                 # 可視化
```

---

## 📅 15週間実装スケジュール

| 週 | フェーズ | 内容 | 主要成果物 |
|----|---------|------|-----------|
| **Week 1** | **Phase 7-A** | 特徴量拡張<br>JRA-VAN + JRDB統合 | combined_features_master.csv<br>cross_source_feature_candidates.csv |
| **Week 2-3** | **Phase 7-B** | ファクターROI分析<br>全220ファクターのROI計算 | factor_ranking_report.txt<br>factor_single_roi_analysis.csv |
| **Week 4-5** | **Phase 7-C** | 2ファクター組み合わせ<br>24,090通り全探索 | high_improvement_combinations.csv<br>cross_source_high_roi_combinations.csv |
| **Week 6-7** | **Phase 7-D** | 3ファクターGA探索<br>約170万通りGA探索 | ga_3factors_best50.csv<br>ga_3factors_convergence.csv |
| **Week 8** | **Phase 7-E** | 4-5ファクター探索<br>ビームサーチ | combination_4to5factors.csv |
| **Week 9** | **Phase 7-F** | 組み合わせ特徴量生成<br>50-100特徴量追加 | generate_combination_features.py<br>combination_feature_definitions.csv |
| **Week 10-11** | **Phase 7-G** | ROI特化モデル構築<br>LightGBM + Benter | phase7_lightgbm_model.txt<br>feature_importance.csv |
| **Week 12-13** | **Phase 7-H** | バックテスト<br>2025年データで検証 | backtest_metrics.csv<br>backtest_transaction_log.csv |
| **Week 14** | **Phase 7-I** | 日次予測システム<br>前日情報ベース予測 | daily_phase7_prediction.py<br>prediction_YYYYMMDD.txt/csv |
| **Week 15** | **Phase 7-J** | ドキュメント整備<br>運用マニュアル作成 | PHASE7_ARCHITECTURE.md<br>PHASE7_OPERATION_MANUAL.md |

---

## 🔬 Phase 7の技術的特徴

### 1. クロスソース統合
```
JRA-VAN（質的データ） × JRDB（定量評価）
= 相補的情報による相乗効果
```

### 2. ファクターROI厳選
- **生の回収率100%を基準**（補正なし）
- S ≥ 110%, A 100-110%, B 90-100%, C < 90%
- **Cランクも保持**（組み合わせで救済）

### 3. 組み合わせ最適化
- **2ファクター**: 全探索（24,090通り）
- **3ファクター**: GA探索（約170万通り探索空間）
- **4-5ファクター**: ビームサーチ（上位から拡張）

### 4. ROI直接最適化
```python
カスタム損失関数: -(勝率 × オッズ - 1)
```

### 5. Benterモデル統合
```
最終確率 = 0.7 × Phase7予測 + 0.3 × 市場確率（前日オッズ）
```

---

## 📖 関連ドキュメント

### 📋 Phase 7 コアドキュメント
1. **[PHASE7_STRATEGY.md](docs/00_overview/PHASE7_STRATEGY.md)** - 戦略骨組み（最終版）
2. **[PHASE7_WORKFLOW.md](docs/01_workflow/PHASE7_WORKFLOW.md)** - 15週間実装フロー
3. **[PHASE7_ROADMAP.md](docs/02_roadmap/PHASE7_ROADMAP.md)** - 週次ロードマップ

### 🔗 Phase 1-6 参照ドキュメント
- **Phase 1-6 実装記録**: `../docs/phase1-6/`
- **JRDB統合ガイド**: `../docs/jrdb/`

---

## 🚀 Phase 7 開始前のチェックリスト

### ✅ 必須確認事項

- [ ] **JRDBデータの現状確認**
  - [ ] データ保有形式（DB? CSV?）
  - [ ] データ範囲（2016~2025年揃っているか？）
  - [ ] 取得方法（API? 手動?）
  - [ ] 共通キーの一致確認（race_date, track_code, race_no, horse_no）

- [ ] **既存リポジトリ整理完了**
  - [x] Phase 1~6のドキュメント整備
  - [x] 不要ファイル削除
  - [x] Phase 7ディレクトリ構造作成

- [ ] **開発環境準備**
  - [ ] DEAP（遺伝的アルゴリズム）インストール確認
  - [ ] multiprocessing 動作確認（並列処理用）
  - [ ] ディスク容量確認（CSV大量出力用）

---

## 📊 Phase 7 vs Phase 6 vs 卍氏 比較

| 項目 | 卍氏 | Phase 6 | Phase 7（目標） |
|------|------|---------|----------------|
| **データソース** | JRA-VAN | JRA-VAN | JRA-VAN + JRDB |
| **ファクター数** | 45種類 | 139次元 | 220 + 組合せ(270~320次元) |
| **組み合わせ探索** | 手動 | なし | ✅ GA自動（170万通り） |
| **ROI基準** | 指数100 | なし | ✅ 生ROI 100% |
| **ML活用** | なし | 3モデル | ROI特化LightGBM |
| **前日情報のみ** | ✅ | ✅ | ✅ |
| **実績/目標ROI** | 86~87% | 85~95% | **105~120%** |
| **資金管理** | PAT×8% | なし | PAT×8% vs Kelly比較 |

---

## 📝 更新履歴

- **2026-03-03**: Phase 7ディレクトリ構造作成、README作成
- **2026-03-02**: Phase 7戦略ドキュメント作成完了（GitHub commit 7dbf730）

---

## 📞 お問い合わせ

Phase 7実装に関する質問や提案は、GitHubリポジトリのIssuesでお願いします。

---

**次のアクション**: Week 1 - Phase 7-A（特徴量拡張）の開始準備 🚀
