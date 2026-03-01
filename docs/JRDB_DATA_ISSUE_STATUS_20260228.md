# JRDB データ問題 現在の状況レポート

**作成日**: 2026年2月28日  
**プロジェクト**: anonymous中央競馬AIシステム  
**GitHub Repository**: https://github.com/aka209859-max/anonymous-keiba-ai-jra  
**Branch**: genspark_ai_developer

---

## 📊 Executive Summary

### ✅ **解決した問題**
1. `race_shikonen` カラムの型が **10桁** に修正された
2. `jrd_bac` テーブルにデータが **110件** 登録された

### 🔴 **新たに発見された重大な問題**
`race_shikonen` の値が **間違ったフォーマット** で登録されている

**期待値**: `260221`, `260222`, `260228`, `260301` (6桁 yyMMdd形式)  
**実際の値**: `2621112026`, `2621122026`, `261a01`, `261b01` など (10桁、不正なフォーマット)

---

## 🔍 詳細な検証結果

### **確認1: jrd_bac テーブル件数**

```sql
SELECT COUNT(*) AS total_count FROM jrd_bac;
```

**結果**:
```
total_count
------------
        110
```

✅ **判定**: 件数は正しい（BAC ファイル4つ分の合計）

---

### **確認2: データサンプル**

```sql
SELECT race_shikonen, keibajo_code, kaisai_nen, kaisai_tsukihi, LENGTH(race_shikonen) AS len 
FROM jrd_bac 
ORDER BY race_shikonen DESC 
LIMIT 10;
```

**結果**:
```
race_shikonen | keibajo_code | kaisai_nen | kaisai_tsukihi | len
--------------+--------------+------------+----------------+-----
2622112026    | 06           | 1545       | 1800           |  10
2621122026    | 06           | 1625       | 1800           |  10
2621112026    | 06           | 1545       | 1200           |  10
2621102026    | 06           | 1505       | 1200           |  10
2621092026    | 06           | 1430       | 2200           |  10
2621082026    | 06           | 1400       | 1600           |  10
2621072026    | 06           | 1330       | 1800           |  10
2621062026    | 06           | 1300       | 1800           |  10
2621052026    | 06           | 1225       | 2000           |  10
2621042026    | 06           | 1135       | 1800           |  10
```

❌ **判定**: `race_shikonen` の値が完全に間違っている

**期待されるフォーマット**: `260221` (6桁)  
**実際の値**: `2621112026` (10桁、意味不明)

---

### **確認3: 日付ごとの件数**

```sql
SELECT LEFT(race_shikonen, 6) AS date, COUNT(*) AS count 
FROM jrd_bac 
GROUP BY LEFT(race_shikonen, 6) 
ORDER BY date DESC;
```

**結果** (一部抜粋):
```
  date  | count
--------+-------
 262211 |     1
 262112 |     1
 262111 |     1
 261b12 |     1   ← 16進数？
 261b11 |     1   ← 16進数？
 261a01 |     1   ← 16進数？
 261912 |     1
 261301 |     1
 261201 |     1
 261101 |     1
```

❌ **判定**: 日付フォーマットが完全に崩れている

---

## 🔍 根本原因の分析

### **問題の原因**

PC-KEIBA が **JRDB の BAC ファイルのレイアウト定義を間違えて読み込んでいる** 可能性が高い。

**JRDB BAC ファイルの構造** (仕様書第11版):

| 項目 | バイト位置 | 長さ | 内容 |
|------|-----------|------|------|
| 場コード | 1-2 | 2 | 競馬場コード |
| **年** | 3-4 | 2 | 西暦下2桁 (例: "26") |
| **回** | 5 | 1 | 開催回数 |
| **日** | 6 | 1 | 開催日次（16進数） |
| R | 7-8 | 2 | レース番号 |

**正しい `race_shikonen` の生成方法**:
- 年月日6桁 (yyMMdd) = BAC ファイルの別フィールドから取得
- または、レースキーの年(2) + 月日(4) を組み合わせる

**PC-KEIBA が行っている誤った読み込み**:
- DataSettings.xml の `start` 位置が間違っている
- または、10桁全てを読み込んでしまっている

---

## 🔧 解決策

### **Option A: DataSettings.xml の修正（推奨）**

