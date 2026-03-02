# Phase 6: リアルタイム予測システム 調査指示書

## 📅 作成日時
2026-02-22

---

## 🎯 目的

**JRA競馬AI予想システムを実戦運用するために、当日のレースデータを取得して予測を実行するシステムを構築する。**

現在、Phase 5までで過去データ（2016-2025年）を使った予測モデルは完成している。次のステップとして、**当日のレースデータを取得→特徴量変換→予測実行**のパイプラインを構築する必要がある。

---

## 🔍 調査項目

### 1. PC-KEIBA データベース構造調査

#### 調査目的
PC-KEIBAのデータベース（SQLite/Access等）から、当日のレース情報と馬のデータを取得する方法を確立する。

#### 具体的な調査内容

##### 1.1 データベースファイルの場所
- [ ] PC-KEIBAのインストールディレクトリを確認
- [ ] データベースファイル（.db, .mdb, .accdb等）の場所を特定
- [ ] ファイル名とパスを記録

**確認方法**:
```powershell
# PC-KEIBAのインストールディレクトリを探す
Get-ChildItem "C:\Program Files\" -Recurse -Filter "*KEIBA*" -ErrorAction SilentlyContinue
Get-ChildItem "C:\Program Files (x86)\" -Recurse -Filter "*KEIBA*" -ErrorAction SilentlyContinue

# データベースファイルを探す
Get-ChildItem "C:\" -Recurse -Include "*.db","*.mdb","*.accdb" -ErrorAction SilentlyContinue | Where-Object { $_.FullName -like "*KEIBA*" }
```

##### 1.2 データベーステーブル構造
- [ ] 出馬表データのテーブル名
- [ ] 馬情報のテーブル名
- [ ] 騎手情報のテーブル名
- [ ] レース情報のテーブル名
- [ ] 過去成績のテーブル名

**確認方法（SQLiteの場合）**:
```python
import sqlite3

# データベースに接続
conn = sqlite3.connect('path/to/pckeiba.db')
cursor = conn.cursor()

# 全テーブル名を取得
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()
print("テーブル一覧:", tables)

# 各テーブルのスキーマを確認
for table in tables:
    table_name = table[0]
    cursor.execute(f"PRAGMA table_info({table_name});")
    columns = cursor.fetchall()
    print(f"\n{table_name} のカラム:")
    for col in columns:
        print(f"  {col[1]} ({col[2]})")

conn.close()
```

##### 1.3 必要なデータ項目の確認
現在のAIモデルは以下の特徴量を使用しているため、これらのデータが取得できるか確認：

**基本情報**:
- レース番号、開催日、競馬場コード
- 馬番、馬名
- 騎手名、調教師名
- 馬主名

**レース条件**:
- 距離、コース種別（芝/ダート）
- 馬場状態、天候
- グレード、クラス

**馬の情報**:
- 性別、年齢
- 斤量
- 人気順位、オッズ

**過去成績**:
- 前走のタイム、着順
- 前走の競馬場、距離
- 過去のコース実績
- 過去の騎手実績

**JRDB指数**（重要！）:
- 期待単勝率
- 期待連対率
- 馬場指数
- テン指数、ペース指数、上がり指数
- 位置指数、騎手指数、調教指数、芝指数
- その他JRDB独自指数

---

### 2. JRDBデータの取得方法調査

#### 調査目的
JRDBデータは予測精度に大きく影響する重要な特徴量。PC-KEIBAがJRDBデータをどのように取得・保存しているかを確認する。

#### 具体的な調査内容

##### 2.1 JRDBデータの保存場所
- [ ] PC-KEIBA内でJRDBデータがどこに保存されているか
- [ ] データ形式（CSV、データベース、独自形式等）
- [ ] ファイル名の命名規則

**確認方法**:
```powershell
# JRDBデータファイルを探す
Get-ChildItem "C:\" -Recurse -Include "*.jrdb","*jrdb*.*" -ErrorAction SilentlyContinue

# PC-KEIBAディレクトリ内のCSVファイルを確認
Get-ChildItem "C:\Program Files\*KEIBA*" -Recurse -Include "*.csv","*.txt" -ErrorAction SilentlyContinue
```

##### 2.2 JRDBデータの更新タイミング
- [ ] JRDBデータはいつ更新されるか（レース前日？当日朝？）
- [ ] 手動更新が必要か、自動更新か
- [ ] 更新方法（インターネット経由？ローカルファイル？）

##### 2.3 JRDBデータの取得API
PC-KEIBAがJRDBデータをどのように取得しているか：

- [ ] JRDB公式API利用の有無
- [ ] ログインが必要か
- [ ] APIキーやトークンの有無
- [ ] データ取得のURL、エンドポイント

