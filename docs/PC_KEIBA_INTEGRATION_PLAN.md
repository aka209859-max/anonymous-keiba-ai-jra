# PC-KEIBA活用ルート実装計画書（シンプル版）

## 📋 実装概要

- **目的**：race_shikonenキー不一致問題をPC-KEIBA公式推奨の方法で恒久解決
- **方針**：`myd_key_map`マッピングテーブルを使用した結合方式に移行
- **工数見積もり**：20-30時間（3-5日）
- **参照元**：deep-research-report (4).md、PC-KEIBAマニュアル推奨方式

---

## 🔍 現状の問題

### 問題1：race_shikonenフォーマット不一致
- **JRA-VAN**: `kaisai_nen` + `kaisai_tsukihi` + `keibajo_code` + `race_bango` → 複数列で構成
- **JRDB**: `race_shikonen` 単一列
  - **6桁形式**: `260228` (YY + MMDD)
  - **10桁形式**: `2602281101` (YY + MMDD + 場コード + レース番号)

### 問題2：LIKE検索の限界
現在のPhase 6実装：
```sql
WHERE kyi.race_shikonen LIKE '260228%'
```
- ✅ 10桁形式には対応
- ❌ 6桁形式には非対応（完全一致が必要）
- ❌ 複数競馬場が混在する日に対応困難
- ❌ キー構造の違いを根本解決できていない

---

## ✅ 解決策：myd_key_map方式

### PC-KEIBA公式推奨の設計思想

PC-KEIBAマニュアルより引用：
> JRA-VANとJRDB（および競馬道OnLine）では競馬場コードや「レース施行年」「開催回」「開催日目」の桁数が異なるため、そのままでは結合できず、**マッピング用テーブルを作るのが簡単**です。

> 過去分はプロシージャで一括変換し、最新分は週1回同プロシージャを実行する運用が可能です。

### 結合フロー
```
JRA-VANテーブル (jvd_ra)
    ↓ (kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango)
myd_key_map（マッピングテーブル）
    ↓ (jrdb_race_shikonen, jrdb_kaisai_kai, jrdb_kaisai_nichime)
JRDBテーブル (jrd_kyi, jrd_cyb, jrd_joa)
```

---

## 📝 実装ステップ

### Step 1: myd_key_mapテーブル作成（2-3時間）

#### 1.1 テーブル定義
```sql
-- E:\anonymous-keiba-ai-JRA\sql\create_myd_key_map.sql
CREATE TABLE IF NOT EXISTS myd_key_map (
    -- 正規化キー（12桁：yyyymmddjjrr）
    normalized_key CHAR(12) PRIMARY KEY,
    
    -- JRA-VAN側キー
    jravan_kaisai_nen CHAR(4) NOT NULL,
    jravan_kaisai_tsukihi CHAR(4) NOT NULL,
    jravan_keibajo_code CHAR(2) NOT NULL,
    jravan_kaisai_kai CHAR(2) NOT NULL,
    jravan_kaisai_nichime CHAR(2) NOT NULL,
    jravan_race_bango CHAR(2) NOT NULL,
    
    -- JRDB側キー
    jrdb_race_shikonen TEXT,           -- 6桁 or 10桁
    jrdb_keibajo_code CHAR(2),
    jrdb_kaisai_kai CHAR(1),           -- JRDBは1桁
    jrdb_kaisai_nichime CHAR(1),       -- JRDBは1桁
    jrdb_race_bango CHAR(2),
    
    -- メタ情報
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- インデックス作成
CREATE INDEX IF NOT EXISTS idx_keymap_jravan 
    ON myd_key_map(jravan_kaisai_nen, jravan_kaisai_tsukihi, jravan_keibajo_code, jravan_race_bango);

CREATE INDEX IF NOT EXISTS idx_keymap_jrdb 
    ON myd_key_map(jrdb_race_shikonen, jrdb_keibajo_code, jrdb_kaisai_kai, jrdb_kaisai_nichime, jrdb_race_bango);
```

