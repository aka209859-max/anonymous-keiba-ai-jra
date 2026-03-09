# ===============================================================================
# Phase 2C専用モデル訓練スクリプト
# ===============================================================================
# 
# 目的: 2016-2024年データで訓練したモデルを専用ファイル名で保存
#       Phase 2C分析（2025年検証）用
#
# 生成ファイル:
#   - models/jra_binary_model_2016_2024.txt
#   - models/jra_ranking_model_2016_2024.txt  
#   - models/jra_regression_model_2016_2024.txt
#
# 実行方法:
#   cd E:\anonymous-keiba-ai-JRA
#   .\train_phase2c_models.ps1
#
# 所要時間: 約2-4時間
# ===============================================================================

Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host "Phase 2C専用モデル訓練開始 (2016-2024年データ)" -ForegroundColor Cyan
Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "Stop"
$StartTime = Get-Date

# ===============================================================================
# Step 1: 二値分類モデル訓練
# ===============================================================================

Write-Host "[Step 1/3] 二値分類モデル訓練中..." -ForegroundColor Yellow
Write-Host "推定時間: 30-60分" -ForegroundColor Gray
Write-Host ""

try {
    python scripts/phase3/train_binary_model.py
    
    # 評価用モデルをPhase 2C専用名にコピー
    if (Test-Path "models/jra_binary_model_eval.txt") {
        Copy-Item "models/jra_binary_model_eval.txt" "models/jra_binary_model_2016_2024.txt" -Force
        Write-Host "✅ 二値分類モデル完成: models/jra_binary_model_2016_2024.txt" -ForegroundColor Green
    } else {
        throw "評価用モデルが見つかりません"
    }
} catch {
    Write-Host "❌ 二値分類モデル訓練失敗: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ===============================================================================
# Step 2: ランキングモデル訓練
# ===============================================================================

Write-Host "[Step 2/3] ランキングモデル訓練中..." -ForegroundColor Yellow
Write-Host "推定時間: 30-60分" -ForegroundColor Gray
Write-Host ""

try {
    python scripts/phase4/train_ranking_model.py
    
    # 評価用モデルをPhase 2C専用名にコピー
    if (Test-Path "models/jra_ranking_model_eval.txt") {
        Copy-Item "models/jra_ranking_model_eval.txt" "models/jra_ranking_model_2016_2024.txt" -Force
        Write-Host "✅ ランキングモデル完成: models/jra_ranking_model_2016_2024.txt" -ForegroundColor Green
    } else {
        throw "評価用モデルが見つかりません"
    }
} catch {
    Write-Host "❌ ランキングモデル訓練失敗: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ===============================================================================
# Step 3: 回帰モデル訓練
# ===============================================================================

Write-Host "[Step 3/3] 回帰モデル訓練中..." -ForegroundColor Yellow
Write-Host "推定時間: 60-120分" -ForegroundColor Gray
Write-Host ""

try {
    python scripts/phase4/train_regression_model_optimized.py
    
    # 評価用モデルをPhase 2C専用名にコピー
    if (Test-Path "models/jra_regression_model_eval.txt") {
        Copy-Item "models/jra_regression_model_eval.txt" "models/jra_regression_model_2016_2024.txt" -Force
        Write-Host "✅ 回帰モデル完成: models/jra_regression_model_2016_2024.txt" -ForegroundColor Green
    } else {
        throw "評価用モデルが見つかりません"
    }
} catch {
    Write-Host "❌ 回帰モデル訓練失敗: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ===============================================================================
# 完了サマリー
# ===============================================================================

$EndTime = Get-Date
$Duration = $EndTime - $StartTime

Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host "✅ Phase 2C専用モデル訓練完了！" -ForegroundColor Green
Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "所要時間: $($Duration.Hours)時間 $($Duration.Minutes)分 $($Duration.Seconds)秒" -ForegroundColor White
Write-Host ""
Write-Host "生成されたモデル:" -ForegroundColor Yellow
Get-ChildItem models\*_2016_2024.txt | Format-Table Name, @{Name="Size(MB)";Expression={[math]::Round($_.Length/1MB, 2)}}, LastWriteTime -AutoSize
Write-Host ""
Write-Host "次のステップ:" -ForegroundColor Yellow
Write-Host "  1. Phase 6予測スクリプトを修正してPhase 2C専用モデルを使用" -ForegroundColor White
Write-Host "  2. 2025年予測を再実行: python batch_predict_2025_organized_phase2c.py" -ForegroundColor White
Write-Host "  3. Phase 2C分析を実行: python scripts\validation\validate_hensachi_odds_matrix.py" -ForegroundColor White
Write-Host ""
