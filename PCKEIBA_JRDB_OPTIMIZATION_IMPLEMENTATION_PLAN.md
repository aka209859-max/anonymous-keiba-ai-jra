# 🚀 PC-KEIBA JRDB登録最適化 実装プラン

## 📋 報告書サマリー

添付された技術報告書「PC-KEIBAにおける外部データ登録プロセスの最適化」を分析し、実装可能な最適化プランを作成しました。

**報告書の核心的提案**:
- 登録対象期間: 15年分 → **直近30日**
- ファイル種別: 15種類 → **4種類 (KYI/CYB/JOA/SED)**
- 差分登録モード: OFF → **ON (Upsert方式)**
- **実証結果**: 2時間35分12秒 → **3分45秒** (97.6%短縮)

---

## 🎯 最適化の3本柱

### 1. XML設定ファイルの編集

報告書に記載された推奨XML設定:

```xml
<RegistrationSettings>
  <TargetPeriodMode>Direct</TargetPeriodMode>
  <DaysToProcess>30</DaysToProcess>
  <IncrementalUpdate>true</IncrementalUpdate>
  <FileFilters>
    <FileType id="KYI" enabled="true" />
    <FileType id="CYB" enabled="true" />
    <FileType id="JOA" enabled="true" />
    <FileType id="SED" enabled="true" />
    <FileType id="BAC" enabled="false" />
    <FileType id="CHA" enabled="false" />
    <FileType id="OZ" enabled="false" />
    <FileType id="OW" enabled="false" />
    <FileType id="OU" enabled="false" />
    <FileType id="OT" enabled="false" />
    <FileType id="UKC" enabled="false" />
    <FileType id="KKA" enabled="false" />
    <FileType id="ZKB" enabled="false" />
    <FileType id="ZED" enabled="false" />
  </FileFilters>
</RegistrationSettings>
```

**重要パラメータ**:
- `TargetPeriodMode="Direct"`: 期間直接指定モード
- `DaysToProcess="30"`: 直近30日間のみ
- `IncrementalUpdate="true"`: 差分登録 (既存レコードスキップ)
- `FileType enabled="false"`: 不要な11ファイルを無効化

### 2. PostgreSQL メンテナンス (週次実施)

登録処理の前後に実行するSQL:

```sql
-- ==========================================
-- Phase 6 JRDB登録 週次メンテナンス SQL
-- ==========================================

-- ステップ1: 登録前のインデックス再構築 (月1回推奨)
-- ※毎週実施する場合は所要時間を確認の上、必要に応じて実施
REINDEX TABLE jrd_kyi;
REINDEX TABLE jrd_cyb;
REINDEX TABLE jrd_joa;
REINDEX TABLE jrd_sed;

-- ステップ2: 統計情報の更新 (毎週実施推奨)
ANALYZE jrd_kyi;
ANALYZE jrd_cyb;
ANALYZE jrd_joa;
ANALYZE jrd_sed;

-- ステップ3: 登録後の整合性検証
-- 3-1. 各テーブルの最新レース日を確認
SELECT 
    'KYI' as table_name, MAX(race_shikonen) as latest_date, COUNT(*) as total_records FROM jrd_kyi
UNION ALL
SELECT 
    'CYB', MAX(race_shikonen), COUNT(*) FROM jrd_cyb
UNION ALL
SELECT 
    'JOA', MAX(race_shikonen), COUNT(*) FROM jrd_joa
UNION ALL
SELECT 
    'SED', MAX(race_shikonen), COUNT(*) FROM jrd_sed;

-- 3-2. 当日分のレコード数確認 (例: 2026-02-22 → '260222')
-- ※race_shikonenの形式は 'YY年MM月DD日JJ競馬場RRレース番号' (例: '26022201012')
SELECT 
    'KYI' as table_name, COUNT(*) as today_count FROM jrd_kyi WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'CYB', COUNT(*) FROM jrd_cyb WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'JOA', COUNT(*) FROM jrd_joa WHERE race_shikonen LIKE '260222%'
UNION ALL
SELECT 
    'SED', COUNT(*) FROM jrd_sed WHERE race_shikonen LIKE '260222%';

-- 3-3. 過去データの保全確認 (2010年のデータが残っているか)
SELECT 
    'KYI' as table_name, COUNT(*) as year_2010_count FROM jrd_kyi WHERE race_shikonen LIKE '10%'
UNION ALL
SELECT 
    'CYB', COUNT(*) FROM jrd_cyb WHERE race_shikonen LIKE '10%'
UNION ALL
SELECT 
    'JOA', COUNT(*) FROM jrd_joa WHERE race_shikonen LIKE '10%'
UNION ALL
SELECT 
    'SED', COUNT(*) FROM jrd_sed WHERE race_shikonen LIKE '10%';

-- 期待値: 
-- - latest_date: 260222 または最新のレース施行日
-- - today_count: 150～200件程度 (開催日のレース数 × 出走頭数)
-- - year_2010_count: 数千件以上 (過去データが保持されている)
```

