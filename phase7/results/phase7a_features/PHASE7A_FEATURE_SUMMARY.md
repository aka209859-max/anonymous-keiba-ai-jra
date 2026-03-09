# Phase 7-A 特徴量仕様確認レポート

**作成日**: 2026-03-09  
**作成者**: AI Assistant  
**目的**: Phase 7-A 実施のための既存使用カラムの確認

---

## ✅ 確認完了事項

### 1. 既存の特徴量仕様（Phase 6まで）

**出典**: `INTEGRATED_FEATURE_SPECIFICATION_FINAL (1).md` (HubFiles)

| データソース | カラム数 | 詳細 |
|---|---|---|
| **JRA-VAN** | 97カラム | 基礎情報24 + 馬実績14 + 過去走58 + ターゲット1 |
| **JRDB** | 48カラム | 予測指数13 + 調教5 + 適性6 + 展開2 + ランク6 + CID7 + 調教B2 + 過去走7 |
| **派生特徴量** | 3カラム | 距離増減系 |
| **合計** | **148カラム** | - |

**競馬場分割**: 11競馬場（小倉を夏・冬で季節分割）

**総次元数**: 11競馬場 × 148カラム = **1,628次元**

---

### 2. JRDBデータベース登録状況

**データベース**: PostgreSQL 16.11 / pckeiba

| テーブル | 行数 | 状態 | データ期間 |
|---|---|---|---|
| jrd_kyi | 491,176 | ✅ 完了 | 2016-2026 |
| jrd_cyb | 491,194 | ✅ 完了 | 2016-2026 |
| jrd_joa | 491,194 | ✅ 完了 | 2016-2026 |
| jrd_sed | 491,017 | ✅ 完了 | 2016-2026 |
| jrd_bac | 35,173 | ✅ 完了 | 2016-2026 |
| jrd_cha | 490,167 | ✅ 完了 | 2016-2026 |
| jrd_cza | 452 | ✅ 完了（マスタ） | 調教師452人 |
| jrd_kka | 488,134 | ✅ 完了 | 2016-2026 |
| jrd_kza | 420 | ✅ 完了（マスタ） | 騎手420人 |
| jrd_skb | 490,149 | ✅ 完了 | 2016-2026 |
| jrd_tyb | 490,149 | ✅ 完了 | 2016-2026 |
| jrd_ukc | 55,332 | ✅ 完了 | 2016-2026 |
| jrd_ot～oz | 35,143×5 | ✅ 完了 | オッズデータ |
| jrd_kab | 2,934 | ✅ 完了 | 馬場データ |
| **総計** | **4,193,206行** | **18テーブル完備** | **10年分** |

---

### 3. JRDB 48カラムの内訳

**出典**: HubFiles `INTEGRATED_FEATURE_SPECIFICATION_FINAL (1).md`

#### E. 予測指数系（jrd_kyi）: 13カラム
1. `idm` - IDM指数
2. `kishu_shisu` - 騎手指数
3. `joho_shisu` - 情報指数
4. `sogo_shisu` - 総合指数
5. `chokyo_shisu` - 調教指数
6. `kyusha_shisu` - 厩舎指数
7. `gekiso_shisu` - 激走指数
8. `ninki_shisu` - 人気指数
9. `ten_shisu` - テン指数
10. `pace_shisu` - ペース指数
11. `agari_shisu` - 上がり指数
12. `ichi_shisu` - 位置指数
13. `manken_shisu` - 万券指数

#### E-2. 調教・厩舎評価系（jrd_kyi, jrd_cyb）: 5カラム
14. `chokyo_yajirushi_code` - 調教矢印コード
15. `kyusha_hyoka_code` - 厩舎評価コード
16. `kishu_kitai_rentai_ritsu` - 騎手期待連対率
17. `shiage_shisu` - 仕上指数
18. `chokyo_hyoka` - 調教評価

#### E-3. 馬の適性・状態系（jrd_kyi）: 6カラム
19. `kyakushitsu_code` - 脚質コード
20. `kyori_tekisei_code` - 距離適性コード
21. `joshodo_code` - 上昇度コード
22. `tekisei_code_omo` - 適性コード（重）
23. `hizume_code` - 蹄コード
24. `class_code` - クラスコード

#### E-4. 展開予想系（jrd_kyi）: 2カラム
25. `pace_yoso` - ペース予想
26. `uma_deokure_ritsu` - 馬出遅れ率

#### E-5. ランク・その他（jrd_kyi）: 6カラム
27. `rotation` - ローテーション
28. `hobokusaki_rank` - 放牧先ランク
29. `kyusha_rank` - 厩舎ランク
30. `bataiju` - 馬体重
31. `bataiju_zogen` - 馬体重増減
32. `uma_start_shisu` - 馬スタート指数

#### F. CID・LS指数系（jrd_joa）: 7カラム
33. `cid` - CID
34. `ls_shisu` - LS指数
35. `ls_hyoka` - LS評価
36. `em` - EM
37. `kyusha_bb_shirushi` - 厩舎BB印
38. `kishu_bb_shirushi` - 騎手BB印
39. `kyusha_bb_nijumaru_tansho_kaishuritsu` - 厩舎BB二重丸単勝回収率

#### G. 調教データB（jrd_cyb）: 2カラム
40. `chokyo_course_shubetsu` - 調教コース種別
41. `chokyo_shubetsu` - 調教種別

