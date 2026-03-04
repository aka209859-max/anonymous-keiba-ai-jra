# Phase 7-A データベース調査スクリプト作成記録

**作成日**: 2026-03-03  
**作業内容**: Phase 7-A Week 1 データベース調査用スクリプト・ガイド作成  
**目的**: 元データソース（PostgreSQL）の全体像把握と既存139特徴量の出所特定

---

## 📋 作業サマリー

### 背景
- ユーザー指摘: **既存CSVは元データから厳選したもの。元データを調べる必要がある**
- 理解: Phase 1-6で使用した139カラムは、JRA-VAN + JRDBの膨大なカラムから選抜
- Phase 7目標: **元のPostgreSQLデータベースに戻り、未使用カラムを発掘して200-220次元に拡張**

---

## 🎯 作成物一覧

### 1. データベース調査スクリプト
**ファイル名**: `phase7/scripts/phase7a_feature_expansion/investigate_database_sources.py`  
**サイズ**: 7,795 bytes  
**機能**:
- PostgreSQL `pckeiba` データベースに接続
- 全テーブル一覧を取得（`information_schema.tables`）
- 各テーブルのカラム情報を取得（カラム名、データ型、NULL可否、文字列長）
- 各テーブルの行数を取得
- JRA-VANテーブル（`jvd_*`）の詳細分析
- JRDBテーブルの詳細分析
- 結果を2つのCSVファイルに出力

**出力ファイル**:
1. `database_tables_summary_YYYYMMDD_HHMMSS.csv`
   - テーブル名、カラム数、行数
2. `database_columns_detail_YYYYMMDD_HHMMSS.csv`
   - テーブル名、カラム名、データ型、最大長、NULL可否

**実行コマンド**:
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion
python investigate_database_sources.py
```

---

### 2. 既存特徴量分析スクリプト
**ファイル名**: `phase7/scripts/phase7a_feature_expansion/analyze_existing_features.py`  
**サイズ**: 10,113 bytes  
**機能**:
- `data/raw/jravan_jrdb_merged_fixed.csv` から既存139カラムを読み込み
- カラムをカテゴリ別に自動分類:
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
  - 不明
- データベース全カラムと比較し、未使用カラムを特定
- ROI向上に有望なキーワードで候補をフィルタリング:
  - time, タイム, speed, スピード
  - pace, ペース, position, 位置
  - corner, コーナー, margin, 着差
  - prize, 賞金, rating, レーティング
  - idm, index, 指数, score, スコア
  - ten, テン, agari, 上がり

**出力ファイル**:
1. `existing_features_categorized_YYYYMMDD_HHMMSS.csv`
   - 既存139カラムのカテゴリ分類結果
2. `jravan_candidate_features_YYYYMMDD_HHMMSS.csv`
   - JRA-VAN追加候補リスト（テーブル名、カラム名、データ型）
3. `jrdb_candidate_features_YYYYMMDD_HHMMSS.csv`
   - JRDB追加候補リスト（テーブル名、カラム名、データ型）

**実行コマンド**:
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion
python analyze_existing_features.py
```

**実行順序**: `investigate_database_sources.py` → `analyze_existing_features.py`  
（後者は前者が生成した `database_columns_detail_*.csv` を読み込む）

---

### 3. 実行ガイドドキュメント
**ファイル名**: `phase7/docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md`  
**サイズ**: 5,410 bytes  
**内容**:

#### セクション構成
1. **概要** - Phase 7-Aの目的と背景
2. **調査の目的** - 3つの具体的ゴール
3. **実行手順** - 4ステップの詳細説明
   - Git最新版取得
   - PostgreSQL起動確認
   - データベース調査スクリプト実行
   - 既存特徴量分析スクリプト実行
4. **期待される出力例** - サンプル結果表示
5. **確認チェックリスト** - 9項目の成功条件
6. **トラブルシューティング** - 3つの一般的エラーと対処法
7. **次のステップ** - Day 3-4の予定

#### 主要ポイント
- **現状**: 139カラム（厳選済み）
- **目標**: 200-220カラム（+61〜81カラム追加）
- **方針**: PostgreSQLの元データから未使用の有望カラムを発掘
- **優先**: ROI向上に寄与する指標（タイム、ペース、位置、着差、指数など）

---

## 🔄 Git管理

### コミット待ちファイル（未コミット）
```
phase7/scripts/phase7a_feature_expansion/investigate_database_sources.py
phase7/scripts/phase7a_feature_expansion/analyze_existing_features.py
phase7/docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md
docs/PHASE7A_SCRIPTS_CREATED_20260303.md (このファイル)
```

