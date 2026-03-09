# 🚀 Phase 6 予測実行 クイックスタート

## 📋 5分でできる予測実行

### 対象日: 2026-02-22 (土曜) / 2026-02-23 (日曜)

---

## ⚡ 最速実行手順 (3ステップ)

### 1️⃣ PostgreSQL データ確認 (1分)

```powershell
# psql で確認
psql -U postgres -d pckeiba -c "SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260222%';"
```

**期待値**: 150～200 件

**もし 0 件の場合**:
```
PC-KEIBA → データ → 外部データ登録
→ KYI/CYB/JOA/SED (2026-02-21, 02-22) をダウンロード
→ 「開始」ボタン
```

---

### 2️⃣ Phase 6 予測実行 (2分)

```powershell
# PowerShellを開く
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

# 土曜日の予測
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222

# 日曜日の予測
python scripts/phase6/phase6_daily_prediction.py --target-date 20260223
```

---

### 3️⃣ 結果確認 (1分)

```powershell
# 予測結果を開く
notepad results\predictions_20260222.md
notepad results\predictions_20260223.md
```

---

## 📊 予測結果の見方

### レポート形式 (例)

```markdown
### 01: 中山 - 第1R (芝1200m)

順位 | 馬番 | 馬名       | 総合スコア | ランク
-----|-----|-----------|----------|-------
1    | 3   | ○○○○      | 0.85     | S
2    | 7   | △△△△      | 0.72     | A
3    | 5   | ×××××     | 0.68     | B
```

### ランク意味

| ランク | 評価 | 総合スコア |
|:------|:----|:---------|
| **S** | 最有力 | 0.80 ～ 1.00 |
| **A** | 有力 | 0.70 ～ 0.79 |
| **B** | 対抗 | 0.60 ～ 0.69 |
| **C** | 穴馬 | 0.50 ～ 0.59 |

---

## 🔧 よくあるエラーと対処法

### エラー1: `could not connect to server`

```powershell
# PC-KEIBAを起動すれば解決
# PostgreSQLの起動確認:
psql -U postgres -d pckeiba -c "SELECT version();"
```

---

### エラー2: `ModuleNotFoundError: lightgbm`

```powershell
# 仮想環境で必要パッケージをインストール
.\venv\Scripts\Activate.ps1
pip install lightgbm pandas psycopg2-binary pyyaml numpy scikit-learn
```

---

### エラー3: `データが見つかりません`

**原因**: JRDBデータが未登録

**対処**:
1. PC-KEIBA → データ → 外部データ登録
2. KYI/CYB/JOA/SED の4ファイルをダウンロード
3. 「開始」ボタンで登録 (3-5分)

---

### エラー4: `FileNotFoundError: models/jra_binary_model.txt`

**原因**: モデルファイルが存在しない

**対処**:
```powershell
# モデルファイルの確認
ls models\

# ない場合は Phase 3～5 を実行してモデル生成
python scripts/phase3/train_binary_model.py
python scripts/phase4a/train_ranking_model.py
python scripts/phase4b/train_regression_model_optimized.py
```

---

## ✅ 実行前チェックリスト

- [ ] PC-KEIBA 起動済み
- [ ] PostgreSQL 動作中
- [ ] JRDB データ登録済み (KYI/CYB/JOA/SED)
- [ ] Python仮想環境アクティベート済み
- [ ] models/ フォルダにモデルファイル3つ存在

---

## 📝 実行ログ例

```
[INFO] Phase 6 当日予測システム開始
[INFO] 対象日: 2026-02-22
[INFO] データベース接続: OK
[INFO] モデル読み込み: OK
[INFO] JRA-VAN データ取得: 36レース, 432頭
[INFO] JRDB データ結合: マッチ率 95.3%
[INFO] 特徴量生成: 145列
[INFO] Phase 3 予測: 完了
[INFO] Phase 4-A 予測: 完了
[INFO] Phase 4-B 予測: 完了
[INFO] Phase 5 アンサンブル: 完了
[INFO] レポート生成: results/predictions_20260222.md
[INFO] 予測完了 (所要時間: 2分13秒)
```

---

## 🎯 次のアクション

1. **予測結果を確認**: 各レースのSランク・Aランク馬をチェック
2. **実際の結果と比較**: レース終了後、的中率を確認
3. **週次運用**: 毎週金曜夜～土曜朝に同じ手順を繰り返す

---

## 📞 サポート

詳細な手順は以下を参照:
- `PHASE6_EXECUTION_GUIDE_20260222.md` - 詳細実行ガイド
- `scripts/phase6/README_PHASE6.md` - Phase 6仕様書
- `PHASE6_WEEKLY_OPERATION_FINAL.md` - 週次運用フロー

---

**作成日**: 2026-02-23  
**所要時間**: 約5分 (データ確認済みの場合)  
**対象**: 2026-02-22/23 予測実行
