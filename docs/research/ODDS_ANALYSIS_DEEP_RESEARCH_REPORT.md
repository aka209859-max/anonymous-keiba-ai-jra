# JRA競馬 オッズ帯別回収率分析の深掘り調査レポート

## 調査の結論

あなたの指示文は、目的（単勝・複勝の「オッズ帯」ごとの的中率と回収率を比較し、効率的な購入帯を探す）としては概ね妥当で、特に「TARGETの集計機能で手動検証できる」点まで書かれているのは優れている。citeturn10view3turn10view2

一方で、実務として **2016〜2024の全レース×全馬** を「オッズ帯ごとに画面で繰り返し集計」するのは、帯の数だけ操作が必要になり、転記ミス・条件ズレのリスクが高い（“手動検証”としては有効だが、主解析としては非効率）。citeturn10view3  
この規模の分析では、次の二段構えが最も堅い。

- **主解析（推奨）**：TARGETから必要項目をCSVとして一括出力し、Pythonでオッズ帯（ビン）に切って集計する  
- **手動検証（サンプルチェック）**：TARGETの「項目集計→単勝オッズ（+オッズ指定）」で、いくつかの帯だけ結果が一致するか照合する citeturn10view3

また、指示文の表にある「対象レース数」は、実際の集計単位が「馬（＝賭けの対象）」である以上、**対象数（出走頭数＝ベット数）** と表現した方が誤解がない（単勝・複勝は“馬を買う”ため、オッズ帯別に集計すると分母は馬数になる）。TARGETの成績CSV仕様でも、各馬が1レコードとして出力される設計である。citeturn11view0turn10view2

結論として、指示文は **「手動検証用の手順」として残しつつ、本番はCSV→Pythonで再現可能なパイプラインに置き換える**のが、最短で確実に成果（CSV・グラフ・Markdownレポート）まで到達できる。

## データと指標の定義

### 回収率が100%を超えにくい構造的理由

JRAの投票法（パリミュチュエル方式）では、売上の一定割合が払戻原資となり、単勝・複勝は「払戻率80%」が基準として扱われる（控除率20%に相当）。この枠組み自体はJRAの施策説明や、払戻率80%の扱いを前提にしたJRA公式文書で繰り返し言及される。citeturn2search1turn2search3turn2search16  
また、払戻の考え方として「単勝売上×0.8が払戻総額」という説明（概算）が、競馬データ提供側の解説でも示されている。citeturn2search5

このため、**「何も工夫せずオッズ帯に属する馬を全部買う」** という集計は、原理的には（端数処理や例外施策はさておき）長期では回収率が100%を大きく超え続けることは期待しにくい。したがって本分析のゴールは、しばしば次のどちらかになる。

- （現実的）**回収率が“相対的にマシ”な帯（＝損が小さい帯）を特定する**
- （条件付き）市場の歪み・施策効果を含め、特定帯で回収率が改善するかを検証する

### 「オッズ」と「払戻金」のどちらを基準に集計するか

単勝は、オッズと払戻金が（基本的に）対応しやすい。一方で複勝は、発走前は「2.6〜4.8倍」のように **幅（下限〜上限）** で表示されるのが一般的で、これは「3着以内に入る馬の組合せで払戻が変動する」ためだと説明されている。citeturn6search1  
そのため、複勝をオッズ帯で切る場合は、次のいずれかの定義を先に固定しないと、集計がブレる。

- **定義A（推奨）**：確定後の複勝払戻金から「実現オッズ＝払戻/100」を作り、その値でオッズ帯に分類する  
- 定義B：確定オッズ（複勝下限／上限）を取得し、下限で分類する  
- 定義C：確定オッズ（複勝下限／上限）を取得し、上限で分類する  
- 定義D：下限と上限の平均など、代表値を作って分類する

定義Aは、「確定後オッズは払戻テーブルの払戻金/100で求められる」とする実務的説明とも整合し、帯の定義が一意になるため、再現性が高い。citeturn5search0turn12view0

### JRAプラス10等の“払戻上乗せ”が分析に与える影響

JRAには、いわゆる“元返し（100円）”が生じる場合に「110円（1.1倍）で表示・払戻する」仕組みとして **JRAプラス10** が説明されている。citeturn7search0turn7search2turn7search4  
この制度は対象期間（2016〜2024）にも当然含まれるため、特に低オッズ帯（1.0付近）の回収率に小さくない影響を与え得る。しかも重要なのは「オッズ・払戻金は上乗せ分を含む表示になる」という点で、データ上は“自然な1.1倍”と区別がつきにくいことがある。citeturn7search0turn7search2

したがってレポートでは、少なくとも次を明記しておくのが望ましい。

- 本分析は「実際に公表された（上乗せ込みの）確定払戻」を使うのか、制度影響を除いた“素の期待値”を推定したいのか  
- 後者を狙う場合、制度影響を分離するための追加データ（票数や制度適用フラグ）が必要になる可能性が高い

## TARGET CSV出力で必要データを揃える方法

この分析に必要な項目（確定単勝オッズ・確定複勝オッズまたは複勝払戻・着順・単勝払戻・複勝払戻・人気など）は、TARGETのCSV仕様上、次の組み合わせで整合よく揃えられる。

### 成績データCSVで「着順」と「確定単勝オッズ」を取得

成績データのCSV仕様では、各馬が1行で出力され、**確定着順**・**人気順**・**（レースID+馬番の）レースID（10桁）** が含まれる。citeturn11view0  
さらに「単勝オッズ」出力を付加した場合、**確定単勝オッズ（小数点以下1桁）** として出力され、取消等は0.0になる仕様が明記されている。citeturn11view0

このため、「単勝オッズ帯別」の分母（対象数）・分子（1着回数）・的中率は、成績データCSVだけで機械的に再現できる。

### オッズCSVで「確定複勝オッズ（下限・上限）」を取得

オッズCSV仕様では、1レースにつき頭数分の行が出力され、**時刻フラグ=4が“確定”** と定義されている。citeturn11view5  
同じ行に **単勝オッズ** と **複勝オッズ下限／上限** が含まれる。citeturn11view5

したがって、複勝を「確定オッズ下限」帯で分類したいなら、時刻フラグ=4の行だけを使えばよい。citeturn11view5  
ただし、複勝オッズは元々幅を持つ表記であるため、下限を使うのか上限を使うのか（あるいは払戻ベースにするのか）を、レポートで必ず固定する必要がある。citeturn6search1turn11view5

### 配当CSVで「単勝払戻金」と「複勝払戻金」を取得

配当CSV形式（A形式）では、レース単位で **単勝馬番と単勝配当金額**、および **複勝馬番と複勝配当金額（1〜3着分、同着用の追加枠あり）** が定義されている。citeturn12view0  
同じA形式には、馬番1〜18の「確定着順・異常コード・人気・確定単勝オッズ」を並べた領域もあり、票数がなくても新仕様の成績データに登録されている場合は出力され得る、という注意書きもある。citeturn12view0

この配当CSVを使うと、払戻金を“事実として”扱えるので、複勝の「確定複勝オッズ」を **払戻/100で生成する定義A** が極めてやりやすくなる。citeturn12view0turn5search0

### 2016〜2024年を一括で出す現実的手順

TARGETには「開催成績CSV出力」があり、開催単位で出力内容を選び、出力開始する導線がヘルプに明記されている。citeturn10view2  
ここで肝心なのは、固定仕様の古い出力より、**ユーザー設定可能な出力（成績データ(ユーザー設定)など）の利用が推奨**されている点で、将来項目が増えても既存設定に影響を与えにくい設計になっている。citeturn10view2

したがって、運用としては次が堅い。

- 開催成績CSV出力で「配当A」を開催ごとに出力（払戻の基礎）
- 開催成績CSV出力で「成績データ(ユーザー設定)+単勝オッズ」相当の内容を開催ごとに出力（馬単位の結果＋単勝オッズ）
- （必要なら）オッズCSVは、確定複勝オッズ（下限・上限）が必要なケースだけ追加で出力し、時刻フラグ=4のみを採用 citeturn10view2turn11view0turn11view5turn12view0

## 集計設計

### 集計単位と「対象数」の定義

単勝・複勝のオッズ帯分析は、一般に「各馬を100円買ったと仮定した成績」を集計する形になる。この場合：

- 対象数（分母）＝そのオッズ帯に属する **馬の数（＝想定ベット数）**
- 的中数（分子）＝単勝なら1着になった馬数、複勝なら3着内になった馬数（7頭立以下の扱いなどは別途要確認）

TARGETの成績CSVが「各馬1件ずつ」出力であること、確定着順が項目として存在することからも、この解釈が自然である。citeturn11view0turn12view0

指示文の表見出し「対象レース数」は、ここを誤解させる可能性があるため、**「対象数（馬数）」に修正**するのが望ましい。

### 回収率・ROIの計算をデータ仕様に合わせる

配当CSVには「単勝配当金額」「複勝配当金額」が“金額”として入る。citeturn12view0  
そのため、100円を1点買いする前提なら、回収率は以下で一意に定義できる。

- 総購入金額 ＝ 100円 × 対象数  
- 総払戻金額 ＝ 的中した馬の払戻金の総和（単勝なら“勝った馬”の単勝配当、複勝なら“3着内の馬”の複勝配当）citeturn12view0  
- 回収率（%）＝ 総払戻金額 / 総購入金額 × 100  
- ROI（%）＝ 回収率 − 100

「平均払戻」は解釈が揺れやすいので、レポートでは次のどちらを採用したか明記すべきだ。

- **平均払戻（的中時）**＝ 的中したときの払戻金の平均（“当たったら平均いくら？”）  
- **平均払戻（ベットあたり）**＝ 総払戻金額 / 対象数（これは回収率と1対1で対応する）

### オッズ帯の切り方と境界処理

指示文は「1.0〜1.4、1.5〜1.9…」のように区切っているが、TARGETの確定単勝オッズは小数点以下1桁で出力される仕様であるため、境界の取り扱い（上端含む／下端含む）をコード側で固定しやすい。citeturn11view0  
一方で、複勝は下限・上限が別項目で出るため（しかも“確定”行を選ぶ必要がある）、帯の定義を定めないと比較不能になる。citeturn11view5turn6search1

実務上の推奨は次の通り。

- 単勝：確定単勝オッズ（1桁）で帯分け  
- 複勝：基本は「複勝払戻/100」で“確定複勝オッズ”を作って帯分け（定義A）  
- どうしても確定複勝オッズ（下限・上限）でやりたいなら、時刻フラグ=4の行に限定し、下限で分類する（定義B）などを明記 citeturn11view5turn12view0turn5search0

### 欠損・取消・異常値の扱い

成績CSVでは、取消や票数データがない場合に単勝オッズが0.0になると明記されているため、**0.0の行は集計から除外**するのが自然である。citeturn11view0  
同様に、配当CSVには同着用の枠が存在し、同着が起きた場合は複数の払戻が出る仕様であるため、そのロジックで払戻を割り当てる必要がある。citeturn12view0

## 実装リファレンス（CSV→Pythonでの再現可能な分析設計）

ここでは「TARGETの出力CSV（成績＋配当）をフォルダに集約できる」前提で、あなたが求める3つのCSVとグラフを自動生成できる設計を提示する。TARGET側で出力できる項目仕様は明文化されているため、実装は“読み取りと結合”に集中できる。citeturn11view0turn12view0turn11view5

### 入力ファイルの推奨セット

- 成績データCSV（単勝オッズ付き）  
  - 取得：開催成績CSV出力（成績データ系＋単勝オッズ）  
  - 必須項目：レースID（10桁）、確定着順、人気順、単勝オッズ citeturn11view0turn10view2
- 配当CSV（A形式）  
  - 必須項目：レースID（8桁）、単勝馬番・単勝配当、複勝馬番・複勝配当（同着枠含む） citeturn12view0
- （任意）オッズCSV（確定行）  
  - 必須項目：レースID（10桁）、時刻フラグ=4、複勝下限・上限 citeturn11view5

### 集計の骨格コード例

以下は、集計定義（帯・回収率・ROI）をコード化するための“枠組み”例である（あなたの環境に合わせて、列名とファイルパスは要調整）。

```python
import glob
import pandas as pd
import numpy as np

# --- オッズ帯（指示文準拠） ---
TAN_BINS = [
    (1.0, 1.4), (1.5, 1.9), (2.0, 2.4), (2.5, 2.9),
    (3.0, 3.9), (4.0, 4.9), (5.0, 5.9), (6.0, 6.9),
    (7.0, 7.9), (8.0, 8.9), (9.0, 9.9), (10.0, 14.9),
    (15.0, 19.9), (20.0, 29.9), (30.0, 49.9), (50.0, np.inf),
]
FUK_BINS = [
    (1.0, 1.1), (1.2, 1.4), (1.5, 1.9), (2.0, 2.4),
    (2.5, 2.9), (3.0, 3.9), (4.0, 4.9), (5.0, 5.9),
    (6.0, 6.9), (7.0, 9.9), (10.0, 14.9), (15.0, np.inf),
]

def make_band(x: float, bins):
    if pd.isna(x) or x <= 0:
        return np.nan
    for lo, hi in bins:
        if lo <= x <= hi:
            if np.isinf(hi):
                return f"{lo:.1f}倍以上"
            return f"{lo:.1f}～{hi:.1f}倍"
    return np.nan

# --- 成績CSVを読み込み（各馬1行） ---
race_rows = []
for path in glob.glob("data/results/*.csv"):
    df = pd.read_csv(path, encoding="cp932")  # TARGET CSVは環境で異なる可能性あり
    race_rows.append(df)
res = pd.concat(race_rows, ignore_index=True)

# 想定列名（TARGET仕様に合わせてリネーム）
# 例: res = res.rename(columns={"レースID":"race_id10", "確定着順":"fin", "人気順":"pop", "単勝オッズ":"tan_odds"})
res = res.dropna(subset=["race_id10"])
res = res[res["tan_odds"] > 0]  # 0.0=取消/票数なしを除外（仕様）
res["is_win"] = (res["fin"] == 1).astype(int)
res["is_place"] = (res["fin"].between(1, 3)).astype(int)  # ※7頭立以下の扱いは追加条件が必要

# --- 配当CSV（レース単位）を読み込み ---
pay_rows = []
for path in glob.glob("data/payout/*.csv"):
    df = pd.read_csv(path, encoding="cp932")
    pay_rows.append(df)
pay = pd.concat(pay_rows, ignore_index=True)

# payはrace_id8なので、resのrace_id10からrace_id8を作る
res["race_id8"] = res["race_id10"].astype(str).str[:8]
res["horse_no"] = res["race_id10"].astype(str).str[-2:].astype(int)

# payから単勝・複勝払戻を辞書化（同着枠含めて馬番→金額のマップを作る）
def build_payout_maps(pay_df):
    # ここは「配当CSV形式仕様」の番号（単勝馬番/配当、複勝馬番/配当）に合わせて列名を用意する
    # 例: columns: win_no1, win_pay1, win_no2, win_pay2 ... place_no1, place_pay1 ...
    win_map = {}
    plc_map = {}
    for _, r in pay_df.iterrows():
        rid = str(r["race_id8"])
        # 単勝（同着枠も走査）
        w = {}
        for k in [1, 2, 3]:
            no = r.get(f"win_no{k}")
            amt = r.get(f"win_pay{k}")
            if pd.notna(no) and pd.notna(amt) and int(no) > 0:
                w[int(no)] = int(amt)
        win_map[rid] = w
        # 複勝（同着枠も走査）
        p = {}
        for k in [1, 2, 3, 4, 5]:
            no = r.get(f"place_no{k}")
            amt = r.get(f"place_pay{k}")
            if pd.notna(no) and pd.notna(amt) and int(no) > 0:
                p[int(no)] = int(amt)
        plc_map[rid] = p
    return win_map, plc_map

win_map, plc_map = build_payout_maps(pay)

def lookup_win_payout(row):
    return win_map.get(row["race_id8"], {}).get(row["horse_no"], 0)

def lookup_place_payout(row):
    return plc_map.get(row["race_id8"], {}).get(row["horse_no"], 0)

res["win_payout_yen"] = res.apply(lookup_win_payout, axis=1)
res["place_payout_yen"] = res.apply(lookup_place_payout, axis=1)

# 複勝の“確定オッズ”を払戻から作る（定義A）
res["fuku_odds_implied"] = res["place_payout_yen"] / 100.0

# --- 単勝オッズ帯別集計 ---
res["tan_band"] = res["tan_odds"].apply(lambda x: make_band(x, TAN_BINS))

tan = (
    res.groupby("tan_band", dropna=False)
      .agg(
        target_n=("tan_band", "size"),
        win_n=("is_win", "sum"),
        avg_win_payout=("win_payout_yen", lambda s: s[s > 0].mean()),
        total_payout=("win_payout_yen", "sum"),
      )
      .reset_index()
)
tan["total_stake"] = tan["target_n"] * 100
tan["hit_rate_pct"] = tan["win_n"] / tan["target_n"] * 100
tan["return_pct"] = tan["total_payout"] / tan["total_stake"] * 100
tan["roi_pct"] = tan["return_pct"] - 100

# --- 複勝オッズ帯別集計（払戻ベース） ---
res["fuku_band"] = res["fuku_odds_implied"].apply(lambda x: make_band(x, FUK_BINS))

fuku = (
    res.groupby("fuku_band", dropna=False)
      .agg(
        target_n=("fuku_band", "size"),
        place_n=("is_place", "sum"),
        avg_place_payout=("place_payout_yen", lambda s: s[s > 0].mean()),
        total_payout=("place_payout_yen", "sum"),
      )
      .reset_index()
)
fuku["total_stake"] = fuku["target_n"] * 100
fuku["hit_rate_pct"] = fuku["place_n"] / fuku["target_n"] * 100
fuku["return_pct"] = fuku["total_payout"] / fuku["total_stake"] * 100
fuku["roi_pct"] = fuku["return_pct"] - 100

# --- 人気別（参考） ---
res["pop_band"] = np.select(
    [
        res["pop"] == 1,
        res["pop"] == 2,
        res["pop"] == 3,
        res["pop"] == 4,
        res["pop"] == 5,
        res["pop"] >= 6,
    ],
    ["1番人気", "2番人気", "3番人気", "4番人気", "5番人気", "6番人気以下"],
    default=np.nan
)

ninki = (
    res.groupby("pop_band", dropna=False)
      .agg(
        target_n=("pop_band", "size"),
        win_n=("is_win", "sum"),
        place_n=("is_place", "sum"),
        win_total=("win_payout_yen", "sum"),
        place_total=("place_payout_yen", "sum"),
      )
      .reset_index()
)
ninki["stake"] = ninki["target_n"] * 100
ninki["win_hit_rate_pct"] = ninki["win_n"] / ninki["target_n"] * 100
ninki["place_hit_rate_pct"] = ninki["place_n"] / ninki["target_n"] * 100
ninki["win_return_pct"] = ninki["win_total"] / ninki["stake"] * 100
ninki["place_return_pct"] = ninki["place_total"] / ninki["stake"] * 100

# CSV出力
tan.to_csv("tansho_odds_analysis_2016-2024.csv", index=False, encoding="utf-8-sig")
fuku.to_csv("fukusho_odds_analysis_2016-2024.csv", index=False, encoding="utf-8-sig")
ninki.to_csv("ninki_analysis_2016-2024.csv", index=False, encoding="utf-8-sig")
```

この実装方針が「TARGETの仕様に依存して壊れにくい」理由は、(1)成績CSVに確定着順と確定単勝オッズが明記されている、(2)配当CSVに単勝・複勝の配当金額が明記されている、(3)オッズCSVに“確定（時刻フラグ=4）”が明記されている――という、入力仕様が文章として固定されているからである。citeturn11view0turn12view0turn11view5

## 結果の読み方と、期待される歪みの方向性

### “本命–大穴バイアス”がオッズ帯別回収率に影響する

競馬の投票市場では、一般に「大穴（勝率が低い賭け）に過剰な人気が集まり、本命（勝率が高い賭け）が相対的に割安になる」現象が知られ、研究サーベイでも整理されている。citeturn8view0  
日本の競馬データを用いた検討としても、「本命–大穴バイアス」や、より大穴な賭式ほど人気が過剰になりやすいという方向性が議論されている。citeturn8view1turn8view0

あなたの分析はまさに、この歪みが **単勝・複勝の“どのオッズ帯で強く出るか”** を、2016〜2024の全量データで測る行為になる。ここで重要なのは、結論が「回収率100%超の帯が見つかる」よりも、「相対的に損が小さい帯」「歪みが出やすい帯」が見つかる形になりやすい点である（払戻率の制約があるため）。citeturn2search5turn2search1

