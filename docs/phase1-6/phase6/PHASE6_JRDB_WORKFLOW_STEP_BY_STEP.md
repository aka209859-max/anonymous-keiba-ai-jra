# Phase 6 運用ワークフロー: JRDBデータ取得・取込手順（完全版）

## 📋 **前提条件**

### ✅ **必要な環境**
- PC-KEIBA インストール済み（PostgreSQL内蔵）
- JRDB会員登録済み（https://www.jrdb.com/）
- 会員ID・パスワード準備

### ✅ **必要なJRDBデータファイル**
| ファイル | 内容 | 重要度 |
|---------|------|--------|
| **KYI** | 競走馬データ（IDM、素質、脚質、馬印、血統、馬体、気配など） | **必須** |
| **CYB** | 調教データ（調教指数、馬道、追切評価、仕上がり状態など） | **必須** |
| **JOA** | 情報データ（厩舎コメント、パドック情報、馬具変更、脚元情報など） | 推奨 |
| **SED** | 成績データ（実走着順、上がり3Fタイム、走破タイム、レース評価など） | 推奨 |
| **KAB** | 開催データ（天候、馬場状態、芝・ダートの偏差、浮沈など） | オプション |

### ⚠️ **JRDBダウンロード時間制限**
- **制限時間帯**: レース当日の **08:00～19:00**
- **制限内容**: 過去データのダウンロードが制限される（サーバー負荷軽減のため）
- **推奨時間**: **19:00以降**（前日夜または当日夜）

---

## 🔄 **週次運用フロー（毎週金曜夜～土曜朝 / 土曜夜～日曜朝）**

---

## 📅 **金曜日夜～土曜日朝（土曜レース前）**

### **Step 1: PC-KEIBAでJRA-VANデータを更新**

#### **操作手順**:
```
1. PC-KEIBAを起動
2. メニューバー「データ(D)」をクリック
3. 「データ更新」を選択（またはF5キーを押す）
4. JRA-VAN DataLab.から自動的に土曜日の出走表データをダウンロード
5. 更新完了メッセージが表示されるまで待機（通常5-10分）
```

#### **確認事項**:
- ステータスバーに「データ更新完了」と表示されることを確認
- エラーメッセージが表示された場合は、JRA-VAN接続設定を確認

---

### **Step 2: JRDB会員サイトから土曜日のデータをダウンロード**

#### **2-1. JRDB会員サイトにログイン**
```
1. ブラウザで https://www.jrdb.com/ にアクセス
2. 「会員ログイン」をクリック
3. 会員IDとパスワードを入力してログイン
```

#### **2-2. Target取り込みデータページに移動**
```
1. ログイン後、「データダウンロード」メニューをクリック
2. 「Target取り込みデータ」セクションを探す
3. または、以下のような直接リンクにアクセス:
   https://www.jrdb.com/member/datazip/download.asp
```

#### **2-3. 土曜日のデータファイルをダウンロード**
```
1. カレンダーまたはプルダウンメニューから「土曜日の日付」を選択
   例: 2026年2月22日（土）
   
2. 以下の4つのファイルを個別にダウンロード:
   ☑ KYI260222.zip（競走馬データ）
   ☑ CYB260222.zip（調教データ）
   ☑ JOA260222.zip（情報データ）
   ☑ SED260222.zip（成績データ）※前日まで
   
3. ダウンロード先フォルダを確認
   例: C:\Users\[ユーザー名]\Downloads\
```

#### **⚠️ 重要な注意事項**:
- ファイル名の日付部分は **YYMMDD形式**（例: 260222 = 2026年2月22日）
- ZIPファイルがダウンロードされる（解凍が必要）
- ダウンロード可能時間: **前日19:00以降**が推奨

---

### **Step 3: ダウンロードしたZIPファイルを解凍**

#### **3-1. Windows標準機能で解凍**
```
1. ダウンロードフォルダ内のZIPファイルを右クリック
2. 「すべて展開」を選択
3. 展開先を指定（例: C:\JRDB\data\260222\）
4. 「展開」をクリック
```

#### **3-2. 解凍後のファイル確認**
```
解凍すると、以下のようなテキストファイルが生成される:
C:\JRDB\data\260222\
├─ KYI260222.TXT
├─ CYB260222.TXT
├─ JOA260222.TXT
└─ SED260222.TXT
```

#### **⚠️ 注意事項**:
- テキストファイルの文字エンコーディングは **Shift-JIS**
- ファイル形式は **固定長テキスト**（CSVではない）

