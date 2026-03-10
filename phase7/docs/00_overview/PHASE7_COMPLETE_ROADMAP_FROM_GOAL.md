# Phase 7 完全ロードマップ（ゴールから逆算）

**作成日**: 2026-03-09  
**目的**: ゴールから逆算して現在地を明確化

---

## 🎯 **最終ゴール（Phase 7 完了時点）**

### **達成すべき3つの目標**

| 目標 | 数値 | 意味 |
|---|---|---|
| **年間ROI** | **≥ 105%** | 100万円賭けたら105万円以上戻ってくる |
| **シャープレシオ** | **≥ 1.5** | 安定して儲かる（リスクが低い） |
| **最大ドローダウン** | **< 30%** | 最大損失が30%未満 |

### **最終成果物**

1. **Phase 7 最適モデル** (LightGBM + Benter)
   - 入力: 最適化された200-220カラム
   - 出力: 単勝予測確率 + 購入推奨
   - ファイル: `phase7/models/phase7_final_model.pkl`

2. **Phase 7 最終レポート**
   - バックテスト結果（2025年）
   - ROI達成率: 105-120%
   - ファイル: `phase7/docs/PHASE7_FINAL_REPORT.md`

3. **Phase 7 運用スクリプト**
   - 毎日の予測実行
   - ファイル: `phase7/scripts/phase7_daily_prediction.py`

---

## 📅 **Phase 7 全体スケジュール（15週間）**

```
Week 1  : Phase 7-A (特徴量拡張)           ← ✅ 今ここ（完了）
Week 2  : Phase 7-B (単一カラムROI分析)    ← 🔜 次のフェーズ
Week 3  : Phase 7-C (2カラム組み合わせ)
Week 4  : Phase 7-D (3カラム組み合わせGA)
Week 5-6: Phase 7-E (4-5カラムビームサーチ)
Week 7-8: Phase 7-F (LightGBMモデル構築)
Week 9  : Phase 7-G (Benterモデル統合)
Week 10 : Phase 7-H (バックテスト2025年)
Week 11 : Phase 7-I (ハイパーパラメータ最適化)
Week 12 : Phase 7-J (アンサンブル最適化)
Week 13 : Phase 7-K (最終検証)
Week 14 : Phase 7-L (運用準備)
Week 15 : Phase 7-M (本番運用開始)
```

---

## 🔄 **ゴールから逆算したフロー**

### **Phase 7-M（Week 15）→ 本番運用**
↑
### **Phase 7-L（Week 14）→ 運用準備**
- 毎日の予測スクリプト作成
- エラーハンドリング実装
- ログ記録システム構築
↑
### **Phase 7-K（Week 13）→ 最終検証**
- 2025年全データでバックテスト
- ROI ≥ 105%達成確認
- シャープレシオ ≥ 1.5確認
↑
### **Phase 7-J（Week 12）→ アンサンブル最適化**
- LightGBM 70% + Benter 30%の最適比率決定
- 信頼区間計算
↑
### **Phase 7-I（Week 11）→ ハイパーパラメータ最適化**
- Optuna使用
- 学習率、木の深さ、正則化パラメータ調整
↑
### **Phase 7-H（Week 10）→ バックテスト**
- 2025年データで検証
- 月別ROI計算
- 馬場状態別ROI計算
↑
### **Phase 7-G（Week 9）→ Benterモデル統合**
- 市場オッズとの組み合わせ
- Benterモデルで過信を補正
↑
### **Phase 7-F（Week 7-8）→ LightGBMモデル構築**
- 入力: Phase 7-Eで選定した200-220カラム
- カスタム損失関数: -（勝率 × オッズ - 1）
- 出力: 単勝予測確率
↑
### **Phase 7-E（Week 5-6）→ 4-5カラム組み合わせ（ビームサーチ）**
- Phase 7-Dのトップ50から拡張
- ビーム幅100で探索
- ROI ≥ 115%の組み合わせ選定
↑
### **Phase 7-D（Week 4）→ 3カラム組み合わせ（GA）**
- Phase 7-Cのトップ100から拡張
- 遺伝的アルゴリズムで探索（約170万通り）
- ROI ≥ 112%の組み合わせ選定
↑
### **Phase 7-C（Week 3）→ 2カラム組み合わせ**
- Phase 7-Bのトップ30 × 30 = 900通り
- 全組み合わせ総当たり
- ROI ≥ 110%の組み合わせ選定
↑
### **Phase 7-B（Week 2）→ 単一カラムROI分析** ← 🔜 次のフェーズ
- 334カラム全てを1つずつテスト
- ROI計算: （的中金額 / 購入金額）× 100
- トップ100カラム選定（ROI ≥ 105%）
↑
### **Phase 7-A（Week 1）→ 特徴量拡張** ← ✅ 今ここ（完了）
- Phase 6: 148カラム → Phase 7-A: 334カラム
- JRA-VAN: 97 → 218（+121）
- JRDB: 48 → 116（+68）
- データ期間: 2016-2025年（460,424行）
- 充填率: 100%

