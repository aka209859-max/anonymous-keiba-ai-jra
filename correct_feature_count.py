import json
from pathlib import Path

def extract_features_from_lightgbm(model_path):
    """LightGBMモデルから特徴量を正しく抽出"""
    features = []
    try:
        with open(model_path, 'r', encoding='utf-8') as f:
            for line in f:
                if line.startswith('feature_names='):
                    # feature_names=feat1 feat2 feat3 の形式
                    features_str = line.replace('feature_names=', '').strip()
                    features = features_str.split()
                    break
    except Exception as e:
        print(f"Error: {e}")
    return features

def is_jrdb_feature(feature_name):
    """JRDBの132カラムに該当するかチェック"""
    feature_lower = feature_name.lower()
    
    jrdb_keywords = [
        'idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 'ninki_shisu',
        'chokyo_shisu', 'kyusha_shisu', 'gekiso_shisu', 'ten_shisu',
        'pace_shisu', 'agari_shisu', 'ichi_shisu', 'ls_shisu',
        'manken_shisu', 'uma_start_shisu',
        'kyakushitsu_code', 'kyori_tekisei_code', 'kyori_tekisei_code_2',
        'joshodo_code', 'tekisei_code_omo', 'tekisei_code_shiba',
        'tekisei_code_dirt', 'hizume_code', 'class_code', 'rotation',
        'kijun_odds_tansho', 'kijun_ninkijun_tansho',
        'kijun_odds_fukusho', 'kijun_ninkijun_fukusho',
        'tokutei_joho_', 'sogo_joho_', 'bataiju', 'kako',
        'kishu_kitai_', 'taikei', 'uma_tokki_', 'uma_deokure_ritsu',
        'soho', 'pace_yoso', 'dochu_juni', 'kohan_3f_juni',
        'goal_juni', 'tenkai_kigo_code', 'gekiso_juni',
        'shirushi_code_', 'chokyo_yajirushi_code', 'kyusha_hyoka_code',
        'manken_shirushi', 'hobokusaki_rank', 'kyusha_rank',
        'kakutoku_shokin_ruikei', 'shutoku_shokin_ruikei',
        'joken_class_code', 'blinker_shiyo_kubun', 'wakuban',
        'jrd_kyi', 'jrd_sed', 'jrd_joa', 'jrd_cyb', 'jrd_bac',
        'shiage_shisu', 'chokyo_hyoka', 'bataiju_jrdb', 'bataiju_zogen',
        'cid', 'ls_shisu', 'ls_hyoka', 'em', 'kyusha_bb_shirushi',
        'kishu_bb_shirushi', 'kyusha_bb_nijumaru_tansho_kaishuritsu'
    ]
    
    for keyword in jrdb_keywords:
        if feature_lower == keyword or feature_lower.startswith(keyword):
            return True
    return False

# メイン処理
project_root = Path.cwd()
models_dir = project_root / 'models'

target_models = [
    ('jra_binary_model.txt', '二値分類モデル'),
    ('jra_ranking_model.txt', 'ランキングモデル'),
    ('jra_regression_model.txt', '回帰モデル')
]

print("="*80)
print("3モデルの特徴量を正確にカウント（修正版）")
print("="*80)

all_results = {}

for model_file, model_name in target_models:
    model_path = models_dir / model_file
    
    print(f"\n【{model_name}】")
    print("-"*80)
    
    if not model_path.exists():
        print(f"  ファイルが見つかりません")
        continue
    
    features = extract_features_from_lightgbm(str(model_path))
    
    jrdb_features = [f for f in features if is_jrdb_feature(f)]
    jravan_features = [f for f in features if not is_jrdb_feature(f)]
    
    total = len(features)
    jrdb_count = len(jrdb_features)
    jravan_count = len(jravan_features)
    
    print(f"  全特徴量数:      {total}")
    print(f"  JRDB特徴量:      {jrdb_count} ({jrdb_count/total*100:.1f}%)")
    print(f"  JRA-VAN特徴量:   {jravan_count} ({jravan_count/total*100:.1f}%)")
    
    # JRDB特徴量リスト
    if jrdb_features:
        print(f"\n  JRDB特徴量一覧:")
        for i, feat in enumerate(jrdb_features, 1):
            print(f"    {i:2d}. {feat}")
    else:
        print(f"\n  JRDB特徴量: なし")
    
    all_results[model_name] = {
        'total': total,
        'jrdb_count': jrdb_count,
        'jravan_count': jravan_count,
        'jrdb_features': jrdb_features,
        'jravan_features': jravan_features
    }

# サマリー
print("\n\n" + "="*80)
print("【サマリー】")
print("="*80)
print(f"{'モデル':<20} {'全特徴量':>12} {'JRDB':>12} {'JRDB率':>12}")
print("-"*80)

for model_name in ['二値分類モデル', 'ランキングモデル', '回帰モデル']:
    if model_name in all_results:
        r = all_results[model_name]
        print(f"{model_name:<20} {r['total']:>12} {r['jrdb_count']:>12} {r['jrdb_count']/r['total']*100:>11.1f}%")

# JSON保存
with open('final_feature_analysis.json', 'w', encoding='utf-8') as f:
    json.dump(all_results, f, indent=2, ensure_ascii=False)

print("\n詳細結果保存: final_feature_analysis.json")
print("="*80)
