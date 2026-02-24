# JRA中央競馬AI予測モデル

**プロジェクト名**: anonymous競馬AIシステム - JRA中央競馬AI  
**バージョン**: 1.0  
**作成日**: 2026-02-19  
**開発方式**: AI（スクリプト作成） + ユーザー（ローカルPC実行）

---

## 🎯 プロジェクト概要

JRA中央競馬の3着以内（馬連圏内）を予測するAIモデルを構築するプロジェクトです。

### システム構成

- **対象**: JRA中央競馬（10競馬場）
- **競馬場コード**: 11パターン（札幌〜阪神＋小倉夏・小倉冬）
  * 01: 札幌（夏季）
  * 02: 函館（夏季）
  * 03: 福島（春・夏）
  * 04: 新潟（夏季）
  * 05: 東京（通年）
  * 06: 中山（通年）
  * 07: 中京（通年）
  * 08: 京都（春・秋）
  * 09: 阪神（通年）
  * 10_summer: 小倉（夏季：7〜8月）
  * 10_winter: 小倉（冬季：1〜2月）

- **総特徴量**: 148カラム
  * JRA-VAN: 97カラム（基礎24 + 馬実績14 + 過去走58 + ターゲット1）
  * JRDB: 48カラム（予測指数13 + 調教5 + 適性6 + 展開2 + ランク6 + CID7 + 調教B2 + 過去走7）
  * 派生: 3カラム（距離変化関連）

- **総次元数**: 11 × 148 = 1,628次元

- **学習手法**: LightGBM + Boruta + Optuna

- **開発フロー**: Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 4 → Phase 5

---

## 📚 必読ドキュメント（重要度順）

1. **JRA_DEVELOPMENT_FLOW.md** ⭐最最重要⭐
   - AI/ユーザーの役割分担を明記
   - Phase 0〜5の詳細フロー
   - 各Phaseの「AIの作業」と「ユーザーの作業」

2. **INTEGRATED_FEATURE_SPECIFICATION_FINAL.md** ⭐最重要⭐
   - 統合特徴量仕様（148カラムの完全定義）
   - データソース別の特徴量内訳
   - 実装ガイド、SQL例

3. **PHASE0_SETUP_MANUAL_WINDOWS.md**
   - Phase 0（環境構築）の手順書
   - Windows環境向け

4. **jra_context_protocol_v3.md**
   - コンテキスト維持プロトコル（v3.0）
   - セッション開始/終了時の手順

5. **SETUP_MANUAL_PHASE_0_TO_5.md**
   - Phase 0〜5のスクリプト作成ガイド
   - 各Phaseのスクリプト例

6. **OPTIMAL_PAST_RACE_FEATURES_FINAL.md**
   - 過去走データ設計（パターンC+）
   - 3層構造（高解像度・低解像度・コンテキスト）

---

## 🚀 クイックスタート

### Phase 0: 環境構築

```powershell
# 1. プロジェクトディレクトリに移動
cd E:\anonymous-keiba-ai-JRA

# 2. Python仮想環境作成・有効化
python -m venv venv
.\venv\Scripts\Activate.ps1

# 3. 必須ライブラリインストール
pip install -r requirements.txt

# 4. DB設定ファイル編集
notepad config\db_config.yaml
# ★パスワードなどを実際の環境に合わせて編集★

# 5. DB接続確認
python scripts\phase0_setup.py
```

詳細は `PHASE0_SETUP_MANUAL_WINDOWS.md` を参照。

---

## 📁 ディレクトリ構造

```
E:\anonymous-keiba-ai-JRA\
├── config/                  # 設定ファイル
│   ├── db_config.yaml       # DB接続設定
│   ├── feature_config.yaml  # 特徴量設定
│   └── model_config.yaml    # モデル設定
├── data/                    # データ（Git管理対象外）
│   ├── raw/                 # 生データ（Phase 1）
│   ├── processed/           # 前処理済みデータ（Phase 2）
│   └── features/            # 特徴量選択後データ（Phase 3）
├── models/                  # モデル（Git管理対象外）
│   ├── boruta/              # Boruta選択結果（Phase 3）
│   ├── lightgbm/            # LightGBMモデル（Phase 4）
│   └── optuna/              # Optunaチューニング結果（Phase 4）
├── scripts/                 # Pythonスクリプト
│   ├── phase0_setup.py      # Phase 0: DB接続テスト
│   ├── phase1_data_extraction.py    # Phase 1: データ抽出
│   ├── phase2_preprocessing.py      # Phase 2: 前処理
│   ├── phase3_boruta_selection.py   # Phase 3: Boruta特徴量選択
│   ├── phase4_lightgbm_optuna.py    # Phase 4: LightGBM + Optuna学習
│   └── phase5_evaluation.py         # Phase 5: モデル評価
├── sql/                     # SQLクエリ
│   ├── jravan_extraction.sql    # JRA-VAN抽出SQL
│   └── jrdb_extraction.sql      # JRDB抽出SQL
├── logs/                    # ログファイル
├── results/                 # 評価結果（Phase 5）
│   └── plots/               # グラフ・プロット
├── docs/                    # ドキュメント
│   ├── INTEGRATED_FEATURE_SPECIFICATION_FINAL.md
│   ├── JRA_DEVELOPMENT_FLOW.md
│   ├── jra_context_protocol_v3.md
│   ├── PHASE0_SETUP_MANUAL_WINDOWS.md
│   └── ...
├── requirements.txt         # Python依存パッケージ
├── README.md                # このファイル
└── .gitignore               # Git除外設定
```

