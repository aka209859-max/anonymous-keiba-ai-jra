#!/usr/bin/env python3
"""
JRDBの特徴量が二値分類・ランキング・回帰の3モデルで本当に使われているか徹底検証
E:\anonymous-keiba-ai-JRA で実行してください
"""
import os
import sys
import json
from pathlib import Path
from typing import Dict, List, Set, Tuple

def extract_lightgbm_features(model_path: str) -> List[str]:
    """LightGBMモデルファイルから特徴量名を抽出"""
    features = []
    try:
        with open(model_path, 'r', encoding='utf-8') as f:
            in_feature_names = False
            for line in f:
                line = line.strip()
                
                # feature_names セクションの開始
                if line.startswith('feature_names='):
                    # feature_names=[feature1 feature2 ...] の形式
                    content = line.replace('feature_names=', '').strip()
                    if content.startswith('[') and content.endswith(']'):
                        # 1行で完結している場合
                        features_str = content[1:-1]
                        features = [f.strip() for f in features_str.split() if f.strip()]
                        break
                    else:
                        in_feature_names = True
                        continue
                
                # feature_names セクション内
                if in_feature_names:
                    if line.endswith(']'):
                        # セクション終了
                        features.extend([f.strip() for f in line[:-1].split() if f.strip()])
                        break
                    else:
                        features.extend([f.strip() for f in line.split() if f.strip()])
    except Exception as e:
        print(f"⚠️  {model_path} の読み込みエラー: {e}")
    
    return features

def categorize_jrdb_features(features: List[str]) -> Dict[str, List[str]]:
    """JRDB特徴量をカテゴリ別に分類"""
    
    # JRDBの132カラムの主要パターン
    jrdb_patterns = {
        # 指数系（15種類）
        'index': ['idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 'ninki_shisu', 
                 'chokyo_shisu', 'kyusha_shisu', 'gekiso_shisu', 'ten_shisu', 
                 'pace_shisu', 'agari_shisu', 'ichi_shisu', 'ls_shisu', 
                 'manken_shisu', 'uma_start_shisu'],
        
        # 適性系（10種類）
        'tekisei': ['kyakushitsu_code', 'kyori_tekisei_code', 'kyori_tekisei_code_2',
                   'joshodo_code', 'tekisei_code_omo', 'tekisei_code_shiba', 
                   'tekisei_code_dirt', 'hizume_code', 'class_code', 'rotation'],
        
        # オッズ・人気系（4種類）
        'odds': ['kijun_odds_tansho', 'kijun_ninkijun_tansho', 
                'kijun_odds_fukusho', 'kijun_ninkijun_fukusho'],
        
        # 特定情報・総合情報（10種類）
        'joho': ['tokutei_joho_1', 'tokutei_joho_2', 'tokutei_joho_3', 
                'tokutei_joho_4', 'tokutei_joho_5', 'sogo_joho_1', 
                'sogo_joho_2', 'sogo_joho_3', 'sogo_joho_4', 'sogo_joho_5'],
        
        # 馬体重系（2種類）
        'bataiju': ['bataiju', 'bataiju_zogen'],
        
        # 過去成績キー（10種類）
        'kako': ['kako1_kyoso_seiseki_key', 'kako2_kyoso_seiseki_key', 
                'kako3_kyoso_seiseki_key', 'kako4_kyoso_seiseki_key', 
                'kako5_kyoso_seiseki_key', 'kako1_race_key', 'kako2_race_key',
                'kako3_race_key', 'kako4_race_key', 'kako5_race_key'],
        
        # 騎手期待値（3種類）
        'kishu_kitai': ['kishu_kitai_rentai_ritsu', 'kishu_kitai_tansho_ritsu',
                       'kishu_kitai_sanchakunai_ritsu'],
        
        # 体型・特記（9種類）
        'taikei': ['taikei', 'taikei_sogo_1', 'taikei_sogo_2', 'taikei_sogo_3',
                  'uma_tokki_1', 'uma_tokki_2', 'uma_tokki_3', 'uma_deokure_ritsu',
                  'soho'],
        
        # レース展開予想（18種類）
        'tenkai': ['pace_yoso', 'dochu_juni', 'dochu_sa', 'dochu_uchisoto',
                  'kohan_3f_juni', 'kohan_3f_sa', 'kohan_3f_uchisoto',
                  'goal_juni', 'goal_sa', 'goal_uchisoto', 'tenkai_kigo_code',
                  'gekiso_juni', 'ls_shisu_juni', 'ten_shisu_juni',
                  'pace_shisu_juni', 'agari_shisu_juni', 'ichi_shisu_juni',
                  'gekiso_type'],
        
        # 印・評価（12種類）
        'shirushi': ['shirushi_code_1', 'shirushi_code_2', 'shirushi_code_3',
                    'shirushi_code_4', 'shirushi_code_5', 'shirushi_code_6',
                    'shirushi_code_7', 'chokyo_yajirushi_code', 'kyusha_hyoka_code',
                    'manken_shirushi', 'hobokusaki_rank', 'kyusha_rank'],
        
        # その他（賞金、フラグ、馬記号等）
        'other': ['kakutoku_shokin_ruikei', 'shutoku_shokin_ruikei', 
                 'joken_class_code', 'blinker_shiyo_kubun', 'wakuban',
                 'torikeshi_flag', 'seibetsu_code', 'banushikai_code',
                 'umakigo_code', 'yuso_kubun', 'sanko_zenso', 
                 'sanko_zenso_kishu_code', 'kokyu_flag', 
                 'kyuyo_riyu_bunrui_code', 'flag', 'nyukyu_nansome',
                 'nyukyu_nengappi', 'nyukyu_nannichimae']
    }
    
    categorized = {cat: [] for cat in jrdb_patterns.keys()}
    uncategorized = []
    
    for feature in features:
        feature_lower = feature.lower()
        matched = False
        
        for category, patterns in jrdb_patterns.items():
            for pattern in patterns:
                # 完全一致または接頭辞一致（_avg, _max, _min等の派生特徴量対応）
                if (feature_lower == pattern.lower() or 
                    feature_lower.startswith(pattern.lower() + '_')):
                    categorized[category].append(feature)
                    matched = True
                    break
            if matched:
                break
        
        if not matched:
            uncategorized.append(feature)
    
    # JRA-VANのみの特徴量（uncategorized）も分類
    categorized['jravan_only'] = uncategorized
    
    return categorized

