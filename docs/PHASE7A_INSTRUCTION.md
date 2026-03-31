# Phase 7-A: 全1,939カラムリスト取得指示

## 🎯 目的
全43テーブル（JRA-VAN 38 + JRDB 5）の**全1,939カラム**のカラム名・データ型を取得し、使用可否を判断する。

---

## 📋 実行手順

### Step 1: SQLを実行
以下のSQLをpgAdmin4で実行してください：

```sql
SELECT 
    table_name,
    ordinal_position,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
  AND (table_name LIKE 'jvd_%' OR table_name LIKE 'jrd_%')
ORDER BY 
    table_name,
    ordinal_position;
```

### Step 2: CSVエクスポート
実行結果を以下のファイル名でエクスポートしてください：
- **ファイル名**: `all_1939_columns_list.csv`

### Step 3: 確認事項
エクスポートしたCSVで以下を確認：
- ✅ 総行数が約1,939行か
- ✅ 各テーブルのカラム数が合計1,939になるか
- ✅ カラム名・データ型が正しく取得されているか

---

## 📊 期待される結果サンプル

| table_name | ordinal_position | column_name | data_type | character_maximum_length |
|------------|------------------|-------------|-----------|-------------------------|
| jrd_bac | 1 | keibajo_code | character varying | - |
| jrd_bac | 2 | race_shikonen | character varying | - |
| ... | ... | ... | ... | ... |
| jvd_tk | 336 | yobi_10 | character varying | - |

---

## ⏭️ 次のステップ
CSVを取得したら報告してください。次は以下を実行します：

1. 全1,939カラムを整理（テーブルごと、カラム名の意味を推定）
2. 各テーブルの2016～2025年レコード数確認
3. 充填率80%以上のカラムを選定
4. 200～220カラムに絞り込み
5. データ抽出スクリプト作成

---

**すぐに実行してください！**
