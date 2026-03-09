# Phase 2C 偏差値・購入推奨機能実装完了報告

**作成日**: 2026-03-01  
**更新者**: GenSpark AI Developer  
**リポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra  
**ブランチ**: `genspark_ai_developer`  
**コミット**: `d95ad36`

---

## 📋 実装概要

Phase 2C分析結果に基づき、レース内偏差値の計算と購入推奨ロジックを実装しました。

### 主な変更点

1. **偏差値計算機能の追加**
   - レース内でensemble_scoreから偏差値を計算
   - 標準偏差0の場合は偏差値50を割り当て

2. **偏差値ランク付与機能**
   - S/A/B/C/D/Eの6段階評価
   - Phase 2C分析で実証された区分を使用

3. **購入推奨判定機能**
   - Phase 2C分析の回収率80%以上基準を適用
   - Sランク: 全オッズ推奨
   - Aランク: オッズ5倍未満推奨
   - Bランク: オッズ3倍未満推奨

4. **出力フォーマット更新**
   - Markdown、note、ブッカーズ形式すべてに偏差値情報を追加
   - CSV出力に`hensachi`と`hensachi_rank`カラムを追加

---

## 🔧 実装詳細

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

### 2. 偏差値ランク付与

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

### 3. 購入推奨判定

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

## 📊 偏差値ランク定義

| ランク | 偏差値範囲 | 説明 | 購入推奨基準 |
|:---:|:---:|:---:|:---:|
| **S** | 70以上 | レース内最上位 | **全オッズ推奨** |
| **A** | 65-70 | レース内上位 | **オッズ5倍未満** |
| **B** | 60-65 | レース内中上位 | **オッズ3倍未満** |
| **C** | 55-60 | レース内平均以上 | 推奨しない |
| **D** | 50-55 | レース内平均 | 推奨しない |
| **E** | 50未満 | レース内下位 | 推奨しない |

---

## 💰 購入推奨基準（Phase 2C分析結果）

### 単勝推奨パターン

| ランク×オッズ帯 | 回収率 | 的中率 | 年間出現数 | 判定 |
|:---:|---:|---:|---:|:---:|
| S × 全オッズ | 492% | 23.4% | 218頭 | ✅ 推奨 |
| A × 1-4.9倍 | 84-87% | 22-38% | 217頭 | ✅ 推奨 |
| B × 1-2.9倍 | 90% | 41% | 187頭 | ✅ 推奨 |
| C/D/E × 全オッズ | 80%未満 | - | - | ❌ 非推奨 |

### 実戦例

#### ✅ 推奨例1: Sランク × オッズ20倍
- **偏差値**: 72.5 (Sランク)
- **オッズ**: 20.0倍
- **判定**: 🌟 **購入推奨**（Sランクは全オッズ推奨）
- **根拠**: 年間218頭中51頭的中、回収率492%

#### ✅ 推奨例2: Aランク × オッズ3.5倍
- **偏差値**: 66.8 (Aランク)
- **オッズ**: 3.5倍
- **判定**: ⭐ **購入推奨**（Aランク × オッズ5倍未満）
- **根拠**: 回収率87%、的中率22%

#### ✅ 推奨例3: Bランク × オッズ2.1倍
- **偏差値**: 61.2 (Bランク)
- **オッズ**: 2.1倍
- **判定**: ✅ **購入推奨**（Bランク × オッズ3倍未満）
- **根拠**: 回収率90%、的中率41%

#### ❌ 非推奨例1: Aランク × オッズ15倍
- **偏差値**: 67.3 (Aランク)
- **オッズ**: 15.0倍
- **判定**: ❌ **非推奨**（Aランクでもオッズ5倍以上は回収率低下）

#### ❌ 非推奨例2: Cランク × オッズ2.5倍
- **偏差値**: 56.1 (Cランク)
- **オッズ**: 2.5倍
- **判定**: ❌ **非推奨**（Cランク以下は推奨対象外）

---

## 📈 出力フォーマット例

### Markdown形式（results/predictions_YYYYMMDD.md）

```markdown
### 📊 予想順位

**1. 5番 サンプル馬1** （スコア: 0.78 / A） | 偏差値 72.3 (S)
2. 3番 サンプル馬2 （スコア: 0.65 / B） | 偏差値 66.1 (A)
3. 8番 サンプル馬3 （スコア: 0.58 / C） | 偏差値 61.8 (B)

### 💰 購入推奨

**🎯 本命軸**
- 単勝: **5番**
  💰 **購入推奨**: 🌟 Sランク（偏差値70以上）: 全オッズ帯で購入推奨
```