---

### **Step 4: PC-KEIBAでJRDBデータを取り込み**

#### **4-1. PC-KEIBAのJRDB取込機能を起動**

**❓ PC-KEIBAに「JRDB一括取込」メニューがある場合**:
```
1. PC-KEIBAのメニューバー「データ(D)」をクリック
2. 「外部データ登録」または「JRDBデータ取込」を選択
   （※ PC-KEIBAのバージョンによりメニュー名が異なる可能性あり）
3. 解凍したフォルダ（C:\JRDB\data\260222\）を指定
4. 「取込開始」をクリック
5. 進捗バーが100%になるまで待機
```

#### **❓ PC-KEIBAに「JRDB一括取込」メニューがない場合**:

**Option A: PostgreSQL経由で手動インポート**

```sql
-- 1. 一時テーブル作成
CREATE TEMP TABLE work_jrdb_kyi (raw_line TEXT);

-- 2. テキストファイルをロード（Shift-JIS）
COPY work_jrdb_kyi FROM 'C:\JRDB\data\260222\KYI260222.TXT' 
WITH (ENCODING 'SJIS');

-- 3. 固定長テキストをパースして本テーブルに挿入
INSERT INTO jrd_kyi (
    race_date, horse_name, idm, info_score, -- ... 他のカラム
)
SELECT 
    SUBSTRING(raw_line, 1, 8),      -- 日付（1バイト目～8バイト目）
    SUBSTRING(raw_line, 25, 36),    -- 馬名（25バイト目～36バイト目）
    SUBSTRING(raw_line, 61, 3)::INT, -- IDM（61バイト目～63バイト目）
    -- ... 他の項目も同様にSUBSTRINGで抽出
FROM work_jrdb_kyi;
```

**Option B: Pythonスクリプトで自動インポート**

```python
# scripts/jrdb/import_jrdb_to_pckeiba.py
import psycopg2
import os

def import_jrdb_file(file_path, target_table):
    """JRDBテキストファイルをPostgreSQLにインポート"""
    conn = psycopg2.connect(
        host='127.0.0.1',
        port=5432,
        database='pckeiba',
        user='postgres',
        password='postgres123'
    )
    
    cursor = conn.cursor()
    
    # 一時テーブル作成
    cursor.execute(f"CREATE TEMP TABLE work_jrdb (raw_line TEXT)")
    
    # ファイルロード
    with open(file_path, 'r', encoding='shift-jis') as f:
        cursor.copy_from(f, 'work_jrdb')
    
    # パースして本テーブルに挿入
    cursor.execute(f"""
        INSERT INTO {target_table} (...)
        SELECT 
            SUBSTRING(raw_line, 1, 8), 
            ...
        FROM work_jrdb
    """)
    
    conn.commit()
    cursor.close()
    conn.close()

# 実行
import_jrdb_file('C:\\JRDB\\data\\260222\\KYI260222.TXT', 'jrd_kyi')
import_jrdb_file('C:\\JRDB\\data\\260222\\CYB260222.TXT', 'jrd_cyb')
import_jrdb_file('C:\\JRDB\\data\\260222\\JOA260222.TXT', 'jrd_joa')
import_jrdb_file('C:\\JRDB\\data\\260222\\SED260222.TXT', 'jrd_sed')
```

---

### **Step 5: データ取込の確認**

#### **5-1. PostgreSQLで確認（推奨）**
```sql
-- pgAdmin または psql で実行

-- 1. KYIテーブルの確認
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
-- 期待値: 土曜日の全出走頭数（例: 150-200頭）

-- 2. CYBテーブルの確認
SELECT COUNT(*) FROM jrd_cyb WHERE race_shikonen LIKE '260222%';

-- 3. JRA-VANとの結合確認
SELECT 
    ra.race_id,
    se.umaban,
    se.bamei,
    kyi.idm,
    cyb.chokyoshi
FROM jvd_ra ra
LEFT JOIN jvd_se se ON ra.race_id = se.race_id
LEFT JOIN jrd_kyi kyi ON se.ketto_toroku_bango = kyi.ketto_toroku_bango
    AND ra.kaisai_tsukihi = SUBSTRING(kyi.race_shikonen, 1, 4)
LEFT JOIN jrd_cyb cyb ON kyi.race_shikonen = cyb.race_shikonen
    AND kyi.ketto_toroku_bango = cyb.ketto_toroku_bango
WHERE ra.kaisai_tsukihi = '0222'
LIMIT 10;

-- 期待結果: IDMやchokyoshi（調教指数）が NULL でないこと
```

