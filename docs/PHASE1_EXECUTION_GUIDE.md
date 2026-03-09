# Phase 1: データ抽出 - 実行手順書

**作成日**: 2026年02月19日  
**Phase**: Phase 1 (データ抽出)  
**前提条件**: Phase 0 完了 (環境構築・DB接続確認済み)  
**実行環境**: Windows PowerShell + Python 3.14.2 + PostgreSQL

---

## 📋 Phase 1 の目的

JRA-VANとJRDBの2つのデータベースから必要なカラムを抽出し、**148特徴量を持つ統合CSVファイル**を作成する。

---

## 🎯 Phase 1 の達成目標

| 目標 | 詳細 | 期待値 |
|------|------|--------|
| **JRA-VAN データ抽出** | 97列を抽出 | 数万～数十万件 |
| **JRDB データ抽出** | 48列を抽出 | 数万～数十万件 |
| **データマージ** | 2つのデータソースを結合 | マージ率 80%以上 |
| **派生特徴量計算** | 3列を計算 (distance_change系) | 全レコード計算完了 |
| **統合CSV保存** | 148列 × N万件 | `data/raw/jra_integrated_raw.csv` |

---

## 📊 特徴量構成 (148列)

### JRA-VAN (97列)
- **A. 基礎情報系**: 24列 (month, kyori, track_code, grade_code, keibajo_season_code 等)
- **B. 馬実績データ**: 14列 (sogo, kyakushitsu_keiko, 馬場状態別着回数, 距離別着回数 等)
- **C. 過去走データ (パターンC+)**: 58列
  - C-1. 高解像度 (t-1, t-2): 28列
  - C-2. 低解像度 (5走統計): 18列
  - C-3. コンテキスト (条件別): 12列
- **D. ターゲット変数**: 1列 (target_top3)

### JRDB (48列)
- **E. 予測指数系**: 13列 (idm, kishu_shisu, sogo_shisu, chokyo_shisu 等)
- **F. 調教・厩舎評価系**: 5列 (chokyo_yajirushi_code, shiage_shisu 等)
- **G. 適性・状態系**: 6列 (kyakushitsu_code, kyori_tekisei_code 等)
- **H. 展開予想系**: 2列 (pace_yoso, uma_deokure_ritsu)
- **I. ランク・その他**: 6列 (rotation, hobokusaki_rank, bataiju 等)
- **J. CID・LS指数**: 7列 (cid, ls_shisu, em 等)
- **K. 調教B**: 2列 (shiage_shisu, chokyo_hyoka from jrd_cyb)
- **L. 過去走データ**: 7列 (prev1_pace, prev1_furi 等)

### 派生特徴量 (3列)
- **distance_change**: 距離増減（m）
- **distance_change_abs**: 距離増減絶対値（m）
- **distance_change_sign**: 距離増減符号（1=増、0=同、-1=減）

---

## 🔧 実行手順

### ステップ1: 準備確認

PowerShellで以下を実行:

```powershell
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1
```

確認項目:
- ✅ 仮想環境が有効化されている（プロンプトに `(venv)` 表示）
- ✅ `config/db_config.yaml` が正しく設定されている（database=pckeiba）
- ✅ PostgreSQL サービスが起動している
- ✅ `sql/jravan_extraction.sql` が存在
- ✅ `sql/jrdb_extraction.sql` が存在
- ✅ `scripts/phase1_data_extraction.py` が存在

---

### ステップ2: Phase 1 実行

```powershell
python scripts\phase1_data_extraction.py
```

**実行時間**: 6～20分（データ量により変動）

---

### ステップ3: 実行中の出力確認

以下のような出力が表示されます:

