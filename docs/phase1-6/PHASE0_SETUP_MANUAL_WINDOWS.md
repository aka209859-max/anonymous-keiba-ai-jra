# Phase 0: 環境構築手順書（Windows版）

**対象**: JRA中央競馬AI予想システム Phase 0  
**作成日**: 2026-02-19  
**実行環境**: ユーザーのローカルPC（Windows）  
**作業ディレクトリ**: E:\anonymous-keiba-ai-JRA

---

## 🎯 Phase 0 の目的

1. Python開発環境のセットアップ
2. PostgreSQL（JRA-VAN + JRDB）接続確認
3. プロジェクトディレクトリ構造の作成
4. 必須ライブラリのインストール

---

## ✅ 前提条件

### 必須環境

| 項目 | 要件 | 確認方法 |
|---|---|---|
| **OS** | Windows 10/11 | - |
| **Python** | 3.9 または 3.10 | `python --version` |
| **PostgreSQL** | 12以上 | `psql --version` |
| **メモリ** | 16GB以上 | システム情報で確認 |
| **ストレージ** | 100GB以上の空き容量 | エクスプローラーで確認 |

### データベース前提

- **JRA-VANデータベース**: `jra_keiba` が存在
  - テーブル: `jvd_ra`, `jvd_se`, `jvd_ck`, `jvd_hr` など
- **JRDBデータベース**: `jra_keiba`（または別DB）が存在
  - テーブル: `jrd_kyi`, `jrd_joa`, `jrd_cyb`, `jrd_sed` など

---

## 📋 手順

### ステップ 1: プロジェクトディレクトリ作成

#### 1.1 PowerShellを開く

1. `Windowsキー + X` → `Windows PowerShell` を選択
2. または `Windowsキー + R` → `powershell` と入力

#### 1.2 プロジェクトディレクトリ作成

```powershell
# Eドライブに移動
cd E:\

# プロジェクトディレクトリ作成
mkdir anonymous-keiba-ai-JRA
cd anonymous-keiba-ai-JRA

# サブディレクトリ作成
mkdir config
mkdir data\raw
mkdir data\processed
mkdir data\features
mkdir models\boruta
mkdir models\lightgbm
mkdir models\optuna
mkdir scripts
mkdir sql
mkdir logs
mkdir results\plots
mkdir docs

# 確認
tree /F
```

**期待される出力**:
```
E:\anonymous-keiba-ai-JRA
├── config
├── data
│   ├── raw
│   ├── processed
│   └── features
├── models
│   ├── boruta
│   ├── lightgbm
│   └── optuna
├── scripts
├── sql
├── logs
├── results
│   └── plots
└── docs
```

---

### ステップ 2: Python仮想環境作成

#### 2.1 Python バージョン確認

```powershell
python --version
```

**期待される出力**: `Python 3.9.x` または `Python 3.10.x`

⚠️ Python 3.9/3.10 でない場合:
- Python公式サイトから3.10をダウンロード・インストール
- https://www.python.org/downloads/

#### 2.2 仮想環境作成

```powershell
# 仮想環境作成
python -m venv venv

# 仮想環境有効化
.\venv\Scripts\Activate.ps1
```

**期待される出力**: プロンプトに `(venv)` が表示される

⚠️ エラーが出た場合（ExecutionPolicy）:
```powershell
# PowerShellの実行ポリシーを一時的に変更
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\venv\Scripts\Activate.ps1
```

#### 2.3 pip アップグレード

```powershell
python -m pip install --upgrade pip
```

---

### ステップ 3: 設定ファイル配置

#### 3.1 AIが作成したファイルをコピー

AIが作成した以下のファイルを、ローカルPCの対応する場所にコピー:

| ファイル | コピー元（AI） | コピー先（ローカルPC） |
|---|---|---|
| requirements.txt | sandbox | E:\anonymous-keiba-ai-JRA\ |
| db_config.yaml | sandbox | E:\anonymous-keiba-ai-JRA\config\ |
| feature_config.yaml | sandbox | E:\anonymous-keiba-ai-JRA\config\ |
| phase0_setup.py | sandbox | E:\anonymous-keiba-ai-JRA\scripts\ |

#### 3.2 db_config.yaml を編集

```powershell
notepad config\db_config.yaml
```

以下の項目を実際の環境に合わせて編集:

```yaml
jravan:
  host: localhost          # PostgreSQLホスト（変更不要の場合が多い）
  port: 5432               # PostgreSQLポート（変更不要の場合が多い）
  database: jra_keiba      # ★実際のJRA-VANデータベース名に変更★
  user: postgres           # ★実際のPostgreSQLユーザー名に変更★
  password: postgres123    # ★実際のPostgreSQLパスワードに変更★★★重要★★★

jrdb:
  host: localhost
  port: 5432
  database: jra_keiba      # ★実際のJRDBデータベース名に変更★
  user: postgres           # ★実際のPostgreSQLユーザー名に変更★
  password: postgres123    # ★実際のPostgreSQLパスワードに変更★★★重要★★★
```