---

## 📍 **現在地: Phase 7-A 完了**

### **✅ Phase 7-A で完了したこと**

#### **Day 1-2: データ基盤構築**
- [x] JRDBデータベース再登録（18テーブル、4,193,206行）
- [x] CSVインポートエラー修正（カラムずれ解消）
- [x] 確定レース抽出（2016-2025年、460,424行）
- [x] 充填率100%達成確認

#### **Day 3-7: 特徴量選定**
- [x] 334カラム選定（JRA-VAN 218 + JRDB 116）
- [x] 334カラム詳細リスト作成
- [x] Phase 6（148カラム）からの拡張確認（+186）

### **成果物**

| ファイル名 | 内容 | 状態 |
|---|---|---|
| `PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv` | 334カラム定義 | ✅ 完了 |
| `JRDB_REREGISTRATION_SUCCESS_REPORT.md` | JRDB再登録成功レポート | ✅ 完了 |
| `PHASE7A_334_COLUMNS_DETAIL.md` | 334カラム詳細 | ✅ 完了 |
| `PHASE7A_CURRENT_STATUS_FINAL.md` | Phase 7-A完了レポート | ✅ 完了 |

### **データ準備状況**

| 項目 | 数値 | 状態 |
|---|---|---|
| 確定レース行数 | 460,424行 | ✅ |
| JRA-VANカラム | 218個 | ✅ |
| JRDBカラム | 116個 | ✅ |
| 総カラム数 | 334個 | ✅ |
| 充填率 | 100% | ✅ |
| データ期間 | 2016-2025年 | ✅ |

---

## 🔜 **次のフェーズ: Phase 7-B（Week 2）**

### **Phase 7-B の目的**

**334カラムの中から「儲かるカラム」トップ100を見つける**

### **Phase 7-B の作業内容（Day 8-14）**

#### **Day 8-10: 単一カラムROI分析**

**やること**:
1. JRA-VAN + JRDB 統合データセット作成
   - 334カラム × 460,424行
   - CSV保存: `jravan_jrdb_merged_334cols.csv`

2. 334カラムを1つずつテスト
   - カラムAだけで予測 → ROI計算
   - カラムBだけで予測 → ROI計算
   - ... （334回繰り返す）

3. ROIランキング作成
   - 1位 ~ 334位まで順位付け
   - CSV保存: `phase7b_single_column_roi_ranking.csv`

**ROI計算方法**:
```
例: カラム「agari_shisu」（上がり指数）でテスト

1. 上がり指数が高い馬トップ3に賭ける
2. 的中金額 / 購入金額 = ROI
3. 全レース（460,424行）で平均ROI計算

ROI = 108% なら「100円賭けて108円戻る」
```

**期待結果**:
- トップ100カラムのROI: 105-120%
- 334位のROI: 80-90%

#### **Day 11-12: トップ100カラム選定**

**選定基準**:
- ROI ≥ 105%
- 的中率 ≥ 20%
- サンプル数 ≥ 1,000レース

**成果物**:
- `phase7b_top100_columns.csv`

#### **Day 13-14: 2カラム組み合わせ準備**

**やること**:
- トップ30カラムを選定
- Phase 7-C（Week 3）の準備

---

## 📊 **Phase 7-B の具体的な実装手順**

### **ステップ1: 統合データセット作成**

**PowerShell スクリプト**:
```powershell
# PostgreSQLからデータ抽出
cd E:\anonymous-keiba-ai-JRA\phase7\scripts\phase7b

# Python スクリプト実行
python create_merged_dataset_334cols.py
```