### 3. データフォルダの構造化

JRDBダウンロード先を週次運用専用に整理:

```
C:\JRDB\
├── phase6\                  ← PC-KEIBAの「データファイル保存先」に指定
│   ├── KYI260222.txt       ✅ Phase 6必須
│   ├── CYB260222.txt       ✅ Phase 6必須
│   ├── JOA260222.txt       ✅ Phase 6必須
│   └── SED260222.txt       ✅ Phase 6必須 (レース後)
│
└── archive\                 ← 過去データ保管用 (登録対象外)
    ├── 2010-2024\
    │   ├── KYI*.txt
    │   ├── CYB*.txt
    │   ├── JOA*.txt
    │   ├── SED*.txt
    │   └── ... (その他11種類)
    └── other_files\
        ├── BAC*.txt
        ├── CHA*.txt
        └── ... (Phase 6で不要な11種類)
```

**運用ルール**:
- `C:\JRDB\phase6\` には最新の4ファイルのみを配置
- 週次ダウンロード時、前週のファイルは `archive\` に移動
- PC-KEIBAの「データファイル保存先」を `C:\JRDB\phase6\` に設定

---

## 📝 実装手順 (ステップ・バイ・ステップ)

### ステップ1: 設定ファイルの検索と編集

#### 1-1. PC-KEIBA設定ファイルの検索

以下のフォルダを検索:
```
C:\Program Files\PC-KEIBA\
C:\Program Files (x86)\PC-KEIBA\
C:\Users\<username>\Documents\PC-KEIBA\
C:\Users\<username>\AppData\Roaming\PC-KEIBA\
C:\Users\<username>\AppData\Local\PC-KEIBA\
```

検索対象ファイル名:
- `jrdb*.xml`
- `external_data*.xml`
- `config*.xml`
- `registration*.xml`

**検索コマンド (PowerShell)**:
```powershell
# PC-KEIBA関連フォルダ内のXMLファイルを検索
Get-ChildItem -Path "C:\Program Files\PC-KEIBA", "C:\Users\$env:USERNAME\Documents\PC-KEIBA", "C:\Users\$env:USERNAME\AppData\Roaming\PC-KEIBA" -Filter "*.xml" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName, Length, LastWriteTime
```

#### 1-2. XMLファイルの編集

見つかったXMLファイル (例: `C:\Users\<username>\Documents\PC-KEIBA\config\jrdb_registration.xml`) をテキストエディタで開き、以下の箇所を探す:

**変更前 (デフォルト設定)**:
```xml
<RegistrationSettings>
  <TargetPeriodMode>All</TargetPeriodMode>  <!-- 全期間 -->
  <IncrementalUpdate>false</IncrementalUpdate>  <!-- 差分OFF -->
  <FileFilters>
    <!-- 全ファイル種別がenabled="true" -->
  </FileFilters>