⚠️ **セキュリティ注意**:
- `db_config.yaml` はGit管理対象外にすること（`.gitignore` に追加）
- パスワードを平文で保存するため、ファイルのアクセス権限に注意

保存して閉じる: `Ctrl + S` → `Alt + F4`

---

### ステップ 4: 必須ライブラリインストール

#### 4.1 requirements.txt からインストール

```powershell
# 仮想環境が有効化されていることを確認
# プロンプトに (venv) が表示されているか確認

# 必須ライブラリ一括インストール
pip install -r requirements.txt
```

**所要時間**: 約5～10分

**期待される出力**:
```
Collecting pandas>=1.5.0
...
Successfully installed pandas-X.X.X numpy-X.X.X ...
```

⚠️ エラーが出た場合:
- インターネット接続を確認
- `pip install --upgrade pip` を再実行
- 個別インストール: `pip install pandas numpy scikit-learn lightgbm optuna boruta psycopg2-binary sqlalchemy matplotlib seaborn plotly tqdm joblib pyyaml`

#### 4.2 インストール確認

```powershell
# 主要パッケージのバージョン確認
pip list | Select-String "pandas|numpy|lightgbm|optuna|boruta|psycopg2"
```

**期待される出力**:
```
pandas                1.5.3
numpy                 1.24.3
lightgbm              4.1.0
optuna                3.4.0
boruta                0.3
psycopg2-binary       2.9.9
...
```

---

### ステップ 5: PostgreSQL接続確認

#### 5.1 PostgreSQLサービス起動確認

```powershell
# PostgreSQLサービス状態確認
Get-Service -Name postgresql*
```

**期待される出力**:
```
Status   Name               DisplayName
------   ----               -----------
Running  postgresql-x64-14  PostgreSQL Server 14
```

⚠️ Stopped の場合:
```powershell
# サービス起動
Start-Service -Name postgresql-x64-14  # ★バージョン番号は環境に合わせる★
```

#### 5.2 psql コマンドで手動接続テスト

```powershell
# JRA-VAN DB接続テスト
psql -h localhost -p 5432 -U postgres -d jra_keiba
```

パスワード入力を求められたら、PostgreSQLのパスワードを入力。

**期待される出力**:
```
psql (14.x)
Type "help" for help.

jra_keiba=#
```

テーブル一覧確認:
```sql
\dt jvd_*
```

**期待される出力**:
```
            List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | jvd_ra    | table | postgres
 public | jvd_se    | table | postgres
 public | jvd_ck    | table | postgres
 ...
```

終了:
```sql
\q
```

---

### ステップ 6: Phase 0 スクリプト実行

#### 6.1 Phase 0 スクリプト実行

```powershell
# 仮想環境が有効化されていることを確認
python scripts\phase0_setup.py
```

**期待される出力**:
```
======================================================================
Phase 0: 環境構築・データベース接続確認
======================================================================
プロジェクトルート: E:\anonymous-keiba-ai-JRA

📦 必須ライブラリのインポート確認中...
  ✅ pyyaml
  ✅ pandas
  ✅ numpy
  ✅ scikit-learn
  ✅ lightgbm
  ✅ optuna
  ✅ boruta
  ✅ psycopg2-binary
  ✅ sqlalchemy
  ✅ matplotlib
  ✅ seaborn
  ✅ tqdm
  ✅ joblib

✅ 全ての必須ライブラリが正常にインポートできました

📂 設定ファイル読み込み中...
✅ 設定ファイル読み込み完了

🔌 JRA-VAN DB接続テスト中...
  ✅ JRA-VAN DB接続成功
  📊 検出されたテーブル（最初の10件）:
     - jvd_ra
     - jvd_se
     - jvd_ck
     - jvd_hr
     - jvd_um
     - jvd_ks
     - jvd_ch
     - jvd_bn
     ...
  📊 jvd_ra レコード数: 123,456件

🔌 JRDB DB接続テスト中...
  ✅ JRDB DB接続成功
  📊 検出されたテーブル（最初の10件）:
     - jrd_kyi
     - jrd_joa
     - jrd_cyb
     - jrd_sed
     ...
  📊 jrd_kyi レコード数: 120,000件

🔌 SQLAlchemy接続テスト中...
  ✅ SQLAlchemy (JRA-VAN) 接続成功
  ✅ SQLAlchemy (JRDB) 接続成功

======================================================================
Phase 0 実行結果
======================================================================
JRA-VAN DB接続: ✅ 成功
JRDB DB接続:    ✅ 成功
SQLAlchemy接続: ✅ 成功
======================================================================

✅ Phase 0 完了: 全てのDB接続が成功しました

次のステップ:
  1. config/feature_config.yaml を確認
  2. Phase 1（データ抽出）に進む準備完了
  3. AIに「Phase 0完了」と報告してください
```

