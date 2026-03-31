"""
Phase 7-A Day 5: 既存81カラムの徹底調査
目的: 81カラムのソース内訳を完全解明
"""

# 既存81カラムリスト（PowerShellで取得したCSVヘッダー）
existing_81_columns = [
    "kaisai_nen", "kaisai_tsukihi", "keibajo_code", "kaisai_kai", "kaisai_nichime",
    "race_bango", "umaban", "ketto_toroku_bango_jravan", "wakuban", "seibetsu_code",
    "month", "kyori", "track_code", "tenko_code", "babajotai_code_shiba",
    "babajotai_code_dirt", "hasso_jikoku", "grade_code", "keibajo_season_code",
    "shusso_tosu", "barei", "kishumei_ryakusho", "bataiju_jravan", "zogen_sa",
    "blinker_shiyo_kubun", "race_date_int", "target_top3", "prev1_rank",
    "prev1_time", "prev1_last_3f", "past5_rank_avg", "past5_rank_best",
    "past5_time_avg", "race_shikonen", "ketto_toroku_bango_jrdb", "idm",
    "kishu_shisu", "joho_shisu", "sogo_shisu", "chokyo_shisu", "kyusha_shisu",
    "gekiso_shisu", "ninki_shisu", "ten_shisu", "pace_shisu", "agari_shisu",
    "ichi_shisu", "manken_shisu", "chokyo_yajirushi_code", "kyusha_hyoka_code",
    "kishu_kitai_rentai_ritsu", "shiage_shisu", "chokyo_hyoka", "kyakushitsu_code",
    "kyori_tekisei_code", "joshodo_code", "tekisei_code_omo", "hizume_code",
    "class_code", "pace_yoso", "uma_deokure_ritsu", "rotation", "hobokusaki_rank",
    "kyusha_rank", "bataiju_jrdb", "bataiju_zogen", "uma_start_shisu", "cid",
    "ls_shisu", "ls_hyoka", "em", "kyusha_bb_shirushi", "kishu_bb_shirushi",
    "kyusha_bb_nijumaru_tansho_kaishuritsu", "prev1_pace", "prev1_deokure",
    "prev1_furi", "prev1_furi_1", "prev1_furi_2", "prev1_furi_3", "prev1_batai_code"
]

print(f"✅ 既存CSVの総カラム数: {len(existing_81_columns)}")
print("=" * 80)

# JRA-VANテーブルのカラム（jvd_se 70, jvd_ra 62, jvd_ck 106から抽出）
jravan_columns_jvd_se = [
    "kaisai_nen", "kaisai_tsukihi", "keibajo_code", "kaisai_kai", "kaisai_nichime",
    "race_bango", "umaban", "ketto_toroku_bango", "wakuban", "seibetsu_code",
    "barei", "kishumei_ryakusho", "bataiju", "zogen_sa", "blinker_shiyo_kubun"
]

jravan_columns_jvd_ra = [
    "kyori", "track_code", "tenko_code", "babajotai_code_shiba", "babajotai_code_dirt",
    "hasso_jikoku", "grade_code", "shusso_tosu", "keibajo_season_code", "month"
]

# JRDBテーブルのカラム（jrd_kyi 132カラムから抽出）
jrdb_columns_jrd_kyi = [
    "race_shikonen", "ketto_toroku_bango", "idm", "kishu_shisu", "joho_shisu",
    "sogo_shisu", "chokyo_shisu", "kyusha_shisu", "gekiso_shisu", "ninki_shisu",
    "ten_shisu", "pace_shisu", "agari_shisu", "ichi_shisu", "manken_shisu",
    "chokyo_yajirushi_code", "kyusha_hyoka_code", "kishu_kitai_rentai_ritsu",
    "shiage_shisu", "chokyo_hyoka", "kyakushitsu_code", "kyori_tekisei_code",
    "joshodo_code", "tekisei_code_omo", "hizume_code", "class_code", "pace_yoso",
    "uma_deokure_ritsu", "rotation", "hobokusaki_rank", "kyusha_rank",
    "bataiju", "bataiju_zogen", "uma_start_shisu", "cid", "ls_shisu", "ls_hyoka",
    "em", "kyusha_bb_shirushi", "kishu_bb_shirushi",
    "kyusha_bb_nijumaru_tansho_kaishuritsu"
]

