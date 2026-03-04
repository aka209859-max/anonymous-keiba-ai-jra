# Phase 7-A データベース調査実行ガイド

**作成日**: 2026-03-03  
**目的**: PostgreSQLデータベースの全テーブル・カラム情報を調査し、既存139特徴量との対応を分析  
**目標**: 200-220次元への特徴量拡張の基盤を確立

---

## 📋 概要

Phase 1-6では、膨大なJRA-VAN + JRDBデータから**139カラムに厳選**して使用してきました。  
Phase 7-Aでは、**元のデータソース（PostgreSQLデータベース）**に戻り、未使用の有望カラムを発掘して**200-220次元**に拡張します。

---

## 🎯 調査の目的

1. **元データの全体像把握**
   - PostgreSQLに何個のテーブルがあるか
   - 各テーブルに何個のカラムがあるか
   - 総カラム数は何個か

2. **既存139カラムの出所特定**
   - どのテーブル・カラムから抽出されたか
   - どのカテゴリ（レース情報、馬情報、騎手情報など）に属するか

3. **未使用カラムの発掘**
   - ROI向上に有望な未使用カラムをリストアップ
   - JRA-VANとJRDBそれぞれから候補を選定

---

## 🚀 実行手順

### ステップ1: Git最新版取得

```powershell
cd E:\anonymous-keiba-ai-JRA

# ローカル変更を一時保存
git stash push -m "Local changes before Phase 7 merge"

# Phase 7コードを取得
git pull origin genspark_ai_developer

# Phase 7ディレクトリ確認
cd phase7
dir
```

**期待される結果**:
- `phase7/` ディレクトリが作成される
- `docs`, `scripts`, `results`, `models`, `config`, `logs`, `notebooks` サブディレクトリが存在
- `README.md` が存在

---

### ステップ2: PostgreSQL起動確認

```powershell
# PostgreSQLサービス確認
Get-Service postgresql*

# 起動していない場合
Start-Service postgresql-x64-15  # バージョン番号は環境に合わせて調整
```

**確認項目**:
- PostgreSQLサービスが **Running** 状態
- ポート5432がリッスン中

---

### ステップ3: データベース調査スクリプト実行

```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion

# Python仮想環境がある場合
# .venv\Scripts\activate  # または適切な環境

# スクリプト実行
python investigate_database_sources.py
```

**処理内容**:
1. PostgreSQL `pckeiba` データベースに接続
2. 全テーブル一覧を取得
3. 各テーブルのカラム情報を取得
4. JRA-VANテーブル（`jvd_*`）の詳細分析
5. JRDBテーブルの詳細分析
6. 結果を2つのCSVファイルに出力

**出力ファイル** (保存先: `phase7/results/phase7a_features/`):
- `database_tables_summary_YYYYMMDD_HHMMSS.csv` - テーブル一覧（テーブル名、カラム数、行数）
- `database_columns_detail_YYYYMMDD_HHMMSS.csv` - 全カラム詳細（テーブル名、カラム名、データ型、NULL可否）

**実行時間**: 約1-3分（データベースサイズによる）

---

### ステップ4: 既存特徴量分析スクリプト実行

```powershell
# 同じディレクトリで実行
python analyze_existing_features.py
```

**処理内容**:
1. `data/raw/jravan_jrdb_merged_fixed.csv` から既存139カラムを読み込み
2. カラムをカテゴリ別に分類
   - JRA-VAN_レース基本情報
   - JRA-VAN_馬基本情報
   - JRA-VAN_騎手・調教師
   - JRA-VAN_過去成績
   - JRA-VAN_馬場・天候
   - JRA-VAN_オッズ
   - JRDB_基本情報
   - JRDB_過去走
   - JRDB_調教
   - JRDB_予想
   - 派生特徴量
3. データベース全カラムと比較し、未使用カラムを特定
4. ROI向上に有望な候補カラムを提案

**出力ファイル** (保存先: `phase7/results/phase7a_features/`):
- `existing_features_categorized_YYYYMMDD_HHMMSS.csv` - 既存139カラムのカテゴリ分類
- `jravan_candidate_features_YYYYMMDD_HHMMSS.csv` - JRA-VAN追加候補リスト
- `jrdb_candidate_features_YYYYMMDD_HHMMSS.csv` - JRDB追加候補リスト

**実行時間**: 約30秒-1分

---

## 📊 期待される出力例

### データベーステーブルサマリー

```
table_name,column_count,row_count
jvd_ra,45,123456
jvd_se,38,123456
jvd_ck,42,567890
jvd_hr,28,234567
jrdb_bac,52,123456
jrdb_sed,35,123456
...
```

### 既存特徴量カテゴリ分布

