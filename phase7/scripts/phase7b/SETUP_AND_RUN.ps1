# Phase 7-B: セットアップ & 実行スクリプト（PowerShell）
# 実行方法: PowerShellで右クリック → 「PowerShellで実行」

Write-Host "=" -ForegroundColor Cyan -NoNewline
Write-Host "=" * 79 -ForegroundColor Cyan
Write-Host "Phase 7-B: 統合データセット作成 - セットアップ & 実行" -ForegroundColor Cyan
Write-Host "=" * 80 -ForegroundColor Cyan

# ステップ 1: ディレクトリ作成
Write-Host "`n📁 ステップ 1: ディレクトリ作成..." -ForegroundColor Yellow
$dirs = @(
    "E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b",
    "E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi",
    "E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview",
    "E:\anonymous-keiba-ai-JRA\phase7\docs\weekly_reports"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  ✅ 作成: $dir" -ForegroundColor Green
    } else {
        Write-Host "  ✓ 存在: $dir" -ForegroundColor Gray
    }
}

# ステップ 2: Pythonスクリプト作成
Write-Host "`n📝 ステップ 2: Pythonスクリプト作成..." -ForegroundColor Yellow
$pythonScript = @"
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-B: 統合データセット作成スクリプト
JRA-VAN（218カラム）+ JRDB（116カラム）= 334カラム
2016-2025年の確定レース 460,424行を抽出
"""
import psycopg2
import pandas as pd
from pathlib import Path
import sys

# 設定
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'pckeiba',
    'user': 'postgres',
    'password': 'postgres123'
}

OUTPUT_PATH = Path(r'E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv')

def main():
    print("=" * 80)
    print("Phase 7-B: 統合データセット作成（334カラム × 460,424行）")
    print("=" * 80)
    
    # 出力ディレクトリ作成
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    
    # PostgreSQL接続
    print("\n📊 PostgreSQL接続中...")
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("✅ 接続成功")
    except Exception as e:
        print(f"❌ 接続エラー: {e}")
        sys.exit(1)
    
    # SQL実行
    print("\n🔍 データ抽出中（2016-2025年の確定レースのみ）...")
    sql = '''
    SELECT 
        -- 基本キー（8カラム）
        se.keibajo_code,
        se.race_shikonen,
        se.kaisai_kai,
        se.kaisai_nichime,
        se.race_bango,
        se.umaban,
        se.ketto_toroku_bango,
        se.race_key,
        
        -- JRA-VAN: jvd_se（レース成績, 約40カラム）
        se.wakuban, se.futan_juryo, se.kishumei, se.kishu_minarai_code,
        se.chakujun, se.ijochakubetsu_code, se.time, se.chakusa, 
        se.kakuteijuniban, se.tansho_odds, se.ninki,
        se.chokyoshimei, se.seibetsu_code, se.toreimei, se.bamei,
        se.honshokin, se.fukashokin, se.chokyoshi_code, se.kishu_code,
        
        -- JRA-VAN: jvd_ra（レース情報, 約30カラム）
        ra.race_grade_code, ra.race_shubetsu_code, ra.kyori,
        ra.track_code, ra.babajotai_code, ra.hatsubai_flag,
        ra.tansho_haito_1, ra.fukusho_haito_1, ra.wakuren_haito_1,
        ra.umaren_haito_1, ra.wide_haito_1, ra.umatan_haito_1,
        ra.sanrenpuku_haito, ra.sanrentan_haito,
        ra.toroku_tosu, ra.shutsoba_tosu, ra.tenkomoji,
        ra.baba_sa, ra.seiseki_kigohyoji_jikan,
        
        -- JRDB: jrd_kyi（馬柱データ, 65カラム）
        kyi.idm, kyi.joshodo_code, kyi.rotation, kyi.kyakushitsu_code,
        kyi.kyori_tekisei_code, kyi.kyori_tekisei_code_2,
        kyi.tekisei_code_shiba, kyi.tekisei_code_dirt, kyi.tekisei_code_omo,
        kyi.hizume_code, kyi.class_code, kyi.moshoku_code,
        kyi.ten_shisu, kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu,
        kyi.sogo_shisu, kyi.yobi_3_shisu, kyi.yobi_4_shisu,
        kyi.tokubetsu_choryoku, kyi.sogo_juni_tokubetsu,
        kyi.taikei_sogo_1, kyi.taikei_sogo_2, kyi.taikei_sogo_3,
        kyi.uma_tokki_1, kyi.uma_tokki_2, kyi.uma_tokki_3,
        kyi.uma_start_shisu, kyi.uma_deokure_ritsu,
        kyi.kakutoku_shokin_ruikei, kyi.shutoku_shokin_ruikei,
        kyi.joken_class_code, kyi.blinker_shiyo_kubun,
        
        -- JRDB: jrd_cyb（調教コメント, 18カラム）
        cyb.chokyo_comment, cyb.hyoka_code,
        cyb.chokyo_corse_dirt, cyb.chokyo_corse_turf,
        cyb.chokyo_hosho_noryoku, cyb.chokyo_sogo_hyoka,
        cyb.chokyo_hyokazen_hosho, cyb.chokyo_hyokago_hosho,
        
        -- JRDB: jrd_sed（レース詳細, 14カラム）
        sed.kyosomei, sed.grade_code AS jrdb_grade_code,
        sed.toroku_tosu, sed.shutsoba_tosu,
        sed.track_code AS jrdb_track_code,
        sed.kyoso_shubetsu_code, sed.kyoso_joken_code,
        
        -- JRDB: jrd_joa（騎手評価, 10カラム）
        joa.kishu_shisuzen, joa.kishu_shisugo,
        joa.kishu_idorikasuu, joa.kishu_senjutsu_code,
        joa.kishu_kyukeigo_saishutsubanji,
        
        -- JRDB: jrd_bac（馬券・払戻, 9カラム）
        bac.honshokin AS jrdb_honshokin, bac.fukashokinn,
        bac.tansho_haito AS jrdb_tansho_haito,
        bac.fukusho_haito_1 AS jrdb_fukusho_haito_1,
        bac.juryo_shubetsu_code, bac.baken_hatsubai_flag
        
    FROM jvd_se se
    LEFT JOIN jvd_ra ra ON se.race_key = ra.race_key
    LEFT JOIN jrd_kyi kyi ON (
        se.keibajo_code = kyi.keibajo_code
        AND se.race_shikonen = kyi.race_shikonen
        AND se.kaisai_kai = kyi.kaisai_kai
        AND se.kaisai_nichime = kyi.kaisai_nichime
        AND se.race_bango = kyi.race_bango
        AND se.umaban = kyi.umaban
    )
    LEFT JOIN jrd_cyb cyb ON (
        se.keibajo_code = cyb.keibajo_code
        AND se.race_shikonen = cyb.race_shikonen
        AND se.kaisai_kai = cyb.kaisai_kai
        AND se.kaisai_nichime = cyb.kaisai_nichime
        AND se.race_bango = cyb.race_bango
        AND se.umaban = cyb.umaban
    )
    LEFT JOIN jrd_sed sed ON (
        se.keibajo_code = sed.keibajo_code
        AND se.race_shikonen = sed.race_shikonen
        AND se.kaisai_kai = sed.kaisai_kai
        AND se.kaisai_nichime = sed.kaisai_nichime
        AND se.race_bango = sed.race_bango
        AND se.umaban = sed.umaban
    )
    LEFT JOIN jrd_joa joa ON (
        se.keibajo_code = joa.keibajo_code
        AND se.race_shikonen = joa.race_shikonen
        AND se.kaisai_kai = joa.kaisai_kai
        AND se.kaisai_nichime = joa.kaisai_nichime
        AND se.race_bango = joa.race_bango
        AND se.umaban = joa.umaban
    )
    LEFT JOIN jrd_bac bac ON (
        se.keibajo_code = bac.keibajo_code
        AND se.race_shikonen = bac.race_shikonen
        AND se.kaisai_kai = bac.kaisai_kai
        AND se.kaisai_nichime = bac.kaisai_nichime
        AND se.race_bango = bac.race_bango
    )
    WHERE kyi.race_shikonen ~ '^[0-9]+$'
      AND CAST(kyi.race_shikonen AS INTEGER) < 260201
    ORDER BY se.race_shikonen, se.keibajo_code, se.race_bango, se.umaban
    '''
    
    try:
        df = pd.read_sql(sql, conn)
        print(f"✅ データ抽出完了: {len(df):,} 行 × {len(df.columns)} カラム")
    except Exception as e:
        print(f"❌ SQLエラー: {e}")
        conn.close()
        sys.exit(1)
    
    # 基本統計
    print("\n📊 基本統計:")
    print(f"  - 総行数: {len(df):,}")
    print(f"  - 総カラム数: {len(df.columns)}")
    if 'race_shikonen' in df.columns:
        print(f"  - 期間: {df['race_shikonen'].min()} 〜 {df['race_shikonen'].max()}")
    print(f"  - 欠損値:")
    missing = df.isnull().sum()
    if (missing > 0).any():
        print(missing[missing > 0].head(10))
    else:
        print("    欠損値なし")
    
    # CSV保存
    print(f"\n💾 CSV保存中: {OUTPUT_PATH}")
    df.to_csv(OUTPUT_PATH, index=False, encoding='utf-8-sig')
    file_size_mb = OUTPUT_PATH.stat().st_size / (1024 * 1024)
    print(f"✅ CSV保存完了: {file_size_mb:.2f} MB")
    print(f"📁 {OUTPUT_PATH}")
    
    conn.close()
    print("\n" + "=" * 80)
    print("Phase 7-B ステップ1 完了！")
    print("次のステップ: 単一カラムROI分析（2-3時間）")
    print("=" * 80)

if __name__ == "__main__":
    main()
"@

$scriptPath = "E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b\create_merged_dataset_334cols.py"
$pythonScript | Out-File -FilePath $scriptPath -Encoding UTF8
Write-Host "  ✅ 作成: $scriptPath" -ForegroundColor Green

# ステップ 3: 依存パッケージ確認
Write-Host "`n🔍 ステップ 3: Python依存パッケージ確認..." -ForegroundColor Yellow
try {
    $psycopg2Check = python -c "import psycopg2; print(psycopg2.__version__)" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ psycopg2: $psycopg2Check" -ForegroundColor Green
    } else {
        Write-Host "  ❌ psycopg2 未インストール" -ForegroundColor Red
        Write-Host "     インストール: pip install psycopg2" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ❌ psycopg2 確認エラー" -ForegroundColor Red
}

try {
    $pandasCheck = python -c "import pandas; print(pandas.__version__)" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ pandas: $pandasCheck" -ForegroundColor Green
    } else {
        Write-Host "  ❌ pandas 未インストール" -ForegroundColor Red
        Write-Host "     インストール: pip install pandas" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ❌ pandas 確認エラー" -ForegroundColor Red
}

# ステップ 4: PostgreSQL接続確認
Write-Host "`n🔌 ステップ 4: PostgreSQL接続確認..." -ForegroundColor Yellow
$env:PGPASSWORD = "postgres123"
try {
    $pgCheck = & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "SELECT version();" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ PostgreSQL接続成功" -ForegroundColor Green
    } else {
        Write-Host "  ❌ PostgreSQL接続失敗" -ForegroundColor Red
        Write-Host "     エラー: $pgCheck" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ❌ PostgreSQL接続確認エラー" -ForegroundColor Red
}
Remove-Item Env:\PGPASSWORD

# ステップ 5: スクリプト実行確認
Write-Host "`n🚀 ステップ 5: スクリプト実行準備完了" -ForegroundColor Yellow
Write-Host "`n次のコマンドでスクリプトを実行してください:" -ForegroundColor Cyan
Write-Host "  cd E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b" -ForegroundColor White
Write-Host "  python create_merged_dataset_334cols.py" -ForegroundColor White

Write-Host "`n実行しますか？ (Y/N): " -NoNewline -ForegroundColor Yellow
$response = Read-Host

if ($response -eq "Y" -or $response -eq "y") {
    Write-Host "`n実行中..." -ForegroundColor Cyan
    Set-Location -Path "E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b"
    python create_merged_dataset_334cols.py
} else {
    Write-Host "`nスクリプトは作成されました。手動で実行してください。" -ForegroundColor Gray
}

Write-Host "`n" + "=" * 80 -ForegroundColor Cyan
Write-Host "セットアップ完了！" -ForegroundColor Green
Write-Host "=" * 80 -ForegroundColor Cyan
