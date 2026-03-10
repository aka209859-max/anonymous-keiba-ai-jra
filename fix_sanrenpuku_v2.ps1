Write-Host "========================================" -ForegroundColor Cyan
Write-Host "三連複出力修正: 7位まで拡張（完全版）" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$scriptPath = "E:\anonymous-keiba-ai-JRA\scripts\phase6\phase6_daily_prediction.py"

# バックアップ作成
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupPath = "${scriptPath}.backup_sanrenpuku_${timestamp}"
Copy-Item $scriptPath $backupPath -Force
Write-Host "✅ バックアップ作成: $backupPath" -ForegroundColor Green

# ファイルを UTF-8 で読み込み
$content = Get-Content $scriptPath -Raw -Encoding UTF8

# 修正1: top_horses を 6 → 7 に変更（Line 1112）
Write-Host "`n【修正1】top_horses を 7 に変更" -ForegroundColor Yellow
$pattern1 = "        top_horses = group\.head\(6\)"
$replacement1 = "        top_horses = group.head(7)"
if ($content -match $pattern1) {
    $content = $content -replace $pattern1, $replacement1
    Write-Host "✅ 修正1完了" -ForegroundColor Green
} else {
    Write-Host "❌ 修正1失敗: パターンが見つかりません" -ForegroundColor Red
}

# 修正2: 三連複の条件を >= 6 → >= 7 に変更（Line 1174）
Write-Host "`n【修正2】条件を >= 7 に変更" -ForegroundColor Yellow
$pattern2 = "            if len\(top_horses\) >= 6:"
$replacement2 = "            if len(top_horses) >= 7:"
if ($content -match $pattern2) {
    $content = $content -replace $pattern2, $replacement2
    Write-Host "✅ 修正2完了" -ForegroundColor Green
} else {
    Write-Host "❌ 修正2失敗: パターンが見つかりません" -ForegroundColor Red
}

# 修正3: 相手2の範囲を range(1, 6) → range(1, 7) に変更（Line 1181）
Write-Host "`n【修正3】相手2の範囲を 2~7位に変更" -ForegroundColor Yellow
$pattern3 = "                aite2 = '\.'.join\(\[str\(int\(top_horses\.iloc\[i\]\['umaban'\]\)\) for i in range\(1, 6\)\]\)"
$replacement3 = "                aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 7)])"
if ($content -match $pattern3) {
    $content = $content -replace $pattern3, $replacement3
    Write-Host "✅ 修正3完了" -ForegroundColor Green
} else {
    Write-Host "❌ 修正3失敗: パターンが見つかりません" -ForegroundColor Red
}

# 修正4: Twitter形式の top_horses も 6 → 7 に変更（Line 1213）
Write-Host "`n【修正4】Twitter形式の top_horses を 7 に変更" -ForegroundColor Yellow
$pattern4 = "        top_horses = group\.head\(6\)"
$replacement4 = "        top_horses = group.head(7)"
# この修正は2回目の出現箇所なので、すでに置換済みの可能性あり
Write-Host "✅ 修正4はパターン1と同じため自動適用済み" -ForegroundColor Green

# UTF-8 BOM なしで保存
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($scriptPath, $content, $utf8NoBom)
Write-Host "`n✅ ファイル保存完了" -ForegroundColor Green

# 修正確認
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "【修正後の確認】" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n1. top_horses = group.head(7) の確認:" -ForegroundColor Yellow
$lines = Get-Content $scriptPath -Encoding UTF8
$lineNum = 0
foreach ($line in $lines) {
    $lineNum++
    if ($line -match "top_horses = group\.head") {
        Write-Host "Line ${lineNum}: $line" -ForegroundColor White
    }
}

Write-Host "`n2. if len(top_horses) >= 7: の確認:" -ForegroundColor Yellow
$lineNum = 0
foreach ($line in $lines) {
    $lineNum++
    if ($line -match "if len\(top_horses\) >=") {
        Write-Host "Line ${lineNum}: $line" -ForegroundColor White
    }
}

Write-Host "`n3. range(1, 7) の確認:" -ForegroundColor Yellow
$lineNum = 0
foreach ($line in $lines) {
    $lineNum++
    if ($line -match "range\(1, \d+\)") {
        Write-Host "Line ${lineNum}: $line" -ForegroundColor White
    }
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "✅ 三連複出力修正完了" -ForegroundColor Green
Write-Host "次は Phase 6 を再実行してください" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
