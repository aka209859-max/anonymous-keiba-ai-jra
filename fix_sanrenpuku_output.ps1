Write-Host "========================================" -ForegroundColor Cyan
Write-Host "三連複出力修正: 7位まで拡張" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$scriptPath = "E:\anonymous-keiba-ai-JRA\scripts\phase6\phase6_daily_prediction.py"

# バックアップ作成
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupPath = "${scriptPath}.backup_sanrenpuku_${timestamp}"
Copy-Item $scriptPath $backupPath -Force
Write-Host "✅ バックアップ作成: $backupPath" -ForegroundColor Green

# ファイルを UTF-8 で読み込み
$content = Get-Content $scriptPath -Raw -Encoding UTF8

# 修正1: top_horses を 6 → 7 に変更
$oldLine1 = "        top_horses = group.head(6)"
$newLine1 = "        top_horses = group.head(7)"

# 修正2: 三連複の相手2を 1~6位 → 1~7位 に変更
$oldLine2 = "            if len(top_horses) >= 6:"
$newLine2 = "            if len(top_horses) >= 7:"

# 修正3: 相手2の範囲を range(1, 6) → range(1, 7) に変更
$oldLine3 = "                aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 6)])"
$newLine3 = "                aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 7)])"

# 置換実行
$modified = $false

if ($content -match [regex]::Escape($oldLine1)) {
    $content = $content -replace [regex]::Escape($oldLine1), $newLine1
    Write-Host "✅ 修正1完了: top_horses を 7 に変更" -ForegroundColor Green
    $modified = $true
} else {
    Write-Host "⚠️  修正1: 該当行が見つかりません" -ForegroundColor Yellow
}

if ($content -match [regex]::Escape($oldLine2)) {
    $content = $content -replace [regex]::Escape($oldLine2), $newLine2
    Write-Host "✅ 修正2完了: 条件を >= 7 に変更" -ForegroundColor Green
    $modified = $true
} else {
    Write-Host "⚠️  修正2: 該当行が見つかりません" -ForegroundColor Yellow
}

if ($content -match [regex]::Escape($oldLine3)) {
    $content = $content -replace [regex]::Escape($oldLine3), $newLine3
    Write-Host "✅ 修正3完了: 相手2の範囲を 1~7位に変更" -ForegroundColor Green
    $modified = $true
} else {
    Write-Host "⚠️  修正3: 該当行が見つかりません" -ForegroundColor Yellow
}

if ($modified) {
    # UTF-8 BOM なしで保存
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($scriptPath, $content, $utf8NoBom)
    Write-Host "✅ ファイル保存完了" -ForegroundColor Green
}

# 修正確認
Write-Host "`n【修正後の該当箇所】" -ForegroundColor Cyan
Write-Host "Line 1112 付近:" -ForegroundColor Yellow
Select-String -Path $scriptPath -Pattern "top_horses = group.head" -Context 0,0

Write-Host "`nLine 1174 付近:" -ForegroundColor Yellow
Select-String -Path $scriptPath -Pattern "if len\(top_horses\) >= \d+:" -Context 0,2

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "✅ 三連複出力修正完了" -ForegroundColor Green
Write-Host "次は Phase 6 を再実行してください" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
