# Phase 1-A ファイル整理計画

## ✅ データ確認完了

- **ファイル名**: `jra_jravan_97cols.csv`
- **総行数**: 738,844 行（ヘッダー含め 738,845 行）
- **列数**: 31 列
- **ファイルサイズ**: 95.2 MB
- **target_top3 分布**: 約 23.4% が上位3着（1～3位）
- **データ品質**: ✅ 正常

---

## 📁 保持すべきファイル（KEEP）

### Scripts
1. ✅ **`scripts/phase1a_simple.py`** (NEW - 最終動作版)
   - 年別バッチ処理
   - LATERAL JOIN
   - 5分50秒で完走
   - **アクション**: Windows から追加が必要

2. ✅ **`scripts/create_indexes.py`**
   - インデックス作成ヘルパー
   - 再利用可能

### SQL
1. ✅ **`sql/jrdb_extraction.sql`** (8.5 KB)
   - Phase 1-B で使用予定
   - JRDB データ抽出用

2. ✅ **`sql/jravan_extraction_lateral.sql`** (15 KB)
   - LATERAL JOIN 版クエリ
   - 参考資料として保持

---

## 🗑️ 削除すべきファイル（DELETE）

### Scripts (失敗版・試行版)
1. ❌ **`scripts/phase1_data_extraction.py`** (13 KB)
   - 初期版、ROW_NUMBER() で失敗

2. ❌ **`scripts/phase1_data_extraction_lightweight.py`** (12 KB)
   - 軽量版、97列要件未達

3. ❌ **`scripts/phase1_data_extraction_optimized.py`** (9.7 KB)
   - 最適化試行版、未完成

4. ❌ **`scripts/phase1_data_extraction_stepwise.py`** (24 KB)
   - 段階的実行版、複雑で不要

5. ❌ **`scripts/phase1a_jravan_extraction_lateral.py`** (7.9 KB)
   - 途中版、カラム名エラーあり
   - **phase1a_simple.py に置き換え**

### SQL (失敗版・試行版)
1. ❌ **`sql/jravan_extraction.sql`** (14 KB)
   - 初期版、未最適化

2. ❌ **`sql/jravan_extraction_full_optimized.sql`** (11 KB)
   - 最適化版だがサーバークラッシュ

3. ❌ **`sql/jravan_extraction_optimized.sql`** (17 KB)
   - ROW_NUMBER() 版、179 GB 一時ファイル発生

4. ❌ **`sql/jravan_step1_basic.sql`** (3.9 KB)
   - 段階的実行の第1ステップ、未使用

5. ❌ **`sql/jravan_step1_basic_fixed.sql`** (3.9 KB)
   - 上記の修正版、未使用

6. ❌ **`sql/jravan_step2_history.sql`** (1.3 KB)
   - 段階的実行の第2ステップ、未使用

---

## 📝 実行計画

### Step 1: Windows から成功版スクリプトを取得
```powershell
# Windows 側で実行
cd E:\anonymous-keiba-ai-JRA
Get-Content scripts\phase1a_simple.py | clip
```

### Step 2: 不要ファイルを削除
```bash
cd /home/user/webapp

# Scripts 削除
git rm scripts/phase1_data_extraction.py
git rm scripts/phase1_data_extraction_lightweight.py
git rm scripts/phase1_data_extraction_optimized.py
git rm scripts/phase1_data_extraction_stepwise.py
git rm scripts/phase1a_jravan_extraction_lateral.py

# SQL 削除
git rm sql/jravan_extraction.sql
git rm sql/jravan_extraction_full_optimized.sql
git rm sql/jravan_extraction_optimized.sql
git rm sql/jravan_step1_basic.sql
git rm sql/jravan_step1_basic_fixed.sql
git rm sql/jravan_step2_history.sql
```

### Step 3: 最終版スクリプトを追加
```bash
# phase1a_simple.py を作成（Windows からコピー）
git add scripts/phase1a_simple.py
```

### Step 4: コミット & プッシュ
```bash
git commit -m "chore: cleanup Phase 1-A files - remove failed/test versions

Removed:
- 5 failed/test script versions
- 6 unused/failed SQL files

Added:
- scripts/phase1a_simple.py (final working version, 5min50sec runtime)

Kept:
- scripts/create_indexes.py (reusable helper)
- sql/jrdb_extraction.sql (for Phase 1-B)
- sql/jravan_extraction_lateral.sql (reference)"

git push origin genspark_ai_developer
```

---

## 📊 整理後のファイル構成

```
scripts/
├── create_indexes.py          # インデックス作成
└── phase1a_simple.py          # Phase 1-A 最終版（NEW）

sql/
├── jrdb_extraction.sql        # Phase 1-B 用
└── jravan_extraction_lateral.sql  # 参考資料

data/raw/
└── jra_jravan_97cols.csv      # 抽出結果（738,844行）
```

---

## ✅ 整理完了後の確認項目

1. [ ] 不要ファイル 11 個が削除された
2. [ ] `scripts/phase1a_simple.py` が追加された
3. [ ] 残ったファイルが 4 個（scripts 2個、sql 2個）
4. [ ] Git コミットメッセージが明確
5. [ ] プルリクエストが更新された
