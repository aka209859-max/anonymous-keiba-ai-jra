# Phase 6 週次運用フロー（確定版）

## 🎯 **運用方針（確定）**

### ✅ **決定事項**
- **Phase 1-5**: 現行Pythonスクリプトを継続使用（PC-KEIBA SQL化は将来の最適化プロジェクト）
- **Phase 6**: 毎週土日の予測レポート生成
- **JRDBデータ取得**: **PC-KEIBA経由で個別ファイルをダウンロード**

---

## 📋 **前提条件**

### ✅ **必要な環境**
- PC-KEIBA インストール済み（PostgreSQL内蔵）
- JRDB会員登録済み（https://www.jrdb.com/）
- Python環境構築済み（E:\anonymous-keiba-ai-JRA）
- Phase 1-5のモデルファイル生成済み（models/*.txt）

### ✅ **Phase 6で使用するJRDBファイル**
| ファイル | 内容 | PC-KEIBAでの取得 |
|---------|------|------------------|
| **KYI** | 競走馬データ（IDM、素質、脚質、馬印、血統など） | ✅ 個別ダウンロード可能 |
| **CYB** | 調教データ（調教指数、馬道、追切評価など） | ✅ 個別ダウンロード可能 |
| **JOA** | 情報データ（厩舎コメント、パドック情報など） | ✅ 個別ダウンロード可能 |
| **SED** | 成績データ（実走着順、タイムなど） | ✅ 個別ダウンロード可能 |

---

## 🔄 **週次運用フロー（毎週金曜夜～土曜朝 / 土曜夜～日曜朝）**

---

## 📅 **金曜日夜～土曜日朝（土曜レース前）**

### **Step 1: PC-KEIBAでJRA-VANデータを更新**

```
1. PC-KEIBAを起動
2. F5キーを押す（またはメニュー「データ(D)」→「データ更新」）
3. JRA-VAN DataLab.から土曜日の出走表データが自動ダウンロードされる
4. 更新完了メッセージが表示されるまで待機（通常5-10分）
5. ステータスバーに「データ更新完了」と表示されることを確認
```

**✅ 確認事項**:
- エラーメッセージが表示されないこと
- JRA-VAN接続が正常であること

---

### **Step 2: PC-KEIBA経由でJRDBデータを個別ダウンロード**

#### **2-1. PC-KEIBAのJRDBダウンロード機能を起動**

```
【方法A: メニューから】
1. PC-KEIBAのメニューバー「データ(D)」をクリック
2. 「外部データ登録」または「JRDBデータ取得」を選択
3. 「個別ファイル取得」または「ファイル選択」を選択

【方法B: ツールバーから】
1. PC-KEIBAのツールバーで「JRDB」アイコンをクリック
2. 「データ取得」を選択
```

#### **2-2. 土曜日のJRDBファイルを個別にダウンロード**

```
1. 対象日付を選択: 2026年2月22日（土）

2. 以下の4つのファイルを個別に取得:
   ☑ KYI260221.txt（競走馬データ）
   ☑ CYB260221.txt（調教データ）
   ☑ JOA260221.txt（情報データ）
   ☑ SED260221.txt（成績データ）
   
   ※ ファイル名の日付は前日（金曜日）になる（例: 2/22のレースは260221）

3. 各ファイルの「取得」ボタンをクリック

4. ダウンロード完了メッセージを確認
```

**📝 注意事項**:
- PC-KEIBAがJRDB会員IDでログイン済みであること
- JRDB会員情報がPC-KEIBAに設定されていること（初回のみ設定が必要）

#### **2-3. JRDB会員情報の設定（初回のみ）**

```
1. PC-KEIBAのメニュー「設定」→「外部サービス設定」
2. 「JRDB設定」を選択
3. 会員IDとパスワードを入力
4. 「接続テスト」で確認
5. 「OK」をクリック
```

---

### **Step 3: PC-KEIBAでJRDBデータをPostgreSQLに取り込み**

```
【自動取り込みの場合】
- PC-KEIBAがダウンロード後、自動的にPostgreSQLに取り込む
- 進捗バーが表示され、完了まで待機（通常1-2分）

【手動取り込みの場合】
1. メニュー「データ(D)」→「外部データ登録」
2. 「JRDBデータ取込」を選択
3. ダウンロード済みのファイルが表示される
4. 「取込開始」をクリック
5. 完了まで待機
```

---

### **Step 4: データ取込の確認（PostgreSQL）**

#### **4-1. pgAdminまたはpsqlで確認**

```sql
-- 1. JRA-VANデータの確認
SELECT COUNT(*) FROM jvd_ra WHERE kaisai_tsukihi = '0222';
-- 期待値: 土曜日の全レース数（例: 36レース）

-- 2. JRDBデータの確認（KYI）
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%';
-- 期待値: 土曜日の全出走頭数（例: 150-200頭）

-- 3. JRDBデータの確認（CYB）
SELECT COUNT(*) FROM jrd_cyb WHERE race_shikonen LIKE '260221%';
-- 期待値: 土曜日の全出走頭数（例: 150-200頭）

-- 4. 結合確認（最重要）
SELECT 
    COUNT(*) AS total_horses,
    COUNT(kyi.idm) AS jrdb_kyi_match,
    COUNT(cyb.chokyoshi) AS jrdb_cyb_match,
    ROUND(COUNT(kyi.idm)::NUMERIC / COUNT(*) * 100, 2) AS kyi_match_rate,
    ROUND(COUNT(cyb.chokyoshi)::NUMERIC / COUNT(*) * 100, 2) AS cyb_match_rate
FROM jvd_se se
LEFT JOIN jrd_kyi kyi ON se.ketto_toroku_bango = kyi.ketto_toroku_bango
    AND se.kaisai_tsukihi = SUBSTRING(kyi.race_shikonen, 1, 4)
LEFT JOIN jrd_cyb cyb ON se.ketto_toroku_bango = cyb.ketto_toroku_bango
    AND se.kaisai_tsukihi = SUBSTRING(cyb.race_shikonen, 1, 4)
WHERE se.kaisai_tsukihi = '0222';

-- 期待結果:
-- kyi_match_rate ≥ 95%
-- cyb_match_rate ≥ 95%
```

#### **4-2. 成功判定基準**

```
✅ kyi_match_rate ≥ 95% → Phase 6実行可能
⚠️ kyi_match_rate < 95% → JRDBデータ再取込が必要
❌ kyi_match_rate = 0%   → JRDBインポート失敗（Step 3を再実行）
```

---

### **Step 5: Phase 6実行（予測レポート生成）**

#### **5-1. PowerShellでPhase 6実行**

```powershell
# PowerShellを起動（管理者権限不要）

# 1. プロジェクトフォルダに移動
cd E:\anonymous-keiba-ai-JRA

# 2. 仮想環境を有効化
.\venv\Scripts\Activate.ps1

# 3. Phase 6実行（土曜日の予測）
python scripts/phase6/phase6_daily_prediction.py --target-date 20260222
```

#### **5-2. 実行結果の確認**

```
期待される出力:

==========================================
Phase 6: 当日予測システム実行開始
==========================================
対象日: 2026-02-22
データベース接続: 127.0.0.1:5432/pckeiba

[Step 1] データ取得中...
✅ 基礎データ: 530頭（12レース）
✅ JRDB結合: 530行マッチ（100.0%）

[Step 2] 特徴量生成中...
✅ 特徴量マトリクス: 530行 × 145列

[Step 3] モデル読み込み中...
✅ Binary Model: models/jra_binary_model.txt
✅ Ranking Model: models/jra_ranking_model.txt
✅ Regression Model: models/jra_regression_model_optimized.txt

[Step 4] 予測実行中...
✅ アンサンブル予測完了

[Step 5] レポート保存中...
✅ Markdown: results/predictions_20260222.md
✅ CSV: results/predictions_20260222.csv

==========================================
Phase 6 実行完了 ✅
==========================================
```

---

### **Step 6: 予測レポート確認**

```powershell
# メモ帳で開く
notepad results\predictions_20260222.md

# またはVS Codeで開く
code results\predictions_20260222.md

# ブラウザで開く
start results\predictions_20260222.md
```

#### **予測レポート例**:

```markdown
# 🏇 JRA競馬AI予想 - 2026年2月22日（土）

## 🏇 中山 第1R 予想

### 予想結果
| 順位 | 馬番 | 馬名 | スコア | 評価 | 騎手 | 馬主 |
|------|------|------|--------|------|------|------|
| 1 | 3 | フランジパーヌ | 1.00 | S | 武豊 | 田中太郎 |
| 2 | 7 | ミラクルレディ | 0.85 | A | 川田将雅 | 山本花子 |
| 3 | 12 | トップガン | 0.72 | A | 福永祐一 | 鈴木商事 |

### 購入推奨
- **本命軸**: 3番（単勝・複勝）
- **馬単**: 3-7, 3-12
- **三連複**: 3-7-12 BOX

---

## 🏇 中山 第2R 予想
...
```

---

## 📅 **土曜日夜～日曜日朝（日曜レース前）**

### **同じ手順を繰り返す**

```
Step 1: PC-KEIBAでJRA-VANデータ更新（F5）

Step 2: PC-KEIBA経由でJRDBデータを個別ダウンロード
        （日曜日のファイル: KYI260222.txt, CYB260222.txt, JOA260222.txt, SED260222.txt）

Step 3: PC-KEIBAでJRDBデータをPostgreSQLに取り込み

Step 4: データ取込確認（kaisai_tsukihi = '0223', race_shikonen LIKE '260222%'）

Step 5: Phase 6実行
        python scripts/phase6/phase6_daily_prediction.py --target-date 20260223

Step 6: 予測レポート確認
        notepad results\predictions_20260223.md
```

---

## ⚠️ **トラブルシューティング**

### **問題1: PC-KEIBAに「JRDBデータ取得」メニューがない**

```
原因: PC-KEIBAのバージョンが古い、またはJRDB連携機能が未設定

対処:
1. PC-KEIBAのバージョンを確認（ヘルプ → バージョン情報）
2. 最新版にアップデート
3. JRDB連携設定を確認（設定 → 外部サービス設定 → JRDB設定）
```

### **問題2: JRDB会員ID/パスワードエラー**

```
原因: 認証情報が間違っている、または有効期限切れ

対処:
1. JRDB公式サイト（https://www.jrdb.com/）で会員情報を確認
2. PC-KEIBAの設定を更新（設定 → 外部サービス設定 → JRDB設定）
3. 「接続テスト」で認証が成功することを確認
```

### **問題3: Phase 6で「JRDB data missing」エラー**

```
エラーメッセージ:
⚠️ 警告: JRDBデータが0件です

対処:
1. Step 4のSQL確認を実行
   SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%';

2. 0件の場合:
   - PC-KEIBAでJRDBデータを再ダウンロード（Step 2）
   - PostgreSQLへの取り込みを再実行（Step 3）

3. データ件数は正常だが、結合が失敗している場合:
   - race_shikonen の日付形式を確認
   - kaisai_tsukihi の値を確認
   - テーブル間のキー整合性を確認
```

### **問題4: PostgreSQLに接続できない**

```
原因: PC-KEIBAのPostgreSQLサービスが起動していない

対処:
1. PC-KEIBAが起動していることを確認
2. Windowsサービスで「PostgreSQL」が実行中か確認
   - Win + R → services.msc → Enter
   - 「PostgreSQL」または「pckeiba-db」を探す
   - サービスが停止している場合は「開始」をクリック

3. Phase 6のデータベース接続設定を確認
   - host: 127.0.0.1
   - port: 5432
   - database: pckeiba
   - user: postgres
   - password: （PC-KEIBA設定時のパスワード）
```

---

## 📊 **週次チェックリスト**

### **金曜夜～土曜朝（土曜レース前）**

```
毎週金曜日 19:00以降～土曜日朝

□ PC-KEIBA起動
□ F5でJRA-VANデータ更新完了
□ PC-KEIBA経由でJRDB個別ファイルダウンロード完了
   □ KYI260221.txt
   □ CYB260221.txt
   □ JOA260221.txt
   □ SED260221.txt
□ PostgreSQLへの取り込み完了
□ データ確認SQL実行（match_rate ≥ 95%確認）
□ Phase 6実行（--target-date 20260222）
□ predictions_20260222.md 生成確認
□ 予測レポートの内容確認（馬名、スコア、購入推奨が表示されている）
```

### **土曜夜～日曜朝（日曜レース前）**

```
毎週土曜日 19:00以降～日曜日朝

□ 同上（日曜日 --target-date 20260223）
□ JRDBファイル日付: 260222（土曜日のデータ）
□ kaisai_tsukihi: '0223'
```

---

## 📈 **運用改善の記録**

### **Version 1.0（2026-02-23）**
- 初版作成
- JRDBデータ取得方式: **PC-KEIBA経由で個別ファイルダウンロード**に確定
- Phase 1-5: 現行Pythonスクリプトを継続使用
- Phase 6: 週次運用フロー確立

### **今後の改善予定（オプション）**
- [ ] JRDBデータダウンロードの完全自動化スクリプト作成
- [ ] Windowsタスクスケジューラによる自動実行設定
- [ ] Phase 1-2のSQL化（長期プロジェクト、数週間～数ヶ月）

---

## 🔗 **関連ドキュメント**

- `PCKEIBA_PHASE1_5_INVESTIGATION_FINAL_VERDICT.md` - PC-KEIBA実装可能性調査（最終評価）
- `PHASE6_JRDB_WORKFLOW_STEP_BY_STEP.md` - JRDB詳細ワークフロー（旧版、参考用）
- `README_PHASE6.md` - Phase 6仕様書
- `scripts/phase6/phase6_daily_prediction.py` - Phase 6実行スクリプト

---

## 📞 **サポート**

### **エラー発生時の報告内容**
```
1. エラーメッセージ全文
2. 実行したコマンド
3. どのステップで失敗したか
4. PC-KEIBAのバージョン
5. PostgreSQL確認SQLの結果
```

---

**作成日**: 2026-02-23  
**最終更新**: 2026-02-23  
**バージョン**: 1.0  
**ステータス**: ✅ 確定版
