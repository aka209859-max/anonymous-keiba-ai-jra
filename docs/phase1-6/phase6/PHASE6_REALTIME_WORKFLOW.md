# Phase 6: リアルタイム予想ワークフロー（簡潔版）

## 📅 作成日時
2026-02-22

---

## 🎯 **目的**
Phase 5アンサンブルモデルを使って、**当日のレースを予想する**

---

## 📊 **現状整理**

### ✅ **完了済み**
- Phase 1-2: データ準備（2016-2025年、483,369レース）
- Phase 3: 二値分類モデル（AUC 0.9419）
- Phase 4-A: ランキングモデル（NDCG@3 0.8597）
- Phase 4-B: タイム予測モデル（RMSE 4.84秒）
- Phase 5: アンサンブル統合（本命top3 84.43%, 対抗top3 73.41%）

### 📦 **使用可能なリソース**
- 学習済みモデル:
  - `models/jra_binary_model.txt`
  - `models/jra_ranking_model.txt`
  - `models/jra_regression_model_optimized.txt`
- 特徴量生成ロジック: `scripts/phase2b/feature_engineering.py`
- 予測スクリプト: `scripts/phase5/ensemble_prediction.py`

### 🔌 **PC-KEIBA接続情報**
- PostgreSQL: `127.0.0.1:5432`
- データベース: `pckeiba`
- 認証: `postgres / postgres123`

---

## ❓ **3つの重要な質問（Phase 6の核心）**

### 🔴 **質問1: JRA-VANデータの当日取得**

**確認すること**:
```powershell
# PC-KEIBAの自動更新設定を確認
Get-Content "$env:APPDATA\PC-KEIBA Database\AppConfig.xml" | Select-String "Jidokoshin"
```

**予想される答え**:
- ✅ **自動更新ON**: PC-KEIBAが定期的にJRA-VANサーバーと同期
  - → `jra_shutsuba`テーブルに当日データが自動で入る
  - → Pythonから直接PostgreSQLクエリで取得可能
- ❌ **手動更新必要**: PC-KEIBAソフトで「データ更新」ボタンを押す
  - → 更新後にPythonスクリプト実行

**確認方法**:
```python
# 今日の日付のデータがあるか確認
import psycopg2
from datetime import datetime

conn = psycopg2.connect(host='127.0.0.1', port=5432, database='pckeiba', 
                        user='postgres', password='postgres123')
cursor = conn.cursor()

today = datetime.now().strftime('%Y%m%d')
cursor.execute(f"""
    SELECT COUNT(*) FROM jra_shutsuba 
    WHERE kaisai_nen = {today[:4]} AND kaisai_tsukihi = '{today}'
""")
count = cursor.fetchone()[0]
print(f"今日のレースデータ: {count}件")
conn.close()
```

---

### 🔴 **質問2: JRDBデータの当日取得**

**確認すること**:
```powershell
# JRDBファイルの保存場所を探す
Get-ChildItem C:\ -Recurse -Include "BAC*.txt","SED*.txt" -ErrorAction SilentlyContinue | 
    Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)} |
    Select-Object FullName, LastWriteTime
```

**予想される答え**:
- **パターンA**: PC-KEIBAがJRDBファイルを自動取り込み
  - → PostgreSQLの専用テーブル（例: `jrdb_bac`, `jrdb_sed`）に保存
  - → Pythonから直接クエリで取得可能
  
- **パターンB**: JRDBファイルは固定フォルダに保存されるのみ
  - → 例: `C:\PC-KEIBA\JRDB\BAC20260222.txt`
  - → Pythonで固定長ファイルをパース必要

- **パターンC**: JRDB会員サイトから手動ダウンロード必要
  - → 毎朝ダウンロード → 指定フォルダに保存 → Python処理

**AppConfig.xmlのヒント**:
```xml
<DirectoryGaibuShisu />  <!-- 外部指数ディレクトリ（空=未設定？） -->
```

---

### 🔴 **質問3: 予想ワークフロー（自動化レベル）**

**3つのシナリオ**:

