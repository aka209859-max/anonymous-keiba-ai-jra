# Phase 6 本番スクリプト更新完了報告

**更新日**: 2026-03-01  
**対象ファイル**: `scripts/phase6/phase6_daily_prediction.py`  
**コミット**: `06b5a17`  
**ブランチ**: `genspark_ai_developer`

---

## 📋 更新内容サマリー

本番用の Phase 6 予測スクリプトに、Phase 2C分析結果に基づく **偏差値計算** と **購入推奨ロジック** を追加しました。

### 主な変更点

1. **偏差値計算機能**（レース内相対評価）
2. **偏差値ランク付与**（S/A/B/C/D/E）
3. **購入推奨判定ロジック**（回収率80%以上基準）
4. **note形式出力に偏差値・購入推奨を追加**
5. **ブッカーズ形式出力に偏差値・購入推奨を追加**

**※重要**: CSV/Markdown出力は変更していません（ユーザー要望により、note/ブッカーズ/Twitterのみ更新）

---

## 🔧 追加された関数

### 1. 偏差値計算関数

```python
def calculate_hensachi_for_race(group):
    """レース内で偏差値を計算
    
    偏差値 = 50 + 10 × (スコア - 平均) / 標準偏差
    """
    mean = group['ensemble_score'].mean()
    std = group['ensemble_score'].std()
    
    if std == 0 or pd.isna(std):
        group['hensachi'] = 50.0
    else:
        z_score = (group['ensemble_score'] - mean) / std
        group['hensachi'] = 50 + 10 * z_score
    
    return group
```

### 2. 偏差値ランク付与関数

```python
def assign_hensachi_rank(hensachi: float) -> str:
    """偏差値からランクを付与（S/A/B/C/D/E）"""
    if hensachi >= 70.0:
        return 'S'
    elif hensachi >= 65.0:
        return 'A'
    elif hensachi >= 60.0:
        return 'B'
    elif hensachi >= 55.0:
        return 'C'
    elif hensachi >= 50.0:
        return 'D'
    else:
        return 'E'
```

### 3. 購入推奨判定関数

```python
def should_recommend_purchase(hensachi_rank: str, tansho_odds: float) -> tuple:
    """購入推奨判定（Phase 2C分析結果に基づく）
    
    判定基準（回収率80%以上）:
    - Sランク: 問答無用で購入推奨
    - Aランク: オッズ5倍未満なら購入推奨
    - Bランク: オッズ3倍未満なら購入推奨
    
    Returns:
        tuple: (bool, str) = (購入推奨フラグ, 推奨理由)
    """
    if pd.isna(tansho_odds):
        return False, ""
    
    if hensachi_rank == 'S':
        return True, "🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨"
    elif hensachi_rank == 'A' and tansho_odds < 5.0:
        return True, f"⭐ Aランク（偏差値65-70）× オッズ{tansho_odds:.1f}倍: 回収率80%以上"
    elif hensachi_rank == 'B' and tansho_odds < 3.0:
        return True, f"✅ Bランク（偏差値60-65）× オッズ{tansho_odds:.1f}倍: 回収率80%以上"
    else:
        return False, ""
```

---

## 📈 出力フォーマット例

### note形式（`results/{競馬場名}_{日付}_note.txt`）

```markdown
## 🏇 東京 第1R 予想

### 📊 予想順位

**1. 5番 サンプル馬1** （スコア: 0.78 / A） | 偏差値 72.3 (S)
  💰 **購入推奨**: 🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨
2. 3番 サンプル馬2 （スコア: 0.65 / B） | 偏差値 66.1 (A)
3. 8番 サンプル馬3 （スコア: 0.58 / C） | 偏差値 61.8 (B)
```

### ブッカーズ形式（`results/{競馬場名}_{日付}_bookers.txt`）

```
🏁 東京 第1R 予想結果

🎯 AI推奨馬

◎ 5 サンプル馬1 (ランクA / 偏差値72.3(S))
AIスコア: 0.78
💰 購入推奨: 🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨

○ 3 サンプル馬2 (ランクB / 偏差値66.1(A))
AIスコア: 0.65
```

---

## 💰 購入推奨基準（Phase 2C分析結果）

| ランク | 偏差値範囲 | 購入推奨条件 | 根拠（回収率） |
|:---:|:---:|:---:|:---:|
| **S** | 70以上 | **全オッズ推奨** | 492%（218頭） |
| **A** | 65-70 | **オッズ5倍未満** | 84-87%（217頭） |
| **B** | 60-65 | **オッズ3倍未満** | 90%（187頭） |
| **C** | 55-60 | 推奨しない | 80%未満 |
| **D** | 50-55 | 推奨しない | 80%未満 |
| **E** | 50未満 | 推奨しない | 80%未満 |

---

## ⚙️ 動作フロー

### 1. 偏差値計算タイミング

