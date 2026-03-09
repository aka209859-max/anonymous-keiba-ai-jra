# JRA競馬AI開発 クイックスタート

**作成日**: 2026-02-22  
**現在地**: Phase 2-A 完了 → Phase 2-B から開始

---

## 📍 現在の状況

✅ **Phase 2-A 完了**: 10競馬場のデータ生成済み

**生成済みファイル** (`E:\anonymous-keiba-ai-JRA\data\features\`):
1. `01_2016-2025_features.csv`（札幌: 20,063行）
2. `02_2016-2025_features.csv`（函館: 17,864行）
3. `03_2016-2025_features.csv`（福島: 33,295行）
4. `04_2016-2025_features.csv`（新潟: 46,666行）
5. `05_2016-2025_features.csv`（東京: 77,473行）
6. `06_2016-2025_features.csv`（中山: 73,085行）
7. `07_2016-2025_features.csv`（中京: 52,367行）
8. `08_2016-2025_features.csv`（京都: 55,680行）
9. `09_2016-2025_features.csv`（阪神: 68,290行）
10. `10_summer_2016-2025_features.csv`（小倉夏: 19,375行）
11. `10_winter_2016-2025_features.csv`（小倉冬: 19,375行）

**合計**: 483,533行、139列

---

## 🎯 これからやること（Phase 2-B → Phase 5）

### 全体スケジュール: **6-9日（約1週間）**

```
Phase 2-B: データ統合（30分）       ← 今ここから開始
    ↓
Phase 3: 二値分類モデル（2-3日）
    ↓
Phase 4-A: ランキングモデル（1日）
    ↓
Phase 4-B: 回帰モデル（1日）
    ↓
Phase 5: アンサンブル統合（1-2日）
    ↓
✅ 完成！
```

---

## ⚡ 即座に実行すべきコマンド

### Phase 2-B: データ統合（所要時間: 約30分）

#### ステップ1: 統合スクリプト作成

`E:\anonymous-keiba-ai-JRA\scripts\phase2\merge_all_features.py` を以下の内容で作成:

```python
import pandas as pd
import glob
from pathlib import Path

def merge_all_features():
    print("📂 Phase 2-B: データ統合開始...")
    
    csv_files = sorted(glob.glob('data/features/*_2016-2025_features.csv'))
    print(f"✅ 検出ファイル: {len(csv_files)}個")
    
    dfs = []
    for f in csv_files:
        df = pd.read_csv(f, encoding='utf-8')
        print(f"  {Path(f).name}: {len(df):,}行")
        dfs.append(df)
    
    all_df = pd.concat(dfs, ignore_index=True)
    
    print(f"\n📊 統合結果:")
    print(f"  総行数: {len(all_df):,}行")
    print(f"  総列数: {len(all_df.columns)}列")
    print(f"  重複行数: {all_df.duplicated().sum()}行")
    
    output_path = 'data/features/all_tracks_2016-2025_features.csv'
    all_df.to_csv(output_path, index=False, encoding='utf-8')
    
    file_size_mb = Path(output_path).stat().st_size / (1024 * 1024)
    print(f"\n💾 保存完了: {output_path}")
    print(f"  サイズ: {file_size_mb:.1f} MB")
    print(f"\n✅ Phase 2-B 完了！")

if __name__ == '__main__':
    merge_all_features()
```

#### ステップ2: 実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase2\merge_all_features.py
```

#### ステップ3: 確認

```powershell
Get-ChildItem data\features\all_tracks_2016-2025_features.csv | Format-List Name, Length, LastWriteTime
```

### 成功基準
- ✅ ファイル `all_tracks_2016-2025_features.csv` が生成される
- ✅ 行数: **480,000 ～ 485,000**
- ✅ 列数: **139**
- ✅ サイズ: **300 ～ 400 MB**

---

## 📋 Phase 2-B 完了後の報告テンプレート

Phase 2-B が完了したら、以下の情報を報告してください：

```
✅ Phase 2-B 完了報告

【実行時間】: XX分

【生成ファイル】:
- ファイル名: all_tracks_2016-2025_features.csv
- 行数: XXX,XXX行
- 列数: XXX列
- サイズ: XXX.X MB
- 重複行数: XXX行

【検証結果】:
- 行数が 480,000 ～ 485,000 の範囲内: ✅ / ❌
- 列数が 139: ✅ / ❌
- 重複率 < 0.01%: ✅ / ❌

【次のステップ】:
Phase 3 の詳細手順を提供してください。
```

---

## 📚 全体ドキュメント

詳細なロードマップは以下を参照:
- `JRA_COMPLETE_ROADMAP_PHASE2B_TO_PHASE5.md`

---

## 🔧 トラブルシューティング

### ファイルが11個見つからない
```powershell
# ファイル確認
Get-ChildItem data\features\*_2016-2025_features.csv
```
→ ファイル名が異なる場合、スクリプトの `glob.glob()` パターンを修正

### メモリエラー
- 不要なアプリを閉じる
- 64bit Pythonを使用していることを確認

### エンコーディングエラー
- `encoding='utf-8'` を `encoding='shift-jis'` に変更

---

## ✅ 重要な注意事項

1. **Phase 2-B は必須**: Phase 3 以降で全競馬場データを統合学習するため
2. **地方競馬との違い**: 地方競馬は競馬場ごとに個別学習、JRAは統合学習
3. **ファイル保存**: 必ずプロジェクトルート `E:\anonymous-keiba-ai-JRA\` に保存
4. **各Phase完了後**: 必ず報告して次の手順を受け取る

---

**今すぐ実行**: Phase 2-B のスクリプトを作成して実行してください！

**所要時間**: 約30分

**完了後**: Phase 3 の詳細手順を提供します。
