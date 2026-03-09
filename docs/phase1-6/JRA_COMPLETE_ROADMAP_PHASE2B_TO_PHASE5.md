# JRA競馬AI予想システム 完全ロードマップ（Phase 2-B → Phase 5）

**作成日**: 2026-02-22  
**対象**: JRA 10競馬場 2016-2025年データ  
**参考**: 地方競馬システム（Phase 3-4実績あり）

---

## 📍 現在地

✅ **Phase 1-D**: 特徴量抽出スクリプト完成（139列）  
✅ **Phase 2-A**: 10競馬場のデータ生成完了（1-10競馬場、小倉は季節分け）

**現在の状態**:
- `data/features/` に以下の11個のCSVファイルが存在
  - `01_2016-2025_features.csv`（札幌: 20,063行）
  - `02_2016-2025_features.csv`（函館: 17,864行）
  - `03_2016-2025_features.csv`（福島: 33,295行）
  - `04_2016-2025_features.csv`（新潟: 46,666行）
  - `05_2016-2025_features.csv`（東京: 77,473行）
  - `06_2016-2025_features.csv`（中山: 73,085行）
  - `07_2016-2025_features.csv`（中京: 52,367行）
  - `08_2016-2025_features.csv`（京都: 55,680行）
  - `09_2016-2025_features.csv`（阪神: 68,290行）
  - `10_summer_2016-2025_features.csv`（小倉夏: 19,375行）
  - `10_winter_2016-2025_features.csv`（小倉冬: 19,375行）

**合計**: 483,533行、139列、約300-400MB

---

## 🗺️ 完全ロードマップ（Phase 2-B → Phase 5）

### 総所要時間: **6-9日（約1週間）**

```
Phase 2-B: データ統合（30分）
    ↓
Phase 3: 二値分類モデル（2-3日）
    ↓
Phase 4-A: ランキング学習モデル（1日）
    ↓
Phase 4-B: 回帰分析モデル（1日）
    ↓
Phase 5: アンサンブル統合（1-2日）
    ↓
✅ 完成！
```

---

## Phase 2-B: データ統合（30分）

### 目的
11個のCSVファイルを1つに統合し、全競馬場のデータでモデルを学習できるようにする。

### なぜ必要？

**統合前**:
- 11個のCSVファイルが別々に存在
- 最大データ: 東京 77,473行
- モデルは競馬場ごとにしか学習できない

**統合後**:
- 1個の統合CSVファイル
- 合計データ: 483,533行
- 全国の競馬場データで汎用モデルを学習可能

### 実行手順

#### ステップ1: 統合スクリプト作成

`scripts/phase2/merge_all_features.py` を作成（Pythonスクリプト）:

```python
import pandas as pd
import glob
from pathlib import Path

def merge_all_features():
    """11個の競馬場CSVを1つに統合"""
    
    # 1. データファイル読み込み
    print("📂 Phase 2-B: データ統合開始...")
    csv_files = sorted(glob.glob('data/features/*_2016-2025_features.csv'))
    
    print(f"✅ 検出ファイル: {len(csv_files)}個")
    for f in csv_files:
        print(f"  - {Path(f).name}")
    
    # 2. 全CSVを読み込み
    dfs = []
    for f in csv_files:
        df = pd.read_csv(f, encoding='utf-8')
        print(f"  {Path(f).name}: {len(df):,}行")
        dfs.append(df)
    
    # 3. 統合
    all_df = pd.concat(dfs, ignore_index=True)
    
    # 4. 基本情報表示
    print(f"\n📊 統合結果:")
    print(f"  総行数: {len(all_df):,}行")
    print(f"  総列数: {len(all_df.columns)}列")
    print(f"  重複行数: {all_df.duplicated().sum()}行")
    
    # 5. 保存
    output_path = 'data/features/all_tracks_2016-2025_features.csv'
    all_df.to_csv(output_path, index=False, encoding='utf-8')
    
    # 6. ファイルサイズ確認
    file_size_mb = Path(output_path).stat().st_size / (1024 * 1024)
    print(f"\n💾 保存完了:")
    print(f"  ファイル: {output_path}")
    print(f"  サイズ: {file_size_mb:.1f} MB")
    
    # 7. 年ごとの分布確認
    if 'kaisai_nen' in all_df.columns:
        print(f"\n📅 年別データ分布:")
        year_counts = all_df['kaisai_nen'].value_counts().sort_index()
        for year, count in year_counts.items():
            print(f"  {year}年: {count:,}行")
    
    # 8. 欠損値チェック
    missing_rate = (all_df.isnull().sum() / len(all_df) * 100).sort_values(ascending=False)
    print(f"\n⚠️ 欠損率トップ5:")
    for col, rate in missing_rate.head(5).items():
        print(f"  {col}: {rate:.2f}%")
    
    print(f"\n✅ Phase 2-B 完了！")
    return all_df

if __name__ == '__main__':
    merge_all_features()
```

