# オッズ補正と均等払戻による回収率分析の改善案

**参照元**: https://team-d.club/correct-recovery-rate/  
**作成日**: 2026-02-28

---

## 🎯 重要な発見

CrossFactor（競馬ソフト）の記事から、従来の回収率分析における**3つの重大な問題点と解決策**が明らかになりました。

---

## ❌ 従来の回収率分析の問題点

### 問題1: 穴馬の影響を受けすぎる

**均等買い（各馬100円ずつ）の問題**:
```
対象データ数: 100件
的中件数: 1件
配当: 15,000円

→ 単勝的中率: 1%
→ 単勝回収率: 150%
```

**問題**: この1件の的中がなければ回収率は0%。高配当1発で全体の回収率が歪む。

**複勝の例**:
```
対象データ数: 100件
的中件数: 2件
平均配当: 6,000円

→ 複勝的中率: 2.0%
→ 複勝回収率: 120%
```

**問題**: 2件のうち1件でも来なければ回収率は60%に激減。

### 問題2: 古いデータと新しいデータを同じレベルで扱っている

**問題点**:
- 2016年のデータと2025年のデータを同じ重みで扱っている
- 騎手の騎乗能力の年齢による変化
- 馬券術や競馬予想AIの進化によるオッズの変動
- より新しいデータの方が信頼度が高いはず

**結論**: **期間別の重み付け補正が必要**

### 問題3: オッズによる回収率の偏り

**2016-2020年のデータ（記事より）**:

**単勝オッズ別の単勝回収率**:
- オッズ100倍以上 → 回収率が一気に下がる

**複勝オッズ別の複勝回収率**:
- オッズ17倍以上 → 回収率が一気に下がる

**原因**:
1. 人気が低い馬が予想以上に来ていない
2. 人気が低い馬が実力以上に過剰に買われている

---

## ✅ CrossFactor の解決策

### 解決策1: 期間別の重み付け補正

**実装方法**:
- 2016年～2025年にかけて、**1～10の割合で重み付け**
- 新しいデータほど重みを大きくする
- 例: 2016年=1.0, 2017年=2.0, ..., 2025年=10.0

**Python実装例**:
```python
# 年別の重み付け
year_weights = {
    2016: 1.0,
    2017: 2.0,
    2018: 3.0,
    2019: 4.0,
    2020: 5.0,
    2021: 6.0,
    2022: 7.0,
    2023: 8.0,
    2024: 9.0,
    2025: 10.0
}

# 回収率計算時に重み付け
weighted_recovery_rate = sum(
    (payoff / bet) * year_weights[year] for year, payoff, bet in data
) / sum(year_weights[year] for year in data)
```

### 解決策2: オッズ範囲ごとの配当補正

**実装方法**:
- **単勝・複勝それぞれにオッズ範囲ごとに補正係数を適用**
- すべてのデータを使いつつ、オッズ帯別の偏りを補正

**補正係数の例**:
```python
# 単勝オッズ補正係数（記事のグラフから推定）
tansho_correction = {
    (1.0, 1.9):   1.00,  # 基準
    (2.0, 2.9):   1.02,
    (3.0, 4.9):   1.05,
    (5.0, 9.9):   1.08,
    (10.0, 19.9): 1.10,
    (20.0, 49.9): 1.05,
    (50.0, 99.9): 0.90,
    (100.0, float('inf')): 0.50  # 大幅減衰
}

# 複勝オッズ補正係数（記事のグラフから推定）
fukusho_correction = {
    (1.0, 1.4):   1.00,  # 基準
    (1.5, 1.9):   1.02,
    (2.0, 2.9):   1.05,
    (3.0, 4.9):   1.08,
    (5.0, 9.9):   1.10,
    (10.0, 16.9): 1.05,
    (17.0, float('inf')): 0.60  # 大幅減衰
}
```

### 解決策3: 均等払戻による分析（最重要！）

**従来の「均等買い」**:
- すべての馬券を同じ金額（例: 100円）で買った場合の回収率
- 高オッズ馬の影響が大きすぎる

**CrossFactorの「均等払戻」**:
- **すべての馬券を同じ払戻金額（例: 10,000円）で買った場合の回収率**
- オッズが低い馬券 → 多くの金額をベット
- オッズが高い馬券 → 少ない金額をベット

