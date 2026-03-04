# Phase 7-A pgAdmin4完全調査結果（最終版）

**調査日時**: 2026-03-03  
**調査方法**: pgAdmin4による直接SQL実行  
**目的**: JRA-VAN + JRDB全カラム情報取得、Phase 7-A特徴量拡張（139 → 200-220次元）の基礎確立

---

## 📊 データベース全体サマリー（確定）

### 総合統計
| 項目 | 数値 |
|------|------|
| **総テーブル数** | **100テーブル** |
| **JRA-VANテーブル数**（jvd_*） | **38テーブル** |
| **JRDBテーブル数**（jrd_*） | **5テーブル** |
| **地方競馬テーブル数**（nvd_*） | 33テーブル |
| **その他テーブル数**（apd_*, myd_*） | 24テーブル |

### データ規模（確定）
| データソース | テーブル数 | 総カラム数 | 総行数 |
|-------------|-----------|-----------|--------|
| **JRA-VAN**（jvd_*） | 38 | **1,649** | 19,415,067 |
| **JRDB**（jrd_*） | 5 | **290** | 16,543 |
| **合計** | 43 | **1,939** | 19,431,610 |

---

## 🎯 Phase 7-A 特徴量拡張計画（確定）

### 現状と目標
- **現在の特徴量数**: 139カラム（Phase 1-6で厳選済み）
- **データベース総カラム数**: **1,939カラム**（JRA-VAN 1,649 + JRDB 290）
- **目標特徴量数**: **200-220カラム**
- **必要追加数**: **61〜81カラム**

### 拡張余地
- **未使用カラム数**: 1,939 - 139 = **1,800カラム**
- **選定比率**: 目標61〜81カラム / 未使用1,800カラム ≈ **3.4〜4.5%**
- **評価**: ✅ **十分な拡張余地あり**（ROI向上有望カラムを厳選可能）

---

## 📋 JRDBテーブル完全詳細（5テーブル、290カラム）

### JRDBテーブル一覧

| # | テーブル名 | カラム数 | 行数 | 内容 | ROI向上可能性 |
|---|-----------|---------|------|------|-------------|
| 1 | **jrd_kyi** | **132** | 4,828 | **馬・騎手指標（最重要）** | ⭐⭐⭐⭐⭐ |
| 2 | **jrd_sed** | **80** | 3,696 | **成績・戦績（最重要）** | ⭐⭐⭐⭐⭐ |
| 3 | jrd_cyb | 27 | 3,081 | 調教情報 | ⭐⭐⭐⭐ |
| 4 | jrd_bac | 27 | 110 | 馬場・コース | ⭐⭐⭐ |
| 5 | jrd_joa | 24 | 4,828 | 馬場指数 | ⭐⭐⭐ |

**JRDB合計**: 290カラム

---

## 🔍 JRDBテーブル詳細カラム分析

### 1. jrd_kyi（馬・騎手指標）- 132カラム ⭐⭐⭐⭐⭐

**ROI向上最重要カラム**:

#### A. JRDB独自指数系（最優先）
```
idm                          # IDM指数（JRDB総合指標）
kishu_shisu                  # 騎手指数
joho_shisu                   # 情報指数
sogo_shisu                   # 総合指数
ninki_shisu                  # 人気指数
chokyo_shisu                 # 調教指数
kyusha_shisu                 # 厩舎指数
gekiso_shisu                 # 激走指数

ten_shisu                    # テン指数（スタートダッシュ力）
pace_shisu                   # ペース指数
agari_shisu                  # 上がり指数（ラストスパート力）
ichi_shisu                   # 位置取り指数
```

#### B. 適性・評価コード系
```
kyakushitsu_code             # 脚質コード（逃げ・先行・差し・追込）
kyori_tekisei_code           # 距離適性コード
kyori_tekisei_code_2         # 距離適性コード2
joshodo_code                 # 上昇度コード
tekisei_code_shiba           # 芝適性コード
tekisei_code_dirt            # ダート適性コード
tekisei_code_omo             # 重馬場適性コード
rotation                     # ローテーション
```

#### C. 位置取り・展開予想系
```
pace_yoso                    # ペース予想
dochu_juni                   # 道中順位予想
dochu_sa                     # 道中差
dochu_uchisoto               # 道中内外
kohan_3f_juni                # 後半3F順位予想
kohan_3f_sa                  # 後半3F差
kohan_3f_uchisoto            # 後半3F内外
goal_juni                    # ゴール順位予想
goal_sa                      # ゴール差
goal_uchisoto                # ゴール内外
tenkai_kigo_code             # 展開記号コード
```