#### **5-2. エラーが発生した場合の対処**
```
❌ エラー: 「テーブル jrd_kyi が存在しません」
→ 対処: PC-KEIBAで初回のJRDB取込を実行し、テーブルを自動生成させる

❌ エラー: 「文字エンコーディングエラー」
→ 対処: COPY文に WITH (ENCODING 'SJIS') を追加

❌ エラー: 「PRIMARY KEY制約違反」
→ 対処: 既存データを DELETE してから再インポート
   DELETE FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
```

---

### **Step 6: Phase 6実行（予測レポート生成）**

#### **6-1. Pythonスクリプト実行**
```powershell
# PowerShellを管理者権限で起動

# 1. プロジェクトフォルダに移動
cd E:\anonymous-keiba-ai-JRA

# 2. 仮想環境を有効化
.\venv\Scripts\Activate.ps1

# 3. Phase 6実行（土曜日の予測）
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222

# 実行結果例:
# ==========================================
# Phase 6: 当日予測システム実行開始
# ==========================================
# 対象日: 2026-02-22
# データベース接続: 127.0.0.1:5432/pckeiba
# 
# [Step 1] データ取得中...
# ✅ 基礎データ: 530頭（12レース）
# ✅ JRDB結合: 530行マッチ
# 
# [Step 2] 特徴量生成中...
# ✅ 特徴量マトリクス: 530行 × 145列
# 
# [Step 3] モデル読み込み中...
# ✅ Binary Model: models/jra_binary_model.txt
# ✅ Ranking Model: models/jra_ranking_model.txt
# ✅ Regression Model: models/jra_regression_model_optimized.txt
# 
# [Step 4] 予測実行中...
# ✅ アンサンブル予測完了
# 
# [Step 5] レポート保存中...
# ✅ Markdown: results/predictions_20260222.md
# ✅ CSV: results/predictions_20260222.csv
# 
# ==========================================
# Phase 6 実行完了 ✅
# ==========================================
```

#### **6-2. 予測レポート確認**
```powershell
# メモ帳で開く
notepad results\predictions_20260222.md

# またはVS Codeで開く
code results\predictions_20260222.md
```

#### **予測レポート例**:
```markdown
# 🏇 JRA競馬AI予想 - 2026年2月22日（土）

## 🏇 中山 第1R 予想

### 予想結果
| 順位 | 馬番 | 馬名 | スコア | 評価 | 騎手 | 馬主 |
|------|------|------|--------|------|------|------|
| 1 | 3 | フランジパーヌ | 1.00 | S | 武豊 | 田中太郎 |
| 2 | 7 | ミラクルレディ | 0.85 | A | 川田将雅 | 山本花子 |
| 3 | 12 | トップガン | 0.72 | A | 福永祐一 | 鈴木商事 |

### 購入推奨
- **本命軸**: 3番（単勝・複勝）
- **馬単**: 3-7, 3-12
- **三連複**: 3-7-12 BOX

---

## 🏇 中山 第2R 予想
...
```

---

## 📅 **土曜日夜～日曜日朝（日曜レース前）**

### **同じ手順を繰り返す**
```
Step 1: PC-KEIBAでデータ更新（F5）
Step 2: JRDB会員サイトから日曜日のデータをダウンロード
        （KYI260223.zip, CYB260223.zip, JOA260223.zip, SED260223.zip）
Step 3: ZIPファイルを解凍
Step 4: PC-KEIBAでJRDBデータ取込
Step 5: データ取込確認
Step 6: Phase 6実行（--target-date 20260223）
```

---

## 🔧 **自動化オプション（上級者向け）**

### **Option: Pythonスクリプトで全自動化**

```python
# scripts/jrdb/auto_download_and_import.py

import requests
from selenium import webdriver
import zipfile
import psycopg2
import subprocess
from datetime import datetime

def auto_workflow(target_date):
    """JRDB取得～Phase 6実行を全自動化"""
    
    # 1. JRDB会員サイトからダウンロード（Selenium）
    print("🔧 JRDBデータダウンロード中...")
    download_jrdb_data(target_date)
    
    # 2. ZIPファイル解凍
    print("🔧 ZIPファイル解凍中...")
    unzip_jrdb_files(target_date)
    
    # 3. PostgreSQLにインポート
    print("🔧 PostgreSQLにインポート中...")
    import_to_postgresql(target_date)
    
    # 4. Phase 6実行
    print("🔧 Phase 6実行中...")
    subprocess.run([
        'python', 
        'scripts/phase6/phase6_daily_prediction.py', 
        '--target-date', target_date
    ])
    
    print("✅ 全処理完了！")

# 実行
auto_workflow('20260222')
```