def main():
    print("=" * 80)
    print("🔍 JRDB特徴量の使用状況を徹底検証")
    print("=" * 80)
    print()
    
    # プロジェクトルート（E:\anonymous-keiba-ai-JRA を想定）
    project_root = Path.cwd()
    models_dir = project_root / 'models'
    
    if not models_dir.exists():
        print(f"❌ modelsディレクトリが見つかりません: {models_dir}")
        print(f"   現在のディレクトリ: {project_root}")
        print(f"   E:\\anonymous-keiba-ai-JRA で実行してください")
        sys.exit(1)
    
    # 検証対象モデル
    target_models = {
        'binary': 'jra_binary_model.txt',      # 二値分類（勝敗予測）
        'ranking': 'jra_ranking_model.txt',    # ランキング（着順予測）
        'regression': 'jra_regression_model.txt'  # 回帰（タイム予測）
    }
    
    results = {}
    
    for model_type, model_file in target_models.items():
        model_path = models_dir / model_file
        
        print(f"\n{'='*80}")
        print(f"📊 [{model_type.upper()}モデル] {model_file}")
        print(f"{'='*80}")
        
        if not model_path.exists():
            print(f"⚠️  ファイルが見つかりません: {model_path}")
            results[model_type] = None
            continue
        
        # 特徴量抽出
        features = extract_lightgbm_features(str(model_path))
        
        if not features:
            print(f"⚠️  特徴量を抽出できませんでした")
            results[model_type] = None
            continue
        
        print(f"\n✅ 全特徴量数: {len(features)}")
        
        # JRDB特徴量を分類
        categorized = categorize_jrdb_features(features)
        
        # JRDB特徴量の合計数
        jrdb_total = sum(len(v) for k, v in categorized.items() if k != 'jravan_only')
        jravan_only = len(categorized['jravan_only'])
        
        print(f"\n📌 JRDB由来の特徴量: {jrdb_total} 個 ({jrdb_total/len(features)*100:.1f}%)")
        print(f"📌 JRA-VANのみの特徴量: {jravan_only} 個 ({jravan_only/len(features)*100:.1f}%)")
        
        # カテゴリ別詳細
        print(f"\n{'カテゴリ':<20} {'個数':>6}  特徴量例（最大10個）")
        print("-" * 80)
        
        for category in ['index', 'tekisei', 'odds', 'joho', 'bataiju', 'kako', 
                        'kishu_kitai', 'taikei', 'tenkai', 'shirushi', 'other']:
            count = len(categorized[category])
            if count > 0:
                examples = ', '.join(categorized[category][:10])
                if len(categorized[category]) > 10:
                    examples += f" ... (他{len(categorized[category])-10}個)"
                print(f"{category:<20} {count:>6}  {examples}")
        
        print(f"\n{'JRA-VANのみ':<20} {jravan_only:>6}  (JRDB以外の特徴量)")
        
        # 結果保存
        results[model_type] = {
            'total_features': len(features),
            'jrdb_features': jrdb_total,
            'jravan_features': jravan_only,
            'jrdb_percentage': jrdb_total / len(features) * 100,
            'categorized': {k: len(v) for k, v in categorized.items()},
            'examples': {k: v[:20] for k, v in categorized.items()}  # 各カテゴリ20個まで
        }
    
    # サマリー出力
    print(f"\n\n{'='*80}")
    print("📊 3モデルのJRDB使用状況サマリー")
    print(f"{'='*80}")
    print(f"\n{'モデル':<15} {'全特徴量':>10} {'JRDB特徴量':>12} {'JRDB率':>10} {'JRA-VAN':>10}")
    print("-" * 80)
    
    for model_type in ['binary', 'ranking', 'regression']:
        if results.get(model_type):
            r = results[model_type]
            print(f"{model_type:<15} {r['total_features']:>10} {r['jrdb_features']:>12} "
                  f"{r['jrdb_percentage']:>9.1f}% {r['jravan_features']:>10}")
        else:
            print(f"{model_type:<15} {'N/A':>10} {'N/A':>12} {'N/A':>10} {'N/A':>10}")
    
    # JSON出力（詳細分析用）
    output_file = project_root / 'jrdb_feature_analysis.json'
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    
    print(f"\n\n✅ 詳細結果を保存しました: {output_file}")
    print()
    print("=" * 80)
    print("🎯 結論")
    print("=" * 80)
    
    # 結論判定
    all_models_ok = True
    for model_type, result in results.items():
        if result and result['jrdb_percentage'] < 10:
            all_models_ok = False
            print(f"⚠️  {model_type}モデル: JRDB特徴量が{result['jrdb_percentage']:.1f}%しか使われていません")
    
    if all_models_ok and all(results.values()):
        print("✅ 全モデルでJRDB特徴量が適切に使用されています")
    elif not all(results.values()):
        print("⚠️  一部のモデルファイルが見つかりませんでした")
    else:
        print("❌ JRDBデータが十分に活用されていない可能性があります")
        print("   → モデル再学習が必要な場合があります")
    
    print("=" * 80)

if __name__ == '__main__':
    main()