**計算式**:
```python
# 均等買いの場合（従来）
bet_amount = 100  # 固定
payoff = odds * bet_amount
recovery_rate = sum(payoff) / sum(bet_amount)

# 均等払戻の場合（CrossFactor方式）
target_payoff = 10000  # 目標払戻額（固定）
bet_amount = target_payoff / odds  # オッズに応じて変動
actual_payoff = odds * bet_amount  # = target_payoff（的中時）
recovery_rate = sum(actual_payoff) / sum(bet_amount)
```

**効果**:
- 穴馬券の影響度を下げる
- より安定した回収率分析が可能

---

## 📊 実装への適用

### Phase 2（2025年検証スクリプト）への適用

#### 1. 期間別重み付け

```python
def calculate_weighted_recovery_rate(data, year_weights):
    """
    期間別の重み付けを考慮した回収率計算
    
    Args:
        data: [(year, odds, hit, payoff), ...]
        year_weights: {2016: 1.0, 2017: 2.0, ..., 2025: 10.0}
    
    Returns:
        weighted_recovery_rate: float
    """
    total_weighted_payoff = 0
    total_weighted_bet = 0
    
    for year, odds, hit, payoff in data:
        weight = year_weights.get(year, 1.0)
        
        # 均等払戻方式
        target_payoff = 10000
        bet_amount = target_payoff / odds
        
        if hit:
            actual_payoff = payoff
        else:
            actual_payoff = 0
        
        total_weighted_payoff += actual_payoff * weight
        total_weighted_bet += bet_amount * weight
    
    return (total_weighted_payoff / total_weighted_bet) * 100
```

#### 2. オッズ補正係数の適用

```python
def get_odds_correction(odds, ticket_type='tansho'):
    """
    オッズに応じた補正係数を取得
    
    Args:
        odds: float
        ticket_type: 'tansho' or 'fukusho'
    
    Returns:
        correction_factor: float
    """
    if ticket_type == 'tansho':
        if odds < 2.0:
            return 1.00
        elif odds < 3.0:
            return 1.02
        elif odds < 5.0:
            return 1.05
        elif odds < 10.0:
            return 1.08
        elif odds < 20.0:
            return 1.10
        elif odds < 50.0:
            return 1.05
        elif odds < 100.0:
            return 0.90
        else:
            return 0.50
    
    elif ticket_type == 'fukusho':
        if odds < 1.5:
            return 1.00
        elif odds < 2.0:
            return 1.02
        elif odds < 3.0:
            return 1.05
        elif odds < 5.0:
            return 1.08
        elif odds < 10.0:
            return 1.10
        elif odds < 17.0:
            return 1.05
        else:
            return 0.60
```

#### 3. 信頼度の計算

CrossFactorの信頼度計算式:
```python
def calculate_confidence(corrected_recovery_rate, data_count, base=80):
    """
    信頼度 = (補正回収率 - 基準) × データ件数
    
    Args:
        corrected_recovery_rate: 補正後の回収率（%）
        data_count: データ件数
        base: 基準値（デフォルト: 80）
    
    Returns:
        confidence: float
    """
    return (corrected_recovery_rate - base) * data_count
```

**信頼度の解釈**:
- 信頼度が高いほど、データの信憑性が高い
- プラスの信頼度 → 期待値が高い
- マイナスの信頼度 → 期待値が低い

---

## 🎯 Phase 6 への適用提案

### 予測時の重み付け

Phase 6 の当日予測でも、以下を適用すべき:

1. **学習時の期間別重み付け**:
   - 2024年のデータを2016年のデータより重視
   - 最新の競馬環境を反映

2. **オッズ推定による補正**:
   - Phase 6 は確定オッズ前の予測
   - 過去の同条件レースからオッズを推定
   - 推定オッズに基づいて補正係数を適用

3. **偏差値計算時に均等払戻の概念を適用**:
   - 現在: 各馬のアンサンブルスコアを偏差値化
   - 改善: オッズ推定値を考慮した偏差値計算

---

## 📝 実装優先度の見直し

### 新しい実装順序

```
Phase 1: 投稿用フォルダの作成 ✅ 完了
         ↓
Phase 2A: 2025年検証スクリプト（基本版）
          - 従来の均等買い方式で集計
          - オッズ帯別の回収率を確認
         ↓
Phase 2B: 2025年検証スクリプト（補正版） ← 新規追加
          - 期間別重み付け補正
          - オッズ補正係数の適用
          - 均等払戻方式の実装
          - 信頼度の計算
         ↓
Phase 3: 偏差値化 + ランク評価
          - Phase 2B の結果を反映
          - オッズ推定による補正
          - 購入推奨ロジック
```

---

## 📊 検証レポートの拡張