#### ステップ2: PowerShellで実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase2\merge_all_features.py
```

#### ステップ3: 結果確認

```powershell
# ファイル確認
Get-ChildItem data\features\all_tracks_2016-2025_features.csv | Format-List Name, Length, LastWriteTime

# 簡易検証
python -c "import pandas as pd; df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv'); print(f'行数: {len(df):,}\n列数: {len(df.columns)}\n重複: {df.duplicated().sum()}行')"
```

### 成功基準

- ✅ `data/features/all_tracks_2016-2025_features.csv` が生成される
- ✅ 行数: **480,000 ～ 485,000**
- ✅ 列数: **139**
- ✅ ファイルサイズ: **300 ～ 400 MB**
- ✅ 重複率: **< 0.01%**

### 所要時間: **約30分**

---

## Phase 3: 二値分類モデル（2-3日）

### 目的
「3着以内に入るか？」を予測するLightGBM二値分類モデルを構築。

### モデル仕様

| 項目 | 値 |
|------|-----|
| **アルゴリズム** | LightGBM（勾配ブースティング） |
| **目的** | 二値分類（binary classification） |
| **目的変数** | 1: 3着以内、0: 4着以下 |
| **評価指標** | AUC、Accuracy、Precision、Recall、F1-Score |
| **特徴量選択** | Boruta（RandomForest ベース） |
| **最適化** | Optuna（ベイズ最適化、100 trials） |

### 実行手順

#### ステップ1: 学習スクリプト作成

`scripts/phase3/train_binary_model.py` を作成:

```python
import pandas as pd
import lightgbm as lgb
import optuna
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score, accuracy_score, precision_score, recall_score, f1_score
from boruta import BorutaPy
from sklearn.ensemble import RandomForestClassifier

def prepare_data():
    """データ読み込みと前処理"""
    print("📂 Phase 3: 二値分類モデル構築開始...")
    
    # 1. データ読み込み
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    print(f"✅ データ読み込み: {len(df):,}行 × {len(df.columns)}列")
    
    # 2. 目的変数作成（3着以内=1, 4着以下=0）
    # カラム名は実際のものに合わせて調整
    df['target'] = (df['chakujun'] <= 3).astype(int)
    print(f"✅ 目的変数作成: 3着以内={df['target'].sum():,}行 ({df['target'].mean()*100:.1f}%)")
    
    # 3. 欠損値処理
    # 数値列: -1で埋める
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    # カテゴリ列: 'unknown'で埋める
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    # カテゴリ列をcategory型に変換（LightGBM高速化）
    for col in categorical_cols:
        df[col] = df[col].astype('category')
    
    print(f"✅ 欠損値処理完了")
    
    # 4. 時系列分割（2016-2023: 訓練、2024: 検証、2025: テスト）
    train_df = df[df['kaisai_nen'] <= 2023].copy()
    valid_df = df[df['kaisai_nen'] == 2024].copy()
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    print(f"✅ データ分割:")
    print(f"  訓練: {len(train_df):,}行（2016-2023）")
    print(f"  検証: {len(valid_df):,}行（2024）")
    print(f"  テスト: {len(test_df):,}行（2025）")
    
    # 5. 特徴量とターゲット分離
    feature_cols = [c for c in df.columns if c not in ['target', 'chakujun', 'kaisai_nen', 'race_id']]
    
    X_train = train_df[feature_cols]
    y_train = train_df['target']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target']
    
    X_test = test_df[feature_cols]
    y_test = test_df['target']
    
    return X_train, y_train, X_valid, y_valid, X_test, y_test, feature_cols

