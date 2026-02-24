# JRDB DataSettings.xml の race_shikonen 定義を修正するスクリプト
# length="2" → length="10" に一括変更

$xmlFile = "E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DataSettings.xml 修正スクリプト" -ForegroundColor Cyan
Write-Host "race_shikonen length=`"2`" → length=`"10`"" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if (Test-Path $xmlFile) {
    Write-Host "処理中: $xmlFile" -ForegroundColor Yellow
    
    # バックアップを作成
    $backupFile = $xmlFile + ".backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
    Copy-Item $xmlFile $backupFile -Force
    Write-Host "  ✓ バックアップ作成: $backupFile" -ForegroundColor Green
    
    # ファイル内容を読み込み（UTF-8）
    $content = Get-Content $xmlFile -Raw -Encoding UTF8
    
    # 置換前の出現回数をカウント
    $beforeCount = ([regex]::Matches($content, '<column name="race_shikonen" length="2"')).Count
    
    Write-Host "  発見: race_shikonen length=`"2`" が $beforeCount 箇所" -ForegroundColor Yellow
    
    # 置換実行
    $newContent = $content -replace '<column name="race_shikonen" length="2"', '<column name="race_shikonen" length="10"'
    
    # 置換後の出現回数をカウント
    $afterCount = ([regex]::Matches($newContent, '<column name="race_shikonen" length="10"')).Count
    
    # ファイルに書き込み（UTF-8 BOM なし）
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($xmlFile, $newContent, $utf8NoBom)
    
    Write-Host "  ✓ 置換完了: $beforeCount 箇所 → length=`"10`" に変更" -ForegroundColor Green
    Write-Host ""
    
    # 確認: 変更後の定義を表示
    Write-Host "変更後の確認（最初の5箇所）:" -ForegroundColor Yellow
    Select-String -Path $xmlFile -Pattern '<column name="race_shikonen"' | Select-Object -First 5 | ForEach-Object {
        Write-Host "  行 $($_.LineNumber): $($_.Line.Trim())" -ForegroundColor White
    }
    Write-Host ""
    
} else {
    Write-Host "  ✗ ファイルが見つかりません: $xmlFile" -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "修正完了！" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "次のステップ:" -ForegroundColor Yellow
Write-Host "1. PC-KEIBA を起動" -ForegroundColor White
Write-Host "2. データ(D) → 外部データ登録" -ForegroundColor White
Write-Host "3. 設定ファイル: $xmlFile" -ForegroundColor White
Write-Host "4. データフォルダ: E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\" -ForegroundColor White
Write-Host "5. 開始ボタンをクリックして再登録" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  重要: 修正前のデータをクリアするために、既存テーブルを削除してください" -ForegroundColor Yellow
