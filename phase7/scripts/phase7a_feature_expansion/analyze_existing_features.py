#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 7-A 既存特徴量分析スクリプト
既存の139カラムがどのテーブル・カラムから抽出されたかを特定
"""

import pandas as pd
import os
import sys
from datetime import datetime

def load_existing_features():
    """既存の139カラム特徴量を読み込み"""
    data_path = os.path.join('..', '..', '..', 'data', 'raw', 'jravan_jrdb_merged_fixed.csv')
    
    print(f"既存データ読み込み中: {data_path}")
    df = pd.read_csv(data_path, nrows=1)  # 1行だけ読み込み（カラム名取得用）
    
    print(f"✅ カラム数: {len(df.columns)}")
    return df.columns.tolist()

def categorize_features(columns):
    """カラムをカテゴリ別に分類"""
    
    categories = {
        'JRA-VAN_レース基本情報': [],
        'JRA-VAN_馬基本情報': [],
        'JRA-VAN_騎手・調教師': [],
        'JRA-VAN_過去成績': [],
        'JRA-VAN_馬場・天候': [],
        'JRA-VAN_オッズ': [],
        'JRDB_基本情報': [],
        'JRDB_過去走': [],
        'JRDB_調教': [],
        'JRDB_予想': [],
        '派生特徴量': [],
        '不明': []
    }
    
    for col in columns:
        col_lower = col.lower()
        
        # レース基本情報
        if any(kw in col_lower for kw in ['race_', 'レース', 'kyori', '距離', 'track', 'baba', '馬場']):
            categories['JRA-VAN_レース基本情報'].append(col)
        
        # 馬基本情報
        elif any(kw in col_lower for kw in ['horse_', '馬名', 'bamei', 'sex', '性別', 'age', '年齢', 'weight', '体重', 'burdenweight', '斤量']):
            categories['JRA-VAN_馬基本情報'].append(col)
        
        # 騎手・調教師
        elif any(kw in col_lower for kw in ['jockey', '騎手', 'trainer', '調教師', 'kishu', 'chokyoshi']):
            categories['JRA-VAN_騎手・調教師'].append(col)
        
        # 過去成績
        elif any(kw in col_lower for kw in ['past', '過去', 'previous', 'history', 'chaku', '着', 'win', 'place']):
            categories['JRA-VAN_過去成績'].append(col)
        
        # 馬場・天候
        elif any(kw in col_lower for kw in ['tenki', '天気', 'weather', 'babajotai', '馬場状態', 'condition']):
            categories['JRA-VAN_馬場・天候'].append(col)
        
        # オッズ
        elif any(kw in col_lower for kw in ['odds', 'オッズ', 'ninki', '人気']):
            categories['JRA-VAN_オッズ'].append(col)
        
        # JRDB基本
        elif any(kw in col_lower for kw in ['jrdb', 'bac', 'sed', 'kyi']):
            if 'past' in col_lower or '過去' in col_lower:
                categories['JRDB_過去走'].append(col)
            elif 'cyb' in col_lower or '調教' in col_lower:
                categories['JRDB_調教'].append(col)
            elif 'yoso' in col_lower or '予想' in col_lower:
                categories['JRDB_予想'].append(col)
            else:
                categories['JRDB_基本情報'].append(col)
        
        # 派生特徴量
        elif any(kw in col_lower for kw in ['ratio', '比率', 'rate', 'avg', '平均', 'diff', '差分', 'lag']):
            categories['派生特徴量'].append(col)
        
        # 不明
        else:
            categories['不明'].append(col)
    
    return categories

def analyze_feature_distribution(categories):
    """特徴量分布を分析"""
    print(f"\n{'='*80}")
    print(f"既存特徴量カテゴリ分布")
    print(f"{'='*80}\n")
    
    total = 0
    for category, features in categories.items():
        count = len(features)
        total += count
        print(f"{category}: {count}個")
        if count > 0 and count <= 10:  # 10個以下なら全表示
            for feat in features:
                print(f"  - {feat}")
        print()
    
    print(f"合計: {total}個")
    print(f"{'='*80}\n")
    
    return total

def identify_unused_potential(database_detail_file):
    """データベースから未使用の有望カラムを特定"""
    
    if not os.path.exists(database_detail_file):
        print(f"⚠️  データベース詳細ファイルが見つかりません: {database_detail_file}")
        print(f"先に investigate_database_sources.py を実行してください。")
        return None
    
    print(f"\nデータベース詳細読み込み中: {database_detail_file}")
    df_db = pd.read_csv(database_detail_file, encoding='utf-8-sig')
    
    print(f"✅ データベース総カラム数: {len(df_db)}")
    
    # JRA-VANテーブルのみ抽出
    df_jravan = df_db[df_db['table_name'].str.startswith('jvd_')]
    print(f"JRA-VANカラム数: {len(df_jravan)}")
    
    # JRDBテーブルのみ抽出
    df_jrdb = df_db[df_db['table_name'].str.contains('jrdb', case=False, na=False)]
    print(f"JRDBカラム数: {len(df_jrdb)}")
    
    return df_db, df_jravan, df_jrdb

def suggest_additional_features(existing_features, df_jravan, df_jrdb):
    """追加候補特徴量を提案"""
    print(f"\n{'='*80}")
    print(f"追加候補特徴量の提案")
    print(f"{'='*80}\n")
    
    # 既存特徴量の小文字版（マッチング用）
    existing_lower = [col.lower() for col in existing_features]
    
    # JRA-VAN候補
    print("【JRA-VAN 追加候補】")
    jravan_candidates = []
    for _, row in df_jravan.iterrows():
        col_name = row['column_name']
        if col_name.lower() not in existing_lower:
            # ROI向上に有望なカラムを優先
            if any(kw in col_name.lower() for kw in [
                'time', 'タイム', 'speed', 'スピード',
                'pace', 'ペース', 'position', '位置',
                'corner', 'コーナー', 'margin', '着差',
                'prize', '賞金', 'rating', 'レーティング',
                'idm', 'index', '指数'
            ]):
                jravan_candidates.append({
                    'table': row['table_name'],
                    'column': col_name,
                    'type': row['data_type']
                })
    
    print(f"有望候補数: {len(jravan_candidates)}")
    for i, cand in enumerate(jravan_candidates[:20], 1):  # 上位20件表示
        print(f"{i:2d}. {cand['table']}.{cand['column']} ({cand['type']})")
    
    if len(jravan_candidates) > 20:
        print(f"   ... 他 {len(jravan_candidates)-20}件")
    
    # JRDB候補
    print(f"\n【JRDB 追加候補】")
    jrdb_candidates = []
    for _, row in df_jrdb.iterrows():
        col_name = row['column_name']
        if col_name.lower() not in existing_lower:
            if any(kw in col_name.lower() for kw in [
                'time', 'タイム', 'speed', 'スピード',
                'pace', 'ペース', 'position', '位置',
                'corner', 'コーナー', 'margin', '着差',
                'score', 'スコア', 'mark', 'マーク',
                'ten', 'テン', 'agari', '上がり'
            ]):
                jrdb_candidates.append({
                    'table': row['table_name'],
                    'column': col_name,
                    'type': row['data_type']
                })
    
    print(f"有望候補数: {len(jrdb_candidates)}")
    for i, cand in enumerate(jrdb_candidates[:20], 1):
        print(f"{i:2d}. {cand['table']}.{cand['column']} ({cand['type']})")
    
    if len(jrdb_candidates) > 20:
        print(f"   ... 他 {len(jrdb_candidates)-20}件")
    
    print(f"\n{'='*80}")
    print(f"追加可能カラム数合計: {len(jravan_candidates) + len(jrdb_candidates)}")
    print(f"目標特徴量数: 200-220")
    print(f"現在特徴量数: {len(existing_features)}")
    print(f"必要追加数: {200 - len(existing_features)} ~ {220 - len(existing_features)}")
    print(f"{'='*80}\n")
    
    return jravan_candidates, jrdb_candidates

def save_analysis_results(categories, jravan_candidates, jrdb_candidates, output_dir):
    """分析結果保存"""
    os.makedirs(output_dir, exist_ok=True)
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # カテゴリ分布CSV
    category_data = []
    for category, features in categories.items():
        for feat in features:
            category_data.append({
                'category': category,
                'feature_name': feat
            })
    
    df_cat = pd.DataFrame(category_data)
    cat_file = os.path.join(output_dir, f'existing_features_categorized_{timestamp}.csv')
    df_cat.to_csv(cat_file, index=False, encoding='utf-8-sig')
    print(f"✅ カテゴリ分類保存: {cat_file}")
    
    # JRA-VAN候補CSV
    df_jravan_cand = pd.DataFrame(jravan_candidates)
    jravan_file = os.path.join(output_dir, f'jravan_candidate_features_{timestamp}.csv')
    df_jravan_cand.to_csv(jravan_file, index=False, encoding='utf-8-sig')
    print(f"✅ JRA-VAN候補保存: {jravan_file}")
    
    # JRDB候補CSV
    df_jrdb_cand = pd.DataFrame(jrdb_candidates)
    jrdb_file = os.path.join(output_dir, f'jrdb_candidate_features_{timestamp}.csv')
    df_jrdb_cand.to_csv(jrdb_file, index=False, encoding='utf-8-sig')
    print(f"✅ JRDB候補保存: {jrdb_file}")
    
    return cat_file, jravan_file, jrdb_file

def main():
    """メイン処理"""
    print(f"\n{'='*80}")
    print(f"Phase 7-A 既存特徴量分析開始")
    print(f"実行日時: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"{'='*80}\n")
    
    try:
        # 既存特徴量読み込み
        existing_features = load_existing_features()
        
        # カテゴリ分類
        categories = categorize_features(existing_features)
        
        # 分布分析
        total = analyze_feature_distribution(categories)
        
        # データベース詳細ファイルパス（investigate_database_sources.py実行後に生成）
        result_dir = os.path.join('..', '..', 'results', 'phase7a_features')
        
        # 最新のdatabase_columns_detail_*.csvを検索
        detail_files = [f for f in os.listdir(result_dir) 
                       if f.startswith('database_columns_detail_') and f.endswith('.csv')]
        
        if not detail_files:
            print("\n⚠️  データベース詳細ファイルが見つかりません。")
            print("先に investigate_database_sources.py を実行してください。")
            return 1
        
        latest_detail_file = sorted(detail_files)[-1]
        database_detail_path = os.path.join(result_dir, latest_detail_file)
        
        # 未使用カラム特定
        result = identify_unused_potential(database_detail_path)
        if result:
            df_db, df_jravan, df_jrdb = result
            
            # 追加候補提案
            jravan_candidates, jrdb_candidates = suggest_additional_features(
                existing_features, df_jravan, df_jrdb
            )
            
            # 結果保存
            cat_file, jravan_file, jrdb_file = save_analysis_results(
                categories, jravan_candidates, jrdb_candidates, result_dir
            )
        
        print("\n✅ Phase 7-A 既存特徴量分析完了")
        print(f"\n次のステップ:")
        print(f"1. カテゴリ分類結果を確認")
        print(f"2. JRA-VAN候補とJRDB候補を確認")
        print(f"3. ROI向上に最も有望な特徴量を選定")
        print(f"4. 追加特徴量抽出スクリプトを作成")
        
        return 0
        
    except Exception as e:
        print(f"\n❌ エラー発生: {e}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == '__main__':
    sys.exit(main())
