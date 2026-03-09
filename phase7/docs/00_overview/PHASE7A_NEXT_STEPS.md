# Phase 7-A 次のステップ

**作成日**: 2026-03-09  
**現在の進捗**: Day 1-2 完了（JRDBデータ現状確認）  
**次のタスク**: Day 3-4（JRA-VAN 139次元詳細リスト作成）

---

## ✅ 完了した作業（Day 1-2）

### JRDBデータベース構築完了

- [x] **18テーブル、4,193,206行のデータ登録完了**
- [x] **データ期間**: 2016年1月 〜 2026年3月（10年分）
- [x] **Phase 7-A 必須テーブル**: 5/5 完了（1,999,754行）
- [x] **補助テーブル**: 13/13 完了（2,193,452行）
- [x] **テーブル構造修正**: `race_shikonen` VARCHAR(6) 対応完了
- [x] **CSA/KSA 構造理解**: マスタデータ（調教師452人、騎手420人）

### 成果物
- ✅ **レポート作成**: `JRDB_DATABASE_SETUP_COMPLETE_REPORT.md`
- ✅ **GitHubコミット**: `122a97e` (2026-03-09)

---

## 🎯 次のタスク: Day 3-4（JRA-VAN 139次元詳細リスト作成）

### 目的
Phase 6 で使用している **139次元の特徴量** を詳細に文書化し、Phase 7-A での特徴量拡張の基盤を作る。

---

### 📋 作業内容

#### 1. Phase 6 スクリプトの解析

**対象ファイル**:
- `/home/user/webapp/phase6_daily_prediction.py`
- `/home/user/webapp/scripts/phase2a/prepare_features_v2.py`

**確認項目**:
1. **使用されているテーブル**
   - JRA-VAN: `jvd_ra`, `jvd_se`, `jvd_ck` 等
   - JRDB: `jrd_kyi`, `jrd_cyb`, `jrd_joa`, `jrd_sed` 等

2. **抽出されている特徴量**
   - 基礎情報系（24列）
   - 過去成績系（50列程度）
   - JRDB特徴量（65列程度）

3. **前日情報の判定**
   - 前日21時時点で確定している情報のみをリストアップ
   - 当日情報（馬体重、リアルタイムオッズ）を除外

#### 2. 特徴量リストの作成

**CSVフォーマット**:
```csv
feature_id,feature_name,table_name,data_type,description,is_prior_day_available,category
1,race_avg_time,n_uma_race_tokucho,float,レース平均タイム,TRUE,過去成績
2,same_track_avg_rank,n_uma_race_tokucho,float,同コース平均着順,TRUE,過去成績
3,kishu_win_rate,n_kishu,float,騎手勝率,TRUE,騎手情報
...
```

**カラム説明**:
- `feature_id`: 通し番号（1-139）
- `feature_name`: 特徴量名（英語）
- `table_name`: ソーステーブル名
- `data_type`: データ型（int, float, str, bool）
- `description`: 日本語説明
- `is_prior_day_available`: 前日情報フラグ（TRUE/FALSE）
- `category`: カテゴリ（過去成績, 騎手情報, 調教情報, レース情報等）

#### 3. カテゴリ分類

**分類例**:
1. **レース基本情報**（10-15列）
   - 競馬場コード、距離、馬場状態等

2. **過去成績**（40-50列）
   - 平均着順、勝率、連対率、複勝率
   - 同コース成績、同距離成績

3. **騎手情報**（10-15列）
   - 騎手勝率、騎手連対率
   - 騎手期待値

4. **調教情報**（15-20列）
   - 調教タイム、調教評価

5. **JRDB特徴量**（30-40列）
   - IDM、テン指数、上がり指数
   - 馬場指数、展開予想

6. **オッズ情報**（5-10列）
   - 前日オッズ（単勝、複勝）

---

### 🛠️ 実装方法

#### ステップ 1: Phase 6 スクリプトの SQL 解析

**PowerShell スクリプト（PC側で実行）**:
```powershell
# Phase 6 スクリプトから使用されているテーブルとカラムを抽出
$scriptPath = "E:\anonymous-keiba-ai-JRA\phase6_daily_prediction.py"
$content = Get-Content $scriptPath -Raw

# テーブル名を抽出
$tables = [regex]::Matches($content, "FROM\s+(\w+)\s+") | ForEach-Object { $_.Groups[1].Value }
$tables += [regex]::Matches($content, "JOIN\s+(\w+)\s+") | ForEach-Object { $_.Groups[1].Value }

Write-Host "使用されているテーブル:" -ForegroundColor Cyan
$tables | Sort-Object -Unique | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }

# カラム名を抽出（SELECT句から）
$columns = [regex]::Matches($content, "SELECT\s+([\s\S]*?)\s+FROM", [System.Text.RegularExpressions.RegexOptions]::Multiline)

Write-Host "`n抽出されたSELECT句の数: $($columns.Count)" -ForegroundColor Cyan
```

#### ステップ 2: PostgreSQL でカラム情報を取得

**PostgreSQL スクリプト**:
```powershell
$env:PGPASSWORD = "postgres123"

# 主要テーブルのカラム情報を取得
$tables = @("jvd_ra", "jvd_se", "jvd_ck", "jrd_kyi", "jrd_cyb", "jrd_joa", "jrd_sed")