def boruta_feature_selection(X_train, y_train, feature_cols):
    """Borutaによる特徴量選択"""
    print("\n🔍 Phase 3-1: Boruta特徴量選択開始...")
    
    rf = RandomForestClassifier(n_jobs=-1, max_depth=5)
    boruta = BorutaPy(rf, n_estimators='auto', verbose=2, random_state=42)
    
    # category型を一時的にコード化
    X_train_encoded = X_train.copy()
    for col in X_train.columns:
        if X_train[col].dtype.name == 'category':
            X_train_encoded[col] = X_train[col].cat.codes
    
    boruta.fit(X_train_encoded.values, y_train.values)
    
    selected_features = [feature_cols[i] for i, selected in enumerate(boruta.support_) if selected]
    
    print(f"✅ 選択特徴量: {len(selected_features)} / {len(feature_cols)}個")
    print(f"  選択率: {len(selected_features)/len(feature_cols)*100:.1f}%")
    
    # 重要な特徴量トップ10を表示
    importances = boruta.ranking_
    top_features = sorted(zip(feature_cols, importances), key=lambda x: x[1])[:10]
    print(f"\n📊 重要特徴量トップ10:")
    for feat, rank in top_features:
        print(f"  {feat}: ランク {rank}")
    
    return selected_features

def optuna_optimize(X_train, y_train, X_valid, y_valid, selected_features):
    """Optunaによるハイパーパラメータ最適化"""
    print("\n⚙️ Phase 3-2: Optuna最適化開始...")
    
    def objective(trial):
        params = {
            'objective': 'binary',
            'metric': 'auc',
            'verbosity': -1,
            'boosting_type': 'gbdt',
            'num_leaves': trial.suggest_int('num_leaves', 20, 150),
            'learning_rate': trial.suggest_float('learning_rate', 0.01, 0.3),
            'feature_fraction': trial.suggest_float('feature_fraction', 0.5, 1.0),
            'bagging_fraction': trial.suggest_float('bagging_fraction', 0.5, 1.0),
            'bagging_freq': trial.suggest_int('bagging_freq', 1, 7),
            'min_child_samples': trial.suggest_int('min_child_samples', 5, 100),
        }
        
        train_data = lgb.Dataset(X_train[selected_features], y_train)
        valid_data = lgb.Dataset(X_valid[selected_features], y_valid, reference=train_data)
        
        model = lgb.train(
            params,
            train_data,
            num_boost_round=1000,
            valid_sets=[valid_data],
            callbacks=[lgb.early_stopping(stopping_rounds=50), lgb.log_evaluation(0)]
        )
        
        y_pred = model.predict(X_valid[selected_features])
        auc = roc_auc_score(y_valid, y_pred)
        return auc
    
    study = optuna.create_study(direction='maximize')
    study.optimize(objective, n_trials=100, show_progress_bar=True)
    
    print(f"✅ 最適化完了:")
    print(f"  最高AUC: {study.best_value:.4f}")
    print(f"  最適パラメータ:")
    for key, value in study.best_params.items():
        print(f"    {key}: {value}")
    
    return study.best_params

def train_final_model(X_train, y_train, X_valid, y_valid, X_test, y_test, selected_features, best_params):
    """最終モデル学習"""
    print("\n🚀 Phase 3-3: 最終モデル学習...")
    
    params = {
        'objective': 'binary',
        'metric': 'auc',
        'verbosity': -1,
        **best_params
    }
    
    train_data = lgb.Dataset(X_train[selected_features], y_train)
    valid_data = lgb.Dataset(X_valid[selected_features], y_valid, reference=train_data)
    
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[valid_data],
        callbacks=[lgb.early_stopping(stopping_rounds=50)]
    )
    
    # テストデータで評価
    y_pred_proba = model.predict(X_test[selected_features])
    y_pred = (y_pred_proba >= 0.5).astype(int)
    
    auc = roc_auc_score(y_test, y_pred_proba)
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    recall = recall_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)
    
    print(f"\n📊 テストデータ評価結果:")
    print(f"  AUC: {auc:.4f}")
    print(f"  Accuracy: {accuracy:.4f}")
    print(f"  Precision: {precision:.4f}")
    print(f"  Recall: {recall:.4f}")
    print(f"  F1-Score: {f1:.4f}")
    
    # モデル保存
    model.save_model('models/jra_binary_model.txt')
    print(f"\n💾 モデル保存: models/jra_binary_model.txt")
    
    return model

