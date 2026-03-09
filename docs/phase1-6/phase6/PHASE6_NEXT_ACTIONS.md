# Phase 6: 次のアクション（優先順位順）

## 📅 作成日時
2026-02-22

---

## 🎯 最優先タスク（今すぐ実行）

### 1️⃣ PC-KEIBAのPostgreSQL接続確認
**目的**: PC-KEIBAがPostgreSQLを使用しているか確認

**手順**:
```powershell
# PostgreSQLサービスの確認
Get-Service | Where-Object {$_.Name -like "*postgres*"}

# PC-KEIBAの設定ファイルを探す
Get-ChildItem "$env:APPDATA\PC-KEIBA Database" -Recurse -ErrorAction SilentlyContinue
Get-ChildItem "$env:LOCALAPPDATA\PC-KEIBA*" -Recurse -ErrorAction SilentlyContinue

# PostgreSQLインストールの確認
Get-ChildItem "C:\Program Files\PostgreSQL" -ErrorAction SilentlyContinue
```

**期待される結果**:
- PostgreSQLサービスが起動中
- 設定ファイル（config.ini, database.conf等）が見つかる
- データベース名、ユーザー名、ポート番号が判明

---

### 2️⃣ JRDBファイルの保存場所確認
**目的**: PC-KEIBAがJRDBファイルをどこに保存しているか確認

**手順**:
```powershell
# JRDBファイルを検索（最近7日間）
Get-ChildItem C:\ -Recurse -Include "BAC*.txt","SED*.txt","KYI*.txt" `
    -ErrorAction SilentlyContinue | 
    Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)} |
    Select-Object FullName, LastWriteTime

# PC-KEIBAのインストールフォルダ内を探す
Get-ChildItem "C:\Program Files\PC-KEIBA*" -Recurse -Include "*.txt" `
    -ErrorAction SilentlyContinue |
    Where-Object {$_.Name -match "^(BAC|SED|KYI|CYB)"}
```

**期待される結果**:
- BACファイル等の保存先パス判明
- ファイル命名規則の確認（例: BAC20260222.txt）

---

### 3️⃣ JRDBファイルフォーマットのサンプル取得
**目的**: 固定長フォーマットの実データを確認