foreach($table in $tables){
    Write-Host "`n[$table] カラム一覧:" -ForegroundColor Cyan
    & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d pckeiba -c "
    SELECT 
        column_name,
        data_type,
        character_maximum_length
    FROM information_schema.columns 
    WHERE table_name='$table'
    ORDER BY ordinal_position;
    "
}

Remove-Item Env:\PGPASSWORD
```

#### ステップ 3: 特徴量リスト CSV 作成

**Python スクリプト（概要）**:
```python
import pandas as pd

# Phase 6 から抽出した特徴量リスト
features = [
    {
        'feature_id': 1,
        'feature_name': 'race_avg_time',
        'table_name': 'n_uma_race_tokucho',
        'data_type': 'float',
        'description': 'レース平均タイム',
        'is_prior_day_available': True,
        'category': '過去成績'
    },
    # ... 139個の特徴量
]

df = pd.DataFrame(features)
df.to_csv('jravan_available_features.csv', index=False, encoding='utf-8-sig')
print(f"特徴量リスト作成完了: {len(df)}列")
```

---

### 📦 成果物

**ファイル名**: `jravan_available_features.csv`

**保存先**: `phase7/results/phase7a_features/`

**期待される行数**: 139行（Phase 6 で使用されている全特徴量）

**サンプル**:
```csv
feature_id,feature_name,table_name,data_type,description,is_prior_day_available,category
1,keibajo_code,jvd_ra,str,競馬場コード,TRUE,レース基本情報
2,race_bango,jvd_ra,int,レース番号,TRUE,レース基本情報
3,kyori,jvd_ra,int,距離,TRUE,レース基本情報
4,track_code,jvd_ra,str,トラックコード,TRUE,レース基本情報
5,babajotai_code,jvd_se,str,馬場状態コード,TRUE,レース基本情報
...
50,race_avg_time,past_agg,float,レース平均タイム,TRUE,過去成績
51,same_track_avg_rank,past_agg,float,同コース平均着順,TRUE,過去成績
...
100,idm,jrd_kyi,int,IDM,TRUE,JRDB特徴量
101,ten_shisu,jrd_kyi,int,テン指数,TRUE,JRDB特徴量
...
```

---

## 🚀 実行手順

### 手順 1: PC側で Phase 6 スクリプト解析

1. PowerShell を開く
2. ステップ1のスクリプトを実行
3. 出力結果をテキストファイルに保存

### 手順 2: PostgreSQL でカラム情報を取得

1. ステップ2のスクリプトを実行
2. 各テーブルのカラム一覧を確認
3. 結果を保存

### 手順 3: 手動で特徴量リストを作成

1. Phase 6 スクリプトを読み、使用されている特徴量を特定
2. Excel または Python で CSV を作成
3. 139行の特徴量リストを完成させる

### 手順 4: 前日情報フラグの判定

**前日情報として利用可能**:
- ✅ レース基本情報（競馬場、距離、トラック等）
- ✅ 過去成績（前走、前々走等）
- ✅ 騎手情報（騎手勝率等）
- ✅ 調教情報（前日までの調教タイム）
- ✅ JRDB特徴量（IDM、テン指数等）
- ✅ 前日オッズ（前日21時時点）

**当日情報（除外）**:
- ❌ 馬体重（当日発表）
- ❌ リアルタイムオッズ（レース直前）
- ❌ 天候（当日変動）

---

## 📊 カテゴリ別の特徴量分布（予想）

| カテゴリ | 特徴量数 | 割合 |
|---------|----------|------|
| レース基本情報 | 15 | 10.8% |
| 過去成績 | 45 | 32.4% |
| 騎手情報 | 12 | 8.6% |
| 調教情報 | 18 | 12.9% |
| JRDB特徴量 | 35 | 25.2% |
| オッズ情報 | 8 | 5.8% |
| その他 | 6 | 4.3% |
| **合計** | **139** | **100%** |

---

## ✅ Day 3-4 完了条件

- [ ] Phase 6 スクリプトの SQL 解析完了
- [ ] PostgreSQL からカラム情報取得完了
- [ ] `jravan_available_features.csv` 作成完了（139行）
- [ ] 前日情報フラグの判定完了
- [ ] カテゴリ分類完了
- [ ] ファイルを `phase7/results/phase7a_features/` に保存
- [ ] GitHub にコミット

---

## 🔗 関連ドキュメント

- **Week 1 計画書**: `PHASE7A_WEEK1_START_PLAN.md`
- **データベース完了レポート**: `JRDB_DATABASE_SETUP_COMPLETE_REPORT.md`
- **Phase 7 README**: `../../README.md`
- **Phase 6 スクリプト**: `/home/user/webapp/phase6_daily_prediction.py`

---

## 📝 作業ログ

### 2026-03-09
- [x] Day 1-2 完了（JRDBデータベース構築）
- [x] データベース完了レポート作成
- [x] GitHub コミット（122a97e）
- [ ] Day 3-4 開始（JRA-VAN 139次元詳細リスト作成） ← **次のタスク**

---

**次のアクション**: Phase 6 スクリプトの SQL 解析を開始してください 🚀
