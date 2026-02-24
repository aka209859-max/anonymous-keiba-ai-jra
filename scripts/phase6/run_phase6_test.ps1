# Phase 6: Daily Prediction System Test Script
# Test execution for 2026-02-21 & 2026-02-22 data

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Phase 6: Daily Prediction System Test" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Change to project directory
cd E:\anonymous-keiba-ai-JRA

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
.\venv\Scripts\Activate.ps1

# Create necessary directories
Write-Host "Creating directories..." -ForegroundColor Yellow
if (-not (Test-Path "scripts\phase6")) {
    New-Item -ItemType Directory -Path "scripts\phase6" -Force | Out-Null
}

if (-not (Test-Path "results")) {
    New-Item -ItemType Directory -Path "results" -Force | Out-Null
}

if (-not (Test-Path "logs")) {
    New-Item -ItemType Directory -Path "logs" -Force | Out-Null
}

Write-Host "Directory creation complete" -ForegroundColor Green
Write-Host ""

# Prediction for 2026-02-21
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Test 1: Prediction for 2026-02-21" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

python scripts\phase6\phase6_daily_prediction.py --target-date 20260221

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Prediction for 2026-02-21 completed successfully" -ForegroundColor Green
    Write-Host ""
    
    # Check result file
    if (Test-Path "results\predictions_20260221.csv") {
        $fileInfo = Get-Item "results\predictions_20260221.csv"
        Write-Host "Prediction result file:" -ForegroundColor Yellow
        Write-Host "  Filename: $($fileInfo.Name)" -ForegroundColor White
        $fileSizeKB = [math]::Round($fileInfo.Length / 1KB, 2)
        Write-Host "  File size: $fileSizeKB KB" -ForegroundColor White
        Write-Host "  Created: $($fileInfo.LastWriteTime)" -ForegroundColor White
        Write-Host ""
        
        # Show first 5 lines
        Write-Host "Prediction results (first 5 lines):" -ForegroundColor Yellow
        Get-Content "results\predictions_20260221.csv" -TotalCount 5 | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
        Write-Host ""
    } else {
        Write-Host "Warning: Prediction result file not found" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "Prediction for 2026-02-21 failed" -ForegroundColor Red
    Write-Host ""
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Test 2: Prediction for 2026-02-22" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

python scripts\phase6\phase6_daily_prediction.py --target-date 20260222

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Prediction for 2026-02-22 completed successfully" -ForegroundColor Green
    Write-Host ""
    
    # Check result file
    if (Test-Path "results\predictions_20260222.csv") {
        $fileInfo = Get-Item "results\predictions_20260222.csv"
        Write-Host "Prediction result file:" -ForegroundColor Yellow
        Write-Host "  Filename: $($fileInfo.Name)" -ForegroundColor White
        $fileSizeKB = [math]::Round($fileInfo.Length / 1KB, 2)
        Write-Host "  File size: $fileSizeKB KB" -ForegroundColor White
        Write-Host "  Created: $($fileInfo.LastWriteTime)" -ForegroundColor White
        Write-Host ""
        
        # Show first 5 lines
        Write-Host "Prediction results (first 5 lines):" -ForegroundColor Yellow
        Get-Content "results\predictions_20260222.csv" -TotalCount 5 | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
        Write-Host ""
    } else {
        Write-Host "Warning: Prediction result file not found" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "Prediction for 2026-02-22 failed" -ForegroundColor Red
    Write-Host ""
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Test execution completed" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# List generated files
Write-Host "Generated files:" -ForegroundColor Yellow
Write-Host ""

if (Test-Path "results\predictions_*.csv") {
    Get-ChildItem "results\predictions_*.csv" | ForEach-Object {
        $sizeKB = [math]::Round($_.Length / 1KB, 2)
        Write-Host "  Success: $($_.Name) ($sizeKB KB)" -ForegroundColor Green
    }
} else {
    Write-Host "  Warning: No prediction result files found" -ForegroundColor Yellow
}

Write-Host ""

if (Test-Path "logs\phase6_prediction_*.log") {
    Write-Host "Log files:" -ForegroundColor Yellow
    Get-ChildItem "logs\phase6_prediction_*.log" | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | ForEach-Object {
        $sizeKB = [math]::Round($_.Length / 1KB, 2)
        Write-Host "  Success: $($_.Name) ($sizeKB KB)" -ForegroundColor Green
    }
} else {
    Write-Host "  Warning: No log files found" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Phase 6 test completed!" -ForegroundColor Green
Write-Host ""