if __name__ == '__main__':
    X_train, y_train, X_valid, y_valid, X_test, y_test, feature_cols = prepare_data()
    selected_features = boruta_feature_selection(X_train, y_train, feature_cols)
    best_params = optuna_optimize(X_train, y_train, X_valid, y_valid, selected_features)
    model = train_final_model(X_train, y_train, X_valid, y_valid, X_test, y_test, selected_features, best_params)
    print("\n✅ Phase 3 完了！")
```

#### ステップ2: 実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase3\train_binary_model.py
```

### 期待結果

- ✅ AUC: **0.70 ～ 0.80**（地方競馬の平均: 0.7739）
- ✅ 訓練データ: 約387,000行
- ✅ 検証データ: 約48,000行
- ✅ テストデータ: 約48,500行
- ✅ モデル保存: `models/jra_binary_model.txt`

### 所要時間: **2-3日**
- Boruta: 3-6時間
- Optuna: 6-12時間（100 trials）
- 最終学習: 30分-1時間

---

## Phase 4-A: ランキング学習モデル（1日）

### 目的
レース内の相対順位を学習し、「A馬はB馬より強いか？」を予測。

### モデル仕様

| 項目 | 値 |
|------|-----|
| **アルゴリズム** | LightGBM Ranker |
| **Objective** | lambdarank |
| **評価指標** | NDCG@1, @3, @5, @10 |
| **特徴** | レース単位でグループ化 |

### 実行手順

#### ステップ1: ランキング学習スクリプト作成

`scripts/phase4/train_ranking_model.py`:

```python
import pandas as pd
import lightgbm as lgb
import optuna
from sklearn.metrics import ndcg_score
from sklearn.model_selection import GroupShuffleSplit

def prepare_ranking_data():
    """ランキング学習用データ準備"""
    print("📂 Phase 4-A: ランキング学習モデル構築開始...")
    
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    
    # race_idが必要
    if 'race_id' not in df.columns:
        # レースIDを生成: YYYYMMDDJJRR (年月日 + 競馬場コード + レース番号)
        df['race_id'] = (
            df['kaisai_nen'].astype(str) +
            df['kaisai_tsukihi'].astype(str).str.zfill(4) +
            df['keibajo'].astype(str).str.zfill(2) +
            df['race_bango'].astype(str).str.zfill(2)
        )
    
    # 目的変数: 着順（1位=1, 2位=2, ...）
    df['target'] = df['chakujun']
    
    # 欠損値処理
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    for col in categorical_cols:
        if col != 'race_id':
            df[col] = df[col].astype('category')
    
    # 時系列分割
    train_df = df[df['kaisai_nen'] <= 2023].copy()
    valid_df = df[df['kaisai_nen'] == 2024].copy()
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    print(f"✅ データ分割:")
    print(f"  訓練: {len(train_df):,}行")
    print(f"  検証: {len(valid_df):,}行")
    print(f"  テスト: {len(test_df):,}行")
    
    # Phase 3で選択された特徴量を読み込み（またはBorutaで再選択）
    # ここではシンプルに全特徴量を使用
    feature_cols = [c for c in df.columns if c not in ['target', 'chakujun', 'kaisai_nen', 'race_id']]
    
    return train_df, valid_df, test_df, feature_cols

def train_ranking_model(train_df, valid_df, test_df, feature_cols):
    """ランキングモデル学習"""
    print("\n🚀 Phase 4-A: ランキングモデル学習...")
    
    # グループ情報（race_idごとの馬数）
    train_groups = train_df.groupby('race_id').size().values
    valid_groups = valid_df.groupby('race_id').size().values
    test_groups = test_df.groupby('race_id').size().values
    
    # データセット作成
    X_train = train_df[feature_cols]
    y_train = train_df['target']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target']
    
    X_test = test_df[feature_cols]
    y_test = test_df['target']
    
    params = {
        'objective': 'lambdarank',
        'metric': 'ndcg',
        'ndcg_eval_at': [1, 3, 5, 10],
        'boosting_type': 'gbdt',
        'num_leaves': 50,
        'learning_rate': 0.05,
        'verbosity': -1
    }
    
    train_data = lgb.Dataset(X_train, y_train, group=train_groups)
    valid_data = lgb.Dataset(X_valid, y_valid, group=valid_groups, reference=train_data)
    
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[valid_data],
        callbacks=[lgb.early_stopping(stopping_rounds=50)]
    )
    
    # テストデータで評価
    y_pred = model.predict(X_test)
    
    # NDCG計算（レースごと）
    ndcg_scores = []
    for race_id in test_df['race_id'].unique():
        mask = test_df['race_id'] == race_id
        true_rank = y_test[mask].values
        pred_score = y_pred[mask]
        
        # NDCGは昇順スコアを期待するため反転
        ndcg = ndcg_score([true_rank], [-pred_score], k=3)
        ndcg_scores.append(ndcg)
    
    avg_ndcg = sum(ndcg_scores) / len(ndcg_scores)
    
    print(f"\n📊 テストデータ評価結果:")
    print(f"  平均NDCG@3: {avg_ndcg:.4f}")
    
    # モデル保存
    model.save_model('models/jra_ranking_model.txt')
    print(f"\n💾 モデル保存: models/jra_ranking_model.txt")
    
    return model

if __name__ == '__main__':
    train_df, valid_df, test_df, feature_cols = prepare_ranking_data()
    model = train_ranking_model(train_df, valid_df, test_df, feature_cols)
    print("\n✅ Phase 4-A 完了！")
```

