# Phase 7-A Week 1 開始計画書

**作成日**: 2026-03-03  
**対象期間**: Week 1（7日間）  
**フェーズ**: Phase 7-A（特徴量拡張調査）

---

## 🎯 Phase 7-A の目標

**JRA-VAN 139次元 + JRDB 60~80次元 = 220次元基盤の構築**

---

## 📋 3つのコアドキュメントからの抽出タスク

### **PHASE7_WORKFLOW.md から**

#### タスク 7-A1: データソース統合確認
- [ ] JRA-VAN: 139次元の確認
- [ ] JRDB: 利用可能データ項目一覧取得
- [ ] 共通キー（race_date, keibajo_code, race_no, umaban）確認

#### タスク 7-A2: クロスソース特徴量候補リスト作成
- [ ] JRA-VAN単独: 139次元
- [ ] JRDB単独: 60~80次元
- [ ] 合計: 200~220次元

#### タスク 7-A3: 追加ファクター調査
- [ ] 卍氏45ファクターとの照合
- [ ] Benter 130+変数との照合
- [ ] 文献・成功事例からの追加候補

### **PHASE7_ROADMAP.md から**

#### Day 1-2: データソース確認
- [ ] JRA-VAN: 既存139次元の詳細確認
- [ ] JRDB: 利用可能データ項目一覧取得
- [ ] 共通キー検証（race_date, keibajo_code等）

#### Day 3-4: クロスソース候補作成
- [ ] JRA-VAN単独: 139次元リスト
- [ ] JRDB単独: 60~80次元リスト
- [ ] クロスソース候補: 例）前走脚質 × テン指数順位

#### Day 5-7: 追加ファクター調査
- [ ] 卍氏45ファクターとの照合
- [ ] Benter 130+変数との照合
- [ ] 最終特徴量マスター確定（200~220次元）

### **PHASE7_STRATEGY.md から**

#### アプローチ

1. **JRA-VANの深掘り**
   - [ ] 既存139次元の詳細確認
   - [ ] 未使用テーブル・カラムの調査
   - [ ] 前日確定情報の範囲確定

2. **JRDBの統合**
   - [ ] テン指数、上がり指数、馬場指数
   - [ ] 展開予想、調教指数
   - [ ] 独自評価（厩舎評価等）

3. **クロスソース候補生成**
   - [ ] 例1: JRA-VAN「前走脚質=逃げ」× JRDB「テン指数順位≤3」
   - [ ] 例2: JRA-VAN「騎手勝率≥15%」× JRDB「馬場指数≥70」

---

## 📊 Phase 7-A の実施計画（Week 1）

### **Day 1-2: JRDBデータ現状確認調査**

#### 🔍 調査項目

1. **データ保有状況確認**
   - [ ] PC側（E:\anonymous-keiba-ai-JRA）でJRDBデータ保存場所を確認
   - [ ] データ形式: データベース（.mdb/.accdb）or CSV形式?
   - [ ] 利用可能なJRDBファイル一覧取得
   
2. **データ期間確認**
   - [ ] 2016年~2025年のデータが揃っているか確認
   - [ ] 年別のレース数カウント
   - [ ] 欠損期間の有無チェック

3. **JRDBファイル種類確認**
   - [ ] BAC（馬基本データ）
   - [ ] SED（レース詳細データ）
   - [ ] KYI（競走馬調教データ）
   - [ ] その他利用可能ファイル

#### 📦 Day 1-2 成果物
- `jrdb_data_inventory_report.txt`: JRDBデータ現状報告書
- `jrdb_available_files_list.csv`: 利用可能ファイル一覧

---

### **Day 3-4: JRA-VAN 139次元詳細リスト作成**

#### 🔍 調査項目

1. **既存Phase 6のJRA-VAN特徴量確認**
   - [ ] Phase 6で使用している139次元の詳細リスト取得
   - [ ] テーブル名、カラム名、データ型、説明を記録

2. **前日確定情報の範囲確定**
   - [ ] 前日21時時点で確定している情報のみリストアップ
   - [ ] 当日情報（馬体重、リアルタイムオッズ）を除外

3. **未使用テーブル・カラムの調査**
   - [ ] JRA-VANデータベース全体の調査
   - [ ] 前日情報で利用可能な未使用カラムの発見

#### 📦 Day 3-4 成果物
- `jravan_available_features.csv`: JRA-VAN 139次元詳細リスト
  - カラム: feature_id, feature_name, table_name, data_type, description, is_prior_day_available

---

### **Day 5-6: JRDB 60~80次元候補リスト作成**

#### 🔍 調査項目

1. **JRDBデータ項目の抽出**
   - [ ] テン指数、上がり指数、馬場指数
   - [ ] 展開予想コード
   - [ ] 調教指数、調教評価
   - [ ] 厩舎評価、騎手評価
   - [ ] 前走データ（着順、タイム等）

2. **前日情報確認**
   - [ ] JRDBデータの更新タイミング確認
   - [ ] 前日21時時点で取得可能な項目の特定

3. **データ型・範囲の記録**
   - [ ] 各項目のデータ型（数値、カテゴリカル等）
   - [ ] 取りうる値の範囲
   - [ ] 欠損値の有無