#### 1.2 初期データ投入（2023年以降）
```sql
-- E:\anonymous-keiba-ai-JRA\sql\populate_myd_key_map.sql
INSERT INTO myd_key_map (
    normalized_key,
    jravan_kaisai_nen,
    jravan_kaisai_tsukihi,
    jravan_keibajo_code,
    jravan_kaisai_kai,
    jravan_kaisai_nichime,
    jravan_race_bango,
    jrdb_race_shikonen,
    jrdb_keibajo_code,
    jrdb_kaisai_kai,
    jrdb_kaisai_nichime,
    jrdb_race_bango
)
SELECT DISTINCT
    -- 正規化キー
    ra.kaisai_nen || ra.kaisai_tsukihi || ra.keibajo_code || ra.race_bango AS normalized_key,
    
    -- JRA-VAN側
    ra.kaisai_nen,
    ra.kaisai_tsukihi,
    ra.keibajo_code,
    ra.kaisai_kai,
    ra.kaisai_nichime,
    ra.race_bango,
    
    -- JRDB側（race_shikonenから抽出）
    CASE 
        WHEN LENGTH(kyi.race_shikonen) = 10 THEN SUBSTRING(kyi.race_shikonen, 1, 10)
        WHEN LENGTH(kyi.race_shikonen) = 6 THEN kyi.race_shikonen
        ELSE kyi.race_shikonen
    END AS jrdb_race_shikonen,
    kyi.keibajo_code,
    kyi.kaisai_kai,
    kyi.kaisai_nichime,
    kyi.race_bango
FROM jvd_ra ra
INNER JOIN jrd_kyi kyi ON (
    -- 年月日での照合（race_shikonenから抽出）
    ra.kaisai_nen = '20' || SUBSTRING(kyi.race_shikonen, 1, 2)
    AND ra.kaisai_tsukihi = SUBSTRING(kyi.race_shikonen, 3, 4)
    AND ra.keibajo_code = kyi.keibajo_code
    AND ra.race_bango = kyi.race_bango
)
WHERE ra.kaisai_nen >= '2023'
ON CONFLICT (normalized_key) DO UPDATE SET
    jrdb_race_shikonen = EXCLUDED.jrdb_race_shikonen,
    jrdb_keibajo_code = EXCLUDED.jrdb_keibajo_code,
    jrdb_kaisai_kai = EXCLUDED.jrdb_kaisai_kai,
    jrdb_kaisai_nichime = EXCLUDED.jrdb_kaisai_nichime,
    jrdb_race_bango = EXCLUDED.jrdb_race_bango,
    updated_at = CURRENT_TIMESTAMP;
```

---

### Step 2: 週次更新プロシージャ作成（1-2時間）

```sql
-- E:\anonymous-keiba-ai-JRA\sql\update_key_map_weekly.sql
-- 【目的】最新週のマッピングを追加
-- 【実行頻度】週1回（月曜朝など）

DO $$
DECLARE
    insert_count INTEGER;
BEGIN
    -- 直近2週間分のマッピングを更新
    INSERT INTO myd_key_map (
        normalized_key,
        jravan_kaisai_nen,
        jravan_kaisai_tsukihi,
        jravan_keibajo_code,
        jravan_kaisai_kai,
        jravan_kaisai_nichime,
        jravan_race_bango,
        jrdb_race_shikonen,
        jrdb_keibajo_code,
        jrdb_kaisai_kai,
        jrdb_kaisai_nichime,
        jrdb_race_bango
    )
    SELECT DISTINCT
        ra.kaisai_nen || ra.kaisai_tsukihi || ra.keibajo_code || ra.race_bango,
        ra.kaisai_nen,
        ra.kaisai_tsukihi,
        ra.keibajo_code,
        ra.kaisai_kai,
        ra.kaisai_nichime,
        ra.race_bango,
        CASE 
            WHEN LENGTH(kyi.race_shikonen) = 10 THEN SUBSTRING(kyi.race_shikonen, 1, 10)
            ELSE kyi.race_shikonen
        END,
        kyi.keibajo_code,
        kyi.kaisai_kai,
        kyi.kaisai_nichime,
        kyi.race_bango
    FROM jvd_ra ra
    INNER JOIN jrd_kyi kyi ON (
        ra.kaisai_nen = '20' || SUBSTRING(kyi.race_shikonen, 1, 2)
        AND ra.kaisai_tsukihi = SUBSTRING(kyi.race_shikonen, 3, 4)
        AND ra.keibajo_code = kyi.keibajo_code
        AND ra.race_bango = kyi.race_bango
    )
    WHERE ra.kaisai_nen || ra.kaisai_tsukihi >= TO_CHAR(CURRENT_DATE - INTERVAL '14 days', 'YYYYMMDD')
    ON CONFLICT (normalized_key) DO UPDATE SET
        jrdb_race_shikonen = EXCLUDED.jrdb_race_shikonen,
        updated_at = CURRENT_TIMESTAMP;
    
    GET DIAGNOSTICS insert_count = ROW_COUNT;
    RAISE NOTICE '✅ key_map更新完了: %件', insert_count;
END $$;
```