#### ステップ2: 実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase4\train_ranking_model.py
```

### 成功基準
- ✅ NDCG@3: **> 0.50**
- ✅ モデル保存: `models/jra_ranking_model.txt`

### 所要時間: **約1日**

---

## Phase 4-B: 回帰分析モデル（1日）

### 目的
走破タイムを予測し、能力値を数値化。

### モデル仕様

| 項目 | 値 |
|------|-----|
| **アルゴリズム** | LightGBM Regressor |
| **Objective** | regression |
| **評価指標** | RMSE、MAE、R² |
| **目的変数** | 走破タイム（秒） |

### 実行手順

#### ステップ1: 回帰モデルスクリプト作成

`scripts/phase4/train_regression_model.py`:

```python
import pandas as pd
import lightgbm as lgb
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

def prepare_regression_data():
    """回帰分析用データ準備"""
    print("📂 Phase 4-B: 回帰分析モデル構築開始...")
    
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    
    # 目的変数: 走破タイム（秒）
    # カラム名は実際のものに合わせて調整（例: 'time', 'race_time'）
    df['target'] = df['time']  # 走破タイム列
    
    # タイム0や異常値を除外
    df = df[(df['target'] > 0) & (df['target'] < 300)].copy()
    
    # 欠損値処理
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numeric_cols] = df[numeric_cols].fillna(-1)
    
    categorical_cols = df.select_dtypes(include=['object']).columns
    df[categorical_cols] = df[categorical_cols].fillna('unknown')
    
    for col in categorical_cols:
        df[col] = df[col].astype('category')
    
    # 時系列分割
    train_df = df[df['kaisai_nen'] <= 2023].copy()
    valid_df = df[df['kaisai_nen'] == 2024].copy()
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    print(f"✅ データ分割:")
    print(f"  訓練: {len(train_df):,}行")
    print(f"  検証: {len(valid_df):,}行")
    print(f"  テスト: {len(test_df):,}行")
    
    feature_cols = [c for c in df.columns if c not in ['target', 'time', 'chakujun', 'kaisai_nen', 'race_id']]
    
    return train_df, valid_df, test_df, feature_cols

