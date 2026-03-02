# JRDB データ再登録：完全手順ガイド

## 🎯 目的
race_shikonen が "26" だけになっている問題を解決し、正しい形式（例: "2602221012"）でデータを再登録する。

---

## ⚠️ 問題の原因
DataSettings.xml の race_shikonen 定義が `length="2"` になっているため、年（2バイト）しか読み取られていない。

---

## 🔧 解決手順

### ステップ1: 現在のデータを削除

```powershell
# パスワード設定
$env:PGPASSWORD = "postgres123"

Write-Host "既存データを削除中..." -ForegroundColor Yellow

# 4つのテーブルのデータを削除
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "TRUNCATE TABLE jrd_kyi CASCADE;"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "TRUNCATE TABLE jrd_cyb CASCADE;"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "TRUNCATE TABLE jrd_joa CASCADE;"
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "TRUNCATE TABLE jrd_sed CASCADE;"

Write-Host "✓ データ削除完了" -ForegroundColor Green

# 件数確認（すべて0になるはず）
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT 'jrd_kyi' AS table_name, COUNT(*) FROM jrd_kyi UNION ALL SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb UNION ALL SELECT 'jrd_joa', COUNT(*) FROM jrd_joa UNION ALL SELECT 'jrd_sed', COUNT(*) FROM jrd_sed;"

# パスワード変数をクリア
Remove-Item Env:\PGPASSWORD
```

---

### ステップ2: DataSettings.xml を修正

**重要**: JRDB の KYI ファイルのフィールド仕様では、race_shikonen は**ファイル名から取得**する必要があります。

しかし、PC-KEIBA の DataSettings.xml では、固定長ファイルの先頭から読み取る仕様になっているため、**この方法では正しく取得できません**。

#### 解決策A: PC-KEIBAの公式設定を確認

PC-KEIBA の公式サイトまたはサポートに問い合わせて、**最新の DataSettings.xml** を入手してください。

公式の XML では、race_shikonen の定義が正しく設定されているはずです。

#### 解決策B: 手動で XML を修正（非推奨）

もし公式 XML が入手できない場合、以下のように修正しますが、**動作保証はありません**:

```xml
<!-- 修正前 -->
<column name="race_shikonen" length="2" />

<!-- 修正後（仮） -->
<column name="race_shikonen" length="6" />
```

ただし、JRDB の KYI ファイルでは、race_shikonen は**ファイル先頭の2バイト（年）しか含まれていない**可能性が高いため、この修正では不十分です。

---

### ステップ3: PC-KEIBA で再登録

1. **PC-KEIBA** を起動
2. **データ(D)** → **外部データ登録** を選択
3. 設定:
   - **設定ファイル**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml`（修正後）
   - **データファイルの保存先**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`
4. **開始** をクリック
5. 登録完了を待つ（3〜5分）

---

### ステップ4: 登録結果の確認

```powershell
# パスワード設定
$env:PGPASSWORD = "postgres123"

# 件数確認
Write-Host "データ件数確認..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT 'jrd_kyi' AS table_name, COUNT(*) FROM jrd_kyi UNION ALL SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb UNION ALL SELECT 'jrd_joa', COUNT(*) FROM jrd_joa UNION ALL SELECT 'jrd_sed', COUNT(*) FROM jrd_sed;"

# race_shikonen の値確認
Write-Host "`nrace_shikonen の値確認..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT DISTINCT race_shikonen, LENGTH(race_shikonen) AS len FROM jrd_kyi ORDER BY race_shikonen DESC LIMIT 10;"

# サンプルデータ確認
Write-Host "`nサンプルデータ確認..." -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT race_shikonen, keibajo_code, race_bango, umaban, bamei FROM jrd_kyi ORDER BY race_shikonen DESC LIMIT 10;"

# パスワード変数をクリア
Remove-Item Env:\PGPASSWORD
Write-Host "`n✓ 確認完了" -ForegroundColor Green
```

**期待される結果**:
- race_shikonen の長さが 6〜10 文字
- 値が "260221..." または "2602221012" のような形式

---

## 🚨 もし race_shikonen がまだ "26" のみの場合

JRDB の KYI ファイル仕様では、**ファイル内に完全な race_shikonen が含まれていない**可能性があります。

その場合、以下のような代替案が必要です:

### 代替案1: VIEW で擬似的な race_shikonen を作成

```sql
-- 仮の race_shikonen を作成する VIEW
-- ただし、開催月日が不明なので完全な race_shikonen は作成不可
CREATE OR REPLACE VIEW jrd_kyi_with_pseudo_race_key AS
SELECT 
    '26' || 
    LPAD(kaisai_kai, 2, '0') || 
    CASE 
        WHEN kaisai_nichime = 'a' THEN '10'
        WHEN kaisai_nichime = 'b' THEN '11'
        WHEN kaisai_nichime = 'c' THEN '12'
        WHEN kaisai_nichime = '1' THEN '01'
        WHEN kaisai_nichime = '2' THEN '02'
        -- ... 他の値も同様
        ELSE LPAD(kaisai_nichime, 2, '0')
    END || 
    keibajo_code || 
    LPAD(race_bango, 2, '0') AS pseudo_race_key,
    *
FROM jrd_kyi;
```

ただし、これでも**開催月日が不明**なので、完全な解決にはなりません。

---

### 代替案2: PC-KEIBA公式サポートに問い合わせ

最も確実な方法は、**PC-KEIBA の公式サポートに問い合わせる**ことです:

- JRDB の race_shikonen をどのように取得するのか
- 正しい DataSettings.xml の設定方法
- BAC（開催データ）ファイルの登録方法

---

## 📝 まとめ

1. **現状**: race_shikonen が "26" のみで、開催日情報がない
2. **原因**: DataSettings.xml の定義が不正確 & JRDB ファイル仕様の理解不足
3. **解決策**: 
   - **推奨**: PC-KEIBA 公式サポートに問い合わせて正しい設定を入手
   - **代替**: BAC ファイルを登録して開催日情報を取得
   - **暫定**: VIEW で擬似的な race_key を作成（ただし完全ではない）

---

## 🔗 次のアクション

### 優先順位1: PC-KEIBA公式サポートに問い合わせ

以下の内容を問い合わせてください:
- JRDB の race_shikonen フィールドの正しい取得方法
- 最新の DataSettings.xml の入手方法
- BAC（開催データ）ファイルの登録手順

### 優先順位2: JRDB公式サイトでファイル仕様を確認

JRDB 公式サイト（https://www.jrdb.com/）で、KYI ファイルのフィールド定義を確認してください。

---

**最終更新**: 2026-02-24  
**作成者**: Claude (GenSpark AI Developer)