```
JRA-VAN_レース基本情報: 18個
  - race_id
  - keibajo_code
  - kyori
  - track_code
  ...

JRA-VAN_馬基本情報: 15個
  - horse_id
  - bamei
  - sex_code
  - age
  ...

JRA-VAN_騎手・調教師: 12個
JRDB_基本情報: 25個
JRDB_過去走: 18個
派生特徴量: 22個

合計: 139個
```

### 追加候補特徴量（例）

```
【JRA-VAN 追加候補】 (有望度順)
 1. jvd_se.time_index (タイム指数)
 2. jvd_se.pace_index (ペース指数)
 3. jvd_ck.corner_position_1 (1コーナー位置)
 4. jvd_ck.corner_position_4 (4コーナー位置)
 5. jvd_ck.margin_2着 (2着との着差)
 ...

【JRDB 追加候補】 (有望度順)
 1. jrdb_bac.ten_index (テン指数)
 2. jrdb_bac.agari_index (上がり指数)
 3. jrdb_sed.pace_score (ペーススコア)
 4. jrdb_kyi.training_score (調教評価点)
 ...

追加可能カラム数合計: 180
目標特徴量数: 200-220
現在特徴量数: 139
必要追加数: 61 ~ 81
```

---

## ✅ 実行後確認チェックリスト

- [ ] PostgreSQL接続成功
- [ ] `database_tables_summary_*.csv` 生成確認
- [ ] `database_columns_detail_*.csv` 生成確認
- [ ] JRA-VANテーブル数が10個以上
- [ ] JRDBテーブル数が5個以上
- [ ] 総カラム数が300個以上
- [ ] `existing_features_categorized_*.csv` 生成確認
- [ ] `jravan_candidate_features_*.csv` 生成確認（候補数30個以上）
- [ ] `jrdb_candidate_features_*.csv` 生成確認（候補数30個以上）

---

## 🔍 トラブルシューティング

### エラー1: PostgreSQL接続失敗

```
psycopg2.OperationalError: connection to server at "127.0.0.1", port 5432 failed
```

**対処法**:
1. PostgreSQLサービスが起動しているか確認
   ```powershell
   Get-Service postgresql*
   Start-Service postgresql-x64-15
   ```

2. ポート5432が使用中か確認
   ```powershell
   netstat -ano | findstr :5432
   ```

3. `config/db_config.yaml` の設定確認
   - host: 127.0.0.1
   - port: 5432
   - database: pckeiba
   - user/password が正しいか

---

### エラー2: CSV読み込み失敗

```
FileNotFoundError: data/raw/jravan_jrdb_merged_fixed.csv
```

**対処法**:
1. ファイルの存在確認
   ```powershell
   dir E:\anonymous-keiba-ai-JRA\data\raw\*.csv
   ```

2. 正しいディレクトリから実行しているか確認
   ```powershell
   pwd
   # 期待値: E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion
   ```

---

### エラー3: メモリ不足

```
MemoryError: Unable to allocate array
```

**対処法**:
- スクリプト内の `nrows=1` パラメータにより、カラム名のみ読み込むため通常は発生しない
- それでも発生する場合、Pythonの64bit版使用を確認

---

## 📝 次のステップ（Day 3-4）

調査完了後、以下を実施：

1. **候補カラム精査**
   - JRA-VAN候補とJRDB候補を確認
   - ROI向上に最も有望なカラムを選定（目標: +61〜81カラム）

2. **追加特徴量抽出スクリプト作成**
   - 選定したカラムを抽出するSQLクエリ作成
   - `extract_additional_features.py` 実装

3. **統合マスターCSV作成**
   - 既存139 + 追加61〜81 = 200〜220カラム
   - `combined_features_master.csv` 生成

---

## 📄 関連ドキュメント

- [PHASE7_WORKFLOW.md](../01_workflow/PHASE7_WORKFLOW.md) - 15週間実装フロー
- [PHASE7_ROADMAP.md](../02_roadmap/PHASE7_ROADMAP.md) - 週次ロードマップ
- [PHASE7_STRATEGY.md](./PHASE7_STRATEGY.md) - 戦略骨組み
- [PHASE7A_WEEK1_START_PLAN.md](./PHASE7A_WEEK1_START_PLAN.md) - Week 1計画

---

## 📧 サポート

質問・問題がある場合、以下を記録して報告：
- 実行したコマンド
- エラーメッセージ全文
- 環境情報（Pythonバージョン、PostgreSQLバージョン）

---

**Phase 7-A Day 1-2 目標**: データベース全体像の把握と既存特徴量の出所特定  
**成功基準**: 6個のCSVファイル生成、追加候補カラム60個以上特定
