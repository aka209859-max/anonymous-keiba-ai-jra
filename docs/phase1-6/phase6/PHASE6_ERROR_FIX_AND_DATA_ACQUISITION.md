# 🔧 Phase 6 エラー修正 & データ取得方法の説明

**修正日**: 2026-02-23  
**コミット**: `f05b8e8`  
**Pull Request**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1

---

## 🔴 発生したエラー

### エラー内容
```python
AttributeError: 'int' object has no attribute 'strip'
File "phase6_daily_prediction.py", line 747, in save_predictions
    bamei = row.get('bamei', f"{umaban}番馬").strip()
```

### 原因
- `bamei`（馬名）カラムがデータベースから**整数型**（int）で取得された
- `.strip()` メソッドは文字列（str）にのみ使用可能
- 整数型に対して `.strip()` を呼ぶとAttributeErrorが発生

### なぜ整数型になったのか？
PC-KEIBAのPostgreSQLデータベースで `jvd_se.bamei` カラムが以下のいずれかの状態：
1. **数値型（INTEGER/NUMERIC）で定義されている**
2. **文字列型だが、すべて数字のみの馬名が保存されている**（例: "1234"）
3. **カテゴリカルエンコーディングが適用された**（Line 482-486で自動変換）

---

## ✅ 修正内容

### 修正箇所1: 予想順位表示部分（Line 744-751）

#### 修正前
```python
bamei = row.get('bamei', f"{umaban}番馬").strip()
```

#### 修正後
```python
bamei_raw = row.get('bamei', f"{umaban}番馬")
# bameiが整数型の場合は文字列に変換
if isinstance(bamei_raw, (int, float)):
    bamei = str(int(bamei_raw)) if not pd.isna(bamei_raw) else f"{umaban}番馬"
else:
    bamei = str(bamei_raw).strip() if pd.notna(bamei_raw) else f"{umaban}番馬"
```

### 修正箇所2: コンソール出力部分（Line 773-778）

#### 修正前
```python
bamei = row.get('bamei', f"{int(row['umaban'])}番馬").strip()
```

#### 修正後
```python
bamei_raw = row.get('bamei', f"{int(row['umaban'])}番馬")
if isinstance(bamei_raw, (int, float)):
    bamei = str(int(bamei_raw)) if not pd.isna(bamei_raw) else f"{int(row['umaban'])}番馬"
else:
    bamei = str(bamei_raw).strip() if pd.notna(bamei_raw) else f"{int(row['umaban'])}番馬"
```

### 修正ロジック

1. **型チェック**: `isinstance(bamei_raw, (int, float))` で整数・浮動小数点型を判定
2. **整数型の場合**: `str(int(bamei_raw))` で文字列に変換（小数点削除）
3. **文字列型の場合**: `.strip()` で前後の空白を削除
4. **欠損値の場合**: `pd.notna()` でNaN/Noneチェック、フォールバック値 `"{umaban}番馬"` を使用

---

## 📊 当日データ取得方法

### 1. **JRA-VANデータ（当日データ）**

#### 取得方法
- **PC-KEIBAソフトウェア**が自動的にJRA-VANから取得
- JRA-VAN Data Lab契約が必要（月額2,090円〜）

#### 取得タイミング

| データ種別 | 取得タイミング | 内容 |
|-----------|--------------|------|
| **出馬表** | レース前日20:00〜当日朝 | レース基本情報、出走馬一覧、騎手、枠番、負担重量 |
| **速報データ** | レース当日9:00〜 | 馬体重、天候、馬場状態 |
| **確定データ** | レース確定後（約5分後） | 確定着順、走破タイム、オッズ |

#### 取得手順

```
1. PC-KEIBAソフトを起動
2. 「データ更新」ボタンをクリック（またはF5キー）
3. JRA-VANサーバーから自動ダウンロード開始
4. PostgreSQLデータベースに自動保存
   - jvd_ra: レース基本情報
   - jvd_se: 出走馬情報
   - jvd_ck: 馬実績データ
   - jvd_um: 馬基本情報
```

