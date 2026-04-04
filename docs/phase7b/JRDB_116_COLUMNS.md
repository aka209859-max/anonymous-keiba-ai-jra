# JRDB データ形式: 116列詳細

**証拠ファイル**: `docs/PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv`  
**調査日**: 2026-03-31  
**総列数**: 116列（全て使用）

---

## 1. テーブル別カラム一覧

### 1.1 jrd_kyi (競馬指数) - 65列

**説明**: JRDBの独自指数、評価、適性、体型など（メインデータ）

**主な指数系カラム**:
| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `idm` | IDM | JRDB独自の総合指数 |
| 2 | `jockey_index` | 騎手指数 | 騎手の能力評価値 |
| 3 | `info_index` | 情報指数 | 情報価値の評価 |
| 4 | `sogo_index` | 総合指数 | 総合的な評価値 |
| 5 | `ketto_index` | 血統指数 | 血統による評価 |
| 6 | `trainer_index` | 調教師指数 | 調教師の能力評価 |
| 7 | `stable_index` | 厩舎指数 | 厩舎の総合力評価 |
| 8 | `ten_index` | 展開指数 | 展開予想評価 |
| 9 | `pace_index` | ペース指数 | ペース適性評価 |
| 10 | `joh_index` | 上がり指数 | 上がり3ハロンの評価 |
| 11 | `ichi_index` | 位置取り指数 | ポジショニング評価 |
| 12 | `teki_sei_index` | 適性指数 | コース適性評価 |

**適性評価系カラム**:
| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 13 | `kyori_tekisei` | 距離適性 | 距離別の適性 |
| 14 | `baba_tekisei` | 馬場適性 | 馬場状態適性 |
| 15 | `course_tekisei` | コース適性 | コース形状適性 |
| 16 | `kawarimi` | 変わり身 | 調子の変化度 |
| 17 | `seichoku` | 成長曲線 | 成長度合い |

**体型・気配評価**:
| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 18 | `taikei` | 体型 | 馬体の総合評価 |
| 19 | `kiai` | 気配 | パドック時の気配 |
| 20 | `chokyo_hyoka` | 調教評価 | 調教の仕上がり |

**その他45列**: 過去成績、単勝オッズ、人気、予想印など

---

### 1.2 jrd_cyb (調教分析) - 18列

**説明**: 調教コメント、評価、コース情報

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `chokyo_comment` | 調教コメント | 調教師によるコメント |
| 2 | `chokyo_hyoka_rank` | 調教評価ランク | A/B/C/Dランク |
| 3 | `chokyo_course_type` | 調教コース種別 | 芝/ダート/坂路等 |
| 4 | `chokyo_distance` | 調教距離 | 調教走行距離 |
| 5 | `chokyo_time` | 調教タイム | 調教時のタイム |
| 6 | `oikiri_time` | 追い切りタイム | 最終追い切りタイム |
| 7 | `handicap_time_index` | ハンデ時計指数 | 時計補正指数 |
| 8 | `chokyo_course_detail` | 調教コース詳細 | 具体的なコース情報 |
| ... | （他10列省略） | ... | ... |

---

### 1.3 jrd_sed (レース詳細) - 14列

**説明**: 馬場差、ペース、コース取り、振り

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `pace` | ペース | レースのペース区分 |
| 2 | `baba_sa` | 馬場差 | 馬場の有利不利 |
| 3 | `course_tori` | コース取り | 実際に走ったコース |
| 4 | `furi` | 振り | スタート時の出遅れ等 |
| 5 | `position_1corner` | 1コーナー位置 | 1コーナー通過位置 |
| 6 | `position_2corner` | 2コーナー位置 | 2コーナー通過位置 |
| 7 | `position_3corner` | 3コーナー位置 | 3コーナー通過位置 |
| 8 | `position_4corner` | 4コーナー位置 | 4コーナー通過位置 |
| 9 | `last_3f_time` | 上がり3F時計 | ラスト3ハロンタイム |
| 10 | `first_3f_time` | 最初3F時計 | スタート後3ハロンタイム |
| 11 | `pace_flow` | ペース流れ | ペースの推移 |
| 12 | `race_rough` | レース荒れ度 | レース展開の荒れ具合 |
| 13 | `ten_type` | 展開タイプ | 展開パターン分類 |
| 14 | `contender_level` | 相手関係レベル | 出走馬のレベル |

---

### 1.4 jrd_joa (騎手・厩舎評価) - 10列

**説明**: LS指数、騎手・厩舎の評価指標

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `ls_index` | LS指数 | 騎手・厩舎の総合評価指数 |
| 2 | `jockey_recent_win_rate` | 騎手最近勝率 | 直近の勝率 |
| 3 | `jockey_course_win_rate` | 騎手コース別勝率 | コース別勝率 |
| 4 | `jockey_distance_win_rate` | 騎手距離別勝率 | 距離別勝率 |
| 5 | `trainer_recent_win_rate` | 調教師最近勝率 | 直近の勝率 |
| 6 | `trainer_course_win_rate` | 調教師コース別勝率 | コース別勝率 |
| 7 | `trainer_distance_win_rate` | 調教師距離別勝率 | 距離別勝率 |
| 8 | `stable_win_rate` | 厩舎勝率 | 厩舎全体の勝率 |
| 9 | `jockey_stable_combo_rate` | 騎手×厩舎複合勝率 | 組み合わせ勝率 |
| 10 | `ls_info_comment` | LS情報コメント | 追加情報 |

