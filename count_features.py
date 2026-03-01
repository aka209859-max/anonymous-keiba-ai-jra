import json
from pathlib import Path

def extract_lightgbm_features_correct(model_path):
    """LightGBMモデルから特徴量名を正しく抽出"""
    features = []
    try:
        with open(model_path, 'r', encoding='utf-8') as f:
            in_feature_names = False
            for line in f:
                line = line.strip()
                
                # feature_names= で始まる行を探す
                if line.startswith('feature_names='):
                    # [で始まる場合
                    content = line.replace('feature_names=', '').strip()
                    if content == '[':
                        in_feature_names = True
                        continue
                    elif content.startswith('[') and content.endswith(']'):
                        # 1行で完結している場合（まずない）
                        features_str = content[1:-1]
                        features = [f.strip() for f in features_str.split() if f.strip()]
                        break
                    else:
                        in_feature_names = True
                        continue
                
                # feature_names セクション内
                if in_feature_names:
                    if line == ']':
                        # セクション終了
                        break
                    else:
                        # 特徴量名を追加（空白でない場合）
                        if line:
                            features.append(line)
    except Exception as e:
        print(f"Error reading {model_path}: {e}")
    
    return features

def is_jrdb_feature(feature_name):
    """特徴量がJRDB由来かを判定"""
    feature_lower = feature_name.lower()
    
    # JRDBテーブルの132カラムのキーワード（完全版）
    jrdb_keywords = [
        # 指数系
        'idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 'ninki_shisu',
        'chokyo_shisu', 'kyusha_shisu', 'gekiso_shisu', 'ten_shisu',
        'pace_shisu', 'agari_shisu', 'ichi_shisu', 'ls_shisu',
        'manken_shisu', 'uma_start_shisu',
        # 適性系
        'kyakushitsu_code', 'kyori_tekisei_code', 'kyori_tekisei_code_2',
        'joshodo_code', 'tekisei_code_omo', 'tekisei_code_shiba',
        'tekisei_code_dirt', 'hizume_code', 'class_code', 'rotation',
        # オッズ系
        'kijun_odds_tansho', 'kijun_ninkijun_tansho',
        'kijun_odds_fukusho', 'kijun_ninkijun_fukusho',
        # 情報系
        'tokutei_joho_1', 'tokutei_joho_2', 'tokutei_joho_3',
        'tokutei_joho_4', 'tokutei_joho_5', 'sogo_joho_1',
        'sogo_joho_2', 'sogo_joho_3', 'sogo_joho_4', 'sogo_joho_5',
        # 馬体重
        'bataiju', 'bataiju_zogen',
        # 過去成績
        'kako1_kyoso_seiseki_key', 'kako2_kyoso_seiseki_key',
        'kako3_kyoso_seiseki_key', 'kako4_kyoso_seiseki_key',
        'kako5_kyoso_seiseki_key', 'kako1_race_key', 'kako2_race_key',
        'kako3_race_key', 'kako4_race_key', 'kako5_race_key',
        # 騎手期待値
        'kishu_kitai_rentai_ritsu', 'kishu_kitai_tansho_ritsu',
        'kishu_kitai_sanchakunai_ritsu',
        # 体型
        'taikei', 'taikei_sogo_1', 'taikei_sogo_2', 'taikei_sogo_3',
        'uma_tokki_1', 'uma_tokki_2', 'uma_tokki_3', 
        'uma_deokure_ritsu', 'soho',
        # 展開予想
        'pace_yoso', 'dochu_juni', 'dochu_sa', 'dochu_uchisoto',
        'kohan_3f_juni', 'kohan_3f_sa', 'kohan_3f_uchisoto',
        'goal_juni', 'goal_sa', 'goal_uchisoto', 'tenkai_kigo_code',
        'gekiso_juni', 'ls_shisu_juni', 'ten_shisu_juni',
        'pace_shisu_juni', 'agari_shisu_juni', 'ichi_shisu_juni',
        'gekiso_type',
        # 印・評価
        'shirushi_code_1', 'shirushi_code_2', 'shirushi_code_3',
        'shirushi_code_4', 'shirushi_code_5', 'shirushi_code_6',
        'shirushi_code_7', 'chokyo_yajirushi_code', 'kyusha_hyoka_code',
        'manken_shirushi', 'hobokusaki_rank', 'kyusha_rank',
        # その他
        'kakutoku_shokin_ruikei', 'shutoku_shokin_ruikei',
        'joken_class_code', 'blinker_shiyo_kubun', 'wakuban',
        'torikeshi_flag', 'seibetsu_code', 'banushikai_code',
        'umakigo_code', 'yuso_kubun', 'sanko_zenso',
        'sanko_zenso_kishu_code', 'kokyu_flag',
        'kyuyo_riyu_bunrui_code', 'flag', 'nyukyu_nansome',
        'nyukyu_nengappi', 'nyukyu_nannichimae', 'hobokusaki',
        'ketto_toroku_bango',
        # テーブル名
        'jrd_kyi', 'jrd_sed', 'jrd_joa', 'jrd_cyb', 'jrd_bac'
    ]
    
    # 完全一致または接頭辞一致
    for keyword in jrdb_keywords:
        if feature_lower == keyword or feature_lower.startswith(keyword + '_'):
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
print("3モデルの特徴量数を正確にカウント")
print("="*80)

results = {}

for model_file, model_name in target_models:
    model_path = models_dir / model_file
    
    print(f"\n【{model_name}】 {model_file}")
    print("-"*80)
    
    if not model_path.exists():
        print(f"  ファイルが見つかりません: {model_path}")
        continue
    
    # 特徴量を抽出
    features = extract_lightgbm_features_correct(str(model_path))
    
    # JRDBとJRA-VANに分類
    jrdb_features = [f for f in features if is_jrdb_feature(f)]
    jravan_features = [f for f in features if not is_jrdb_feature(f)]
    
    total = len(features)
    jrdb_count = len(jrdb_features)
    jravan_count = len(jravan_features)
    
    print(f"  全特徴量数:      {total:,}")
    print(f"  JRDB特徴量:      {jrdb_count:,} ({jrdb_count/total*100:.2f}%)")
    print(f"  JRA-VAN特徴量:   {jravan_count:,} ({jravan_count/total*100:.2f}%)")
    
    # JRDB特徴量のリストを表示（最初の50個）
    if jrdb_features:
        print(f"\n  JRDB特徴量（最初の50個）:")
        for i, feat in enumerate(jrdb_features[:50], 1):
            print(f"    {i:2d}. {feat}")
        if len(jrdb_features) > 50:
            print(f"    ... 他 {len(jrdb_features)-50} 個")
    
    results[model_name] = {
        'total': total,
        'jrdb_count': jrdb_count,
        'jravan_count': jravan_count,
        'jrdb_features': jrdb_features[:100]  # 最初の100個まで保存
    }

# サマリー
print("\n\n" + "="*80)
print("【サマリー】")
print("="*80)
print(f"{'モデル':<20} {'全特徴量':>15} {'JRDB':>15} {'JRDB率':>10}")
print("-"*80)

for model_name in ['二値分類モデル', 'ランキングモデル', '回帰モデル']:
    if model_name in results:
        r = results[model_name]
        print(f"{model_name:<20} {r['total']:>15,} {r['jrdb_count']:>15,} {r['jrdb_count']/r['total']*100:>9.2f}%")

# JSON保存
with open('model_features_count.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, indent=2, ensure_ascii=False)

print("\n詳細結果を保存: model_features_count.json")
print("="*80)
