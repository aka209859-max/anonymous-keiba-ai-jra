#!/usr/bin/env python3
"""
Phase 7-A4: JRDB欠損パターン分析 (CSV版)
CSVファイルから直接読み込んでJRDBデータの欠損パターンを調査
"""

import pandas as pd
import numpy as np
from datetime import datetime
from collections import defaultdict

def load_race_data():
    """レースデータCSVの読み込み"""
    print("=" * 80)
    print("レースデータCSV読み込み中...")
    print("=" * 80)
    
    csv_path = '/home/user/webapp/data/raw/jra_jravan_central_only.csv'
    
    # まず小さいサンプルで列名を確認
    df_sample = pd.read_csv(csv_path, nrows=1000, encoding='utf-8-sig')
    print(f"\n総カラム数: {len(df_sample.columns)}")
    print(f"サンプル行数: {len(df_sample)}")
    
    # 全データ読み込み（メモリ効率化のため必要な列のみ）
    # JRDBカラムを特定（カラム名に 'jrdb' または 'jrd_' が含まれる）
    jrdb_cols = [col for col in df_sample.columns if 'jrdb' in col.lower() or 'jrd_' in col.lower()]
    
    print(f"\nJRDB関連カラム数: {len(jrdb_cols)}")
    if len(jrdb_cols) > 0:
        print(f"JRDBカラム例: {jrdb_cols[:10]}")
    
    # 分析に必要な基本カラムを特定
    base_cols = []
    for col in df_sample.columns:
        if any(keyword in col.lower() for keyword in [
            'race', 'grade', 'keibajo', 'kaisai', 'kyori', 'track', 
            'kyoso', 'shubetsu', 'joken', '種別', '条件'
        ]):
            base_cols.append(col)
    
    print(f"\nレース基本情報カラム数: {len(base_cols)}")
    print(f"基本カラム例: {base_cols[:10]}")
    
    # 全データ読み込み（必要な列のみ）
    use_cols = list(set(base_cols + jrdb_cols))
    print(f"\n読み込む列数: {len(use_cols)}")
    
    df = pd.read_csv(csv_path, usecols=use_cols, encoding='utf-8-sig')
    print(f"\n✅ 全データ読み込み完了: {len(df):,}行")
    
    return df, jrdb_cols, base_cols

def identify_race_type_column(df, base_cols):
    """レース種別を示すカラムを特定"""
    
    # 候補となるカラム名パターン
    patterns = ['grade', 'グレード', 'kyoso', '競走', 'joken', '条件', 'shubetsu', '種別']
    
    candidates = []
    for col in base_cols:
        for pattern in patterns:
            if pattern in col.lower():
                candidates.append(col)
                break
    
    print(f"\nレース種別候補カラム: {candidates}")
    
    # 各カラムのユニーク値を確認
    for col in candidates[:5]:  # 最初の5個まで確認
        unique_vals = df[col].dropna().unique()
        print(f"\n{col}: {len(unique_vals)}種類")
        if len(unique_vals) <= 30:
            print(f"  値: {sorted(unique_vals)[:20]}")
    
    return candidates

def analyze_jrdb_missing_by_grade(df, jrdb_cols):
    """グレード別のJRDB欠損率分析"""
    
    print("\n" + "=" * 80)
    print("1. グレード別 JRDB欠損率分析")
    print("=" * 80)
    
    # grade_code カラムを探す
    grade_col = None
    for col in df.columns:
        if 'grade' in col.lower():
            grade_col = col
            break
    
    if grade_col is None:
        print("⚠️ グレード情報カラムが見つかりませんでした")
        return None
    
    print(f"\n使用カラム: {grade_col}")
    
    # JRDBカラムごとの欠損率を計算
    results = []
    
    for grade in sorted(df[grade_col].dropna().unique()):
        grade_df = df[df[grade_col] == grade]
        total_count = len(grade_df)
        
        jrdb_filled = {}
        for col in jrdb_cols[:10]:  # 最初の10カラムのみ（代表として）
            filled_count = grade_df[col].notna().sum()
            fill_rate = (filled_count / total_count * 100) if total_count > 0 else 0
            jrdb_filled[col] = fill_rate
        
        avg_fill_rate = np.mean(list(jrdb_filled.values())) if jrdb_filled else 0
        
        results.append({
            'grade': grade,
            'total_races': total_count,
            'avg_jrdb_fill_rate': round(avg_fill_rate, 1)
        })
    
    result_df = pd.DataFrame(results)
    result_df = result_df.sort_values('total_races', ascending=False)
    
    print(result_df.to_string(index=False))
    
    return result_df

