# Phase 2 検証スクリプト - オッズ刻み定義

**参照元**: https://team-d.club/correct-recovery-rate/ のグラフ  
**作成日**: 2026-02-28

---

## 📊 オッズ刻みの定義（CrossFactor準拠）

### 単勝オッズの刻み（1.0-100.0倍）

**完全なリスト**:
```python
TANSHO_ODDS_BINS = [
    1, 3, 5, 7, 9, 11, 13, 15, 17, 19,       # 1-19: 2刻み
    22, 26, 30, 34, 38, 42, 46, 50,          # 22-50: 4刻み
    60, 70, 80, 90, 100                       # 60-100: 10刻み
]

# 範囲として表現
TANSHO_ODDS_RANGES = [
    (1.0, 2.9),    # 1
    (3.0, 4.9),    # 3
    (5.0, 6.9),    # 5
    (7.0, 8.9),    # 7
    (9.0, 10.9),   # 9
    (11.0, 12.9),  # 11
    (13.0, 14.9),  # 13
    (15.0, 16.9),  # 15
    (17.0, 18.9),  # 17
    (19.0, 21.9),  # 19
    (22.0, 25.9),  # 22
    (26.0, 29.9),  # 26
    (30.0, 33.9),  # 30
    (34.0, 37.9),  # 34
    (38.0, 41.9),  # 38
    (42.0, 45.9),  # 42
    (46.0, 49.9),  # 46
    (50.0, 59.9),  # 50
    (60.0, 69.9),  # 60
    (70.0, 79.9),  # 70
    (80.0, 89.9),  # 80
    (90.0, 99.9),  # 90
    (100.0, float('inf'))  # 100+
]
```

**刻み方のロジック**:
- 1-19倍: 2刻み（本命～中穴を細かく分析）
- 22-50倍: 4刻み（穴馬を中程度に分析）
- 60-100倍: 10刻み（大穴を粗く分析）
- **100倍以上: 1つの範囲として扱う**（回収率が著しく低いため）

### 複勝オッズの刻み（1.0-20.0倍）

**完全なリスト**:
```python
FUKUSHO_ODDS_BINS = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,           # 1-10: 1刻み
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20   # 11-20: 1刻み
]

# 範囲として表現
FUKUSHO_ODDS_RANGES = [
    (1.0, 1.4),    # 1
    (1.5, 1.9),    # 1.5 (実質2の下限)
    (2.0, 2.4),    # 2
    (2.5, 2.9),    # 2.5 (実質3の下限)
    (3.0, 3.4),    # 3
    (3.5, 3.9),    # 3.5
    (4.0, 4.4),    # 4
    (4.5, 4.9),    # 4.5
    (5.0, 5.4),    # 5
    (5.5, 5.9),    # 5.5
    (6.0, 6.4),    # 6
    (6.5, 6.9),    # 6.5
    (7.0, 7.4),    # 7
    (7.5, 7.9),    # 7.5
    (8.0, 8.4),    # 8
    (8.5, 8.9),    # 8.5
    (9.0, 9.4),    # 9
    (9.5, 9.9),    # 9.5
    (10.0, 10.4),  # 10
    (10.5, 10.9),  # 10.5
    (11.0, 11.4),  # 11
    (11.5, 11.9),  # 11.5
    (12.0, 12.4),  # 12
    (12.5, 12.9),  # 12.5
    (13.0, 13.4),  # 13
    (13.5, 13.9),  # 13.5
    (14.0, 14.4),  # 14
    (14.5, 14.9),  # 14.5
    (15.0, 15.4),  # 15
    (15.5, 15.9),  # 15.5
    (16.0, 16.4),  # 16
    (16.5, 16.9),  # 16.5
    (17.0, 17.4),  # 17
    (17.5, 17.9),  # 17.5
    (18.0, 18.4),  # 18
    (18.5, 18.9),  # 18.5
    (19.0, 19.4),  # 19
    (19.5, 19.9),  # 19.5
    (20.0, float('inf'))  # 20+
]
```

**刻み方のロジック**:
- 1-20倍: **1刻み**（複勝は範囲が狭いため非常に細かく分析）
- **17倍以上: 1つの範囲として扱う**（回収率が著しく低いため）

---

## 🎯 実装のポイント

### 1. オッズ範囲の判定関数