**Python スクリプト内容（サンプル）**:
```python
import psycopg2
import pandas as pd

# PostgreSQL接続
conn = psycopg2.connect(
    host="127.0.0.1",
    port=5432,
    database="pckeiba",
    user="postgres",
    password="postgres123"
)

# 334カラム統合クエリ
query = """
SELECT 
    -- JRA-VAN 218カラム
    jvd_se.*,
    jvd_ra.*,
    -- JRDB 116カラム
    jrd_kyi.*,
    jrd_cyb.*,
    jrd_sed.*,
    jrd_joa.*,
    jrd_bac.*
FROM jvd_se
LEFT JOIN jvd_ra USING (race_id)
LEFT JOIN jrd_kyi USING (race_id, umaban)
LEFT JOIN jrd_cyb USING (race_id, umaban)
LEFT JOIN jrd_sed USING (race_id, umaban)
LEFT JOIN jrd_joa USING (race_id, umaban)
LEFT JOIN jrd_bac USING (race_id)
WHERE jrd_kyi.race_shikonen ~ '^[0-9]+$'
  AND CAST(jrd_kyi.race_shikonen AS INTEGER) < 260201
"""

# データ抽出
df = pd.read_sql(query, conn)
print(f"抽出行数: {len(df)}")
print(f"カラム数: {len(df.columns)}")

# CSV保存
output_path = "E:/anonymous-keiba-ai-JRA/phase7/results/phase7b_roi/jravan_jrdb_merged_334cols.csv"
df.to_csv(output_path, index=False, encoding='utf-8-sig')
print(f"保存完了: {output_path}")

conn.close()
```

**期待結果**:
```
抽出行数: 460424
カラム数: 334
保存完了: E:/anonymous-keiba-ai-JRA/phase7/results/phase7b_roi/jravan_jrdb_merged_334cols.csv
```

---

### **ステップ2: 単一カラムROI分析**

**Python スクリプト**:
```python
# phase7/scripts/phase7b/single_column_roi_analysis.py
import pandas as pd
import numpy as np

# 統合データ読み込み
df = pd.read_csv("jravan_jrdb_merged_334cols.csv")

# ROI計算関数
def calculate_roi(df, column_name):
    # カラムの値が高いトップ3を選ぶ
    df_sorted = df.sort_values(by=column_name, ascending=False)
    df_top3 = df_sorted.groupby('race_id').head(3)
    
    # 的中金額計算
    winning_amount = df_top3[df_top3['chakujun'] <= 3]['tansho_haraimodoshi'].sum()
    
    # 購入金額計算
    total_bet = len(df_top3) * 100  # 1頭100円
    
    # ROI計算
    roi = (winning_amount / total_bet) * 100
    
    return roi

# 334カラム全てでROI計算
roi_results = []
for col in df.columns:
    if col in ['race_id', 'umaban', 'chakujun', 'tansho_haraimodoshi']:
        continue  # 除外カラム
    
    try:
        roi = calculate_roi(df, col)
        roi_results.append({
            'column_name': col,
            'roi': roi
        })
        print(f"{col}: ROI = {roi:.2f}%")
    except:
        pass

# ランキング作成
df_roi = pd.DataFrame(roi_results)
df_roi = df_roi.sort_values(by='roi', ascending=False)
df_roi.to_csv("phase7b_single_column_roi_ranking.csv", index=False)

print(f"\nトップ10カラム:")
print(df_roi.head(10))
```

**期待結果**:
```
column_name          | roi
---------------------|-------
agari_shisu          | 118.5%
sogo_shisu           | 115.2%
idm                  | 112.8%
ten_shisu            | 110.3%
pace_shisu           | 108.7%
...
```

---

### **ステップ3: トップ100カラム選定**

**Python スクリプト**:
```python
# トップ100カラム選定
df_roi = pd.read_csv("phase7b_single_column_roi_ranking.csv")

# ROI ≥ 105%の条件
df_top100 = df_roi[df_roi['roi'] >= 105.0].head(100)

# 保存
df_top100.to_csv("phase7b_top100_columns.csv", index=False)

print(f"トップ100カラム選定完了: {len(df_top100)}カラム")
print(f"平均ROI: {df_top100['roi'].mean():.2f}%")
```

---

## 📋 **Phase 7 全体の進捗状況**

### **進捗バー**

```
Phase 7-A: ████████████████████ 100% ✅ 完了
Phase 7-B: ░░░░░░░░░░░░░░░░░░░░   0% ← 次のフェーズ
Phase 7-C: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-D: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-E: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-F: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-G: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-H: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-I: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-J: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-K: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-L: ░░░░░░░░░░░░░░░░░░░░   0%
Phase 7-M: ░░░░░░░░░░░░░░░░░░░░   0%

全体進捗: 7% (1/15週完了)
```

---

## 🎯 **マイルストーン**

