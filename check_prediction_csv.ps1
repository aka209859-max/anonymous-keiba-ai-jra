# Phase 6 予測結果 CSV の診断スクリプト

Write-Host "`n=== Phase 6 予測結果の診断 ===" -ForegroundColor Cyan

$csvPath = "E:\anonymous-keiba-ai-JRA\results\predictions_20260222.csv"

if (Test-Path $csvPath) {
    Write-Host "`n✓ CSV ファイルが存在します: $csvPath" -ForegroundColor Green
    
    # CSV を読み込み
    $data = Import-Csv -Path $csvPath -Encoding UTF8
    
    Write-Host "`n--- カラム一覧 ---" -ForegroundColor Yellow
    $data[0].PSObject.Properties.Name | ForEach-Object { Write-Host "  - $_" }
    
    Write-Host "`n--- 最初の3行のサンプル ---" -ForegroundColor Yellow
    $data | Select-Object -First 3 | Format-Table -AutoSize
    
    Write-Host "`n--- bamei カラムの状態 ---" -ForegroundColor Yellow
    if ($data[0].PSObject.Properties.Name -contains "bamei") {
        $bameiSample = $data | Select-Object -First 10 | Select-Object umaban, bamei, ensemble_score
        $bameiSample | Format-Table -AutoSize
        
        # bamei が数字かどうか確認
        $numericBamei = $data | Where-Object { $_.bamei -match '^\d+$' } | Measure-Object
        Write-Host "  数字のみの bamei: $($numericBamei.Count) / $($data.Count) 件" -ForegroundColor $(if ($numericBamei.Count -gt 0) { "Red" } else { "Green" })
    } else {
        Write-Host "  ❌ bamei カラムが存在しません！" -ForegroundColor Red
    }
    
    Write-Host "`n--- ensemble_score の分布 ---" -ForegroundColor Yellow
    $scores = $data | Select-Object -ExpandProperty ensemble_score | Where-Object { $_ -ne $null }
    $scoreStats = $scores | Measure-Object -Average -Maximum -Minimum
    Write-Host "  最小値: $([math]::Round($scoreStats.Minimum, 3))"
    Write-Host "  最大値: $([math]::Round($scoreStats.Maximum, 3))"
    Write-Host "  平均値: $([math]::Round($scoreStats.Average, 3))"
    
    # スコア 1.00 の件数
    $score100 = $data | Where-Object { [double]$_.ensemble_score -eq 1.0 } | Measure-Object
    Write-Host "  スコア 1.00 の件数: $($score100.Count) / $($data.Count) ($(([math]::Round(($score100.Count / $data.Count) * 100, 1)))%)" `
        -ForegroundColor $(if (($score100.Count / $data.Count) -gt 0.3) { "Red" } else { "Green" })
    
} else {
    Write-Host "`n❌ CSV ファイルが見つかりません: $csvPath" -ForegroundColor Red
}

Write-Host "`n=== 診断完了 ===" -ForegroundColor Cyan
