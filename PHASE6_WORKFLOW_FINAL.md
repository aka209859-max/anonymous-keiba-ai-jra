# Phase 6: リアルタイム予想ワークフロー【確定版】

## 📅 作成日時
2026-02-22（ディープサーチ完了）

---

## 🎯 **Phase 6の全体像**

```
【完了】Phase 5: アンサンブルモデル（本命top3 84.43%, 対抗top3 73.41%）
              ↓
【実装】Phase 6: 当日の朝 → レース予想 → 投票判断
```

---

## ✅ **判明した重要情報**

### 1️⃣ **JRA-VAN Data 自動更新（完全判明）**

| 項目 | 詳細 |
|------|------|
| **自動更新機能** | ✅ **あり**（通常データ + 速報系データ） |
| **設定場所** | メニュー > 設定 > データ登録 |
| **デフォルト更新時刻** | **21:00**（前日夜に翌日出馬表を取得） |
| **リアルタイム更新** | ✅ **有効**（30秒間隔でオッズ・馬体重更新） |
| **手動更新** | **F5キー** または メニュー > ツール > データ登録 |
| **PostgreSQLテーブル** | `jra_shutsuba`（出馬表）、`jvd_o1`（オッズ） |

**データ取得タイミング**:
- **前日21:00以降**: 確定した枠順・出馬表 → `jra_shutsuba`に投入
- **当日朝**: 騎手変更・出走取消・馬場状態
- **レース直前**: 馬体重・オッズ（30秒ごと）

**確認方法**（PostgreSQL）:
```sql
SELECT COUNT(*) FROM jra_shutsuba WHERE kaisai_tsukihi='20260222';
-- 件数 = レース数 × 出走馬数 なら正常
```

---

### 2️⃣ **JRDB データ取り込み（完全判明）**

| 項目 | 詳細 |
|------|------|
| **取り込み方法** | **フォルダ監視による自動取り込み** |
| **設定場所** | `AppConfig.xml` > `<DirectoryGaibuShisu>` |
| **保存場所** | 設定したディレクトリ（例: `C:\PC-KEIBA\JRDB\`） |
| **対応ファイル** | BAC, SED, KYI, CYB（固定長テキスト） |
| **PostgreSQLテーブル** | `jrdb_bac`, `jrdb_sed`, `jrdb_kyi`, `jrdb_cyb` |
| **取り込みタイミング** | ファイル配置後、数秒〜数分で自動検知 |

**重要ポイント**:
1. **`DirectoryGaibuShisu`にパスを設定**（例: `C:\PC-KEIBA\JRDB\`）
2. JRDBファイル（`BAC20260222.txt`等）をそのフォルダに配置
3. PC-KEIBAが自動検知 → PostgreSQLの`jrdb_bac`等に取り込み
4. 処理後、ファイルはバックアップまたは削除

**確認方法**（PostgreSQL）:
```sql
SELECT COUNT(*) FROM jrdb_bac WHERE kaisai_tsukihi='20260222';
-- 件数 > 0 なら取り込み成功
```

---

## 🚀 **Phase 6 ワークフロー（3パターン）**

### 🟢 **パターンA: 半自動化（推奨）**

```
前日 21:00  PC-KEIBA自動更新（JRA-VAN）
           ↓ jra_shutsubaに翌日出馬表が投入
           
当日 06:00  【手動】JRDB会員サイトからBAC, SED, KYIをDL
           ↓
           【手動】C:\PC-KEIBA\JRDB\ にファイル配置
           ↓
           【自動】PC-KEIBAが数分以内に自動検知・取り込み
           ↓ jrdb_bac等に投入完了
           
当日 07:00  【自動】Windowsタスクスケジューラで実行
           python scripts/phase6/run_daily_prediction.py
           ↓
           1. PostgreSQLから当日データ取得
           2. Phase 2-B特徴量生成（139列）
           3. Phase 5アンサンブル予測
           4. results/predictions_20260222.csv 出力
           
当日 07:30  【手動】予想結果確認 → 投票判断
```

**自動化レベル**: 70%（データ取得のみ手動、それ以外自動）

---

### 🟡 **パターンB: 完全手動（シンプル）**

```
当日 朝    【手動】PC-KEIBAで「F5」キー（データ更新）
           【手動】JRDBファイルDL & 配置
           【手動】PowerShellで実行:
                   python scripts/phase6/run_daily_prediction.py
           【手動】予想結果確認
```

**自動化レベル**: 0%（すべて手動、確実・シンプル）

---

### 🔵 **パターンC: 完全自動化（理想・要設定）**

```
前日 21:00  PC-KEIBA自動更新（JRA-VAN）
           