### コミット予定
```bash
git add phase7/scripts/phase7a_feature_expansion/*.py
git add phase7/docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md
git add docs/PHASE7A_SCRIPTS_CREATED_20260303.md
git commit -m "feat(phase7a): Add database investigation and feature analysis scripts

- investigate_database_sources.py: PostgreSQL full table/column scan
- analyze_existing_features.py: Existing 139 features categorization
- PHASE7A_DATABASE_INVESTIGATION_GUIDE.md: Step-by-step execution guide
- Target: 200-220 dimensions (current 139 + 61-81 new features)
"
```

---

## 📊 期待される成果（Day 1-2完了時）

### 定量目標
- [x] データベース調査スクリプト作成（✅ 完了）
- [x] 既存特徴量分析スクリプト作成（✅ 完了）
- [x] 実行ガイド作成（✅ 完了）
- [ ] スクリプト実行（PC側で実施）
- [ ] 6個のCSVファイル生成
  - database_tables_summary_*.csv
  - database_columns_detail_*.csv
  - existing_features_categorized_*.csv
  - jravan_candidate_features_*.csv
  - jrdb_candidate_features_*.csv
- [ ] 追加候補カラム60個以上特定

### 定性目標
- [x] 元データソース構造の理解（✅ スクリプトで自動化）
- [x] 既存139カラムのカテゴリ分類（✅ スクリプトで自動化）
- [ ] ROI向上有望カラムの特定（PC側実行で確認）

---

## 🚀 次のアクション（PC側実行）

### 優先度1: Git同期
```powershell
cd E:\anonymous-keiba-ai-JRA
git stash push -m "Local changes before Phase 7 merge"
git pull origin genspark_ai_developer
cd phase7
dir  # ディレクトリ構造確認
```

### 優先度2: PostgreSQL起動確認
```powershell
Get-Service postgresql*
# 必要に応じて Start-Service
```

### 優先度3: スクリプト実行
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion

# 1. データベース全体調査
python investigate_database_sources.py

# 2. 既存特徴量分析
python analyze_existing_features.py
```

### 優先度4: 結果確認
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features
dir

# CSVファイルをExcelで開いて内容確認
```

---

## 📝 補足事項

### 設計方針の変更点
**初期案（誤り）**:
- 既存CSVのカラムを確認して拡張 ← ❌ これは既に厳選済み

**修正案（正解）**:
- 元のPostgreSQLデータベースから全カラムを調査
- 既存139カラムとの差分を特定
- 未使用カラムから有望なものを選定
- 200-220次元に拡張

### ユーザーフィードバックへの対応
**問題指摘**:
> 既存CSVのカラムは何度も言うように元のデータから厳選したものです。  
> 何度言えばわかってくれますか？？  
> そのデータ元を調べないといけないでしょ？？

**対応内容**:
1. ✅ 方針転換: CSV → PostgreSQL元データ
2. ✅ データベース全体スキャンスクリプト作成
3. ✅ 既存特徴量との対応分析スクリプト作成
4. ✅ 未使用カラム発掘の自動化
5. ✅ ROI有望キーワードフィルタリング

---

## 🎯 Week 1 進捗

| Day | タスク | 状態 | 成果物 |
|-----|--------|------|--------|
| 1-2 | データベース調査 | **🔄 スクリプト完成** | investigate_database_sources.py (✅)<br>analyze_existing_features.py (✅)<br>PHASE7A_DATABASE_INVESTIGATION_GUIDE.md (✅) |
| 1-2 | 実行・結果確認 | **⏳ PC側実行待ち** | 6個のCSVファイル（未生成）<br>追加候補リスト（未確定） |
| 3-4 | 候補選定・抽出 | ⬜ 未着手 | extract_additional_features.py（未作成）<br>200-220次元データセット（未作成） |
| 5-6 | 統合マスター作成 | ⬜ 未着手 | combined_features_master.csv（未作成） |
| 7 | Week 1完了報告 | ⬜ 未着手 | PHASE7A_WEEK1_COMPLETION_REPORT.md（未作成） |

**現在地**: Day 1-2 スクリプト作成完了、PC側実行前

---

## ✅ 確認事項

### サンドボックス側（完了）
- [x] investigate_database_sources.py 作成（7,795 bytes）
- [x] analyze_existing_features.py 作成（10,113 bytes）
- [x] PHASE7A_DATABASE_INVESTIGATION_GUIDE.md 作成（5,410 bytes）
- [x] PHASE7A_SCRIPTS_CREATED_20260303.md 作成（このファイル）
- [ ] Git コミット実施

### PC側（未実施）
- [ ] Git pull 実行
- [ ] PostgreSQL起動確認
- [ ] investigate_database_sources.py 実行
- [ ] analyze_existing_features.py 実行
- [ ] 6個のCSVファイル生成確認
- [ ] 追加候補カラム60個以上確認

---

**作成者**: GenSpark AI Assistant  
**レビュー**: 未実施  
**次回更新**: PC側スクリプト実行後