```
======================================================================
Phase 1: データ抽出開始
======================================================================
実行日時: 2026-02-19 16:00:00
2026-02-19 16:00:00 - INFO - ✅ 設定ファイル読み込み完了
2026-02-19 16:00:00 - INFO - ✅ jravan データベースエンジン作成完了
======================================================================
JRA-VAN データ抽出開始...
======================================================================
2026-02-19 16:00:01 - INFO - SQL実行中... (数分かかる場合があります)
2026-02-19 16:05:30 - INFO - ✅ JRA-VAN抽出完了
2026-02-19 16:05:30 - INFO -   - レコード数: 125,432件
2026-02-19 16:05:30 - INFO -   - カラム数: 97列
======================================================================
JRDB データ抽出開始...
======================================================================
2026-02-19 16:05:31 - INFO - SQL実行中... (数分かかる場合があります)
2026-02-19 16:08:00 - INFO - ✅ JRDB抽出完了
2026-02-19 16:08:00 - INFO -   - レコード数: 123,891件
2026-02-19 16:08:00 - INFO -   - カラム数: 48列
======================================================================
データマージ開始...
======================================================================
2026-02-19 16:08:01 - INFO - マージキー: ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban']
2026-02-19 16:09:00 - INFO - ✅ マージ完了
2026-02-19 16:09:00 - INFO -   - JRA-VAN: 125,432件
2026-02-19 16:09:00 - INFO -   - JRDB: 123,891件
2026-02-19 16:09:00 - INFO -   - マージ後: 120,567件 × 145列
2026-02-19 16:09:00 - INFO -   - マージ率: 96.12%
======================================================================
派生特徴量計算開始...
======================================================================
2026-02-19 16:09:01 - INFO - ✅ 派生特徴量計算完了
2026-02-19 16:09:01 - INFO -   - distance_change: 距離増減（m）
2026-02-19 16:09:01 - INFO -   - distance_change_abs: 距離増減絶対値（m）
2026-02-19 16:09:01 - INFO -   - distance_change_sign: 距離増減符号（1=増、0=同、-1=減）
======================================================================
CSV保存開始...
======================================================================
2026-02-19 16:10:00 - INFO - ✅ CSV保存完了
2026-02-19 16:10:00 - INFO -   - 保存先: data\raw\jra_integrated_raw.csv
2026-02-19 16:10:00 - INFO -   - ファイルサイズ: 523.45 MB
======================================================================
データ統計情報
======================================================================
2026-02-19 16:10:00 - INFO - 最終レコード数: 120,567件
2026-02-19 16:10:00 - INFO - 最終カラム数: 148列
2026-02-19 16:10:00 - INFO - 期待カラム数: 148列
2026-02-19 16:10:00 - INFO - ✅ カラム数一致
======================================================================
✅ Phase 1 完了
======================================================================
```

---

### ステップ4: 結果確認

以下のファイルが作成されていることを確認:

```powershell
# CSVファイル確認
ls data\raw\jra_integrated_raw.csv

# ログファイル確認
ls logs\phase1_extraction.log

# ファイルサイズ確認
Get-Item data\raw\jra_integrated_raw.csv | Select-Object Name, Length, LastWriteTime
```

**期待されるファイル**:
- `data/raw/jra_integrated_raw.csv` (約500MB～2GB)
- `logs/phase1_extraction.log` (実行ログ)

---

### ステップ5: データ内容確認（任意）

Pythonで簡易確認:

```powershell
python -c "import pandas as pd; df = pd.read_csv('data/raw/jra_integrated_raw.csv', nrows=5); print(df.shape); print(df.columns.tolist()[:10])"
```

**期待される出力**:
```
(5, 148)
['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban', 'ketto_toroku_bango', 'month', 'kyori', 'track_code', 'grade_code']
```

---

## ✅ Phase 1 完了チェックリスト

実行後、以下を確認してください:

- [ ] **JRA-VAN データ抽出成功** (数万～数十万件)
- [ ] **JRDB データ抽出成功** (数万～数十万件)
- [ ] **データマージ成功** (マージ率 80%以上)
- [ ] **派生特徴量計算成功** (distance_change系3列)
- [ ] **統合CSV保存成功** (`data/raw/jra_integrated_raw.csv`)
- [ ] **カラム数148列の確認**
- [ ] **レコード数が妥当** (数万件以上)
- [ ] **エラーなし**
- [ ] **ログファイル生成** (`logs/phase1_extraction.log`)

---

## 🚨 トラブルシューティング

### エラー1: SQL実行エラー

