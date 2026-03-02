# JRDB セットアップ: ステップ実行ガイド

## 📋 実行手順（コピー＆ペースト用）

### ステップ1: 設定ファイルを安全な場所にコピー

**PowerShell で実行**:
```powershell
# E: ドライブのプロジェクトフォルダに移動
cd E:\anonymous-keiba-ai-JRA\data\jrdb

# config フォルダ作成
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\data\jrdb\config" -Force

# Downloads から設定ファイルをコピー
Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\*.sql" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force
Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\DataSettings.xml" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force

# コピー確認
Write-Host "=== コピーされたファイル一覧 ===" -ForegroundColor Green
ls "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
```

**期待される結果**:
- jrd_kyi.sql (約 19 KB)
- jrd_cyb.sql (約 4 KB)
- jrd_joa.sql (約 3 KB)
- jrd_sed.sql (約 11 KB)
- DataSettings.xml (約 54 KB)

---

### ステップ2: pgAdmin でテーブル作成

#### 2-1. jrd_kyi テーブル作成
1. pgAdmin 4 を開く
2. **Servers → PostgreSQL 16 → Databases → pckeiba** を右クリック
3. **Query Tool** を選択
4. **File → Open File** から以下を選択:
   ```
   E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_kyi.sql
   ```
5. **F5** キーまたは ▶️ ボタンで実行
6. 下部の **Messages** タブで `CREATE TABLE` の成功を確認

#### 2-2. jrd_cyb テーブル作成
1. 同じ Query Tool で **File → Open File**:
   ```
   E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_cyb.sql
   ```
2. **F5** で実行
3. **Messages** タブで確認

#### 2-3. jrd_joa テーブル作成
1. **File → Open File**:
   ```
   E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_joa.sql
   ```
2. **F5** で実行
3. **Messages** タブで確認

#### 2-4. jrd_sed テーブル作成
1. **File → Open File**:
   ```
   E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_sed.sql
   ```
2. **F5** で実行
3. **Messages** タブで確認

---

### ステップ3: テーブル作成の検証

**pgAdmin Query Tool で実行**:
```sql
-- 4つのテーブルが作成されたか確認
SELECT tablename 
FROM pg_catalog.pg_tables 
WHERE schemaname='public' 
  AND tablename IN ('jrd_kyi','jrd_cyb','jrd_joa','jrd_sed')
ORDER BY tablename;
```

**期待される結果**:
| tablename |
|-----------|
| jrd_cyb   |
| jrd_joa   |
| jrd_kyi   |
| jrd_sed   |

---

### ステップ4: race_shikonen カラム定義の確認

**pgAdmin Query Tool で実行**:
```sql
SELECT 
    table_name, 
    column_name, 
    data_type, 
    character_maximum_length
FROM information_schema.columns 
WHERE table_name IN ('jrd_kyi','jrd_cyb','jrd_joa','jrd_sed')
  AND column_name = 'race_shikonen'
ORDER BY table_name;
```

**期待される結果**:
| table_name | column_name     | data_type        | character_maximum_length |
|------------|-----------------|------------------|--------------------------|
| jrd_cyb    | race_shikonen   | character varying| 10 または 6 以上          |
| jrd_joa    | race_shikonen   | character varying| 10 または 6 以上          |
| jrd_kyi    | race_shikonen   | character varying| 10 または 6 以上          |
| jrd_sed    | race_shikonen   | character varying| 10 または 6 以上          |

⚠️ **もし `character_maximum_length` が 2 の場合**: SQL ファイルが古い版です。最新の SQL ファイルを再ダウンロードしてください。

---

### ステップ5: PC-KEIBA でデータ登録

#### 5-1. 設定
1. PC-KEIBA を起動
2. **データ(D)** → **外部データ登録** を選択
3. 以下を設定:
   - **設定ファイル**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml`
   - **データファイルの保存先**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`

#### 5-2. 実行
1. **開始** ボタンをクリック
2. 進捗ログを監視:
   - `KYI260221.lzh → KYI260221.txt 展開中...`
   - `KYI260221.txt → jrd_kyi テーブルに 487 件登録`
   - `CYB260221.lzh → CYB260221.txt 展開中...`
   - `CYB260221.txt → jrd_cyb テーブルに 530 件登録`
   - （260222 の 4 ファイルも同様）
3. **登録完了** メッセージを待つ（約 3〜5 分）

---

### ステップ6: データ登録の検証

#### 6-1. 件数確認
```sql
SELECT 'jrd_kyi' AS table_name, COUNT(*) AS row_count FROM jrd_kyi
UNION ALL
SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb
UNION ALL
SELECT 'jrd_joa', COUNT(*) FROM jrd_joa
UNION ALL
SELECT 'jrd_sed', COUNT(*) FROM jrd_sed
ORDER BY table_name;
```

