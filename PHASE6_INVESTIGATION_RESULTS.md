# Phase 6: 調査結果レポート

## 📅 調査日時
2026-02-22

---

## ✅ タスク1: PC-KEIBA PostgreSQL確認 - **完了**

### PostgreSQLサービス状態
```
Status: Running ✅
Name: postgresql-x64-16
DisplayName: postgresql-x64-16 - PostgreSQL Server
バージョン: PostgreSQL 16.x
```

### PC-KEIBA設定ファイル
**場所**: `C:\Users\ihaji\AppData\Roaming\PC-KEIBA Database\`

**発見ファイル**:
- ✅ `AppConfig.xml` (1,380 bytes, 最終更新: 2026/02/21 23:43)
- ✅ `LastFileTimestamp.xml` (186 bytes)
- ✅ `RecordIdConfigJvd.xml` (5,574 bytes) - **JRA-VAN Data設定**
- ✅ `RecordIdConfigNvd.xml` (4,833 bytes) - **地方競馬設定**
- 📁 `logs/` フォルダ（app.log含む）

### 次の調査項目
1. **AppConfig.xml** の内容確認（データベース接続情報）
2. **RecordIdConfigJvd.xml** の解析（JRA-VAN Data取得設定）
3. PostgreSQLデータベース名・ユーザー名・ポート確認

---

## 🔍 次のステップ: 設定ファイル解析

### PowerShellコマンド（次に実行）

```powershell
# 1. AppConfig.xmlの内容確認
Get-Content "$env:APPDATA\PC-KEIBA Database\AppConfig.xml"

# 2. PostgreSQLデータディレクトリ確認
Get-ChildItem "C:\Program Files\PostgreSQL\16\data" -ErrorAction SilentlyContinue

# 3. PostgreSQL設定ファイル確認
Get-Content "C:\Program Files\PostgreSQL\16\data\postgresql.conf" | Select-String "port"

# 4. PC-KEIBAデータベースファイル検索
Get-ChildItem "C:\Program Files\PostgreSQL\16\data" -Recurse -Include "*.db","pg_*" -ErrorAction SilentlyContinue | Select-Object FullName -First 10
```

---

## 📋 調査ステータス

| タスク | 状態 | 備考 |
|--------|------|------|
| PostgreSQLサービス確認 | ✅ 完了 | postgresql-x64-16 起動中 |
| PC-KEIBA設定ファイル | ✅ 完了 | AppConfig.xml発見 |
| データベース接続情報 | 🔄 調査中 | AppConfig.xml解析必要 |
| JRDBファイル場所 | ⏳ 未実施 | タスク2 |
| JRDBフォーマット確認 | ⏳ 未実施 | タスク3 |

---

## 🎯 期待される次の発見

### AppConfig.xmlに含まれる可能性のある情報
```xml
<Database>
    <Host>localhost</Host>
    <Port>5432</Port>
    <DatabaseName>pc_keiba_db</DatabaseName>
    <Username>postgres</Username>
</Database>
```

### 確認すべきデータベース名候補
- `pc_keiba_db`
- `pckeiba`
- `keiba`
- `jra_data`

---

**次のアクション**: 上記のPowerShellコマンドを実行して、AppConfig.xmlの内容を報告してください。
