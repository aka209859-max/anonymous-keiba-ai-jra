# Phase 7-A 充填率確認 実行ガイド
**作成日**: 2026-03-03

---

## ✅ 修正完了

構文エラーを修正しました。以下の2つのファイルが使用可能です：

### 📁 生成ファイル

| ファイル | サイズ | 対象 | 実行時間 |
|---------|--------|------|---------|
| **PHASE7A_FILLRATE_BATCH_TEST_FIXED.sql** | 106 KB | 主要5テーブル, 450カラム | 約1分 |
| **PHASE7A_ALL_1939_COLUMNS_FILLRATE_BATCH_FIXED.sql** | 457 KB | 全43テーブル, 1,939カラム | 5-10分 |

---

## 🎯 実行手順

### ステップ1: テスト版で動作確認（推奨）

1. pgAdmin4を開く
2. ファイルを開く: `/home/user/webapp/docs/PHASE7A_FILLRATE_BATCH_TEST_FIXED.sql`
3. 全選択（Ctrl+A）
4. 実行（F5）
5. 結果が表示されることを確認（450行）

**期待される結果**:
```
table_name | column_name | total_rows | filled_count | fillrate
-----------+-------------+------------+--------------+---------
jrd_kyi    | agari_shisu | 4828       | 4828         | 100.00
jrd_kyi    | bamei       | 4828       | 4828         | 100.00
...
```

---

### ステップ2: 本番版を実行

1. ファイルを開く: `/home/user/webapp/docs/PHASE7A_ALL_1939_COLUMNS_FILLRATE_BATCH_FIXED.sql`
2. 全選択（Ctrl+A）
3. 実行（F5）【5-10分かかります。完了まで待機してください】
4. 実行完了後、結果ペインで右クリック
5. **"Export"** または **"Copy"** を選択
6. Export の場合:
   - ファイル形式: CSV
   - ファイル名: `all_1939_columns_fillrate_complete.csv`
   - ヘッダー: チェック（✓）
   - 保存
7. Copy の場合:
   - "Copy as CSV (with headers)" を選択
   - テキストエディタに貼り付け
   - 保存: `all_1939_columns_fillrate_complete.csv`

---

### ステップ3: CSVをアップロード

このチャットに `all_1939_columns_fillrate_complete.csv` をアップロードしてください。

---

## 📊 出力形式

### 期待されるCSV形式

```csv
table_name,column_name,total_rows,filled_count,fillrate
jrd_bac,baken_hatsubai_flag,110,110,100.00
jrd_bac,course_kubun,110,110,100.00
jrd_bac,data_kubun,110,110,100.00
...
jvd_se,umaban,739040,739040,100.00
jvd_se,wakuban,739040,739040,100.00
...
```

**総行数**: 1,939行（全カラム分）

---

## 🔍 トラブルシューティング

### エラー: "syntax error at end of input"
→ 修正版SQLを使用してください（_FIXED.sql）

### エラー: "column does not exist"
→ テーブル名を確認してください

### 実行が長すぎる（10分以上）
→ 中断（Ctrl+C）して、テスト版で動作確認してください

### メモリエラー
→ pgAdmin4を再起動して、再度実行してください

---

## 📋 次のステップ

CSVアップロード後の処理：

1. ✅ 充填率データと日本語説明を結合
2. ✅ 充填率 ≥ 80%のカラムを抽出
3. ✅ 既存81カラム + 追加120-140カラム = 200-220カラムを選定
4. ✅ Phase 7使用カラムリスト作成
5. ✅ 新マージCSV生成SQL作成

---

**準備完了です！pgAdmin4で実行してください。**
