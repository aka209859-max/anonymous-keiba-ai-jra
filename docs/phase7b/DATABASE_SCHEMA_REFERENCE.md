# Phase 7-B データベーススキーマ参考資料

## 📊 PostgreSQL データベース構成

### 接続情報
```
ホスト: 127.0.0.1
ポート: 5432
データベース: pckeiba
ユーザー: postgres
パスワード: postgres123
```

---

## 🏇 JRA-VAN テーブル構造

### 1. ベーステーブル: `jvd_se` (成績)
**主キー**: `kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango, umaban, ketto_toroku_bango`

**データ件数**: 739,559行（2016-2025年）

**重要カラム**:
| カラム名 | 型 | 形式 | 説明 | 例 |
|---------|------|------|------|-----|
| `kaisai_nen` | character varying | YYYY (4桁) | 開催年 | '2024' |
| `kaisai_tsukihi` | character varying | MMDD (4桁) | 開催月日 | '0101' |
| `keibajo_code` | character varying | 2桁 | 競馬場コード | '05' |
| `race_bango` | character varying | 2桁 | レース番号 | '11' |
| `umaban` | character varying | 2桁 | 馬番 | '01' |
| `ketto_toroku_bango` | character varying | 10桁 | 血統登録番号 | '2019105123' |
| `kaisai_kai` | character varying | 2桁 | 開催回 | '03' |
| `kaisai_nichime` | character varying | 2桁 | 開催日目 | '05' |
| `chokyoshi_code` | character varying | 5桁 | 調教師コード | '01234' |
| `banushi_code` | character varying | 6桁 | 馬主コード | '012345' |

**総カラム数**: 70

---

### 2. レース結合テーブル（レース単位で結合）
**結合キー**: `kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango`

| テーブル名 | カラム数 | 説明 |
|-----------|---------|------|
| `jvd_ra` | 31 | レース基本情報（馬場状態、天候、距離等） |
| `jvd_dm` | 16 | データマイニング予想 |
| `jvd_hr` | 18 | 払戻金詳細 |
| `jvd_h1` | 21 | 払戻金情報 |
| `jvd_h6` | 6 | 三連単払戻 |

---

### 3. レース+馬結合テーブル
**結合キー**: `kaisai_nen, kaisai_tsukihi, keibajo_code, race_bango, ketto_toroku_bango`

| テーブル名 | カラム数 | 説明 |
|-----------|---------|------|
| `jvd_ck` | 23 | レース成績・距離別成績 |
| `jvd_jg` | 3 | 除外・取消情報（+ `shutsuba_tohyo_uketsuke`） |

---

### 4. 馬マスタテーブル（馬単位で結合）
**結合キー**: `ketto_toroku_bango`

| テーブル名 | カラム数 | 説明 |
|-----------|---------|------|
| `jvd_um` | 14 | 馬基本情報（血統情報含む） |
| `jvd_sk` | 12 | 血統情報（10代分の先祖データ） |

---

### 5. 調教データテーブル（特殊キー）
**結合キー**: `ketto_toroku_bango` のみ（調教日時は複数存在）

| テーブル名 | カラム数 | 主キー | 説明 |
|-----------|---------|--------|------|
| `jvd_wc` | 17 | `tracen_kubun, chokyo_nengappi, chokyo_jikoku, ketto_toroku_bango` | ウッドチップ調教 |
| `jvd_hc` | 7 | `tracen_kubun, chokyo_nengappi, chokyo_jikoku, ketto_toroku_bango` | 芝・ダート調教 |

**注意**: 1頭の馬に対して複数の調教データが存在するため、LEFT JOIN すると行数が増える可能性あり。

---

### 6. 調教師マスタテーブル
**結合キー**: `chokyoshi_code`

| テーブル名 | カラム数 | 説明 |
|-----------|---------|------|
| `jvd_ch` | 1 | 調教師マスタ（東西所属コード） |

---

### 7. 結合不可能なテーブル（除外済み）

| テーブル名 | カラム数 | 主キー | 除外理由 |
|-----------|---------|--------|---------|
| `jvd_bt` | 2 | `hanshoku_toroku_bango` | 繁殖登録番号が `jvd_se` に存在しない |
| `jvd_hn` | 6 | `hanshoku_toroku_bango` | 繁殖登録番号が `jvd_se` に存在しない |
| `jvd_br` | 1 | `seisansha_code` | 生産者コードが `jvd_se` に存在しない |