#### 📦 Day 5-6 成果物
- `jrdb_available_features.csv`: JRDB 60~80次元候補リスト
  - カラム: feature_id, feature_name, jrdb_file_source, data_type, value_range, description

---

### **Day 7: 統合マスター作成とクロスソース候補生成**

#### 🔍 統合作業

1. **統合特徴量マスター作成**
   - [ ] JRA-VAN 139次元 + JRDB 60~80次元を統合
   - [ ] 重複チェック（同一情報の重複を除外）
   - [ ] 最終次元数の確定（目標: 200~220次元）

2. **クロスソース候補生成**
   - [ ] JRA-VAN × JRDBの組み合わせ候補リスト作成
   - [ ] 期待される相乗効果の記述
   - [ ] 優先度付け（高・中・低）

3. **データ結合検証**
   - [ ] SQL結合クエリの作成
   - [ ] サンプルデータでの結合テスト（2024年データ）
   - [ ] 結合成功率の確認（目標: ≥95%）

#### 📦 Day 7 成果物
- `combined_features_master.csv`: 統合特徴量マスター（220次元）
  - カラム: feature_id, feature_name, source (JRA-VAN/JRDB), data_type, description
- `cross_source_feature_candidates.csv`: クロスソース候補
  - カラム: candidate_id, jravan_feature, jrdb_feature, expected_synergy, priority

---

## 📊 Phase 7-A 成果物サマリー

| # | ファイル名 | 保存先 | 説明 |
|---|-----------|--------|------|
| 1 | `jrdb_data_inventory_report.txt` | `phase7/results/phase7a_features/` | JRDBデータ現状報告 |
| 2 | `jrdb_available_files_list.csv` | `phase7/results/phase7a_features/` | 利用可能JRDBファイル一覧 |
| 3 | `jravan_available_features.csv` | `phase7/results/phase7a_features/` | JRA-VAN 139次元詳細リスト |
| 4 | `jrdb_available_features.csv` | `phase7/results/phase7a_features/` | JRDB 60~80次元候補リスト |
| 5 | `combined_features_master.csv` | `phase7/results/phase7a_features/` | 統合特徴量マスター（220次元） |
| 6 | `cross_source_feature_candidates.csv` | `phase7/results/phase7a_features/` | クロスソース候補 |

**合計: 6ファイル**

---

## 🚀 次のアクション（今すぐ実施）

### ステップ 1: PC側でJRDBデータ確認

PC側で以下のPowerShellコマンドを実行してください:

```powershell
# JRDBデータ保存場所の確認
cd E:\anonymous-keiba-ai-JRA
dir /s *.mdb
dir /s *.accdb
dir /s JRDB*

# 年別フォルダ確認
cd data
dir

# もし見つからない場合、別のドライブを確認
cd E:\
dir /s JRDB*
```

### ステップ 2: JRDBデータ現状報告

以下の情報を報告してください:

1. **JRDBデータの保存場所**: （例: E:\JRDB\data\ または E:\anonymous-keiba-ai-JRA\data\jrdb\）
2. **データ形式**: （データベース .mdb/.accdb、CSV、LZH圧縮ファイル等）
3. **年別データの有無**: 2016年~2025年のデータが揃っているか?
4. **ファイル一覧**: 利用可能なJRDBファイルの種類（BAC, SED, KYI等）

---

## 📋 開始前チェックリスト

### 必須確認事項

- [x] Phase 7 ディレクトリ構造作成完了
- [x] 3つのコアドキュメント確認完了
- [ ] **JRDBデータ現状確認** ← **次のタスク**
- [ ] JRA-VAN 139次元詳細確認
- [ ] 開発環境準備（Python, pandas, numpy等）

### 開発環境チェック

- [ ] Python 3.8以上インストール済み
- [ ] pandas, numpy インストール済み
- [ ] pyodbc（データベースアクセス用）インストール済み
- [ ] ディスク容量確認（CSV出力用に1GB以上推奨）

---

## 🎯 Phase 7-A 完了条件

### 完了基準

- [ ] JRDBデータ現状が完全に把握できている
- [ ] JRA-VAN 139次元の詳細リストが完成している
- [ ] JRDB 60~80次元の候補リストが完成している
- [ ] 統合特徴量マスター（220次元）が確定している
- [ ] クロスソース候補が20個以上生成されている
- [ ] データ結合検証が成功している（結合成功率 ≥95%）
- [ ] 全6ファイルが `phase7/results/phase7a_features/` に保存されている

### 品質基準

- [ ] 全CSVファイルが正しいフォーマットで保存されている
- [ ] 欠損値・異常値が適切に処理されている
- [ ] ドキュメントが日本語で明確に記述されている
- [ ] 再現可能性が担保されている（スクリプト化されている）

---

## 📝 Phase 7-A 実施記録（随時更新）

### 2026-03-03
- [x] Phase 7-A Week 1 開始計画書作成
- [ ] PC側でJRDBデータ現状確認実施 ← **次のアクション**

---

**Phase 7-A Week 1 開始準備完了！次はJRDBデータ現状確認からスタートします 🚀**
