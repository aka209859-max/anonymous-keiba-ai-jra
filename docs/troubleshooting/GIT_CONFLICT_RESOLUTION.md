# Phase 6: Git競合解決とスクリプト取得手順

## 問題
ローカルに未コミットのファイルがあり、git pullがブロックされている

## 解決手順

### 方法1: 既存ファイルをコミットしてからpull（推奨）

```powershell
cd E:\anonymous-keiba-ai-JRA

# 現在の作業内容を全てコミット
git add .
git commit -m "chore: ローカル作業ファイルをコミット（Phase 6実装前）"

# リモートから最新コードを取得（マージ）
git pull origin genspark_ai_developer
```

### 方法2: stashを使って一時退避

```powershell
cd E:\anonymous-keiba-ai-JRA

# 現在の変更を一時退避
git stash save "Phase 6実装前のローカル変更"

# リモートから最新コードを取得
git pull origin genspark_ai_developer

# 退避した変更を復元（必要な場合）
git stash pop
```

### 方法3: GitHubから直接ダウンロード（最も簡単）

```powershell
cd E:\anonymous-keiba-ai-JRA

# scripts/phase6フォルダを作成
New-Item -ItemType Directory -Path "scripts\phase6" -Force

# GitHubから直接ダウンロード
$url = "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/f320aef/scripts/phase6/fetch_today_data.py"
Invoke-WebRequest -Uri $url -OutFile "scripts\phase6\fetch_today_data.py"

# ダウンロード確認
Get-ChildItem scripts\phase6\
```

### 方法4: 強制的にリモートに合わせる（注意: ローカル変更が消える）

```powershell
cd E:\anonymous-keiba-ai-JRA

# ローカルの変更を破棄してリモートに合わせる
git fetch origin
git reset --hard origin/genspark_ai_developer

# ⚠️ 警告: この方法はローカルの未コミット変更を全て削除します
```

---

## 推奨: 方法3（直接ダウンロード）を実行

以下のコマンドを実行してください：

```powershell
# scripts/phase6フォルダ作成
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\scripts\phase6" -Force

# fetch_today_data.pyをダウンロード
$url = "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/f320aef/scripts/phase6/fetch_today_data.py"
Invoke-WebRequest -Uri $url -OutFile "E:\anonymous-keiba-ai-JRA\scripts\phase6\fetch_today_data.py"

# ダウンロード確認
Get-ChildItem E:\anonymous-keiba-ai-JRA\scripts\phase6\

# スクリプト実行
python E:\anonymous-keiba-ai-JRA\scripts\phase6\fetch_today_data.py
```
