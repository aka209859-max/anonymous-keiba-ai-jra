# Phase 0: 環境セットアップ 成果物リスト

**Phase**: Phase 0（環境構築・データベース接続確認）  
**作成日**: 2026-02-19  
**ステータス**: ✅ AI側の作成完了 → ユーザーの実行待ち

---

## 📦 成果物一覧

### 1. ディレクトリ構造定義
- **ファイル名**: `phase0_directory_structure.txt`
- **内容**: プロジェクトディレクトリ構造の定義
- **用途**: ユーザーがローカルPCでディレクトリを作成する際の参考

### 2. Python依存パッケージリスト
- **ファイル名**: `requirements.txt`
- **内容**: Phase 0〜5で使用する全てのPythonライブラリ
- **用途**: `pip install -r requirements.txt` で一括インストール

### 3. データベース接続設定
- **ファイル名**: `config/db_config.yaml`
- **内容**: PostgreSQL（JRA-VAN + JRDB）接続設定
- **注意**: ⚠️ ユーザーが実際の環境に合わせて編集必須 ⚠️
  - `password` フィールドを実際のPostgreSQLパスワードに変更
  - `database` フィールドを実際のデータベース名に変更

### 4. 特徴量設定
- **ファイル名**: `config/feature_config.yaml`
- **内容**: 148特徴量の定義、競馬場コード定義、データ抽出期間など
- **用途**: Phase 1以降で参照

### 5. Phase 0 接続確認スクリプト
- **ファイル名**: `scripts/phase0_setup.py`
- **内容**: 
  - 必須ライブラリのインポート確認
  - PostgreSQL（JRA-VAN + JRDB）接続テスト
  - テーブル存在確認
  - レコード数確認
- **実行方法**: `python scripts/phase0_setup.py`
- **期待される出力**: 
  ```
  ✅ Phase 0 完了: 全てのDB接続が成功しました
  ```

### 6. Phase 0 環境構築手順書（Windows版）
- **ファイル名**: `PHASE0_SETUP_MANUAL_WINDOWS.md`
- **内容**: 
  - ディレクトリ作成手順
  - Python仮想環境作成手順
  - 必須ライブラリインストール手順
  - DB接続確認手順
  - トラブルシューティング
  - Phase 0完了報告テンプレート
- **対象**: Windowsユーザー向け

### 7. Git除外設定
- **ファイル名**: `.gitignore`
- **内容**: 
  - Pythonバイトコード
  - データファイル（data/）
  - モデルファイル（models/）
  - ログファイル（logs/）
  - DB設定ファイル（config/db_config.yaml）
  - 仮想環境（venv/）

### 8. プロジェクト概要
- **ファイル名**: `README.md`
- **内容**: 
  - プロジェクト概要
  - システム構成（148特徴量、11競馬場）
  - 必読ドキュメント一覧
  - クイックスタート
  - ディレクトリ構造
  - 開発フロー（Phase 0〜5）
  - 重要な注意事項

---

## 📂 ファイル配置場所（ユーザーのローカルPC）

```
E:\anonymous-keiba-ai-JRA\          ← ユーザーのローカルPC
├── config/
│   ├── db_config.yaml              ← ⚠️ ユーザーが編集必須
│   └── feature_config.yaml
├── scripts/
│   └── phase0_setup.py             ← ユーザーが実行
├── docs/
│   └── PHASE0_SETUP_MANUAL_WINDOWS.md
├── requirements.txt                ← pip install -r requirements.txt
├── .gitignore
└── README.md
```

---

## ✅ ユーザーの作業手順（Phase 0）

### ステップ 1: ファイルのダウンロード・配置

AIが作成した以下のファイルを、ローカルPC（E:\anonymous-keiba-ai-JRA）の対応する場所にコピー:

1. `requirements.txt` → `E:\anonymous-keiba-ai-JRA\requirements.txt`
2. `db_config.yaml` → `E:\anonymous-keiba-ai-JRA\config\db_config.yaml`
3. `feature_config.yaml` → `E:\anonymous-keiba-ai-JRA\config\feature_config.yaml`
4. `phase0_setup.py` → `E:\anonymous-keiba-ai-JRA\scripts\phase0_setup.py`
5. `PHASE0_SETUP_MANUAL_WINDOWS.md` → `E:\anonymous-keiba-ai-JRA\docs\PHASE0_SETUP_MANUAL_WINDOWS.md`
6. `.gitignore` → `E:\anonymous-keiba-ai-JRA\.gitignore`
7. `README.md` → `E:\anonymous-keiba-ai-JRA\README.md`

### ステップ 2: ディレクトリ作成

PowerShellを開いて実行:

```powershell
cd E:\
mkdir anonymous-keiba-ai-JRA
cd anonymous-keiba-ai-JRA

# サブディレクトリ作成
mkdir config, data\raw, data\processed, data\features
mkdir models\boruta, models\lightgbm, models\optuna
mkdir scripts, sql, logs, results\plots, docs
```

### ステップ 3: Python仮想環境作成

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
```

### ステップ 4: 必須ライブラリインストール

```powershell
pip install -r requirements.txt
```

### ステップ 5: DB設定ファイル編集

```powershell
notepad config\db_config.yaml
```

⚠️ **重要**: 以下を実際の環境に合わせて編集
- `password: postgres123` → 実際のPostgreSQLパスワード
- `database: jra_keiba` → 実際のデータベース名

### ステップ 6: Phase 0 スクリプト実行

```powershell
python scripts\phase0_setup.py
```

### ステップ 7: 結果確認

期待される出力:
```
✅ Phase 0 完了: 全てのDB接続が成功しました

次のステップ:
  1. config/feature_config.yaml を確認
  2. Phase 1（データ抽出）に進む準備完了
  3. AIに「Phase 0完了」と報告してください
```

### ステップ 8: AIに完了報告

以下の形式でAIに報告:

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
- JRA-VAN テーブル検出: jvd_ra, jvd_se, jvd_ck など
- JRA-VAN レコード数: XXX,XXX件（jvd_ra）
- JRDB テーブル検出: jrd_kyi, jrd_joa, jrd_cyb など
- JRDB レコード数: XXX,XXX件（jrd_kyi）

## 確認事項
- [✅] 全てのDB接続が成功
- [✅] エラーなく完了
- [✅] 結果が妥当な範囲

## 次のPhase
Phase 1（データ抽出）に進んでも良いか確認をお願いします。
```

---

## ❌ トラブルシューティング

詳細は `PHASE0_SETUP_MANUAL_WINDOWS.md` の「トラブルシューティング」セクションを参照してください。

主なエラーと対処法:
- PostgreSQL接続エラー → サービス起動確認
- 認証エラー → パスワード確認
- データベースが見つからない → データベース名確認
- テーブルが見つからない → JRA-VANデータインポート確認
- ライブラリインストールエラー → pip アップグレード

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

## 📝 Phase 0完了チェックリスト

- [ ] プロジェクトディレクトリ構造が作成されている
- [ ] Python仮想環境が作成・有効化されている
- [ ] 全ての必須ライブラリがインストールされている
- [ ] `config/db_config.yaml` が正しく設定されている
- [ ] PostgreSQL（JRA-VAN + JRDB）接続が成功している
- [ ] `scripts/phase0_setup.py` が正常終了している
- [ ] 「✅ Phase 0 完了」メッセージが表示されている
- [ ] AIに完了報告を送信した

---

**作成日**: 2026-02-19  
**Phase**: Phase 0（環境構築）  
**ステータス**: ✅ AI側の作成完了 → ⏳ ユーザーの実行待ち