---

### Step 3: Phase 6クエリ修正（3-4時間）

#### 3.1 JRDB結合クエリの書き換え

**【修正前】** (scripts/phase6/phase6_daily_prediction.py:351-417)
```python
query_jrdb = """
SELECT ...
FROM jrd_kyi kyi
LEFT JOIN jrd_cyb cyb ON (...)
LEFT JOIN jrd_joa joa ON (...)
WHERE kyi.race_shikonen LIKE %s  -- ❌ 問題箇所
"""
```

**【修正後】**
```python
query_jrdb = """
SELECT 
    map.jravan_kaisai_nen AS kaisai_nen,
    map.jravan_keibajo_code AS keibajo_code,
    map.jravan_kaisai_kai AS kaisai_kai,
    map.jravan_kaisai_nichime AS kaisai_nichime,
    map.jravan_race_bango AS race_bango,
    kyi.umaban,
    kyi.idm,
    ... (全41列)
FROM myd_key_map map
INNER JOIN jrd_kyi kyi ON (
    kyi.race_shikonen = map.jrdb_race_shikonen
    AND kyi.keibajo_code = map.jrdb_keibajo_code
    AND kyi.kaisai_kai = map.jrdb_kaisai_kai
    AND kyi.kaisai_nichime = map.jrdb_kaisai_nichime
    AND kyi.race_bango = map.jrdb_race_bango
)
LEFT JOIN jrd_cyb cyb ON (
    cyb.race_shikonen = kyi.race_shikonen
    AND cyb.keibajo_code = kyi.keibajo_code
    AND cyb.kaisai_kai = kyi.kaisai_kai
    AND cyb.kaisai_nichime = kyi.kaisai_nichime
    AND cyb.race_bango = kyi.race_bango
    AND cyb.umaban = kyi.umaban
)
LEFT JOIN jrd_joa joa ON (
    joa.race_shikonen = kyi.race_shikonen
    AND joa.keibajo_code = kyi.keibajo_code
    AND joa.kaisai_kai = kyi.kaisai_kai
    AND joa.kaisai_nichime = kyi.kaisai_nichime
    AND joa.race_bango = kyi.race_bango
    AND joa.umaban = kyi.umaban
)
WHERE map.jravan_kaisai_nen = %s
  AND map.jravan_kaisai_tsukihi = %s
  AND map.jravan_keibajo_code = ANY(%s)
"""

# パラメータ変更
params = (kaisai_nen, kaisai_tsukihi, keibajo_codes)
df_jrdb = pd.read_sql_query(query_jrdb, conn, params=params)
```

---

### Step 4: 検証SQL作成（1時間）

#### 4.1 当日データ確認SQL
```powershell
# E:\anonymous-keiba-ai-JRA\scripts\check_daily_jrdb.ps1
param(
    [Parameter(Mandatory=$true)]
    [string]$TargetDate  # 例: 20260228
)

$kaisai_nen = $TargetDate.Substring(0, 4)
$kaisai_tsukihi = $TargetDate.Substring(4, 4)

$env:PGPASSWORD = "postgres123"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "JRDB当日データ確認: $TargetDate" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. JRA-VANデータ確認
Write-Host "`n[1] JRA-VANデータ（jvd_ra）" -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c @"
SELECT COUNT(*) AS jravan_race_count
FROM jvd_ra
WHERE kaisai_nen = '$kaisai_nen'
  AND kaisai_tsukihi = '$kaisai_tsukihi';
"@

# 2. JRDBデータ確認
Write-Host "`n[2] JRDBデータ（jrd_kyi）" -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c @"
SELECT 
    COUNT(DISTINCT race_shikonen || keibajo_code || race_bango) AS jrdb_race_count,
    COUNT(*) AS jrdb_row_count
FROM jrd_kyi
WHERE SUBSTRING(race_shikonen, 1, 6) = '$($kaisai_nen.Substring(2, 2))$kaisai_tsukihi';
"@

# 3. key_mapマッピング確認
Write-Host "`n[3] マッピングテーブル（myd_key_map）" -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c @"
SELECT COUNT(*) AS mapped_race_count
FROM myd_key_map
WHERE jravan_kaisai_nen = '$kaisai_nen'
  AND jravan_kaisai_tsukihi = '$kaisai_tsukihi';
