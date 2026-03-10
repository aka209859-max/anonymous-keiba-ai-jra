# Phase 7-B 実行手順（簡潔版）

## 📋 3ステップで実行

### ステップ 1: セットアップスクリプトをローカルPCにコピー

GitHubからファイルをダウンロードして、以下の場所に保存:

```
E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b\SETUP_AND_RUN.ps1
```

### ステップ 2: PowerShellで実行

1. ファイルを右クリック → **「PowerShellで実行」**
2. または、PowerShellを開いて:
   ```powershell
   cd E:\anonymous-keiba-ai-JRA\scripts\phase7\phase7b
   .\SETUP_AND_RUN.ps1
   ```

### ステップ 3: 結果確認

**期待される出力**:
```
✅ データ抽出完了: 460,424 行 × 100+ カラム
✅ CSV保存完了: 125.50 MB
📁 E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv
```

---

## 🎯 何が作成されるか

### ディレクトリ構造（自動作成）
```
E:\anonymous-keiba-ai-JRA\
├── scripts\phase7\phase7b\
│   ├── SETUP_AND_RUN.ps1                      # セットアップスクリプト（手動配置）
│   └── create_merged_dataset_334cols.py       # 自動作成
│
└── phase7\results\phase7b_roi\
    └── jravan_jrdb_merged_334cols_2016_2025.csv   # 出力ファイル（460,424行）
```

### 出力ファイル詳細
- **ファイル名**: `jravan_jrdb_merged_334cols_2016_2025.csv`
- **行数**: 460,424 行（2016-2025年の確定レース）
- **カラム数**: 100+ カラム（JRA-VAN + JRDB統合）
- **サイズ**: 約125 MB
- **文字コード**: UTF-8 with BOM（Excel対応）

---

## ⚠️ トラブルシューティング

### エラー 1: psycopg2 が見つからない
```
❌ psycopg2 未インストール
```
**解決策**:
```powershell
pip install psycopg2
```

### エラー 2: PostgreSQL接続失敗
```
❌ PostgreSQL接続失敗
```
**解決策**:
1. PostgreSQLが起動しているか確認
2. パスワードが正しいか確認（デフォルト: `postgres123`）
3. スクリプト内の接続情報を修正

### エラー 3: ディレクトリが作成されない
```
❌ アクセスが拒否されました
```
**解決策**:
PowerShellを**管理者として実行**

---

## 📊 実行後の確認

以下のコマンドで結果を確認:

```powershell
# ファイルサイズ確認
Get-Item "E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv" | Select-Object Name, Length

# 行数確認（PowerShell）
(Get-Content "E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv").Count - 1

# カラム数確認（Python）
python -c "import pandas as pd; df = pd.read_csv(r'E:\anonymous-keiba-ai-JRA\phase7\results\phase7b_roi\jravan_jrdb_merged_334cols_2016_2025.csv', nrows=1); print(f'カラム数: {len(df.columns)}')"
```

---

## 🎯 次のステップ

Phase 7-B Week 2 の残りのタスク:

1. **ステップ 1**: 統合データセット作成 ✅（今回）
2. **ステップ 2**: 単一カラムROI分析（次回、2-3時間）
3. **ステップ 3**: トップ100カラム選定（次回、30分）

実行完了後、以下を報告してください:
- ✅ 成功 / ❌ 失敗
- 行数: XXX,XXX 行
- カラム数: XXX カラム
- ファイルサイズ: XXX MB
- エラーメッセージ（失敗の場合）

---

**作成日**: 2026-03-10  
**バージョン**: 1.0