**代替情報**:
- 血統情報: `jvd_sk` (12列) + `jvd_um` (14列) で十分カバー
- 馬主情報: `jvd_se.banushi_code`, `banushimei` で基本情報取得可能

---

## 🗂️ JRDB テーブル構造

### データ件数（全テーブル）
| テーブル名 | 件数 | 説明 |
|-----------|------|------|
| `jrd_kyi` | 491,176 | 競馬指数（メインデータ） |
| `jrd_cyb` | 491,194 | 調教分析 |
| `jrd_sed` | 491,017 | レース詳細 |
| `jrd_joa` | 491,194 | 騎手・厩舎評価 |
| `jrd_bac` | 35,173 | レース基本情報 |

**データ期間**: 161101（2016年11月1日）～ 262612（2026年12月12日）

---

### JRDB 主キー構造

**全テーブル共通の主キー要素**:
| カラム名 | 型 | 形式 | 説明 | 例 |
|---------|------|------|------|-----|
| `keibajo_code` | character varying | 2桁 | 競馬場コード | '06' |
| `race_shikonen` | character varying | YYMMDD (6桁) | レース施行年月日 | '240307' |
| `kaisai_kai` | character varying | 2桁 | 開催回 | '02' |
| `kaisai_nichime` | character varying | 2桁 | 開催日目 | '03' |
| `race_bango` | character varying | 2桁 | レース番号 | '01' |
| `umaban` | character varying | 2桁 | 馬番（`jrd_bac` 除く） | '01' |

**`jrd_bac` のみ**: レース単位のため `umaban` なし

---

### JRA-VAN との結合条件

**日付形式の変換が必要**:

```sql
-- JRA-VAN: kaisai_nen='2024' (YYYY), kaisai_tsukihi='0101' (MMDD)
-- JRDB: race_shikonen='240101' (YYMMDD)

-- 結合条件
(SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen
```

**例**:
- `SUBSTRING('2024', 3, 2)` → `'24'`
- `'24' || '0101'` → `'240101'`
- `'240101' = '240101'` → マッチ成功 ✅

---

### JRDBテーブル別カラム数

| テーブル名 | カラム数 | 主な内容 |
|-----------|---------|---------|
| `jrd_kyi` | 65 | IDM、指数、評価、適性、体型等 |
| `jrd_cyb` | 18 | 調教コメント、評価、コース情報 |
| `jrd_sed` | 14 | 馬場差、ペース、コース取り、振り |
| `jrd_joa` | 10 | 騎手・厩舎評価、LS指数 |
| `jrd_bac` | 9 | 賞金、競走条件、馬券発売フラグ |

---

## 🔗 完全な LEFT JOIN SQL 例

```sql
SELECT
    -- 主キー（race_id は複合キーから生成）
    (se.kaisai_nen || se.keibajo_code || COALESCE(se.kaisai_kai, '00') || 
     COALESCE(se.kaisai_nichime, '00') || se.race_bango) AS race_id,
    se.umaban,
    se.kaisai_tsukihi,
    
    -- JRA-VAN カラム群
    se.*,
    ra.*,
    ck.*,
    um.*,
    -- ... その他のテーブル
    
    -- JRDB カラム群
    kyi.*,
    cyb.*,
    sed.*,
    joa.*,
    bac.*

FROM jvd_se AS se

-- JRA-VAN レース結合テーブル
LEFT JOIN jvd_ra AS ra 
    ON se.kaisai_nen = ra.kaisai_nen 
    AND se.kaisai_tsukihi = ra.kaisai_tsukihi 
    AND se.keibajo_code = ra.keibajo_code 
    AND se.race_bango = ra.race_bango

-- JRA-VAN レース+馬結合テーブル
LEFT JOIN jvd_ck AS ck 
    ON se.kaisai_nen = ck.kaisai_nen 
    AND se.kaisai_tsukihi = ck.kaisai_tsukihi 
    AND se.keibajo_code = ck.keibajo_code 
    AND se.race_bango = ck.race_bango 
    AND se.ketto_toroku_bango = ck.ketto_toroku_bango

-- JRA-VAN 馬マスタテーブル
LEFT JOIN jvd_um AS um 
    ON se.ketto_toroku_bango = um.ketto_toroku_bango

LEFT JOIN jvd_sk AS sk 
    ON se.ketto_toroku_bango = sk.ketto_toroku_bango

-- JRA-VAN 調教データテーブル（複数行マッチの可能性あり）
LEFT JOIN jvd_wc AS wc 
    ON se.ketto_toroku_bango = wc.ketto_toroku_bango

LEFT JOIN jvd_hc AS hc 
    ON se.ketto_toroku_bango = hc.ketto_toroku_bango

-- JRA-VAN 調教師マスタ
LEFT JOIN jvd_ch AS ch 
    ON se.chokyoshi_code = ch.chokyoshi_code

-- JRDB 馬単位テーブル
LEFT JOIN jrd_kyi AS kyi 
    ON se.keibajo_code = kyi.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = kyi.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = kyi.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = kyi.kaisai_nichime 
    AND se.race_bango = kyi.race_bango 
    AND se.umaban = kyi.umaban

LEFT JOIN jrd_cyb AS cyb 
    ON se.keibajo_code = cyb.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = cyb.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = cyb.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = cyb.kaisai_nichime 
    AND se.race_bango = cyb.race_bango 
    AND se.umaban = cyb.umaban

-- JRDB レース単位テーブル
LEFT JOIN jrd_bac AS bac 
    ON se.keibajo_code = bac.keibajo_code 
    AND (SUBSTRING(se.kaisai_nen, 3, 2) || se.kaisai_tsukihi) = bac.race_shikonen 
    AND COALESCE(se.kaisai_kai, '00') = bac.kaisai_kai 
    AND COALESCE(se.kaisai_nichime, '00') = bac.kaisai_nichime 
    AND se.race_bango = bac.race_bango

WHERE se.kaisai_nen >= '2016' AND se.kaisai_nen <= '2025'
ORDER BY se.kaisai_nen, se.kaisai_tsukihi, se.keibajo_code, se.race_bango, se.umaban;
```

