# 🗺️ JRA中央競馬AI開発ロードマップ - 現在のステータス

**作成日**: 2026-02-20  
**最終更新**: 2026-02-20 15:15 JST  
**プロジェクトパス**: `E:\anonymous-keiba-ai-JRA` (ユーザーローカルPC)  
**GitHubリポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra  
**PRステータス**: [#1 OPEN](https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1) - Phase 1-A & 1-B Complete

---

## 📚 重要ドキュメント階層

### 🔴 最重要（必読）
1. **JRA_DEVELOPMENT_FLOW.md** ⭐⭐⭐
   - AI/ユーザーの役割分担
   - Phase 0〜5の詳細フロー
   - 「AIが何をするか」「ユーザーが何をするか」を明記

2. **INTEGRATED_FEATURE_SPECIFICATION_FINAL.md** ⭐⭐⭐
   - 統合特徴量仕様（148カラム完全定義）
   - データソース別内訳
   - SQL実装ガイド

### 🟡 Phase別成果物
3. **PHASE0_SETUP_MANUAL_WINDOWS.md** - 環境構築手順
4. **PHASE1A_SUCCESS_REPORT.md** - Phase 1-A成果レポート
5. **PHASE1B_SUCCESS_REPORT.md** - Phase 1-B成果レポート
6. **PROJECT_ROADMAP_STATUS.md** - このファイル（全体進捗）

### 🔵 技術仕様
7. **OPTIMAL_PAST_RACE_FEATURES_FINAL.md** - 過去走データ設計
8. **jra_context_protocol_v3.md** - コンテキスト維持プロトコル

---

## 🎯 開発方式の基本原則

### ✅ AI（開発アシスタント）の役割
- Pythonスクリプトの作成
- SQLクエリの作成
- ドキュメントの作成・更新
- 実装手順の説明
- エラー対処方法の提案
- **GitHubリポジトリへのコミット・プッシュ**

### ✅ ユーザー（あなた）の役割
- **ローカルPC（E:\anonymous-keiba-ai-JRA）**でコードを実行
- PostgreSQL（JRA-VAN + JRDB Database）からデータ抽出
- Pythonスクリプトを実行してモデル学習
- 結果を確認・報告
- 実行ログ・スクリーンショット共有

### ❌ 絶対にやらないこと
- ❌ AIが「学習完了しました」と自己完結
- ❌ サンドボックス内で完結させる
- ❌ ダミーデータで終わらせる
- ❌ ユーザーの確認なしにPhase完了とする

---

## 📊 プロジェクト全体進捗

| Phase | ステータス | 説明 | 成果物 | 進捗率 |
|-------|----------|------|--------|--------|
| **Phase 0** | ✅ 完了 | 環境セットアップ | DB接続確認、ディレクトリ構造 | 100% |
| **Phase 1-A** | ✅ 完了 | JRA-VANデータ抽出 | jra_jravan_central_only.csv (63 MB, ~500k行) | 100% |
| **Phase 1-B** | ✅ 完了 | JRDBデータ抽出 | jrdb_48cols.csv (86 MB, 481k行) | 100% |
| **Phase 1-C** | ⏳ 準備完了 | JRA-VAN + JRDB統合 | jravan_jrdb_merged.csv (予定: ~150-180 MB, ~480k行) | 95% |
| **Phase 1-D** | ⬜ 未着手 | 派生特徴量作成 | 距離変化、条件別実績等 | 0% |
| **Phase 2** | ⬜ 未着手 | 前処理 | 欠損値処理、エンコーディング | 0% |
| **Phase 3** | ⬜ 未着手 | Boruta特徴量選択 | 148列 → 重要特徴量のみ | 0% |
| **Phase 4** | ⬜ 未着手 | LightGBM + Optuna学習 | 学習モデル、評価指標 | 0% |
| **Phase 5** | ⬜ 未着手 | モデル評価 | プロット、レポート | 0% |

### 🎯 現在のフォーカス
**Phase 1-C: JRA-VAN + JRDBデータ統合（実行準備完了、ユーザー実行待ち）**

---

## 🔧 Phase 1 詳細ステータス

### Phase 1-A: JRA-VANデータ抽出 ✅ 完了

#### 成果物
- **ファイル**: `data/raw/jra_jravan_central_only.csv`
- **サイズ**: 63 MB（中央競馬10場のみにフィルタ）
- **行数**: ~500,000行（2016-2025年分）
- **列数**: 31列
- **実行時間**: 4-5分

#### 技術的成果
- ✅ PostgreSQLクラッシュ解決（LATERAL JOIN + 年別バッチ）
- ✅ INTEGERオーバーフロー解決（BIGINT キャスト）
- ✅ 型安全性確保（pg_input_is_valid + 正規表現）
- ✅ 中央競馬10場のみに最適化（地方競馬除外）

#### 主要スクリプト
- `scripts/phase1a_simple.py` - 最終動作版
- `scripts/create_indexes.py` - インデックス作成ヘルパー

#### 詳細レポート
📄 [PHASE1A_SUCCESS_REPORT.md](PHASE1A_SUCCESS_REPORT.md)

---

### Phase 1-B: JRDBデータ抽出 ✅ 完了

#### 成果物
- **ファイル**: `data/raw/jrdb_48cols.csv`
- **サイズ**: 86 MB
- **行数**: 481,627行（2016-2025年分）
- **列数**: 53列（キー7列 + 特徴46列）
- **実行時間**: 44秒（3ステップ方式）

#### 3ステップ抽出方式
| ステップ | 内容 | 実行時間 |
|---------|------|----------|
| **Step 1** | 基本データ（予測指数・調教・適性等） | 15.74秒 |
| **Step 2** | 過去走データ（pace・furi等） | 23秒 |
| **Step 3** | pandas結合 | 5.71秒 |

#### データ品質
- **過去走データあり**: 399,707件（83%）
- **過去走データなし**: 81,920件（17%、新馬戦等）
- **血統登録番号**: 54,508頭分

#### 主要スクリプト
- `scripts/phase1b_step1_basic.py` - 基本データ抽出
- `scripts/phase1b_step2_past.py` - 過去走データ抽出
- `scripts/phase1b_step3_merge.py` - pandas結合
- `scripts/create_jrdb_indexes.py` - インデックス作成

#### 詳細レポート
📄 [PHASE1B_SUCCESS_REPORT.md](PHASE1B_SUCCESS_REPORT.md)

---

### Phase 1-C: JRA-VAN + JRDBデータ統合 ⏳ 準備完了

#### 目的
JRA-VANの基礎データ（31列）とJRDBの予測指数データ（53列）を統合し、完全な特徴量データセットを作成

#### 実装状況
✅ **スクリプト完成**:
- `scripts/phase1c_merge.py` - 改良版（チャンク処理）
- `scripts/phase1c_merge_ultra_light.py` - 超軽量版（SQLite使用）★推奨

✅ **技術的課題と解決策**:
1. **初期の問題**: 競馬場コード不一致で結合失敗
   - JRA-VAN: 中央10場 + 地方・海外（コード30-65）
   - JRDB: 中央10場のみ（コード01-10）
   - **解決**: Phase 1-Aを中央10場のみに再最適化

2. **サンドボックスメモリ制約**:
   - メモリ制限: ~1GB
   - マージ処理で約800 MB使用 → OOM Killer発動
   - **解決**: Windows環境での実行を推奨

#### 結合キー
- `keibajo_code`: 競馬場コード（01-10）
- `kaisai_nen`: 開催年（2016-2025）
- `race_bango`: レース番号（1-12）
- `umaban`: 馬番（1-18）

#### 期待される出力
- **ファイル**: `data/raw/jravan_jrdb_merged.csv`
- **サイズ**: 150-180 MB
- **行数**: ~480,000行
- **列数**: ~70列（JRDB 53列 + JRA-VAN 17列）
- **実行時間**: 5-10分（Windows環境）

#### 次のステップ（ユーザー実行）
```powershell
# Windowsで実行
cd E:\anonymous-keiba-ai-JRA
git pull origin genspark_ai_developer
python scripts\phase1c_merge_ultra_light.py
```

#### 関連コミット
- `e951e3e` - Phase 1-C merge script with ultra-light version
- `1697f18` - 中央競馬10場のみに最適化
- `4923342` - 結合キー修正

#### GitHubコメント
🔗 [PR#1 Comment - Phase 1-C準備完了](https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1#issuecomment-3935553764)

---

### Phase 1-D: 派生特徴量作成 ⬜ 未着手

#### 目的
Phase 1-Cの統合データに、以下の派生特徴量を追加:

1. **距離変化関連**（3列）
   - `kyori_change`: 前走比距離変化量（m）
   - `kyori_change_category`: カテゴリ（短縮・同距離・延長）
   - `distance_suitability_score`: 距離適性スコア

2. **条件別実績**（オプション）
   - 芝/ダート別、距離帯別、競馬場別の実績統計

#### 実装待ち
Phase 1-Cが完了次第、スクリプト作成予定

---

## 📂 プロジェクト構造

### リポジトリ構造（GitHub）
```
anonymous-keiba-ai-jra/
├── scripts/                      # Pythonスクリプト
│   ├── phase1a_simple.py         # Phase 1-A: JRA-VAN抽出
│   ├── phase1b_step1_basic.py    # Phase 1-B: JRDB基本データ
│   ├── phase1b_step2_past.py     # Phase 1-B: JRDB過去走データ
│   ├── phase1b_step3_merge.py    # Phase 1-B: pandas結合
│   ├── phase1c_merge.py          # Phase 1-C: 統合（改良版）
│   ├── phase1c_merge_ultra_light.py  # Phase 1-C: 統合（超軽量版）
│   └── create_*.py               # インデックス作成ヘルパー
├── sql/                          # SQLクエリ（参考用）
├── docs/                         # ドキュメント
├── data/                         # データディレクトリ（.gitignore）
│   └── raw/                      # 生データ
├── logs/                         # ログディレクトリ
├── config/                       # 設定ファイル
├── *.md                          # 各種ドキュメント
├── requirements.txt              # Python依存パッケージ
└── README.md                     # プロジェクト概要
```

### ローカルPC構造（ユーザー環境）
```
E:\anonymous-keiba-ai-JRA/
├── data/
│   ├── raw/
│   │   ├── jra_jravan_central_only.csv  # Phase 1-A出力
│   │   ├── jrdb_48cols.csv               # Phase 1-B出力
│   │   └── jravan_jrdb_merged.csv        # Phase 1-C出力（予定）
│   ├── processed/                        # Phase 2出力（予定）
│   └── features/                         # Phase 3出力（予定）
├── models/                               # Phase 4出力（予定）
│   ├── lightgbm/
│   └── optuna/
├── results/                              # Phase 5出力（予定）
│   └── plots/
├── logs/                                 # 実行ログ
├── scripts/                              # GitHubから取得
├── config/
│   └── db_config.yaml                    # DB接続設定
└── venv/                                 # Python仮想環境
```

---

## 🔍 技術スタック

### データソース
| データソース | 提供内容 | テーブル | 列数 |
|------------|---------|---------|------|
| **JRA-VAN** | 公式レース結果、馬実績、過去走 | jvd_ra, jvd_se, jvd_ck, jvd_hr | 31列 |
| **JRDB** | 予測指数、調教評価、適性データ | jrd_kyi, jrd_joa, jrd_cyb, jrd_sed | 53列 |

### 開発環境
- **言語**: Python 3.10+
- **データベース**: PostgreSQL 12+
- **主要ライブラリ**: pandas, numpy, psycopg2, sqlalchemy

### 機械学習（Phase 3-5）
- **特徴量選択**: Boruta
- **モデル**: LightGBM
- **最適化**: Optuna
- **評価**: sklearn, matplotlib, seaborn

---

## 🚀 次のアクション

### 🔴 最優先: Phase 1-C実行（ユーザー作業）

#### 実行手順
```powershell
# 1. リポジトリ更新
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer

# 2. 入力ファイル確認
dir data\raw\jra_jravan_central_only.csv  # 63 MB
dir data\raw\jrdb_48cols.csv               # 86 MB

# 3. Phase 1-C実行（超軽量版推奨）
python scripts\phase1c_merge_ultra_light.py

# または通常版
python scripts\phase1c_merge.py
```

#### 期待される出力
- **ファイル**: `data\raw\jravan_jrdb_merged.csv`
- **サイズ**: 150-180 MB
- **行数**: ~480,000行
- **列数**: ~70列
- **実行時間**: 5-10分

#### 完了報告
実行後、以下を報告してください：
1. ✅ ログ出力（最後の統計情報）
2. ✅ ファイルサイズと行数確認
3. ✅ 実行時間
4. ⚠️ エラーがあればその内容

---

## 📈 開発スケジュール予測

| Phase | 期間（推定） | ステータス |
|-------|------------|-----------|
| Phase 0 | 1-2時間 | ✅ 完了 |
| Phase 1-A | 1日 | ✅ 完了 |
| Phase 1-B | 1日 | ✅ 完了 |
| **Phase 1-C** | **0.5日** | **⏳ 実行待ち** |
| Phase 1-D | 0.5日 | ⬜ 未着手 |
| Phase 2 | 1-2日 | ⬜ 未着手 |
| Phase 3 | 0.5-1日（Boruta実行時間含む） | ⬜ 未着手 |
| Phase 4 | 2-3日（Optuna最適化含む） | ⬜ 未着手 |
| Phase 5 | 0.5-1日 | ⬜ 未着手 |
| **合計** | **7-11日** | **Phase 1-C: 32%完了** |

---

## 🔗 関連リンク

### GitHub
- **リポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra
- **Pull Request #1**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1
- **最新コミット**: `e951e3e` - Phase 1-C merge script with ultra-light version

### ドキュメント
- 📘 [JRA_DEVELOPMENT_FLOW.md](JRA_DEVELOPMENT_FLOW.md) - 開発フロー全体
- 📗 [INTEGRATED_FEATURE_SPECIFICATION_FINAL.md](INTEGRATED_FEATURE_SPECIFICATION_FINAL.md) - 特徴量仕様
- 📙 [PHASE1A_SUCCESS_REPORT.md](PHASE1A_SUCCESS_REPORT.md) - Phase 1-A成果
- 📕 [PHASE1B_SUCCESS_REPORT.md](PHASE1B_SUCCESS_REPORT.md) - Phase 1-B成果

---

## ✅ チェックリスト（全体）

### Phase 0: 環境セットアップ
- [x] ユーザーがプロジェクトディレクトリ作成
- [x] ユーザーがPython環境構築
- [x] ユーザーがPostgreSQL接続テスト成功
- [x] ユーザーが「Phase 0完了」報告

### Phase 1-A: JRA-VANデータ抽出
- [x] AIがSQLクエリ・スクリプト作成
- [x] ユーザーがスクリプト実行
- [x] ユーザーがCSV生成完了報告
- [x] ユーザーが列数31を確認
- [x] ユーザーが「Phase 1-A完了」報告

### Phase 1-B: JRDBデータ抽出
- [x] AIが3ステップスクリプト作成
- [x] ユーザーがスクリプト実行
- [x] ユーザーがCSV生成完了報告
- [x] ユーザーが列数53を確認
- [x] ユーザーが「Phase 1-B完了」報告

### Phase 1-C: データ統合
- [x] AIがマージスクリプト作成
- [x] AIが中央競馬フィルタ最適化
- [x] AIがメモリ効率化（超軽量版）
- [ ] ユーザーがスクリプト実行 ← **現在ここ**
- [ ] ユーザーがCSV生成完了報告
- [ ] ユーザーが列数~70を確認
- [ ] ユーザーが「Phase 1-C完了」報告

### Phase 1-D〜Phase 5
- [ ] 未着手（Phase 1-C完了後に開始）

---

## 📝 Git履歴

### 最近のコミット
```
e951e3e - feat: Phase 1-C merge script with ultra-light version
1697f18 - refactor: Phase 1-A/1-C 中央競馬10場のみに最適化
4923342 - fix: Phase 1-C 結合キー修正
2613548 - feat: Phase 1-C データ結合スクリプト追加
7390d7e - feat: Phase 1-B JRDB抽出完了
8c92773 - docs: add comprehensive Phase 1-A success report
...
```

### ブランチ
- **main**: 安定版（Phase 1-A/1-B完了時点）
- **genspark_ai_developer**: 開発ブランチ（現在作業中）

---

## 💡 Tips & Notes

### メモリ最適化
Phase 1-Cの経験から、大規模データマージは以下の手法が有効：
1. **チャンク処理**: 一度に読み込む行数を制限（10,000-50,000行）
2. **年別バッチ**: データを年単位に分割処理
3. **SQLite活用**: pandasマージの代わりにSQLite一時DBを使用
4. **即座にCSV追記**: 全データをメモリに保持しない

### データ品質管理
- 血統登録番号一致率: 90%以上を目標
- 欠損値: 新馬戦等で過去走データが欠損するのは正常
- 重複チェック: 各Phase完了時に必ず実施

### Git運用
- 各Phase完了時に必ずコミット・プッシュ
- PRコメントで詳細な実行結果を報告
- 大きなデータファイル（CSV等）は`.gitignore`で除外

---

**最終更新**: 2026-02-20 15:15 JST  
**次回更新予定**: Phase 1-C完了後  
**ステータス**: ⏳ Phase 1-C実行待ち（ユーザー側）
