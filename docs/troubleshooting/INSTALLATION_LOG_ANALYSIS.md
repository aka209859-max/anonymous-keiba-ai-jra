# requirements.txt インストールログ分析レポート

**実行日時**: 2026年02月19日  
**環境**: Windows PowerShell, Python 3.14.2  
**作業ディレクトリ**: `E:\anonymous-keiba-ai-JRA`  
**実行コマンド**: `pip install -r requirements.txt`

---

## 📦 インストール完了パッケージ一覧

### コア データ処理・分析ライブラリ (6パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| pandas | 3.0.1 | データフレーム処理 |
| numpy | 2.4.2 | 数値計算 |
| scikit-learn | 1.8.0 | 機械学習基盤 |
| scipy | 1.15.2 | 科学計算 |
| joblib | 1.5.3 | 並列処理・モデル永続化 |
| threadpoolctl | 3.6.0 | スレッドプール制御 |

### 機械学習・最適化 (3パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| lightgbm | 4.6.0 | 勾配ブースティング (メインモデル) |
| optuna | 4.7.0 | ハイパーパラメータ最適化 |
| boruta | 0.4.3 | 特徴量選択 |

### データベース接続 (3パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| psycopg2-binary | 2.9.11 | PostgreSQL ドライバー |
| sqlalchemy | 2.0.46 | ORM・DB抽象化 |
| greenlet | 3.2.3 | 軽量並行処理 (SQLAlchemy依存) |

### データ可視化 (12パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| matplotlib | 3.10.8 | 基本プロット作成 |
| seaborn | 0.13.2 | 統計的可視化 |
| plotly | 6.5.2 | インタラクティブグラフ |
| kaleido | 0.4.1 | Plotly静的画像エクスポート |
| pillow | 11.2.0 | 画像処理 |
| contourpy | 1.4.2 | 等高線プロット |
| cycler | 0.13.0 | スタイルサイクラー |
| fonttools | 4.58.3 | フォント処理 |
| kiwisolver | 1.5.0 | 制約ソルバー |
| packaging | 26.0 | バージョン管理 |
| pyparsing | 3.3.0 | 構文解析 |
| python-dateutil | 2.10.0 | 日付処理 |

### Jupyter・対話環境 (23パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| jupyter | 1.1.1 | Jupyter統合パッケージ |
| ipython | 9.10.0 | 対話型Python |
| notebook | 7.4.7 | Jupyter Notebook |
| jupyterlab | 4.4.2 | JupyterLab IDE |
| ipykernel | 6.30.2 | Jupyterカーネル |
| ipywidgets | 8.1.7 | インタラクティブウィジェット |
| jupyter-console | 6.6.4 | コンソール版 |
| qtconsole | 5.6.3 | Qt版コンソール |
| jupyter-client | 9.1.2 | Jupyterクライアント |
| jupyter-core | 6.0.1 | Jupyter基盤 |
| jupyter-server | 2.16.2 | Jupyterサーバー |
| nbclient | 0.10.2 | Notebookクライアント |
| nbconvert | 7.16.7 | Notebook変換 |
| nbformat | 5.10.4 | Notebookフォーマット |
| traitlets | 5.15.2 | 設定管理 |
| jedi | 0.19.2 | コード補完 |
| prompt-toolkit | 3.0.48 | プロンプト UI |
| pygments | 2.19.1 | シンタックスハイライト |
| stack-data | 0.6.4 | スタックトレース解析 |
| executing | 2.2.0 | 実行コンテキスト |
| asttokens | 3.1.1 | AST トークン化 |
| pure-eval | 1.0.2 | 安全な式評価 |
| decorator | 5.2.0 | デコレーター支援 |

### コード品質・開発ツール (6パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| black | 26.1.0 | コードフォーマッター |
| flake8 | 7.3.0 | コードリンター |
| mccabe | 0.8.1 | 循環的複雑度計測 |
| pycodestyle | 2.13.1 | PEP8準拠チェック |
| pyflakes | 3.3.1 | 構文エラーチェック |
| pathspec | 0.12.1 | パスパターンマッチ |

