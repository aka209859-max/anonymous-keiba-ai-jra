# JRA-VAN データ形式: 209列詳細

**証拠ファイル**: `docs/PHASE7A_COMBINED_497_UNIQUE_COLNAME.csv`  
**調査日**: 2026-03-31  
**実際の使用列数**: 218列（元データ）→ **209列**（最終使用、race_id等9列を動的生成・除外）

---

## 1. テーブル別カラム一覧

### 1.1 jvd_se (成績テーブル) - 40列

**説明**: レース結果の基礎データ（最重要ベーステーブル）

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `kaisai_nen` | 開催年 | YYYY形式（例: '2024'） |
| 2 | `kaisai_tsukihi` | 開催月日 | MMDD形式（例: '0307'） |
| 3 | `keibajo_code` | 競馬場コード | 2桁数字 |
| 4 | `kaisai_kai` | 開催回 | 第何回開催か |
| 5 | `kaisai_nichime` | 開催日目 | 何日目か |
| 6 | `race_bango` | レース番号 | 1-12 |
| 7 | `umaban` | 馬番 | 1-18 |
| 8 | `ketto_toroku_bango` | 血統登録番号 | 10桁 |
| 9 | `bamei` | 馬名 | 最大36バイト |
| 10 | `barei` | 馬齢 | 単位:歳 |
| 11 | `bataiju` | 馬体重 | 単位:kg |
| 12 | `blinker_shiyo_kubun` | ブリンカー使用区分 | 0:なし 1:あり |
| 13 | `chokyoshi_code` | 調教師コード | 5桁数字 |
| 14 | `chokyoshimei_ryakusho` | 調教師名略称 | - |
| 15 | `banushi_code` | 馬主コード | 5桁英数字 |
| 16 | `banushimei` | 馬主名 | 最大64バイト |
| 17 | `data_kubun` | データ区分 | 1:速報 2:確定 |
| 18 | `aiteuma_joho_1` | 相手馬情報1 | - |
| 19 | `aiteuma_joho_2` | 相手馬情報2 | - |
| 20 | `aiteuma_joho_3` | 相手馬情報3 | - |
| 21 | `chakusa_code_1` | 着差コード1 | - |
| 22 | `chakusa_code_2` | 着差コード2 | - |
| 23 | `chakusa_code_3` | 着差コード3 | - |
| 24 | `corner_1` | コーナー通過順1 | - |
| 25 | `corner_2` | コーナー通過順2 | - |
| 26 | `corner_3` | コーナー通過順3 | - |
| 27 | `corner_4` | コーナー通過順4 | - |
| ... | （他13列省略） | ... | ... |

---

### 1.2 jvd_ra (レース基本情報) - 31列

**説明**: 馬場状態、天候、距離などのレース条件

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `babajotai_code_shiba` | 馬場状態コード芝 | 1:良 2:稍重 3:重 4:不良 |
| 2 | `babajotai_code_dirt` | 馬場状態コードダート | 1:良 2:稍重 3:重 4:不良 |
| 3 | `course_kubun` | コース区分 | A/B/C/D/E |
| 4 | `course_kubun_henkomae` | コース区分変更前 | - |
| 5 | `corner_tsuka_juni_1` | コーナー通過順位1 | - |
| 6 | `corner_tsuka_juni_2` | コーナー通過順位2 | - |
| 7 | `corner_tsuka_juni_3` | コーナー通過順位3 | - |
| 8 | `corner_tsuka_juni_4` | コーナー通過順位4 | - |
| 9 | `fukashokin` | 付加賞金 | 単位:万円 |
| 10 | `data_sakusei_nengappi` | データ作成年月日 | YYYYMMDD |
| ... | （他21列省略） | ... | ... |

---

### 1.3 jvd_ck (レース成績・距離別成績) - 23列

**説明**: 過去成績、距離別パフォーマンス

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `banushimei_hojinkaku` | 馬主名法人格 | 法人の場合 |
| 2 | `chokyoshimei` | 調教師名 | フルネーム |
| 3 | `chuo_gokei` | 中央合計 | 中央競馬成績 |
| 4 | `dirt_1200_ika` | ダート1200m以下 | - |
| 5 | `dirt_1201_1400` | ダート1201-1400m | - |
| 6 | `dirt_1401_1600` | ダート1401-1600m | - |
| 7 | `dirt_1601_1800` | ダート1601-1800m | - |
| 8 | `dirt_1801_2000` | ダート1801-2000m | - |
| 9 | `dirt_2001_2200` | ダート2001-2200m | - |
| 10 | `dirt_2201_2400` | ダート2201-2400m | - |
| 11 | `dirt_2401_2800` | ダート2401-2800m | - |
| 12 | `dirt_2801_ijo` | ダート2801m以上 | - |
| 13 | `dirt_choku` | ダート直線 | - |
| ... | （他10列省略） | ... | ... |

