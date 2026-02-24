# PC-KEIBA JRDB登録最適化 ディープサーチ指示文

## 📋 調査目的
PC-KEIBAの「外部データ登録」機能でJRDBデータを毎週登録する際に、
- **問題1**: データ登録ボタンを押すと保有している15年分すべてのファイルを再処理し、数時間かかる
- **問題2**: 添付された15種類のJRDBファイル（BAC, CHA, JOA, CYB, KAB, OZ, OW, OU, OT, UKC, KKA, KYI, ZKB, ZED）のうち、Phase 6予測に必要なのは **KYI (競走馬), CYB (調教), JOA (情報), SED (成績)** の4ファイルのみ

**Phase 6 週次運用で実現したい目標**:
1. 登録処理時間を **5分以内** に短縮
2. 当日分（または直近30日分）のみを **差分登録**
3. 不要な11ファイルの登録を **スキップ** または **設定除外**

---

## 🎯 調査すべき核心的質問

### 1. 差分登録・増分更新の設定
**Question**: PC-KEIBAの「外部データ登録」画面に、以下の設定項目は存在するか？
- [ ] **登録対象期間の設定**: 「全期間」「直近N日」「指定期間 (YYYY-MM-DD ～ YYYY-MM-DD)」等の選択肢
- [ ] **差分登録モード**: 「既存データをスキップし、新規データのみ登録」ON/OFF
- [ ] **全データ再登録**: 「毎回全データを削除して再登録」ON/OFF (これがONになっている可能性)
- [ ] **ファイル更新日時チェック**: 「ファイルのタイムスタンプを確認し、更新されたファイルのみ処理」ON/OFF

**期待される回答例**:
```
設定画面で「登録対象期間: 直近30日」を選択し、
「差分登録モード: ON」「全データ再登録: OFF」に設定したところ、
所要時間が 2時間30分 → 3分 に短縮された。
```

### 2. ファイル別登録制御
**Question**: 特定のJRDBファイルだけを登録対象にする方法はあるか？
- [ ] **設定ファイル (XML) の編集**: `/path/to/jrdb_settings.xml` で登録対象ファイル種別を指定できるか？
- [ ] **GUIでのファイル種別選択**: 画面上でチェックボックス等により KYI, CYB, JOA, SED のみを選択できるか？
- [ ] **データファイルフォルダの分離**: Phase 6用フォルダ `C:\JRDB\phase6\` に必要な4ファイルのみ配置し、その他を別フォルダに退避する運用は可能か？

**期待される回答例**:
```
設定ファイル jrdb_config.xml の <FileTypes> セクションで、
<File>KYI</File>, <File>CYB</File>, <File>JOA</File>, <File>SED</File>
のみを有効化し、その他をコメントアウトしたところ、
11ファイル処理 → 4ファイル処理に減り、所要時間が大幅短縮された。
```

### 3. 初回全件登録 vs. 週次差分登録の分離
**Question**: 初回セットアップ（2010-2025の全期間）と、週次運用（当日分のみ）で異なる設定プロファイルを使い分けられるか？
- [ ] **設定プロファイルの保存・切替**: 「プロファイル A: 全期間」「プロファイル B: 直近30日差分」のように複数設定を保存できるか？
- [ ] **バッチ処理用コマンドラインオプション**: `pckeiba.exe --import-jrdb --config=weekly_incremental.xml` のようなCLI起動はサポートされているか？

**期待される回答例**:
```
「設定」→「外部データ登録プロファイル管理」で
「初回全件 (2010-2025)」と「週次差分 (直近30日)」の2つを作成。
毎週の運用では「週次差分」プロファイルを選択することで、
処理時間を 2時間 → 5分 に短縮できた。
```

---

## 🔍 具体的な調査手順

### Step 1: PC-KEIBAメニュー構造の確認
1. PC-KEIBAを起動し、ツールバー「**データ (D)**」→「**外部データ登録**」をクリック
2. 画面上部・下部のすべてのボタン・タブ・メニューを記録:
   - 「設定」「オプション」「詳細設定」「プロファイル」等のボタンの有無
   - 「登録対象期間」「差分モード」「ファイル種別」等の設定項目の有無
3. **スクリーンショット取得** (設定画面全体)

### Step 2: 設定ファイル (XML) の確認
1. PC-KEIBAインストールフォルダ (例: `C:\Program Files\PC-KEIBA\`) または
   データフォルダ (例: `C:\Users\<username>\Documents\PC-KEIBA\`) 内を検索:
   - `jrdb*.xml`
   - `external_data*.xml`
   - `config*.xml`
2. 該当XMLファイルをテキストエディタで開き、以下を確認:
   ```xml
   <RegistrationConfig>
     <TargetPeriod>全期間</TargetPeriod>  <!-- ← ここを「直近30日」に変更できるか？ -->
     <IncrementalMode>false</IncrementalMode>  <!-- ← これをtrueにできるか？ -->
     <FileTypes>
       <File>KYI</File>
       <File>CYB</File>
       <!-- ... 他のファイル種別 ... -->
     </FileTypes>
   </RegistrationConfig>
   ```
3. **該当部分をコピー＆ペーストで報告**

### Step 3: データ登録実行テスト (Before)
1. 現在の設定のまま「**開始**」ボタンをクリック
2. 以下を記録:
   - 処理開始時刻: `2026-02-23 10:00:00`
   - 進捗メッセージ: 例「KYI260221.txt 処理中... (15,234 / 485,000 レコード)」
   - 処理完了時刻: `2026-02-23 12:35:12`
   - **所要時間**: 2時間35分12秒
   - 処理されたファイル数: 15種類 × 15年分 = 約225ファイル

### Step 4: 設定最適化 (試行錯誤)
以下のパターンを順番に試し、それぞれの所要時間を記録:

**パターンA: 登録対象期間を直近30日に変更**
```
設定: 登録対象期間 = 2026-01-22 ～ 2026-02-22 (直近30日)
結果: 所要時間 = ?分?秒
```

**パターンB: 差分モードをON**
```
設定: 差分登録モード = ON (既存レコードをスキップ)
結果: 所要時間 = ?分?秒
```

**パターンC: ファイル種別を4種類のみに限定**
```
設定: ファイル種別 = KYI, CYB, JOA, SED のみ (11種類を除外)
結果: 所要時間 = ?分?秒
```

**パターンD: A + B + C を組み合わせ**
```
設定: 直近30日 + 差分ON + 4ファイルのみ
結果: 所要時間 = ?分?秒 ← **これが最も速いはず**
```

### Step 5: PostgreSQL データ確認
各パターン実行後、以下のSQLで登録結果を検証:

```sql
-- 1. KYI (競走馬) テーブルの件数確認
SELECT COUNT(*) AS kyi_count,
       MIN(race_shikonen) AS oldest_date,
       MAX(race_shikonen) AS newest_date
