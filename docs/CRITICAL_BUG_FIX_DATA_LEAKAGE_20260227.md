# 🚨 重大バグ修正レポート: データリーク問題

**作成日**: 2026-02-27  
**修正コミット**: `fac34a4`  
**影響範囲**: Phase 3 二値分類モデル  
**重大度**: **CRITICAL**

---

## 📋 エグゼクティブサマリー

Phase 3二値分類モデル（`train_binary_model.py`）に**データリーク（Data Leakage）**の致命的なバグを発見。モデルが予測対象である「着順」そのものを特徴量として使用していたため、AUC=1.0000という異常に高い精度を記録していたが、実際には予測不可能な状態でした。

---

## 🔍 問題の詳細

### 症状

1. **異常な精度**
   - 訓練AUC: 1.0000
   - テストAUC: 1.0000
   - Early stopping: 1イテレーション目で停止

2. **予測失敗**
   - 混同行列:
     ```
     真陰性 (TN): 37,121  ← 4着以下を正しく予測
     偽陽性 (FP): 0       ← 誤って3着以内と予測なし
     偽陰性 (FN): 10,376  ← 3着以内を全て見逃し
     真陽性 (TP): 0       ← 3着以内を一切予測できない
     ```
   - モデルは**全てのレースで4着以下と予測**（3着以内を完全無視）

3. **特徴量重要度の異常**
   ```
   133. kakutei_chakujun_float: 831,351.00  ← 突出して高い
   他の特徴量: 全て 0.00
   ```

4. **モデルファイルサイズ異常**
   - 評価用モデル: 0.01 MB（正常: 15-20 MB）
   - 本番用モデル: 0.83 MB（正常: 15-20 MB）

### 根本原因

**`kakutei_chakujun_float`（着順の数値型）が特徴量に含まれていた**

#### コード上の問題箇所

**1. `preprocess_data()` 関数（行114-117）**
```python
# 修正前（バグあり）
exclude_cols = [
    'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
    'umaban', 'kakutei_chakujun', 'target_top3'  # kakutei_chakujun_float が欠落
]
```

**2. `prepare_features()` 関数（行262-265）**
```python
# 修正前（バグあり）
exclude_cols = [
    'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
    'umaban', 'kakutei_chakujun', 'is_top3', 'target_top3'  # kakutei_chakujun_float が欠落
]
```

#### なぜこのバグが発生したか

1. 行126で `kakutei_chakujun` を数値型に変換して `kakutei_chakujun_float` を作成
2. 行136で `kakutei_chakujun_float` から目的変数 `is_top3` を生成
3. **しかし**、`kakutei_chakujun_float` 自体を除外リストに追加し忘れた
4. 結果: モデルが「着順」そのものを使って「3着以内かどうか」を予測（カンニング状態）

---

## ✅ 修正内容

### コード変更

**コミット**: `fac34a4`  
**ファイル**: `scripts/phase3/train_binary_model.py`

#### 修正1: `preprocess_data()` 関数（行116）
```python
# 修正後
exclude_cols = [
    'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
    'umaban', 'kakutei_chakujun', 'kakutei_chakujun_float', 'target_top3'  # ← 追加
]
```

#### 修正2: `prepare_features()` 関数（行264）
```python
# 修正後
exclude_cols = [
    'kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 
    'umaban', 'kakutei_chakujun', 'kakutei_chakujun_float', 'is_top3', 'target_top3'  # ← 追加
]
```

### diff サマリー
```diff
- 'umaban', 'kakutei_chakujun', 'target_top3'
+ 'umaban', 'kakutei_chakujun', 'kakutei_chakujun_float', 'target_top3'
```

---

## 📊 期待される影響

### 修正前（バグあり）
- **AUC**: 1.0000（異常に高い）
- **予測**: 全て4着以下（3着以内を予測不可能）
- **特徴量**: 着順そのものを使用（カンニング）
- **実用性**: ❌ 実際のレースでは使用不可能（着順が事前に分からない）

