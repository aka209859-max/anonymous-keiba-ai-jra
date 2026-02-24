# PC-KEIBAのデータ取得・更新方法に関するディープサーチ指示文

## 🎯 調査目的

PC-KEIBA Database ソフトウェアにおける以下の3点を明確にする：

1. **JRA-VAN Data の当日データ自動取得方法**
   - 出馬表データは自動的にPostgreSQLデータベースに取り込まれるのか？
   - 手動での「データ更新」操作が必要なのか？
   - 更新タイミング（毎日何時に自動実行されるか）
   - リアルタイム更新機能の有無と設定方法

2. **JRDBデータの取り込み・保存方法**
   - PC-KEIBAはJRDBデータ（BAC, SED, KYI等）をどのように取り込むのか？
   - JRDBファイルの保存場所（デフォルトディレクトリ）
   - PostgreSQLテーブルへの自動取り込みの有無
   - 固定長テキストファイルのままか、DB化されるか

3. **当日予想のための最適ワークフロー**
   - プロの競馬予想家やPC-KEIBAユーザーが実践している運用方法
   - 朝のデータ取得から予想結果出力までの具体的な手順
   - 自動化可能な部分と手動操作が必要な部分の区別

---

## 🔍 具体的な検索キーワード

### キーワードグループ1: JRA-VAN Data 自動更新
```
"PC-KEIBA Database" "JRA-VAN" "自動更新"
"PC-KEIBA" "データ更新" "タイミング"
"PC-KEIBA Database" "リアルタイム更新" "設定"
"PC-KEIBA" "出馬表" "自動取得"
"JRA-VAN DataLab" "PC-KEIBA" "連携"
"PC-KEIBA Database" "自動更新時刻"
"PC-KEIBA" "データ取得" "スケジュール"
```

### キーワードグループ2: JRDB データ取り込み
```
"PC-KEIBA Database" "JRDB" "取り込み"
"PC-KEIBA" "外部指数" "インポート"
"PC-KEIBA Database" "BAC" "SED" "取り込み方法"
"PC-KEIBA" "JRDB" "保存場所"
"PC-KEIBA Database" "固定長テキスト" "読み込み"
"PC-KEIBA" "JRDB" "PostgreSQL" "テーブル"
"PC-KEIBA Database" "外部指数ディレクトリ" "設定"
"DirectoryGaibuShisu" "PC-KEIBA"
```

### キーワードグループ3: 実践的ワークフロー
```
"PC-KEIBA Database" "使い方" "当日予想"
"PC-KEIBA" "運用方法" "朝のルーティン"
"PC-KEIBA Database" "自動化" "予想"
"PC-KEIBA" "機械学習" "LambdaRank" "実行"
"PC-KEIBA Database" "予測テーブル" "活用"
"PC-KEIBA" "Python" "連携" "自動予想"
"PC-KEIBA Database" "Windowsタスクスケジューラ"
```

### キーワードグループ4: マニュアル・公式情報
```
"PC-KEIBA Database" "マニュアル" filetype:pdf
"PC-KEIBA Database" "ヘルプ" "データ更新"
"PC-KEIBA" "公式サイト" "使い方"
"PC-KEIBA Database" "設定ガイド"
"AppConfig.xml" "PC-KEIBA" "設定項目"
"JidokoshinJikokuDateTimePicker" "PC-KEIBA"
```

---

## 📋 重点調査項目

### ✅ 調査項目1: JRA-VAN Data 自動更新
**確認すべき情報**:
- [ ] 自動更新機能のON/OFF設定方法
- [ ] デフォルトの更新時刻（`JidokoshinJikokuDateTimePicker`の意味）
- [ ] `jra_shutsuba`テーブルへのデータ投入タイミング
- [ ] リアルタイム更新機能（`RealtimeInterval: 30秒`）の動作
- [ ] 手動更新の操作方法（メニュー、ショートカット）
- [ ] 更新完了の確認方法

### ✅ 調査項目2: JRDB データ取り込み
**確認すべき情報**:
- [ ] JRDBファイルのデフォルト保存場所
- [ ] PC-KEIBAへのインポート手順
- [ ] `DirectoryGaibuShisu`（外部指数ディレクトリ）の設定方法
- [ ] インポート後のデータ保存形式（PostgreSQLテーブル名）
- [ ] 固定長テキストファイルのパース処理の有無
- [ ] BAC, SED, KYI, CYB各ファイルの役割と必須性

### ✅ 調査項目3: 既存AI機能との連携
**確認すべき情報**:
- [ ] LambdaRankモデル（`myd_lambdarank_1_*`）の実行方法
- [ ] 予測結果テーブル（`myd_lambdarank_1_pred`）の構造
- [ ] Pythonスクリプト連携機能（`DirectoryPython`の用途）
- [ ] 外部スクリプトからの予測実行方法
- [ ] PC-KEIBA内蔵AIと外部モデルの併用方法

---

## 🎯 期待される調査結果フォーマット