"@

# 4. 結合テスト
Write-Host "`n[4] JRA-VAN ⇔ JRDB結合テスト" -ForegroundColor Yellow
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c @"
SELECT 
    COUNT(DISTINCT map.normalized_key) AS joined_race_count,
    COUNT(*) AS joined_row_count
FROM myd_key_map map
INNER JOIN jrd_kyi kyi ON (
    kyi.race_shikonen = map.jrdb_race_shikonen
    AND kyi.keibajo_code = map.jrdb_keibajo_code
    AND kyi.kaisai_kai = map.jrdb_kaisai_kai
    AND kyi.kaisai_nichime = map.jrdb_kaisai_nichime
    AND kyi.race_bango = map.jrdb_race_bango
)
WHERE map.jravan_kaisai_nen = '$kaisai_nen'
  AND map.jravan_kaisai_tsukihi = '$kaisai_tsukihi';
"@

Remove-Item Env:\PGPASSWORD

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "期待値: race_count ≥ 36, row_count ≥ 500" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
```

---

### Step 5: 運用手順書作成（1時間）

#### 毎日の運用フロー

```markdown
## 📅 毎日の運用手順（所要時間：10-15分）

### タイミング：レース当日朝（8:00-9:00推奨）

#### ① JRDBデータダウンロード（3分）
1. JRDBサイトにログイン
2. 当日のデータファイルをダウンロード
   - KYI (競走馬情報)
   - CYB (調教データ)
   - JOA (状態データ)
   - SED (成績データ) ※必要に応じて
3. ファイルを解凍

#### ② PC-KEIBAでデータ登録（5分）
1. PC-KEIBA起動
2. メニュー → 「外部データ登録」
3. 4ファイルを選択 → 実行
4. 完了メッセージ確認

#### ③ データ確認（1分）
```powershell
cd E:\anonymous-keiba-ai-JRA
.\scripts\check_daily_jrdb.ps1 -TargetDate 20260228
```

**期待値**：
- jrdb_race_count ≥ 36
- jrdb_row_count ≥ 500
- mapped_race_count ≥ 36
- joined_row_count ≥ 500

#### ④ Phase 6実行（1分）
```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts/phase6/phase6_daily_prediction.py --target-date 20260228
```

#### ⑤ 結果確認
- `results/*20260228*.txt` ファイルを確認
```

---

## 📊 実装スケジュール

| ステップ | 作業内容 | 所要時間 | 累計 |
|---|---|---|---|
| Step 1 | myd_key_mapテーブル作成 | 2-3h | 2-3h |
| Step 2 | 週次更新プロシージャ作成 | 1-2h | 3-5h |
| Step 3 | Phase 6クエリ修正 | 3-4h | 6-9h |
| Step 4 | 検証SQL作成 | 1h | 7-10h |
| Step 5 | 運用手順書作成 | 1h | 8-11h |
| **テスト** | 統合テスト | 4-6h | **12-17h** |
| **ドキュメント** | コード整理・コミット | 2-3h | **14-20h** |

---

## ✅ 成功基準

### 技術的成功基準
1. ✅ myd_key_mapテーブルが正常に作成され、2023年以降のデータが格納されている
2. ✅ Phase 6でJRDBデータが正常に取得できる（520件以上）
3. ✅ 予測結果ファイルが正常に出力される

### 運用的成功基準
1. ✅ 毎朝10-15分で完結する運用フローが確立されている
2. ✅ データ欠落時の検知機構が機能している
3. ✅ 手順書を見れば誰でも実行できる

---

## 📝 次のアクション

### 実装開始前の確認事項
- [ ] ユーザーの承認を得る
- [ ] GitHubブランチを作成（feature/pc-keiba-key-mapping）
- [ ] バックアップ取得（念のため）

### 実装順序
1. Step 1: myd_key_mapテーブル作成とデータ投入
2. Step 2: 週次更新プロシージャ作成
3. Step 3: Phase 6クエリ修正
4. Step 4: 検証SQL作成
5. Step 5: 統合テスト
6. Git commit & PR作成

---

## 📚 参考資料

- deep-research-report (4).md (行41-201)
- PC-KEIBAマニュアル「外部データとの結合」セクション
- 現行Phase 6実装: scripts/phase6/phase6_daily_prediction.py

---

**作成日**: 2026-02-28  
**最終更新**: 2026-02-28  
**ステータス**: 承認待ち
