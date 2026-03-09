# JRDBデータ自動ダウンロード - PowerShellスクリプト
# Windowsタスクスケジューラで毎日実行

param(
    [string]$TargetDate = ""
)

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "JRDB Data Automatic Download" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Project directory
cd E:\anonymous-keiba-ai-JRA

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
.\venv\Scripts\Activate.ps1

# Set JRDB credentials from environment variables
if (-not $env:JRDB_USERNAME -or -not $env:JRDB_PASSWORD) {
    Write-Host "ERROR: JRDB credentials not set" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please set environment variables:" -ForegroundColor Yellow
    Write-Host '  $env:JRDB_USERNAME="your_username"' -ForegroundColor White
    Write-Host '  $env:JRDB_PASSWORD="your_password"' -ForegroundColor White
    Write-Host ""
    Write-Host "Or add to PowerShell profile:" -ForegroundColor Yellow
    Write-Host '  notepad $PROFILE' -ForegroundColor White
    Write-Host ""
    exit 1
}

# Determine target date (default: tomorrow)
if ($TargetDate -eq "") {
    $Tomorrow = (Get-Date).AddDays(1)
    $TargetDate = $Tomorrow.ToString("yyyyMMdd")
    Write-Host "Target date not specified, using tomorrow: $TargetDate" -ForegroundColor Yellow
} else {
    Write-Host "Target date: $TargetDate" -ForegroundColor Green
}

Write-Host ""

# Execute JRDB download script
Write-Host "Executing JRDB download script..." -ForegroundColor Yellow
python scripts\jrdb\download_jrdb_daily.py --target-date $TargetDate

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host "JRDB download completed successfully!" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Launch PC-KEIBA" -ForegroundColor White
    Write-Host "  2. Execute 'JRDB Import' (or wait for auto-import)" -ForegroundColor White
    Write-Host "  3. Run Phase 6 prediction:" -ForegroundColor White
    Write-Host "     python scripts\phase6\phase6_daily_prediction.py --target-date $TargetDate" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host "JRDB download failed" -ForegroundColor Red
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  1. Check JRDB credentials" -ForegroundColor White
    Write-Host "  2. Verify data is published on JRDB website" -ForegroundColor White
    Write-Host "  3. Check internet connection" -ForegroundColor White
    Write-Host "  4. Review log file in logs\ directory" -ForegroundColor White
    Write-Host ""
    exit 1
}