```python
# ensemble_predict関数内（Line 673付近）
result_df = pd.concat(race_normalized, ignore_index=True)

logger.info(f"✅ アンサンブルスコア計算完了")

# 偏差値計算（レース内で標準化）← ここで計算
logger.info("\n🔧 偏差値計算中...")
result_df = result_df.groupby('race_id').apply(calculate_hensachi_for_race)
result_df = result_df.reset_index(drop=True)

# 偏差値ランク付与
result_df['hensachi_rank'] = result_df['hensachi'].apply(assign_hensachi_rank)

logger.info(f"✅ 偏差値計算完了")
logger.info(f"偏差値範囲: {result_df['hensachi'].min():.2f} - {result_df['hensachi'].max():.2f}")
```

### 2. 出力時の処理

#### note形式（Line 1002付近）
```python
for idx, row in group.iterrows():
    rank = int(row['predicted_rank'])
    umaban = int(row['umaban'])
    bamei = str(row.get('bamei', f"{umaban}番馬")).strip()
    score = row['ensemble_score']
    score_rank = get_score_rank(score)
    hensachi = row.get('hensachi', np.nan)
    hensachi_rank = row.get('hensachi_rank', '')
    
    # 偏差値情報を追加
    hensachi_str = f" | 偏差値 {hensachi:.1f} ({hensachi_rank})" if not pd.isna(hensachi) else ""
    
    # 1位の馬の場合、購入推奨判定を追加
    recommendation_str = ""
    if rank == 1 and 'tansho_odds' in row:
        should_buy, reason = should_recommend_purchase(hensachi_rank, row.get('tansho_odds', np.nan))
        if should_buy:
            recommendation_str = f"\n  💰 **購入推奨**: {reason}"
    
    if rank <= 3:
        lines.append(f"**{rank}. {umaban}番 {bamei}** （スコア: {score:.2f} / {score_rank}{hensachi_str}）{recommendation_str}")
    else:
        lines.append(f"{rank}. {umaban}番 {bamei} （スコア: {score:.2f} / {score_rank}{hensachi_str}）")
```

---

## ⚠️ 重要な注意事項

### 1. オッズ情報が必要

購入推奨判定を行うには **単勝オッズ情報** が必要です。

- ✅ **リアルタイム予測時**: JRA-VANからオッズを取得して判定
- ✅ **バックテスト時**: jvd_o1テーブルから確定オッズで判定
- ❌ **事前予測時**: オッズ未確定のため購入推奨は表示されない

**現在のスクリプトでは**:
- オッズ情報がない場合、購入推奨は表示されません
- 偏差値と偏差値ランクのみが表示されます

### 2. レース内偏差値の解釈

- ✅ 同一レース内の馬同士の比較は可能
- ❌ 異なるレース間の偏差値比較は意味がない
- ❌ 過去レースとの偏差値比較は不可

### 3. 後方互換性

- 旧`get_score_rank()`関数は残してあります（互換性のため）
- 既存のコードは影響を受けません

---

## 🧪 テスト方法（Windowsユーザー向け）

### ステップ1: 最新コードを取得

```powershell
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer
```

### ステップ2: 予測実行

```powershell
# 例: 2026年2月21日の予測
python scripts\phase6\phase6_daily_prediction.py --target-date 20260221
```

### ステップ3: 出力確認

note形式とブッカーズ形式のファイルを確認:
```
results\
  ├── 東京_20260221_note.txt
  ├── 東京_20260221_bookers.txt
  └── 東京_20260221_tweet.txt
```

**確認項目**:
- [ ] 各馬に偏差値（例: 偏差値 72.3 (S)）が表示されているか
- [ ] 1位の馬に購入推奨が表示されているか（条件を満たす場合）
- [ ] 偏差値ランクが S/A/B/C/D/E で表示されているか

---

## 📝 今後の拡張可能性

### Phase 3: オッズ連携

```python
# オッズ取得機能を追加する場合
def fetch_realtime_odds(race_id, umaban):
    """JRA-VANからリアルタイムオッズを取得"""
    # JRA-VAN API連携
    return odds_value

# 予測実行時にオッズを取得
result_df['tansho_odds'] = result_df.apply(
    lambda row: fetch_realtime_odds(row['race_id'], row['umaban']),
    axis=1
)
```

### Phase 4: 自動購入推奨通知

```python
# 購入推奨馬を自動抽出
recommended_horses = result_df[
    result_df.apply(
        lambda row: should_recommend_purchase(
            row['hensachi_rank'], 
            row.get('tansho_odds', np.nan)
        )[0],
        axis=1
    )
]

# Twitter/LINE通知
for _, horse in recommended_horses.iterrows():
    send_notification(f"🌟 購入推奨: {horse['bamei']} ({horse['hensachi_rank']}ランク)")
```

---

## 🔗 関連ドキュメント

- [Phase 2C 偏差値実装ドキュメント](./PHASE2C_DEVIATION_SCORE_IMPLEMENTATION.md)
- [Phase 2C 検証手順書](./PHASE2C_CORRECT_VALIDATION_GUIDE.md)

---

## 📞 質問・フィードバック

実装に関するご質問や改善提案がありましたら、GitHub Issuesまたはプルリクエストのコメントでお知らせください。

**更新完了日**: 2026-03-01  
**次回アップデート予定**: オッズ連携機能実装時
