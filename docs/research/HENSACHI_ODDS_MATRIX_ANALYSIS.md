# Phase 2 検証分析 - 偏差値パターン別オッズ回収率マトリクス

**作成日**: 2026-02-28  
**目的**: 偏差値ランク（S/A/B/C/D/E）× オッズ刻み（CrossFactor準拠）の2次元分析

---

## 🎯 分析の目的

各レース内で計算した**偏差値ランク**ごとに、**オッズ帯別の回収率**を分析することで、最も効率的な購入パターンを特定する。

### 重要な仮説
- 偏差値Sランク（70+）でも、単勝1.1倍なら回収率は低い可能性
- 偏差値Aランク（65-69.9）で、単勝5.5倍なら回収率が高い可能性
- **偏差値 × オッズの組み合わせで最適な購入戦略が見えるはず**

---

## 📊 分析マトリクスの定義

### 1. 単勝オッズ別の単勝回収率（偏差値パターン別）

#### 分析軸

**縦軸（偏差値ランク）**:
- S: 70.0以上（最有力）
- A: 65.0-69.9（有力）
- B: 60.0-64.9（注目）
- C: 55.0-59.9（妙味あり）
- D: 50.0-54.9（評価普通）
- E: 49.9以下（評価低い）

**横軸（単勝オッズ刻み、CrossFactor準拠）**:
```
1-2.9, 3-4.9, 5-6.9, 7-8.9, 9-10.9, 11-12.9, 13-14.9, 15-16.9, 17-18.9, 19-21.9,
22-25.9, 26-29.9, 30-33.9, 34-37.9, 38-41.9, 42-45.9, 46-49.9, 50-59.9,
60-69.9, 70-79.9, 80-89.9, 90-99.9, 100+
```
**合計**: 23オッズ範囲

#### 分析指標（各セルで集計）

1. **対象数**: そのセルに該当する馬の数
2. **的中数**: そのセルで1着になった馬の数
3. **的中率**: 的中数 / 対象数 × 100 (%)
4. **平均配当**: 的中時の平均払戻金額
5. **回収率（均等買い）**: 総払戻 / (対象数 × 100) × 100 (%)
6. **回収率（均等払戻）**: CrossFactor方式による回収率
7. **補正回収率**: 期間重み付け + オッズ補正 + 均等払戻
8. **信頼度**: (補正回収率 - 80) × 対象数
9. **推奨度**: ★★★★★（信頼度とROIに基づく）

#### 出力フォーマット（CSV）

**ファイル名**: `tansho_hensachi_odds_matrix.csv`

```csv
偏差値ランク,オッズ範囲,対象数,的中数,的中率,平均配当,回収率(均等買い),回収率(均等払戻),補正回収率,信頼度,推奨度
S(70+),1-2.9,120,89,74.2%,125,92.8%,95.2%,98.5%,2220,★★★
S(70+),3-4.9,245,156,63.7%,172,109.5%,108.2%,110.8%,7553,★★★★★
S(70+),5-6.9,180,90,50.0%,285,142.5%,138.4%,141.2%,11016,★★★★★
...
A(65-69.9),1-2.9,450,299,66.4%,128,85.0%,87.8%,91.2%,5040,★★★★
A(65-69.9),3-4.9,680,408,60.0%,178,106.8%,105.1%,108.3%,19244,★★★★★
...
B(60-64.9),1-2.9,890,534,60.0%,130,78.0%,80.5%,83.8%,3382,★★★
...
C(55-59.9),1-2.9,1200,576,48.0%,132,63.4%,65.2%,68.5%,-13800,★
...
D(50-54.9),1-2.9,1500,540,36.0%,135,48.6%,50.1%,52.8%,-40800,☆
...
E(<50),1-2.9,2000,400,20.0%,138,27.6%,28.5%,30.1%,-99800,☆
...
```

#### 出力フォーマット（Markdown）

**ファイル名**: `tansho_hensachi_odds_matrix_report.md`

