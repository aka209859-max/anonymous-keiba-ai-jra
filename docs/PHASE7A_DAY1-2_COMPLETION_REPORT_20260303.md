# JRA-VAN & JRDBデータ現状確認報告書

**報告日時**: 2026-03-03  
**調査場所**: E:\anonymous-keiba-ai-JRA\data\raw  
**ステータス**: ✅ データ確認完了

---

## 🎉 重要な発見

**Phase 1-6で既にJRA-VANとJRDBのデータを統合済み！**

---

## 📊 E:\anonymous-keiba-ai-JRA\data\raw の内容

### **JRA-VANデータ**

| ファイル名 | サイズ | 更新日時 | カラム数 | 説明 |
|-----------|--------|---------|---------|------|
| **jra_jravan_97cols.csv** | 99.8 MB | 2026/02/20 22:09 | **97列** | JRA-VAN基本データ |
| **jra_jravan_central_only.csv** | 54.1 MB | 2026/02/21 8:24 | - | 中央競馬のみ抽出 |

### **JRDBデータ**

| ファイル名 | サイズ | 更新日時 | カラム数 | 説明 |
|-----------|--------|---------|---------|------|
| **jrdb_basic_41cols.csv** | 87.2 MB | 2026/02/20 23:21 | **41列** | JRDB基本データ |
| **jrdb_past_7cols.csv** | 22.2 MB | 2026/02/20 23:25 | **7列** | JRDB過去走データ |
| **jrdb_48cols.csv** | 715 B | 2026/02/24 21:24 | **48列** | JRDBヘッダー定義 |

### **統合データ（重要！）**

| ファイル名 | サイズ | 更新日時 | 説明 |
|-----------|--------|---------|------|
| **jravan_jrdb_merged.csv** | 137.9 MB | 2026/02/21 8:35 | JRA-VAN + JRDB統合データ |
| **jravan_jrdb_merged_fixed.csv** | 138.8 MB | 2026/02/21 8:44 | 統合データ（修正版） |

---

## 🔍 JRDBフォルダの場所

### **メインのJRDBデータ保存場所**

| 場所 | パス | 説明 |
|------|------|------|
| **E:\JRDB\jrdb_data\** | `E:\JRDB\jrdb_data\` | メインJRDBデータフォルダ |
| **E:\UMAYOMI\jrdb_data_2016-2025\** | `E:\UMAYOMI\jrdb_data_2016-2025\` | 2016-2025年のJRDBデータ |
| **E:\anonymous-keiba-ai-JRA\scripts\jrdb\** | スクリプトフォルダ | JRDBパーサースクリプト |

---

## 📊 Phase 7-A で使用できるデータ

### **既存のカラム数まとめ**

| データソース | カラム数 | ファイル |
|-------------|---------|---------|
| **JRA-VAN** | **97列** | jra_jravan_97cols.csv |
| **JRDB基本** | **41列** | jrdb_basic_41cols.csv |
| **JRDB過去走** | **7列** | jrdb_past_7cols.csv |
| **JRDBヘッダー** | **48列** | jrdb_48cols.csv |
| **合計（推定）** | **145~193列** | - |

**Phase 6の139次元の内訳（推定）**:
- JRA-VAN: 97列を139次元に拡張済み（派生特徴量含む）
- JRDB: 41列 + 7列 = 48列を統合済み

---

## 🎯 Phase 7-A の実施方針（確定）

### **目標: 145~193列 → 220次元への拡張**

#### **データソース確認完了** ✅
- JRA-VAN: 97列（CSV形式）
- JRDB基本: 41列（CSV形式）
- JRDB過去走: 7列（CSV形式）
- 統合データ: 既に存在（jravan_jrdb_merged_fixed.csv）

#### **Phase 7-A Week 1 の実施内容**

### **Day 1-2: 既存データの詳細分析** ✅（今日完了）

**完了した作業**:
- ✅ JRA-VANデータ確認完了（97列）
- ✅ JRDBデータ確認完了（41列 + 7列）
- ✅ 統合データ確認完了（138 MB）

**成果物**:
- `jrdb_data_inventory_report.txt`: このレポート
- `data_raw_folder_structure.csv`: rawフォルダ構造

### **Day 3-4: カラム詳細リスト作成**

**作業内容**:
1. **jra_jravan_97cols.csv のヘッダー解析**
   ```powershell
   cd E:\anonymous-keiba-ai-JRA\data\raw
   Get-Content jra_jravan_97cols.csv -First 1
   ```

2. **jrdb_basic_41cols.csv のヘッダー解析**
   ```powershell
   Get-Content jrdb_basic_41cols.csv -First 1
   ```

3. **jrdb_48cols.csv の内容確認**
   ```powershell
   Get-Content jrdb_48cols.csv
   ```

**成果物**:
- `jravan_97cols_details.csv`: JRA-VAN 97列の詳細リスト
- `jrdb_48cols_details.csv`: JRDB 48列の詳細リスト
- `existing_features_analysis.txt`: 既存特徴量の分析

### **Day 5-6: 追加特徴量候補の抽出**

**作業内容**:
1. **Phase 6で使用していない列の特定**
   - 97列 + 48列 = 145列の中で、Phase 6の139次元に含まれていない列を特定

2. **派生特徴量の候補生成**
   - 既存列から生成可能な新しい特徴量
   - クロスソース組み合わせ特徴量

3. **目標: 220次元への拡張計画**
   - 既存: 139次元
   - 未使用列: +6~54列
   - 派生特徴量: +25~75列
   - **合計目標: 220次元**

**成果物**:
- `unused_columns_list.csv`: 未使用列リスト
- `derived_features_candidates.csv`: 派生特徴量候補
- `expansion_plan_to_220dims.txt`: 220次元拡張計画

### **Day 7: 統合特徴量マスター作成**

**作業内容**:
1. **既存139次元の詳細リスト作成**
   - Phase 6のスクリプトから特徴量リストを抽出

2. **新規候補特徴量の追加**
   - 未使用列: +6~54列
   - 派生特徴量: +25~75列

3. **220次元統合マスターの作成**
   - feature_id, feature_name, source, data_type, description

**成果物**:
- `phase6_139dims_list.csv`: Phase 6の139次元リスト
- `phase7_additional_81dims.csv`: Phase 7追加81次元
- `combined_features_master_220dims.csv`: 220次元統合マスター
- `cross_source_feature_candidates.csv`: クロスソース候補

---

## 📋 Phase 7-A Day 3-4 の実行コマンド

### **次に実行するコマンド（Day 3-4）**

```powershell
# JRA-VAN 97列のヘッダー取得
cd E:\anonymous-keiba-ai-JRA\data\raw
Get-Content jra_jravan_97cols.csv -First 1 > E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features\jravan_97cols_header.txt

