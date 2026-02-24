# JRDB 完全セットアップガイド
**最終更新**: 2026-02-24  
**目的**: DataSettings.xml の race_shikonen 定義を修正し、正しいデータを PostgreSQL に登録

---

## 🚨 現在の問題

### 根本原因
**DataSettings.xml** で `race_shikonen` が **`length="2"`** と定義されているため、PC-KEIBA が JRDB ファイルから**年の2桁（"26"）しか読み込んでいない**。

### 影響範囲
- `jrd_kyi` テーブル: `race_shikonen` = "26" （本来は "2602210106" のような10桁）
- `jrd_cyb` テーブル: 同様の問題
- `jrd_joa` テーブル: 同様の問題
- `jrd_sed` テーブル: 同様の問題
- **`jrd_bac` テーブル**: 存在しない（開催日情報が取得できない）

### 現在のデータ状態
```sql
-- race_shikonen の値
SELECT DISTINCT race_shikonen, LENGTH(race_shikonen) FROM jrd_kyi;
-- 結果: "26" (長さ 2)  ← 本来は "2602210106" (長さ 10)
```

---

## ✅ 解決策：3ステップ

### ステップ1: 既存テーブルの削除
不正なデータを含むテーブルをすべて削除します。

### ステップ2: DataSettings.xml の修正
`race_shikonen` の定義を **`length="2"`** → **`length="10"`** に変更します。

### ステップ3: PC-KEIBA で再登録
修正した DataSettings.xml を使って、正しいデータを登録します。

---

## 📋 実行手順（コピー＆ペースト）

### 🔧 PowerShell スクリプトの実行

#### **オプションA: 一括実行スクリプト（推奨）**
以下のスクリプトをコピーして PowerShell で実行してください。

```powershell
# E: ドライブに移動
cd E:\anonymous-keiba-ai-JRA

# スクリプト実行ポリシーを一時的に変更
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# 一括クリーンアップ & 再セットアップスクリプトを実行
# （スクリプトは sandbox の /home/user/webapp/ にあります）
# ローカル PC にコピーしてから実行してください
```

**スクリプト実行時の対話**:
1. PostgreSQL パスワードの入力を求められます → `postgres123` を入力
2. 既存テーブルの削除が実行されます
3. DataSettings.xml の修正が実行されます
4. PC-KEIBA での再登録手順が表示されます

---

#### **オプションB: 手動で段階的に実行**

##### 1. 既存テーブルの削除

```powershell
$env:PGPASSWORD = "postgres123"

# JRDB テーブルを一括削除
$tables = @("jrd_kyi","jrd_cyb","jrd_joa","jrd_sed","jrd_bac","jrd_cha","jrd_cza","jrd_hjc","jrd_kab","jrd_kka","jrd_kta","jrd_kza","jrd_mza","jrd_ot","jrd_ou","jrd_ov","jrd_ow","jrd_oz","jrd_skb","jrd_srb","jrd_tyb","jrd_ukc")

foreach ($table in $tables) {
    & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "DROP TABLE IF EXISTS $table CASCADE;"
    Write-Host "削除完了: $table" -ForegroundColor Green
}

# 削除確認
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname='public' AND tablename LIKE 'jrd_%' ORDER BY tablename;"

Remove-Item Env:\PGPASSWORD
Write-Host "`n✓ テーブル削除完了" -ForegroundColor Green
```

**期待される結果**: `(0 行)` と表示される（JRDB テーブルがすべて削除された）

---

##### 2. DataSettings.xml の修正

```powershell
$xmlFile = "E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml"

# バックアップ作成
$backupFile = $xmlFile + ".backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
Copy-Item $xmlFile $backupFile -Force
Write-Host "✓ バックアップ作成: $backupFile" -ForegroundColor Green

# ファイル内容を読み込み
$content = Get-Content $xmlFile -Raw -Encoding UTF8

# race_shikonen の length を 2 → 10 に変更
$beforeCount = ([regex]::Matches($content, '<column name="race_shikonen" length="2"')).Count
Write-Host "修正箇所: $beforeCount 箇所" -ForegroundColor Yellow

$newContent = $content -replace '<column name="race_shikonen" length="2"', '<column name="race_shikonen" length="10"'

# 保存（UTF-8 BOM なし）
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($xmlFile, $newContent, $utf8NoBom)

Write-Host "✓ 修正完了: length=`"2`" → length=`"10`" ($beforeCount 箇所)" -ForegroundColor Green