#### D. 指数順位系
```
gekiso_juni                  # 激走順位
ls_shisu_juni                # LS指数順位
ten_shisu_juni               # テン指数順位
pace_shisu_juni              # ペース指数順位
agari_shisu_juni             # 上がり指数順位
ichi_shisu_juni              # 位置指数順位
```

#### E. 騎手・調教師期待値系
```
kishu_kitai_rentai_ritsu     # 騎手期待連対率
kishu_kitai_tansho_ritsu     # 騎手期待単勝率
kishu_kitai_sanchakunai_ritsu # 騎手期待3着内率
chokyo_yajirushi_code        # 調教矢印コード（↑↓）
kyusha_hyoka_code            # 厩舎評価コード
```

#### F. 馬体・調教評価系
```
bataiju                      # 馬体重
bataiju_zogen                # 馬体重増減
hizume_code                  # 蹄コード
batai_code                   # 馬体コード（jrd_sedにも）
kehai_code                   # 気配コード（jrd_sedにも）
class_code                   # クラスコード
```

#### G. 体型・特記事項
```
taikei                       # 体型
taikei_sogo_1/2/3            # 体型総合1/2/3
uma_tokki_1/2/3              # 馬特記1/2/3
uma_start_shisu              # 馬スタート指数
uma_deokure_ritsu            # 馬出遅れ率
manken_shisu                 # 万券指数
manken_shirushi              # 万券印
```

#### H. 調教・厩舎評価
```
hobokusaki                   # 放牧先
hobokusaki_rank              # 放牧先ランク
kyusha_rank                  # 厩舎ランク
nyukyu_nansome               # 入厩何走目
nyukyu_nengappi              # 入厩年月日
nyukyu_nannichimae           # 入厩何日前
```

#### I. 過去成績キー
```
kako1_kyoso_seiseki_key      # 過去1走競走成績キー
kako2_kyoso_seiseki_key      # 過去2走競走成績キー
kako3_kyoso_seiseki_key      # 過去3走競走成績キー
kako4_kyoso_seiseki_key      # 過去4走競走成績キー
kako5_kyoso_seiseki_key      # 過去5走競走成績キー
```

---

### 2. jrd_sed（成績・戦績）- 80カラム ⭐⭐⭐⭐⭐

**ROI向上最重要カラム**:

#### A. JRDB指数系
```
idm                          # IDM指数
soten                        # 素点
babasa                       # 馬場差
pace                         # ペース
ten_shisu                    # テン指数
agari_shisu                  # 上がり指数
pace_shisu                   # ペース指数
race_p_shisu                 # レースペース指数
```

#### B. 走り方・展開評価
```
deokure                      # 出遅れ
ichidori                     # 位置取り
furi                         # 不利
furi_1/2/3                   # 不利1/2/3
race                         # レース評価
course_dori_code             # コース取りコード
corse_dori_code_corner_4     # 4コーナーコース取りコード
```

#### C. ペース評価
```
race_pace                    # レースペース
uma_pace                     # 馬ペース
race_pace_nagare             # レースペース流れ
uma_pace_nagare              # 馬ペース流れ
```

#### D. タイム・ラップ系
```
soha_time                    # 走破タイム
zenhan_3f_taimu              # 前半3Fタイム
kohan_3f                     # 後半3F
zenhan_3f_sento_sa           # 前半3F先頭差
kohan_3f_sento_sa            # 後半3F先頭差
```

#### E. コーナー通過順位
```
corner_1                     # 1コーナー通過順位
corner_2                     # 2コーナー通過順位
corner_3                     # 3コーナー通過順位
corner_4                     # 4コーナー通過順位
```

#### F. 評価コード
```
joshodo_code                 # 上昇度コード
class_code                   # クラスコード
batai_code                   # 馬体コード
kehai_code                   # 気配コード
kyakushitsu_code             # 脚質コード
```

#### G. オッズ系
```
tansho_odds                  # 単勝オッズ（確定）
tansho_ninkijun              # 単勝人気順
odds_fukusho                 # 複勝オッズ
odds_tansho_10am             # 単勝オッズ（10時）
odds_fukusho_10am            # 複勝オッズ（10時）
```

