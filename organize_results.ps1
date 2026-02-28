# results フォルダ整理スクリプト
# 投稿用フォルダを作成し、note/bookers/tweetファイルを移動

param(
    [string]$ResultsPath = "E:\anonymous-keiba-ai-JRA\results"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "resultsフォルダ整理" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 投稿用フォルダを作成
$PostFolder = Join-Path $ResultsPath "投稿用"

if (-not (Test-Path $PostFolder)) {
    Write-Host "[1/3] 投稿用フォルダを作成中..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $PostFolder -Force | Out-Null
    Write-Host "  ✅ 作成完了: $PostFolder" -ForegroundColor Green
} else {
    Write-Host "[1/3] 投稿用フォルダは既に存在します" -ForegroundColor Gray
}

Write-Host ""

# note/bookers/tweetファイルを検索
Write-Host "[2/3] 移動対象ファイルを検索中..." -ForegroundColor Yellow

$noteFiles = Get-ChildItem -Path $ResultsPath -Filter "*_*_note.txt" -File -ErrorAction SilentlyContinue
$bookersFiles = Get-ChildItem -Path $ResultsPath -Filter "*_*_bookers.txt" -File -ErrorAction SilentlyContinue
$tweetFiles = Get-ChildItem -Path $ResultsPath -Filter "*_*_tweet.txt" -File -ErrorAction SilentlyContinue

$allFiles = @()
$allFiles += $noteFiles
$allFiles += $bookersFiles
$allFiles += $tweetFiles

if ($allFiles.Count -eq 0) {
    Write-Host "  ⚠️ 移動対象ファイルが見つかりません" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "完了（移動対象なし）" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Cyan
    exit 0
}

Write-Host "  📄 見つかったファイル: $($allFiles.Count)個" -ForegroundColor Green
foreach ($file in $allFiles) {
    Write-Host "     - $($file.Name)" -ForegroundColor Gray
}

Write-Host ""

# ファイルを移動
Write-Host "[3/3] ファイルを移動中..." -ForegroundColor Yellow

$movedCount = 0
$errorCount = 0

foreach ($file in $allFiles) {
    try {
        $destPath = Join-Path $PostFolder $file.Name
        
        # 移動先に同名ファイルがある場合は上書き
        if (Test-Path $destPath) {
            Remove-Item $destPath -Force
        }
        
        Move-Item -Path $file.FullName -Destination $destPath -Force
        Write-Host "  ✅ 移動: $($file.Name)" -ForegroundColor Green
        $movedCount++
    }
    catch {
        Write-Host "  ❌ エラー: $($file.Name) - $_" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ 整理完了" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  移動成功: $movedCount 個" -ForegroundColor Green
if ($errorCount -gt 0) {
    Write-Host "  移動失敗: $errorCount 個" -ForegroundColor Red
}
Write-Host ""
Write-Host "投稿用フォルダの内容:" -ForegroundColor Yellow

$postFiles = Get-ChildItem -Path $PostFolder -File -ErrorAction SilentlyContinue | Sort-Object Name
if ($postFiles.Count -gt 0) {
    foreach ($file in $postFiles) {
        $sizeKB = [math]::Round($file.Length / 1KB, 1)
        Write-Host "  📄 $($file.Name) ($sizeKB KB)" -ForegroundColor Gray
    }
} else {
    Write-Host "  （ファイルなし）" -ForegroundColor Gray
}

Write-Host ""
Write-Host "処理を完了しました。何かキーを押して終了..." -ForegroundColor Gray
pause
