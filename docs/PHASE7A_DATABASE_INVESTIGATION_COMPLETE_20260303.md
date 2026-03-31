# Phase 7-A データソース調査スクリプト作成完了報告

**報告日時**: 2026-03-03  
**作業フェーズ**: Phase 7-A Week 1 Day 1-2  
**作業内容**: 元データソース（PostgreSQL）調査スクリプト・ガイド作成  
**Git コミット**: `5b5be31`

---

## ✅ 作業完了サマリー

### 理解した重要ポイント
1. ❌ **誤り**: 既存CSV（139列）から拡張しようとした
2. ✅ **正解**: **元のPostgreSQLデータベースに戻って未使用カラムを発掘**
3. 🎯 **目標**: 139列 → 200-220列（+61〜81列追加）

---

## 📦 作成ファイル一覧

### 1. investigate_database_sources.py
**パス**: `phase7/scripts/phase7a_feature_expansion/investigate_database_sources.py`  
**サイズ**: 7,795 bytes  
**機能**:
- PostgreSQL `pckeiba` データベース全テーブル・カラムスキャン
- JRA-VANテーブル（`jvd_*`）詳細分析
- JRDBテーブル詳細分析
- 2つのCSV出力（サマリーと詳細）

**出力ファイル**:
```
phase7/results/phase7a_features/database_tables_summary_YYYYMMDD_HHMMSS.csv
phase7/results/phase7a_features/database_columns_detail_YYYYMMDD_HHMMSS.csv
```

---

### 2. analyze_existing_features.py
**パス**: `phase7/scripts/phase7a_feature_expansion/analyze_existing_features.py`  
**サイズ**: 10,113 bytes  
**機能**:
- 既存139列を11カテゴリに自動分類
- データベース全カラムとの差分特定
- ROI向上有望キーワードでフィルタリング
  - time, タイム, speed, スピード
  - pace, ペース, position, 位置
  - corner, コーナー, margin, 着差
  - prize, 賞金, index, 指数
  - score, スコア, ten, テン, agari, 上がり
- 3つのCSV出力（分類結果、JRA-VAN候補、JRDB候補）

**出力ファイル**:
```
phase7/results/phase7a_features/existing_features_categorized_YYYYMMDD_HHMMSS.csv
phase7/results/phase7a_features/jravan_candidate_features_YYYYMMDD_HHMMSS.csv
phase7/results/phase7a_features/jrdb_candidate_features_YYYYMMDD_HHMMSS.csv
```

---

### 3. PHASE7A_DATABASE_INVESTIGATION_GUIDE.md
**パス**: `phase7/docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md`  
**サイズ**: 5,410 bytes  
**内容**:
- 調査目的と背景説明
- 4ステップ実行手順（Git同期、PostgreSQL確認、スクリプト2本実行）
- 期待される出力例
- トラブルシューティング（PostgreSQL接続失敗、CSV読み込み失敗、メモリ不足）
- 確認チェックリスト（9項目）
- 次のステップ（Day 3-4予定）

---

### 4. PHASE7A_SCRIPTS_CREATED_20260303.md
**パス**: `docs/PHASE7A_SCRIPTS_CREATED_20260303.md`  
**サイズ**: 6,186 bytes  
**内容**:
- 作業背景とユーザーフィードバックへの対応
- 3ファイルの詳細仕様
- 期待される成果（定量・定性）
- PC側実行アクション
- Week 1進捗トラッカー

---

## 🔄 Git 管理

### コミット情報
```
Commit: 5b5be31
Branch: genspark_ai_developer
Message: feat(phase7a): Add database investigation and feature analysis scripts
Files: 4 files changed, 1,137 insertions(+)
```

### ファイル構成
```
phase7/
├── scripts/
│   └── phase7a_feature_expansion/
│       ├── investigate_database_sources.py  (新規作成)
│       └── analyze_existing_features.py     (新規作成)
├── docs/
│   └── 00_overview/
│       └── PHASE7A_DATABASE_INVESTIGATION_GUIDE.md  (新規作成)
└── results/
    └── phase7a_features/
        └── (PC実行後にCSV 6個生成予定)

docs/
└── PHASE7A_SCRIPTS_CREATED_20260303.md  (新規作成)
```