FROM jrd_kyi;

-- 2. 当日分のみ抽出 (例: 2026-02-22)
SELECT COUNT(*) AS today_count
FROM jrd_kyi
WHERE race_shikonen LIKE '260221%';

-- 3. 15年分すべてが登録されているか確認
SELECT SUBSTRING(race_shikonen, 1, 2) AS year,
       COUNT(*) AS count
FROM jrd_kyi
GROUP BY SUBSTRING(race_shikonen, 1, 2)
ORDER BY year DESC;

-- 4. Phase 6予測に必要な4テーブルの整合性確認
SELECT 
  (SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '260221%') AS kyi_count,
  (SELECT COUNT(*) FROM jrd_cyb WHERE race_shikonen LIKE '260221%') AS cyb_count,
  (SELECT COUNT(*) FROM jrd_joa WHERE race_shikonen LIKE '260221%') AS joa_count,
  (SELECT COUNT(*) FROM jrd_sed WHERE race_shikonen LIKE '260221%') AS sed_count;
```

**期待される結果**:
- **パターンA～C単独**: 所要時間が 30分～1時間程度に短縮
- **パターンD (組み合わせ)**: 所要時間が **5分以内** に短縮 ← **目標達成**

---

## 📊 報告フォーマット

調査完了後、以下の形式で報告してください:

### 1. 現状 (Before)
```
■ 設定内容
- 登録対象期間: 全期間 (2010-2025)
- 差分登録モード: OFF
- 全データ再登録: ON
- ファイル種別: 15種類すべて

■ 実行結果
- 処理開始: 2026-02-23 10:00:00
- 処理完了: 2026-02-23 12:35:12
- 所要時間: 2時間35分12秒
- 処理ファイル数: 約225ファイル (15種類 × 15年分)

■ PostgreSQL確認
- jrd_kyi レコード数: 485,342 件
- 対象期間: 2010年～2025年
- 当日分 (260221): 158 件
```

### 2. 最適化後 (After)
```
■ 設定内容 (パターンD)
- 登録対象期間: 直近30日 (2026-01-22 ～ 2026-02-22)
- 差分登録モード: ON
- 全データ再登録: OFF
- ファイル種別: KYI, CYB, JOA, SED のみ (4種類)