当日 06:00  【自動】Pythonスクリプトで以下を実行:
           1. JRDBファイル自動DL（Selenium/Playwright）
              ※ログイン・ファイルDL・配置を自動化
           2. PC-KEIBAが自動検知・取り込み
           
当日 07:00  【自動】予測スクリプト実行（タスクスケジューラ）
           
当日 07:30  【自動】予想結果をメール/LINEで通知
```

**自動化レベル**: 100%（すべて自動、JRDBログイン自動化必要）

---

## 📂 **Phase 6 実装スクリプト（3つ）**

### 1️⃣ **データ取得スクリプト**
**ファイル**: `scripts/phase6/fetch_today_data.py`

```python
import psycopg2
import pandas as pd
from datetime import datetime

def fetch_today_data():
    """PostgreSQLから当日の出馬表+JRDBデータを取得"""
    conn = psycopg2.connect(
        host='127.0.0.1', port=5432, database='pckeiba',
        user='postgres', password='postgres123'
    )
    
    today = datetime.now().strftime('%Y%m%d')
    
    # JRA-VAN出馬表 + JRDBデータを結合
    query = f"""
        SELECT 
            a.kaisai_nen, a.kaisai_tsukihi, a.keiba_jo_code, 
            a.race_ban, a.uma_ban, a.kishumei_ryakusho,
            b.idm_shisu, b.jockey_shisu, b.pace_shisu, ...
        FROM jra_shutsuba a
        LEFT JOIN jrdb_bac b 
            ON a.kaisai_nen = b.kaisai_nen 
            AND a.kaisai_tsukihi = b.kaisai_tsukihi
            AND a.keiba_jo_code = b.keiba_jo_code
            AND a.race_ban = b.race_ban
            AND a.uma_ban = b.uma_ban
        WHERE a.kaisai_tsukihi = '{today}'
        ORDER BY a.race_ban, a.uma_ban;
    """
    
    df = pd.read_sql(query, conn)
    conn.close()
    
    # CSVに保存
    df.to_csv(f'data/today_raw/today_data_{today}.csv', index=False)
    print(f"✅ 当日データ取得完了: {len(df)}件")
    return df
```

---

### 2️⃣ **特徴量生成スクリプト**
**ファイル**: `scripts/phase6/generate_today_features.py`

```python
import pandas as pd
from datetime import datetime

def generate_today_features():
    """Phase 2-Bと同じロジックで139列の特徴量を生成"""
    today = datetime.now().strftime('%Y%m%d')
    
    # 当日データ読み込み
    df = pd.read_csv(f'data/today_raw/today_data_{today}.csv')
    
    # Phase 2-Bの特徴量生成ロジックを適用
    # （省略: feature_engineering.pyのロジックを再利用）
    
    # 139列の特徴量を生成
    df_features = create_features(df)
    
    # CSVに保存
    df_features.to_csv(f'data/today_features/features_{today}.csv', index=False)
    print(f"✅ 特徴量生成完了: {df_features.shape}")
    return df_features
```

---

### 3️⃣ **予測実行スクリプト（統合版）**
**ファイル**: `scripts/phase6/run_daily_prediction.py`

```python
import pandas as pd
import lightgbm as lgb
from datetime import datetime

def run_daily_prediction():
    """当日予想の完全自動実行"""
    today = datetime.now().strftime('%Y%m%d')
    print(f"🔮 {today} の予想を開始します...")
    
    # 1. データ取得
    from fetch_today_data import fetch_today_data
    fetch_today_data()
    
    # 2. 特徴量生成
    from generate_today_features import generate_today_features
    df_features = generate_today_features()
    
    # 3. モデル読み込み
    binary_model = lgb.Booster(model_file='models/jra_binary_model.txt')
    ranking_model = lgb.Booster(model_file='models/jra_ranking_model.txt')
    regression_model = lgb.Booster(model_file='models/jra_regression_model_optimized.txt')
    
    # 4. 予測実行（Phase 5アンサンブル）
    X = df_features[feature_cols].to_numpy()
    
    binary_score = binary_model.predict(X)
    ranking_score = ranking_model.predict(X)
    time_score = 1 / (regression_model.predict(X) + 1)  # タイムを正規化
    
    ensemble_score = 0.3 * binary_score + 0.4 * ranking_score + 0.3 * time_score
    
    # 5. レースごとにランキング
    df_features['ensemble_score'] = ensemble_score
    df_features['predicted_rank'] = df_features.groupby('race_id')['ensemble_score'].rank(ascending=False)
    
    # 6. 結果出力
    output_file = f'results/predictions_{today}.csv'
    df_features[['race_id', 'uma_ban', 'ensemble_score', 'predicted_rank']].to_csv(output_file, index=False)
    
    print(f"✅ 予想完了: {output_file}")
    print(f"   レース数: {df_features['race_id'].nunique()}")
    print(f"   出走馬数: {len(df_features)}")