---

### 1.5 jrd_bac (レース基本情報) - 9列

**説明**: 賞金、競走条件、馬券発売フラグ（レース単位、umaban なし）

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `baken_hatsubai_flag` | 馬券発売フラグ | 各券種の発売有無 |
| 2 | `honshoken` | 本賞金 | 1着賞金 |
| 3 | `fukashokin` | 付加賞金 | 付加賞金額 |
| 4 | `kyoso_joken` | 競走条件 | レースの条件 |
| 5 | `race_grade` | レースグレード | G1/G2/G3/OP等 |
| 6 | `race_weight_type` | 負担重量種別 | ハンデ/別定/定量 |
| 7 | `race_class` | レースクラス | 新馬/未勝利/1勝等 |
| 8 | `race_baba_jotai` | レース時馬場状態 | 良/稍重/重/不良 |
| 9 | `race_tenki` | レース時天気 | 晴/曇/雨/雪 |

---

## 2. 主キー構造

### 馬単位テーブル (jrd_kyi, jrd_cyb, jrd_sed, jrd_joa)
```python
PRIMARY KEY (
    keibajo_code,         # 競馬場コード (2桁)
    race_shikonen,        # レース施行日 (YYMMDD形式)
    kaisai_kai,           # 開催回 (2桁)
    kaisai_nichime,       # 開催日目 (2桁)
    race_bango,           # レース番号 (2桁)
    umaban                # 馬番 (2桁)
)
```

### レース単位テーブル (jrd_bac) - umaban なし
```python
PRIMARY KEY (
    keibajo_code,
    race_shikonen,
    kaisai_kai,
    kaisai_nichime,
    race_bango
)
```

---

## 3. データ型

**全カラム共通**: `character varying` (文字列型)

---

## 4. JOIN 条件（JRA-VANとの結合）

### 日付変換ロジック

**JRA-VAN側**:
- `kaisai_nen`: '2024' (YYYY形式)
- `kaisai_tsukihi`: '0307' (MMDD形式)

**JRDB側**:
- `race_shikonen`: '240307' (YYMMDD形式)

**変換SQL**:
```sql
(SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen
-- '2024' → '24' + '0307' = '240307'
```

### 馬単位テーブル JOIN
```sql
LEFT JOIN jrd_kyi AS kyi 
    ON se.keibajo_code = kyi.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = kyi.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = kyi.kaisai_nichime 
    AND se.race_bango = kyi.race_bango 
    AND se.umaban = kyi.umaban
```

### レース単位テーブル JOIN (jrd_bac のみ)
```sql
LEFT JOIN jrd_bac AS bac 
    ON se.keibajo_code = bac.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = bac.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = bac.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = bac.kaisai_nichime 
    AND se.race_bango = bac.race_bango
```

**注**: `umaban` は含まない（レース単位のため）

---

## 5. データ件数

**証拠**: PostgreSQL 検証結果

| テーブル | 行数 | 期間 |
|---------|------|------|
| `jrd_kyi` | 491,176 | 161101～262612 |
| `jrd_cyb` | 491,194 | 161101～262612 |
| `jrd_sed` | 491,017 | 161101～262612 |
| `jrd_joa` | 491,194 | 161101～262612 |
| `jrd_bac` | 35,173 | 161101～262612 |

**期間**: 2016年11月1日～2026年12月12日

---

## 6. 実装コード

**証拠ファイル**: `phase7/scripts/phase7b_factor_roi/create_merged_dataset_334cols.py`

```python
jrdb_tables = {
    'jrd_kyi': 'kyi',  # 65列
    'jrd_cyb': 'cyb',  # 18列
    'jrd_sed': 'sed',  # 14列
    'jrd_joa': 'joa',  # 10列
    'jrd_bac': 'bac'   # 9列 (レース単位)
}
```

---

## 7. JRDB データの特徴

### 7.1 独自指数
- **IDM**: JRDB独自の総合指数（最重要）
- **各種指数**: 騎手、調教師、血統、展開など12種類以上

### 7.2 詳細な適性評価
- 距離適性、馬場適性、コース適性を数値化
- 変わり身（調子の変化）、成長曲線を評価

### 7.3 調教分析
- 調教コメント、評価ランク
- 追い切りタイム、時計補正指数

### 7.4 LS指数
- 騎手・厩舎の総合評価指数
- 各種勝率データ（最近、コース別、距離別）

### 7.5 レース詳細分析
- ペース、馬場差、コース取り
- 上がり3F、展開タイプ

---

## 8. 使用上の注意

### 8.1 NULL値の扱い
- LEFT JOIN のため、JRDB データが存在しないレースでは全カラムが NULL
- `COALESCE` で NULL を適切に処理

### 8.2 日付変換の必須性
- JRA-VAN と JRDB で日付形式が異なる
- 必ず `SUBSTRING` + `||` で変換すること

### 8.3 文字列型の扱い
- 全カラムが `character varying` 型
- 数値として使用する場合は CAST が必要

---

**作成日**: 2026-03-31  
**証拠元**: サンドボックス実ファイル検証  
**総カラム数**: 116列（全て使用）
