# Phase 4 スクリプト監査レポート

**作成日時**: 2026-02-27  
**目的**: ユーザーPC上のPhase 4スクリプトを全て確認し、rank 0問題のチェック、必要/不要の分類を実施

---

## 📋 監査対象スクリプト（5ファイル）

### 1️⃣ **train_ranking_model.py**（本番用ランキングモデル）
- **目的**: 2016-2025全データで学習、本番予測用
- **学習期間**: 2016-2023訓練、2024検証、2025テスト
- **出力**: `models/jra_ranking_model.txt`

### 2️⃣ **train_ranking_model_eval.py**（評価用ランキングモデル）
- **目的**: 2016-2024データで学習、2025予測でキャリブレーション用
- **学習期間**: 2016-2023訓練、2024検証（2025年は学習に使用しない）
- **出力**: `models/jra_ranking_model_eval.txt`
- **作成日**: 2026-02-27（最新版、コミット 7776179）

### 3️⃣ **train_regression_model.py**（基本回帰モデル）
- **目的**: 走破タイム予測（LightGBM Regressor）
- **出力**: `models/jra_regression_model_eval.txt`, `models/jra_regression_model.txt`

### 4️⃣ **train_regression_model_optimized.py**（最適化回帰モデル）
- **目的**: Optunaでハイパーパラメータ最適化（RMSE < 5.0秒目標）
- **出力**: `models/jra_regression_model_optimized.txt`

### 5️⃣ **analyze_ranking_model.py**（ランキングモデル分析）
- **目的**: 特徴量重要度、予測例、NDCG分布の可視化
- **出力**: 分析レポート（CSV、TXT）

---

## 🔍 Rank 0 問題の監査結果

### ✅ **問題なし（既に修正済み）**

#### 1. train_ranking_model.py
```python
# 行46-55
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

# 着順の欠損値処理
missing_count = df['target'].isnull().sum()
if missing_count > 0:
    print(f"⚠️  着順欠損: {missing_count}行 → 除外")
    df = df.dropna(subset=['target'])

print(f"✅ 目的変数作成: 着順範囲 {df['target'].min():.0f} ~ {df['target'].max():.0f}")
```

**判定**: ✅ **NaNは除外されるが、rank 0は除外されない**
- `pd.to_numeric(..., errors='coerce')` により数値変換エラーは NaN に変換
- `.dropna(subset=['target'])` で NaN は除外
- **しかし、rank 0（取消・失格）は数値として残るため問題あり**

#### 2. train_ranking_model_eval.py
```python
# 行51-60（同様の処理）
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

missing_count = df['target'].isnull().sum()
if missing_count > 0:
    print(f"⚠️  着順欠損: {missing_count}行 → 除外")
    df = df.dropna(subset=['target'])

print(f"✅ 目的変数作成: 着順範囲 {df['target'].min():.0f} ~ {df['target'].max():.0f}")
```

**判定**: ✅ **NaNは除外されるが、rank 0は除外されない**

#### 3. train_regression_model.py
- **目的変数**: 走破タイム（`target_time_seconds`）
- **着順は使用しない**: 回帰モデルなので `kakutei_chakujun` は特徴量から除外されている
- **判定**: ✅ **rank 0問題には影響なし**

#### 4. train_regression_model_optimized.py
- **同上**
- **判定**: ✅ **rank 0問題には影響なし**

#### 5. analyze_ranking_model.py
- **目的**: 既存モデルの分析のみ
- **判定**: ✅ **rank 0問題には影響なし**

---

## 🚨 **重大な発見: Rank 0 がまだ除外されていない！**

### 問題の詳細

**ユーザーPC上の `train_ranking_model.py` と `train_ranking_model_eval.py` は古いバージョンです。**

- ❌ **GitHub最新版（コミット 7717c11）にはrank 0除外コードがある**
- ❌ **しかし、ユーザーがアップロードしたファイルには含まれていない**

### 期待されるコード（GitHubの最新版）

```python
# GitHub版（コミット 7717c11）には以下のコードが含まれる
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

# 🚨 着順0以下または欠損のデータを除外
original_count = len(df)
invalid_mask = (df['target'] <= 0) | (df['target'].isnull())
invalid_count = invalid_mask.sum()
if invalid_count > 0:
    logger.warning(f"   ⚠️  無効な着順データ: {invalid_count}行 ({invalid_count/original_count*100:.2f}%) → 除外")
    df = df[~invalid_mask].copy()
```

### ユーザーPC上のコード（古いバージョン）

```python
# ユーザーPC版（古い）には rank 0 除外コードがない
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

missing_count = df['target'].isnull().sum()
if missing_count > 0:
    print(f"⚠️  着順欠損: {missing_count}行 → 除外")
    df = df.dropna(subset=['target'])  # ← NaNのみ除外、rank 0は残る！
```

---

## 📊 必要/不要スクリプトの分類

### ✅ **必要なスクリプト（5ファイル全て必要）**

| スクリプト | 用途 | 優先度 | 備考 |
|------------|------|--------|------|
| `train_ranking_model.py` | **本番用ランキングモデル** | 🔴 高 | Phase 5アンサンブルで使用 |
| `train_ranking_model_eval.py` | **評価用ランキングモデル** | 🔴 高 | Phase 2-3キャリブレーションで使用 |
| `train_regression_model.py` | **基本回帰モデル** | 🟡 中 | 最適化版があるため優先度低め |
| `train_regression_model_optimized.py` | **最適化回帰モデル** | 🔴 高 | RMSE < 5.0秒達成版 |
| `analyze_ranking_model.py` | **ランキングモデル分析** | 🟢 低 | デバッグ・検証用 |

### 🗑️ **不要なスクリプト: なし**

- **全てのスクリプトが必要です！**
- 理由: 各スクリプトは異なる目的を持ち、ロードマップで使用される

---

## 🔧 必要な修正作業

### 🚨 **緊急修正: Rank 0 除外コードの追加**

#### 対象ファイル

1. `scripts/phase4/train_ranking_model.py`
2. `scripts/phase4/train_ranking_model_eval.py`

#### 修正内容

**修正前（現在のコード）**:

```python
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

missing_count = df['target'].isnull().sum()
if missing_count > 0:
    print(f"⚠️  着順欠損: {missing_count}行 → 除外")
    df = df.dropna(subset=['target'])

print(f"✅ 目的変数作成: 着順範囲 {df['target'].min():.0f} ~ {df['target'].max():.0f}")
```

**修正後（追加が必要）**:

```python
df['target'] = pd.to_numeric(df['kakutei_chakujun'], errors='coerce')

# 🚨 着順0以下または欠損のデータを除外
original_count = len(df)
invalid_mask = (df['target'] <= 0) | (df['target'].isnull())
invalid_count = invalid_mask.sum()
if invalid_count > 0:
    print(f"⚠️  無効な着順データ: {invalid_count}行 ({invalid_count/original_count*100:.2f}%) → 除外")
    df = df[~invalid_mask].copy()

print(f"✅ 目的変数作成: 着順範囲 {df['target'].min():.0f}位 ~ {df['target'].max():.0f}位")
```

---

## 📝 修正手順（推奨）

### オプション A: GitHubから最新版をダウンロード（推奨）

```powershell
# リポジトリルートに移動
cd E:\anonymous-keiba-ai-JRA

# 最新コードをプル
git pull origin genspark_ai_developer

# コミット確認
git log --oneline -5
# 以下が表示されるはず:
# 7717c11 - fix(models): Exclude invalid rank data (rank <= 0)

# ファイル確認
dir scripts\phase4\train_ranking_model.py
dir scripts\phase4\train_ranking_model_eval.py

# rank 0除外コードがあるか確認
Get-Content scripts\phase4\train_ranking_model.py | Select-Object -Index 45..60
```

### オプション B: 手動で修正

1. `scripts/phase4/train_ranking_model.py` を開く
2. 行46-55付近を上記の「修正後」コードに置き換え
3. `scripts/phase4/train_ranking_model_eval.py` も同様に修正
4. 保存して再実行

---

## 🎯 次のアクション

### 即座に実行すべきこと

1. **最新版をGitHubからプル**
   ```powershell
   cd E:\anonymous-keiba-ai-JRA
   git pull origin genspark_ai_developer
   ```

2. **評価用ランキングモデルを再訓練**
   ```powershell
   $env:PYTHONIOENCODING="utf-8"
   python scripts/phase4/train_ranking_model_eval.py
   ```

3. **NDCG@3が改善されたか確認**
   - **修正前**: NDCG@3 = 0.2502（rank 0を含む）
   - **修正後（期待値）**: NDCG@3 > 0.50（rank 0除外）

4. **評価予測を再実行**
   ```powershell
   python scripts\evaluation\generate_eval_predictions.py
   ```

5. **`ranking_pred_eval` 列が追加されたか確認**
   ```powershell
   Get-Content data\evaluation\predictions_2025_eval_model.csv -Head 1
   ```

---

## 📌 まとめ

### ✅ 確認完了

- 5つのPhase 4スクリプトを全て監査
- 各スクリプトの目的、出力、優先度を明確化
- 不要なスクリプトは**ゼロ**（全て必要）

### 🚨 重大な発見

- **ユーザーPC上のランキングモデルスクリプトは古いバージョン**
- **rank 0（取消・失格）が除外されていない**
- **これがNDCG@3 = 0.2502の低スコアの原因**

### 🔧 必要な作業

1. GitHubから最新版をプル（コミット 7717c11以降）
2. 評価用ランキングモデルを再訓練
3. NDCG@3 > 0.50 を確認
4. 評価予測を再実行

---

## 📚 参考情報

- **コミット 7717c11**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/7717c11
- **修正内容**: 3つの学習スクリプトに rank 0 除外コードを追加
- **影響範囲**: `train_binary_model.py`, `train_ranking_model.py`, `train_ranking_model_eval.py`

---

**次のステップ**: ユーザーに最新版プルと再訓練を依頼し、結果を報告してもらう。