```python
def get_tansho_odds_bin(odds):
    """
    単勝オッズから該当する範囲のラベルを返す
    
    Args:
        odds: float (単勝オッズ)
    
    Returns:
        label: str (例: "1-2.9", "3-4.9", ...)
    """
    if odds < 3.0:
        return "1-2.9"
    elif odds < 5.0:
        return "3-4.9"
    elif odds < 7.0:
        return "5-6.9"
    elif odds < 9.0:
        return "7-8.9"
    elif odds < 11.0:
        return "9-10.9"
    elif odds < 13.0:
        return "11-12.9"
    elif odds < 15.0:
        return "13-14.9"
    elif odds < 17.0:
        return "15-16.9"
    elif odds < 19.0:
        return "17-18.9"
    elif odds < 22.0:
        return "19-21.9"
    elif odds < 26.0:
        return "22-25.9"
    elif odds < 30.0:
        return "26-29.9"
    elif odds < 34.0:
        return "30-33.9"
    elif odds < 38.0:
        return "34-37.9"
    elif odds < 42.0:
        return "38-41.9"
    elif odds < 46.0:
        return "42-45.9"
    elif odds < 50.0:
        return "46-49.9"
    elif odds < 60.0:
        return "50-59.9"
    elif odds < 70.0:
        return "60-69.9"
    elif odds < 80.0:
        return "70-79.9"
    elif odds < 90.0:
        return "80-89.9"
    elif odds < 100.0:
        return "90-99.9"
    else:
        return "100+"


def get_fukusho_odds_bin(odds):
    """
    複勝オッズから該当する範囲のラベルを返す
    
    Args:
        odds: float (複勝オッズ)
    
    Returns:
        label: str (例: "1.0-1.4", "1.5-1.9", ...)
    """
    if odds < 1.5:
        return "1.0-1.4"
    elif odds < 2.0:
        return "1.5-1.9"
    elif odds < 2.5:
        return "2.0-2.4"
    elif odds < 3.0:
        return "2.5-2.9"
    elif odds < 3.5:
        return "3.0-3.4"
    elif odds < 4.0:
        return "3.5-3.9"
    elif odds < 4.5:
        return "4.0-4.4"
    elif odds < 5.0:
        return "4.5-4.9"
    elif odds < 5.5:
        return "5.0-5.4"
    elif odds < 6.0:
        return "5.5-5.9"
    elif odds < 6.5:
        return "6.0-6.4"
    elif odds < 7.0:
        return "6.5-6.9"
    elif odds < 7.5:
        return "7.0-7.4"
    elif odds < 8.0:
        return "7.5-7.9"
    elif odds < 8.5:
        return "8.0-8.4"
    elif odds < 9.0:
        return "8.5-8.9"
    elif odds < 9.5:
        return "9.0-9.4"
    elif odds < 10.0:
        return "9.5-9.9"
    elif odds < 10.5:
        return "10.0-10.4"
    elif odds < 11.0:
        return "10.5-10.9"
    elif odds < 11.5:
        return "11.0-11.4"
    elif odds < 12.0:
        return "11.5-11.9"
    elif odds < 12.5:
        return "12.0-12.4"
    elif odds < 13.0:
        return "12.5-12.9"
    elif odds < 13.5:
        return "13.0-13.4"
    elif odds < 14.0:
        return "13.5-13.9"
    elif odds < 14.5:
        return "14.0-14.4"
    elif odds < 15.0:
        return "14.5-14.9"
    elif odds < 15.5:
        return "15.0-15.4"
    elif odds < 16.0:
        return "15.5-15.9"
    elif odds < 16.5:
        return "16.0-16.4"
    elif odds < 17.0:
        return "16.5-16.9"
    elif odds < 17.5:
        return "17.0-17.4"
    elif odds < 18.0:
        return "17.5-17.9"
    elif odds < 18.5:
        return "18.0-18.4"
    elif odds < 19.0:
        return "18.5-18.9"
    elif odds < 19.5:
        return "19.0-19.4"
    elif odds < 20.0:
        return "19.5-19.9"
    else:
        return "20+"
```

### 2. pandas での集計例