```markdown
# 単勝オッズ別の単勝回収率（偏差値パターン別）

## 📊 分析マトリクス

### 偏差値Sランク（70.0以上）

| オッズ範囲 | 対象数 | 的中率 | 回収率(均等買い) | 補正回収率 | 信頼度 | 推奨度 |
|-----------|--------|--------|----------------|-----------|--------|--------|
| 1-2.9 | 120 | 74.2% | 92.8% | 98.5% | 2220 | ★★★ |
| 3-4.9 | 245 | 63.7% | 109.5% | 110.8% | 7553 | ★★★★★ |
| 5-6.9 | 180 | 50.0% | 142.5% | 141.2% | 11016 | ★★★★★ |
| ... | ... | ... | ... | ... | ... | ... |

### 偏差値Aランク（65.0-69.9）

| オッズ範囲 | 対象数 | 的中率 | 回収率(均等買い) | 補正回収率 | 信頼度 | 推奨度 |
|-----------|--------|--------|----------------|-----------|--------|--------|
| 1-2.9 | 450 | 66.4% | 85.0% | 91.2% | 5040 | ★★★★ |
| 3-4.9 | 680 | 60.0% | 106.8% | 108.3% | 19244 | ★★★★★ |
| ... | ... | ... | ... | ... | ... | ... |

（以下、B/C/D/Eランクも同様）

## 🔥 最優秀パターン TOP 10

1. **偏差値S × 単勝5-6.9倍**: 補正回収率141.2%、信頼度11016 ⭐⭐⭐⭐⭐
2. **偏差値S × 単勝3-4.9倍**: 補正回収率110.8%、信頼度7553 ⭐⭐⭐⭐⭐
3. **偏差値A × 単勝3-4.9倍**: 補正回収率108.3%、信頼度19244 ⭐⭐⭐⭐⭐
4. ...

## ⚠️ 非推奨パターン（信頼度マイナス）

1. **偏差値E × 全オッズ帯**: 回収率30%以下、大幅マイナス
2. **偏差値D × 単勝1-2.9倍**: 回収率52.8%、信頼度-40800
3. **偏差値C × 単勝1-2.9倍**: 回収率68.5%、信頼度-13800
...
```

---

### 2. 複勝オッズ別の複勝回収率（偏差値パターン別）

#### 分析軸

**縦軸（偏差値ランク）**: S/A/B/C/D/E（単勝と同じ）

**横軸（複勝オッズ刻み、CrossFactor準拠）**:
```
1.0-1.4, 1.5-1.9, 2.0-2.4, 2.5-2.9, 3.0-3.4, 3.5-3.9, 4.0-4.4, 4.5-4.9,
5.0-5.4, 5.5-5.9, 6.0-6.4, 6.5-6.9, 7.0-7.4, 7.5-7.9, 8.0-8.4, 8.5-8.9,
9.0-9.4, 9.5-9.9, 10.0-10.4, 10.5-10.9, 11.0-11.4, 11.5-11.9, 12.0-12.4,
12.5-12.9, 13.0-13.4, 13.5-13.9, 14.0-14.4, 14.5-14.9, 15.0-15.4, 15.5-15.9,
16.0-16.4, 16.5-16.9, 17.0-17.4, 17.5-17.9, 18.0-18.4, 18.5-18.9, 19.0-19.4,
19.5-19.9, 20+
```
**合計**: 39オッズ範囲

#### 分析指標（単勝と同じ）

1. 対象数
2. 的中数（3着以内）
3. 的中率
4. 平均配当
5. 回収率（均等買い）
6. 回収率（均等払戻）
7. 補正回収率
8. 信頼度
9. 推奨度

#### 出力フォーマット（CSV）

**ファイル名**: `fukusho_hensachi_odds_matrix.csv`

```csv
偏差値ランク,オッズ範囲,対象数,的中数,的中率,平均配当,回収率(均等買い),回収率(均等払戻),補正回収率,信頼度,推奨度
S(70+),1.0-1.4,520,442,85.0%,105,89.2%,91.5%,94.8%,7696,★★★★
S(70+),1.5-1.9,620,403,65.0%,128,83.2%,85.8%,89.1%,5644,★★★★
S(70+),2.0-2.4,480,168,35.0%,215,75.2%,78.3%,81.6%,768,★★★
...
A(65-69.9),1.0-1.4,1200,1020,85.0%,106,90.1%,92.6%,96.0%,19200,★★★★★
A(65-69.9),1.5-1.9,1450,943,65.0%,129,83.9%,86.5%,89.8%,14210,★★★★★
...
B(60-64.9),1.0-1.4,2100,1785,85.0%,107,90.9%,93.5%,96.9%,35490,★★★★★
...
```

---

## 🎨 ヒートマップ生成

### 単勝回収率ヒートマップ