### 出力フォーマット（拡張版）

**CSV出力**:
```csv
偏差値帯,券種,オッズ帯,対象数,的中数,的中率,平均配当,回収率(均等買い),回収率(均等払戻),補正回収率,信頼度,推奨度
S(70+),単勝,1.0-1.4,120,89,74.2%,125,92.8%,95.2%,98.5%,2220,★★★
S(70+),単勝,1.5-1.9,245,156,63.7%,172,109.5%,108.2%,110.8%,7553,★★★★★
...
```

**Markdownレポート**:
```markdown
## オッズ補正と均等払戻による回収率分析

### 補正前 vs 補正後の比較

| オッズ帯 | 均等買い回収率 | 均等払戻回収率 | 補正回収率 | 信頼度 |
|---------|--------------|--------------|-----------|-------|
| 1.0-1.4 | 92.8% | 95.2% | 98.5% | 2220 |
| 1.5-1.9 | 109.5% | 108.2% | 110.8% | 7553 |
| ...     | ...   | ...   | ...   | ...  |

### 補正の効果

- **期間別重み付け**: 新しいデータを重視（2025年=10.0, 2016年=1.0）
- **オッズ補正**: 極端な高オッズ馬の影響を減衰
- **均等払戻**: 穴馬券の影響度を適切に調整
```

---

## 🔬 実装すべき新機能

### 1. 均等払戻計算関数

```python
def calculate_equal_payout_recovery_rate(data, target_payout=10000):
    """
    均等払戻方式による回収率計算
    
    Args:
        data: [(odds, hit, payoff), ...]
        target_payout: 目標払戻額（デフォルト: 10000円）
    
    Returns:
        recovery_rate: float
    """
    total_bet = 0
    total_payoff = 0
    
    for odds, hit, payoff in data:
        # 目標払戻額に対する購入金額を計算
        bet = target_payout / odds
        total_bet += bet
        
        if hit:
            total_payoff += payoff
    
    return (total_payoff / total_bet) * 100
```

### 2. 補正回収率計算の統合関数

```python
def calculate_corrected_recovery_rate(
    data,
    year_weights,
    odds_correction_func,
    target_payout=10000,
    ticket_type='tansho'
):
    """
    期間重み付け + オッズ補正 + 均等払戻を統合した補正回収率計算
    
    Args:
        data: [(year, odds, hit, payoff), ...]
        year_weights: {2016: 1.0, ..., 2025: 10.0}
        odds_correction_func: オッズ補正関数
        target_payout: 目標払戻額
        ticket_type: 'tansho' or 'fukusho'
    
    Returns:
        corrected_recovery_rate: float
    """
    total_weighted_bet = 0
    total_weighted_payoff = 0
    
    for year, odds, hit, payoff in data:
        # 期間別の重み
        year_weight = year_weights.get(year, 1.0)
        
        # オッズ補正係数
        odds_corr = odds_correction_func(odds, ticket_type)
        
        # 均等払戻方式の購入金額
        bet = target_payout / odds
        
        # 補正後の購入金額と払戻金額
        weighted_bet = bet * year_weight
        
        if hit:
            weighted_payoff = payoff * year_weight * odds_corr
        else:
            weighted_payoff = 0
        
        total_weighted_bet += weighted_bet
        total_weighted_payoff += weighted_payoff
    
    return (total_weighted_payoff / total_weighted_bet) * 100
```

---

## 📚 参考資料

- **CrossFactor 補正回収率分析**: https://team-d.club/correct-recovery-rate/
- **オッズ補正の理論的背景**: パリミュチュエル方式における市場の歪み
- **均等払戻の数学的根拠**: ケリー基準との整合性

---

## 📝 まとめ

### 従来の問題点
1. ❌ 穴馬の影響を受けすぎる（均等買いの問題）
2. ❌ 古いデータと新しいデータを同列に扱う
3. ❌ オッズによる回収率の偏りを考慮していない

### CrossFactor の解決策
1. ✅ **均等払戻方式**: 穴馬の影響を適切に調整
2. ✅ **期間別重み付け**: 新しいデータを重視
3. ✅ **オッズ補正係数**: オッズ帯別の偏りを補正
4. ✅ **信頼度指標**: データの信憑性を定量化

### 次のアクション
- Phase 2B を新規追加（補正版検証スクリプト）
- 均等払戻・期間重み付け・オッズ補正を実装
- Phase 3 で補正結果を反映した偏差値化

---

**最終更新**: 2026-02-28 17:00 JST