```python
import pandas as pd

# オッズ範囲のラベルを追加
df['tansho_odds_bin'] = df['tansho_odds'].apply(get_tansho_odds_bin)
df['fukusho_odds_bin'] = df['fukusho_odds'].apply(get_fukusho_odds_bin)

# 単勝オッズ別に集計
tansho_summary = df.groupby('tansho_odds_bin').agg({
    'race_id': 'count',  # 対象数
    'tansho_hit': 'sum',  # 的中数
    'tansho_payoff': 'sum'  # 払戻総額
}).rename(columns={'race_id': 'count', 'tansho_hit': 'hits'})

# 的中率と回収率を計算
tansho_summary['hit_rate'] = tansho_summary['hits'] / tansho_summary['count'] * 100
tansho_summary['recovery_rate'] = tansho_summary['tansho_payoff'] / (tansho_summary['count'] * 100) * 100

# 複勝オッズ別に集計
fukusho_summary = df.groupby('fukusho_odds_bin').agg({
    'race_id': 'count',
    'fukusho_hit': 'sum',
    'fukusho_payoff': 'sum'
}).rename(columns={'race_id': 'count', 'fukusho_hit': 'hits'})

fukusho_summary['hit_rate'] = fukusho_summary['hits'] / fukusho_summary['count'] * 100
fukusho_summary['recovery_rate'] = fukusho_summary['fukusho_payoff'] / (fukusho_summary['count'] * 100) * 100
```

---

## 📊 出力フォーマット

### CSV出力例

**tansho_odds_analysis_crossfactor.csv**:
```csv
オッズ範囲,対象数,的中数,的中率,平均配当,回収率,補正回収率,信頼度
1-2.9,2150,1333,62.0%,120,74.4%,78.2%,2220
3-4.9,5840,2365,40.5%,168,68.0%,72.1%,4580
5-6.9,4200,1260,30.0%,280,84.0%,88.5%,3570
...
90-99.9,18500,1480,8.0%,940,75.2%,78.8%,1460
100+,35000,360,1.0%,4500,45.0%,22.5%,-20125
```

**fukusho_odds_analysis_crossfactor.csv**:
```csv
オッズ範囲,対象数,的中数,的中率,平均配当,回収率,補正回収率,信頼度
1.0-1.4,5200,4420,85.0%,105,89.2%,91.5%,598
1.5-1.9,6200,4030,65.0%,128,83.2%,85.8%,360
2.0-2.4,4800,1680,35.0%,215,75.2%,78.3%,-82
...
16.5-16.9,850,93,10.9%,820,89.3%,92.1%,102
17.0-17.4,780,70,9.0%,870,78.3%,65.2%,-1153
...
20+,15000,300,2.0%,2400,48.0%,24.0%,-84000
```

---

## 🎯 グラフ生成

### matplotlib での再現

```python
import matplotlib.pyplot as plt
import matplotlib
matplotlib.rcParams['font.family'] = 'MS Gothic'  # 日本語フォント

# 単勝グラフ
fig, ax = plt.subplots(figsize=(14, 6))

x_labels = ["1", "3", "5", "7", "9", "11", "13", "15", "17", "19", 
            "22", "26", "30", "34", "38", "42", "46", "50", 
            "60", "70", "80", "90", "100", "120", "140", "160", "180", "200"]
recovery_rates = tansho_summary['recovery_rate'].values

ax.plot(range(len(x_labels)), recovery_rates, marker='o', linewidth=2)
ax.set_xticks(range(len(x_labels)))
ax.set_xticklabels(x_labels, rotation=0)
ax.set_xlabel('単勝オッズ', fontsize=12)
ax.set_ylabel('回収率 (%)', fontsize=12)
ax.set_title('単勝オッズ別の単勝回収率', fontsize=14, fontweight='bold')
ax.axhline(y=80, color='red', linestyle='--', linewidth=1, label='基準値 (80%)')
ax.grid(True, alpha=0.3)
ax.legend()

plt.tight_layout()
plt.savefig('tansho_odds_recovery_rate.png', dpi=300)
plt.close()

# 複勝グラフ（同様）
```

---

## 📝 まとめ

### 検証刻みの決定

**単勝**: 1-100倍まで、CrossFactorのグラフと同じ刻み
- 1-19倍: 2刻み
- 22-50倍: 4刻み
- 60-100倍: 10刻み
- **100倍以上: 除外または1つの範囲として扱う**

**複勝**: 1-20倍まで、CrossFactorのグラフと同じ刻み
- 1-20倍: 1刻み（0.5刻みの可能性もあり）
- **17倍以上: 除外または1つの範囲として扱う**

### Phase 2A/2B での利用

- Phase 2A（基本版）: この刻みで均等買い方式で集計
- Phase 2B（補正版）: この刻みで均等払戻方式 + 期間重み付け + オッズ補正を適用

---

**最終更新**: 2026-02-28 17:30 JST