### 修正後（期待値）
- **AUC**: 0.70-0.85（現実的な範囲）
- **予測**: 3着以内/4着以下を適切に分類
- **特徴量**: レース前に入手可能な情報のみ使用
- **実用性**: ✅ 実際のレースで使用可能

---

## 🎯 再現手順と検証

### 1. 旧モデルの削除（必須）
```powershell
Remove-Item E:\anonymous-keiba-ai-JRA\models\jra_binary_model.txt
Remove-Item E:\anonymous-keiba-ai-JRA\models\jra_binary_model_eval.txt
```

### 2. 修正版スクリプトの取得
```powershell
# GitHub最新版を取得
cd E:\anonymous-keiba-ai-JRA
git pull origin genspark_ai_developer

# または直接ダウンロード
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/genspark_ai_developer/scripts/phase3/train_binary_model.py" -OutFile "scripts\phase3\train_binary_model.py"
```

### 3. 再訓練
```powershell
$env:PYTHONIOENCODING="utf-8"
python scripts\phase3\train_binary_model.py
```

### 4. 検証ポイント

#### ✅ 正常な結果の確認項目
```
□ rank 0 除外メッセージ: "⚠️ 無効な着順データ: 5,699行 → 除外"
□ 特徴量数: 132列（133列から kakutei_chakujun_float が除外されている）
□ 使用特徴量リスト: kakutei_chakujun_float が含まれていない
□ Early stopping: 10-100イテレーション程度（1ではない）
□ テストAUC: 0.70-0.85 の範囲（1.0000 ではない）
□ 特徴量重要度: 複数の特徴量が分散している（1つだけ突出していない）
□ 混同行列: 真陽性(TP) > 0（3着以内を予測できている）
□ モデルファイルサイズ: 評価用 15-20 MB、本番用 15-20 MB
```

#### ❌ 異常な結果（修正失敗）
```
✗ テストAUC = 1.0000
✗ Early stopping at iteration 1
✗ kakutei_chakujun_float が特徴量重要度で突出
✗ 真陽性(TP) = 0
✗ モデルファイルサイズ < 1 MB
```

---

## 📁 影響を受けたファイル

### 削除必須
- `models/jra_binary_model.txt`（旧・本番用モデル）
- `models/jra_binary_model_eval.txt`（旧・評価用モデル）

### 再生成必要
- `models/jra_binary_model.txt`（新・本番用モデル）
- `models/jra_binary_model_eval.txt`（新・評価用モデル）
- `results/phase3_binary_model_report.txt`（評価レポート）

### 影響なし（そのまま使用可能）
- `models/jra_regression_model.txt`（回帰モデル）
- `models/jra_regression_model_eval.txt`（回帰モデル評価用）
- `models/jra_regression_model_optimized.txt`（回帰モデル最適化版）

---

## 🔗 関連リンク

- **修正コミット**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/fac34a4
- **修正版スクリプト**: https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/genspark_ai_developer/scripts/phase3/train_binary_model.py
- **前回コミット**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/b54ee22

---

## 📚 学んだ教訓

### データリークの兆候
1. **異常に高い精度**（AUC=1.0, Accuracy=100%）
2. **1イテレーションでEarly stopping**
3. **特徴量重要度が1つだけ突出**
4. **予測が極端に偏る**（全て同じクラスを予測）
5. **モデルファイルサイズが異常に小さい**

### 予防策
1. **目的変数から派生した列は全て除外**
2. **レース結果に関連する列は慎重に確認**
3. **特徴量重要度を必ずチェック**
4. **混同行列で予測の偏りを確認**
5. **Early stoppingの挙動を監視**

---

## 🎯 次のアクション

1. ✅ **完了**: バグ修正とGitHubプッシュ（コミット `fac34a4`）
2. ⏳ **進行中**: ユーザーによる修正版スクリプト取得
3. ⏳ **進行中**: 二値分類モデル再訓練（約30-60分）
4. ⏳ **待機中**: ランキングモデル再訓練（約30-60分）
5. ⏳ **待機中**: Phase 4評価予測生成

---

**担当者**: GenSpark AI Developer  
**レビュー**: 必須（ユーザー確認後）  
**ステータス**: 修正完了 → ユーザー検証待ち