def train_regression_model(train_df, valid_df, test_df, feature_cols):
    """回帰モデル学習"""
    print("\n🚀 Phase 4-B: 回帰モデル学習...")
    
    X_train = train_df[feature_cols]
    y_train = train_df['target']
    
    X_valid = valid_df[feature_cols]
    y_valid = valid_df['target']
    
    X_test = test_df[feature_cols]
    y_test = test_df['target']
    
    params = {
        'objective': 'regression',
        'metric': 'rmse',
        'boosting_type': 'gbdt',
        'num_leaves': 50,
        'learning_rate': 0.05,
        'verbosity': -1
    }
    
    train_data = lgb.Dataset(X_train, y_train)
    valid_data = lgb.Dataset(X_valid, y_valid, reference=train_data)
    
    model = lgb.train(
        params,
        train_data,
        num_boost_round=1000,
        valid_sets=[valid_data],
        callbacks=[lgb.early_stopping(stopping_rounds=50)]
    )
    
    # テストデータで評価
    y_pred = model.predict(X_test)
    
    rmse = mean_squared_error(y_test, y_pred, squared=False)
    mae = mean_absolute_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    relative_error = (mae / y_test.mean()) * 100
    
    print(f"\n📊 テストデータ評価結果:")
    print(f"  RMSE: {rmse:.2f}秒")
    print(f"  MAE: {mae:.2f}秒")
    print(f"  R²: {r2:.4f}")
    print(f"  相対誤差: {relative_error:.2f}%")
    
    # モデル保存
    model.save_model('models/jra_regression_model.txt')
    print(f"\n💾 モデル保存: models/jra_regression_model.txt")
    
    return model

if __name__ == '__main__':
    train_df, valid_df, test_df, feature_cols = prepare_regression_data()
    model = train_regression_model(train_df, valid_df, test_df, feature_cols)
    print("\n✅ Phase 4-B 完了！")
```

#### ステップ2: 実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase4\train_regression_model.py
```

### 成功基準
- ✅ RMSE: **< 5.0秒**
- ✅ R²: **> 0.70**
- ✅ モデル保存: `models/jra_regression_model.txt`

### 所要時間: **約1日**

---

## Phase 5: アンサンブル統合（1-2日）

### 目的
3つのモデル（Binary、Ranker、Regressor）の予測を統合し、最終的な買い目候補を決定。

### アンサンブル戦略

| モデル | 重み | 役割 |
|--------|------|------|
| **二値分類** | 0.3 | 3着以内確率 |
| **ランキング** | 0.4 | 相対的な強さ（重視） |
| **回帰** | 0.2 | 走破タイム予測 |

### 実行手順

#### ステップ1: アンサンブルスクリプト作成

`scripts/phase5/ensemble_prediction.py`:

