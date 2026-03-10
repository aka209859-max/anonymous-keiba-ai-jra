# Phase 7-B スクリプト更新手順（最新版へ上書き）

## 🔴 **問題**
PCの `phase7b_factor_roi` フォルダにあるスクリプトは古いバージョンで、パスが間違っています。

---

## ✅ **解決方法：GitHubから最新版を取得**

### **Step 1: genspark_ai_developer ブランチに切り替え**

```powershell
cd E:\anonymous-keiba-ai-JRA
git checkout genspark_ai_developer
```

**期待される出力**:
```
Switched to branch 'genspark_ai_developer'
Your branch is behind 'origin/genspark_ai_developer' by X commits...
```

---

### **Step 2: 最新版をPull**

```powershell
git pull origin genspark_ai_developer
```

**期待される出力**:
```
Updating ...
Fast-forward
 phase7/scripts/phase7b_factor_roi/create_merged_dataset_334cols.py | ...
 phase7/scripts/phase7b_factor_roi/generate_sql_for_334cols.py      | ...
 ...
```

---

### **Step 3: ファイル確認**

```powershell
Get-ChildItem E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi
```

**期待される出力**:
```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        2026/03/10     14:00           8464 generate_sql_for_334cols.py
-a----        2026/03/10     14:00           9532 create_merged_dataset_334cols.py
-a----        2026/03/10     14:00           8635 POWERSHELL_EXECUTION_GUIDE.md
...
```

---

### **Step 4: スクリプト実行**

```powershell
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b_factor_roi
python create_merged_dataset_334cols.py
```

---

## ⚠️ **もし `git checkout` でエラーが出た場合**

### **エラー: "Your local changes would be overwritten"**

```powershell
# ローカル変更を破棄して最新版に上書き
cd E:\anonymous-keiba-ai-JRA
git checkout genspark_ai_developer
git reset --hard origin/genspark_ai_developer
git pull origin genspark_ai_developer
```

**⚠️ 警告**: この操作はローカルの変更をすべて削除します。

---

### **エラー: "pathspec 'genspark_ai_developer' did not match"**

ブランチがローカルに存在しない場合：

```powershell
# リモートブランチ一覧確認
git branch -a

# リモートからブランチを取得
git fetch origin genspark_ai_developer

# ブランチ作成＆切り替え
git checkout -b genspark_ai_developer origin/genspark_ai_developer

# 最新版をPull
git pull origin genspark_ai_developer
```

---

## 🎯 **完全な実行手順（コピペ用）**

```powershell
# Step 1: Gitリポジトリへ移動
cd E:\anonymous-keiba-ai-JRA

# Step 2: 現在のブランチ確認
git branch

# Step 3: genspark_ai_developer ブランチに切り替え
git checkout genspark_ai_developer

# もしブランチが存在しない場合
# git fetch origin
# git checkout -b genspark_ai_developer origin/genspark_ai_developer

# Step 4: 最新版をPull
git pull origin genspark_ai_developer

# Step 5: ファイル確認
Get-ChildItem phase7\scripts\phase7b_factor_roi

# Step 6: スクリプト実行フォルダへ移動
cd phase7\scripts\phase7b_factor_roi

# Step 7: スクリプト実行
python create_merged_dataset_334cols.py
```

---

## 📊 **実行後の確認**

```powershell
# 1. ファイル存在確認
Get-ChildItem E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi

# 2. 行数確認（460,424行のはず）
(Get-Content E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv).Count - 1

# 3. カラム数確認（334列のはず）
(Get-Content E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv -First 1).Split(',').Count

# 4. ファイルサイズ確認（125.5 MBのはず）
(Get-Item E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv).Length / 1MB
```

---

## 🎉 **まとめ**

### **現在の状態**
- ✅ GitHubには最新版がコミット済み（5コミット）
- ❌ PCのブランチが `master` で古い
- ❌ PCのスクリプトのパスが間違っている（`phase7b` → 正: `phase7b_factor_roi`）

### **やること**
1. `git checkout genspark_ai_developer` でブランチ切り替え
2. `git pull origin genspark_ai_developer` で最新版取得
3. `python create_merged_dataset_334cols.py` で実行

---

**まずは `git checkout genspark_ai_developer` を実行してください！** 🚀