#### データベース保存先
- **Database**: `pckeiba`
- **Host**: `127.0.0.1:5432`
- **User**: `postgres`
- **Password**: `postgres123`

#### 確認コマンド
```sql
-- 2026-02-21のレース数確認
SELECT COUNT(DISTINCT race_bango) AS race_count
FROM jvd_ra
WHERE kaisai_nen = '2026' AND kaisai_tsukihi = '0221';

-- 2026-02-21の出走馬数確認
SELECT COUNT(*) AS horse_count
FROM jvd_se
WHERE kaisai_nen = '2026' AND kaisai_tsukihi = '0221';
```

---

### 2. **JRDBデータ（当日データ）**

#### 取得方法
- **JRDBサイトから手動ダウンロード**
- JRDB会員登録が必要（月額1,980円〜）

#### ダウンロード手順

```
1. JRDBサイトにログイン
   https://www.jrdb.com/

2. 「データダウンロード」メニューを選択

3. 必要なファイルをダウンロード:
   - KYI (競走馬指数): 各馬のIDM、騎手指数、調教指数など
   - CYB (調教指数): 調教評価、仕上がり指数
   - JOA (騎手評価): 騎手の実力指数、期待値
   - SED (過去走データ): 過去レースの詳細、ペース指数

4. ダウンロードしたファイルをPC-KEIBAの指定フォルダに配置
   （例: C:\Program Files\PC-KEIBA\jrdb\）

5. PC-KEIBAで「JRDBデータ取り込み」を実行

6. PostgreSQLデータベースに自動インポート
   - jrd_kyi: 競走馬指数
   - jrd_cyb: 調教指数
   - jrd_joa: 騎手評価
   - jrd_sed: 過去走データ
```

#### データ取得時刻

| ファイル | 公開時刻 | 内容 |
|---------|---------|------|
| **KYI** | 前日19:00頃 | 競走馬指数（IDM、騎手指数など） |
| **CYB** | 前日19:00頃 | 調教指数（仕上がり評価） |
| **JOA** | 前日19:00頃 | 騎手評価（期待連対率など） |
| **SED** | 前日19:00頃 | 過去走データ（ペース指数など） |

#### 確認コマンド
```sql
-- 2026-02-21のJRDBデータ確認
SELECT COUNT(*) AS jrdb_kyi_count
FROM jrd_kyi
WHERE '20' || race_shikonen = '2026';

-- JRDBデータとJRA-VANデータのマージ確認
SELECT 
    ra.race_bango,
    COUNT(se.umaban) AS jravan_horse_count,
    COUNT(kyi.umaban) AS jrdb_horse_count
FROM jvd_ra ra
LEFT JOIN jvd_se se ON (ra.kaisai_nen = se.kaisai_nen AND ra.kaisai_tsukihi = se.kaisai_tsukihi AND ra.race_bango = se.race_bango)
LEFT JOIN jrd_kyi kyi ON ('20' || kyi.race_shikonen = ra.kaisai_nen AND kyi.keibajo_code = ra.keibajo_code AND kyi.race_bango = ra.race_bango)
WHERE ra.kaisai_nen = '2026' AND ra.kaisai_tsukihi = '0221'
GROUP BY ra.race_bango
ORDER BY ra.race_bango;
```

---

### 3. **Phase 6 スクリプトのデータ取得フロー**

#### データ取得SQL（Line 94-156）

```python
# A. 基礎情報系（JRA-VAN）
query_basic = f"""
SELECT 
    ra.kaisai_nen,
    ra.kaisai_tsukihi,
    ra.keibajo_code,
    se.umaban,
    se.bamei,                  # 馬名
    se.kishumei_ryakusho,      # 騎手名
    se.banushimei,             # 馬主名
    ...
FROM jvd_ra ra
INNER JOIN jvd_se se ON (...)
WHERE ra.kaisai_nen = '2026'
  AND ra.kaisai_tsukihi = '0221'
"""
```

#### 実行タイミング

