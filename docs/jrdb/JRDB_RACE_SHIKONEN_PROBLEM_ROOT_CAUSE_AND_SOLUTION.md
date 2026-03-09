# JRDB race_shikonen問題：根本原因と完全解決ガイド

## 📌 問題の概要

**症状**: PC-KEIBAでJRDBデータ登録後、PostgreSQLの`race_shikonen`カラムに`"26"`（年の2桁のみ）が格納され、本来の`"260221"`（6桁yyMMdd形式）にならない。

**影響**: Phase 6予測スクリプトが`WHERE race_shikonen LIKE '260221%'`でデータを取得できず、予測実行不可能。

---

## 🔬 技術的根本原因（JRDB仕様書に基づく解析）

### JRDBファイルの固定長フォーマット構造

#### **KYIファイルのレースキー構造（公式仕様第11版）**

| 項目名 | バイト数 | TYPE | 相対位置 | 内容 |
|--------|----------|------|----------|------|
| 場コード | 2 | 99 | 1 | 競馬場コード（01-10） |
| **年** | **2** | **99** | **3** | **西暦下2桁（例: "26"）** ← ここだけ読んでいる |
| 回 | 1 | 9 | 5 | 開催回数 |
| 日 | 1 | F | 6 | 開催日次（16進数） |
| R | 2 | 99 | 7 | レース番号 |

**重要**: KYIファイルには「年月日6桁」フィールドは存在しない。レースキーの「年」フィールドは2バイトのみ。

#### **BACファイルの年月日フィールド**

| 項目名 | バイト数 | TYPE | 相対位置 | 内容 |
|--------|----------|------|----------|------|
| **年月日** | **8** | **9** | **9** | **YYYYMMDD形式（例: "20260221"）** |

BACファイルには完全な年月日があるが、KYI/CYB/JOA/SEDには存在しない。

---

## 🚨 原因の特定：3つのパターン

### **パターンA: XML設定ファイルのlength定義ミス（最も可能性が高い）**

```xml
<!-- ❌ 現在の誤った設定（年2桁のみ読み取る） -->
<field name="race_shikonen" start="3" length="2" />

<!-- ✅ 正しい設定（年月日6桁を読み取る） -->
<field name="race_shikonen" start="?" length="6" />
```

**問題**: `length="2"`では年の2桁しか読み取れない。

### **パターンB: フィールド開始位置（start）の指定ミス**

KYIファイルのレースキー「年」フィールド（位置3）を指している場合、2バイトしか読めないのは仕様通り。

### **パターンC: 旧版XMLファイルの使用**

PC-KEIBAの公式XMLは有料会員向けに随時更新されている。古いバージョンは仕様変更に未対応。

---

## ✅ 完全な解決手順

### **ステップ1: 現在のrace_shikonenカラム定義を確認**

pgAdminで実行:

```sql
-- カラムの型と最大長を確認
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'jrd_kyi'
  AND column_name = 'race_shikonen';
```

**期待される結果**: `character_maximum_length = 6` 以上

**もし2になっている場合**: テーブル定義も修正が必要（後述）

---

### **ステップ2: PC-KEIBAの最新XML設定ファイルをダウンロード（推奨）**