```python
import pandas as pd
import lightgbm as lgb
import numpy as np

def load_models():
    """3つのモデルを読み込み"""
    print("📂 Phase 5: アンサンブル統合開始...")
    
    binary_model = lgb.Booster(model_file='models/jra_binary_model.txt')
    ranking_model = lgb.Booster(model_file='models/jra_ranking_model.txt')
    regression_model = lgb.Booster(model_file='models/jra_regression_model.txt')
    
    print("✅ モデル読み込み完了")
    return binary_model, ranking_model, regression_model

def predict_ensemble(df, binary_model, ranking_model, regression_model, feature_cols):
    """アンサンブル予測"""
    print("\n🔮 アンサンブル予測実行...")
    
    X = df[feature_cols]
    
    # 1. 各モデルで予測
    binary_proba = binary_model.predict(X)  # 0-1の確率
    ranking_score = ranking_model.predict(X)  # スコア（大きいほど上位）
    regression_time = regression_model.predict(X)  # 走破タイム（小さいほど速い）
    
    # 2. 正規化
    # 二値分類: 既に0-1なのでそのまま
    binary_norm = binary_proba
    
    # ランキング: Min-Max正規化
    ranking_norm = (ranking_score - ranking_score.min()) / (ranking_score.max() - ranking_score.min())
    
    # 回帰: 小さい方が良いので反転してMin-Max正規化
    regression_norm = 1 - ((regression_time - regression_time.min()) / (regression_time.max() - regression_time.min()))
    
    # 3. 加重平均で総合スコア計算
    ensemble_score = (
        0.3 * binary_norm +
        0.4 * ranking_norm +
        0.2 * regression_norm
    )
    
    # 4. 推奨度を割り当て
    recommendations = []
    for i in range(len(df)):
        if binary_proba[i] < 0.4:
            rec = '消去'
        elif ensemble_score[i] >= 0.7:
            rec = '◎ 本命'
        elif ensemble_score[i] >= 0.6:
            rec = '○ 対抗'
        elif ensemble_score[i] >= 0.5:
            rec = '▲ 単穴'
        elif ensemble_score[i] >= 0.4:
            rec = '△ 連下'
        else:
            rec = '× 評価低'
        recommendations.append(rec)
    
    # 5. 結果をDataFrameにまとめ
    result_df = df.copy()
    result_df['binary_proba'] = binary_proba
    result_df['ranking_score'] = ranking_score
    result_df['regression_time'] = regression_time
    result_df['binary_norm'] = binary_norm
    result_df['ranking_norm'] = ranking_norm
    result_df['regression_norm'] = regression_norm
    result_df['ensemble_score'] = ensemble_score
    result_df['recommendation'] = recommendations
    
    return result_df

def evaluate_ensemble(result_df):
    """アンサンブル評価"""
    print("\n📊 アンサンブル評価結果:")
    
    # 推奨度ごとの的中率
    for rec in ['◎ 本命', '○ 対抗', '▲ 単穴']:
        subset = result_df[result_df['recommendation'] == rec]
        if len(subset) > 0:
            hit_rate = (subset['chakujun'] <= 3).mean()
            print(f"  {rec}: {len(subset)}頭, 的中率 {hit_rate*100:.1f}%")
    
    # 総合スコアトップ3の的中率
    top3_per_race = result_df.groupby('race_id').apply(
        lambda x: x.nlargest(3, 'ensemble_score')
    ).reset_index(drop=True)
    
    top3_hit_rate = (top3_per_race['chakujun'] <= 3).mean()
    print(f"\n  上位3頭的中率: {top3_hit_rate*100:.1f}%")

if __name__ == '__main__':
    # テストデータで評価
    df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', encoding='utf-8')
    test_df = df[df['kaisai_nen'] == 2025].copy()
    
    binary_model, ranking_model, regression_model = load_models()
    
    feature_cols = [c for c in df.columns if c not in ['target', 'chakujun', 'kaisai_nen', 'race_id', 'time']]
    
    result_df = predict_ensemble(test_df, binary_model, ranking_model, regression_model, feature_cols)
    
    # 結果保存
    result_df.to_csv('results/ensemble_predictions_2025.csv', index=False, encoding='utf-8-sig')
    print(f"\n💾 予測結果保存: results/ensemble_predictions_2025.csv")
    
    evaluate_ensemble(result_df)
    
    print("\n✅ Phase 5 完了！")
```

#### ステップ2: 実行

```powershell
cd E:\anonymous-keiba-ai-JRA
python scripts\phase5\ensemble_prediction.py
```

### 成功基準
- ✅ 本命的中率: **> 40%**
- ✅ 対抗的中率: **> 30%**
- ✅ 上位3頭的中率: **> 35%**

### 所要時間: **1-2日**

---

## 🎯 完成後の期待結果

### 生成されるファイル

```
models/
├── jra_binary_model.txt        # 二値分類モデル
├── jra_ranking_model.txt       # ランキングモデル
└── jra_regression_model.txt    # 回帰モデル

data/features/
└── all_tracks_2016-2025_features.csv  # 統合データセット

results/
└── ensemble_predictions_2025.csv      # 2025年の予測結果
```

### 性能目標

| 指標 | 目標値 |
|------|--------|
| **二値分類AUC** | 0.70-0.80 |
| **ランキングNDCG@3** | > 0.50 |
| **回帰R²** | > 0.70 |
| **本命的中率** | > 40% |
| **対抗的中率** | > 30% |
| **上位3頭的中率** | > 35% |

---

## 📊 進捗チェックリスト

### Phase 2-B: データ統合
- [ ] `merge_all_features.py` スクリプト作成
- [ ] スクリプト実行（約30分）
- [ ] `all_tracks_2016-2025_features.csv` 生成確認
- [ ] 行数・列数・重複率確認

### Phase 3: 二値分類モデル
- [ ] `train_binary_model.py` スクリプト作成
- [ ] Boruta特徴量選択実行（3-6時間）
- [ ] Optuna最適化実行（6-12時間）
- [ ] モデル学習・評価
- [ ] AUC 0.70以上達成確認

### Phase 4-A: ランキング学習
- [ ] `train_ranking_model.py` スクリプト作成
- [ ] race_id生成確認
- [ ] モデル学習・評価
- [ ] NDCG@3 > 0.50確認

