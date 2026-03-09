# 🏇 小倉競馬場の季節分割ルール詳細

## 📋 基本情報

### 小倉競馬場の特別扱い理由
小倉競馬場（keibajo_code = '10'）は、JRA中央競馬の中で唯一、**季節によって馬場特性が大きく異なる**ため、夏季と冬季で別の競馬場として扱います。

---

## 🗓️ 季節分割ルール

### 10_summer（小倉夏開催）
- **開催月**: **7月〜8月**
- **季節コード**: `'10_summer'`
- **特徴**:
  - 気温: 30℃超（猛暑）
  - 湿度: 高湿度（多湿）
  - 芝状態: 夏枯れ、芝傷み
  - ペース: 前半スローになりやすい
  - 馬体質: 夏バテしない馬が有利
  - レース格: 夏の地方重賞級が多い

### 10_winter（小倉冬開催）
- **開催月**: **1月〜2月**
- **季節コード**: `'10_winter'`
- **特徴**:
  - 気温: 10℃前後（寒冷）
  - 湿度: 低湿度
  - 芝状態: 冬芝良好、締まった馬場
  - ペース: 前半速いペースになりやすい
  - 馬体質: 寒さに強い馬が有利
  - レース格: 春シーズンの前哨戦（準OP～OP級）

---

## 🔧 実装方法

### SQL実装（Phase 1で使用）

#### 方法1: kaisai_tsukihi（開催月日）から判定
```sql
-- kaisai_tsukihiは4桁文字列 '0715' (7月15日), '0210' (2月10日) など
CASE 
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi, 1, 2) AS INTEGER) IN (7, 8) 
        THEN '10_summer'  -- 7月または8月
    WHEN keibajo_code = '10' AND CAST(SUBSTRING(kaisai_tsukihi, 1, 2) AS INTEGER) IN (1, 2) 
        THEN '10_winter'  -- 1月または2月
    ELSE keibajo_code  -- 他の競馬場はそのまま
END AS keibajo_season_code
```

#### 方法2: monthカラム（派生カラム）から判定
```sql
-- monthが既に計算済みの場合
CASE 
    WHEN keibajo_code = '10' AND month IN (7, 8) THEN '10_summer'
    WHEN keibajo_code = '10' AND month IN (1, 2) THEN '10_winter'
    ELSE keibajo_code
END AS keibajo_season_code
```

---

## ⚠️ 重要な注意点

### 1. 小倉競馬場の開催スケジュール
JRA公式の開催スケジュールでは：
- **夏開催**: 7月〜8月（毎年）
- **冬開催**: 1月〜2月（毎年）
- **その他の月**: 小倉競馬場では基本的にレースは開催されない

### 2. データ品質確認が必要
もし小倉競馬場で3月〜6月、9月〜12月のデータがある場合は：
- データエラーの可能性
- または特別開催（稀）

実際のデータで確認すべき：
```sql
-- 小倉競馬場の開催月分布を確認
SELECT 
    CAST(SUBSTRING(kaisai_tsukihi, 1, 2) AS INTEGER) AS month,
    COUNT(*) AS record_count
FROM jvd_ra  -- JRA-VANレーステーブル
WHERE keibajo_code = '10'
GROUP BY month
ORDER BY month;
```

### 3. Phase 1-Cでの扱い
現在のPhase 1-Cスクリプトでは、小倉競馬場の季節分割は**まだ実装されていません**。

理由：
- Phase 1-A（JRA-VAN抽出）では`keibajo_code`のみ使用
- Phase 1-B（JRDB抽出）では`keibajo_code`のみ使用
- Phase 1-C（統合）では既存のコードをそのまま使用

**Phase 1-Dで実装予定**：
- `keibajo_season_code`カラムを派生特徴量として追加
- 小倉競馬場のみ、月情報から`10_summer`/`10_winter`に変換

---

## 📊 小倉競馬場データ統計（参考）

### 期待されるレコード数比率
| 競馬場コード | 開催期間 | 年間レース数（推定） |
|------------|---------|-------------------|
| 10_summer | 7〜8月（2ヶ月） | 約50〜70レース |
| 10_winter | 1〜2月（2ヶ月） | 約50〜70レース |
| **合計** | **年間4ヶ月** | **約100〜140レース** |

他の主要競馬場（東京・中山・阪神等）は年間200〜300レース程度なので、小倉は**相対的にレース数が少ない**。

---

## 🔄 Phase 1-D実装計画

### 追加する派生特徴量
Phase 1-Dで以下のカラムを追加予定：

#### 1. keibajo_season_code
```python
# Phase 1-D実装例（pandas）
import pandas as pd

# kaisai_tsukihiから月を抽出（'0715' → 7）
df['month'] = df['kaisai_tsukihi'].str[:2].astype(int)

# 小倉競馬場の季節分割
def create_season_code(row):
    if row['keibajo_code'] == '10':
        if row['month'] in [7, 8]:
            return '10_summer'
        elif row['month'] in [1, 2]:
            return '10_winter'
        else:
            # 例外: 小倉で7,8,1,2以外の月はエラー記録
            return '10_unknown'
    else:
        return row['keibajo_code']

df['keibajo_season_code'] = df.apply(create_season_code, axis=1)
```

#### 2. データ品質チェック
```python
# 小倉で想定外の月がないか確認
kokura_data = df[df['keibajo_code'] == '10']
invalid_kokura = kokura_data[~kokura_data['month'].isin([1, 2, 7, 8])]

if len(invalid_kokura) > 0:
    print(f"警告: 小倉競馬場で想定外の開催月が {len(invalid_kokura)} 件あります")
    print(invalid_kokura[['kaisai_nen', 'kaisai_tsukihi', 'month']].head(10))
```

---

## 📝 まとめ

### 小倉競馬場分割ルール
| 項目 | 10_summer | 10_winter |
|------|-----------|-----------|
| **開催月** | **7月〜8月** | **1月〜2月** |
| **気温** | 30℃超 | 10℃前後 |
| **芝状態** | 夏枯れ | 良好 |
| **ペース** | スロー傾向 | 速い傾向 |
| **判定SQL** | `month IN (7, 8)` | `month IN (1, 2)` |

### 現在の実装状況
- ✅ **Phase 1-A**: `keibajo_code = '10'`として抽出済み（季節分割なし）
- ✅ **Phase 1-B**: `keibajo_code = 10`として抽出済み（季節分割なし）
- ⏳ **Phase 1-C**: `keibajo_code = '10'`として結合予定（季節分割なし）
- ⬜ **Phase 1-D**: `keibajo_season_code`を派生特徴量として追加予定（季節分割あり）

### 次のステップ
1. **Phase 1-C実行**: 現状のまま`keibajo_code = '10'`で統合
2. **Phase 1-D実装**: 月情報から`keibajo_season_code`を計算し、`10_summer`/`10_winter`に分割
3. **Phase 2以降**: `keibajo_season_code`を特徴量として使用（11パターン）

---

**重要**: Phase 1-Cは現状のまま実行してOKです。小倉の季節分割はPhase 1-Dで実装します！

**作成日**: 2026-02-20  
**ステータス**: Phase 1-D実装待ち
