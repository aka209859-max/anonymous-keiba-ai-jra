# Phase 7-B 統合データセット作成 - PowerShell実行手順

## 📋 概要

**目的**: JRA-VAN (218列) + JRDB (116列) = 334列の統合データセットを作成

**入力ファイル**:
- `E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv`

**出力ファイル**:
- `E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv`

**予想処理時間**: 約10-15分

**出力行数**: 約460,424行

**出力列数**: 334列

**ファイルサイズ**: 約125.5 MB

---

## 🚀 実行手順（Windows PowerShell）

### **Step 1: フォルダ確認**

```powershell
# 現在のフォルダ構造を確認
cd E:\anonymous-keiba-ai-JRA
Get-ChildItem -Directory

# Phase 7-B フォルダ確認
Get-ChildItem phase7\scripts -Directory
Get-ChildItem phase7\scripts\phase7b_factor_roi -File
```

**期待される出力**:
```
phase7\scripts\phase7b_factor_roi\
  - create_merged_dataset_334cols.py  (8,386バイト)
  - generate_sql_for_334cols.py      (7,588バイト)
```

---

### **Step 2: スクリプト実行（2つの方法）**

#### **方法1: 統合スクリプト実行（推奨）**

```powershell
# Phase 7-B フォルダへ移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi

# 統合データセット作成スクリプト実行（SQL自動生成→データ取得→CSV保存）
python create_merged_dataset_334cols.py
```

**この方法の特徴**:
- ✅ **1コマンドで完結**
- ✅ CSV読み込み → SQL自動生成 → データ取得 → CSV保存まで全自動
- ✅ エラーハンドリング完備

---

#### **方法2: 2段階実行（デバッグ用）**

```powershell
# Phase 7-B フォルダへ移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi

# Step 2-1: SQL自動生成スクリプト実行
python generate_sql_for_334cols.py

# Step 2-2: 生成されたSQLファイルを確認
notepad E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi\generated_sql_334cols.sql

# Step 2-3: 統合データセット作成スクリプト実行
python create_merged_dataset_334cols.py
```

**この方法の特徴**:
- 🔍 SQL内容を確認できる
- 🐛 デバッグに便利

---

### **Step 3: 実行中の画面出力**

実行すると以下のような出力が表示されます：

```
================================================================================
Phase 7-B: JRA-VAN + JRDB 統合データセット作成（自動SQL生成版）
実行時刻: 2026-03-10 14:30:00
================================================================================

📂 出力ディレクトリ作成: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi
   ✅ 完了

📄 CSV確認: E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv
   ✅ 確認完了

🔧 SQL自動生成中...

【テーブル別カラム数】
--------------------------------------------------------------------------------
  jrd_bac              :   9 カラム
  jrd_cyb              :  18 カラム
  jrd_joa              :  10 カラム
  jrd_kyi              :  65 カラム
  jrd_sed              :  14 カラム
  jvd_br               :   1 カラム
  jvd_bt               :   2 カラム
  jvd_ch               :   1 カラム
  jvd_ck               :  31 カラム
  jvd_dm               :  16 カラム
  jvd_h1               :  23 カラム
  jvd_h6               :   6 カラム
  jvd_hc               :   8 カラム
  jvd_hn               :   5 カラム
  jvd_hr               :  12 カラム
  jvd_jg               :   3 カラム
  jvd_ra               :  23 カラム
  jvd_se               :  37 カラム
  jvd_sk               :  10 カラム
  jvd_um               :  17 カラム
  jvd_wc               :  14 カラム
--------------------------------------------------------------------------------
  合計                 : 325 カラム

   ✅ SQL自動生成完了
   総行数: 389 行

🔌 PostgreSQL接続中...
   ✅ 接続成功

📊 データ取得中（約10-15分かかる可能性があります）...
   対象期間: 2016-2025年（確定レースのみ）
   予想行数: 約460,424行

   ✅ 取得完了: 460,424 行 × 334 列

================================================================================
📈 データ概要
================================================================================
行数: 460,424
列数: 334
メモリ使用量: 125.5 MB

【最初の5行】
     race_id  umaban  kaisai_tsukihi  ...
0  2016010101      01        0101  ...
1  2016010101      02        0101  ...
2  2016010101      03        0101  ...
3  2016010101      04        0101  ...
4  2016010101      05        0101  ...

【欠損値サマリー】
✅ 欠損値なし（すべて100%充填）

================================================================================
💾 CSV保存中...
================================================================================
保存先: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv

   ✅ 保存完了
   ファイルサイズ: 125.5 MB

================================================================================
🎉 Phase 7-B 統合データセット作成完了！
================================================================================

【次のステップ】
1. 単一カラムROI分析スクリプト実行
   → python single_column_roi_analysis.py

2. Top 100カラム選定
   → ROI ≥ 105%のカラムを抽出

完了時刻: 2026-03-10 14:45:00
================================================================================
```