def analyze_jrdb_missing_by_year(df, jrdb_cols):
    """年度別のJRDB欠損率分析"""
    
    print("\n" + "=" * 80)
    print("2. 年度別 JRDB欠損率分析")
    print("=" * 80)
    
    # 年度カラムを探す
    year_col = None
    for col in df.columns:
        if any(keyword in col.lower() for keyword in ['年', 'nen', 'year', 'kaisai_nen']):
            year_col = col
            break
    
    if year_col is None:
        # 日付カラムから年度を抽出
        date_col = None
        for col in df.columns:
            if any(keyword in col.lower() for keyword in ['date', '日付', 'nengappi', 'kaisai']):
                if df[col].dtype in ['object', 'int64']:
                    date_col = col
                    break
        
        if date_col:
            print(f"\n日付カラムから年度を抽出: {date_col}")
            df['year_extracted'] = df[date_col].astype(str).str[:4]
            year_col = 'year_extracted'
    
    if year_col is None:
        print("⚠️ 年度情報カラムが見つかりませんでした")
        return None
    
    print(f"\n使用カラム: {year_col}")
    
    results = []
    
    for year in sorted(df[year_col].dropna().unique()):
        year_df = df[df[year_col] == year]
        total_count = len(year_df)
        
        jrdb_filled = {}
        for col in jrdb_cols[:10]:
            filled_count = year_df[col].notna().sum()
            fill_rate = (filled_count / total_count * 100) if total_count > 0 else 0
            jrdb_filled[col] = fill_rate
        
        avg_fill_rate = np.mean(list(jrdb_filled.values())) if jrdb_filled else 0
        
        results.append({
            'year': year,
            'total_records': total_count,
            'avg_jrdb_fill_rate': round(avg_fill_rate, 1)
        })
    
    result_df = pd.DataFrame(results)
    result_df = result_df.sort_values('year')
    
    print(result_df.to_string(index=False))
    
    return result_df

def analyze_jrdb_missing_by_venue(df, jrdb_cols):
    """競馬場別のJRDB欠損率分析"""
    
    print("\n" + "=" * 80)
    print("3. 競馬場別 JRDB欠損率分析")
    print("=" * 80)
    
    venue_col = None
    for col in df.columns:
        if 'keibajo' in col.lower() or '競馬場' in col:
            venue_col = col
            break
    
    if venue_col is None:
        print("⚠️ 競馬場情報カラムが見つかりませんでした")
        return None
    
    print(f"\n使用カラム: {venue_col}")
    
    venue_map = {
        '01': '札幌', '02': '函館', '03': '福島', '04': '新潟', '05': '東京',
        '06': '中山', '07': '中京', '08': '京都', '09': '阪神', '10': '小倉',
        1: '札幌', 2: '函館', 3: '福島', 4: '新潟', 5: '東京',
        6: '中山', 7: '中京', 8: '京都', 9: '阪神', 10: '小倉'
    }
    
    results = []
    
    for venue in sorted(df[venue_col].dropna().unique()):
        venue_df = df[df[venue_col] == venue]
        total_count = len(venue_df)
        
        jrdb_filled = {}
        for col in jrdb_cols[:10]:
            filled_count = venue_df[col].notna().sum()
            fill_rate = (filled_count / total_count * 100) if total_count > 0 else 0
            jrdb_filled[col] = fill_rate
        
        avg_fill_rate = np.mean(list(jrdb_filled.values())) if jrdb_filled else 0
        
        venue_name = venue_map.get(venue, str(venue))
        
        results.append({
            'venue_code': venue,
            'venue_name': venue_name,
            'total_records': total_count,
            'avg_jrdb_fill_rate': round(avg_fill_rate, 1)
        })
    
    result_df = pd.DataFrame(results)
    result_df = result_df.sort_values('total_records', ascending=False)
    
    print(result_df.to_string(index=False))
    
    return result_df

def analyze_jrdb_columns_detail(df, jrdb_cols):
    """JRDBカラム個別の充填率分析"""
    
    print("\n" + "=" * 80)
    print("4. JRDBカラム個別の充填率詳細")
    print("=" * 80)
    
    results = []
    
    for col in jrdb_cols:
        total = len(df)
        filled = df[col].notna().sum()
        fill_rate = (filled / total * 100) if total > 0 else 0
        missing = total - filled
        
        results.append({
            'column_name': col,
            'total_rows': total,
            'filled_count': filled,
            'missing_count': missing,
            'fill_rate': round(fill_rate, 1)
        })
    
    result_df = pd.DataFrame(results)
    result_df = result_df.sort_values('fill_rate')
    
    # 充填率ごとにグルーピング
    print("\n【充填率別カラム数】")
    print(f"100%: {len(result_df[result_df['fill_rate'] == 100.0])} カラム")
    print(f"80-99%: {len(result_df[(result_df['fill_rate'] >= 80) & (result_df['fill_rate'] < 100)])} カラム")
    print(f"60-79%: {len(result_df[(result_df['fill_rate'] >= 60) & (result_df['fill_rate'] < 80)])} カラム")
    print(f"40-59%: {len(result_df[(result_df['fill_rate'] >= 40) & (result_df['fill_rate'] < 60)])} カラム")
    print(f"0-39%: {len(result_df[result_df['fill_rate'] < 40])} カラム")
    
    print("\n【充填率が100%未満のカラム（上位20件）】")
    print(result_df[result_df['fill_rate'] < 100].head(20).to_string(index=False))
    
    return result_df

