# ランキングモデル NDCG計算バグ修正レポート

## 📋 概要

**日付**: 2026-02-27  
**対象**: Phase 4-A ランキング評価用モデル (`train_ranking_model_eval.py`)  
**問題**: NDCG@3 スコアが成功基準 (0.50) を大幅に下回る (0.2485)  
**修正コミット**: `d6edcf4`

---

## 🚨 問題の詳細

### 発生した現象

```
訓練中の検証NDCG@3:  0.7676  ← LightGBM内部メトリック
最終評価NDCG@3:       0.2485  ← カスタム実装
```

**矛盾**: 同じ2024年検証データに対して、**3倍以上の乖離**が発生。

---

## 🔍 原因分析

### LightGBM Ranker の予測値の特性

```python
# LightGBM Ranker (objective='lambdarank') の予測値
y_pred_race = model.predict(X_valid)
# 例: [2.3, 5.1, 1.8, 8.4, ...]
#     ↑小さいほど上位予測（1着に近い）
```

### sklearn.metrics.ndcg_score の期待値

```python
from sklearn.metrics import ndcg_score

# sklearn.ndcg_score は「大きいスコア = 高関連性」を期待
ndcg = ndcg_score([y_true_relevance], [y_pred_score], k=3)
#                                       ↑大きいほど上位でなければならない
```

### バグのあるコード (修正前)

```python
# ❌ 間違い: 予測値をそのまま渡している
for race_id in valid_df['race_id'].unique():
    y_true_race = y_valid[race_mask].values
    y_pred_race = y_pred_valid[race_mask]
    
    max_rank = y_true_race.max()
    y_true_relevance = max_rank - y_true_race + 1
    
    # ❌ y_pred_race は「小さい = 上位」だが、
    # ndcg_score は「大きい = 上位」を期待
    ndcg = ndcg_score([y_true_relevance], [y_pred_race], k=3)
```

**結果**: スコアの大小関係が逆転 → NDCG@3 = 0.2485

---

## ✅ 修正内容

### 修正後のコード

```python
# ✅ 正しい: 予測値を反転
for race_id in valid_df['race_id'].unique():
    y_true_race = y_valid[race_mask].values
    y_pred_race = y_pred_valid[race_mask]
    
    max_rank = y_true_race.max()
    y_true_relevance = max_rank - y_true_race + 1
    
    # ✅ 予測値を反転（小さい → 大きい に変換）
    y_pred_score = -y_pred_race
    
    # 🎯 これで両方「大きい = 上位」となり整合
    ndcg = ndcg_score([y_true_relevance], [y_pred_score], k=3)
```

### 変更点サマリ

| 項目 | 修正前 | 修正後 |
|------|--------|--------|
| **予測スコア** | `y_pred_race` (小↓上位) | `y_pred_score = -y_pred_race` (大↑上位) |
| **NDCG@3** | 0.2485 | **~0.77** (予想) |

---

## 📊 期待される改善

### 修正前後の比較

```
訓練中 LightGBM NDCG@3:  0.7676
修正前カスタム NDCG@3:   0.2485  ← バグあり
修正後カスタム NDCG@3:   0.7676  ← 正常 (予想)
```

**期待される結果**: 訓練中の検証スコアと最終評価スコアが一致。

---

## 🔧 再現手順 (修正後)

### 1. 修正版スクリプトの取得

```powershell
# ローカルに修正版をダウンロード
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/d6edcf4/scripts/phase4/train_ranking_model_eval.py" -OutFile "scripts\phase4\train_ranking_model_eval.py"
```

### 2. 既存モデルの削除

```powershell
Remove-Item models\jra_ranking_model_eval.txt -ErrorAction SilentlyContinue
```

### 3. 再訓練の実行

```powershell
$env:PYTHONIOENCODING="utf-8"
python scripts\phase4\train_ranking_model_eval.py
```

### 4. 期待される出力

```
✅ 検証データ（2024年）NDCG@3: 0.7676
✅ 成功基準クリア（NDCG@3 > 0.50）
```

---

## 📚 教訓

### なぜ訓練中のNDCGは正しかったのか？

LightGBM Rankerの内部実装は：
- `objective='lambdarank'` → 着順の**大小関係**を直接学習
- `metric='ndcg'` → 着順の**順序構造**を理解した評価

→ LightGBM内部は正常動作。

### なぜカスタムNDCGは間違っていたのか？

`sklearn.metrics.ndcg_score`は汎用ライブラリのため：
- ドメイン知識なし（着順が「小さい=良い」とは知らない）
- 単に「大きいスコア=高関連性」と解釈

→ 予測値の符号反転が必要。

---

## ✅ 検証完了条件

- [ ] 修正版スクリプトで再訓練
- [ ] 最終評価NDCG@3 ≥ 0.50
- [ ] モデルファイルサイズ: 1.3~2.0 MB
- [ ] レポート生成成功

---

## 📁 関連ファイル

- **修正スクリプト**: `scripts/phase4/train_ranking_model_eval.py`
- **コミット**: `d6edcf4`
- **GitHub URL**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/d6edcf4

---

**作成日**: 2026-02-27  
**作成者**: GenSpark AI Assistant