**X軸**: 単勝オッズ範囲（23個）  
**Y軸**: 偏差値ランク（6個: S/A/B/C/D/E）  
**色**: 補正回収率
- 赤: 100%以上（プラス）
- 黄: 80-100%（基準付近）
- 青: 80%未満（マイナス）

**Python実装**:
```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# データ準備
hensachi_ranks = ['S(70+)', 'A(65-69.9)', 'B(60-64.9)', 'C(55-59.9)', 'D(50-54.9)', 'E(<50)']
odds_ranges = ['1-2.9', '3-4.9', '5-6.9', ..., '90-99.9', '100+']  # 23個

# マトリクスデータ（補正回収率）
matrix = np.array([
    [98.5, 110.8, 141.2, ...],  # S
    [91.2, 108.3, 135.1, ...],  # A
    [83.8, 102.5, 128.6, ...],  # B
    [68.5, 89.2, 115.3, ...],   # C
    [52.8, 72.1, 98.5, ...],    # D
    [30.1, 48.6, 65.2, ...]     # E
])

# ヒートマップ描画
fig, ax = plt.subplots(figsize=(20, 8))
sns.heatmap(matrix, annot=True, fmt='.1f', cmap='RdYlBu_r', 
            xticklabels=odds_ranges, yticklabels=hensachi_ranks,
            vmin=0, vmax=150, center=80, cbar_kws={'label': '補正回収率 (%)'})

ax.set_xlabel('単勝オッズ範囲', fontsize=14)
ax.set_ylabel('偏差値ランク', fontsize=14)
ax.set_title('単勝回収率ヒートマップ（偏差値 × オッズ）', fontsize=16, fontweight='bold')

plt.tight_layout()
plt.savefig('tansho_hensachi_odds_heatmap.png', dpi=300)
plt.close()
```

### 複勝回収率ヒートマップ（同様）

---

## 📈 3Dサーフェスプロット

**X軸**: オッズ（連続値）  
**Y軸**: 偏差値（連続値）  
**Z軸**: 補正回収率

```python
from mpl_toolkits.mplot3d import Axes3D

# データ準備
X = np.array([...])  # オッズ（中央値）
Y = np.array([...])  # 偏差値（中央値）
Z = np.array([...])  # 補正回収率

# 3Dサーフェスプロット
fig = plt.figure(figsize=(14, 10))
ax = fig.add_subplot(111, projection='3d')

surf = ax.plot_surface(X, Y, Z, cmap='coolwarm', alpha=0.8)
ax.set_xlabel('単勝オッズ', fontsize=12)
ax.set_ylabel('偏差値', fontsize=12)
ax.set_zlabel('補正回収率 (%)', fontsize=12)
ax.set_title('単勝回収率 3Dサーフェス（偏差値 × オッズ）', fontsize=14, fontweight='bold')

fig.colorbar(surf, shrink=0.5, aspect=5)
plt.savefig('tansho_hensachi_odds_3d.png', dpi=300)
plt.close()
```

---

## 🔬 実装スクリプトの構造

### Phase 2A（基本版）

```python
def analyze_hensachi_odds_matrix_basic(df, ticket_type='tansho'):
    """
    偏差値 × オッズ刻みの2次元分析（均等買い方式）
    
    Args:
        df: DataFrame with columns:
            - hensachi: float (偏差値)
            - tansho_odds or fukusho_odds: float
            - hit: bool (的中したか)
            - payoff: float (払戻金額)
        ticket_type: 'tansho' or 'fukusho'
    
    Returns:
        matrix_df: DataFrame (偏差値ランク × オッズ範囲)
    """
    # 偏差値ランクを付与
    df['hensachi_rank'] = df['hensachi'].apply(get_hensachi_rank)
    
    # オッズ範囲を付与
    if ticket_type == 'tansho':
        df['odds_bin'] = df['tansho_odds'].apply(get_tansho_odds_bin)
    else:
        df['odds_bin'] = df['fukusho_odds'].apply(get_fukusho_odds_bin)
    
    # グループ化して集計
    matrix = df.groupby(['hensachi_rank', 'odds_bin']).agg({
        'race_id': 'count',  # 対象数
        'hit': 'sum',  # 的中数
        'payoff': 'sum'  # 払戻総額
    }).rename(columns={'race_id': 'count', 'hit': 'hits'})
    
    # 的中率と回収率を計算
    matrix['hit_rate'] = matrix['hits'] / matrix['count'] * 100
    matrix['recovery_rate'] = matrix['payoff'] / (matrix['count'] * 100) * 100
    
    return matrix
```

### Phase 2B（補正版）

```python
def analyze_hensachi_odds_matrix_corrected(df, year_weights, ticket_type='tansho'):
    """
    偏差値 × オッズ刻みの2次元分析（CrossFactor補正方式）
    
    Args:
        df: DataFrame with columns:
            - year: int
            - hensachi: float
            - tansho_odds or fukusho_odds: float
            - hit: bool
            - payoff: float
        year_weights: dict (期間別重み付け)
        ticket_type: 'tansho' or 'fukusho'
    
    Returns:
        matrix_df: DataFrame (偏差値ランク × オッズ範囲)
    """
    # 偏差値ランクを付与
    df['hensachi_rank'] = df['hensachi'].apply(get_hensachi_rank)
    
    # オッズ範囲を付与
    if ticket_type == 'tansho':
        df['odds_bin'] = df['tansho_odds'].apply(get_tansho_odds_bin)
        odds_col = 'tansho_odds'
    else:
        df['odds_bin'] = df['fukusho_odds'].apply(get_fukusho_odds_bin)
        odds_col = 'fukusho_odds'
    
    # 期間別重みを付与
    df['year_weight'] = df['year'].map(year_weights)
    
    # オッズ補正係数を付与
    df['odds_correction'] = df[odds_col].apply(
        lambda x: get_odds_correction(x, ticket_type)
    )
    
    # 均等払戻方式の購入金額を計算
    target_payoff = 10000
    df['bet_amount'] = target_payoff / df[odds_col]
    
    # 補正後の払戻金額を計算
    df['corrected_payoff'] = np.where(
        df['hit'],
        df['payoff'] * df['year_weight'] * df['odds_correction'],
        0
    )
    
    # 補正後の購入金額を計算
    df['weighted_bet'] = df['bet_amount'] * df['year_weight']
    
    # グループ化して集計
    matrix = df.groupby(['hensachi_rank', 'odds_bin']).agg({
        'race_id': 'count',
        'hit': 'sum',
        'payoff': 'sum',
        'corrected_payoff': 'sum',
        'weighted_bet': 'sum'
    }).rename(columns={'race_id': 'count', 'hit': 'hits'})
    
    # 的中率と回収率を計算
    matrix['hit_rate'] = matrix['hits'] / matrix['count'] * 100
    matrix['recovery_rate_equal_bet'] = matrix['payoff'] / (matrix['count'] * 100) * 100
    matrix['corrected_recovery_rate'] = matrix['corrected_payoff'] / matrix['weighted_bet'] * 100
    
    # 信頼度を計算
    matrix['confidence'] = (matrix['corrected_recovery_rate'] - 80) * matrix['count']
    
    # 推奨度を付与
    matrix['recommendation'] = matrix['confidence'].apply(get_recommendation_stars)
    
    return matrix
```

---

## 📝 まとめ

### 分析の全体像

```
偏差値ランク（6種類）
  × オッズ刻み（単勝23範囲、複勝39範囲）
  = 単勝138セル、複勝234セル
```

### 各セルで集計する指標

1. 対象数
2. 的中数
3. 的中率
4. 平均配当
5. 回収率（均等買い）- Phase 2A
6. 回収率（均等払戻）- Phase 2B
7. 補正回収率 - Phase 2B
8. 信頼度 - Phase 2B
9. 推奨度 - Phase 2B

### 出力ファイル

**Phase 2A**:
- `tansho_hensachi_odds_matrix.csv`
- `fukusho_hensachi_odds_matrix.csv`
- `tansho_hensachi_odds_heatmap.png`
- `fukusho_hensachi_odds_heatmap.png`
- `hensachi_odds_matrix_report.md`

**Phase 2B**:
- `tansho_hensachi_odds_matrix_corrected.csv`
- `fukusho_hensachi_odds_matrix_corrected.csv`
- `tansho_hensachi_odds_heatmap_corrected.png`
- `fukusho_hensachi_odds_heatmap_corrected.png`
- `hensachi_odds_matrix_corrected_report.md`
- `comparison_basic_vs_corrected.md`（補正前後の比較）

---

**最終更新**: 2026-02-28 17:45 JST