---

## ❌ トラブルシューティング

### エラー 1: PostgreSQL接続エラー

**症状**:
```
❌ JRA-VAN DB接続失敗（接続エラー）
エラー詳細: could not connect to server: Connection refused
```

**対処法**:
1. PostgreSQLサービスが起動しているか確認
   ```powershell
   Get-Service -Name postgresql*
   ```
2. サービスが停止している場合は起動
   ```powershell
   Start-Service -Name postgresql-x64-14
   ```
3. ファイアウォールでポート5432が開いているか確認

---

### エラー 2: 認証エラー

**症状**:
```
❌ JRA-VAN DB接続失敗（接続エラー）
エラー詳細: FATAL:  password authentication failed for user "postgres"
```

**対処法**:
1. `config/db_config.yaml` のパスワードを確認
2. psqlコマンドで手動接続して、パスワードが正しいか確認
   ```powershell
   psql -h localhost -U postgres -d jra_keiba
   ```

---

### エラー 3: データベースが見つからない

**症状**:
```
❌ JRA-VAN DB接続失敗（接続エラー）
エラー詳細: FATAL:  database "jra_keiba" does not exist
```

**対処法**:
1. データベース一覧を確認
   ```powershell
   psql -h localhost -U postgres -l
   ```
2. 実際のデータベース名を確認し、`config/db_config.yaml` を修正

---

### エラー 4: テーブルが見つからない

**症状**:
```
⚠️  JRA-VANテーブルが見つかりません（jvd_*）
```

**対処法**:
1. psqlで接続してテーブル一覧確認
   ```sql
   \dt
   ```
2. JRA-VANデータが正しくインポートされているか確認
3. スキーマが異なる場合は、スキーマを指定
   ```sql
   \dt jravan.*
   ```

---

### エラー 5: ライブラリインストールエラー

**症状**:
```
ERROR: Could not find a version that satisfies the requirement lightgbm>=4.0.0
```

**対処法**:
1. pipをアップグレード
   ```powershell
   python -m pip install --upgrade pip
   ```
2. 個別にインストールしてバージョンを確認
   ```powershell
   pip install lightgbm
   ```
3. Pythonバージョンが古い場合は3.9または3.10にアップグレード

---

## ✅ Phase 0 完了チェックリスト

Phase 0 完了後、以下を確認してください:

- [ ] プロジェクトディレクトリ構造が作成されている
- [ ] Python仮想環境が作成・有効化されている
- [ ] 全ての必須ライブラリがインストールされている
- [ ] `config/db_config.yaml` が正しく設定されている
- [ ] PostgreSQL（JRA-VAN + JRDB）接続が成功している
- [ ] `scripts/phase0_setup.py` が正常終了している
- [ ] 「✅ Phase 0 完了」メッセージが表示されている

---

## 📝 Phase 0 完了報告テンプレート

Phase 0が完了したら、AIに以下の形式で報告してください:

```
# Phase 0 完了報告

## 実行環境
- OS: Windows 11
- Python: 3.10.x
- 作業ディレクトリ: E:\anonymous-keiba-ai-JRA

## 実行内容
- プロジェクトディレクトリ作成: ✅
- Python仮想環境作成: ✅
- 必須ライブラリインストール: ✅
- DB接続確認（JRA-VAN）: ✅
- DB接続確認（JRDB）: ✅
- phase0_setup.py 実行: ✅

## 結果
- JRA-VAN テーブル検出: jvd_ra, jvd_se, jvd_ck, jvd_hr など
- JRA-VAN レコード数: 123,456件（jvd_ra）
- JRDB テーブル検出: jrd_kyi, jrd_joa, jrd_cyb, jrd_sed など
- JRDB レコード数: 120,000件（jrd_kyi）

## 確認事項
- [✅] 全てのDB接続が成功
- [✅] エラーなく完了
- [✅] 結果が妥当な範囲

## 次のPhase
Phase 1（データ抽出）に進んでも良いか確認をお願いします。
```

---

## 🚀 次のステップ

Phase 0が完了したら:

1. **AIに「Phase 0完了」と報告**
2. **Phase 1の準備**
   - 対象競馬場を決定（01: 札幌 ～ 10_winter: 小倉冬）
   - データ抽出期間を確認（デフォルト: 2020～2025年）
3. **Phase 1開始**
   - AIがPhase 1のスクリプト（データ抽出SQL + Pythonスクリプト）を作成
   - ユーザーがローカルPCで実行

---

**作成日**: 2026-02-19  
**対象Phase**: Phase 0 環境構築  
**対象環境**: ユーザーのローカルPC（Windows）  
**作業ディレクトリ**: E:\anonymous-keiba-ai-JRA