### 1. JRA-VAN Data 自動更新
```
【自動更新機能】
- 機能の有無: ✅ あり / ❌ なし
- 設定場所: メニュー > 設定 > データ更新
- デフォルト更新時刻: 21:00（AppConfig.xmlの値）
- リアルタイム更新: ✅ 有効 / ❌ 無効
- 更新間隔: 30秒
- 手動更新方法: メニュー > ツール > データ更新 / F5キー

【出馬表データ取得タイミング】
- 前日夜: XX:XX に確定版取得
- 当日朝: XX:XX に最新版取得
- レース直前: リアルタイム更新で馬体重等を反映

【PostgreSQLテーブル】
- テーブル名: jra_shutsuba
- データ投入: 自動更新時にINSERT/UPDATE
- 確認方法: SELECT COUNT(*) FROM jra_shutsuba WHERE kaisai_tsukihi='20260222'
```

### 2. JRDB データ取り込み
```
【JRDBファイル保存場所】
- デフォルトパス: C:\PC-KEIBA\JRDB\
- または: C:\Users\USERNAME\Documents\PC-KEIBA\JRDB\
- ファイル命名規則: BAC20260222.txt, SED20260222.txt

【取り込み方法】
- パターンA: PC-KEIBAメニュー > ツール > JRDB取り込み
- パターンB: 指定フォルダに置くだけで自動読み込み
- パターンC: 外部指数ディレクトリ設定が必要

【PostgreSQLへの保存】
- テーブル名: jrdb_bac, jrdb_sed, jrdb_kyi (例)
- または: jra_shutsubaテーブルに結合して保存
- 確認方法: SELECT table_name FROM information_schema.tables WHERE table_name LIKE 'jrdb%'
```

### 3. 推奨ワークフロー
```
【プロ予想家の運用例】
06:00  JRDB会員サイトから当日データDL（BAC, SED, KYI）
06:10  PC-KEIBAの指定フォルダにファイル配置
06:15  PC-KEIBAソフト起動 > データ更新ボタンクリック
06:20  PostgreSQL確認: 当日データ取り込み完了
06:30  Pythonスクリプト実行: 特徴量生成 + AI予測
07:00  予想結果CSV確認 > 投票判断

【自動化可能な範囲】
✅ PC-KEIBAのJRA-VAN自動更新（前日設定で翌朝自動実行）
❌ JRDBファイルDL（会員サイトから手動）
✅ JRDBファイル配置後の自動取り込み（フォルダ監視）
✅ Pythonスクリプト自動実行（Windowsタスクスケジューラ）
✅ 予想結果CSV自動生成
```

---

## 🌐 推奨検索ソース

1. **公式サイト・マニュアル**
   - PC-KEIBA Database 公式サイト
   - PC-KEIBA マニュアルPDF
   - JRA-VAN DataLab 公式ドキュメント
   - JRDB 公式サイト（データ仕様書）

2. **コミュニティ・Q&A**
   - Yahoo!知恵袋: "PC-KEIBA データ更新"
   - 5ちゃんねる 競馬板: PC-KEIBAスレ
   - note: "PC-KEIBA 使い方"
   - Qiita: "競馬予想 自動化"

3. **技術情報**
   - GitHub: PC-KEIBA 関連リポジトリ
   - Zenn: 競馬AI 記事
   - はてなブログ: PC-KEIBA カスタマイズ

4. **動画・実演**
   - YouTube: "PC-KEIBA 使い方"
   - YouTube: "PC-KEIBA データ更新"
   - YouTube: "競馬予想 自動化"

---

## 📊 調査成果物

以下の形式でレポートをまとめてください：

```markdown
# PC-KEIBA データ取得・更新方法 調査レポート

## 1. JRA-VAN Data 自動更新
（上記フォーマットに従って記述）

## 2. JRDB データ取り込み
（上記フォーマットに従って記述）

## 3. 推奨ワークフロー
（上記フォーマットに従って記述）

## 4. 重要な発見・注意点
- ...
- ...

## 5. 参考URL
- [PC-KEIBA公式] https://...
- [JRA-VAN DataLab] https://...
- [参考記事] https://...
```

---

## ⚠️ 特に重要な確認事項

1. **`AppConfig.xml`の各項目の意味**
   ```xml
   <JidokoshinJikokuDateTimePicker>21:00</JidokoshinJikokuDateTimePicker>
   <!-- ↑ これは何の時刻？ 自動更新開始時刻？ -->
   
   <DirectoryGaibuShisu />
   <!-- ↑ JRDBファイルの保存先？ 空欄の場合の動作は？ -->
   
   <RealtimeInterval>30</RealtimeInterval>
   <!-- ↑ 30秒ごとに何を更新？ オッズ？ 馬体重？ -->
   ```

2. **`LastFileTimestamp`の意味**
   ```xml
   <LastFileTimestampJvd>20260221115924</LastFileTimestampJvd>
   <LastFileTimestampNvd>20260221232044</LastFileTimestampNvd>
   <!-- ↑ 最終取得日時？ これで自動更新の成否を確認できる？ -->
   ```

3. **既存AI予測テーブルの活用**
   ```xml
   <TestTable>myd_lambdarank_1_test</TestTable>
   <PredTable>myd_lambdarank_1_pred</PredTable>
   <!-- ↑ これらのテーブルはどうやって更新される？ -->
   <!-- PC-KEIBA内蔵AIが自動で予測を実行している？ -->
   ```

---

**この指示文をディープサーチツールに入力して、上記の情報を収集してください。**
