# ローカル変更を一時退避してGitHubの最新版を取得

Write-Host "=== ステップ1: ローカル変更を退避 ===" -ForegroundColor Cyan
git stash push -m "Backup before pulling fixed script (2026-02-27)"

Write-Host "`n=== ステップ2: 最新版を取得 ===" -ForegroundColor Cyan
git pull origin genspark_ai_developer

Write-Host "`n=== ステップ3: 修正確認 ===" -ForegroundColor Cyan
Write-Host "行116付近（preprocess_data関数）:" -ForegroundColor Yellow
Get-Content scripts\phase3\train_binary_model.py | Select-Object -Skip 113 -First 5

Write-Host "`n行264付近（prepare_features関数）:" -ForegroundColor Yellow
Get-Content scripts\phase3\train_binary_model.py | Select-Object -Skip 261 -First 5

Write-Host "`n=== 完了！ ===" -ForegroundColor Green
Write-Host "次のコマンドで再訓練を開始してください:" -ForegroundColor Green
Write-Host '$env:PYTHONIOENCODING="utf-8"' -ForegroundColor White
Write-Host 'python scripts\phase3\train_binary_model.py' -ForegroundColor White