---

## 📊 統合後のデータセット仕様

### カラム構成
| カテゴリ | カラム数 | 内訳 |
|---------|---------|------|
| **JRA-VAN** | 209 | jvd_se(40) + jvd_ra(31) + jvd_ck(23) + jvd_um(14) + jvd_hr(18) + jvd_h1(21) + jvd_h6(6) + jvd_dm(16) + jvd_wc(17) + jvd_hc(7) + jvd_ch(1) + jvd_jg(3) + jvd_sk(12) |
| **JRDB** | 116 | jrd_kyi(65) + jrd_cyb(18) + jrd_sed(14) + jrd_joa(10) + jrd_bac(9) |
| **合計** | **325** | - |

### 期待データ量
- **行数**: 460,000～739,559行（JOINの結果による）
- **ファイルサイズ**: 120～200 MB
- **対象期間**: 2016-2025年

---

## ⚠️ 注意事項

### 1. 調教データテーブルの扱い
`jvd_wc` と `jvd_hc` は1頭の馬に対して複数の調教データが存在するため、LEFT JOIN すると行数が大幅に増える可能性があります。

**対策**:
- 最新の調教データのみを取得する
- サブクエリで調教データを集約してから結合する
- または、調教データを別途取得して後処理で結合する

### 2. NULL値の扱い
LEFT JOIN のため、JRDBデータが存在しないレースでは JRDB カラムが全て NULL になります。

### 3. データ型
全てのキーカラムは `character varying` 型のため、数値比較ではなく文字列比較を使用してください。

---

## 🔧 トラブルシューティング

### よくあるエラーと対処法

#### 1. `column does not exist`
→ テーブルの主キーを確認してください（本ドキュメント参照）

#### 2. `function to_char(character varying, unknown) does not exist`
→ カラムが既に文字列型の場合、`TO_CHAR()` は不要です。`SUBSTRING()` と `||` を使用してください。

#### 3. `missing FROM-clause entry for table`
→ SELECT に含めたカラムのテーブルが FROM 句に存在するか確認してください。

#### 4. データが0行
→ WHERE 句の条件、JOIN 条件（特に日付変換）を確認してください。

---

## 📚 参考情報

### 主キー確認クエリ
```sql
SELECT 
    tc.table_name,
    string_agg(kcu.column_name, ', ' ORDER BY kcu.ordinal_position) AS primary_key_columns
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'
  AND tc.table_name LIKE 'jvd_%'  -- または 'jrd_%'
GROUP BY tc.table_name
ORDER BY tc.table_name;
```

### データ件数確認クエリ
```sql
SELECT COUNT(*) FROM jvd_se WHERE kaisai_nen >= '2016' AND kaisai_nen <= '2025';
SELECT COUNT(*) FROM jrd_kyi;
```

---

## 📝 更新履歴

- 2026-03-12: 初版作成（Phase 7-B データベーススキーマ参考資料）
