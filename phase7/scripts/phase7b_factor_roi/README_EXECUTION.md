# Phase 7-B 統合データセット作成 実行手順

**作成日**: 2026-03-09  
**目的**: JRA-VAN + JRDB 334カラム統合データセット作成

---

## 📋 実行手順

### **PowerShell で実行**

```powershell
# 1. ディレクトリ移動
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b

# 2. Python スクリプト実行
python create_merged_dataset_334cols.py
```

---

## ⏱️ 予想実行時間

| 処理 | 所要時間 |
|---|---|
| PostgreSQL接続 | 1秒 |
| データ抽出（460,424行） | 5-10分 |
| CSV保存 | 1-2分 |
| **合計** | **約10-15分** |

---

## 📊 期待結果

### **コンソール出力例**

```
================================================================================
Phase 7-B: JRA-VAN + JRDB 統合データセット作成
================================================================================
実行日時: 2026-03-09 14:30:00

✅ PostgreSQL接続成功: pckeiba

📊 統合データセット作成開始...
📥 データ抽出中...
✅ データ抽出完了
  - 行数: 460,424 行
  - カラム数: 68 カラム

📊 基本統計:
  - 期間: 20160105 ～ 20251228
  - レース数: 58,234 レース
  - 競馬場数: 10 場

✅ 欠損値なし

💾 CSV保存中: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
✅ CSV保存完了
  - ファイルサイズ: 125.50 MB
  - パス: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv

================================================================================
✅ Phase 7-B 統合データセット作成完了
================================================================================
📁 出力ファイル: E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
📊 行数: 460,424 行
📊 カラム数: 68 カラム

🔜 次のステップ: 単一カラムROI分析

✅ PostgreSQL接続クローズ
```

---

## 📁 出力ファイル

| 項目 | 値 |
|---|---|
| **ファイル名** | `jravan_jrdb_merged_334cols_2016_2025.csv` |
| **保存先** | `E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\` |
| **行数** | 460,424 行 |
| **カラム数** | 68 カラム（簡易版、本番は334） |
| **ファイルサイズ** | 約125 MB |
| **データ期間** | 2016年1月 ～ 2025年12月 |

---

## ⚠️ 注意事項

### **カラム数について**

**現在のスクリプト**: 68カラム（主要カラムのみ抜粋）

**理由**:
- 334カラム全てを手動で列挙すると非常に長大になる
- まずは主要カラムで動作確認

**本番対応**:
1. `PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv` から334カラムリストを読み込む
2. 動的にSELECT文を生成
3. 334カラム全てを抽出

---

## 🔧 エラー対応

### **エラー1: PostgreSQL接続失敗**

```
❌ PostgreSQL接続失敗: password authentication failed
```

**対応**:
- パスワード確認: `postgres123`
- PostgreSQL起動確認

---

### **エラー2: テーブルが見つからない**

```
❌ データ抽出失敗: relation "jvd_se" does not exist
```

**対応**:
- テーブル名確認
- スキーマ確認（public.jvd_se など）

---

### **エラー3: メモリ不足**

```
❌ MemoryError: Unable to allocate array
```

**対応**:
- チャンクごとに読み込む（`chunksize=10000`）
- 不要なカラムを除外

---

## 🔜 次のステップ

### **統合データセット作成完了後**

1. **単一カラムROI分析スクリプト作成**
   - ファイル: `single_column_roi_analysis.py`
   - 処理: 68カラム（または334カラム）を1つずつテスト

2. **ROIランキング作成**
   - 出力: `phase7b_single_column_roi_ranking.csv`
   - 内容: カラム名、ROI、的中率、サンプル数

3. **トップ100カラム選定**
   - 出力: `phase7b_top100_columns.csv`
   - 条件: ROI ≥ 105%

---

## 📝 実行後の報告フォーマット

### **成功時**

```
✅ 統合データセット作成完了

📊 結果:
  - 行数: XXX,XXX 行
  - カラム数: XXX カラム
  - ファイルサイズ: XXX MB
  - 欠損値: なし（または詳細）

📁 出力ファイル:
  E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv

🔜 次: 単一カラムROI分析スクリプト作成
```

### **失敗時**

```
❌ 統合データセット作成失敗

🔴 エラー内容:
  [エラーメッセージ]

📋 対応:
  [対応手順]
```

---

**作成者**: AI Assistant  
**最終更新**: 2026-03-09  
**次のアクション**: PowerShell でスクリプト実行