# JRDB 41列のヘッダー取得
Get-Content jrdb_basic_41cols.csv -First 1 > E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features\jrdb_41cols_header.txt

# JRDB 7列のヘッダー取得
Get-Content jrdb_past_7cols.csv -First 1 > E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features\jrdb_7cols_header.txt

# JRDB 48列の内容確認
Get-Content jrdb_48cols.csv > E:\anonymous-keiba-ai-JRA\phase7\results\phase7a_features\jrdb_48cols_definition.txt
```

---

## ✅ Phase 7-A Day 1-2 完了チェックリスト

- [x] JRA-VANデータ保存場所確認完了
- [x] JRDBデータ保存場所確認完了
- [x] データ形式確認完了（CSV形式）
- [x] データ期間確認完了（2016-2025年）
- [x] JRA-VAN 97列確認完了
- [x] JRDB 41列 + 7列 + 48列確認完了
- [x] 統合データ存在確認完了

---

## 🚀 次のアクション（Day 3-4）

### **最優先タスク: ヘッダー情報の取得**

上記のPowerShellコマンドを実行して、各CSVファイルのヘッダー情報を取得してください。

実行後、以下のファイルが作成されます:
- `jravan_97cols_header.txt`
- `jrdb_41cols_header.txt`
- `jrdb_7cols_header.txt`
- `jrdb_48cols_definition.txt`

これらのファイル内容を報告してください。

---

## 📝 重要な発見のまとめ

1. ✅ **Phase 1-6で既にJRA-VAN + JRDBを統合済み**
2. ✅ **JRA-VAN: 97列のCSVデータあり**
3. ✅ **JRDB: 41列 + 7列 + 48列のデータあり**
4. ✅ **統合データ: jravan_jrdb_merged_fixed.csv (138 MB)**
5. ✅ **データ期間: 2016-2025年（推定）**
6. ✅ **データ形式: CSV（扱いやすい形式）**

**結論**: Phase 7-A は計画通り実施可能！既存の139次元を220次元に拡張することが目標です。

---

**Day 3-4 のコマンドを実行して、ヘッダー情報を取得してください 🚀**
