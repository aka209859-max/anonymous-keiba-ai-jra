# Phase 1-C スクリプト整理レポート

**作成日**: 2026-02-21  
**Phase 1-C 完了時点での中間スクリプト整理**

---

## 📋 整理方針

Phase 1-C 完了により、試行錯誤で作成された中間スクリプトが不要になりました。
最終版のみを残し、リポジトリをクリーンに保ちます。

---

## ✅ 保持すべきスクリプト（10本）

### 実行スクリプト（3本）

1. **`phase1a_final.py`** - Phase 1-A 最終版
   - JRA-VAN データ抽出（jvd_ra + jvd_se テーブル使用）
   - 477,670件 × 33列を抽出
   - ✅ 保持理由: 現在の正式版、再実行時に必要

2. **`phase1c_final_6key_fixed.py`** - Phase 1-C 最終版
   - 6キー結合（kaisai_nen, keibajo_code, kaisai_kai, kaisai_nichime, race_bango, umaban）
   - kaisai_nen 2桁→4桁変換、kaisai_nichime a/b/c→10/11/12変換対応
   - ✅ 保持理由: 現在の正式版、重複キー0件を実現

3. **`fix_ketto_format.py`** - 血統登録番号修正
   - 7-8桁→10桁統一処理
   - 99.37%一致率達成
   - ✅ 保持理由: 最終版、データ品質向上に必須

### データベース診断スクリプト（5本）

4. **`check_database_schema.py`** - 初期スキーマ確認
   - n_race テーブルの存在確認（結果: 不存在）
   - ✅ 保持理由: トラブルシューティング履歴として有用

5. **`check_all_tables.py`** - 全テーブル一覧
   - pckeiba DB内の全テーブル表示、race系自動検出
   - ✅ 保持理由: データベース調査時に再利用可能

6. **`check_jvd_um_columns.py`** - jvd_um テーブル列確認
   - 馬マスターテーブルの構造確認
   - ✅ 保持理由: 血統情報利用時の参照用

7. **`check_shutsuba_tables.py`** - 出馬テーブル候補確認
   - jvd_se, jvd_o1, jvd_o2, nvd_se の検証
   - ✅ 保持理由: テーブル選定プロセスの記録

8. **`check_jvd_tables.py`** - jvd_ra 詳細確認
   - レース情報テーブルの詳細構造
   - ✅ 保持理由: kaisai_kai/kaisai_nichime 確認の記録

### 検証スクリプト（2本）

9. **`verify_merge_result.py`** - 結合結果検証
   - 血統登録番号形式の診断
   - ✅ 保持理由: 将来のデータ品質チェックに使用可能

10. **Phase 1-B 関連スクリプト（既存）**
    - phase1b_step1_basic.py
    - phase1b_step2_past.py
    - phase1b_step3_merge.py
    - ✅ 保持理由: Phase 1-B 実装時に使用予定

---

## ❌ 削除可能なスクリプト（9本）

### Phase 1-A 中間版（2本）

1. **`phase1a_simple.py`**
   - ❌ 削除理由: 誤ったテーブル名（n_race）を使用
   - 代替: phase1a_final.py で完全に置き換え

2. **`phase1a_jvd_corrected.py`**
   - ❌ 削除理由: 誤ったテーブル（jvd_um）を使用
   - 問題: jvd_um は馬マスターで出馬情報を含まない
   - 代替: phase1a_final.py（jvd_ra + jvd_se）が正解

### Phase 1-C 5キー版（2本）

3. **`phase1c_final_5key.py`**
   - ❌ 削除理由: 5キー結合で46万件以上の重複発生
   - 問題: kaisai_nen がキーに含まれていない
   - 代替: phase1c_final_6key_fixed.py で完全解決

4. **`phase1c_final_5key_fixed.py`**
   - ❌ 削除理由: 5キー結合（kaisai_nichime変換対応版）
   - 問題: kaisai_nen 不足による重複問題は未解決
   - 代替: phase1c_final_6key_fixed.py

### Phase 1-C 6キー中間版（1本）

5. **`phase1c_final_6key.py`**
   - ❌ 削除理由: kaisai_nen の2桁→4桁変換が未実装
   - 問題: JRDBの2桁年とJRA-VANの4桁年が結合できない（0件結合）
   - 代替: phase1c_final_6key_fixed.py で変換対応

### Phase 1-C 年別バッチ版（4本）

6. **`phase1c_merge.py`**
   - ❌ 削除理由: 年別バッチ処理の初期版
   - 問題: メモリ制約対策として試行したが、最終的に不要

