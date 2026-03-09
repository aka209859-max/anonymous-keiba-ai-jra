# JRA競馬AI Phase6 予測実行スクリプト
# 使用方法: .\run_prediction.ps1 -Date 20260301

param(
    [Parameter(Mandatory=$false)]
    [string]$Date = "20260301"
)

$ErrorActionPreference = "Continue"
$ProjectRoot = "E:\anonymous-keiba-ai-JRA"
$JrdbDir = "$ProjectRoot\data\jrdb\raw\JRDB_weekly"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "JRA競馬AI Phase6 予測実行" -ForegroundColor Cyan
Write-Host "対象日: $Date" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# プロジェクトルートへ移動
cd $ProjectRoot

# ステップ1: .lzhファイルの解凍
Write-Host "[ステップ1] .lzhファイルを解凍中..." -ForegroundColor Yellow
cd $JrdbDir

$lzhFiles = Get-ChildItem -Filter "*.lzh" -ErrorAction SilentlyContinue
if ($lzhFiles.Count -eq 0) {
    Write-Host "⚠️ .lzhファイルが見つかりません" -ForegroundColor Red
    Write-Host "JRDB公式サイトから以下のファイルをダウンロードして、" -ForegroundColor Yellow
    Write-Host "このフォルダに保存してください: $JrdbDir" -ForegroundColor Yellow
    Write-Host "  - KYI$Date.lzh" -ForegroundColor Yellow
    Write-Host "  - BAC$Date.lzh" -ForegroundColor Yellow
    Write-Host "  - JOA$Date.lzh" -ForegroundColor Yellow
    Write-Host "  - SED$Date.lzh (翌日提供)" -ForegroundColor Yellow
    Write-Host "  - KAB$Date.lzh" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "見つかった.lzhファイル: $($lzhFiles.Count)個" -ForegroundColor Green
foreach ($file in $lzhFiles) {
    Write-Host "  - $($file.Name)" -ForegroundColor Gray
}

# 7-Zipで解凍
$7zipPath = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path $7zipPath)) {
    Write-Host "⚠️ 7-Zipが見つかりません: $7zipPath" -ForegroundColor Red
    Write-Host "7-Zipをインストールしてください" -ForegroundColor Yellow
    pause
    exit 1
}

foreach ($file in $lzhFiles) {
    Write-Host "  解凍中: $($file.Name)..." -ForegroundColor Gray
    & $7zipPath e $file.FullName -o"$JrdbDir" -y | Out-Null
}

# 解凍されたtxtファイルを確認
$txtFiles = Get-ChildItem -Filter "*.txt" -ErrorAction SilentlyContinue
Write-Host "✅ 解凍完了: $($txtFiles.Count)個のtxtファイル" -ForegroundColor Green

if ($txtFiles.Count -eq 0) {
    Write-Host "⚠️ txtファイルが見つかりません" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""

# ステップ2: PostgreSQLへインポート
Write-Host "[ステップ2] PostgreSQLへインポート中..." -ForegroundColor Yellow
cd $ProjectRoot

python scripts\import_jrdb_official.py "$JrdbDir"
$importExitCode = $LASTEXITCODE

if ($importExitCode -ne 0) {
    Write-Host "⚠️ インポート中にエラーが発生しました (終了コード: $importExitCode)" -ForegroundColor Red
} else {
    Write-Host "✅ インポート完了" -ForegroundColor Green
}

Write-Host ""

# ステップ3: データベース確認
Write-Host "[ステップ3] データベースを確認中..." -ForegroundColor Yellow

$env:PGPASSWORD = "postgres123"
$psqlPath = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

if (-not (Test-Path $psqlPath)) {
    Write-Host "⚠️ psql.exeが見つかりません: $psqlPath" -ForegroundColor Red
    Write-Host "PostgreSQL 16がインストールされているか確認してください" -ForegroundColor Yellow
    $psqlPath = "psql"  # パスが通っている場合
}

# 日付フォーマット変換 (20260301 -> 260301)
$shortDate = $Date.Substring(2)

# jrd_kyiテーブルのデータ確認
$kyiQuery = "SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '$shortDate%';"
Write-Host "  SQLクエリ: $kyiQuery" -ForegroundColor Gray

try {
    $kyiCount = & $psqlPath -h 127.0.0.1 -p 5432 -U postgres -d pckeiba -t -c $kyiQuery 2>&1 | Select-String -Pattern "\d+" | ForEach-Object { $_.Matches.Value }
    
    if ($kyiCount -and $kyiCount -gt 0) {
        Write-Host "✅ jrd_kyiテーブル: $kyiCount 件のデータ" -ForegroundColor Green
    } else {
        Write-Host "⚠️ jrd_kyiにデータが見つかりません" -ForegroundColor Yellow
        Write-Host "  → これは正常な場合もあります（当日データがまだ提供されていない等）" -ForegroundColor Gray
        Write-Host "  → Phase6は前回のデータを使用して予測を実行します" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠️ データベース確認中にエラーが発生しました" -ForegroundColor Yellow
    Write-Host "  エラー: $_" -ForegroundColor Gray
}

Write-Host ""

# ステップ4: Phase6予測実行
Write-Host "[ステップ4] Phase6予測を実行中..." -ForegroundColor Yellow

python scripts\phase6\phase6_daily_prediction.py --target-date $Date
$predictionExitCode = $LASTEXITCODE

if ($predictionExitCode -ne 0) {
    Write-Host "⚠️ 予測実行中にエラーが発生しました (終了コード: $predictionExitCode)" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""

# ステップ5: 結果確認
Write-Host "[ステップ5] 結果を確認中..." -ForegroundColor Yellow

$resultCsv = "$ProjectRoot\results\predictions_$Date.csv"
$postDir = "$ProjectRoot\results\投稿用"

if (Test-Path $resultCsv) {
    $csvSize = (Get-Item $resultCsv).Length / 1KB
    Write-Host "✅ 予測CSV生成完了: predictions_$Date.csv ($([math]::Round($csvSize, 1)) KB)" -ForegroundColor Green
    
    # CSVの行数をカウント
    $rowCount = (Get-Content $resultCsv).Count - 1  # ヘッダー行を除く
    Write-Host "   レース数: $rowCount 行" -ForegroundColor Gray
} else {
    Write-Host "⚠️ 予測CSVが見つかりません: $resultCsv" -ForegroundColor Red
}

# 投稿用ファイルの確認
if (Test-Path $postDir) {
    $postFiles = Get-ChildItem -Path $postDir -Filter "*$Date*" -ErrorAction SilentlyContinue
    if ($postFiles.Count -gt 0) {
        Write-Host "✅ 投稿用ファイル生成完了: $($postFiles.Count)個" -ForegroundColor Green
        foreach ($file in $postFiles) {
            Write-Host "   - $($file.Name)" -ForegroundColor Gray
        }
    }
} else {
    Write-Host "ℹ️ 投稿用フォルダが存在しません: $postDir" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ 予測実行完了！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "結果ファイル:" -ForegroundColor Yellow
Write-Host "  - CSV: $resultCsv" -ForegroundColor Gray
if (Test-Path $postDir) {
    Write-Host "  - 投稿用: $postDir" -ForegroundColor Gray
}
Write-Host ""

# Excelで開くか確認
$openExcel = Read-Host "Excelで結果を開きますか？ (Y/N)"
if ($openExcel -match '^[Yy]') {
    if (Test-Path $resultCsv) {
        Start-Process $resultCsv
    }
}

Write-Host ""
Write-Host "処理を完了しました。何かキーを押して終了..." -ForegroundColor Gray
pause