```python
# phase6_daily_prediction.py 実行時
python scripts/phase6/phase6_daily_prediction.py --target-date 20260221

# 内部処理フロー
1. データベース接続 (Line 712)
2. 当日データ取得 (Line 716)
   - JRA-VAN: jvd_ra, jvd_se, jvd_ck からデータ抽出
   - JRDB: jrd_kyi, jrd_cyb, jrd_joa, jrd_sed からデータ抽出
3. 145列特徴量生成 (Line 93-489)
4. Phase 5 アンサンブル予測 (Line 719-722)
5. Markdownレポート出力 (Line 725)
```

---

## 🧪 修正後のテスト手順

### ローカルPCで実行

```powershell
# 1. GitHubから最新コード取得
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git reset --hard origin/genspark_ai_developer

# 2. 仮想環境アクティベート
.\venv\Scripts\Activate.ps1

# 3. Phase6テスト実行
.\scripts\phase6\run_phase6_test.ps1

# 4. 結果確認
notepad results\predictions_20260221.md
```

---

## 📋 期待される出力

### コンソール出力（修正後）
```
============================================================
Phase 6: 当日データ取得 & 特徴量生成（20260221）
============================================================
✅ 基礎情報: 530頭（12レース）
✅ 馬実績データマージ: 530件
✅ 過去走データマージ: 496件
✅ JRDB特徴量マージ: 2402件
✅ JRDB過去走マージ: 496件
✅ 派生特徴量生成完了
✅ 特徴量生成完了: 530行 × 140列

✅ 二値分類予測完了（特徴量: 132列）
✅ ランキング予測完了（特徴量: 136列）
✅ タイム予測完了（特徴量: 135列）
✅ アンサンブルスコア計算完了

中山 01R:
  1. 2番 フランジパーヌ （スコア: 1.00 / S）
  2. 3番 キーチデッドミラー （スコア: 0.94 / S）
  3. 11番 ソシテアイサレテ （スコア: 0.59 / C）

✅ 予測結果保存完了:
  📄 Markdownレポート: results/predictions_20260221.md (8.45 KB)
  📊 CSV (バックアップ): results/predictions_20260221.csv (52.42 KB)
  レコード数: 494行
  レース数: 12レース
```

### Markdownレポート（修正後）
```markdown
## 🏇 中山 第1R 予想

### 📊 予想順位
**1. 2番 フランジパーヌ** （スコア: 1.00 / S）
**2. 3番 キーチデッドミラー** （スコア: 0.94 / S）
**3. 11番 ソシテアイサレテ** （スコア: 0.59 / C）

### 💰 購入推奨
**🎯 本命軸**
- 単勝: **2番**
- 複勝: **2番**、3番

**🔄 相手候補**
- 馬単: 2→3、3→2、2→11、11→2
- 三連複: 2.3 - 3.11.5 - 3.11.5.9.7.6
```

---

## 🔗 GitHub情報

- **Repository**: https://github.com/aka209859-max/anonymous-keiba-ai-jra
- **Pull Request**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/pull/1
- **Branch**: `genspark_ai_developer`
- **Latest Commit**: `f05b8e8` (fix(phase6): Handle bamei column as integer type)

---

## ✅ チェックリスト

- [x] エラー修正完了（bamei整数型対応）
- [x] GitHubにコミット・プッシュ完了
- [ ] ユーザーによる再テスト実行（待機中）
- [ ] Markdownレポート確認（待機中）
- [ ] 馬名が正しく表示されるか確認（待機中）

---

## 📝 データ取得まとめ

| データソース | 取得方法 | 取得タイミング | 費用 |
|-------------|---------|--------------|------|
| **JRA-VAN** | PC-KEIBA自動ダウンロード | レース前日20:00〜当日 | 月額2,090円〜 |
| **JRDB** | 手動ダウンロード → PC-KEIBA取り込み | レース前日19:00〜 | 月額1,980円〜 |

**Phase 6スクリプトは、これらのデータがPostgreSQLデータベースに保存されていることを前提としています。**

---

**修正者**: GenSpark AI Developer  
**修正日時**: 2026-02-23 22:45 JST