| フェーズ | 週 | 主要成果物 | 目標ROI | 状態 |
|---|---|---|---|---|
| Phase 7-A | Week 1 | 334カラム選定 | - | ✅ 完了 |
| Phase 7-B | Week 2 | トップ100カラム | ≥ 105% | 🔜 次 |
| Phase 7-C | Week 3 | 2カラム組み合わせ | ≥ 110% | ⏳ 待機 |
| Phase 7-D | Week 4 | 3カラム組み合わせ | ≥ 112% | ⏳ 待機 |
| Phase 7-E | Week 5-6 | 4-5カラム組み合わせ | ≥ 115% | ⏳ 待機 |
| Phase 7-F | Week 7-8 | LightGBMモデル | ≥ 118% | ⏳ 待機 |
| Phase 7-G | Week 9 | Benterモデル統合 | ≥ 105% | ⏳ 待機 |
| Phase 7-H | Week 10 | バックテスト | ≥ 105% | ⏳ 待機 |
| Phase 7-I | Week 11 | ハイパラ最適化 | ≥ 105% | ⏳ 待機 |
| Phase 7-J | Week 12 | アンサンブル最適化 | ≥ 105% | ⏳ 待機 |
| Phase 7-K | Week 13 | 最終検証 | ≥ 105% | ⏳ 待機 |
| Phase 7-L | Week 14 | 運用準備 | - | ⏳ 待機 |
| Phase 7-M | Week 15 | 本番運用開始 | ≥ 105% | ⏳ 待機 |

---

## 📝 **次のアクション（Phase 7-B Week 2）**

### **最優先タスク**

1. **統合データセット作成**
   - スクリプト: `phase7/scripts/phase7b/create_merged_dataset_334cols.py`
   - 出力: `jravan_jrdb_merged_334cols.csv`（460,424行 × 334カラム）

2. **単一カラムROI分析実行**
   - スクリプト: `phase7/scripts/phase7b/single_column_roi_analysis.py`
   - 出力: `phase7b_single_column_roi_ranking.csv`

3. **トップ100カラム選定**
   - 出力: `phase7b_top100_columns.csv`

### **所要時間見積もり**

| タスク | 所要時間 | 備考 |
|---|---|---|
| 統合データセット作成 | 30分 | PostgreSQL抽出 + CSV保存 |
| 単一カラムROI分析 | 2-3時間 | 334カラム × 460,424行の計算 |
| トップ100カラム選定 | 10分 | ランキングから抽出 |
| **合計** | **3-4時間** | - |

---

## ✅ **Phase 7-A 完了チェックリスト**

### **データ基盤構築**
- [x] JRDBデータベース登録完了
- [x] CSVエラー修正完了
- [x] 確定レース抽出完了
- [x] 充填率100%達成

### **特徴量選定**
- [x] 334カラム選定完了
- [x] 334カラム詳細リスト作成
- [x] Phase 6からの拡張確認

### **ドキュメント作成**
- [x] JRDB再登録成功レポート
- [x] 334カラム詳細レポート
- [x] Phase 7-A完了レポート
- [x] 334カラム定義CSV

### **GitHub コミット**
- [x] 全ドキュメントコミット完了
- [x] ブランチ: `genspark_ai_developer`
- [x] コミット数: 5個

---

## 🔗 **関連ドキュメント**

### **Phase 7-A 成果物**
- `phase7/results/phase7a_features/JRDB_REREGISTRATION_SUCCESS_REPORT.md`
- `phase7/results/phase7a_features/PHASE7A_334_COLUMNS_DETAIL.md`
- `phase7/results/phase7a_features/PHASE7A_CURRENT_STATUS_FINAL.md`
- `docs/PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv`

### **Phase 7 全体計画**
- `phase7/README.md`
- `phase7/docs/01_workflow/PHASE7_WORKFLOW.md`
- `phase7/docs/02_roadmap/PHASE7_ROADMAP.md`

### **HubFiles**
- `INTEGRATED_FEATURE_SPECIFICATION_FINAL (1).md` (Phase 6仕様)
- `START_NEW_SESSION.md` (開発フロー)

---

## 📊 **ゴールまでの距離**

```
現在地: Phase 7-A 完了 (Week 1/15)
ゴール: Phase 7-M 本番運用 (Week 15/15)

残り: 14週間
進捗: 7%

次のマイルストーン: Phase 7-B 完了 (Week 2)
目標ROI: ≥ 105%
```

---

**作成者**: AI Assistant  
**最終更新**: 2026-03-09  
**ステータス**: ✅ Phase 7-A 完了、Phase 7-B 準備完了  
**次のアクション**: Phase 7-B Week 2 開始（統合データセット作成）
