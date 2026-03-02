# 東京競馬場データ修正手順

## 問題の概要
- **検出日**: 2026-02-22
- **問題**: 東京競馬場データに馬番99の無効レコードが164件存在
- **原因**: WHERE句に馬番の範囲フィルターがなかった
- **影響**: 東京のみ、他8競馬場は影響なし

## 修正内容
**コミット**: e6ef575
**ファイル**: `scripts/phase1/extract_jra_features_v1.py`
**変更箇所**: 229行目のWHERE句

```sql
-- 修正前
WHERE ra.keibajo_code = %s
  AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN %s AND %s

-- 修正後
WHERE ra.keibajo_code = %s
  AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN %s AND %s
  AND se.umaban <= 18  -- 無効データ(馬番99等)を除外
```

## 修正スクリプトのダウンロード

### PowerShellコマンド
```powershell
cd E:\anonymous-keiba-ai-JRA

# スクリプト更新
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/e6ef575/scripts/phase1/extract_jra_features_v1.py" -OutFile "scripts\phase1\extract_jra_features_v1.py"

# 更新確認
Select-String -Path "scripts\phase1\extract_jra_features_v1.py" -Pattern "se.umaban <= 18" -Context 2
```

**期待出力**:
```
227:      AND CAST(ra.kaisai_nen AS INTEGER) BETWEEN %s AND %s
228>      AND se.umaban <= 18  -- 無効データ(馬番99等)を除外
229:    ORDER BY ra.kaisai_nen, ra.kaisai_tsukihi, ra.race_bango, se.umaban
```

## 東京競馬場データ再生成

### 1. 旧ファイル削除
```powershell
cd E:\anonymous-keiba-ai-JRA
Remove-Item data\features\05_2016-2025_features.csv -Force
Write-Host "✅ 旧東京データ削除完了"
```

### 2. 再実行
```powershell
python scripts\phase1\extract_jra_features_v1.py `
    --keibajo 05 `
    --start-year 2016 `
    --end-year 2025 `
    --output-dir data\features `
    --db-config config\db_config.yaml
```

**期待処理時間**: 90-110分

### 3. 検証

#### ファイル情報確認
```powershell
Get-ChildItem data\features\05_2016-2025_features.csv | Select Name, @{N='SizeMB';E={[math]::Round($_.Length/1MB,1)}}, LastWriteTime
```

**期待出力**:
```
Name                           SizeMB LastWriteTime
----                           ------ -------------
05_2016-2025_features.csv       62.1 2026-02-22 ...
```

#### 行数・列数確認
```powershell
python -c "
import pandas as pd
df = pd.read_csv('data/features/05_2016-2025_features.csv', low_memory=False)
print(f'総行数: {len(df):,} 行')
print(f'総列数: {len(df.columns)} 列')
print(f'期待行数: 77,309 行 (修正前: 77,473 行)')
"
```

**期待結果**:
- **総行数**: 77,309 行 (164行減少)
- **総列数**: 139 列
- **差分**: 77,473 - 164 = 77,309

#### 重複チェック
```powershell
python -c "
import pandas as pd
df = pd.read_csv('data/features/05_2016-2025_features.csv', low_memory=False)
key_cols = ['kaisai_nen', 'kaisai_tsukihi', 'keibajo_code', 'race_bango', 'umaban']
dups = df.duplicated(subset=key_cols).sum()
print(f'重複レコード数: {dups} 件')
if dups == 0:
    print('✅ 重複なし - 修正成功')
else:
    print('❌ まだ重複が存在します')
"
```

**期待結果**:
```
重複レコード数: 0 件
✅ 重複なし - 修正成功
```

#### 馬番範囲確認
```powershell
python -c "
import pandas as pd
df = pd.read_csv('data/features/05_2016-2025_features.csv', low_memory=False)
print('馬番の範囲:')
print(f'  最小: {df[\"umaban\"].min()}')
print(f'  最大: {df[\"umaban\"].max()}')
count_99 = (df['umaban'] == 99).sum()
print(f'\n馬番99の出現回数: {count_99} 件')
if count_99 == 0:
    print('✅ 馬番99除外成功')
else:
    print('❌ 馬番99がまだ存在します')
"
```

**期待結果**:
```
馬番の範囲:
  最小: 1
  最大: 18
馬番99の出現回数: 0 件
✅ 馬番99除外成功
```

## 成功基準
- ✅ 総行数: 77,309 行 (±100)
- ✅ 総列数: 139 列
- ✅ 重複レコード: 0 件
- ✅ 馬番範囲: 1-18
- ✅ 馬番99出現回数: 0 件
- ✅ ファイルサイズ: 約62 MB
- ✅ JRDB過去走充足率: 99.5%以上
- ✅ 馬実績充足率: 99%以上

## トラブルシューティング

### 問題: スクリプトダウンロード失敗
```powershell
# URLを確認
$url = "https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/e6ef575/scripts/phase1/extract_jra_features_v1.py"
Invoke-WebRequest -Uri $url -Method Head
```

### 問題: DB接続エラー
```powershell
# PostgreSQL起動確認
Get-Service postgresql*
# 設定ファイル確認
Get-Content config\db_config.yaml
```

### 問題: 依然として馬番99が存在
```powershell
# スクリプトの更新を再確認
Select-String -Path "scripts\phase1\extract_jra_features_v1.py" -Pattern "umaban <= 18"
# 出力がない場合はスクリプトが正しく更新されていない
```

## 完了報告テンプレート
```
✅ 東京競馬場データ修正完了

【修正前】
- 総行数: 77,473 行
- 重複: 152 件
- 馬番99: 164 件

【修正後】
- 総行数: 77,309 行 ✅
- 重複: 0 件 ✅
- 馬番99: 0 件 ✅
- 総列数: 139 列 ✅
- ファイルサイズ: 62.1 MB ✅

【検証結果】
- JRDB過去走充足率: XX.XX% ✅
- 馬実績充足率: XX.XX% ✅
- ターゲット変数欠損: 0 件 ✅

【次のステップ】
小倉（夏季/冬季）データ生成へ移行
```

## 関連リンク
- **最新コミット**: https://github.com/aka209859-max/anonymous-keiba-ai-jra/commit/e6ef575
- **修正スクリプト**: https://raw.githubusercontent.com/aka209859-max/anonymous-keiba-ai-jra/e6ef575/scripts/phase1/extract_jra_features_v1.py
- **リポジトリ**: https://github.com/aka209859-max/anonymous-keiba-ai-jra
