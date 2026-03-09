# JRDB SQL ファイルの race_shikonen 定義を修正するスクリプト
# varchar(2) → varchar(10) に一括変更

$sqlFiles = @(
    "E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_kyi.sql",
    "E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_cyb.sql",
    "E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_joa.sql",
    "E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_sed.sql"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "JRDB SQL ファイル修正スクリプト" -ForegroundColor Cyan
Write-Host "race_shikonen varchar(2) → varchar(10)" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

foreach ($file in $sqlFiles) {
    if (Test-Path $file) {
        Write-Host "処理中: $file" -ForegroundColor Yellow
        
        # ファイル内容を読み込み
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # バックアップを作成
        $backupFile = $file + ".backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
        Copy-Item $file $backupFile -Force
        Write-Host "  ✓ バックアップ作成: $backupFile" -ForegroundColor Green
        
        # 置換前の出現回数をカウント
        $beforeCount = ([regex]::Matches($content, "race_shikonen character varying\(2\)")).Count
        
        # 置換実行
        $newContent = $content -replace "race_shikonen character varying\(2\)", "race_shikonen character varying(10)"
        
        # 置換後の出現回数をカウント
        $afterCount = ([regex]::Matches($newContent, "race_shikonen character varying\(10\)")).Count
        
        # ファイルに書き込み（UTF-8 BOM なし）
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file, $newContent, $utf8NoBom)
        
        Write-Host "  ✓ 置換完了: $beforeCount 箇所 (varchar(2) → varchar(10))" -ForegroundColor Green
        Write-Host ""
    } else {
        Write-Host "  ✗ ファイルが見つかりません: $file" -ForegroundColor Red
        Write-Host ""
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "修正完了！" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "確認コマンド（修正後）:" -ForegroundColor Yellow
Write-Host 'Select-String -Path "E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_kyi.sql" -Pattern "race_shikonen character varying"' -ForegroundColor White
Write-Host ""

Write-Host "次のステップ:" -ForegroundColor Yellow
Write-Host "1. pgAdmin の Query Tool で File → Open File から修正後の SQL を開く" -ForegroundColor White
Write-Host "2. F5 で実行してテーブルを作成" -ForegroundColor White
Write-Host "3. 4つすべてのファイルで繰り返す" -ForegroundColor White