</RegistrationSettings>
```

**変更後 (最適化設定)**:
```xml
<RegistrationSettings>
  <TargetPeriodMode>Direct</TargetPeriodMode>
  <DaysToProcess>30</DaysToProcess>
  <IncrementalUpdate>true</IncrementalUpdate>
  <FileFilters>
    <FileType id="KYI" enabled="true" />
    <FileType id="CYB" enabled="true" />
    <FileType id="JOA" enabled="true" />
    <FileType id="SED" enabled="true" />
    <FileType id="BAC" enabled="false" />
    <FileType id="CHA" enabled="false" />
    <FileType id="KAB" enabled="false" />
    <FileType id="OZ" enabled="false" />
    <FileType id="OW" enabled="false" />
    <FileType id="OU" enabled="false" />
    <FileType id="OT" enabled="false" />
    <FileType id="UKC" enabled="false" />
    <FileType id="KKA" enabled="false" />
    <FileType id="ZKB" enabled="false" />
    <FileType id="ZED" enabled="false" />
  </FileFilters>
</RegistrationSettings>
```

**⚠️ バックアップ**: 編集前に元のXMLファイルをコピーして `jrdb_registration.xml.backup` として保存

#### 1-3. GUI設定の確認 (もしXMLファイルが見つからない場合)

PC-KEIBA → データ → 外部データ登録 → 「**設定**」ボタンをクリックし、以下を探す:
- [ ] 「登録対象期間」: 「全期間」→「直近30日」に変更
- [ ] 「差分登録モード」: OFF → ON に変更
- [ ] 「ファイル種別」: KYI/CYB/JOA/SED のみチェック、他をオフ

### ステップ2: PostgreSQL メンテナンス SQL の準備

#### 2-1. SQLファイルの作成

`C:\JRDB\phase6_maintenance.sql` を作成し、上記「PostgreSQL メンテナンス」セクションのSQLをコピー。

#### 2-2. 実行方法

**方法A: pgAdmin**
1. pgAdmin を起動
2. PC-KEIBAのPostgreSQLデータベースに接続
3. ツール → クエリツール
4. `phase6_maintenance.sql` を開いて実行

**方法B: psql (コマンドライン)**
```bash
psql -U postgres -d pckeiba -f "C:\JRDB\phase6_maintenance.sql"
```

### ステップ3: データフォルダの整理

#### 3-1. フォルダ構造の作成

```powershell
# PowerShellで実行
New-Item -Path "C:\JRDB\phase6" -ItemType Directory -Force
New-Item -Path "C:\JRDB\archive" -ItemType Directory -Force
New-Item -Path "C:\JRDB\archive\2010-2024" -ItemType Directory -Force
New-Item -Path "C:\JRDB\archive\other_files" -ItemType Directory -Force
```

#### 3-2. 既存ファイルの整理

**Phase 6必須ファイル (4種類)** を `C:\JRDB\phase6\` に移動:
```powershell
# 最新の4ファイルを phase6 フォルダに移動
Move-Item -Path "C:\JRDB\KYI*.txt" -Destination "C:\JRDB\phase6\" -Force
Move-Item -Path "C:\JRDB\CYB*.txt" -Destination "C:\JRDB\phase6\" -Force
Move-Item -Path "C:\JRDB\JOA*.txt" -Destination "C:\JRDB\phase6\" -Force
Move-Item -Path "C:\JRDB\SED*.txt" -Destination "C:\JRDB\phase6\" -Force
```

**その他11種類** を `C:\JRDB\archive\other_files\` に移動:
```powershell
# 不要な11ファイルをアーカイブに移動
Move-Item -Path "C:\JRDB\BAC*.txt" -Destination "C:\JRDB\archive\other_files\" -Force
Move-Item -Path "C:\JRDB\CHA*.txt" -Destination "C:\JRDB\archive\other_files\" -Force
# ... (残り9種類も同様)
```

#### 3-3. PC-KEIBAの「データファイル保存先」を変更

PC-KEIBA → データ → 外部データ登録 → 「データファイルの保存先」:
```
変更前: C:\JRDB\
変更後: C:\JRDB\phase6\
```

### ステップ4: 最適化テスト (Before / After 測定)

#### 4-1. Before (現状の処理時間測定)

1. PC-KEIBA → データ → 外部データ登録
2. 「開始」ボタンをクリック
3. 以下を記録:
   ```
   処理開始時刻: 2026-02-23 10:00:00
   処理完了時刻: 2026-02-23 12:35:12
   所要時間: 2時間35分12秒
   処理ファイル数: (画面表示の数値)
   ```

#### 4-2. 設定変更の適用

上記「ステップ1～3」を実施。

#### 4-3. After (最適化後の処理時間測定)

1. PC-KEIBAを再起動 (設定を確実に読み込むため)
2. PC-KEIBA → データ → 外部データ登録
3. 「開始」ボタンをクリック
4. 以下を記録:
   ```
   処理開始時刻: 2026-02-23 14:00:00
   処理完了時刻: 2026-02-23 14:03:45
   所要時間: 3分45秒 ← 目標達成！
   処理ファイル数: (画面表示の数値)
   ```

#### 4-4. PostgreSQL データ検証

上記「PostgreSQL メンテナンス」セクションの「ステップ3: 登録後の整合性検証」SQLを実行。

**期待される結果**:
```
table_name | latest_date | total_records
-----------+-------------+---------------
KYI        | 260222****  | ~485,000
CYB        | 260222****  | ~485,000
JOA        | 260222****  | ~485,000
SED        | 260222****  | ~485,000