**手順**:
1. JRDB会員サイト (https://www.jrdb.com/) にログイン
2. 最新のBACファイルを1つダウンロード
3. テキストエディタで開き、フォーマットを確認
4. 以下の情報を記録:
   - ファイルエンコーディング（Shift-JIS想定）
   - 1行の文字数
   - 主要フィールドの位置（レースID、馬番、IDM指数等）

**サンプルデータ例**:
```
レースID(1-8) | 馬番(9-10) | IDM指数(11-15) | ...
20260222010511        082          ...
```

---

## 🔄 実装フェーズ（Week 1-2）

### Phase 6-A: JRDBファイルパーサー実装
**ファイル**: `scripts/phase6/parse_jrdb.py`

**機能**:
- 固定長テキストファイル（BAC, SED, KYI）を読み込み
- Shift-JIS → UTF-8変換
- DataFrameに変換
- 欠損値処理

**入力例**:
```
data/jrdb/BAC20260222.txt
```

**出力例**:
```
data/jrdb_parsed/BAC_20260222.csv
```

---

### Phase 6-B: 当日特徴量生成パイプライン
**ファイル**: `scripts/phase6/generate_today_features.py`

**機能**:
- JRDBパース済みCSVを読み込み
- Phase 2-B と同じ特徴量エンジニアリング処理を適用
- 139列の特徴量を生成

**入力**:
- `data/jrdb_parsed/BAC_20260222.csv`
- `data/jrdb_parsed/SED_20260222.csv`
- （必要に応じて）PC-KEIBA PostgreSQLから過去データ取得

**出力**:
```
data/today_features/features_20260222.csv
```

---

### Phase 6-C: リアルタイム予測実行
**ファイル**: `scripts/phase6/predict_today.py`

**機能**:
- Phase 5 アンサンブルモデルをロード
- 当日特徴量で予測実行
- 予測結果を出力

**入力**:
```
data/today_features/features_20260222.csv
models/jra_binary_model.txt
models/jra_ranking_model.txt
models/jra_regression_model_optimized.txt
```

**出力**:
```
results/predictions_20260222.csv
results/predictions_20260222.html (見やすい表形式)
```

**出力フォーマット例**:
```csv
race_id,umaban,本命順位,対抗順位,ensemble_score,予測着順
202602220105,1,1,✓,0.8523,1
202602220105,5,2,✓,0.7891,2
...
```

---

## 📂 ディレクトリ構造（Phase 6追加分）

```
E:\anonymous-keiba-ai-JRA\
├── data/
│   ├── jrdb/              # 【新規】JRDBダウンロードフォルダ
│   │   ├── BAC20260222.txt
│   │   ├── SED20260222.txt
│   │   └── KYI20260222.txt
│   ├── jrdb_parsed/       # 【新規】パース済みCSV
│   │   ├── BAC_20260222.csv
│   │   └── SED_20260222.csv
│   └── today_features/    # 【新規】当日特徴量
│       └── features_20260222.csv
├── scripts/
│   └── phase6/            # 【新規】Phase 6スクリプト
│       ├── parse_jrdb.py
│       ├── generate_today_features.py
│       └── predict_today.py
└── results/
    ├── predictions_20260222.csv    # 【新規】当日予測結果
    └── predictions_20260222.html
```

---

## ⚙️ 自動化オプション（Week 3）

### Option A: ファイル監視による自動実行
```python
# scripts/phase6/auto_watch.py
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class JRDBFileHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith('.txt') and 'BAC' in event.src_path:
            print(f"新しいJRDBファイル検出: {event.src_path}")
            # 自動的にパース → 特徴量生成 → 予測実行
            run_prediction_pipeline(event.src_path)

# data/jrdb/ フォルダを監視
observer = Observer()
observer.schedule(JRDBFileHandler(), path="E:/anonymous-keiba-ai-JRA/data/jrdb", recursive=False)
observer.start()
```

### Option B: Windowsタスクスケジューラ
```powershell
# 毎朝10:00に実行（JRDB手動ダウンロード後）
$action = New-ScheduledTaskAction -Execute "python" `
    -Argument "E:\anonymous-keiba-ai-JRA\scripts\phase6\predict_today.py"
$trigger = New-ScheduledTaskTrigger -Daily -At 10:00AM
Register-ScheduledTask -TaskName "JRA_AI_Prediction" -Action $action -Trigger $trigger
```

---

## 🚨 法的・技術的リスクへの対応

### ✅ **遵守事項**
1. **JRDBダウンロード制限**:
   - レース当日 08:00-19:00 の大量アクセス禁止
   - → **前日にデータ取得を推奨**
   
2. **利用規約遵守**:
   - スクレイピング自動化は利用規約違反の可能性
   - → **手動ダウンロード + 自動処理の組み合わせ**

3. **データ公開制限**:
   - 予測結果の商用利用は別途ライセンス必要
   - 個人利用の範囲で運用

---

## 📊 成功基準（Phase 6完了の定義）

### 必須要件
- [ ] JRDBファイル（BAC, SED）のパーサー動作確認
- [ ] 当日特徴量生成が139列すべて生成できる
- [ ] Phase 5モデルで予測実行成功
- [ ] 予測結果CSV/HTML出力

### 推奨要件
- [ ] PC-KEIBA PostgreSQL接続成功（可能な場合）
- [ ] ファイル監視による自動実行
- [ ] 過去データでのバックテスト（的中率検証）

---

## 📝 報告フォーマット

各タスク完了後、以下の情報を報告してください：

```
【タスク1: PostgreSQL確認】
✅ 完了 / ❌ 未完了
結果:
- PostgreSQLサービス: 起動中 / 見つからず
- 設定ファイル場所: C:\...\config.ini
- データベース名: pc_keiba_db
- 接続テスト: 成功 / 失敗

【タスク2: JRDBファイル場所】
✅ 完了 / ❌ 未完了
結果:
- BACファイル保存先: C:\...\JRDB\
- ファイル例: BAC20260220.txt
- 最終更新日時: 2026-02-20 18:30

【タスク3: フォーマット確認】
✅ 完了 / ❌ 未完了
結果:
- エンコーディング: Shift-JIS
- 1行の文字数: 1234バイト
- レースID位置: 1-8バイト
- IDM指数位置: 50-55バイト
```

---

## 🔗 参考リンク

- JRDB公式サイト: https://www.jrdb.com/
- PC-KEIBA公式: （URLを記入）
- PostgreSQL接続ガイド: https://www.postgresql.org/docs/current/libpq-connect.html
- psycopg2ドキュメント: https://www.psycopg.org/docs/

---

**次のアクション**: 上記の「最優先タスク」3つを実行し、結果を報告してください。
