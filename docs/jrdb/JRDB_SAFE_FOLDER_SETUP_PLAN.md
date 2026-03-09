# JRDB データ管理：安全な専用フォルダ構成計画

## 📁 推奨フォルダ構成

```
E:\anonymous-keiba-ai-JRA\
  └── data\
      └── jrdb\
          ├── config\               # 設定ファイル（XML、SQL）
          │   ├── DataSettings.xml
          │   ├── jrd_kyi.sql
          │   ├── jrd_cyb.sql
          │   ├── jrd_joa.sql
          │   └── jrd_sed.sql
          │
          ├── raw\
          │   └── JRDB_weekly\      # 最新の週次データのみ（*.lzh）
          │       ├── KYI260221.lzh
          │       ├── CYB260221.lzh
          │       ├── JOA260221.lzh
          │       ├── SED260221.lzh
          │       ├── KYI260222.lzh
          │       ├── CYB260222.lzh
          │       ├── JOA260222.lzh
          │       └── SED260222.lzh
          │
          └── archive\              # 過去データのアーカイブ（オプション）
              └── 2026\
                  └── 02\
```

---

## ⚠️ 現在の「危険」な状況

### Downloads フォルダの問題点
1. **一時的な場所**: ブラウザのダウンロードで上書きされる可能性
2. **バージョン管理不能**: `(1)`, `(2)` のような重複ファイルが増える
3. **アクセス権限**: 誤って削除しやすい
4. **プロジェクト外**: `E:\anonymous-keiba-ai-JRA\` プロジェクトと分離している

### 現在のファイル配置
- **設定ファイル**: `C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\*.sql` と `DataSettings.xml`
- **データファイル**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\*.lzh`
- **問題**: 設定とデータが分離している

---

## 🛠️ セットアップ手順（PowerShell）

### ステップ1: 専用フォルダ作成と設定ファイルのコピー

```powershell
# E: ドライブのプロジェクトフォルダに移動
cd E:\anonymous-keiba-ai-JRA\data\jrdb

# config フォルダ作成（既に存在する場合はスキップ）
New-Item -ItemType Directory -Path "E:\anonymous-keiba-ai-JRA\data\jrdb\config" -Force

# Downloads から最新の SQL と XML をコピー
Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\*.sql" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force
Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\DataSettings.xml" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force

# コピー確認
ls "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" | Select-Object Name, Length, LastWriteTime
```

### ステップ2: データファイルの確認

```powershell
# 現在のデータファイル（*.lzh）を確認
ls "E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\" | Select-Object Name, Length, LastWriteTime

# 期待されるファイル:
# KYI260221.lzh, CYB260221.lzh, JOA260221.lzh, SED260221.lzh
# KYI260222.lzh, CYB260222.lzh, JOA260222.lzh, SED260222.lzh
```

---

## 🔧 テーブル再作成と登録手順

### ステップ3: PostgreSQL テーブルの再作成

#### 3-1. 古いテーブルの削除（すでに完了）
✅ 既に 18 個の古い JRDB テーブルは削除済み（`race_shikonen varchar(2)` の問題があった）

#### 3-2. 最新 SQL で4つの必須テーブルを作成

**pgAdmin Query Tool で順に実行**:

```sql
-- 1. jrd_kyi テーブル作成
-- File → Open File → E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_kyi.sql
-- F5 で実行

-- 2. jrd_cyb テーブル作成
-- File → Open File → E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_cyb.sql
-- F5 で実行

-- 3. jrd_joa テーブル作成
-- File → Open File → E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_joa.sql
-- F5 で実行

-- 4. jrd_sed テーブル作成
-- File → Open File → E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_sed.sql
-- F5 で実行
```

#### 3-3. テーブル作成確認

```sql
-- 4つのテーブルが作成されたか確認
SELECT tablename 
FROM pg_catalog.pg_tables 
WHERE schemaname='public' 
  AND tablename IN ('jrd_kyi','jrd_cyb','jrd_joa','jrd_sed')
ORDER BY tablename;

-- 期待結果: jrd_cyb, jrd_joa, jrd_kyi, jrd_sed の 4 行
```

#### 3-4. race_shikonen カラム定義の確認

```sql
-- race_shikonen が正しく定義されているか確認（6桁以上が必要）
SELECT 
    table_name, 
    column_name, 
    data_type, 
    character_maximum_length
FROM information_schema.columns 
WHERE table_name IN ('jrd_kyi','jrd_cyb','jrd_joa','jrd_sed')
  AND column_name = 'race_shikonen'
ORDER BY table_name;

-- 期待結果: character_maximum_length が 10 または 6 以上
```

---

### ステップ4: PC-KEIBA でデータ登録

#### 4-1. 設定ファイルパスの更新