---

## 🚀 PC側実行指示

### ステップ1: Git同期（最優先）
```powershell
cd E:\anonymous-keiba-ai-JRA

# ローカル変更を一時保存
git stash push -m "Local changes before Phase 7 merge"

# 最新コードを取得（コミット5b5be31を含む）
git pull origin genspark_ai_developer

# Phase 7ディレクトリ確認
cd phase7
dir
```

**確認項目**:
- [ ] `phase7/` ディレクトリ存在
- [ ] `scripts/phase7a_feature_expansion/` 存在
- [ ] `investigate_database_sources.py` 存在
- [ ] `analyze_existing_features.py` 存在
- [ ] `docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md` 存在

---

### ステップ2: PostgreSQL起動確認
```powershell
# サービス状態確認
Get-Service postgresql*

# 起動していない場合
Start-Service postgresql-x64-15  # バージョン番号は環境に応じて調整
```

**確認項目**:
- [ ] PostgreSQLサービスが **Running** 状態
- [ ] ポート5432がリッスン中

---

### ステップ3: スクリプト実行
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion

# 1本目: データベース全体調査
python investigate_database_sources.py

# 期待される出力:
# - "PostgreSQL データベーステーブル一覧"
# - JVD_テーブル数: 10個以上
# - JRDBテーブル数: 5個以上
# - 2つのCSVファイル生成

# 2本目: 既存特徴量分析
python analyze_existing_features.py

# 期待される出力:
# - "既存特徴量カテゴリ分布" (11カテゴリ、合計139個)
# - "JRA-VAN 追加候補" (30個以上)
# - "JRDB 追加候補" (30個以上)
# - 3つのCSVファイル生成
```

**確認項目**:
- [ ] `investigate_database_sources.py` 正常終了（エラーなし）
- [ ] `analyze_existing_features.py` 正常終了（エラーなし）
- [ ] 合計6個のCSVファイル生成

---

### ステップ4: 結果確認
```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features
dir

# 生成されたCSVをExcelで開いて確認
```

**成功基準**:
- [ ] `database_tables_summary_*.csv` - テーブル数20個以上
- [ ] `database_columns_detail_*.csv` - 総カラム数300個以上
- [ ] `existing_features_categorized_*.csv` - 139行（既存特徴量）
- [ ] `jravan_candidate_features_*.csv` - 30行以上（JRA-VAN候補）
- [ ] `jrdb_candidate_features_*.csv` - 30行以上（JRDB候補）
- [ ] 追加候補合計: 60個以上（目標: 61〜81個）

---

## 📊 期待される結果例

### データベーステーブルサマリー
```
table_name       | column_count | row_count
-----------------|--------------|----------
jvd_ra           | 45           | 123,456
jvd_se           | 38           | 123,456
jvd_ck           | 42           | 567,890
jvd_hr           | 28           | 234,567
jrdb_bac         | 52           | 123,456
jrdb_sed         | 35           | 123,456
...
合計テーブル数: 20-30個
JRA-VAN合計カラム: 200-300個
JRDB合計カラム: 100-200個
総合計カラム: 300-500個
```

### 既存特徴量カテゴリ分布
```
JRA-VAN_レース基本情報: 18個
JRA-VAN_馬基本情報: 15個
JRA-VAN_騎手・調教師: 12個
JRA-VAN_過去成績: 20個
JRA-VAN_馬場・天候: 8個
JRA-VAN_オッズ: 6個
JRDB_基本情報: 25個
JRDB_過去走: 18個
JRDB_調教: 7個
JRDB_予想: 5個
派生特徴量: 22個
不明: 3個
合計: 139個
```

### 追加候補（上位20件、例）
```
【JRA-VAN 追加候補】
 1. jvd_se.time_index (タイム指数)
 2. jvd_se.pace_index (ペース指数)
 3. jvd_ck.corner_position_1 (1コーナー位置)
 4. jvd_ck.corner_position_4 (4コーナー位置)
 5. jvd_ck.margin_2nd (2着との着差)
 6. jvd_hr.speed_rating (スピードレーティング)
 7. jvd_ra.lap_time_3f (3F通過タイム)
 8. jvd_ra.lap_time_5f (5F通過タイム)
 ...

