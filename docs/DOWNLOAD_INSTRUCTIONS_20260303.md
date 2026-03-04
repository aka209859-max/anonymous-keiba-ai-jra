# Phase 7 ドキュメントダウンロード指示書

**作成日**: 2026-03-03  
**目的**: サンドボックスからPC側へPhase 7関連ドキュメントをダウンロード

---

## 📥 ダウンロードするファイル一覧

### **重要度: 🔴 最優先（必ずダウンロード）**

| # | ファイル名 | サンドボックスパス | PC保存先 |
|---|-----------|-----------------|---------|
| 1 | **GIT_MERGE_ERROR_RESOLUTION_20260303.md** | `/home/user/webapp/docs/` | `E:\anonymous-keiba-ai-JRA\docs\` |
| 2 | **PHASE7A_WEEK1_START_PLAN.md** | `/home/user/webapp/phase7/docs/00_overview/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\` |
| 3 | **PHASE7_STRATEGY.md** | `/home/user/webapp/phase7/docs/00_overview/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\` |

### **重要度: 🟡 推奨（参考用）**

| # | ファイル名 | サンドボックスパス | PC保存先 |
|---|-----------|-----------------|---------|
| 4 | **PHASE7_WORKFLOW.md** | `/home/user/webapp/phase7/docs/01_workflow/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\01_workflow\` |
| 5 | **PHASE7_ROADMAP.md** | `/home/user/webapp/phase7/docs/02_roadmap/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\02_roadmap\` |
| 6 | **PHASE7_IMPLEMENTATION_PROGRESS.md** | `/home/user/webapp/phase7/docs/00_overview/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\` |
| 7 | **PHASE7_START_REPORT_20260303.md** | `/home/user/webapp/docs/` | `E:\anonymous-keiba-ai-JRA\docs\` |

### **重要度: 🟢 オプション（記録用）**

| # | ファイル名 | サンドボックスパス | PC保存先 |
|---|-----------|-----------------|---------|
| 8 | **PHASE7_SETUP_COMPLETE.md** | `/home/user/webapp/phase7/docs/00_overview/` | `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\` |
| 9 | **PHASE7_SETUP_SUMMARY_20260303.md** | `/home/user/webapp/docs/` | `E:\anonymous-keiba-ai-JRA\docs\` |
| 10 | **README.md** | `/home/user/webapp/phase7/` | `E:\anonymous-keiba-ai-JRA\phase7\` |

---

## 🚀 ダウンロード後の作業手順

### **ステップ 1: Gitマージエラー解決（最優先）**

1. ✅ `GIT_MERGE_ERROR_RESOLUTION_20260303.md` をダウンロード
2. ✅ ファイルを開いて内容を確認
3. ✅ 以下のコマンドを実行:

```powershell
cd E:\anonymous-keiba-ai-JRA
git stash push -m "Local changes before Phase 7 merge"
git pull origin genspark_ai_developer
```

### **ステップ 2: Phase 7 ディレクトリ作成（Git プル後）**

Gitプルが成功すると、以下のディレクトリが自動的に作成されます:

```
E:\anonymous-keiba-ai-JRA\phase7\
├── docs\
│   ├── 00_overview\
│   ├── 01_workflow\
│   ├── 02_roadmap\
│   ├── 03_architecture\
│   ├── 04_operation\
│   ├── 05_performance\
│   └── 06_retraining\
├── scripts\
├── results\
├── models\
├── config\
├── logs\
└── notebooks\
```

### **ステップ 3: ダウンロードしたドキュメントを配置**

ダウンロードしたMDファイルを対応する保存先フォルダに配置してください。

**例**:
- `PHASE7A_WEEK1_START_PLAN.md` → `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\`
- `PHASE7_STRATEGY.md` → `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\`

### **ステップ 4: Phase 7-A Week 1 計画確認**

```powershell
cd E:\anonymous-keiba-ai-JRA\phase7
type docs\00_overview\PHASE7A_WEEK1_START_PLAN.md
```

---

## 📋 各ファイルの説明

### 🔴 最優先ファイル

#### 1. GIT_MERGE_ERROR_RESOLUTION_20260303.md
**目的**: Gitマージエラーの解決方法  
**内容**: 
- 問題の原因（ローカル変更がマージを妨害）
- 解決方法1: git stash（推奨）
- 解決方法2: バックアップ作成
- 実行コマンド

#### 2. PHASE7A_WEEK1_START_PLAN.md
**目的**: Week 1（Day 1-7）の詳細計画  
**内容**:
- Day 1-2: JRDBデータ現状確認調査
- Day 3-4: JRA-VAN 139次元詳細リスト作成
- Day 5-6: JRDB 60~80次元候補リスト作成
- Day 7: 統合マスター作成とクロスソース候補生成
- 成果物: 6ファイル（CSV + TXT）

#### 3. PHASE7_STRATEGY.md
**目的**: Phase 7の戦略骨組み（最終版）  
**内容**:
- 3つの柱（ファクターROI厳選、クロスソース統合、期待値直接最適化）
- 理論的基盤（卍氏手法、Benterモデル、学術研究）
- Phase 7-A ~ 7-J の詳細戦略

---

### 🟡 推奨ファイル

#### 4. PHASE7_WORKFLOW.md
**目的**: 15週間の実装フロー  
**内容**: Phase 7-A ~ 7-J の各タスク、成果物、スケジュール

#### 5. PHASE7_ROADMAP.md
**目的**: 週次ロードマップ  
**内容**: Week 1 ~ Week 15 の詳細計画、マイルストーン、リスク管理

#### 6. PHASE7_IMPLEMENTATION_PROGRESS.md
**目的**: 実装進捗管理  
**内容**: 各フェーズのタスクリスト、成果物チェック、完了条件

---

## 🎯 ダウンロード後の次のアクション

### **最優先タスク: JRDBデータ現状確認**

Gitマージ成功後、以下のコマンドでJRDBデータを確認してください:

```powershell
# JRDBデータの場所を探す
cd E:\anonymous-keiba-ai-JRA
dir /s *.mdb
dir /s *.accdb
dir /s JRDB*

