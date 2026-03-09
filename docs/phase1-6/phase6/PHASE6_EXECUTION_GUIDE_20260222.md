# 🏇 Phase 6 当日予測実行ガイド (2026-02-22/23)

## 📋 概要

2026-02-22 (土曜) と 2026-02-23 (日曜) のレース予測を実行します。  
**所要時間**: 約10分 (データ確認含む)

---

## ✅ 前提条件の確認

### 1. PC-KEIBA + PostgreSQL のデータ状況

以下のデータが必要です:

#### JRA-VAN データ (PC-KEIBA標準データ)
- `jvd_ra` - レース基本情報
- `jvd_se` - 出走馬成績
- `jvd_ck` - 調教データ

#### JRDB データ (外部データ登録済み)
- `jrd_kyi` - 競走馬マスタ (KYI260221.txt, KYI260222.txt)
- `jrd_cyb` - 調教データ (CYB260221.txt, CYB260222.txt)
- `jrd_joa` - 情報データ (JOA260221.txt, JOA260222.txt)
- `jrd_sed` - 成績データ (SED260221.txt, SED260222.txt)

---

## 🚀 実行手順 (ステップ・バイ・ステップ)

### ステップ0: 環境準備 (初回のみ)

#### 0-1. リポジトリの最新版を取得

```powershell
# PowerShellを開く (管理者権限不要)
cd E:\anonymous-keiba-ai-JRA

# 最新版を取得
git fetch
git reset --hard origin/genspark_ai_developer

# 仮想環境の確認
.\venv\Scripts\Activate.ps1

# 必要なパッケージの確認
pip list | Select-String "lightgbm|pandas|psycopg2"
```

**期待される出力**:
```
lightgbm    4.x.x
pandas      2.x.x
psycopg2    2.9.x
```

---

### ステップ1: PostgreSQL データの確認

#### 1-1. JRA-VAN データの確認

```powershell
# pgAdmin または psql で実行
psql -U postgres -d pckeiba
```

```sql
-- 2026-02-22 (土曜) のレース数を確認
SELECT COUNT(DISTINCT race_bango) AS race_count,
       keibajo_code,
       kaisai_tsukihi
FROM jvd_ra
WHERE kaisai_nen = '26'
  AND kaisai_tsukihi = '0222'
GROUP BY keibajo_code, kaisai_tsukihi
ORDER BY keibajo_code;
```

**期待される出力** (例):
```
race_count | keibajo_code | kaisai_tsukihi
-----------+--------------+----------------
    12     |     01       |     0222       ← 札幌
    12     |     05       |     0222       ← 東京
    12     |     06       |     0222       ← 中山
合計 36レース程度
```

#### 1-2. JRDB データの確認

```sql
-- JRDBデータの登録状況を確認
SELECT 
    'KYI' as table_name, 
    COUNT(*) as count_260222 
FROM jrd_kyi 
WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'CYB', 
    COUNT(*) 
FROM jrd_cyb 
WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'JOA', 
    COUNT(*) 
FROM jrd_joa 
WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'SED', 
    COUNT(*) 
FROM jrd_sed 
WHERE race_shikonen LIKE '260222%';
```

**期待される出力**:
```
table_name | count_260222
-----------+--------------
KYI        |   150-200    ← 出走馬数
CYB        |   150-200
JOA        |   150-200
SED        |   150-200    ← 結果データ (レース後のみ)
```

**⚠️ 注意**: 
- レース前は SED のカウントが 0 でも問題ありません
- KYI/CYB/JOA の3つが 150-200件あれば予測可能

---

### ステップ2: データベース接続情報の確認

#### 2-1. 設定ファイルの確認

```powershell
# config/database.yaml の確認
notepad config\database.yaml
```

**期待される内容**:
```yaml
jravan:
  host: localhost
  port: 5432
  database: pckeiba
  user: postgres
  password: your_password

jrdb:
  host: localhost
  port: 5432
  database: pckeiba
  user: postgres
  password: your_password
```

**⚠️ 修正が必要な場合**:
- `host`: PC-KEIBAのPostgreSQLが動作しているホスト (通常は localhost)
- `port`: PostgreSQLのポート番号 (デフォルト: 5432)
- `database`: PC-KEIBAのデータベース名 (通常は pckeiba)
- `user`: PostgreSQLのユーザー名 (通常は postgres)
- `password`: PostgreSQLのパスワード

---

### ステップ3: Phase 6 予測スクリプトの実行

#### 3-1. 2026-02-22 (土曜) の予測

```powershell
# 仮想環境をアクティベート
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

# Phase 6 予測を実行
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222

# 実行中のログ表示 (例):
# [INFO] Phase 6 当日予測システム開始
# [INFO] 対象日: 2026-02-22
# [INFO] モデル読み込み中...
# [INFO] データベースから当日データ取得中...
# [INFO] 特徴量生成中...
# [INFO] 予測実行中...
# [INFO] 予測完了: results/predictions_20260222.md
```

**所要時間**: 約2-3分

#### 3-2. 生成されたレポートの確認

```powershell
# 予測結果を確認
notepad results\predictions_20260222.md
```

**期待される出力形式**:
```markdown
# 🏇 Phase 6 予測レポート - 2026-02-22

## 📊 予測サマリー

- 対象日: 2026-02-22 (土曜)
- 予測レース数: 36レース
- 予測完了時刻: 2026-02-23 14:23:45

---

## 🏆 レース別予測

### 01: 札幌 - 第1R (芝1200m)

| 順位 | 馬番 | 馬名 | 総合スコア | 分類確率 | ランク | タイム予測 |
|:-----|:-----|:-----|:----------|:--------|:------|:---------|
| 1 | 3 | ○○○○ | 0.85 | 0.78 | S | 1:09.2 |
| 2 | 7 | △△△△ | 0.72 | 0.65 | A | 1:09.8 |
| 3 | 5 | ××××× | 0.68 | 0.58 | B | 1:10.1 |

---

### 02: 札幌 - 第2R (ダート1700m)

...
```