【JRDB 追加候補】
 1. jrdb_bac.ten_index (テン指数)
 2. jrdb_bac.agari_index (上がり指数)
 3. jrdb_sed.pace_score (ペーススコア)
 4. jrdb_kyi.training_score (調教評価点)
 5. jrdb_bac.position_3corner (3コーナー位置取り)
 6. jrdb_bac.margin_leader (先頭との差)
 ...

追加可能カラム数: 180個
現在使用中: 139個
拡張余地: 41個以上
目標追加数: 61〜81個
```

---

## 🔍 トラブルシューティング

### エラー1: PostgreSQL接続失敗
```
psycopg2.OperationalError: connection to server failed
```
**対処**:
1. PostgreSQLサービス起動確認: `Get-Service postgresql*`
2. ポート確認: `netstat -ano | findstr :5432`
3. `config/db_config.yaml` の設定確認

---

### エラー2: CSV読み込み失敗
```
FileNotFoundError: data/raw/jravan_jrdb_merged_fixed.csv
```
**対処**:
1. ファイル存在確認: `dir E:\anonymous-keiba-ai-JRA\data\raw\*.csv`
2. 作業ディレクトリ確認: `pwd` (期待値: `...phase7\scripts\phase7a_feature_expansion`)

---

### エラー3: スクリプト実行順序ミス
```
FileNotFoundError: database_columns_detail_*.csv
```
**対処**:
- **正しい順序**: `investigate_database_sources.py` → `analyze_existing_features.py`
- 1本目が生成した `database_columns_detail_*.csv` を2本目が読み込む

---

## 📅 Week 1 進捗

| Day | タスク | 状態 | 成果物 |
|-----|--------|------|--------|
| 1-2 | **データベース調査スクリプト作成** | ✅ **完了** | investigate_database_sources.py<br>analyze_existing_features.py<br>PHASE7A_DATABASE_INVESTIGATION_GUIDE.md<br>PHASE7A_SCRIPTS_CREATED_20260303.md |
| 1-2 | **スクリプト実行・結果確認** | ⏳ **PC実行待ち** | 6個のCSVファイル（未生成）<br>追加候補リスト（未確定） |
| 3-4 | 候補選定・抽出スクリプト作成 | ⬜ 未着手 | extract_additional_features.py（未作成） |
| 5-6 | 統合マスターCSV生成 | ⬜ 未着手 | combined_features_master.csv（未作成） |
| 7 | Week 1完了報告 | ⬜ 未着手 | PHASE7A_WEEK1_COMPLETION_REPORT.md（未作成） |

**現在地**: ✅ Day 1-2 スクリプト作成完了 → ⏳ PC側実行待ち

---

## 🎯 成功基準

### Day 1-2 完了条件（現時点）
- [x] データベース調査スクリプト作成
- [x] 既存特徴量分析スクリプト作成
- [x] 実行ガイドドキュメント作成
- [x] 作業記録作成
- [x] Git コミット完了（5b5be31）
- [ ] **PC側でスクリプト実行**
- [ ] **6個のCSVファイル生成確認**
- [ ] **追加候補カラム60個以上確認**

### Day 1-2 完了条件（PC実行後）
- [ ] データベース総テーブル数: 20個以上
- [ ] 総カラム数: 300個以上
- [ ] JRA-VAN候補: 30個以上
- [ ] JRDB候補: 30個以上
- [ ] 追加候補合計: 60個以上（目標: 61〜81個）

---

## 📝 次のステップ（Day 3-4予定）

PC側でスクリプト実行・結果確認後、以下を実施：

### 1. 候補カラム精査
- JRA-VAN候補リストを確認
- JRDB候補リストを確認
- ROI向上に最も有望なカラムを選定（目標: 61〜81個）

### 2. 追加特徴量抽出スクリプト作成
- `extract_additional_features.py` 実装
- 選定したカラムを抽出するSQLクエリ作成
- 既存139カラムとの結合処理

### 3. 統合マスターCSV生成（Day 5-6）
- 既存139 + 追加61〜81 = 200〜220カラム
- `combined_features_master.csv` 生成
- データ品質チェック（欠損値、重複、データ型）

### 4. Week 1完了報告（Day 7）
- `PHASE7A_WEEK1_COMPLETION_REPORT.md` 作成
- 目標達成状況レビュー
- Phase 7-B準備

---

## 📂 ダウンロード推奨ファイル

PC側で以下のファイルを最優先でダウンロード・確認してください：

### 最優先（実行前必須）
1. **PHASE7A_DATABASE_INVESTIGATION_GUIDE.md**
   - サンドボックス: `/home/user/webapp/phase7/docs/00_overview/PHASE7A_DATABASE_INVESTIGATION_GUIDE.md`
   - PC: `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\PHASE7A_DATABASE_INVESTIGATION_GUIDE.md`
   - 理由: 実行手順・トラブルシューティング記載

### 参考資料
2. **PHASE7A_SCRIPTS_CREATED_20260303.md**
   - サンドボックス: `/home/user/webapp/docs/PHASE7A_SCRIPTS_CREATED_20260303.md`
   - PC: `E:\anonymous-keiba-ai-JRA\docs\PHASE7A_SCRIPTS_CREATED_20260303.md`
   - 理由: スクリプト仕様・期待される結果の詳細

3. **PHASE7A_DATABASE_INVESTIGATION_COMPLETE_20260303.md**（このファイル）
   - サンドボックス: `/home/user/webapp/docs/PHASE7A_DATABASE_INVESTIGATION_COMPLETE_20260303.md`
   - PC: `E:\anonymous-keiba-ai-JRA\docs\PHASE7A_DATABASE_INVESTIGATION_COMPLETE_20260303.md`
   - 理由: 完了報告・PC側実行指示書

---

## ✅ 確認チェックリスト

### サンドボックス側（完了）
- [x] investigate_database_sources.py 作成（7,795 bytes）
- [x] analyze_existing_features.py 作成（10,113 bytes）
- [x] PHASE7A_DATABASE_INVESTIGATION_GUIDE.md 作成（5,410 bytes）
- [x] PHASE7A_SCRIPTS_CREATED_20260303.md 作成（6,186 bytes）
- [x] PHASE7A_DATABASE_INVESTIGATION_COMPLETE_20260303.md 作成（このファイル）
- [x] Git add + commit 実施（5b5be31）
- [ ] Git push 実施（認証エラーのためPC側で実施）

### PC側（未実施、要実施）
- [ ] Git pull 実行（コミット5b5be31取得）
- [ ] phase7/ディレクトリ確認
- [ ] PostgreSQL起動確認
- [ ] investigate_database_sources.py 実行
- [ ] analyze_existing_features.py 実行
- [ ] 6個のCSVファイル生成確認
- [ ] 追加候補カラム60個以上確認
- [ ] 結果をサンドボックス側に報告

---

## 📌 重要な注意事項

1. **スクリプト実行順序**: 必ず `investigate_database_sources.py` → `analyze_existing_features.py` の順
2. **作業ディレクトリ**: `E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7a_feature_expansion` で実行
3. **PostgreSQL**: 実行前に必ず起動確認（ポート5432）
4. **CSV出力先**: `E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features\`
5. **エラー時**: PHASE7A_DATABASE_INVESTIGATION_GUIDE.md のトラブルシューティング参照

---

## 🎉 サンドボックス側作業完了

**Phase 7-A Week 1 Day 1-2 のサンドボックス側作業は完了しました。**

次はPC側での実行をお願いします。実行結果を報告していただければ、Day 3-4の作業（候補選定・抽出スクリプト作成）を続けます。

---

**作成者**: GenSpark AI Assistant  
**作成日時**: 2026-03-03  
**Git コミット**: 5b5be31  
**次回アクション**: PC側スクリプト実行・結果報告
