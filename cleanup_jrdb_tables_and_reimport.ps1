# JRDB テーブル全削除 + DataSettings.xml 修正 + 再登録ガイド
# 実行順序: 1) テーブル削除 → 2) XML 修正 → 3) PC-KEIBA で再登録

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "JRDB 完全クリーンアップ & 再セットアップ" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# パスワード設定
$password = Read-Host "PostgreSQL パスワード (postgres ユーザー)" 
$env:PGPASSWORD = $password

Write-Host "`n[ステップ 1/4] 既存 JRDB テーブルの削除" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray

# 既存の JRDB テーブルをすべて削除
$tablesToDrop = @(
    "jrd_kyi", "jrd_cyb", "jrd_joa", "jrd_sed",
    "jrd_bac", "jrd_cha", "jrd_cza", "jrd_hjc",
    "jrd_kab", "jrd_kka", "jrd_kta", "jrd_kza",
    "jrd_mza", "jrd_ot", "jrd_ou", "jrd_ov",
    "jrd_ow", "jrd_oz", "jrd_skb", "jrd_srb",
    "jrd_tyb", "jrd_ukc"
)

foreach ($table in $tablesToDrop) {
    Write-Host "削除中: $table" -ForegroundColor Gray -NoNewline
    $result = & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "DROP TABLE IF EXISTS $table CASCADE;" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " ✓" -ForegroundColor Green
    } else {
        Write-Host " (スキップ)" -ForegroundColor DarkGray
    }
}

Write-Host "`n[ステップ 2/4] テーブル削除の確認" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname='public' AND tablename LIKE 'jrd_%' ORDER BY tablename;"

Write-Host "`n[ステップ 3/4] DataSettings.xml の修正" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray

$xmlFile = "E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml"

if (Test-Path $xmlFile) {
    # バックアップを作成
    $backupFile = $xmlFile + ".backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
    Copy-Item $xmlFile $backupFile -Force
    Write-Host "✓ バックアップ作成: $backupFile" -ForegroundColor Green
    
    # ファイル内容を読み込み
    $content = Get-Content $xmlFile -Raw -Encoding UTF8
    
    # 置換前の出現回数
    $beforeCount = ([regex]::Matches($content, '<column name="race_shikonen" length="2"')).Count
    Write-Host "✓ 発見: race_shikonen length=`"2`" が $beforeCount 箇所" -ForegroundColor Yellow
    
    # 置換実行
    $newContent = $content -replace '<column name="race_shikonen" length="2"', '<column name="race_shikonen" length="10"'
    
    # 保存
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($xmlFile, $newContent, $utf8NoBom)
    
    Write-Host "✓ 置換完了: length=`"2`" → length=`"10`" ($beforeCount 箇所)" -ForegroundColor Green
    
    # 確認
    Write-Host "`n修正後の確認（最初の3箇所）:" -ForegroundColor Cyan
    Select-String -Path $xmlFile -Pattern '<column name="race_shikonen"' | Select-Object -First 3 | ForEach-Object {
        Write-Host "  $($_.Line.Trim())" -ForegroundColor White
    }
} else {
    Write-Host "✗ ファイルが見つかりません: $xmlFile" -ForegroundColor Red
}

Write-Host "`n[ステップ 4/4] PC-KEIBA で再登録" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "次の手順を実行してください:" -ForegroundColor White
Write-Host ""
Write-Host "1. PC-KEIBA を起動" -ForegroundColor White
Write-Host "2. メニュー → データ(D) → 外部データ登録" -ForegroundColor White
Write-Host "3. 設定ファイル: $xmlFile" -ForegroundColor Cyan
Write-Host "4. データフォルダ: E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\" -ForegroundColor Cyan
Write-Host "5. 開始ボタンをクリック" -ForegroundColor White
Write-Host ""
Write-Host "期待される結果:" -ForegroundColor Yellow
Write-Host "  - BAC260221.lzh → BAC260221.txt 展開 → XX 件登録" -ForegroundColor Gray
Write-Host "  - KYI260221.lzh → KYI260221.txt 展開 → 530 件登録" -ForegroundColor Gray
Write-Host "  - CYB260221.lzh → CYB260221.txt 展開 → 530 件登録" -ForegroundColor Gray
Write-Host "  - JOA260221.lzh → JOA260221.txt 展開 → 530 件登録" -ForegroundColor Gray
Write-Host "  - SED260221.lzh → SED260221.txt 展開 → 530 件登録" -ForegroundColor Gray
Write-Host "  （同様に 260222 のファイルも処理）" -ForegroundColor Gray
Write-Host ""

# パスワード変数をクリア
Remove-Item Env:\PGPASSWORD
Write-Host "✓ 環境変数クリア完了" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "準備完了！PC-KEIBA で再登録を実行してください" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "再登録後の確認コマンド:" -ForegroundColor Yellow
Write-Host '$env:PGPASSWORD = "postgres123"' -ForegroundColor White
Write-Host '& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT ''jrd_kyi'' AS table_name, COUNT(*) FROM jrd_kyi UNION ALL SELECT ''jrd_cyb'', COUNT(*) FROM jrd_cyb UNION ALL SELECT ''jrd_joa'', COUNT(*) FROM jrd_joa UNION ALL SELECT ''jrd_sed'', COUNT(*) FROM jrd_sed UNION ALL SELECT ''jrd_bac'', COUNT(*) FROM jrd_bac ORDER BY table_name;"' -ForegroundColor White
Write-Host '& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT race_shikonen, LENGTH(race_shikonen) AS len, keibajo_code, race_bango, bamei FROM jrd_kyi ORDER BY race_shikonen DESC LIMIT 10;"' -ForegroundColor White
Write-Host 'Remove-Item Env:\PGPASSWORD' -ForegroundColor White