#### H. 配当・賞金
```
haraimodoshi_tansho          # 払戻単勝
haraimodoshi_fukusho         # 払戻複勝
honshokin                    # 本賞金
shutoku_shokin               # 取得賞金
```

---

### 3. jrd_cyb（調教情報）- 27カラム ⭐⭐⭐⭐

**ROI向上有望カラム**:
```
chokyo_type                  # 調教タイプ
chokyo_corse_shubetsu        # 調教コース種別
chokyo_corse_hanro/wood/dirt/shiba/pool/shogai/polytrack  # 各コース別調教
chokyo_kyori                 # 調教距離
chokyo_juten                 # 調教重点
oikiri_shisu                 # 追切指数
shiage_shisu                 # 仕上指数
chokyo_ryo_hyoka             # 調教量評価
shiage_shisu_henka           # 仕上指数変化
chokyo_hyoka                 # 調教評価
oikiri_shisu_isshumae        # 追切指数一週前
```

---

### 4. jrd_bac（馬場・コース）- 27カラム ⭐⭐⭐

**基本レース情報**:
```
keibajo_code                 # 競馬場コード
kyori                        # 距離
track_code                   # トラックコード
kyoso_shubetsu_code          # 競走種別コード
kyoso_joken_code             # 競走条件コード
grade_code                   # グレードコード
course_kubun                 # コース区分
kaisai_kubun                 # 開催区分
honshokin                    # 本賞金
fukashokin                   # 副賞金
```

---

### 5. jrd_joa（馬場指数）- 24カラム ⭐⭐⭐

**JRDB独自指標**:
```
kijun_odds_tansho            # 基準オッズ単勝
kijun_odds_fukusho           # 基準オッズ複勝
cid_chokyo_soten             # CID調教素点
cid_kyusha_soten             # CID厩舎素点
cid_soten                    # CID素点
cid                          # CID
ls_shisu                     # LS指数
ls_hyoka                     # LS評価
em                           # EM
kyusha_bb_shirushi           # 厩舎ビッグバン印
kyusha_bb_nijumaru_tansho_kaishuritsu    # 厩舎BB◎単勝回収率
kyusha_bb_nijumaru_rentai_ritsu          # 厩舎BB◎連対率
kishu_bb_shirushi            # 騎手ビッグバン印
kishu_bb_nijumaru_tansho_kaishuritsu     # 騎手BB◎単勝回収率
kishu_bb_nijumaru_rentai_ritsu           # 騎手BB◎連対率
```

---

## 🎯 ROI向上最重要JRDB特徴量リスト（優先度順）

### 優先度1（必須 - ROI直接影響）

#### JRDB独自指数（10カラム）
```
jrd_kyi.idm                  # IDM指数
jrd_kyi.ten_shisu            # テン指数
jrd_kyi.pace_shisu           # ペース指数
jrd_kyi.agari_shisu          # 上がり指数
jrd_kyi.ichi_shisu           # 位置指数
jrd_kyi.sogo_shisu           # 総合指数
jrd_kyi.ninki_shisu          # 人気指数
jrd_kyi.gekiso_shisu         # 激走指数
jrd_kyi.chokyo_shisu         # 調教指数
jrd_kyi.kyusha_shisu         # 厩舎指数
```

#### 展開予想（10カラム）
```
jrd_kyi.pace_yoso            # ペース予想
jrd_kyi.dochu_juni           # 道中順位
jrd_kyi.kohan_3f_juni        # 後半3F順位
jrd_kyi.goal_juni            # ゴール順位
jrd_kyi.dochu_sa             # 道中差
jrd_kyi.kohan_3f_sa          # 後半3F差
jrd_kyi.goal_sa              # ゴール差
jrd_kyi.dochu_uchisoto       # 道中内外
jrd_kyi.kohan_3f_uchisoto    # 後半3F内外
jrd_kyi.goal_uchisoto        # ゴール内外
```

#### 成績指数（8カラム）
```
jrd_sed.idm                  # IDM指数（実績）
jrd_sed.ten_shisu            # テン指数（実績）
jrd_sed.pace_shisu           # ペース指数（実績）
jrd_sed.agari_shisu          # 上がり指数（実績）
jrd_sed.soten                # 素点
jrd_sed.babasa               # 馬場差
jrd_sed.pace                 # ペース
jrd_sed.race_p_shisu         # レースペース指数
```

### 優先度2（推奨 - ROI間接影響）

