# 小倉競馬場 季節分割変更

## 変更内容

**コミット**: ef58beb

### 修正前
- **冬季**: 1-2月
- **夏季**: 7-8月

### 修正後
- **冬季**: 1-3月（1月、2月、3月）
- **夏季**: 7-9月（7月、8月、9月）

---

## 修正ファイル

`scripts/phase1/extract_jra_features_v1.py` の127-130行目:

```python
if keibajo_code == '10':
    month = int(kaisai_tsukihi[:2])
    if month in [7, 8, 9]:  # 修正: 7,8 → 7,8,9
        return '10_summer'
    elif month in [1, 2, 3]:  # 修正: 1,2 → 1,2,3
        return '10_winter'
```

---

## 更新手順（ローカルPC）

### PowerShellで実行:

```powershell
cd E:\anonymous-keiba-ai-JRA

# 既存スクリプトのバックアップ（任意）
Copy-Item scripts\phase1\extract_jra_features_v1.py scripts\phase1\extract_jra_features_v1.py.before_kokura

# ブラウザで以下のURLを開き、全選択→コピー
# https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/ef58beb/scripts/phase1/extract_jra_features_v1.py

# メモ帳で scripts\phase1\extract_jra_features_v1.py を開いて全選択→貼り付け→上書き保存
```

または、アップロードした修正済みファイルを手動で配置してください。

---

## 確認

```powershell
cd E:\anonymous-keiba-ai-JRA

# 修正箇所を確認
Get-Content scripts\phase1\extract_jra_features_v1.py | Select-Object -Index 126,127,128,129
```

**期待される出力**:
```python
        month = int(kaisai_tsukihi[:2])
        if month in [7, 8, 9]:
            return '10_summer'
        elif month in [1, 2, 3]:
```

---

## 小倉データ生成

```powershell
cd E:\anonymous-keiba-ai-JRA

python scripts\phase1\extract_jra_features_v1.py `
    --keibajo 10 `
    --start-year 2016 `
    --end-year 2025 `
    --output-dir data\features `
    --db-config config\db_config.yaml
```

---

## 期待される出力

### ファイル

- `10_summer_2016-2025_features.csv` (7-9月データ)
- `10_winter_2016-2025_features.csv` (1-3月データ)

### 行数の見積もり

小倉の総レコード数を3ヶ月ベースで分割:
- **冬季（1-3月）**: 約29,000行
- **夏季（7-9月）**: 約29,000行
- **合計**: 約58,000行

※ 前回の見積もり（各19,375行）は2ヶ月ベースだったため、3ヶ月に増えると約1.5倍になります

### ログ確認

```
[出力] 10_summer: XXXXX行 → ...10_summer_2016-2025_features.csv
[出力] 10_winter: XXXXX行 → ...10_winter_2016-2025_features.csv
================================================================================
✅ 特徴量抽出完了
================================================================================
```

---

## 関連リンク

- **コミット**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/ef58beb
- **修正スクリプト**: https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/ef58beb/scripts/phase1/extract_jra_features_v1.py
- **リポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra

