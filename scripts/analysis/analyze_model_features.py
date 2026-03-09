#!/usr/bin/env python3
"""
3モデル（二値分類・ランキング・回帰）で使われている全特徴量を
JRA-VAN由来とJRDB由来に完全に分類する
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
                
                if line.startswith('feature_names='):
                    content = line.replace('feature_names=', '').strip()
                    if content.startswith('[') and content.endswith(']'):
                        features_str = content[1:-1]
                        features = [f.strip() for f in features_str.split() if f.strip()]
                        break
                    else:
                        in_feature_names = True
                        continue
                
                if in_feature_names:
                    if line.endswith(']'):
                        features.extend([f.strip() for f in line[:-1].split() if f.strip()])
                        break
                    else:
                        features.extend([f.strip() for f in line.split() if f.strip()])
    except Exception as e:
        print(f"⚠️  {model_path} の読み込みエラー: {e}")
    
    return features

def classify_feature_source(feature_name: str) -> str:
    """特徴量名からJRDB由来かJRA-VAN由来かを判定"""
    
    feature_lower = feature_name.lower()
    
    # JRDBテーブル jrd_kyi の132カラム全パターン（完全網羅版）
    jrdb_keywords = [
        # === 指数系（15種類） ===
        'idm', 'kishu_shisu', 'joho_shisu', 'sogo_shisu', 'ninki_shisu',
        'chokyo_shisu', 'kyusha_shisu', 'gekiso_shisu', 'ten_shisu',
        'pace_shisu', 'agari_shisu', 'ichi_shisu', 'ls_shisu',
        'manken_shisu', 'uma_start_shisu',
        
        # === 適性系（10種類） ===
        'kyakushitsu_code', 'kyori_tekisei_code', 'kyori_tekisei_code_2',
        'joshodo_code', 'tekisei_code_omo', 'tekisei_code_shiba',
        'tekisei_code_dirt', 'hizume_code', 'class_code', 'rotation',
        
        # === オッズ・人気系（4種類） ===
        'kijun_odds_tansho', 'kijun_ninkijun_tansho',
        'kijun_odds_fukusho', 'kijun_ninkijun_fukusho',
        
        # === 特定情報・総合情報（10種類） ===
        'tokutei_joho_1', 'tokutei_joho_2', 'tokutei_joho_3',
        'tokutei_joho_4', 'tokutei_joho_5', 'sogo_joho_1',
        'sogo_joho_2', 'sogo_joho_3', 'sogo_joho_4', 'sogo_joho_5',
        
        # === 馬体重系（2種類） ===
        'bataiju', 'bataiju_zogen',
        
        # === 過去成績キー（10種類） ===
        'kako1_kyoso_seiseki_key', 'kako2_kyoso_seiseki_key',
        'kako3_kyoso_seiseki_key', 'kako4_kyoso_seiseki_key',
        'kako5_kyoso_seiseki_key', 'kako1_race_key', 'kako2_race_key',
        'kako3_race_key', 'kako4_race_key', 'kako5_race_key',
        
        # === 騎手期待値（3種類） ===
        'kishu_kitai_rentai_ritsu', 'kishu_kitai_tansho_ritsu',
        'kishu_kitai_sanchakunai_ritsu',
        
        # === 体型・特記（9種類） ===
        'taikei', 'taikei_sogo_1', 'taikei_sogo_2', 'taikei_sogo_3',
        'uma_tokki_1', 'uma_tokki_2', 'uma_tokki_3', 'uma_deokure_ritsu',
        'soho',
        
        # === レース展開予想（18種類） ===
        'pace_yoso', 'dochu_juni', 'dochu_sa', 'dochu_uchisoto',
        'kohan_3f_juni', 'kohan_3f_sa', 'kohan_3f_uchisoto',
        'goal_juni', 'goal_sa', 'goal_uchisoto', 'tenkai_kigo_code',
        'gekiso_juni', 'ls_shisu_juni', 'ten_shisu_juni',
        'pace_shisu_juni', 'agari_shisu_juni', 'ichi_shisu_juni',
        'gekiso_type',
        
        # === 印・評価（12種類） ===
        'shirushi_code_1', 'shirushi_code_2', 'shirushi_code_3',
        'shirushi_code_4', 'shirushi_code_5', 'shirushi_code_6',
        'shirushi_code_7', 'chokyo_yajirushi_code', 'kyusha_hyoka_code',
        'manken_shirushi', 'hobokusaki_rank', 'kyusha_rank',
        
        # === その他JRDB特有（20種類以上） ===
        'kakutoku_shokin_ruikei', 'shutoku_shokin_ruikei',
        'joken_class_code', 'blinker_shiyo_kubun', 'wakuban',
        'torikeshi_flag', 'banushikai_code', 'umakigo_code',
        'yuso_kubun', 'sanko_zenso', 'sanko_zenso_kishu_code',
        'kokyu_flag', 'kyuyo_riyu_bunrui_code',
        'nyukyu_nansome', 'nyukyu_nengappi', 'nyukyu_nannichimae',
        'hobokusaki', 'ketto_toroku_bango',
        
        # === JRDBテーブル名も含める ===
        'jrd_kyi', 'jrd_sed', 'jrd_joa', 'jrd_cyb', 'jrd_bac',
    ]
    
    # JRDBキーワードマッチング（完全一致 or 接頭辞一致）
    for keyword in jrdb_keywords:
        if feature_lower == keyword or feature_lower.startswith(keyword + '_'):
            return 'JRDB'
    
    # デフォルトはJRA-VAN
    return 'JRA-VAN'

def analyze_model_features(model_path: Path, model_name: str) -> Dict:
    """モデルの特徴量を詳細分析"""
    
    print(f"\n{'='*100}")
    print(f"📊 【{model_name}】 {model_path.name}")
    print(f"{'='*100}")
    
    features = extract_lightgbm_features(str(model_path))
    
    if not features:
        print("⚠️  特徴量を抽出できませんでした")
        return None
    
    # JRDBとJRA-VANに分類
    jrdb_features = []
    jravan_features = []
    
    for feature in features:
        source = classify_feature_source(feature)
        if source == 'JRDB':
            jrdb_features.append(feature)
        else:
            jravan_features.append(feature)
    
    total = len(features)
    jrdb_count = len(jrdb_features)
    jravan_count = len(jravan_features)
    
    print(f"\n✅ 特徴量総数: {total}")
    print(f"   ├─ JRDB由来:    {jrdb_count:4d} 個 ({jrdb_count/total*100:5.1f}%)")
    print(f"   └─ JRA-VAN由来: {jravan_count:4d} 個 ({jravan_count/total*100:5.1f}%)")
    
    # JRDB特徴量の詳細リスト
    print(f"\n📋 JRDB由来の特徴量一覧（{jrdb_count}個）:")
    print("-" * 100)
    if jrdb_features:
        for i, feat in enumerate(sorted(jrdb_features), 1):
            print(f"  {i:3d}. {feat}")
    else:
        print("  （なし）")
    
    # JRA-VAN特徴量の詳細リスト
    print(f"\n📋 JRA-VAN由来の特徴量一覧（{jravan_count}個）:")
    print("-" * 100)
    if jravan_features:
        for i, feat in enumerate(sorted(jravan_features), 1):
            print(f"  {i:3d}. {feat}")
    else:
        print("  （なし）")
    
    return {
        'model_name': model_name,
        'total_features': total,
        'jrdb_count': jrdb_count,
        'jravan_count': jravan_count,
        'jrdb_percentage': jrdb_count / total * 100,
        'jrdb_features': sorted(jrdb_features),
        'jravan_features': sorted(jravan_features)
    }

def main():
    print("=" * 100)
    print("🔍 3モデルの特徴量を完全分析（JRDBとJRA-VANに完全分類）")
    print("=" * 100)
    print()
    
    project_root = Path.cwd()
    models_dir = project_root / 'models'
    
    if not models_dir.exists():
        print(f"❌ modelsディレクトリが見つかりません: {models_dir}")
        print(f"   現在のディレクトリ: {project_root}")
        print(f"   E:\\anonymous-keiba-ai-JRA で実行してください")
        sys.exit(1)
    
    # 3モデルを定義
    target_models = [
        ('jra_binary_model.txt', '二値分類モデル（勝敗予測）'),
        ('jra_ranking_model.txt', 'ランキングモデル（着順予測）'),
        ('jra_regression_model.txt', '回帰モデル（タイム予測）')
    ]
    
    results = {}
    
    for model_file, model_name in target_models:
        model_path = models_dir / model_file
        
        if not model_path.exists():
            print(f"\n⚠️  {model_file} が見つかりません")
            results[model_name] = None
            continue
        
        result = analyze_model_features(model_path, model_name)
        results[model_name] = result
    
    # ========================================
    # サマリーテーブル
    # ========================================
    print(f"\n\n{'='*100}")
    print("📊 【サマリー】3モデルの特徴量使用状況")
    print(f"{'='*100}")
    print(f"\n{'モデル':<30} {'全特徴量':>10} {'JRDB':>10} {'JRDB率':>10} {'JRA-VAN':>10}")
    print("-" * 100)
    
    for model_name in ['二値分類モデル（勝敗予測）', 'ランキングモデル（着順予測）', '回帰モデル（タイム予測）']:
        if results.get(model_name):
            r = results[model_name]
            print(f"{model_name:<30} {r['total_features']:>10} {r['jrdb_count']:>10} "
                  f"{r['jrdb_percentage']:>9.1f}% {r['jravan_count']:>10}")
        else:
            print(f"{model_name:<30} {'N/A':>10} {'N/A':>10} {'N/A':>10} {'N/A':>10}")
    
    # ========================================
    # 共通JRDB特徴量の抽出
    # ========================================
    print(f"\n\n{'='*100}")
    print("🔗 【共通特徴量分析】3モデル全てで使われているJRDB特徴量")
    print(f"{'='*100}")
    
    jrdb_sets = []
    for model_name, result in results.items():
        if result and result['jrdb_features']:
            jrdb_sets.append(set(result['jrdb_features']))
    
    if len(jrdb_sets) >= 2:
        common_jrdb = set.intersection(*jrdb_sets) if jrdb_sets else set()
        if common_jrdb:
            print(f"\n✅ 全モデル共通のJRDB特徴量（{len(common_jrdb)}個）:")
            for i, feat in enumerate(sorted(common_jrdb), 1):
                print(f"  {i:3d}. {feat}")
        else:
            print("\n⚠️  全モデル共通のJRDB特徴量はありません")
    
    # ========================================
    # JSON出力
    # ========================================
    output_file = project_root / 'model_features_analysis.json'
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    
    print(f"\n\n✅ 詳細結果をJSON形式で保存しました: {output_file}")
    
    # ========================================
    # 最終結論
    # ========================================
    print(f"\n\n{'='*100}")
    print("🎯 【最終結論】")
    print(f"{'='*100}")
    
    all_have_jrdb = True
    for model_name, result in results.items():
        if result:
            if result['jrdb_count'] == 0:
                print(f"❌ {model_name}: JRDBの特徴量が1つも使われていません！")
                all_have_jrdb = False
            elif result['jrdb_percentage'] < 5:
                print(f"⚠️  {model_name}: JRDBの特徴量が{result['jrdb_percentage']:.1f}%しか使われていません")
                all_have_jrdb = False
    
    if all_have_jrdb and all(results.values()):
        print("✅ 全モデルでJRDB特徴量が使用されています")
        print("   → Phase 6の予測結果にはJRDBデータが反映されています")
    else:
        print("❌ JRDBデータが十分に反映されていない可能性があります")
        print("   → モデルの再学習またはデータパイプラインの見直しが必要です")
    
    print("=" * 100)

if __name__ == '__main__':
    main()