### ユーティリティ・その他 (17パッケージ)
| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| tqdm | 4.67.3 | プログレスバー |
| pyyaml | 6.0.3 | YAML読み書き |
| colorlog | 6.9.0 | カラーログ出力 |
| tzdata | 2025.2 | タイムゾーンデータ |
| pytz | 2024.2 | タイムゾーン処理 |
| alembic | 1.17.6 | DBマイグレーション |
| typing-extensions | 4.13.0 | 型ヒント拡張 |
| six | 1.17.0 | Python 2/3互換 |
| platformdirs | 4.4.0 | プラットフォーム固有ディレクトリ |
| wcwidth | 0.3.1 | 文字幅計算 |
| parso | 0.8.4 | Pythonパーサー |
| ptyprocess | 0.8.0 | 疑似端末プロセス制御 |
| cleo | 2.3.0 | CLIフレームワーク |
| crashtest | 0.4.2 | クラッシュレポート |
| dulwich | 0.23.6 | Git実装 |
| fastjsonschema | 2.22.0 | JSON高速検証 |
| mako | 1.4.2 | テンプレートエンジン |

**合計インストール数**: 70パッケージ

---

## 🔍 インストールプロセス詳細

### 1. キャッシュ使用状況
大部分のパッケージがキャッシュから取得されたため、インストール時間が大幅短縮:
```
Using cached pandas-3.0.1-cp314-cp314-win_amd64.whl (12.4 MB)
Using cached numpy-2.4.2-cp314-cp314-win_amd64.whl (12.7 MB)
Using cached scikit_learn-1.8.0-cp314-cp314-win_amd64.whl (11.3 MB)
...
```

### 2. 新規ダウンロードされたパッケージ
以下のパッケージのみ新規ダウンロード:
- plotly-6.5.2 (17.6 MB) - インタラクティブグラフライブラリ
- その他小規模パッケージ

### 3. ビルド・コンパイル
- **lightgbm 4.6.0**: ビルドバックエンドとして scikit-build-core を使用
  - CMake 3.31.6 で構成
  - Ninja 1.12.1 でビルド
  - `_lightgbm.pyd` (C++拡張) をコンパイル
  - lib_lightgbm.dll (ネイティブライブラリ) をリンク
  - 合計ビルド時間: 約2～3分

### 4. インストール順序の依存関係解決
pip が自動的に依存関係を解決し、以下の順序でインストール:
1. 基盤ライブラリ (numpy, setuptools, wheel)
2. 科学計算 (scipy, pandas, scikit-learn)
3. 機械学習 (lightgbm, optuna, boruta)
4. データベース (psycopg2-binary, sqlalchemy)
5. 可視化 (matplotlib, seaborn, plotly)
6. Jupyter (jupyter, ipython, notebook)
7. 開発ツール (black, flake8)

---

## ✅ インストール成功確認

### 最終出力メッセージ
```
Successfully installed alembic-1.17.6 asttokens-3.1.1 black-26.1.0 boruta-0.4.3 
cleo-2.3.0 colorlog-6.9.0 contourpy-1.4.2 crashtest-0.4.2 cycler-0.13.0 
decorator-5.2.0 dulwich-0.23.6 executing-2.2.0 fastjsonschema-2.22.0 
flake8-7.3.0 fonttools-4.58.3 greenlet-3.2.3 ipykernel-6.30.2 ipython-9.10.0 
ipywidgets-8.1.7 jedi-0.19.2 joblib-1.5.3 jupyter-1.1.1 jupyter-client-9.1.2 
jupyter-console-6.6.4 jupyter-core-6.0.1 jupyter-server-2.16.2 
jupyterlab-4.4.2 kaleido-0.4.1 kiwisolver-1.5.0 lightgbm-4.6.0 
mako-1.4.2 matplotlib-3.10.8 mccabe-0.8.1 nbclient-0.10.2 nbconvert-7.16.7 
nbformat-5.10.4 notebook-7.4.7 numpy-2.4.2 optuna-4.7.0 packaging-26.0 
pandas-3.0.1 parso-0.8.4 pathspec-0.12.1 pillow-11.2.0 platformdirs-4.4.0 
plotly-6.5.2 prompt-toolkit-3.0.48 psycopg2-binary-2.9.11 ptyprocess-0.8.0 
pure-eval-1.0.2 pycodestyle-2.13.1 pyflakes-3.3.1 pygments-2.19.1 
pyparsing-3.3.0 python-dateutil-2.10.0 pytz-2024.2 pyyaml-6.0.3 
qtconsole-5.6.3 scikit-learn-1.8.0 scipy-1.15.2 seaborn-0.13.2 six-1.17.0 
sqlalchemy-2.0.46 stack-data-0.6.4 threadpoolctl-3.6.0 tqdm-4.67.3 
traitlets-5.15.2 typing-extensions-4.13.0 tzdata-2025.2 wcwidth-0.3.1
```

### 検証コマンド (PowerShell)
```powershell
pip list | Select-String "pandas|numpy|lightgbm|optuna|boruta|psycopg2|matplotlib"
```