#### 適性評価（7カラム）
```
jrd_kyi.kyakushitsu_code     # 脚質コード
jrd_kyi.kyori_tekisei_code   # 距離適性
jrd_kyi.tekisei_code_shiba   # 芝適性
jrd_kyi.tekisei_code_dirt    # ダート適性
jrd_kyi.tekisei_code_omo     # 重馬場適性
jrd_kyi.joshodo_code         # 上昇度
jrd_kyi.rotation             # ローテーション
```

#### 騎手期待値（3カラム）
```
jrd_kyi.kishu_kitai_rentai_ritsu        # 騎手期待連対率
jrd_kyi.kishu_kitai_tansho_ritsu        # 騎手期待単勝率
jrd_kyi.kishu_kitai_sanchakunai_ritsu   # 騎手期待3着内率
```

#### 調教評価（6カラム）
```
jrd_cyb.oikiri_shisu         # 追切指数
jrd_cyb.shiage_shisu         # 仕上指数
jrd_cyb.chokyo_hyoka         # 調教評価
jrd_cyb.shiage_shisu_henka   # 仕上指数変化
jrd_kyi.chokyo_yajirushi_code # 調教矢印
jrd_kyi.kyusha_hyoka_code    # 厩舎評価
```

#### 走り方評価（5カラム）
```
jrd_sed.deokure              # 出遅れ
jrd_sed.ichidori             # 位置取り
jrd_sed.furi                 # 不利
jrd_sed.race                 # レース評価
jrd_sed.course_dori_code     # コース取り
```

---

## 📊 Phase 7-A 特徴量拡張計画（最終確定版）

### 追加候補カラム選定基準

#### JRA-VANから（目標: 30〜40カラム）
1. タイム・ラップ系: 10カラム
2. コーナー通過順位: 8カラム
3. 馬場状態別成績: 8カラム
4. 距離別成績: 6カラム
5. 競馬場別成績: 4カラム
6. 賞金累計系: 4カラム

#### JRDBから（目標: 31〜41カラム）
1. JRDB指数系（優先度1）: 18カラム
2. 展開予想系（優先度1）: 10カラム
3. 適性評価系（優先度2）: 7カラム
4. 騎手期待値系（優先度2）: 3カラム
5. 調教評価系（優先度2）: 6カラム
6. 走り方評価系（優先度2）: 5カラム

**合計追加数**: 61〜81カラム  
**最終特徴量数**: 200〜220カラム（現在139 + 追加61〜81）

---

## ✅ Day 1-2 完了確認

### 達成項目
- [x] PostgreSQL接続確認
- [x] 全100テーブル確認
- [x] JRA-VAN 38テーブル、1,649カラム詳細取得
- [x] **JRDB 5テーブル、290カラム詳細取得**（✅ 完了）
- [x] 総カラム数1,939個確認
- [x] 未使用カラム1,800個特定
- [x] ROI向上有望カラムリスト作成

### 成功基準達成状況
| 項目 | 目標 | 実績 | 達成率 |
|------|------|------|--------|
| データベース接続 | ✅ | ✅ | 100% |
| 総テーブル数 | 20個以上 | 100個 | **500%** |
| 総カラム数 | 300個以上 | 1,939個 | **646%** |
| JRA-VANテーブル | 10個以上 | 38個 | **380%** |
| JRDBテーブル | 5個以上 | 5個 | **100%** |
| 追加候補カラム | 60個以上 | 1,800個 | **3,000%** |

---

## 📝 次のステップ（Day 3-4）

### 1. 既存139カラムの分析
- `data/raw/jravan_jrdb_merged_fixed.csv` 読み込み
- 11カテゴリに分類
- データベースカラムとの対応確認

### 2. ROI向上有望61〜81カラムの選定
- JRA-VANから30〜40カラム選定
- JRDBから31〜41カラム選定
- 優先度1（必須）、優先度2（推奨）、優先度3（候補）に分類

### 3. 追加特徴量抽出SQLクエリ作成
- JRA-VAN抽出クエリ
- JRDB抽出クエリ
- 結合キー確認

### 4. `extract_additional_features.py` 実装
- 選定カラム抽出
- 既存139カラムとの結合
- データ品質チェック

---

**Phase 7-A Day 1-2 完了！**  
**調査完了日時**: 2026-03-03  
**Git コミット**: 次回作成予定  
**次回アクション**: Day 3-4（候補選定・抽出スクリプト作成）