# dataフォルダを確認
cd data
dir
```

### **確認項目**:

1. ✅ JRDBデータの保存場所
2. ✅ データ形式（.mdb/.accdb/CSV/LZH等）
3. ✅ 2016~2025年のデータ有無
4. ✅ 利用可能なJRDBファイル一覧（BAC, SED, KYI等）

---

## 📝 確認チェックリスト

### ダウンロード完了チェック

- [ ] GIT_MERGE_ERROR_RESOLUTION_20260303.md ダウンロード完了
- [ ] PHASE7A_WEEK1_START_PLAN.md ダウンロード完了
- [ ] PHASE7_STRATEGY.md ダウンロード完了
- [ ] その他の推奨ファイルダウンロード完了

### Git作業完了チェック

- [ ] `git stash` 実行完了
- [ ] `git pull origin genspark_ai_developer` 実行完了
- [ ] `phase7/` ディレクトリ作成確認完了
- [ ] ダウンロードしたMDファイルを適切なフォルダに配置完了

### Phase 7-A 開始準備チェック

- [ ] PHASE7A_WEEK1_START_PLAN.md 内容確認完了
- [ ] JRDBデータ保存場所確認完了
- [ ] JRDBデータ形式確認完了
- [ ] 2016~2025年データ有無確認完了

---

## 🔧 トラブルシューティング

### Q1. ダウンロードしたファイルをどこに保存すればいい？

**A**: 上記の「PC保存先」列を参照してください。基本的に:
- `docs/` 配下のファイル → `E:\anonymous-keiba-ai-JRA\docs\`
- `phase7/docs/00_overview/` 配下のファイル → `E:\anonymous-keiba-ai-JRA\phase7\docs\00_overview\`

### Q2. Git プル後にフォルダが見つからない場合は？

**A**: 手動でフォルダを作成してください:
```powershell
cd E:\anonymous-keiba-ai-JRA
mkdir phase7
mkdir phase7\docs
mkdir phase7\docs\00_overview
mkdir phase7\docs\01_workflow
mkdir phase7\docs\02_roadmap
```

### Q3. JRDBデータが見つからない場合は？

**A**: 以下を確認してください:
1. 別のドライブ（D:, F:等）を検索
2. JRDBの公式サイトからデータを取得
3. 既存のデータベースファイルを確認

---

**まずGIT_MERGE_ERROR_RESOLUTION_20260303.mdとPHASE7A_WEEK1_START_PLAN.mdをダウンロードして、Gitマージを解決してください 🚀**