**期待される結果**:
| table_name | row_count |
|------------|-----------|
| jrd_cyb    | 1,000〜1,100 |
| jrd_joa    | 300〜400    |
| jrd_kyi    | 300〜400    |
| jrd_sed    | 400〜500    |

#### 6-2. race_shikonen の値確認
```sql
SELECT 
    race_shikonen, 
    keibajo_code, 
    kaisai_kai, 
    kaisai_nichime, 
    race_bango, 
    umaban,
    bamei
FROM jrd_kyi
WHERE race_shikonen LIKE '260221%' OR race_shikonen LIKE '260222%'
ORDER BY race_shikonen DESC, keibajo_code, race_bango, umaban
LIMIT 10;
```

**期待される結果**:
| race_shikonen | keibajo_code | kaisai_kai | kaisai_nichime | race_bango | umaban | bamei |
|---------------|--------------|------------|----------------|------------|--------|-------|
| 2602221212    | 12           | 1          | 12             | 12         | 15     | （馬名） |
| 2602221212    | 12           | 1          | 12             | 12         | 14     | （馬名） |
| ...           | ...          | ...        | ...            | ...        | ...    | ...   |

✅ **race_shikonen が "2602221212" のような 10 桁形式** であれば成功！

❌ **race_shikonen が "26" の 2 桁のみ** の場合は、SQL ファイルまたは XML 設定に問題があります。

---

### ステップ7: Phase 6 予測の実行

**すべての検証が OK なら**:

```powershell
# プロジェクトフォルダに移動
cd E:\anonymous-keiba-ai-JRA

# Python 仮想環境を有効化
.\venv\Scripts\Activate.ps1

# Phase 6 予測スクリプトを実行（2026年2月22日）
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222
```

**期待される出力**:
```
INFO: ========================================
INFO: Phase 6: 日次予測 (20260222)
INFO: ========================================
INFO: 対象日: 2026-02-22
INFO: JRDBデータ取得中...
INFO: 対象レース数: 36 レース
INFO: 出走馬数: 432 頭
INFO: データマッチ率: 95.3%
INFO: 特徴量生成中... (145 features)
INFO: モデル読み込み中...
INFO: 予測実行中...
INFO: 結果を保存中: results\predictions_20260222.md
INFO: ========================================
INFO: 予測完了！ (実行時間: 2分13秒)
INFO: ========================================
```

---

## ✅ チェックリスト

### セットアップ
- [ ] ステップ1: 設定ファイルを `E:\anonymous-keiba-ai-JRA\data\jrdb\config\` にコピー
- [ ] ステップ2-1: `jrd_kyi.sql` 実行
- [ ] ステップ2-2: `jrd_cyb.sql` 実行
- [ ] ステップ2-3: `jrd_joa.sql` 実行
- [ ] ステップ2-4: `jrd_sed.sql` 実行
- [ ] ステップ3: テーブル作成確認（4 行）
- [ ] ステップ4: `race_shikonen` カラム定義確認（長さ >= 6）

### データ登録
- [ ] ステップ5-1: PC-KEIBA 設定（XML パスとデータフォルダパス）
- [ ] ステップ5-2: 登録実行と完了確認
- [ ] ステップ6-1: 件数確認（各テーブル 300〜1,100 行）
- [ ] ステップ6-2: `race_shikonen` 値確認（10 桁形式）

### 予測実行
- [ ] ステップ7: Phase 6 予測スクリプト実行（20260222）
- [ ] 結果ファイル確認: `E:\anonymous-keiba-ai-JRA\results\predictions_20260222.md`

---

## 🚨 トラブルシューティング

### 問題A: `race_shikonen` が 2 桁のみ
**原因**: SQL ファイルの定義が `varchar(2)` になっている  
**解決策**: 最新の SQL ファイルを再ダウンロード、またはカラム定義を手動修正

### 問題B: PC-KEIBA で "登録件数 0 件"
**原因**: データファイルが見つからない、または XML 設定が間違っている  
**解決策**:
1. `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\*.lzh` の存在確認
2. XML パスが正しいか確認
3. PC-KEIBA のログを確認

### 問題C: Phase 6 で "JRDBデータが見つかりません"
**原因**: `race_shikonen` の形式が違う、またはデータが未登録  
**解決策**: ステップ 6-2 の SQL で `race_shikonen` の値を確認

---

**最終更新**: 2026-02-24  
**作成者**: Claude (GenSpark AI Developer)
