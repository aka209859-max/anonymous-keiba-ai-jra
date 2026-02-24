# JRDB Complete Cleanup and Reimport Script
# Purpose: Delete old JRDB tables, fix DataSettings.xml, and prepare for PC-KEIBA reimport

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "JRDB Complete Cleanup & Re-setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 0: Get PostgreSQL password
$password = Read-Host "PostgreSQL password (postgres user)" 
$env:PGPASSWORD = $password

Write-Host ""
Write-Host "[Step 1/4] Deleting existing JRDB tables" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray

# List of JRDB tables to drop
$tablesToDrop = @(
    "jrd_kyi", "jrd_cyb", "jrd_joa", "jrd_sed",
    "jrd_bac", "jrd_cha", "jrd_cza", "jrd_hjc",
    "jrd_kab", "jrd_kka", "jrd_kta", "jrd_kza",
    "jrd_mza", "jrd_ot", "jrd_ou", "jrd_ov",
    "jrd_ow", "jrd_oz", "jrd_skb", "jrd_srb",
    "jrd_tyb", "jrd_ukc"
)

$psqlPath = "C:\Program Files\PostgreSQL\16\bin\psql.exe"

foreach ($table in $tablesToDrop) {
    Write-Host "Deleting: $table" -ForegroundColor Gray -NoNewline
    $dropCmd = "DROP TABLE IF EXISTS $table CASCADE;"
    $result = & $psqlPath -U postgres -d pckeiba -c $dropCmd 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " (skipped)" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "[Step 2/4] Verifying table deletion" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
$verifyCmd = "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname='public' AND tablename LIKE 'jrd_%' ORDER BY tablename;"
& $psqlPath -U postgres -d pckeiba -c $verifyCmd

Write-Host ""
Write-Host "[Step 3/4] Fixing DataSettings.xml" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray

$xmlFile = "E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml"

if (Test-Path $xmlFile) {
    # Create backup
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFile = "$xmlFile.backup_$timestamp"
    Copy-Item $xmlFile $backupFile -Force
    Write-Host "Backup created: $backupFile" -ForegroundColor Green
    
    # Read file content
    $content = Get-Content $xmlFile -Raw -Encoding UTF8
    
    # Count occurrences before replacement
    $pattern = '<column name="race_shikonen" length="2"'
    $beforeCount = ([regex]::Matches($content, $pattern)).Count
    Write-Host "Found: race_shikonen length=`"2`" at $beforeCount locations" -ForegroundColor Yellow
    
    # Replace
    $newContent = $content -replace '<column name="race_shikonen" length="2"', '<column name="race_shikonen" length="10"'
    
    # Save
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($xmlFile, $newContent, $utf8NoBom)
    
    Write-Host "Replacement complete: length=`"2`" -> length=`"10`" ($beforeCount locations)" -ForegroundColor Green
    
    # Verify
    Write-Host ""
    Write-Host "Verification (first 3 occurrences):" -ForegroundColor Cyan
    Select-String -Path $xmlFile -Pattern '<column name="race_shikonen"' | Select-Object -First 3 | ForEach-Object {
        Write-Host "  $($_.Line.Trim())" -ForegroundColor White
    }
} else {
    Write-Host "File not found: $xmlFile" -ForegroundColor Red
}

Write-Host ""
Write-Host "[Step 4/4] PC-KEIBA Re-registration" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "Please follow these steps:" -ForegroundColor White
Write-Host ""
Write-Host "1. Launch PC-KEIBA" -ForegroundColor White
Write-Host "2. Menu -> Data(D) -> External Data Registration" -ForegroundColor White
Write-Host "3. Configuration file: $xmlFile" -ForegroundColor Cyan
Write-Host "4. Data folder: E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\" -ForegroundColor Cyan
Write-Host "5. Click Start button" -ForegroundColor White
Write-Host ""
Write-Host "Expected registration log:" -ForegroundColor Yellow
Write-Host "  - BAC260221.lzh -> BAC260221.txt extract -> XX records" -ForegroundColor Gray
Write-Host "  - KYI260221.lzh -> KYI260221.txt extract -> 530 records" -ForegroundColor Gray
Write-Host "  - CYB260221.lzh -> CYB260221.txt extract -> 530 records" -ForegroundColor Gray
Write-Host "  - JOA260221.lzh -> JOA260221.txt extract -> 530 records" -ForegroundColor Gray
Write-Host "  - SED260221.lzh -> SED260221.txt extract -> 530 records" -ForegroundColor Gray
Write-Host "  (Same for 260222 files)" -ForegroundColor Gray
Write-Host ""

# Clear password
Remove-Item Env:\PGPASSWORD
Write-Host "Environment variable cleared" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Ready! Please execute PC-KEIBA re-registration" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Verification commands after re-registration:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Copy and paste these commands:" -ForegroundColor White
Write-Host ""
Write-Host '$env:PGPASSWORD = "postgres123"' -ForegroundColor Cyan
Write-Host ""
Write-Host '& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT ''jrd_kyi'' AS table_name, COUNT(*) FROM jrd_kyi UNION ALL SELECT ''jrd_cyb'', COUNT(*) FROM jrd_cyb UNION ALL SELECT ''jrd_joa'', COUNT(*) FROM jrd_joa UNION ALL SELECT ''jrd_sed'', COUNT(*) FROM jrd_sed UNION ALL SELECT ''jrd_bac'', COUNT(*) FROM jrd_bac ORDER BY table_name;"' -ForegroundColor Cyan
Write-Host ""
Write-Host '& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT race_shikonen, LENGTH(race_shikonen) AS len, keibajo_code, race_bango FROM jrd_kyi ORDER BY race_shikonen DESC LIMIT 5;"' -ForegroundColor Cyan
Write-Host ""
Write-Host 'Remove-Item Env:\PGPASSWORD' -ForegroundColor Cyan
Write-Host ""