DataSettings.xml の BAC ファイル定義を修正する必要があります。

**現在の定義** (推測):
```xml
<column name="race_shikonen" start="3" length="10" />
```

**正しい定義** (要確認):
```xml
<!-- BAC ファイルには年月日フィールドが別にある可能性 -->
<column name="race_shikonen" start="XX" length="6" />
```

**修正手順**:
1. `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml` を開く
2. BAC ファイルの `race_shikonen` 定義を確認
3. `start` 位置と `length` を修正
4. `jrd_bac` テーブルを削除
5. PC-KEIBA で再登録

---

### **Option B: PC-KEIBA 公式 DataSettings.xml の再取得（最も確実）**

**手順**:
1. [PC-KEIBA 公式サイト](https://pc-keiba.com/wp/gaibu-data/) にログイン
2. 最新の JRDB 用 DataSettings.xml をダウンロード
3. `E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml` を上書き
4. `jrd_bac` テーブルを削除
5. PC-KEIBA で再登録

---

### **Option C: 手動でデータを修正（非推奨、一時的な対策）**

SQL で `race_shikonen` の値を修正することも可能ですが、根本原因を解決していないため、次回の登録で同じ問題が再発します。

---

## 📌 現在の状況まとめ

### **達成したこと**
1. ✅ jrd_bac テーブルの `race_shikonen` カラムを 2桁 → 10桁に修正
2. ✅ jrd_bac.sql ファイルを修正し、テーブルを再作成
3. ✅ PC-KEIBA でデータ登録を実行（110件）

### **未解決の問題**
1. ❌ `race_shikonen` の値が間違ったフォーマットで登録されている
2. ❌ DataSettings.xml の BAC ファイル定義が間違っている可能性

### **Phase 6 への影響**
- Phase 6 の予測スクリプトは `race_shikonen LIKE '260221%'` のような条件でデータを抽出します
- 現在の `race_shikonen` の値 (`2621112026` など) では、日付フィルタリングが **完全に機能しません**
- **Phase 6 を開始する前に、この問題を解決する必要があります**

---

## 🎯 推奨される次のステップ

### **優先度1: DataSettings.xml の確認**

```powershell
# BAC ファイルの race_shikonen 定義を確認
Get-Content "E:\anonymous-keiba-ai-JRA\data\jrdb\config\DataSettings.xml" | Select-String -Pattern "race_shikonen" -Context 5
```

### **優先度2: PC-KEIBA 公式 DataSettings.xml の再取得**

最も確実な解決策は、PC-KEIBA 公式サイトから最新の DataSettings.xml をダウンロードすることです。

### **優先度3: BAC ファイルの実データを確認**

```powershell
# BAC ファイルを解凍して中身を確認
cd E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly\
# （lzh 解凍ツールで BAC260221.txt を取り出す）
# 先頭100バイトを16進ダンプで確認
```

---

## 📚 参考情報

### **JRDB 仕様書 (第11版)**
- BAC ファイルのレースキー構造:
  - 場コード (2) + 年 (2) + 回 (1) + 日 (1) + R (2) = 8桁
  - 年月日6桁フィールドは別に存在する可能性

### **関連ドキュメント**
- `JRDB_COMPLETE_SETUP_GUIDE.md`
- `JRDB_RACE_SHIKONEN_PROBLEM_ROOT_CAUSE_AND_SOLUTION.md`
- `JRDB_FIX_SUMMARY_FOR_USER.md`

---

## ⚠️ 重要な注意

この問題は、**以前に修正した「2桁問題」とは別の問題** です。

- **以前の問題**: `race_shikonen` が 2桁 (`"26"`) しか格納されなかった
  - **原因**: SQL ファイルの型定義が `character varying(2)` だった
  - **解決**: `character varying(10)` に修正

- **現在の問題**: `race_shikonen` は 10桁格納されているが、**値が間違っている**
  - **原因**: DataSettings.xml の読み込み位置が間違っている
  - **解決**: DataSettings.xml を修正するか、公式版を再取得

---

**作成者**: GenSpark AI Assistant  
**最終更新**: 2026年2月28日  
**ステータス**: 🔴 **未解決 - DataSettings.xml の修正が必要**