### CSV形式（results/predictions_YYYYMMDD.csv）

新規追加カラム:
- `hensachi`: レース内偏差値（float型、例: 72.3）
- `hensachi_rank`: 偏差値ランク（str型、例: 'S'）

---

## 🔄 変更されたファイル

### 修正ファイル
1. **`scripts/phase6/phase6_daily_prediction_phase2c.py`**
   - 偏差値計算関数追加
   - 偏差値ランク付与関数追加
   - 購入推奨判定関数追加
   - 全出力フォーマット更新

### 新規ファイル
2. **`analyze_phase2c_by_rank.py`**
   - ランク別オッズ帯分析スクリプト
   - Phase 2C検証結果の詳細確認用

---

## ✅ 動作確認項目

### 必須確認事項

- [x] 偏差値計算が各レース内で正しく実行される
- [x] 偏差値ランク（S/A/B/C/D/E）が正しく付与される
- [x] 購入推奨判定ロジックが正しく動作する
- [x] Markdown形式出力に偏差値情報が含まれる
- [x] CSV出力に偏差値カラムが含まれる
- [x] note形式出力が正しく生成される
- [x] ブッカーズ形式出力が正しく生成される

### テスト実行方法（Windows環境）

```powershell
# 1. 最新コードを取得
cd E:\anonymous-keiba-ai-JRA
git fetch origin genspark_ai_developer
git checkout genspark_ai_developer
git pull origin genspark_ai_developer

# 2. 予測実行（2025年1月データで検証）
python batch_predict_2025_phase2c.py

# 3. 出力確認
# - results\validation\predictions_2025_phase2c\csv\predictions_20250105.csv を開く
# - hensachi、hensachi_rank カラムが追加されていることを確認

# 4. 分析実行
python scripts\validation\validate_hensachi_odds_matrix.py `
    --year 2025 `
    --month 1 `
    --predictions-dir results\validation\predictions_2025_phase2c\csv `
    --output results\validation\hensachi_odds_matrix_phase2c

# 5. レポート確認
# - hensachi_odds_matrix_report.md を開いて推奨パターンを確認
```

---

## 🎯 次のステップ（オプション）

### Phase 3: リアルタイム予測への統合

1. **オッズ取得機能追加**
   - JRA-VANリアルタイムオッズ取得
   - オッズ変動モニタリング

2. **購入推奨自動出力**
   - 推奨馬を自動的にnote/Twitter形式で出力
   - 偏差値ランク1位の馬が推奨基準を満たす場合に通知

3. **バックテスト機能**
   - 過去データでの購入推奨精度検証
   - ROI、的中率の統計レポート

---

## 📝 重要な注意事項

### ⚠️ レース内偏差値について

**現在の実装では「レース内での相対評価」のみを使用しています**:

- ✅ 同一レース内の馬同士の比較は可能
- ❌ 異なるレース間での偏差値比較は意味がない
- ❌ 過去レースとの偏差値比較は不可

例:
- **レースA**: 1位馬の偏差値75 → レースA内で最上位
- **レースB**: 1位馬の偏差値72 → レースB内で最上位
- ⚠️ レースAの75とレースBの72を直接比較することはできない

### 🎯 購入推奨判定のタイミング

購入推奨判定を行うには**オッズ情報が必要**です:

1. **リアルタイム予測時**: JRA-VANからオッズを取得して判定
2. **バックテスト時**: jvd_o1テーブルから確定オッズを取得して判定
3. **事前予測時**: オッズ未確定のため購入推奨は表示されない

---

## 🔗 関連ドキュメント

- [Phase 2C 正しい検証実施手順書](./PHASE2C_CORRECT_VALIDATION_GUIDE.md)
- [Phase 2C 分析結果レポート](./results/validation/hensachi_odds_matrix_phase2c/hensachi_odds_matrix_report.md)

---

## 📞 お問い合わせ・フィードバック

実装に関するご質問や改善提案がありましたら、GitHub Issuesまたはプルリクエストのコメントでお知らせください。

**実装完了日**: 2026-03-01  
**次回アップデート予定**: Phase 3実装時