# JRDBテーブルのカラム（jrd_sed 80カラムから抽出）
jrdb_columns_jrd_sed = [
    "prev1_pace", "prev1_deokure", "prev1_furi", "prev1_furi_1", "prev1_furi_2",
    "prev1_furi_3", "prev1_batai_code"
]

# 派生カラム（Phase 1-6で生成された特徴量）
derived_columns = [
    "race_date_int", "target_top3", "prev1_rank", "prev1_time", "prev1_last_3f",
    "past5_rank_avg", "past5_rank_best", "past5_time_avg"
]

# カラム名の正規化（JRA-VANとJRDBで同じカラムに異なる接尾辞がある場合）
jravan_normalized = []
for col in existing_81_columns:
    if col in jravan_columns_jvd_se or col in jravan_columns_jvd_ra:
        jravan_normalized.append(col)
    elif col.replace("_jravan", "") in jravan_columns_jvd_se:
        jravan_normalized.append(col)

jrdb_normalized = []
for col in existing_81_columns:
    if col in jrdb_columns_jrd_kyi or col in jrdb_columns_jrd_sed:
        jrdb_normalized.append(col)
    elif col.replace("_jrdb", "") in jrdb_columns_jrd_kyi:
        jrdb_normalized.append(col)

derived_normalized = [col for col in existing_81_columns if col in derived_columns]

# 詳細分類
print("\n📊 カラム分類（詳細版）")
print("=" * 80)

# JRA-VANソース
jravan_source = []
for col in existing_81_columns:
    if "jravan" in col.lower() or col in jravan_columns_jvd_se or col in jravan_columns_jvd_ra:
        jravan_source.append(col)

# JRDBソース
jrdb_source = []
for col in existing_81_columns:
    if "jrdb" in col.lower() or col in jrdb_columns_jrd_kyi or col in jrdb_columns_jrd_sed:
        jrdb_source.append(col)

# 共通カラム（両方に存在）
common_cols = ["kaisai_nen", "kaisai_tsukihi", "keibajo_code", "kaisai_kai", 
               "kaisai_nichime", "race_bango", "umaban"]

# レース基本情報（JRA-VAN由来）
race_basic = ["kaisai_nen", "kaisai_tsukihi", "keibajo_code", "kaisai_kai", 
              "kaisai_nichime", "race_bango", "month", "race_date_int", 
              "grade_code", "hasso_jikoku", "keibajo_season_code"]

# 馬基本情報
horse_basic = ["umaban", "ketto_toroku_bango_jravan", "ketto_toroku_bango_jrdb", 
               "wakuban", "seibetsu_code", "barei"]

# レース条件（JRA-VAN由来）
race_conditions = ["kyori", "track_code", "tenko_code", "babajotai_code_shiba", 
                   "babajotai_code_dirt", "shusso_tosu"]

# 馬体重・装備（JRA-VAN由来）
horse_weight = ["bataiju_jravan", "bataiju_jrdb", "zogen_sa", "bataiju_zogen", 
                "blinker_shiyo_kubun"]

# 騎手・厩舎（JRA-VAN由来）
jockey_trainer = ["kishumei_ryakusho"]

# JRDB指数（jrd_kyi由来）
jrdb_indices = ["idm", "kishu_shisu", "joho_shisu", "sogo_shisu", "chokyo_shisu", 
                "kyusha_shisu", "gekiso_shisu", "ninki_shisu", "ten_shisu", 
                "pace_shisu", "agari_shisu", "ichi_shisu", "manken_shisu", 
                "shiage_shisu", "uma_start_shisu", "ls_shisu"]

# JRDB評価・コード（jrd_kyi由来）
jrdb_codes = ["chokyo_yajirushi_code", "kyusha_hyoka_code", "chokyo_hyoka", 
              "kyakushitsu_code", "kyori_tekisei_code", "joshodo_code", 
              "tekisei_code_omo", "hizume_code", "class_code", "ls_hyoka", "em"]

# JRDB予測・確率（jrd_kyi由来）
jrdb_forecast = ["pace_yoso", "kishu_kitai_rentai_ritsu", "uma_deokure_ritsu"]

# JRDB厩舎・ローテーション（jrd_kyi由来）
jrdb_stable = ["rotation", "hobokusaki_rank", "kyusha_rank", "kyusha_bb_shirushi", 
               "kishu_bb_shirushi", "kyusha_bb_nijumaru_tansho_kaishuritsu", "cid"]