**症状**:
```
psycopg2.errors.UndefinedTable: relation "jvd_ra" does not exist
```

**原因**: テーブル名が間違っている、またはテーブルが存在しない

**対処法**:
1. pgAdmin等でテーブル名を確認
2. SQLファイル内のテーブル名を修正
3. `python scripts\phase0_setup.py` で接続確認

---

### エラー2: マージ後レコード数0件

**症状**:
```
マージ後: 0件 × 145列
```

**原因**: JRA-VANとJRDBでキー列の値が一致していない

**対処法**:
1. `kaisai_nen`, `kaisai_tsukihi`, `keibajo_code`, `race_bango`, `umaban` の型・値を確認
2. 両データのサンプルを出力して比較:
   ```python
   import pandas as pd
   jravan = pd.read_csv('temp_jravan_sample.csv', nrows=10)
   jrdb = pd.read_csv('temp_jrdb_sample.csv', nrows=10)
   print(jravan[['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban']])
   print(jrdb[['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban']])
   ```
3. 必要に応じて型変換やフォーマット統一

---

### エラー3: メモリ不足

**症状**:
```
MemoryError: Unable to allocate array
```

**原因**: データ量が大きすぎてメモリに載らない

**対処法**:
1. `pd.read_sql()` で `chunksize` パラメータを使用
2. 抽出期間を分割して複数回実行
3. メモリを増設

---

### エラー4: カラム数不一致

**症状**:
```
最終カラム数: 145列
期待カラム数: 148列
⚠️ カラム数不一致 (期待: 148, 実際: 145)
```

**原因**: SQLクエリで一部カラムが抽出されていない

**対処法**:
1. `logs/phase1_extraction.log` を確認
2. SQLファイル (`jravan_extraction.sql`, `jrdb_extraction.sql`) を確認
3. 不足しているカラムを特定し、SQLに追加

---

### エラー5: データベース接続タイムアウト

**症状**:
```
sqlalchemy.exc.OperationalError: could not connect to server: Connection timed out
```

**原因**: PostgreSQLサービスが起動していない、またはネットワークエラー

**対処法**:
1. PostgreSQL サービスを起動
   ```powershell
   # Windowsサービス確認
   Get-Service -Name postgresql*
   # サービス起動
   Start-Service -Name postgresql-x64-XX
   ```
2. `config/db_config.yaml` の設定を再確認
3. ファイアウォール設定を確認

---

## 📊 Phase 1 完了後の次ステップ

Phase 1完了後、以下のフォーマットでAIに報告してください:

```markdown
# Phase 1 完了報告

## 実行環境
- OS: Windows 11
- Python: 3.14.2
- 実行時間: XX分XX秒

## 実行結果
- JRA-VAN抽出: XXX,XXX件 × 97列
- JRDB抽出: XXX,XXX件 × 48列
- マージ後: XXX,XXX件 × 145列
- 派生特徴量計算: 3列追加
- 最終: XXX,XXX件 × 148列
- CSV保存: ✅ data/raw/jra_integrated_raw.csv

## 統計情報
- ファイルサイズ: XXX MB
- マージ率: XX.XX%
- 欠損率最大カラム: XXX (XX.XX%)
- 期間: 2020-01-01 ～ 2025-12-31

## 確認事項
- [x] カラム数148列
- [x] レコード数が妥当
- [x] マージ率80%以上
- [x] エラーなし
- [x] ログファイル生成

## Phase 2 移行
Phase 2 (前処理・特徴量エンジニアリング) への移行を希望します。
```

---

## 📚 参照ドキュメント

1. **特徴量仕様書**: `INTEGRATED_FEATURE_SPECIFICATION_FINAL.md`
2. **Phase 0完了報告**: `PHASE0_COMPLETION_REPORT.md`
3. **開発フロー**: `JRA_DEVELOPMENT_FLOW.md`
4. **データベース設定**: `config/db_config.yaml`

---

**作成日**: 2026-02-19  
**Phase**: Phase 1 (データ抽出)  
**次Phase**: Phase 2 (前処理・特徴量エンジニアリング)  
**推定実行時間**: 6～20分