---

### 1.4 jvd_h1 (払戻金情報) - 21列

**説明**: 各馬券の配当金額

---

### 1.5 jvd_hr (払戻金詳細) - 18列

**説明**: 払戻金の詳細内訳

---

### 1.6 jvd_wc (ウッドチップ調教) - 17列

**説明**: ウッドチップコースでの調教データ

---

### 1.7 jvd_dm (データマイニング予想) - 16列

**説明**: JRA公式のデータマイニング予想値

---

### 1.8 jvd_um (馬基本情報) - 14列

**説明**: 馬の血統・基本プロフィール

| # | カラム名 | 日本語名 | 説明 |
|---|---------|---------|------|
| 1 | `bamei_eur` | 馬名欧字 | 欧字表記 |
| 2 | `bamei_hankaku_kana` | 馬名半角カナ | カナ表記 |
| 3 | `dirt_furyo` | ダート不良 | 不良馬場適性 |
| 4 | `dirt_hidari` | ダート左回り | 左回り適性 |
| 5 | `dirt_long` | ダート長距離 | 長距離適性 |
| ... | （他9列省略） | ... | ... |

---

### 1.9 jvd_sk (血統情報) - 12列

**説明**: 10代分の先祖血統データ

---

### 1.10 jvd_hc (芝・ダート調教) - 7列

**説明**: 芝・ダートコースでの調教データ

---

### 1.11 jvd_h6 (三連単払戻) - 6列

**説明**: 三連単の配当情報

---

### 1.12 jvd_jg (除外・取消情報) - 3列

**説明**: 出走取消・除外の理由

---

### 1.13 jvd_ch (調教師マスタ) - 1列

**説明**: 調教師の東西所属コード

---

## 2. 除外されたテーブル（結合不可）

### ❌ jvd_bt (繁殖馬) - 2列
**除外理由**: `hanshoku_toroku_bango`（繁殖登録番号）が `jvd_se` に存在しない

### ❌ jvd_hn (繁殖牝馬) - 6列
**除外理由**: `hanshoku_toroku_bango` が `jvd_se` に存在しない

### ❌ jvd_br (生産者) - 1列
**除外理由**: `seisansha_code`（生産者コード）が `jvd_se` に存在しない

**代替情報**: 血統データは `jvd_sk` (12列) + `jvd_um` (14列) で十分カバー

---

## 3. データ型

**全カラム共通**: `character varying` (文字列型)

**注意点**:
- 数値比較ではなく文字列比較を使用
- 日付変換には `SUBSTRING()` と文字列結合 `||` を使用
- `TO_CHAR()` は使用不可（既に文字列型のため）

---

## 4. JOIN 条件

### レース単位テーブル
```sql
ON se.kaisai_nen = ra.kaisai_nen 
   AND se.kaisai_tsukihi = ra.kaisai_tsukihi 
   AND se.keibajo_code = ra.keibajo_code 
   AND se.race_bango = ra.race_bango
```

### レース+馬単位テーブル
```sql
ON se.kaisai_nen = ck.kaisai_nen 
   AND se.kaisai_tsukihi = ck.kaisai_tsukihi 
   AND se.keibajo_code = ck.keibajo_code 
   AND se.race_bango = ck.race_bango 
   AND se.ketto_toroku_bango = ck.ketto_toroku_bango
```

### 馬マスタテーブル
```sql
ON se.ketto_toroku_bango = um.ketto_toroku_bango
```

### 調教師マスタテーブル
```sql
ON se.chokyoshi_code = ch.chokyoshi_code
```

---

## 5. 実装コード

**証拠ファイル**: `phase7/scripts/phase7b_factor_roi/create_merged_dataset_334cols.py`

```python
jvd_tables = {
    'jvd_ra': 'ra',
    'jvd_ck': 'ck',
    'jvd_um': 'um',
    'jvd_hr': 'hr',
    'jvd_h1': 'h1',
    'jvd_h6': 'h6',
    'jvd_dm': 'dm',
    # 'jvd_bt': 'bt',  # ❌ 除外
    'jvd_wc': 'wc',
    'jvd_hc': 'hc',
    'jvd_ch': 'ch',
    # 'jvd_hn': 'hn',  # ❌ 除外
    # 'jvd_br': 'br',  # ❌ 除外
    'jvd_jg': 'jg',
    'jvd_sk': 'sk'
}
```

---

**作成日**: 2026-03-31  
**証拠元**: サンドボックス実ファイル検証