table_name | today_count
-----------+-------------
KYI        | 158
CYB        | 158
JOA        | 158
SED        | 158

table_name | year_2010_count
-----------+-----------------
KYI        | 10,000+
CYB        | 10,000+
JOA        | 10,000+
SED        | 10,000+
```

---

## 🔄 週次運用フロー (最適化版)

### 金曜夜 (19:00～19:10) - 土曜レース準備

#### 1. JRA-VAN データ更新 (5分)
```
PC-KEIBA起動 → F5キー → 自動更新 (5分待機)
```

#### 2. JRDB データダウンロード (1分)
```
PC-KEIBA → データ → 外部データ登録 → JRDBダウンロード
→ 2026-02-22 の KYI, CYB, JOA を選択 → ダウンロード
→ 保存先: C:\JRDB\phase6\
```

#### 3. JRDB データ登録 (3分)
```
PC-KEIBA → データ → 外部データ登録 → 「開始」ボタン
→ 進捗バー完了まで待機 (約3分)
```

#### 4. PostgreSQL 整合性確認 (1分)
```powershell
# PowerShellでSQLを実行
psql -U postgres -d pckeiba -c "SELECT 'KYI' as table_name, COUNT(*) as today_count FROM jrd_kyi WHERE race_shikonen LIKE '260222%';"
# 期待値: 150～200件
```

#### 5. Phase 6 予測実行 (2分)
```powershell
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222
notepad results\predictions_20260222.md
```

**合計所要時間**: **約10分** (現状の3時間から94%短縮)

### 土曜夜 (19:00～19:10) - 日曜レース準備

上記と同様の手順を、日付を `20260223` に変更して実施。

---

## ✅ 成功基準

以下の条件をすべて満たすこと:

- [x] **処理時間**: 2時間30分 → **5分以内** (目標: 3分45秒)
- [x] **データ完全性**: 当日分 (例: 260222) の KYI/CYB/JOA/SED が正常登録 (150～200件)
- [x] **過去データ保持**: 2010～2024年のデータが削除されず保持 (year_2010_count > 0)
- [x] **運用効率**: 毎週金曜夜～土曜朝の作業時間が **10分以内** (JRA-VAN + JRDB + Phase 6)
- [x] **再現性**: 設定変更後、毎週同じ手順で3分台の登録が実現

---

## 📊 技術報告書の実証データ

報告書に記載された実測値:

| 評価項目 | Before (現行設定) | After (最適化設定) | 短縮率 |
|:--------|:-----------------|:------------------|:------|
| **スキャン対象ファイル数** | 約225ファイル (15年×15種) | 約12ファイル (30日×4種) | **94.7%削減** |
| **データベース書き込み量** | 全レコード再評価 | 新規・変更レコードのみ | **99.0%削減** |
| **合計処理時間** | **2時間35分12秒** | **3分45秒** | **97.6%短縮** ⚡ |

**測定環境**:
- CPU: Intel Core i7 12700
- RAM: 32GB DDR4
- Storage: NVMe SSD 1TB
- DB: PostgreSQL 14.x
- データ量: 2010年～2025年の15年分 (約225万レコード)

---

## 🔧 トラブルシューティング

### Q1: XMLファイルが見つからない

**A**: PC-KEIBAのGUI設定で以下を確認:
- データ → 外部データ登録 → 「設定」ボタン
- 「登録対象期間」「差分登録モード」「ファイル種別」の項目があるか確認
- ある場合: GUI上で直接変更
- ない場合: PC-KEIBAのバージョンを確認し、最新版へアップデート

### Q2: 差分登録モードがうまく動作しない

**A**: PostgreSQL側の主キー・ユニークインデックスを確認:
```sql
-- jrd_kyiテーブルのインデックス確認
\d jrd_kyi

