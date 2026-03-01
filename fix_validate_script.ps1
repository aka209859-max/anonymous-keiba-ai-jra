# PowerShell script to fix validate_hensachi_odds_matrix.py locally

$file = "E:\anonymous-keiba-ai-JRA\scripts\validation\validate_hensachi_odds_matrix.py"

# Read file
$content = Get-Content $file -Encoding UTF8 -Raw

# Fix: return config.get('jravan', {})
$content = $content -replace "return config\s*$", "return config.get('jravan', {})"

# Write back
$content | Set-Content $file -Encoding UTF8 -NoNewline

Write-Host "✅ Fixed: return config.get('jravan', {})" -ForegroundColor Green
Write-Host ""
Write-Host "Now run:" -ForegroundColor Yellow
Write-Host "python scripts\validation\validate_hensachi_odds_matrix.py --year 2025 --month 1 --predictions-dir results\validation\predictions_2025\csv --output results\validation\hensachi_odds_matrix" -ForegroundColor Cyan