if __name__ == "__main__":
    run_daily_prediction()
```

---

## ⚙️ **Windowsタスクスケジューラ設定**

### 自動実行の設定方法

```powershell
# PowerShellで実行（管理者権限）
$action = New-ScheduledTaskAction `
    -Execute "C:\Python310\python.exe" `
    -Argument "E:\anonymous-keiba-ai-JRA\scripts\phase6\run_daily_prediction.py" `
    -WorkingDirectory "E:\anonymous-keiba-ai-JRA"

$trigger = New-ScheduledTaskTrigger -Daily -At 07:00AM

Register-ScheduledTask `
    -TaskName "JRA_AI_Daily_Prediction" `
    -Action $action `
    -Trigger $trigger `
    -Description "Phase 6: 当日レース予想自動実行"
```

---

## 📊 **AppConfig.xml 重要設定**

### 必須設定項目

```xml
<!-- JRA-VAN自動更新時刻（前日の出馬表取得） -->
<JidokoshinJikokuDateTimePicker>21:00</JidokoshinJikokuDateTimePicker>

<!-- リアルタイム更新間隔（秒） -->
<RealtimeInterval>30</RealtimeInterval>

<!-- JRDB外部指数ディレクトリ（要設定） -->
<DirectoryGaibuShisu>C:\PC-KEIBA\JRDB\</DirectoryGaibuShisu>

<!-- 最終更新タイムスタンプ（自動更新成否の確認用） -->
<LastFileTimestampJvd>20260221115924</LastFileTimestampJvd>
```

---

## 🎯 **Phase 6 成功基準**

| 項目 | 基準 |
|------|------|
| **データ取得** | 当日の全レースデータが`jra_shutsuba`に存在 |
| **JRDB取り込み** | `jrdb_bac`テーブルに当日データ存在 |
| **特徴量生成** | 139列すべて生成、欠損なし |
| **予測実行** | Phase 5モデルでエラーなく予測完了 |
| **結果出力** | `predictions_YYYYMMDD.csv`出力 |
| **予想精度** | Phase 5と同等（本命top3 > 80%）を維持 |

---

## 📝 **次のアクション（実装手順）**

### ステップ1: 環境確認（今すぐ実行）
```powershell
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1

# PostgreSQL接続確認
python -c "import psycopg2; conn=psycopg2.connect(host='127.0.0.1',port=5432,database='pckeiba',user='postgres',password='postgres123'); print('✅ PostgreSQL接続成功'); conn.close()"

# テーブル確認
python scripts/phase6/inspect_database.py
```

### ステップ2: JRDBディレクトリ設定
```powershell
# JRDBフォルダ作成
New-Item -ItemType Directory -Path "C:\PC-KEIBA\JRDB\" -Force

# AppConfig.xmlに設定を追加（手動編集）
# <DirectoryGaibuShisu>C:\PC-KEIBA\JRDB\</DirectoryGaibuShisu>
```

### ステップ3: スクリプト実装
```powershell
# 最新コードをGitHubから取得
git pull origin genspark_ai_developer

# Phase 6スクリプトが追加されたら実行
python scripts/phase6/fetch_today_data.py
python scripts/phase6/generate_today_features.py
python scripts/phase6/run_daily_prediction.py
```

---

## 🎉 **まとめ**

### ✅ **判明したこと**
1. JRA-VANデータは**21:00に自動更新**（前日の出馬表）
2. JRDBデータは**フォルダ監視で自動取り込み**（`DirectoryGaibuShisu`設定必要）
3. PostgreSQL内の`jra_shutsuba` + `jrdb_bac`から当日データ取得可能

### 🚀 **実装するもの**
1. `fetch_today_data.py`: PostgreSQLからデータ取得
2. `generate_today_features.py`: 特徴量生成（139列）
3. `run_daily_prediction.py`: Phase 5アンサンブル予測

### 🎯 **運用フロー（推奨: パターンA）**
```
前日21:00  PC-KEIBA自動更新
当日06:00  JRDB手動DL & 配置
当日07:00  Python自動予測（タスクスケジューラ）
当日07:30  予想結果確認 → 投票判断
```

**Phase 6完成まで あと一歩！**
