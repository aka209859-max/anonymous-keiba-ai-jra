# 📊 元ドキュメント vs 実DB カラムマッピング完全版

**作成日**: 2026-04-07  
**目的**: 元の325カラムドキュメント（JRDB_116_COLUMNS.md, JRA_VAN_209_COLUMNS.md）と実際のDBとの差異を明確化

---

## 🎯 サマリー

| 項目 | JRDB | JRA-VAN | 合計 |
|------|------|---------|------|
| **元ドキュメント記載** | 116カラム | 209カラム | **325カラム** |
| **実際のDB** | 97カラム | 676カラム | **773カラム** |
| **差分** | **-19** | **+467** | **+448** |

---

## 📋 JRDB（116 → 97カラム）

### ✅ 完全一致: 43カラム

元ドキュメントに記載されていて、実DBに**完全に存在する**カラム:

| 元ドキュメント記載名 | 実DBカラム名 | テーブル |
|-------------------|------------|---------|
| IDM（スピード指数） | `idm` | jrd_kyi_fixed |
| 血統登録番号 | `kettou_toroku_bango` | jrd_kyi_fixed |
| 性別コード | `seibetsu_code` | jrd_kyi_fixed |
| 調教師コード | `chokyoshi_code` | jrd_kyi_fixed |
| 馬名 | `bamei` | jrd_kyi_fixed |
| 距離適性コード | `kyori_tekisei` | jrd_kyi_fixed |
| 上がり指数 | `agari_shisu` | jrd_kyi_fixed |
| 位置取り指数 | `ichi_shisu` | jrd_kyi_fixed |
| ペース指数 | `pace_shisu` | jrd_kyi_fixed |
| 調教矢印コード | `chokyo_yajirushi_code` | jrd_kyi_fixed |
| 厩舎ランク | `kyusha_rank` | jrd_kyi_fixed |
| 騎手指数 | `kishu_shisu` | jrd_kyi_fixed |
| 調教指数 | `chokyo_shisu` | jrd_kyi_fixed |
| 厩舎指数 | `kyusha_shisu` | jrd_kyi_fixed |
| 重適性コード | `omo_tekisei_code` | jrd_kyi_fixed |
| 芝適性コード | `shiba_tekisei_code` | jrd_kyi_fixed |
| ダート適性コード | `da_tekisei_code` | jrd_kyi_fixed |
| 装鞍 | `soho` | jrd_kyi_fixed |
| ブリンカー | `blinker` | jrd_kyi_fixed |
| 負担重量 | `futan_juryo` | jrd_kyi_fixed |
| テン指数 | `ten_shisu` | jrd_kyi_fixed |
| 脚質 | `kyakushitsu` | jrd_kyi_fixed |
| 調教タイプ | `chokyo_type` | jrd_cyb_fixed |
| 追切指数 | `oikiri_shisu` | jrd_cyb_fixed |
| 仕上指数 | `shiage_shisu` | jrd_cyb_fixed |
| 調教量評価 | `chokyo_ryo_hyoka` | jrd_cyb_fixed |
| 仕上指数変化 | `shiage_shisu_henka` | jrd_cyb_fixed |
| 調教評価 | `chokyo_hyoka` | jrd_cyb_fixed |
| LS指数 | `ls_shisu` | jrd_joa_fixed |
| LS評価 | `ls_hyoka` | jrd_joa_fixed |
| オッズ指数 | `odds_shisu` | jrd_joa_fixed |
| 開催年月日 | `nengappi` | jrd_bac_fixed |
| 距離 | `kyori` | jrd_bac_fixed |
| 芝ダ障害コード | `shiba_da_shogai_code` | jrd_bac_fixed |
| 右左回り | `migi_hidari` | jrd_bac_fixed |
| 内外回り | `uchi_soto` | jrd_bac_fixed |
| 種別 | `shubetsu` | jrd_bac_fixed |
| 条件 | `jouken` | jrd_bac_fixed |
| 重量種別コード | `juryo_shubetsu_code` | jrd_bac_fixed |
| グレード | `grade` | jrd_bac_fixed |
| 頭数 | `tosu` | jrd_bac_fixed |
| コース | `course` | jrd_bac_fixed |
| 開催区分 | `kaisai_kubun` | jrd_bac_fixed |