#### H. 過去走用（jrd_sed）: 7カラム
42. `prev1_pace` - 前走1ペース
43. `prev1_deokure` - 前走1出遅れ
44. `prev1_furi` - 前走1振り
45. `prev1_furi_1` - 前走1振り1
46. `prev1_furi_2` - 前走1振り2
47. `prev1_furi_3` - 前走1振り3
48. `prev1_race` - 前走1レース

---

## 🎯 Phase 7-A の目標（確定）

### 現状（Phase 6）
- **使用特徴量**: 148カラム（JRA-VAN 97 + JRDB 48 + 派生3）
- **総次元数**: 1,628次元（11競馬場 × 148カラム）
- **データソース**: JRA-VANとJRDB統合済み

### Phase 7-A の拡張目標
- **目標総カラム数**: 200～220カラム
- **拡張カラム数**: +52～72カラム
- **拡張方針**:
  1. JRDB未使用カラムの追加（データベースには存在するが未使用）
  2. 派生特徴量の追加（クロスソース特徴量）
  3. 過去走データの拡充（過去2～5走）

---

## 📋 次のステップ（Day 3-4）

### タスク: JRA-VAN 97カラムの詳細リスト作成

**目的**: Phase 6で使用している97カラムの詳細を文書化

**実施手順**:
1. `phase6_daily_prediction.py` のSQL解析
2. 各カラムのテーブル名・データ型・説明を記録
3. CSV形式で保存: `jravan_97cols_details.csv`

**成果物フォーマット**:
```csv
feature_id,feature_name,table_name,data_type,description,is_prior_day_available,category
1,month,derived,INT,開催月（1-12）,TRUE,基礎情報
2,kyori,jvd_ra,INT,距離（メートル）,TRUE,基礎情報
...
```

---

## 📋 次のステップ（Day 5-6）

### タスク: JRDB追加候補カラムのリスト作成

**目的**: JRDBデータベースから追加可能な未使用カラムを特定

**実施手順**:
1. JRDB各テーブルの全カラムリスト取得
2. Phase 6で使用していない48カラムを除外
3. 追加候補カラムをリストアップ
4. CSV形式で保存: `jrdb_additional_candidates.csv`

**対象テーブル**:
- jrd_kyi（競走馬調教データ）
- jrd_cyb（馬場・コース情報）
- jrd_joa（騎手データ）
- jrd_sed（レース詳細データ）
- jrd_bac（馬基本データ）

**期待される追加カラム数**: 20～40カラム

---

## 📊 データ所在地まとめ

### ローカルPC（E:\anonymous-keiba-ai-JRA）

| 場所 | 内容 |
|---|---|
| `data/raw/jra_jravan_97cols.csv` | JRA-VAN 97カラム（99.8 MB） |
| `data/raw/jrdb_basic_41cols.csv` | JRDB基本 41カラム（87.2 MB） |
| `data/raw/jrdb_past_7cols.csv` | JRDB過去走 7カラム（22.2 MB） |
| `data/raw/jravan_jrdb_merged_fixed.csv` | 統合データ（138.8 MB） |
| `data/jrdb/config/DataSettings.xml` | PC-KEIBA設定ファイル |
| `data/jrdb/raw/` | JRDB生データ（.lzhファイル） |

### PostgreSQL（127.0.0.1:5432/pckeiba）

| データベース | テーブル数 | 総行数 | データ期間 |
|---|---|---|---|
| pckeiba | 18テーブル | 4,193,206行 | 2016-2026 |

### サンドボックス（/home/user/webapp）

| ディレクトリ | 内容 |
|---|---|
| `phase7/docs/` | Phase 7ドキュメント |
| `phase7/results/phase7a_features/` | Phase 7-A成果物保存先 |
| `phase7/scripts/` | Phase 7スクリプト |
| `phase6_daily_prediction.py` | Phase 6予測スクリプト（139次元使用） |

---

## ✅ 完了確認

- [x] JRDB 48カラムの詳細確認完了
- [x] JRDBデータベース登録完了（18テーブル、4,193,206行）
- [x] Phase 6使用特徴量の確認完了（148カラム）
- [x] データ所在地の確認完了
- [ ] JRA-VAN 97カラムの詳細リスト作成 ← **次のタスク（Day 3-4）**
- [ ] JRDB追加候補カラムのリスト作成 ← **Day 5-6**
- [ ] 220カラム統合マスターの作成 ← **Day 7**

---

## 🔗 関連ドキュメント

### HubFiles
- `INTEGRATED_FEATURE_SPECIFICATION_FINAL (1).md` - 148カラム仕様書（Phase 6最終版）
- `OPTIMAL_PAST_RACE_FEATURES_FINAL.md` - パターンC+推奨
- `START_NEW_SESSION.md` - JRA開発フロー

### ローカルドキュメント
- `phase7/README.md` - Phase 7概要
- `phase7/docs/00_overview/PHASE7A_WEEK1_START_PLAN.md` - Week 1計画
- `phase7/results/phase7a_features/JRDB_DATABASE_SETUP_COMPLETE_REPORT.md` - データベース構築完了レポート

---

**作成者**: AI Assistant  
**最終更新**: 2026-03-09  
**ステータス**: ✅ 確認完了  
**次のアクション**: JRA-VAN 97カラム詳細リスト作成（Day 3-4）