---

### **Step 4: 実行後の確認**

```powershell
# 出力ファイルを確認
Get-ChildItem E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi

# ファイルサイズ確認（約125.5 MBのはず）
(Get-Item E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv).Length / 1MB

# 行数確認（約460,424行のはず）
(Get-Content E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv).Count - 1

# カラム数確認（334列のはず）
(Get-Content E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv -First 1).Split(',').Count
```

---

## ⚠️ エラー対処法

### **エラー1: CSVファイルが見つからない**

```
❌ ファイルが見つかりません: E:\anonymous-keiba-ai-JRA\docs\PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv
```

**対処法**:
```powershell
# ファイルの存在確認
Get-ChildItem E:\anonymous-keiba-ai-JRA\docs -Filter "*PHASE7A*.csv"

# ファイルが見つからない場合はGitHubから取得
# または sandbox の /home/user/webapp/docs/PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv をコピー
```

---

### **エラー2: PostgreSQL接続失敗**

```
❌ 接続失敗: could not connect to server: Connection refused
```

**対処法**:
```powershell
# PostgreSQL起動確認
Get-Service -Name postgresql*

# 起動していない場合は起動
Start-Service postgresql-x64-16

# 接続テスト
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT COUNT(*) FROM jvd_se;"
```

---

### **エラー3: メモリ不足**

```
❌ 取得失敗: MemoryError
```

**対処法**:
```powershell
# Pythonの64bit版を使用していることを確認
python --version

# 必要に応じてチャンク処理に変更（スクリプト修正）
```

---

## 📊 期待される結果

**成功時の最終出力**:

| 項目 | 値 |
|---|---|
| **出力ファイル** | `jravan_jrdb_merged_334cols_2016_2025.csv` |
| **行数** | 約460,424行 |
| **列数** | 334列 |
| **ファイルサイズ** | 約125.5 MB |
| **欠損率** | 0% （100%充填） |
| **データ期間** | 2016-2025年 |
| **処理時間** | 約10-15分 |

---

## 🎯 次のステップ

Phase 7-B 統合データセット作成完了後：

1. **単一カラムROI分析**
   - `python single_column_roi_analysis.py`
   - 334カラムすべてのROIを個別計算

2. **Top 100カラム選定**
   - ROI ≥ 105%のカラムを抽出
   - `phase7b_top100_columns.csv` 作成

3. **Phase 7-C へ移行**
   - 2カラム組み合わせ分析開始
   - 目標: 2カラム組み合わせで ROI ≥ 105%

---

## 📝 補足

- **PC環境推奨**: RAM 8GB以上、Python 3.8以上
- **PostgreSQL**: バージョン16以上推奨
- **処理時間**: データ量により前後する可能性あり
- **CSV エンコーディング**: UTF-8 with BOM（Excel互換）

---

以上で Phase 7-B 統合データセット作成完了です！ 🎉