# JRDB過去走（jrd_sed由来 + 派生）
jrdb_past_race = ["prev1_rank", "prev1_time", "prev1_last_3f", "prev1_pace", 
                  "prev1_deokure", "prev1_furi", "prev1_furi_1", "prev1_furi_2", 
                  "prev1_furi_3", "prev1_batai_code", "past5_rank_avg", 
                  "past5_rank_best", "past5_time_avg"]

# ターゲット変数
target = ["target_top3"]

# その他
others = ["race_shikonen"]

print(f"\n1️⃣ レース基本情報（JRA-VAN由来）: {len(race_basic)}カラム")
print(f"   {', '.join(race_basic)}")

print(f"\n2️⃣ 馬基本情報（JRA-VAN + JRDB）: {len(horse_basic)}カラム")
print(f"   {', '.join(horse_basic)}")

print(f"\n3️⃣ レース条件（JRA-VAN由来）: {len(race_conditions)}カラム")
print(f"   {', '.join(race_conditions)}")

print(f"\n4️⃣ 馬体重・装備（JRA-VAN + JRDB）: {len(horse_weight)}カラム")
print(f"   {', '.join(horse_weight)}")

print(f"\n5️⃣ 騎手・厩舎（JRA-VAN由来）: {len(jockey_trainer)}カラム")
print(f"   {', '.join(jockey_trainer)}")

print(f"\n6️⃣ JRDB指数（jrd_kyi由来）: {len(jrdb_indices)}カラム")
print(f"   {', '.join(jrdb_indices)}")

print(f"\n7️⃣ JRDB評価・コード（jrd_kyi由来）: {len(jrdb_codes)}カラム")
print(f"   {', '.join(jrdb_codes)}")

print(f"\n8️⃣ JRDB予測・確率（jrd_kyi由来）: {len(jrdb_forecast)}カラム")
print(f"   {', '.join(jrdb_forecast)}")

print(f"\n9️⃣ JRDB厩舎・ローテーション（jrd_kyi由来）: {len(jrdb_stable)}カラム")
print(f"   {', '.join(jrdb_stable)}")

print(f"\n🔟 JRDB過去走（jrd_sed由来 + 派生）: {len(jrdb_past_race)}カラム")
print(f"   {', '.join(jrdb_past_race)}")

print(f"\n1️⃣1️⃣ ターゲット変数: {len(target)}カラム")
print(f"   {', '.join(target)}")

print(f"\n1️⃣2️⃣ その他: {len(others)}カラム")
print(f"   {', '.join(others)}")

# 総計検証
total_categorized = (len(race_basic) + len(horse_basic) + len(race_conditions) + 
                     len(horse_weight) + len(jockey_trainer) + len(jrdb_indices) + 
                     len(jrdb_codes) + len(jrdb_forecast) + len(jrdb_stable) + 
                     len(jrdb_past_race) + len(target) + len(others))

print("\n" + "=" * 80)
print(f"📊 カテゴリ別総計: {total_categorized}カラム")

# ソース別集計
jravan_count = (len(race_basic) + len([c for c in horse_basic if 'jravan' in c]) + 
                len(race_conditions) + len([c for c in horse_weight if 'jravan' in c]) + 
                len(jockey_trainer))

jrdb_kyi_count = (len(jrdb_indices) + len(jrdb_codes) + len(jrdb_forecast) + 
                  len(jrdb_stable) + len([c for c in horse_basic if 'jrdb' in c]) + 
                  len([c for c in horse_weight if 'jrdb' in c]) + len(others))

jrdb_sed_count = len([c for c in jrdb_past_race if c.startswith('prev1_')])

derived_count = len([c for c in jrdb_past_race if 'past5_' in c or c == 'prev1_rank' or c == 'prev1_time' or c == 'prev1_last_3f']) + len(target)

print("\n🎯 ソース別内訳:")
print(f"   📘 JRA-VAN由来: 約{jravan_count}カラム")
print(f"   📗 JRDB jrd_kyi由来: 約{jrdb_kyi_count}カラム")
print(f"   📙 JRDB jrd_sed由来: 約{jrdb_sed_count}カラム")
print(f"   📕 派生カラム: 約{derived_count}カラム")

print("\n" + "=" * 80)
print("✅ 分析完了")