### ⚠️ 類似（名称変更）: 1カラム

| 元ドキュメント記載名 | 実DBカラム名 | 説明 |
|-------------------|------------|------|
| **情報指数** | **`sogo_shisu`** | **総合指数**に名称変更 |

### ❌ 存在しない: 3カラム

元ドキュメントに記載されているが、実DBには**存在しない**カラム:

| 元ドキュメント記載名 | 状態 |
|-------------------|------|
| **激走指数** | ❌ 存在しない |
| **激走順位** | ❌ 存在しない |
| **激走タイプ** | ❌ 存在しない |

**重要**: これらのカラム名を使用すると`psycopg2.errors.UndefinedColumn`エラーが発生します。

---

## 📋 JRA-VAN（209 → 676カラム）

### jvd_se テーブル（40 → 70カラム）

#### ✅ 元ドキュメント記載＆実DBに存在: 40カラム

元ドキュメントに記載された40カラムは**すべて実DBに存在**します（完全一致）。

#### ⚠️ 実DBに存在するが元ドキュメントに記載なし: 30カラム

**超重要カラム**が元ドキュメントに記載されていませんでした:

| 実DBカラム名 | 説明 | 重要度 |
|------------|------|--------|
| **`ketto_toroku_bango`** | 血統登録番号（馬の一意識別） | ★★★★★ |
| **`nyusen_juni`** | 入線順位 | ★★★★★ |
| **`kakutei_chakujun`** | **確定着順**（目的変数） | ★★★★★ |
| **`soha_time`** | **走破タイム** | ★★★★★ |
| **`tansho_odds`** | 単勝オッズ | ★★★★★ |
| **`tansho_ninkijun`** | 単勝人気順 | ★★★★ |
| **`kakutoku_honshokin`** | 獲得本賞金 | ★★★★ |
| **`kakutoku_fukashokin`** | 獲得副賞金 | ★★★ |
| **`time_sa`** | タイム差 | ★★★★ |
| **`kyakushitsu_hantei`** | 脚質判定 | ★★★★ |
| `kishu_code` | 騎手コード | ★★★★ |
| `kishu_code_henkomae` | 騎手コード変更前 | ★★★ |
| `kishumei_ryakusho_henkomae` | 騎手名略称変更前 | ★★★ |
| `kishu_minarai_code` | 騎手見習コード | ★★★ |
| `kishu_minarai_code_henkomae` | 騎手見習コード変更前 | ★★★ |
| `hinshu_code` | 品種コード | ★★★ |
| `moshoku_code` | 毛色コード | ★★★ |
| `tozai_shozoku_code` | 東西所属コード | ★★★ |
| `record_koshin_kubun` | レコード更新区分 | ★★★ |
| `mining_kubun` | マイニング区分 | ★★ |
| `yoso_gosa_plus` | 予想誤差プラス | ★★ |
| `yoso_gosa_minus` | 予想誤差マイナス | ★★ |
| `yoso_juni` | 予想順位 | ★★ |
| 他7カラム | 予備等 | ★ |

---

### jvd_ra テーブル（31 → 62カラム）

#### ✅ 元ドキュメント記載＆実DBに存在: 31カラム

元ドキュメントに記載された31カラムは**すべて実DBに存在**します（完全一致）。

#### ⚠️ 実DBに存在するが元ドキュメントに記載なし: 31カラム

**超重要カラム**が元ドキュメントに記載されていませんでした:

| 実DBカラム名 | 説明 | 重要度 |
|------------|------|--------|
| **`record_id`** | レコードID | ★★★★★ |
| **`data_kubun`** | データ区分 | ★★★★ |
| **`kaisai_nen`** | 開催年（結合キー） | ★★★★★ |
| **`kaisai_tsukihi`** | 開催月日（結合キー） | ★★★★★ |
| **`keibajo_code`** | 競馬場コード（結合キー） | ★★★★★ |
| **`kaisai_kai`** | 開催回（結合キー） | ★★★★★ |
| **`kaisai_nichime`** | 開催日目（結合キー） | ★★★★★ |
| **`race_bango`** | レース番号（結合キー） | ★★★★★ |
| **`tokubetsu_kyoso_bango`** | 特別競走番号 | ★★★★ |
| **`kyosomei_hondai`** | 競走名本題 | ★★★★ |
| **`kyosomei_kakkonai`** | 競走名カッコ内 | ★★★ |
| **`kyosomei_hondai_eur`** | 競走名本題欧字 | ★★★ |
| **`kyosomei_kakkonai_eur`** | 競走名カッコ内欧字 | ★★★ |
| **`kyosomei_ryakusho_10`** | 競走名略称10字 | ★★★★ |
| **`kyosomei_ryakusho_6`** | 競走名略称6字 | ★★★★ |
| **`kyosomei_ryakusho_3`** | 競走名略称3字 | ★★★ |
| **`kyosomei_kubun`** | 競走名区分 | ★★★ |
| **`jusho_kaiji`** | 重賞回次 | ★★★ |
| **`juryo_shubetsu_code`** | 重量種別コード | ★★★★ |
| **`kyoso_joken_code_2sai`** | 競走条件コード2歳 | ★★★ |
| **`kyoso_joken_code`** | 競走条件コード | ★★★★ |
| `kyori_henkomae` | 距離変更前 | ★★ |
| `track_code_henkomae` | トラックコード変更前 | ★★ |
| **`honshokin`** | **本賞金** | ★★★★★ |
| **`toroku_tosu`** | 登録頭数 | ★★★ |
| **`nyusen_tosu`** | 入選頭数 | ★★★ |
| **`lap_time`** | **ラップタイム** | ★★★★★ |
| **`shogai_mile_time`** | 障害マイルタイム | ★★★ |
| **`kohan_3f`** | 後半3F | ★★★★ |
| 他2カラム | 予備等 | ★ |

---

## 🚨 Claude Code への影響

### 1. 存在しないカラム名のエラー

**JRDB**:
```python
# ❌ エラーが発生するコード
kyi.joho_shisu         # 存在しない（元ドキュメント: "情報指数"）
kyi.gekiso_shisu       # 存在しない（元ドキュメント: "激走指数"）
kyi.gekiso_juni        # 存在しない（元ドキュメント: "激走順位"）
kyi.gekiso_type        # 存在しない（元ドキュメント: "激走タイプ"）

# ✅ 正しいコード
kyi.sogo_shisu         # 総合指数（類似カラム）
```

**JRA-VAN**:
```python
# ❌ 元ドキュメントに記載なし（存在するが未記載）
se.ketto_toroku_bango      # 血統登録番号（結合キー）
se.kakutei_chakujun        # 確定着順（目的変数）
se.soha_time               # 走破タイム
se.tansho_odds             # 単勝オッズ
ra.kaisai_nen              # 開催年（結合キー）
ra.kaisai_tsukihi          # 開催月日（結合キー）
ra.honshokin               # 本賞金
ra.lap_time                # ラップタイム
```

### 2. full_factor_loader.py の修正ポイント

```python
# 【修正前】存在しないカラム名
SELECT
    kyi.joho_shisu,        # ❌ 存在しない
    kyi.gekiso_shisu,      # ❌ 存在しない
    ...

# 【修正後】実際のカラム名
SELECT
    kyi.sogo_shisu,        # ✅ 総合指数
    -- 激走指数は存在しないため削除
    ...
```

---

## 📊 最終結論

### JRDB（97カラム）
- **完全一致**: 43カラム（100%利用可能）
- **類似**: 1カラム（`情報指数` → `sogo_shisu`）
- **存在しない**: 3カラム（激走指数、激走順位、激走タイプ）

### JRA-VAN（676カラム）
- **元ドキュメント記載**: 209カラム（すべて存在）
- **未記載（重要）**: 467カラム
  - **jvd_se**: +30カラム（うち23個が超重要）
  - **jvd_ra**: +31カラム（うち28個が超重要）
  - **他11テーブル**: +406カラム

### 合計
- **元ドキュメント**: 325カラム
- **実DB**: 773カラム
- **差分**: +448カラム（未記載が多数）

---

**作成者**: GenSpark AI Developer  
**作成日**: 2026-04-07  
**用途**: Claude Code への情報提供、full_factor_loader.py 修正