#### **入手先**
- [PC-KEIBA公式「外部データを登録する」](https://pc-keiba.com/wp/gaibu-data/)
- ページ最下部の有料会員限定エリア
- JRDB用XML設定ファイルとSQLをダウンロード

#### **重要な注意点**
⚠️ 設定ファイルのダウンロードリンクは**ログインしないと表示されない**  
⚠️ 既にダウンロード済みの場合、ファイルの**更新日時**を確認 → 古ければ再取得

---

### **ステップ3A: XML設定ファイルの配置（公式ファイルを使用する場合）**

1. ダウンロードしたXMLファイルを保存:
   ```
   C:\Program Files\PC-KEIBA\config\jrdb_config.xml
   ```
   または
   ```
   C:\Users\<ユーザー名>\Documents\PC-KEIBA\jrdb_config.xml
   ```

2. PC-KEIBA → データ(D) → 外部データ登録
3. **「設定ファイル」**で、今保存したXMLファイルを選択
4. **「データファイルの保存先」**を`E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`に設定

---

### **ステップ3B: XML設定ファイルの手動修正（自作XMLの場合）**

現在使用中のXMLファイルを開き、`race_shikonen`の定義を確認・修正。

#### **重要な技術的制約**

KYI/CYB/JOA/SEDファイルには「年月日6桁」フィールドが存在しないため、**ファイル名から日付を抽出する特殊処理**が必要。

PC-KEIBAの公式XMLは以下のいずれかの方法でこれを実現している可能性:
1. **ファイル名パース**: `KYI260221.txt`から`260221`を抽出
2. **複数フィールド結合**: レースキーの年(2)+月(計算)+日(16進変換)を結合
3. **BACファイルとの連携**: BACの年月日(位置9-16)から取得してマッピング

#### **BACファイル用のXML例**

```xml
<!-- BAC: 年月日フィールド（位置9）の"20"を飛ばして6桁取得 -->
<field name="race_shikonen" start="11" length="6" />
```

**説明**: BACの年月日は"20260221"（8バイト、位置9開始）。"20"をスキップして位置11から6バイト読めば"260221"を取得できる。

---

### **ステップ4: テーブル定義の修正（必要な場合）**

もし`character_maximum_length = 2`だった場合、カラムを拡張:

```sql
-- race_shikonenカラムを6文字に拡張
ALTER TABLE jrd_kyi ALTER COLUMN race_shikonen TYPE varchar(6);
ALTER TABLE jrd_cyb ALTER COLUMN race_shikonen TYPE varchar(6);
ALTER TABLE jrd_joa ALTER COLUMN race_shikonen TYPE varchar(6);
ALTER TABLE jrd_sed ALTER COLUMN race_shikonen TYPE varchar(6);
ALTER TABLE jrd_bac ALTER COLUMN race_shikonen TYPE varchar(6);

-- 念のため全JRDBテーブルに適用
ALTER TABLE jrd_cha ALTER COLUMN race_shikonen TYPE varchar(6);
ALTER TABLE jrd_kab ALTER COLUMN race_shikonen TYPE varchar(6);
-- ... 他のテーブルも同様
```

---

### **ステップ5: 既存データの削除（クリーンスタート）**

誤ったデータが残っているため、一旦削除:

```sql
-- 2026年の不完全なデータを削除
DELETE FROM jrd_kyi WHERE race_shikonen = '26';
DELETE FROM jrd_cyb WHERE race_shikonen = '26';
DELETE FROM jrd_joa WHERE race_shikonen = '26';
DELETE FROM jrd_sed WHERE race_shikonen = '26';

-- 確認
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen = '26'; -- 0件になるはず
```

---

### **ステップ6: データ再登録**

1. PC-KEIBA → データ(D) → 外部データ登録
2. 設定ファイル: 修正後のXMLを選択
3. データ保存先: `E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\`
4. **「開始」**をクリック

---

### **ステップ7: 登録確認**

pgAdminで実行:

```sql
-- 260221のデータ件数確認
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%';
-- 期待値: 150〜200件

-- 260222のデータ件数確認
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';
-- 期待値: 150〜200件

-- サンプルデータ確認
SELECT race_shikonen, keibajo_code, race_bango, umaban, bamei
FROM jrd_kyi
WHERE race_shikonen LIKE '260221%'
LIMIT 5;
```

**期待される結果**: `race_shikonen`が`"260221????"`のような6桁以上の文字列になっている。

---

## 🔍 診断チェックリスト

### **今すぐ確認すべき3つのこと**

```bash
# ① 現在使用中のXMLファイルのパスを確認
# PC-KEIBA画面で「設定ファイル」欄に表示されているフルパスをメモ

# ② そのXMLファイルをメモ帳またはVSCodeで開く
# 「race_shikonen」を検索し、length属性の値を確認

# ③ PostgreSQLでカラム定義を確認
psql -U postgres -d pckeiba -c "\d jrd_kyi"
# race_shikonen の型が varchar(6) 以上になっているか確認
```

---

## 💡 技術的補足：JRA-VANとJRDBの結合キーの違い

PC-KEIBA公式ページに記載の通り、**JRDB独自の桁数仕様**があります:

| データソース | race_shikonen形式 | 桁数 | 例 |
|------------|------------------|------|-----|
| JRA-VAN (`kaisai_nen`) | YYYY | 4桁 | "2026" |
| JRDB（レースキー「年」のみ） | yy | 2桁 | "26" |
| JRDB（年月日ベース） | yyMMdd | 6桁 | "260221" |

これらは**マッピングテーブル（`myd_key_map`）**を経由して結合するのがPC-KEIBA推奨の方法です。

---

## 🎯 次のアクション（優先順位）

### **優先度1: PC-KEIBA公式XMLの再取得**
1. PC-KEIBA会員サイトにログイン
2. 最新のJRDB用XML設定ファイルをダウンロード
3. ファイルの更新日時を確認（2024年以降であることを推奨）

### **優先度2: 現在のXML設定を確認**
1. PC-KEIBAの「外部データ登録」画面で使用中のXMLファイルパスを確認
2. そのファイルを開いて`race_shikonen`の`length`属性を確認
3. `length="2"`なら`length="6"`に変更（ただし公式XMLの再取得を推奨）

### **優先度3: テーブル定義の確認と修正**
1. pgAdminで`race_shikonen`の`character_maximum_length`を確認
2. 2になっていたら6に拡張
3. 既存の不完全なデータ（"26"のみ）を削除

### **優先度4: 再登録とテスト**
1. 修正後のXMLでデータ再登録
2. PostgreSQLで`race_shikonen LIKE '260221%'`で150〜200件取得できることを確認
3. Phase 6予測スクリプトを実行

---

## 📋 トラブルシューティング

### **Q1: PC-KEIBA会員サイトでXMLファイルが見つからない**
**A**: ログイン後、「外部データを登録する」ページの最下部までスクロール。会員限定エリアにダウンロードリンクがあります。

### **Q2: XMLファイルを修正しても変わらない**
**A**: PC-KEIBAを再起動してください。設定ファイルはアプリ起動時に読み込まれます。

### **Q3: テーブル定義を変更してもエラーが出る**
**A**: 既存データとの型不整合の可能性。一旦該当カラムのデータをクリアしてから型変更を実施してください。

### **Q4: 再登録してもrace_shikonenが"26"のまま**
**A**: XMLの`start`位置がレースキーの「年」フィールド（位置3）を指している可能性。公式XMLの再取得を強く推奨します。

---

## 📚 参考資料

- [PC-KEIBA公式「外部データを登録する」](https://pc-keiba.com/wp/gaibu-data/)
- [PC-KEIBA SQL実行手順](https://pc-keiba.com/wp/execute-sqlfiles/)
- JRDB公式仕様書（第11版）
- PostgreSQL 16ドキュメント: ALTER TABLE

---

**作成日**: 2026-02-24  
**対象**: PC-KEIBA JRDB データ登録のrace_shikonenトランケーション問題  
**目的**: Phase 6予測実行のための完全なデータ登録を実現
