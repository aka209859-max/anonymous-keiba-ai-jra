# PC-KEIBA JRDB データ登録問題 - 現状まとめ

## 📌 やりたいこと

**Phase 6: 2026年2月22日(土)・23日(日)の競馬予測を実行したい**

必要な手順:
1. JRDBデータ（KYI, CYB, JOA, SED）をPC-KEIBAのPostgreSQLに登録
2. Phase 6予測スクリプトを実行
3. 予測結果を確認

---

## ⚠️ 現在発生している問題

### **問題の症状**
- PC-KEIBAの「外部データ登録」で処理は成功しているように見える
- しかし、PostgreSQLのテーブル（jrd_kyi）にデータが **0件** のまま

### **確認済みの事実**
✅ **8つのlzhファイルがダウンロード済み**
```
E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\
├── KYI260221.lzh
├── CYB260221.lzh
├── JOA260221.lzh
├── SED260221.lzh
├── KYI260222.lzh
├── CYB260222.lzh
├── JOA260222.lzh
└── SED260222.lzh
```

✅ **PC-KEIBAの処理ログには成功メッセージあり**
```
09:52:12 CYB260221.txt (530件)
09:52:12 CYB260222.txt (487件)
09:52:13 JOA260221.txt (530件)
09:52:13 JOA260222.txt (487件)
09:52:14 KYI260221.txt (530件)
09:52:15 KYI260222.txt (487件)
09:52:17 SED260221.txt (530件)
09:52:18 SED260222.txt (497件)
==== 処理を完了しました ====
```

✅ **PostgreSQLテーブルは存在する**
```
jrd_kyi, jrd_cyb, jrd_joa, jrd_sed など22個のJRDBテーブル確認済み
```

❌ **しかしデータが0件**
```sql
SELECT COUNT(*) FROM jrd_kyi; 
-- 結果: 788644件（過去の累積データ）

SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%';
-- 結果: 0件 ← 本来150〜200件あるはず

SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
-- 結果: 0件 ← 本来150〜200件あるはず
```

---

## 🔍 推測される原因

### **可能性1: race_shikonenカラムのフォーマット不一致**
- PC-KEIBAが書き込んだデータのrace_shikonen形式が `'260221%'` パターンと一致していない
- 実際のフォーマットを確認する必要がある

### **可能性2: データが別のカラム・テーブルに書き込まれている**
- PC-KEIBAの設定ファイル（XML）でマッピングが間違っている
- race_shikonenではなく、別の日付カラムに格納されている

### **可能性3: トランザクションがコミットされていない**
- データは書き込まれているがCOMMITされていない
- 別のセッションから見えない状態

### **可能性4: PC-KEIBAが別のデータベース・スキーマに書き込んでいる**
- pgAdminとPC-KEIBAが異なるデータベースに接続している

---

## 🎯 次に確認すべきこと

### **Step 1: 最新データの実際のフォーマットを確認**
```sql
-- jrd_kyiテーブルの最新10件を表示
SELECT race_shikonen, keibajo_code, race_bango, kaisai_nen, kaisai_tsuki, kaisai_hi
FROM jrd_kyi
ORDER BY race_shikonen DESC
LIMIT 10;
```
→ race_shikonenの実際の値を確認（例: `20260221` か `2602210101` か `260221` か）

### **Step 2: 2026年2月のデータを広く検索**
```sql
-- 2026年2月のデータを検索（複数パターン）
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '202602%';  -- 20260221形式
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '2602%';    -- 260221形式
SELECT COUNT(*) FROM jrd_kyi WHERE CAST(race_shikonen AS TEXT) LIKE '%2602%'; -- 任意の位置
```

### **Step 3: テーブル構造の確認**
```sql
-- jrd_kyiテーブルのカラム定義を確認
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_kyi'
ORDER BY ordinal_position;
```

### **Step 4: PC-KEIBAの設定ファイル確認**
PowerShellで以下を実行し、XML設定ファイルの内容を確認:
```powershell
# XML設定ファイルを検索
Get-ChildItem -Path "E:\*anonymous-keiba-ai-JRA\*","C:\Program Files\PC-KEIBA\*","C:\Users\$env:USERNAME\Documents\*","C:\Users\$env:USERNAME\AppData\*" -Filter "*jrdb*.xml" -Recurse -ErrorAction SilentlyContinue | Select FullName
```

---

## 📋 このドキュメントの使い方

**コピペして第三者（サポート・掲示板など）に質問する際のテンプレート:**

```
【質問】PC-KEIBAでJRDBデータ登録が成功しているのにPostgreSQLでデータが0件

【やりたいこと】
2026年2月22日・23日のJRDBデータ（KYI, CYB, JOA, SED）をPostgreSQLに登録し、Phase 6予測を実行したい

【現象】
- PC-KEIBAの「外部データ登録」で処理完了メッセージが表示される
- ログには「CYB260221.txt (530件)」などデータ読み込みの記録がある
- しかしPostgreSQLで `SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%'` を実行すると0件

【確認済み】
✅ lzhファイル8個がフォルダに存在
✅ PC-KEIBAの処理ログに成功メッセージあり
✅ PostgreSQLのjrd_kyiテーブルは存在（過去データ788,644件あり）
❌ 260221と260222のデータが0件

【環境】
- PC-KEIBA（バージョン不明）
- PostgreSQL 16
- Windows
- データ保存先: E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\

【質問】
race_shikonenカラムのフォーマットが想定と違う可能性があります。
最新データの実際の格納形式を確認する方法、またはPC-KEIBAの設定ファイル（XML）の確認方法を教えてください。
```

---

## 🆘 次のアクション

**まず以下のSQLを実行して、結果を確認してください:**

```sql
-- 最新10件のrace_shikonenの実際の値を確認
SELECT race_shikonen, keibajo_code, race_bango
FROM jrd_kyi
ORDER BY race_shikonen DESC
LIMIT 10;
```

この結果で `race_shikonen` の実際のフォーマットが判明します。

---

**作成日時:** 2026-02-24  
**対象:** PC-KEIBA JRDB データ登録トラブルシューティング
