# JRA全競馬場データ生成スクリプト（小倉除く）
# 作成日: 2026-02-21
# 対象: 01-09（札幌～阪神）

$ErrorActionPreference = "Continue"
$startTime = Get-Date

Write-Host "=================================" -ForegroundColor Green
Write-Host "JRA全競馬場データ生成開始" -ForegroundColor Green
Write-Host "開始時刻: $startTime" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# 競馬場リスト（小倉除く）
$tracks = @(
    @{code="01"; name="札幌"; expected_rows=20063},
    @{code="02"; name="函館"; expected_rows=17864},
    @{code="03"; name="福島"; expected_rows=33295},
    @{code="04"; name="新潟"; expected_rows=46666},
    @{code="05"; name="東京"; expected_rows=77473},
    @{code="06"; name="中山"; expected_rows=73085},
    @{code="07"; name="中京"; expected_rows=52367},
    @{code="08"; name="京都"; expected_rows=55680},
    @{code="09"; name="阪神"; expected_rows=68290}
)

$results = @()

foreach ($track in $tracks) {
    $trackStart = Get-Date
    Write-Host "`n" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host "[$($track.name) ($($track.code))] 処理開始" -ForegroundColor Cyan
    Write-Host "開始時刻: $trackStart" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    
    try {
        # スクリプト実行
        python scripts\phase1\extract_jra_features_v1.py `
            --keibajo $($track.code) `
            --start-year 2016 `
            --end-year 2025 `
            --output-dir data\features `
            --db-config config\db_config.yaml
        
        $trackEnd = Get-Date
        $duration = $trackEnd - $trackStart
        
        # ファイル確認
        $csvFile = "data\features\$($track.code)_2016-2025_features.csv"
        if (Test-Path $csvFile) {
            $fileSize = (Get-Item $csvFile).Length / 1MB
            
            # 行数確認
            $rowCount = (python -c "import pandas as pd; df = pd.read_csv('$csvFile', low_memory=False); print(len(df))")
            
            Write-Host "`n✅ [$($track.name)] 完了" -ForegroundColor Green
            Write-Host "  処理時間: $($duration.TotalMinutes.ToString('0.0'))分" -ForegroundColor Green
            Write-Host "  ファイルサイズ: $($fileSize.ToString('0.0')) MB" -ForegroundColor Green
            Write-Host "  行数: $rowCount 行（期待値: $($track.expected_rows)）" -ForegroundColor Green
            
            $results += [PSCustomObject]@{
                競馬場 = $track.name
                コード = $track.code
                状態 = "✅ 成功"
                行数 = $rowCount
                期待行数 = $track.expected_rows
                ファイルサイズMB = [math]::Round($fileSize, 1)
                処理時間分 = [math]::Round($duration.TotalMinutes, 1)
            }
        } else {
            Write-Host "`n❌ [$($track.name)] ファイル生成失敗" -ForegroundColor Red
            $results += [PSCustomObject]@{
                競馬場 = $track.name
                コード = $track.code
                状態 = "❌ 失敗"
                行数 = 0
                期待行数 = $track.expected_rows
                ファイルサイズMB = 0
                処理時間分 = [math]::Round($duration.TotalMinutes, 1)
            }
        }
        
    } catch {
        $trackEnd = Get-Date
        $duration = $trackEnd - $trackStart
        
        Write-Host "`n❌ [$($track.name)] エラー発生" -ForegroundColor Red
        Write-Host "エラー: $_" -ForegroundColor Red
        
        $results += [PSCustomObject]@{
            競馬場 = $track.name
            コード = $track.code
            状態 = "❌ エラー"
            行数 = 0
            期待行数 = $track.expected_rows
            ファイルサイズMB = 0
            処理時間分 = [math]::Round($duration.TotalMinutes, 1)
        }
    }
}

$endTime = Get-Date
$totalDuration = $endTime - $startTime

Write-Host "`n" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host "全競馬場処理完了" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host "開始時刻: $startTime" -ForegroundColor Green
Write-Host "終了時刻: $endTime" -ForegroundColor Green
Write-Host "合計処理時間: $($totalDuration.TotalHours.ToString('0.0'))時間（$($totalDuration.TotalMinutes.ToString('0.0'))分）" -ForegroundColor Green

Write-Host "`n[処理結果サマリー]" -ForegroundColor Cyan
$results | Format-Table -AutoSize

# 結果をCSVに保存
$results | Export-Csv -Path "data\features\processing_summary.csv" -NoTypeInformation -Encoding UTF8
Write-Host "`n処理結果を保存: data\features\processing_summary.csv" -ForegroundColor Yellow

# 成功・失敗の集計
$successCount = ($results | Where-Object { $_.状態 -eq "✅ 成功" }).Count
$failCount = ($results | Where-Object { $_.状態 -ne "✅ 成功" }).Count

Write-Host "`n[最終結果]" -ForegroundColor Cyan
Write-Host "  成功: $successCount / $($tracks.Count) 競馬場" -ForegroundColor Green
Write-Host "  失敗: $failCount / $($tracks.Count) 競馬場" -ForegroundColor Red

if ($failCount -eq 0) {
    Write-Host "`n🎉 全競馬場のデータ生成に成功しました！" -ForegroundColor Green
} else {
    Write-Host "`n⚠️ 一部の競馬場でエラーが発生しました。ログを確認してください。" -ForegroundColor Yellow
}

Write-Host "`nログファイル: logs\extract_features_*.log" -ForegroundColor Yellow