■ 実行結果
- 処理開始: 2026-02-23 14:00:00
- 処理完了: 2026-02-23 14:03:45
- 所要時間: 3分45秒 ← **目標達成！**
- 処理ファイル数: 約12ファイル (4種類 × 直近3開催日)

■ PostgreSQL確認
- jrd_kyi レコード数: 485,500 件 (+158 件増加)
- 対象期間: 2010年～2025年 (過去データはそのまま保持)
- 当日分 (260221): 158 件 (正常登録)
```

### 3. 設定変更方法 (具体的な手順)
```
【方法A: GUI設定】
1. PC-KEIBA → データ → 外部データ登録
2. 「設定」ボタンをクリック
3. 「登録対象期間」タブで「直近30日」を選択
4. 「登録オプション」タブで「差分登録モード」をON
5. 「ファイル種別」タブで KYI, CYB, JOA, SED のみチェック
6. 「OK」→「適用」→「保存」

【方法B: XML設定ファイル編集】
ファイル: C:\Users\<username>\Documents\PC-KEIBA\config\jrdb_config.xml
変更箇所:
  <TargetPeriod>全期間</TargetPeriod>
  ↓
  <TargetPeriod>直近30日</TargetPeriod>

  <IncrementalMode>false</IncrementalMode>
  ↓
  <IncrementalMode>true</IncrementalMode>

  <FileTypes>
    <File>KYI</File>
    <File>CYB</File>
    <File>JOA</File>
    <File>SED</File>
    <!-- 以下11種類をコメントアウト -->
    <!-- <File>BAC</File> -->
    <!-- <File>CHA</File> -->
    ...
  </FileTypes>
```

---

## 🔎 補足: ディープサーチ用の検索クエリ

もしPC-KEIBAマニュアル・GUI設定だけでは解決できない場合、以下のキーワードでWeb検索を実施:

### 日本語検索クエリ
1. `PC-KEIBA 外部データ登録 差分モード 設定方法`
2. `PC-KEIBA JRDB 登録時間 短縮 最適化`
3. `PC-KEIBA 外部データ 登録対象期間 指定 直近30日`
4. `PC-KEIBA JRDB ファイル種別 選択 KYI CYB のみ`
5. `PC-KEIBA 全データ再登録 OFF 増分更新`
6. `PC-KEIBA 外部データ登録 設定ファイル XML 編集`
7. `PC-KEIBA JRDB 一括ダウンロード 必要ファイルのみ`
8. `PC-KEIBA データ登録 時間がかかる 解決方法`
9. `PC-KEIBA PostgreSQL JRDB 差分インポート`
10. `PC-KEIBA 外部データ登録プロファイル 複数設定`

### 英語検索クエリ (海外競馬予想システムの類似事例)
1. `database incremental update fixed-length data PostgreSQL`
2. `bulk data import optimization selective file types`
3. `differential data registration reduce processing time`

### 調査対象サイト (優先度順)
1. **PC-KEIBA公式マニュアル**: https://pc-keiba.com/wp/ (会員専用ページ含む)
2. **PC-KEIBAユーザーフォーラム・掲示板**: Google検索 `site:pc-keiba.com フォーラム`
3. **JRDB公式サイト**: https://www.jrdb.com/ (データ仕様・連携方法)
4. **個人ブログ・Qiita**: `PC-KEIBA 使い方 JRDB 登録`
5. **YouTube**: `PC-KEIBA 外部データ登録 解説`

---

## ✅ 成功基準

以下の条件をすべて満たすこと:

- [x] **処理時間**: 2時間30分 → **5分以内** に短縮
- [x] **データ完全性**: 当日分 (例: 260221) の KYI/CYB/JOA/SED が正常登録される
- [x] **過去データ保持**: 2010～2024年のデータは削除されず保持される
- [x] **運用効率**: 毎週金曜夜～土曜朝の作業時間が **10分以内** に収まる
- [x] **再現性**: 設定変更後、毎週同じ手順で5分以内に登録完了できる

---

## 📝 次のアクション

この指示文に基づき、以下を実施してください:

1. **PC-KEIBA実機での設定確認** (上記 Step 1～2)
2. **最適化パターンのテスト** (上記 Step 4)
3. **報告フォーマットに沿った結果報告** (上記「報告フォーマット」セクション)
4. **スクリーンショット添付** (設定画面・進捗画面・完了画面)

報告受領後、最適な設定を `PHASE6_WEEKLY_OPERATION_FINAL.md` に反映し、
週次運用手順を確定します。

---

**作成日**: 2026-02-23  
**バージョン**: 1.0  
**対象**: PC-KEIBA + JRDB 週次運用最適化  
**Goal**: Phase 6予測システムの実運用準備完了