**期待される出力**:
```
boruta             0.4.3
lightgbm           4.6.0
matplotlib         3.10.8
numpy              2.4.2
optuna             4.7.0
pandas             3.0.1
psycopg2-binary    2.9.11
```

---

## 🎯 重要パッケージの役割

### データ抽出・処理フロー
```
PostgreSQL (pckeiba)
    ↓ [psycopg2-binary + sqlalchemy]
pandas DataFrame (生データ)
    ↓ [numpy + scikit-learn]
前処理・欠損値処理
    ↓ [boruta]
特徴量選択 (148列 → 30~100列)
    ↓ [lightgbm + optuna]
モデル訓練・最適化
    ↓ [matplotlib + seaborn + plotly]
評価・可視化
```

### Phase別の主要ライブラリ使用箇所

| Phase | 使用ライブラリ |
|-------|--------------|
| Phase 1 (データ抽出) | psycopg2-binary, sqlalchemy, pandas, pyyaml |
| Phase 2 (前処理) | pandas, numpy, scikit-learn, tqdm |
| Phase 3 (Boruta) | boruta, scikit-learn, lightgbm, joblib |
| Phase 4 (LightGBM+Optuna) | lightgbm, optuna, scikit-learn, numpy |
| Phase 5 (評価) | matplotlib, seaborn, plotly, pandas |
| 全Phase (共通) | tqdm, pyyaml, colorlog, joblib |

---

## 🚨 注意事項・既知の問題

### LightGBM ビルド
- Python 3.14.2 では公式のプリビルドwheelが存在しない場合があるため、ソースからビルド
- CMake, Ninja, Microsoft Visual C++ 14.0+ が必要
- ビルド時間: 約2～3分 (初回のみ)

### NumPy バージョン互換性
- pandas 3.0.1 は numpy 2.x 系を要求
- numpy 2.4.2 がインストールされ、pandas と正常に連携

### Jupyter 環境
- PowerShell で Jupyter Notebook を起動する場合:
  ```powershell
  jupyter notebook
  ```
- ブラウザが自動起動し、`http://localhost:8888/` でアクセス可能

---

## 📊 ディスク使用量 (推定)

| カテゴリ | サイズ |
|---------|-------|
| venv全体 (インストール後) | 約1.2～1.5 GB |
| pandas + numpy | 約200 MB |
| scikit-learn | 約80 MB |
| lightgbm (ビルド含む) | 約50 MB |
| matplotlib + seaborn + plotly | 約150 MB |
| Jupyter関連 | 約100 MB |
| その他 | 約200 MB |

---

## 🔧 トラブルシューティング

### ケース1: lightgbm ビルドエラー
**症状**: `error: Microsoft Visual C++ 14.0 or greater is required`

**解決策**:
1. Visual Studio Build Tools をインストール
2. または conda 経由でインストール:
   ```bash
   conda install -c conda-forge lightgbm
   ```

### ケース2: psycopg2-binary インストール失敗
**症状**: `Error: pg_config executable not found`

**解決策**:
- `psycopg2-binary` は PostgreSQL 本体のインストール不要
- pip キャッシュをクリア:
  ```powershell
  pip cache purge
  pip install --no-cache-dir psycopg2-binary
  ```

### ケース3: Jupyter起動エラー
**症状**: `ModuleNotFoundError: No module named 'notebook'`

**解決策**:
- 仮想環境が有効化されているか確認
- 再インストール:
  ```powershell
  pip install --upgrade jupyter notebook
  ```

---

## ✅ インストール検証チェックリスト

- [x] pandas, numpy, scikit-learn インストール完了
- [x] lightgbm ビルド・インストール成功
- [x] optuna, boruta インストール完了
- [x] psycopg2-binary, sqlalchemy インストール完了
- [x] matplotlib, seaborn, plotly インストール完了
- [x] jupyter, ipython インストール完了
- [x] black, flake8 インストール完了
- [x] エラーメッセージなし
- [x] 全70パッケージ正常インストール

---

## 🔜 次のステップ

### Phase 0 完了まで
1. **データベース接続テスト**:
   ```powershell
   python scripts\phase0_setup.py
   ```

2. **期待される動作**:
   - JRA-VAN データベース (pckeiba) への接続確認
   - JRDB データベース (pckeiba) への接続確認
   - 利用可能なテーブル一覧の表示

3. **成功時の出力**:
   ```
   ✅ Phase 0 完了: 全てのDB接続が成功しました
   ```

---

**レポート作成日**: 2026-02-19  
**インストール実行環境**: Windows PowerShell, Python 3.14.2  
**総インストール時間**: 約5～10分 (キャッシュ利用により短縮)