def save_summary_report(results, jrdb_cols_count):
    """分析結果のサマリーレポート保存"""
    
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    # 主要な発見事項を文字列化
    findings = []
    
    if results.get('jrdb_detail') is not None:
        df = results['jrdb_detail']
        avg_fill = df['fill_rate'].mean()
        findings.append(f"- **JRDB全カラム平均充填率**: {avg_fill:.1f}%")
        findings.append(f"- **充填率100%のJRDBカラム**: {len(df[df['fill_rate'] == 100])} / {len(df)} カラム")
        findings.append(f"- **充填率60-79%のカラム**: {len(df[(df['fill_rate'] >= 60) & (df['fill_rate'] < 80)])} カラム")
    
    findings_text = "\n".join(findings) if findings else "（分析結果から自動抽出）"
    
    report = f"""# Phase 7-A4: JRDB欠損パターン分析レポート

**生成日時**: {timestamp}

## 分析目的
JRDBデータの充填率が65-67%である理由を特定し、欠損がどのレース種別・年度・競馬場で発生しているかを明らかにする。

## データソース
- **ファイル**: `/home/user/webapp/data/raw/jra_jravan_central_only.csv`
- **総レコード数**: 483,534行（出走馬ベース）
- **JRDBカラム数**: {jrdb_cols_count}

## 実行した分析
1. グレード別の欠損率分析
2. 年度別の欠損率分析
3. 競馬場別の欠損率分析
4. JRDBカラム個別の充填率分析

## 主要な発見

{findings_text}

### 欠損の主要原因（推測）

#### ① JRDB提供範囲の制限（最も有力）
- JRDBは全レースをカバーしていない可能性
- 特定条件のレース（重賞・メインレース）を優先的に配信
- 新馬戦・障害レースは対象外の可能性

#### ② データ提供時期の差
- JRA-VANは全レース即時配信（100%）
- JRDBは独自計算が必要な指数は遅延配信または一部レースのみ

#### ③ 計算不可能なケース
- 新馬戦では過去成績指数が計算不可
- 血統情報不足で一部指数が欠損
- 調教情報が非公開の馬

## 推奨事項

### 1. 欠損データの扱い
- **オプションA**: 欠損を機械学習で補完（平均値・中央値・KNN補完）
- **オプションB**: 欠損自体を特徴量化（「JRDB対象外レースフラグ」）
- **オプションC**: 充填率100%のカラムのみで先行モデル構築

### 2. レース種別による分析の差別化
- 障害レース・新馬戦でJRDBデータ欠損が確認された場合、別モデル構築を検討
- 重賞レースとその他レースでモデルを分ける戦略も有効

### 3. Phase 7-B への影響
- 334カラム全体でROI分析を実施
- 欠損カラムのROIが低い場合は削除候補
- 欠損カラムでも高ROIの場合は補完戦略を検討

## 次のステップ

### Phase 7-B準備
1. **マージSQL生成**: JRA-VAN 16テーブル + JRDB 5テーブル（334カラム）
2. **CSV出力**: 2016-2025年の全データをCSV化
3. **ROI分析開始**: 単一特徴量での回収率ランキング

### 欠損値補完戦略の決定
- 機械学習による補完（RandomForest/KNN）
- ドメイン知識による補完（例：新馬戦は指数0）
- 欠損フラグを新規特徴量として追加

---

**分析者**: AI Assistant  
**プロジェクト**: anonymous中央競馬AIシステム Phase 7  
**ステータス**: Phase 7-A4 完了（Phase 7-A 全体：100%完了）
"""
    
    output_path = '/home/user/webapp/docs/phase7/PHASE7A4_JRDB_MISSING_ANALYSIS.md'
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"\n\n{'=' * 80}")
    print(f"✅ レポート保存完了: {output_path}")
    print(f"{'=' * 80}")

def main():
    print("\n" + "=" * 80)
    print("Phase 7-A4: JRDB欠損パターン分析 (CSV版)")
    print("=" * 80)
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    try:
        # データ読み込み
        df, jrdb_cols, base_cols = load_race_data()
        
        if len(jrdb_cols) == 0:
            print("\n⚠️ JRDBカラムが見つかりませんでした")
            print("カラム名に 'jrdb' または 'jrd_' が含まれるカラムが存在しません")
            print("\n全カラム一覧:")
            print(df.columns.tolist())
            return
        
        # レース種別カラムの特定
        race_type_candidates = identify_race_type_column(df, base_cols)
        
        # 各分析を実行
        result_grade = analyze_jrdb_missing_by_grade(df, jrdb_cols)
        result_year = analyze_jrdb_missing_by_year(df, jrdb_cols)
        result_venue = analyze_jrdb_missing_by_venue(df, jrdb_cols)
        result_jrdb_detail = analyze_jrdb_columns_detail(df, jrdb_cols)
        
        # サマリーレポート保存
        save_summary_report({
            'grade': result_grade,
            'year': result_year,
            'venue': result_venue,
            'jrdb_detail': result_jrdb_detail
        }, len(jrdb_cols))
        
        print("\n" + "=" * 80)
        print("✅ Phase 7-A4 分析完了")
        print("=" * 80)
        
    except Exception as e:
        print(f"\n❌ エラー発生: {str(e)}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    main()
