# Phase 6: データベース接続情報 - 完全判明

## 📅 更新日時
2026-02-22

---

## 🎯 **重要発見: PostgreSQL接続情報が完全に判明！**

### ✅ **AppConfig.xml解析結果**

```xml
<?xml version="1.0" standalone="yes"?>
<DocumentElement>
  <AppConfig>
    <DbDatabase>pckeiba</DbDatabase>
    <DbPassword>postgres123</DbPassword>
    <DbPort>5432</DbPort>
    <DbServer>127.0.0.1</DbServer>
    <DbUserId>postgres</DbUserId>
  </AppConfig>
</DocumentElement>
```

### 🔑 **データベース接続パラメータ**

| 項目 | 値 | 備考 |
|------|-----|------|
| **ホスト** | `127.0.0.1` (localhost) | ローカル接続 |
| **ポート** | `5432` | PostgreSQLデフォルト |
| **データベース名** | `pckeiba` | ✅ 確定 |
| **ユーザー名** | `postgres` | スーパーユーザー |
| **パスワード** | `postgres123` | ✅ 確定 |
| **SSL** | `False` | 暗号化なし（ローカル接続） |

---

## 🐍 **Python接続コード（即座に使用可能）**

### 基本接続例
```python
import psycopg2
import pandas as pd

# PC-KEIBAデータベースに接続
def connect_pckeiba():
    conn = psycopg2.connect(
        host="127.0.0.1",
        port=5432,
        database="pckeiba",
        user="postgres",
        password="postgres123"
    )
    return conn

# 使用例: テーブル一覧取得
conn = connect_pckeiba()
query = """
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public'
    ORDER BY table_name;
"""
df = pd.read_sql(query, conn)
print(df)
conn.close()
```

---

## 📊 **追加発見情報**

### PC-KEIBAシステム情報
- **バージョン**: 5.0.8.7
- **最終更新（JRA-VAN）**: 2026/02/21 11:59:24
- **最終更新（地方競馬）**: 2026/02/21 23:20:44
- **リアルタイム更新間隔**: 30秒

### 外部指数ディレクトリ（未設定）
```xml
<DirectoryCompiShisu />     <!-- コンピ指数ディレクトリ -->
<DirectoryGaibuShisu />     <!-- 外部指数ディレクトリ -->
<DirectoryGaibuShisuExport />
<DirectoryPython />         <!-- Python実行環境パス -->
```
→ **重要**: JRDBデータの保存場所は別途調査必要

### 投票連携設定
- **KSC投票プラグイン**: `C:\keibasoftcom\KSCTohyoPlugIn2\KSCTohyoPlugIn2.exe`
- **PC-KEIBAアカウント**: HAJIME

### 機械学習設定（既存モデル）
```xml
<Objective>4</Objective>                    <!-- ランキング学習 -->
<ClassSu>3</ClassSu>                        <!-- クラス数: 3 -->
<TestTable>myd_lambdarank_1_test</TestTable>
<PredTable>myd_lambdarank_1_pred</PredTable>
```
→ **重要**: PC-KEIBA内に既にLambdaRankモデルが存在！

---

## 🔍 **次のステップ: データベーススキーマ調査**

### PowerShellコマンド（次に実行）

```powershell
# PostgreSQLに接続してテーブル一覧取得
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "\dt"

# パスワードプロンプトが出たら: postgres123 を入力

# または環境変数でパスワード設定（セキュア）
$env:PGPASSWORD = "postgres123"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "\dt"
```

---

## 🎯 **期待されるテーブル構造**

JRA-VAN Data標準スキーマに基づく予想テーブル:

| テーブル名候補 | 内容 | 重要度 |
|--------------|------|--------|
| `jra_race` | レース情報 | 🔴 最重要 |
| `jra_uma` | 馬情報 | 🔴 最重要 |
| `jra_kishu` | 騎手情報 | 🟡 重要 |
| `jra_seiseki` | 成績情報 | 🔴 最重要 |
| `jra_shutsuba` | 出馬表 | 🔴 最重要 |
| `jra_chokyo` | 調教情報 | 🟡 重要 |
| `jra_bataiju` | 馬体重 | 🟡 重要 |
| `myd_lambdarank_1_test` | 既存AIモデルテスト | 🟢 参考 |
| `myd_lambdarank_1_pred` | 既存AI予測結果 | 🟢 参考 |

---

## 📝 **psql接続エラーの対処**

### エラー内容
```
psql: エラー: "localhost"(::1)、ポート5432のサーバーへの接続に失敗しました: 
FATAL: password authentication failed for user "postgres"
```

### 原因
- `psql.exe`はパスワード入力プロンプトが必要
- コマンドラインで直接パスワードを渡していない

### 解決方法（3通り）

#### 方法1: 環境変数でパスワード設定
```powershell
$env:PGPASSWORD = "postgres123"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "\dt"
```

#### 方法2: .pgpassファイル作成
```powershell
# pgpassファイル作成（自動ログイン）
$pgpassContent = "127.0.0.1:5432:pckeiba:postgres:postgres123"
Set-Content "$env:APPDATA\postgresql\pgpass.conf" -Value $pgpassContent

# psql実行
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "\dt"
```

#### 方法3: Pythonで直接接続（推奨）
```python
import psycopg2

conn = psycopg2.connect(
    host="127.0.0.1",
    port=5432,
    database="pckeiba",
    user="postgres",
    password="postgres123"
)
cursor = conn.cursor()
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='public';")
tables = cursor.fetchall()
for table in tables:
    print(table[0])
conn.close()
```

---

## 🚀 **Phase 6-A実装準備完了！**

### ✅ **確定情報**
- PostgreSQLホスト: 127.0.0.1:5432
- データベース名: pckeiba
- 認証情報: postgres / postgres123

### 🔄 **次のタスク**
1. **テーブルスキーマ調査** → データ構造把握
2. **JRDBファイル場所特定** → 外部指数統合
3. **Pythonスクリプト実装** → データ抽出パイプライン

---

**次のアクション**: 以下のいずれかを実行してテーブル一覧を取得してください：

### 推奨: PowerShellでパスワード設定後に接続
```powershell
$env:PGPASSWORD = "postgres123"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "\dt"
```

### または: Pythonスクリプトで直接確認（簡単）
```powershell
# Python仮想環境アクティベート
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

# psycopg2インストール（未インストールの場合）
pip install psycopg2

# 簡易スクリプト実行
python -c "import psycopg2; conn=psycopg2.connect(host='127.0.0.1',port=5432,database='pckeiba',user='postgres',password='postgres123'); cur=conn.cursor(); cur.execute('SELECT table_name FROM information_schema.tables WHERE table_schema=''public'' ORDER BY table_name;'); print('\n'.join([t[0] for t in cur.fetchall()])); conn.close()"
```

この出力を報告してください！