7. **`phase1c_merge_fixed.py`**
   - ❌ 削除理由: 年別バッチ処理の修正版
   - 問題: 結合キーの型統一に問題

8. **`phase1c_merge_final.py`**
   - ❌ 削除理由: 年別バッチ処理の最終版
   - 問題: kaisai_kai/kaisai_nichime 追加版だが、全件処理で十分と判明

9. **`phase1c_merge_ultra_light.py`**
   - ❌ 削除理由: SQLite 一時DB使用版
   - 問題: メモリ制約対策の試行版、実行時間が長い

---

## 📊 削除の影響分析

### 影響なし
- すべての削除候補は**中間試行版または誤ったアプローチ**
- 最終版スクリプト（10本）で**すべての機能をカバー**
- Git履歴に残るため、必要時は復元可能

### 削除によるメリット
- リポジトリがクリーンになり、新メンバーが理解しやすい
- 誤って古いスクリプトを実行するリスクを排除
- ファイル検索時のノイズ削減

---

## 🔧 削除手順

### ステップ1: バックアップ作成（オプション）
```bash
cd /home/user/webapp
mkdir -p scripts/archive_phase1c_intermediate

# 削除候補を archive に移動
mv scripts/phase1a_simple.py scripts/archive_phase1c_intermediate/
mv scripts/phase1a_jvd_corrected.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_final_5key.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_final_5key_fixed.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_final_6key.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_merge.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_merge_fixed.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_merge_final.py scripts/archive_phase1c_intermediate/
mv scripts/phase1c_merge_ultra_light.py scripts/archive_phase1c_intermediate/
```

### ステップ2: 削除実行
```bash
cd /home/user/webapp/scripts

# Phase 1-A 中間版削除
rm phase1a_simple.py
rm phase1a_jvd_corrected.py

# Phase 1-C 中間版削除
rm phase1c_final_5key.py
rm phase1c_final_5key_fixed.py
rm phase1c_final_6key.py
rm phase1c_merge.py
rm phase1c_merge_fixed.py
rm phase1c_merge_final.py
rm phase1c_merge_ultra_light.py
```

### ステップ3: Git コミット・プッシュ
```bash
cd /home/user/webapp

# 削除をステージング
git add -u

# コミット
git commit -m "chore(phase1): Phase 1-C中間スクリプトを削除

削除したスクリプト（9本）:
- Phase 1-A 旧版: phase1a_simple.py, phase1a_jvd_corrected.py
- Phase 1-C 5キー版: phase1c_final_5key.py, phase1c_final_5key_fixed.py
- Phase 1-C 6キー中間版: phase1c_final_6key.py
- Phase 1-C 年別バッチ版: phase1c_merge*.py (4本)

保持したスクリプト（10本）:
- 実行スクリプト: phase1a_final.py, phase1c_final_6key_fixed.py, fix_ketto_format.py
- DB診断: check_*.py (5本)
- 検証: verify_merge_result.py

理由: Phase 1-C完了により、最終版のみ残してリポジトリをクリーンに保つ"

# プッシュ
git push origin genspark_ai_developer
```

---

## 📝 最終スクリプト構成

### Phase 1-A
- ✅ `phase1a_final.py` - JRA-VANデータ抽出（最終版）

### Phase 1-B
- ✅ `phase1b_step1_basic.py` - 基本特徴量作成
- ✅ `phase1b_step2_past.py` - 過去成績集計
- ✅ `phase1b_step3_merge.py` - データ結合

### Phase 1-C
- ✅ `phase1c_final_6key_fixed.py` - 6キー結合（最終版）
- ✅ `fix_ketto_format.py` - 血統番号統一（最終版）
- ✅ `verify_merge_result.py` - 結合結果検証

### データベース診断
- ✅ `check_database_schema.py` - 初期スキーマ確認
- ✅ `check_all_tables.py` - 全テーブル一覧
- ✅ `check_jvd_um_columns.py` - jvd_um列確認
- ✅ `check_shutsuba_tables.py` - 出馬テーブル確認
- ✅ `check_jvd_tables.py` - jvd_ra詳細確認

**合計**: 13本（Phase 1-B含む）

---

## ✅ チェックリスト

- [ ] バックアップ作成（オプション）
- [ ] 削除候補9本を確認
- [ ] 削除実行
- [ ] Git コミット
- [ ] Git プッシュ
- [ ] PR コメント更新（整理完了を報告）

---

**作成者**: GenSpark AI Developer  
**Phase 1-C 完了日**: 2026-02-21  
**スクリプト整理日**: 2026-02-21