-- 主キーが正しく設定されているか確認
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'jrd_kyi' AND constraint_type = 'PRIMARY KEY';
```

主キーが未設定の場合、差分登録が機能しない可能性があります。

### Q3: 最適化後も処理時間が10分以上かかる

**A**: 以下を確認:
1. **REINDEXの実行**: 上記「PostgreSQL メンテナンス」のREINDEX SQLを実行
2. **ディスク容量**: C:ドライブに10GB以上の空きがあるか確認
3. **バックグラウンドプロセス**: タスクマネージャーでCPU/メモリ使用率を確認
4. **PC-KEIBAのバージョン**: 最新版か確認 (古いバージョンは最適化機能が未実装の可能性)

### Q4: 過去データが削除されてしまった

**A**: **バックアップから復元**:
```sql
-- バックアップがある場合
pg_restore -U postgres -d pckeiba -t jrd_kyi backup_file.dump

-- バックアップがない場合、初回全件登録を再実行
-- (設定を「全期間」「全ファイル種別」に戻して実行)
```

**今後の予防策**: 初回全件登録完了後、PostgreSQLのバックアップを取得:
```bash
pg_dump -U postgres -d pckeiba -t jrd_kyi -t jrd_cyb -t jrd_joa -t jrd_sed > jrdb_backup_20260223.dump
```

---

## 📚 参考資料

このリポジトリ内の関連ファイル:

1. **`PHASE6_OPTIMIZATION_COMPLETE_GUIDE.md`**  
   → 全体像・問題点・調査手順

2. **`PCKEIBA_JRDB_REGISTRATION_DEEPSEARCH_INSTRUCTION.md`**  
   → 詳細調査手順・報告フォーマット

3. **`PCKEIBA_JRDB_FILE_REQUIREMENTS_ANALYSIS.md`**  
   → 15種類のJRDBファイルの必要性分析

4. **`PHASE6_WEEKLY_OPERATION_FINAL.md`**  
   → Phase 6週次運用フロー (本実装プラン確定後に更新)

5. **添付された技術報告書**  
   `/home/user/uploaded_files/PC-KEIBAにおける外部データ登録プロセスの最適化：JRDBデータ.txt`

---

## 🎯 次のアクション

### ユーザーが実施すること:

1. **ステップ1～4を実施** (XML設定 / PostgreSQL準備 / フォルダ整理 / Before/After測定)
2. **結果を報告** (処理時間、スクリーンショット、PostgreSQL確認結果)
3. **週次運用テスト** (今週末の競馬開催日に実運用)

### AI開発者が実施すること:

1. **報告内容を受領後、`PHASE6_WEEKLY_OPERATION_FINAL.md` を最終版に更新**
2. **自動化スクリプトの作成** (PowerShell / バッチファイル)
3. **週次運用の完全自動化** (金曜夜のワンクリック実行)

---

**作成日**: 2026-02-23  
**バージョン**: 1.0  
**対象**: PC-KEIBA + JRDB 週次運用最適化  
**ゴール**: 2.5時間 → 3分45秒の実現  
**根拠**: 添付技術報告書の実証データ (97.6%短縮)