**PC-KEIBA の「外部データ登録」画面で**:
- **設定ファイル**: `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml`
- **データファイルの保存先**: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`

#### 4-2. 登録の実行
1. PC-KEIBA → **データ(D)** → **外部データ登録** を開く
2. 上記パスを設定
3. **開始** をクリック
4. 進捗ログを確認:
   - `KYI260221.lzh → KYI260221.txt 展開 → 487 件登録`
   - `CYB260221.lzh → CYB260221.txt 展開 → 530 件登録`
   - （同様に 260222 の 4 ファイルも処理）
5. 「登録完了」メッセージを確認

---

### ステップ5: データ登録の検証

```sql
-- 各テーブルの件数確認
SELECT 'jrd_kyi' AS table_name, COUNT(*) AS row_count FROM jrd_kyi
UNION ALL
SELECT 'jrd_cyb', COUNT(*) FROM jrd_cyb
UNION ALL
SELECT 'jrd_joa', COUNT(*) FROM jrd_joa
UNION ALL
SELECT 'jrd_sed', COUNT(*) FROM jrd_sed;

-- 期待結果:
-- jrd_kyi: 300〜400 行（260221 + 260222 の合計）
-- jrd_cyb: 1,000〜1,100 行
-- jrd_joa: 300〜400 行
-- jrd_sed: 400〜500 行
```

```sql
-- race_shikonen の値を確認（正しく 6 桁以上になっているか）
SELECT 
    race_shikonen, 
    keibajo_code, 
    kaisai_kai, 
    kaisai_nichime, 
    race_bango, 
    umaban,
    bamei
FROM jrd_kyi
WHERE race_shikonen LIKE '260221%' OR race_shikonen LIKE '260222%'
ORDER BY race_shikonen DESC, keibajo_code, race_bango, umaban
LIMIT 10;

-- 期待結果: race_shikonen が "2602210106" のような 10 桁形式
```

---

## 🚨 重要な確認ポイント

### 15年分データ登録の問題

**質問**: 毎回 PC-KEIBA で登録する際、過去15年分すべてを処理していますか？

**確認方法**:
```sql
-- jrd_kyi に格納されている年の範囲を確認
SELECT 
    LEFT(race_shikonen, 2) AS year_yy,
    MIN(race_shikonen) AS earliest_race,
    MAX(race_shikonen) AS latest_race,
    COUNT(*) AS race_count
FROM jrd_kyi
GROUP BY LEFT(race_shikonen, 2)
ORDER BY year_yy DESC;
```

**もし 11〜26 年（2011〜2026 年）のデータが全部入っている場合**:
- **問題**: 毎回数十万行を再登録しているため、処理が遅く非効率
- **解決策**:
  1. **過去データは一度だけ登録**: 2010〜2025 年のデータは初回のみ
  2. **週次データのみ追加**: `JRDB_weekly` フォルダには当週分だけを配置
  3. **PC-KEIBA 設定**: 増分登録（新規データのみ追加）に設定できるか確認

---

## ✅ 次のアクション

### 優先度1: テーブル作成と検証
1. **ステップ1 の PowerShell コマンドを実行**:
   ```powershell
   # 設定ファイルをプロジェクトフォルダにコピー
   Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\*.sql" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force
   Copy-Item "C:\Users\ihaji\Downloads\GaibuData (2)\Jrdb\DataSettings.xml" "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" -Force
   ls "E:\anonymous-keiba-ai-JRA\data\jrdb\config\" | Select-Object Name, Length, LastWriteTime
   ```
   
2. **ステップ3 の pgAdmin 操作を実行**:
   - `E:\anonymous-keiba-ai-JRA\data\jrdb\config\jrd_kyi.sql` を開いて実行
   - 同様に `jrd_cyb.sql`, `jrd_joa.sql`, `jrd_sed.sql` を実行
   - テーブル作成確認 SQL を実行

3. **結果を報告**:
   - コピーコマンドの出力（ファイルリスト）
   - テーブル作成確認 SQL の結果（4 行）
   - `race_shikonen` カラム定義の確認結果

---

## 📝 まとめ

### 整理の目的
- **安全性**: Downloads フォルダから専用フォルダへ移動
- **一元管理**: 設定ファイルとデータを同じプロジェクト内に配置
- **再現性**: 他の環境でも同じ手順で構築可能
- **効率化**: 15年分の再登録を避け、週次データのみを処理

### 期待される成果
- `E:\anonymous-keiba-ai-JRA\data\jrdb\` フォルダに全ファイルが集約
- PostgreSQL に正しい `race_shikonen` 定義で 4 つのテーブルが作成される
- 2026年2月21日/22日 のデータが正しく登録される
- Phase 6 予測スクリプトが実行可能になる

---

## 🔗 関連ドキュメント

- **根本原因分析**: `JRDB_RACE_SHIKONEN_PROBLEM_ROOT_CAUSE_AND_SOLUTION.md`
- **問題サマリー**: `JRDB_REGISTRATION_PROBLEM_SUMMARY.md`
- **チェックリスト**: `JRDB_WEEKLY_CHECKLIST.md`

---

**最終更新**: 2026-02-24  
**作成者**: Claude (GenSpark AI Developer)