# 確認
Write-Host "`n修正後の確認:" -ForegroundColor Cyan
Select-String -Path $xmlFile -Pattern '<column name="race_shikonen"' | Select-Object -First 3
```

**期待される結果**:
```
data\jrdb\config\DataSettings.xml:123:      <column name="race_shikonen" length="10" />
data\jrdb\config\DataSettings.xml:456:      <column name="race_shikonen" length="10" />
data\jrdb\config\DataSettings.xml:789:      <column name="race_shikonen" length="10" />
```

---

##### 3. PC-KEIBA で再登録

**手順**:
1. **PC-KEIBA を起動**
2. **メニュー** → **データ(D)** → **外部データ登録**
3. **設定ファイル**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml`
4. **データフォルダ**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`
5. **開始** ボタンをクリック

**期待される登録ログ**:
```
BAC260221.lzh → BAC260221.txt 展開 → 10 件登録
KYI260221.lzh → KYI260221.txt 展開 → 530 件登録
CYB260221.lzh → CYB260221.txt 展開 → 530 件登録
JOA260221.lzh → JOA260221.txt 展開 → 530 件登録
SED260221.lzh → SED260221.txt 展開 → 530 件登録
SRB260221.txt → 36 件登録

（同様に 260222 のファイルも処理）
```

⚠️ **重要**: もし **BAC ファイルが登録されない**場合:
- `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\` に `BAC260221.lzh` と `BAC260222.lzh` が存在するか確認
- 存在しない場合は、JRDB データ提供元から再ダウンロード

---

## ✅ 登録後の検証

### PowerShell で確認

```powershell
$env:PGPASSWORD = "postgres123"

# テーブル件数確認
Write-Host "テーブル件数確認..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT 'jrd_kyi' AS table_name, COUNT(*) FROM jrd_kyi UNION ALL SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb UNION ALL SELECT 'jrd_joa', COUNT(*) FROM jrd_joa UNION ALL SELECT 'jrd_sed', COUNT(*) FROM jrd_sed UNION ALL SELECT 'jrd_bac', COUNT(*) FROM jrd_bac ORDER BY table_name;"

# race_shikonen の値確認
Write-Host "`nrace_shikonen 値確認..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT race_shikonen, LENGTH(race_shikonen) AS len, keibajo_code, race_bango, bamei FROM jrd_kyi ORDER BY race_shikonen DESC LIMIT 10;"

# jrd_bac の開催日確認
Write-Host "`n開催日確認 (jrd_bac)..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT * FROM jrd_bac ORDER BY race_shikonen DESC LIMIT 5;"

Remove-Item Env:\PGPASSWORD
Write-Host "`n✓ 確認完了" -ForegroundColor Green
```

### 期待される結果

#### テーブル件数
```
 table_name | count
------------+-------
 jrd_bac    |    20
 jrd_cyb    |  1027
 jrd_joa    |  1027
 jrd_kyi    |  1027
 jrd_sed    |  1027
```

#### race_shikonen の値
```
 race_shikonen |  len | keibajo_code | race_bango |       bamei
---------------+------+--------------+------------+-------------------
 2602221012    |  10  | 10           | 12         | ブラックティンカー
 2602221011    |  10  | 10           | 11         | サトノグリッター
 2602221010    |  10  | 10           | 10         | タマモブラウンタイ
```

✅ **成功**: `race_shikonen` が **10桁** になっている！

#### jrd_bac の開催日
```
 race_shikonen | keibajo_code | kaisai_nengappi | ...
---------------+--------------+-----------------+-----
 2602221012    | 10           | 20260222        | ...
 2602211012    | 10           | 20260221        | ...
```

✅ **成功**: `jrd_bac` テーブルが存在し、開催日情報が取得できる！

---

## 🎯 次のステップ：Phase 6 予測の実行

DataSettings.xml 修正後、データが正しく登録されたら、Phase 6 の予測を実行できます。

```powershell
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

# 2026年2月22日の予測を実行
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222

# 2026年2月21日の予測も実行
python scripts/phase6/phase6_daily_prediction.py --target-date 20260221
```

---

## 📝 まとめ

### 問題の根本原因
- **DataSettings.xml** で `race_shikonen` が `length="2"` と定義されていた
- PC-KEIBA が JRDB ファイルから年の2桁（"26"）しか読み込んでいなかった
- `jrd_bac` テーブルが作成されず、開催日情報が取得できなかった

### 解決策
1. **既存テーブル削除**: 不正なデータを削除
2. **XML 修正**: `race_shikonen` の定義を `length="10"` に変更
3. **再登録**: 修正した XML で正しいデータを登録

### 期待される成果
- `race_shikonen` が 10桁（例: "2602220106"）で正しく格納される
- `jrd_bac` テーブルが作成され、開催日情報が取得できる
- Phase 6 予測スクリプトが正常に実行できる

---

## 🔗 関連ファイル

- **cleanup_jrdb_tables_and_reimport.ps1**: 一括クリーンアップ & 再セットアップスクリプト
- **fix_jrdb_datasettings_xml.ps1**: DataSettings.xml 単独修正スクリプト
- **JRDB_SAFE_FOLDER_SETUP_PLAN.md**: フォルダ構成計画

---

**作成者**: Claude (GenSpark AI Developer)  
**最終更新**: 2026-02-24