#### 🟢 **シナリオA: 完全自動化（理想）**
```
06:00  PC-KEIBA自動更新（JRA-VAN + JRDB）
       ↓
07:00  Pythonスクリプト自動実行（Windowsタスクスケジューラ）
       ↓
       1. PostgreSQLから当日データ取得
       2. 特徴量生成（Phase 2-Bロジック）
       3. Phase 5アンサンブル予測
       4. results/predictions_20260222.csv 出力
       ↓
07:30  予想結果確認、投票判断
```

#### 🟡 **シナリオB: 半自動化（現実的）**
```
朝     【手動】JRDB会員サイトからBACファイルダウンロード
       ↓
       【手動】PC-KEIBAで「データ更新」クリック
       ↓
       【自動】Pythonスクリプト実行
       ↓
       1. PostgreSQL + JRDBファイル取得
       2. 特徴量生成
       3. Phase 5予測
       4. 結果CSV出力
```

#### 🔴 **シナリオC: 手動実行（最小限）**
```
レース前  【手動】データ確認
          ↓
          【手動】Pythonスクリプト実行
          ↓
          予想結果確認
```

---

## 🚀 **次のアクション（優先順位順）**

### 🔴 **最優先: 質問1の答えを確認**
```powershell
# 今日の日付のレースデータがPC-KEIBAにあるか確認
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

python -c "import psycopg2; from datetime import datetime; conn=psycopg2.connect(host='127.0.0.1',port=5432,database='pckeiba',user='postgres',password='postgres123'); cur=conn.cursor(); today=datetime.now().strftime('%Y%m%d'); cur.execute(f\"SELECT COUNT(*) FROM jra_shutsuba WHERE kaisai_nen={today[:4]} AND kaisai_tsukihi='{today}'\"); print(f'今日のレースデータ: {cur.fetchone()[0]}件'); conn.close()"
```

**期待結果**:
- `今日のレースデータ: 0件` → 手動更新またはデータ未取得
- `今日のレースデータ: 120件` → 自動更新成功（当日レース数）

---

### 🟡 **次: 質問2の答えを確認**
```powershell
# JRDBファイル検索
Get-ChildItem C:\ -Recurse -Include "BAC*.txt" -ErrorAction SilentlyContinue | 
    Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-3)} |
    Select-Object FullName, LastWriteTime, Length
```

**期待結果**:
- ファイルが見つかる → 保存場所とファイル名規則が判明
- 見つからない → JRDB連携未設定、または手動ダウンロード必要

---

### 🟢 **その後: ワークフロー設計**

質問1・2の答えに基づいて、以下のスクリプトを作成:

1. **データ取得スクリプト**
   - `scripts/phase6/fetch_today_data.py`
   - PostgreSQL + JRDBファイルから当日データ取得

2. **特徴量生成スクリプト**
   - `scripts/phase6/generate_today_features.py`
   - Phase 2-Bと同じロジックで139列生成

3. **予測実行スクリプト**
   - `scripts/phase6/predict_today.py`
   - Phase 5アンサンブルモデルで予測

4. **統合スクリプト**
   - `scripts/phase6/run_daily_prediction.py`
   - 上記3つをまとめて実行

---

## 📝 **報告フォーマット**

### 質問1の答え:
```
【PC-KEIBAの当日データ】
- jra_shutsubaテーブル: □ 存在する / □ 存在しない
- 今日の日付のデータ: XX件
- 自動更新設定: □ ON / □ OFF / □ 不明
```

### 質問2の答え:
```
【JRDBファイル】
- 保存場所: C:\...\BAC20260222.txt
- 最終更新: 2026-02-22 08:30
- 取得方法: □ PC-KEIBA自動 / □ 手動DL / □ 不明
```

### 質問3の答え:
```
【希望するワークフロー】
□ シナリオA: 完全自動化（タスクスケジューラ）
□ シナリオB: 半自動化（手動DL後に自動処理）
□ シナリオC: 手動実行（必要時のみ）
```

---

**次のアクション**: 上記の2つのコマンドを実行して、質問1・2の答えを報告してください。