---

### ステップ4: 2026-02-23 (日曜) の予測

#### 4-1. 同様の手順で実行

```powershell
# 日曜日の予測を実行
python scripts/phase6/phase6_daily_prediction.py --target-date 20260223

# 結果を確認
notepad results\predictions_20260223.md
```

---

## 📊 予測結果の読み方

### 総合スコア (0.00 ～ 1.00)

Phase 3～5のアンサンブルスコア:
- **0.30 × 二値分類確率** (3着以内に入る確率)
- **0.40 × ランキングスコア** (順位予測の信頼度)
- **0.30 × タイム予測** (走破タイム予測の信頼度)

### ランク分類

| ランク | 総合スコア | 評価 |
|:------|:---------|:----|
| **S** | 0.80 ～ 1.00 | 最有力候補 |
| **A** | 0.70 ～ 0.79 | 有力候補 |
| **B** | 0.60 ～ 0.69 | 対抗馬 |
| **C** | 0.50 ～ 0.59 | 穴馬 |
| **D** | 0.00 ～ 0.49 | 低評価 |

---

## 🔧 トラブルシューティング

### Q1: `ModuleNotFoundError: No module named 'lightgbm'`

```powershell
# 仮想環境で必要なパッケージをインストール
.\venv\Scripts\Activate.ps1
pip install lightgbm pandas psycopg2-binary pyyaml numpy scikit-learn
```

### Q2: `psycopg2.OperationalError: could not connect to server`

**原因**: PostgreSQLが起動していない、または接続情報が間違っている

**対処法**:
```powershell
# PostgreSQLの起動確認 (PC-KEIBAを起動していればOK)
# 接続テスト
psql -U postgres -d pckeiba -c "SELECT version();"
```

### Q3: `KeyError: 'jrd_kyi'` または `データが見つかりません`

**原因**: JRDBデータが登録されていない

**対処法**:
1. PC-KEIBA → データ → 外部データ登録
2. 2026-02-21, 2026-02-22 の KYI/CYB/JOA/SED をダウンロード
3. 「開始」ボタンで登録実行

### Q4: `FileNotFoundError: models/jra_binary_model.txt`

**原因**: Phase 3～5のモデルファイルが存在しない

**対処法**:
```powershell
# モデルファイルの確認
ls models\

# 必要なファイル:
# - jra_binary_model.txt
# - jra_ranking_model.txt
# - jra_regression_model_optimized.txt

# ない場合は、Phase 3～5を実行してモデルを生成
python scripts/phase3/train_binary_model.py
python scripts/phase4a/train_ranking_model.py
python scripts/phase4b/train_regression_model_optimized.py
```

### Q5: 予測結果が空、または一部のレースしか出ない

**原因**: 特定のレースでJRDBデータが欠損している

**対処法**:
```sql
-- レースごとのJRDBデータ充足率を確認
SELECT 
    ra.keibajo_code,
    ra.race_bango,
    COUNT(se.umaban) AS jravan_count,
    COUNT(kyi.umaban) AS jrdb_count,
    ROUND(COUNT(kyi.umaban)::NUMERIC / COUNT(se.umaban) * 100, 2) AS match_rate
FROM jvd_ra ra
INNER JOIN jvd_se se ON (
    ra.kaisai_nen = se.kaisai_nen
    AND ra.kaisai_tsukihi = se.kaisai_tsukihi
    AND ra.keibajo_code = se.keibajo_code
    AND ra.race_bango = se.race_bango
)
LEFT JOIN jrd_kyi kyi ON (
    se.ketto_toroku_bango = kyi.ketto_toroku_bango
)
WHERE ra.kaisai_nen = '26'
  AND ra.kaisai_tsukihi = '0222'
GROUP BY ra.keibajo_code, ra.race_bango
ORDER BY ra.keibajo_code, ra.race_bango;
```

**期待値**: match_rate が 90%以上あればOK

---

## 📝 実行チェックリスト

### 実行前の確認

- [ ] PC-KEIBA が起動している
- [ ] PostgreSQL が動作している
- [ ] JRA-VAN データが最新 (2026-02-22, 02-23)
- [ ] JRDB データが登録済み (KYI/CYB/JOA/SED)
- [ ] Python仮想環境がアクティベート済み
- [ ] Phase 3～5のモデルファイルが存在する

### 実行後の確認

- [ ] `results/predictions_20260222.md` が生成された
- [ ] 予測レース数が妥当 (30-40レース程度)
- [ ] 各レースで1位～5位までの予測が表示されている
- [ ] 総合スコアが 0.00 ～ 1.00 の範囲内
- [ ] エラーメッセージが表示されていない

---

## 🎯 次のステップ

1. **予測結果の確認**: `results/predictions_20260222.md` を開く
2. **実際のレース結果と比較**: レース終了後、SED データを登録し精度検証
3. **週次運用の確立**: 毎週金曜夜～土曜朝に同じ手順を繰り返す

---

## 📚 関連ドキュメント

- `scripts/phase6/README_PHASE6.md` - Phase 6の詳細仕様
- `PHASE6_WEEKLY_OPERATION_FINAL.md` - 週次運用フロー
- `PCKEIBA_JRDB_OPTIMIZATION_IMPLEMENTATION_PLAN.md` - JRDB登録最適化

---

**作成日**: 2026-02-23  
**対象**: 2026-02-22/23 予測実行  
**所要時間**: 約10分 (データ確認 + 予測実行)