### **Windowsタスクスケジューラで毎週自動実行**
```
1. タスクスケジューラを起動
2. 「基本タスクの作成」をクリック
3. 名前: JRA_JRDB_Auto_Weekly
4. トリガー: 毎週金曜日 20:00
5. 操作: プログラムの開始
   - プログラム: python
   - 引数: E:\anonymous-keiba-ai-JRA\scripts\jrdb\auto_download_and_import.py 20260222
6. 完了
```

---

## ⚠️ **トラブルシューティング**

### **問題1: JRDBデータが0件**
```sql
-- 確認SQL
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
-- 結果: 0件

-- 原因:
- ファイルが正しくインポートされていない
- race_shikonen の日付形式が不一致（YYMMDD vs YYYYMMDD）

-- 対処:
1. 手動でテキストファイルを開き、日付形式を確認
2. SUBSTRINGの位置指定を修正
3. 再インポート実行
```

### **問題2: Phase 6でエラー「JRDB data missing」**
```
エラーメッセージ:
⚠️ 警告: JRDBデータが0件です

対処:
1. Step 5のSQL確認を実行
2. jrd_kyi, jrd_cyb テーブルにデータが存在するか確認
3. 存在しない場合は、Step 4のインポート手順を再実行
```

### **問題3: PC-KEIBAに「JRDB一括取込」メニューがない**
```
対処:
- PC-KEIBAのバージョンが古い可能性
- 「データ(D)」メニュー内の以下を探す:
  - 「外部データ登録」
  - 「Pythonデータ登録」
  - 「データベースSQLファイル実行」
  
見つからない場合:
→ Option Bの「Pythonスクリプトで自動インポート」を使用
```

---

## 📊 **データ取込成功の判定基準**

### ✅ **成功の条件**
```sql
-- 1. JRA-VANデータが存在
SELECT COUNT(*) FROM jvd_ra WHERE kaisai_tsukihi = '0222';
-- 期待値: 土曜日の全レース数（例: 36レース）

-- 2. JRDBデータが存在
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
-- 期待値: 土曜日の全出走頭数（例: 150-200頭）

-- 3. 結合可能（NULLが少ない）
SELECT 
    COUNT(*) AS total,
    COUNT(kyi.idm) AS jrdb_match,
    ROUND(COUNT(kyi.idm)::NUMERIC / COUNT(*) * 100, 2) AS match_rate
FROM jvd_se se
LEFT JOIN jrd_kyi kyi ON se.ketto_toroku_bango = kyi.ketto_toroku_bango
WHERE se.kaisai_tsukihi = '0222';
-- 期待値: match_rate ≥ 95%
```

---

## 📝 **週次チェックリスト**

### **金曜夜～土曜朝**
- [ ] PC-KEIBA起動
- [ ] F5でJRA-VANデータ更新完了
- [ ] JRDB会員サイトから土曜日データダウンロード（KYI, CYB, JOA, SED）
- [ ] ZIPファイル解凍完了
- [ ] PC-KEIBAでJRDB取込完了
- [ ] PostgreSQL確認SQL実行（データ存在確認）
- [ ] Phase 6実行（--target-date 20260222）
- [ ] predictions_20260222.md 生成確認

### **土曜夜～日曜朝**
- [ ] 同上（日曜日 --target-date 20260223）

---

## 🔗 **参考リンク**

- **JRDB公式サイト**: https://www.jrdb.com/
- **JRA-VAN DataLab**: https://www.jra-van.jp/
- **PC-KEIBA製品情報**: https://www.jra-van.jp/software/pckeiba/
- **PostgreSQL公式ドキュメント**: https://www.postgresql.org/docs/

---

## 📚 **関連ドキュメント**

- `PCKEIBA_PHASE1_5_INVESTIGATION_FINAL_VERDICT.md` - PC-KEIBA実装可能性調査
- `PCKEIBA_JRDB_INVESTIGATION_PROMPT.md` - JRDB調査指示書
- `README_PHASE6.md` - Phase 6仕様書
- `scripts/phase6/phase6_daily_prediction.py` - Phase 6実行スクリプト

---

**作成日**: 2026-02-23  
**最終更新**: 2026-02-23