**参考調査先**:
- JRDB公式サイト: https://www.jrdb.com/
- PC-KEIBAのドキュメント、設定ファイル
- ネットワークトラフィックの監視（WiresharkやFiddler使用）

##### 2.4 JRDBデータのフォーマット
取得したJRDBデータのフォーマットを確認：

- [ ] 固定長テキスト形式か、CSV形式か
- [ ] 文字コード（Shift-JIS、UTF-8等）
- [ ] カラム定義（どの位置にどのデータがあるか）

**確認例（固定長の場合）**:
```python
# JRDBの固定長フォーマット例
# 1-8桁: レースID
# 9-10桁: 馬番
# 11-15桁: 期待単勝率（小数点2桁、例: 12.34）
# ...

with open('jrdb_data.txt', 'r', encoding='shift-jis') as f:
    for line in f:
        race_id = line[0:8]
        umaban = line[8:10]
        kitai_tansho = float(line[10:15]) / 100
        print(f"レース:{race_id}, 馬番:{umaban}, 期待単勝率:{kitai_tansho}")
```

---

### 3. 当日データ取得の自動化方法

#### 調査目的
当日のレースデータを自動的に取得し、AIモデルで予測できる形式に変換する方法を確立する。

#### 具体的な調査内容

##### 3.1 PC-KEIBAのデータ更新タイミング
- [ ] 出馬表データが利用可能になる時刻（通常、レース前日〜当日朝）
- [ ] JRDBデータが利用可能になる時刻
- [ ] データ更新の確認方法

##### 3.2 データ取得スクリプトの実装方針
以下の2つのアプローチを検討：

**アプローチA: PC-KEIBAのデータベース直接アクセス**
- メリット: 高速、安定
- デメリット: PC-KEIBAのバージョンアップで構造変更の可能性

**アプローチB: エクスポート機能の利用**
- PC-KEIBAのエクスポート機能でCSV出力
- メリット: 公式機能なので安全
- デメリット: 手動操作が必要な可能性

##### 3.3 自動化スクリプトの設計
- [ ] Pythonスクリプトで実装
- [ ] 定時実行（タスクスケジューラ利用）
- [ ] エラーハンドリング
- [ ] ログ出力

**実装イメージ**:
```python
# scripts/phase6/fetch_today_data.py

import sqlite3
import pandas as pd
from datetime import datetime

def fetch_today_races(db_path):
    """当日のレースデータを取得"""
    today = datetime.now().strftime('%Y%m%d')
    
    conn = sqlite3.connect(db_path)
    
    # 出馬表データを取得
    query = f"""
    SELECT 
        race_id, kaisai_date, keibajo_code, race_bango,
        umaban, umamei, kishumei, chokyoshimei, banushimei,
        kyori, track_code, baba_jotai,
        ninki, tansho_odds, fukusho_odds,
        -- その他必要なカラム
    FROM shutsuba
    WHERE kaisai_date = '{today}'
    """
    
    df = pd.read_sql_query(query, conn)
    conn.close()
    
    return df

def fetch_jrdb_data(jrdb_file_path, race_ids):
    """JRDBデータを取得"""
    # JRDBファイルを読み込み、必要なレースのデータを抽出
    jrdb_df = pd.read_csv(jrdb_file_path, encoding='shift-jis')
    jrdb_df = jrdb_df[jrdb_df['race_id'].isin(race_ids)]
    
    return jrdb_df

def merge_race_and_jrdb(race_df, jrdb_df):
    """レースデータとJRDBデータを結合"""
    merged = pd.merge(race_df, jrdb_df, on=['race_id', 'umaban'], how='left')
    return merged

if __name__ == '__main__':
    # 当日データ取得
    pc_keiba_db = 'C:/path/to/pckeiba.db'
    jrdb_file = 'C:/path/to/jrdb_today.csv'
    
    race_df = fetch_today_races(pc_keiba_db)
    print(f"当日のレース数: {race_df['race_id'].nunique()}レース")
    
    jrdb_df = fetch_jrdb_data(jrdb_file, race_df['race_id'].unique())
    
    merged_df = merge_race_and_jrdb(race_df, jrdb_df)
    
    # 特徴量変換用にCSV保存
    merged_df.to_csv('data/today/today_race_data.csv', index=False, encoding='utf-8')
    print("当日データ保存完了: data/today/today_race_data.csv")
```

---

### 4. 特徴量変換パイプライン

#### 調査目的
取得した当日データを、訓練済みモデルが受け入れられる特徴量形式に変換する。

#### 具体的な調査内容

##### 4.1 訓練データの特徴量フォーマット確認
現在のモデルが使用している特徴量（139列）を確認：

```python
# 訓練データの特徴量を確認
import pandas as pd

train_df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', nrows=10)
print("特徴量一覧:")
print(train_df.columns.tolist())
print(f"\n特徴量数: {len(train_df.columns)}列")
```

##### 4.2 特徴量生成ロジックの確認
Phase 2-Bで使用した`extract_jra_features_v1.py`の処理内容を確認：

- [ ] どのようにJRDB指数を計算しているか
- [ ] 過去成績の集計方法
- [ ] コース適性の計算方法
- [ ] カテゴリカル変数のエンコーディング方法

##### 4.3 当日データ用の特徴量生成スクリプト作成
訓練時と同じロジックで特徴量を生成：

```python
# scripts/phase6/generate_today_features.py

import pandas as pd
from scripts.phase2b.extract_jra_features_v1 import (
    calculate_jrdb_indices,
    calculate_past_performance,
    calculate_course_suitability,
    # その他の特徴量生成関数
)

def generate_today_features(today_data_path):
    """当日データから特徴量を生成"""
    
    # 当日データ読み込み
    today_df = pd.read_csv(today_data_path)
    
    # 特徴量生成（訓練時と同じロジック）
    today_df = calculate_jrdb_indices(today_df)
    today_df = calculate_past_performance(today_df)
    today_df = calculate_course_suitability(today_df)
    # ...その他の特徴量
    
    # 欠損値処理
    today_df = today_df.fillna(-1)
    
    # カテゴリカル変数のエンコーディング
    for col in today_df.select_dtypes(include=['object']).columns:
        today_df[col] = today_df[col].astype('category').cat.codes
    
    return today_df

if __name__ == '__main__':
    today_features = generate_today_features('data/today/today_race_data.csv')
    today_features.to_csv('data/today/today_features.csv', index=False)
    print(f"特徴量生成完了: {len(today_features.columns)}列")
```

---

### 5. 予測実行システム

#### 調査目的
訓練済みモデルを使って当日データの予測を実行し、結果を出力する。

#### 具体的な調査内容

##### 5.1 予測実行スクリプトの作成
Phase 5のアンサンブル予測ロジックを流用：

```python
# scripts/phase6/predict_today_races.py

import pandas as pd
import lightgbm as lgb
import numpy as np

def load_models():
    """訓練済みモデル読み込み"""
    models = {
        'binary': lgb.Booster(model_file='models/jra_binary_model.txt'),
        'ranking': lgb.Booster(model_file='models/jra_ranking_model.txt'),
        'regression': lgb.Booster(model_file='models/jra_regression_model_optimized.txt')
    }
    return models

def predict_today(today_features_path):
    """当日レースの予測"""
    
    # モデル読み込み
    models = load_models()
    
    # 特徴量読み込み
    today_df = pd.read_csv(today_features_path)
    
    # 各モデルで予測（Phase 5と同じロジック）
    binary_features = models['binary'].feature_name()
    X_binary = today_df[binary_features].to_numpy()
    binary_proba = models['binary'].predict(X_binary)
    
    ranking_features = models['ranking'].feature_name()
    X_ranking = today_df[ranking_features].to_numpy()
    ranking_score = models['ranking'].predict(X_ranking)
    
    regression_features = models['regression'].feature_name()
    X_regression = today_df[regression_features].to_numpy()
    time_pred = models['regression'].predict(X_regression)
    
    # アンサンブルスコア計算
    today_df['binary_proba'] = binary_proba
    today_df['ranking_score'] = ranking_score
    today_df['time_pred'] = time_pred
    
    # レース単位で順位付け
    predictions = []
    for race_id, group in today_df.groupby('race_id'):
        group = group.copy()
        
        # スコア正規化
        group['ranking_norm'] = 1 - (group['ranking_score'] - group['ranking_score'].min()) / (group['ranking_score'].max() - group['ranking_score'].min())
        group['time_norm'] = 1 - (group['time_pred'] - group['time_pred'].min()) / (group['time_pred'].max() - group['time_pred'].min())
        
        # アンサンブルスコア
        group['ensemble_score'] = (
            0.30 * group['binary_proba'] +
            0.40 * group['ranking_norm'] +
            0.30 * group['time_norm']
        )
        
        # 順位付け
        group['predicted_rank'] = group['ensemble_score'].rank(ascending=False, method='first')
        group = group.sort_values('predicted_rank')
        
        predictions.append(group)
    
    result_df = pd.concat(predictions, ignore_index=True)
    
    return result_df

def format_prediction_output(result_df):
    """予測結果を見やすい形式で出力"""
    
    output_lines = []
    output_lines.append("=" * 80)
    output_lines.append("🏇 本日のレース予測結果")
    output_lines.append("=" * 80)
    
    for race_id, group in result_df.groupby('race_id'):
        group = group.sort_values('predicted_rank')
        
        output_lines.append(f"\n【{race_id}】")
        output_lines.append(f"  本命: {group.iloc[0]['umamei']} (馬番{group.iloc[0]['umaban']})")
        output_lines.append(f"  対抗: {group.iloc[1]['umamei']} (馬番{group.iloc[1]['umaban']})")
        output_lines.append(f "  単穴: {group.iloc[2]['umamei']} (馬番{group.iloc[2]['umaban']})")
        output_lines.append(f"  3連単: {group.iloc[0]['umaban']}-{group.iloc[1]['umaban']}-{group.iloc[2]['umaban']}")
    
    return "\n".join(output_lines)

if __name__ == '__main__':
    # 予測実行
    result_df = predict_today('data/today/today_features.csv')
    
    # 結果保存
    result_df.to_csv('results/today_predictions.csv', index=False, encoding='utf-8')
    
    # 見やすい形式で出力
    output_text = format_prediction_output(result_df)
    print(output_text)
    
    # ファイルにも保存
    with open('results/today_predictions.txt', 'w', encoding='utf-8') as f:
        f.write(output_text)
```

##### 5.2 買い目推奨機能
予測結果から推奨する馬券を提示：

- [ ] 複勝: 本命（予測1位）
- [ ] ワイド: 本命-対抗
- [ ] 3連単: 本命-対抗-単穴
- [ ] 馬連: 本命-対抗
- [ ] 3連複: 本命-対抗-単穴

---

## 📋 調査スケジュール

### Week 1: データソース確認
- [ ] Day 1-2: PC-KEIBAデータベース構造の調査
- [ ] Day 3-4: JRDBデータの取得方法調査
- [ ] Day 5: データフォーマット確認

### Week 2: スクリプト実装
- [ ] Day 1-2: 当日データ取得スクリプト作成
- [ ] Day 3-4: 特徴量生成スクリプト作成
- [ ] Day 5: 予測実行スクリプト作成

### Week 3: テスト・運用
- [ ] Day 1-2: テストデータで動作確認
- [ ] Day 3-4: 実際の当日データで予測テスト
- [ ] Day 5: 自動化設定（タスクスケジューラ等）

---

## 📝 調査結果の記録方法

以下のフォーマットで調査結果を記録してください：

### テンプレート

```markdown
## [調査項目名]

### 調査日時
YYYY-MM-DD HH:MM

### 調査者
[名前]

### 調査結果

#### 1. 発見事項
- [発見した情報]
- [発見した情報]

#### 2. ファイルパス・テーブル名等
- データベースパス: `C:\path\to\file.db`
- テーブル名: `shutsuba`, `race_info`, `jrdb_data`

#### 3. サンプルコード
```python
# 実際に動作確認したコード
import sqlite3
conn = sqlite3.connect('...')
# ...
```

#### 4. 課題・問題点
- [発見した課題]
- [解決が必要な問題]

#### 5. 次のアクション
- [ ] [実施すべきタスク]
- [ ] [実施すべきタスク]
```

---

## 🎯 最終ゴール

**Phase 6完了時の成果物**:

1. **当日データ取得スクリプト**
   - `scripts/phase6/fetch_today_data.py`
   - PC-KEIBAとJRDBからデータを自動取得

2. **特徴量生成スクリプト**
   - `scripts/phase6/generate_today_features.py`
   - 訓練時と同じ形式の特徴量を生成

3. **予測実行スクリプト**
   - `scripts/phase6/predict_today_races.py`
   - アンサンブルモデルで予測、結果を出力

4. **自動化設定**
   - Windowsタスクスケジューラで毎日自動実行
   - ログファイルで実行状況を確認可能

5. **ドキュメント**
   - `docs/PHASE6_REALTIME_SYSTEM.md`
   - システムの使用方法、トラブルシューティング

---

## ⚠️ 注意事項

1. **PC-KEIBAのライセンス・利用規約**
   - データベース直接アクセスが許可されているか確認
   - 商用利用の可否を確認

2. **JRDBの利用規約**
   - JRDBデータの再配布禁止
   - APIの利用制限（リクエスト回数等）

3. **データの正確性**
   - 取得したデータが最新か常に確認
   - 出馬取消、騎手変更等の更新に対応

4. **エラーハンドリング**
   - データ取得失敗時の処理
   - 予測実行エラー時の処理
   - ログ出力で問題箇所を特定可能にする

---

**作成日**: 2026-02-22  
**更新日**: -  
**作成者**: JRA競馬AI開発チーム  
**次回レビュー**: 調査完了後