### オッズの端数処理と、推定による誤差に注意する

研究サーベイでは、オッズから売上比率を逆算する際に、**公表オッズの切り捨て（小数点処理）** が誤差源になり得ることが指摘される。citeturn6search8  
TARGET側のヘルプでも、オッズデータの性質によっては逆算値に誤差が出ること、そして元データそのもの（累計オッズのような“そのもの”）を見れば計算誤差はない、という趣旨の説明がある。citeturn4view2

今回の目的（確定回収率）では、**払戻金（配当）を一次情報として使う**設計（配当CSVを正とする）が誤差耐性の面で最も堅い。citeturn12view0turn5search0

## 指示文の改善案と、最終アウトプット仕様

### 指示文の改善ポイント

あなたの指示文を「不変の仕様」として運用するなら、次の修正だけで精度が上がる。

- 表の「対象レース数」→ **対象数（馬数）** に変更（単勝・複勝は馬単位で賭けるため） citeturn11view0  
- 複勝の「確定複勝オッズ」を、どの定義で扱うか明記（推奨：**複勝払戻/100** を確定複勝オッズとみなす） citeturn12view0turn6search1turn5search0  
- JRAプラス10等の上乗せ施策が、低オッズ帯の回収率に影響し得ることを注記（オッズ・払戻が上乗せ込み表示になる） citeturn7search0turn7search2  
- 「手動で帯ごとに集計」は“検証用”に格下げし、主解析はCSV→Pythonで再現する、と書き換える（2016〜2024全量では必須に近い）citeturn10view3turn10view2

### 出力CSVとレポートの最終形

あなたが提示した3つのCSV（単勝帯、複勝帯、人気別）は、そのまま最終成果物として成立する。  
加えて、レポート（Markdown）には「帯の定義（境界含む）」「複勝オッズの定義」「除外ルール（取消・オッズ0.0）」「上乗せ施策の扱い」を必ず明記することが、再現性と説明責任の面で重要になる。citeturn11view0turn7search0turn12view0

なお、データの共有・公開については、情報提供側のガイドラインで再配布や転載を禁じる趣旨が示されているため、外部共有を想定する場合は「集計結果の粒度」を落とす、または公開範囲を限定するなど、別途の設計が必要になり得る。citeturn6search3