---

## 🔄 開発フロー

### Phase 0: 環境構築
- Python環境セットアップ
- PostgreSQL接続確認
- ディレクトリ構造作成

### Phase 1: データ抽出
- JRA-VAN（97カラム）抽出
- JRDB（48カラム）抽出
- 派生特徴量（3カラム）計算
- 統合CSV生成

### Phase 2: 前処理
- 欠損値処理
- カテゴリカル変数エンコーディング
- 異常値除去
- データ型変換

### Phase 3: Boruta特徴量選択
- 148特徴量から重要特徴量を選択
- 冗長・ノイズ特徴量を除去

### Phase 4: LightGBM + Optuna学習
- Optunaでハイパーパラメータ最適化
- LightGBMモデル訓練
- 評価指標算出

### Phase 5: モデル評価
- 特徴量重要度可視化
- ROC曲線プロット
- 混同行列プロット
- デプロイ準備

---

## ⚠️ 重要な注意事項

### 開発方式
✅ AIはスクリプト・SQLクエリ・ドキュメントを作成  
✅ ユーザーがローカルPC（E:\anonymous-keiba-ai-JRA）で実行  
✅ 各Phase完了時はユーザーの完了報告を待つ  
❌ AI側で「完了しました」と自己完結しない  
❌ サンドボックス内で実行しない  
❌ ダミーデータで終わらせない

### データソースの区別
✅ JRA-VAN: 基本情報、馬実績、過去走データ（97カラム）  
✅ JRDB: 予測指数、調教評価、適性データ（48カラム）  
❌ 混同しないこと！データソース列を必ず確認

### 特徴量に関する制約
✅ keibajo_season_code は特徴量として使用（小倉は10_summer/10_winterで分割）  
❌ kaisai_nen, kaisai_tsukihi, race_bango は識別用（学習に使わない）  
✅ month, days_since_last_race は派生計算で作成  
❌ 予測対象レースの結果カラムは特徴量に含めない（データリーク防止）

### 過去走データ設計
✅ パターンC+（3層構造）を採用
  - 高解像度レイヤー（直近2走詳細）: 28カラム
  - 低解像度レイヤー（過去5走統計）: 18カラム
  - コンテキストレイヤー（条件別実績）: 12カラム

### 小倉競馬場の特別扱い
✅ 小倉は季節で分割
  - 10_summer: 7〜8月（夏季開催）
  - 10_winter: 1〜2月（冬季開催）  
❌ 単一コード「10」として扱わない  
理由: 気温差（夏30℃超 vs 冬10℃前後）、芝状態、ペース、馬体質、レース格が大きく異なる

---

## 📊 データソース

### JRA-VAN
- **提供元**: JRA公式データ配信サービス
- **テーブル**: `jvd_ra`, `jvd_se`, `jvd_ck`, `jvd_hr` など
- **カラム数**: 97カラム

### JRDB
- **提供元**: JRDBデータベース
- **テーブル**: `jrd_kyi`, `jrd_joa`, `jrd_cyb`, `jrd_sed` など
- **カラム数**: 48カラム

---

## 🛠️ 使用技術

| カテゴリ | 技術・ライブラリ |
|---|---|
| **言語** | Python 3.9 / 3.10 |
| **データベース** | PostgreSQL 12+ |
| **モデリング** | LightGBM, Optuna |
| **特徴量選択** | Boruta |
| **データ処理** | pandas, numpy |
| **可視化** | matplotlib, seaborn, plotly |
| **その他** | scikit-learn, psycopg2, sqlalchemy |

---

## 📝 Phase完了報告テンプレート

各Phase完了時に、以下の形式で報告してください：

```
# Phase X 完了報告

## 実行環境
- OS: Windows 11
- Python: 3.10.x
- 作業ディレクトリ: E:\anonymous-keiba-ai-JRA

## 実行内容
- 対象競馬場: [競馬場名]（コード: XX）
- 実行コマンド: python scripts/phaseX_xxx.py --input xxx --output xxx
- 実行時間: XX時間XX分

## 結果
- 生成ファイル: xxx.csv
- レコード数: XXXXX件
- カラム数: XXX個
- 評価指標: AUC 0.XXXX

## 確認事項
- [✅] ファイルが正常に生成された
- [✅] エラーなく完了
- [✅] 結果が妥当な範囲

## 次のPhase
Phase X+1 に進んでも良いか確認をお願いします。
```

---

## 🤝 貢献

このプロジェクトはユーザー（あなた）とAI（開発アシスタント）の共同作業です。

- **AI**: Pythonスクリプト、SQLクエリ、ドキュメントを作成
- **ユーザー**: ローカルPCでコードを実行、結果を確認、GitHubにpush・PR作成

---

## 📄 ライセンス

このプロジェクトは個人利用目的です。

---

## 📞 サポート

質問や問題がある場合は、AIに報告してください。

---

**作成日**: 2026-02-19  
**バージョン**: 1.0  
**ステータス**: Phase 0（環境構築）完了待ち