### Phase 4-B: 回帰分析
- [ ] `train_regression_model.py` スクリプト作成
- [ ] 走破タイムデータ確認
- [ ] モデル学習・評価
- [ ] RMSE < 5.0秒、R² > 0.70確認

### Phase 5: アンサンブル統合
- [ ] `ensemble_prediction.py` スクリプト作成
- [ ] 3モデルの予測統合
- [ ] 2025年データで評価
- [ ] 的中率目標達成確認

---

## 🔧 トラブルシューティング

### Q1: Phase 2-B でファイルが11個見つからない
**原因**: CSVファイル名が想定と異なる  
**対処**: `glob.glob()` のパターンを実際のファイル名に合わせて修正

### Q2: Phase 3 でメモリエラー
**原因**: データサイズ（480k行×139列）が大きい  
**対処**: 
- 不要なアプリを閉じる
- チャンクサイズを減らす
- 64bit Pythonを使用

### Q3: Optuna最適化が遅い
**原因**: 100 trialsが多い  
**対処**: `n_trials=50` に減らす（精度は若干低下）

### Q4: race_id がない
**原因**: データに含まれていない  
**対処**: スクリプト内で生成
```python
df['race_id'] = (
    df['kaisai_nen'].astype(str) +
    df['kaisai_tsukihi'].astype(str).str.zfill(4) +
    df['keibajo'].astype(str).str.zfill(2) +
    df['race_bango'].astype(str).str.zfill(2)
)
```

### Q5: 走破タイム列がない
**原因**: カラム名が異なる  
**対処**: `df.columns` で確認し、適切な列名に修正

---

## 📚 参考: 地方競馬システムとの比較

| 項目 | 地方競馬 | JRA |
|------|---------|-----|
| **競馬場数** | 14競馬場 | 10競馬場 |
| **データ期間** | 2020-2025 | 2016-2025 |
| **総データ数** | 725,519行 | 483,533行 |
| **Phase 2-B** | なし（個別学習） | あり（統合必須） |
| **Phase 3** | 二値分類 | 二値分類 |
| **Phase 4** | Ranker + Regressor | Ranker + Regressor |
| **Phase 5** | アンサンブル | アンサンブル |
| **平均AUC** | 0.7739 | 0.70-0.80（目標） |

---

## ✅ 最終確認事項

### Phase 2-B 完了後
1. ファイル `all_tracks_2016-2025_features.csv` が生成されたか？
2. 行数は 480,000 ～ 485,000 行か？
3. 列数は 139 列か？
4. 重複率は < 0.01% か？

### Phase 3 完了後
1. モデル `jra_binary_model.txt` が生成されたか？
2. AUC は 0.70 以上か？
3. テストデータ（2025年）で評価したか？

### Phase 4-A 完了後
1. モデル `jra_ranking_model.txt` が生成されたか？
2. NDCG@3 は > 0.50 か？

### Phase 4-B 完了後
1. モデル `jra_regression_model.txt` が生成されたか？
2. RMSE は < 5.0秒 か？
3. R² は > 0.70 か？

### Phase 5 完了後
1. 予測結果 `ensemble_predictions_2025.csv` が生成されたか？
2. 本命的中率は > 40% か？
3. 対抗的中率は > 30% か？
4. 上位3頭的中率は > 35% か？

---

## 🚀 次のステップ（Phase 5 完了後）

1. **Phase 6: 実戦投入**
   - 当日レースでの予測実行
   - 買い目の自動生成

2. **Phase 7: 精度向上**
   - 特徴量エンジニアリング追加
   - ハイパーパラメータ再調整

3. **Phase 8: システム化**
   - Web UIの構築
   - 自動予測システム
   - リアルタイム予測

---

**作成日**: 2026-02-22  
**作成者**: Anonymous Keiba AI Development Team  
**参考プロジェクト**: 地方競馬AI予想システム（Phase 3-4 完了実績）

---

## 📞 サポート

各Phase完了後、以下を報告してください：
1. 実行時間
2. 生成ファイル名とサイズ
3. 評価指標（AUC、NDCG、RMSE、的中率など）
4. エラーがあれば詳細

次のPhaseの詳細手順を提供します。

**✅ ロードマップ作成完了！**
