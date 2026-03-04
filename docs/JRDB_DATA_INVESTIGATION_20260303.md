# JRDBデータ現状確認報告 - 2026-03-03

**確認日時**: 2026-03-03  
**確認場所**: E:\anonymous-keiba-ai-JRA\data

---

## 📊 現在のデータフォルダ構造

```
E:\anonymous-keiba-ai-JRA\data\
├── raw\              (JRA-VANの生データ？)
├── features\         (Phase 1-6の特徴量データ)
├── features_test\    (テスト用特徴量)
└── evaluation\       (評価データ)
```

---

## 🔍 JRDBデータ探索コマンド（PowerShell用）

### ステップ 1: JRDBデータを探す（正しいコマンド）

```powershell
# JRDBという名前のフォルダを探す
cd E:\
Get-ChildItem -Path E:\ -Recurse -Directory -Filter "*JRDB*" -ErrorAction SilentlyContinue

# .mdb ファイルを探す（Access データベース）
Get-ChildItem -Path E:\ -Recurse -Filter "*.mdb" -ErrorAction SilentlyContinue | Select-Object FullName, Length, LastWriteTime

# .accdb ファイルを探す（Access 2007以降）
Get-ChildItem -Path E:\ -Recurse -Filter "*.accdb" -ErrorAction SilentlyContinue | Select-Object FullName, Length, LastWriteTime

# .lzh ファイルを探す（JRDBは通常LZH圧縮）
Get-ChildItem -Path E:\ -Recurse -Filter "*.lzh" -ErrorAction SilentlyContinue | Select-Object FullName, Length, LastWriteTime
```

### ステップ 2: raw フォルダの中身を確認

```powershell
cd E:\anonymous-keiba-ai-JRA\data\raw
dir

# サブフォルダがあれば確認
Get-ChildItem -Recurse | Select-Object FullName, Length, LastWriteTime | Format-Table
```

### ステップ 3: 別のドライブも確認

```powershell
# Dドライブを確認
Get-ChildItem -Path D:\ -Recurse -Directory -Filter "*JRDB*" -ErrorAction SilentlyContinue

# Cドライブのユーザーフォルダを確認
Get-ChildItem -Path C:\Users\$env:USERNAME -Recurse -Directory -Filter "*JRDB*" -ErrorAction SilentlyContinue
```

---

## 🎯 Phase 7-A の状況判断

### **シナリオ A: JRDBデータがまだない場合**

**必要な作業**:
1. JRDBデータを入手する方法を確認
2. データ形式を決定（CSV推奨 or データベース）
3. 2016~2025年のデータを準備

**Phase 7-A の調整**:
- Day 1-2: JRDBデータ入手計画作成
- Day 3-4: JRA-VANデータ確認（既存のrawフォルダを調査）
- Day 5-7: 代替案の検討（JRA-VANのみで開始、JRDBは後で追加）

### **シナリオ B: JRDBデータがどこかにある場合**

**次の作業**:
1. データの場所を特定
2. データ形式を確認
3. 2016~2025年のデータ完全性を確認
4. Phase 7-A の計画通り実行

---

## 📋 確認してほしいこと

### 質問 1: JRA-VAN の raw データについて

```powershell
cd E:\anonymous-keiba-ai-JRA\data\raw
dir
```

**確認項目**:
- このフォルダには何が入っていますか？
- JRA-VANのデータベースファイル（.mdb/.accdb）がありますか？
- CSVファイルがありますか？
- サブフォルダ構造はどうなっていますか？

### 質問 2: JRDBデータの入手状況

以下のどれに該当しますか？

**A. JRDBデータを持っていない**
- → JRDBデータ入手方法を相談しましょう
- → Phase 7-A をJRA-VANのみで先に進めることも可能

**B. JRDBデータを持っているが場所がわからない**
- → 上記の探索コマンドを実行してください
- → 見つかったら場所を報告してください

**C. JRDBデータの入手方法がわからない**
- → JRDB公式サイトからのデータ取得方法を確認しましょう
- → データ形式（LZH圧縮、CSV、データベース等）を決定しましょう

**D. JRDBを使わずJRA-VANのみで進めたい**
- → Phase 7-A の計画を調整します
- → JRA-VAN 139次元のみで特徴量拡張を実施

---

## 🚀 次のアクション（優先順位順）

### **最優先: raw フォルダの中身を確認**

```powershell
cd E:\anonymous-keiba-ai-JRA\data\raw
dir
Get-ChildItem -Recurse | Select-Object FullName | Format-Table
```

このコマンドの実行結果を報告してください。

### **次: JRDBデータ探索**

上記のステップ1の探索コマンドを実行して、結果を報告してください。

### **その後: Phase 7-A の方針決定**

JRDBデータの状況に応じて、Phase 7-A の実施方針を決定します。

---

## 📝 Phase 7-A 調整案（JRDBデータがない場合）

### **代替プラン: JRA-VANのみで開始**

#### Day 1-2: JRA-VAN raw データ詳細調査
- `E:\anonymous-keiba-ai-JRA\data\raw` の完全な構造把握
- 利用可能なテーブル・カラムの一覧作成
- 前日情報のみの特定

#### Day 3-4: JRA-VAN 139次元の拡張調査
- Phase 6で使用していない追加カラムの発見
- 未使用テーブルからの特徴量候補抽出
- 目標: 139次元 → 150~170次元への拡張

#### Day 5-7: 特徴量マスター作成（JRA-VANのみ版）
- `jravan_available_features.csv`: 150~170次元
- `jravan_expanded_features.csv`: 新規追加候補
- Phase 7-B でこれらのROI分析を実施

**JRDBは後で追加可能**: Phase 7-B 以降でJRDBデータが準備できたら統合

---

## ✅ 報告してください

以下の情報を報告してください:

1. **raw フォルダの中身**:
   ```powershell
   cd E:\anonymous-keiba-ai-JRA\data\raw
   dir
   ```

2. **JRDBデータ探索結果**:
   ```powershell
   Get-ChildItem -Path E:\ -Recurse -Directory -Filter "*JRDB*" -ErrorAction SilentlyContinue
   ```

3. **JRDBデータの状況**: 上記のA/B/C/Dのどれに該当しますか？

---

**まず raw フォルダの中身を確認して、報告してください 🚀**
