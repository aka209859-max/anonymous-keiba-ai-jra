-- ============================================================================
-- JRDB データ抽出SQL
-- ============================================================================
-- 目的: JRDBデータベースから48列を抽出
-- 構成: 予測指数13 + 調教5 + 適性6 + 展開2 + ランク6 + CID/LS 7 + 調教B 2 + 過去走7 = 48列
-- 作成日: 2026-02-19
-- ============================================================================

WITH
-- ============================================================================
-- JRDB過去走データ取得CTE
-- ============================================================================
past_races_jrdb AS (
    SELECT 
        sed.ketto_toroku_bango,
        sed.pace,
        sed.deokure,
        sed.furi,
        sed.furi_1,
        sed.furi_2,
        sed.furi_3,
        sed.batai_code,
        ROW_NUMBER() OVER (
            PARTITION BY sed.ketto_toroku_bango 
            ORDER BY sed.kaisai_nen DESC, sed.kaisai_tsukihi DESC, sed.race_bango DESC
        ) AS race_order
    FROM jrd_sed sed
    WHERE sed.kakutei_chakujun ~ '^[0-9]+$'  -- 着順確定レースのみ
)

-- ============================================================================
-- メインクエリ：jrd_kyi（予想データ） + jrd_joa（CID/LS） + jrd_cyb（調教B） + jrd_sed（過去走）
-- ============================================================================
SELECT 
    -- ========================================================================
    -- キー列（結合用）
    -- ========================================================================
    kyi.kaisai_nen,
    kyi.kaisai_tsukihi,
    kyi.keibajo_code,
    kyi.race_bango,
    kyi.umaban,
    kyi.ketto_toroku_bango,
    
    -- ========================================================================
    -- E. jrd_kyi（予想データ）から選択【30カラム】
    -- ========================================================================
    
    -- E-1. 予測指数系【13カラム】
    kyi.idm,                            -- #99: IDM（スピード指数）
    kyi.kishu_shisu,                    -- #100: 騎手指数
    kyi.joho_shisu,                     -- #101: 情報指数
    kyi.sogo_shisu,                     -- #102: 総合指数
    kyi.chokyo_shisu,                   -- #103: 調教指数
    kyi.kyusha_shisu,                   -- #104: 厩舎指数
    kyi.gekiso_shisu,                   -- #105: 激走指数
    kyi.ninki_shisu,                    -- #106: 人気指数
    kyi.ten_shisu,                      -- #107: テン指数（前半のスピード能力）
    kyi.pace_shisu,                     -- #108: ペース指数（ペース対応能力）
    kyi.agari_shisu,                    -- #109: 上がり指数（後半の末脚能力）
    kyi.ichi_shisu,                     -- #110: 位置指数（位置取り能力）
    kyi.manken_shisu,                   -- #111: 万券指数（高配当期待度）
    
    -- E-2. 調教・厩舎評価系【5カラム】
    kyi.chokyo_yajirushi_code,         -- #112: 調教矢印コード（1=↑、2=→、3=↓）
    kyi.kyusha_hyoka_code,             -- #113: 厩舎評価コード（高い1～9低い）
    kyi.kishu_kitai_rentai_ritsu,      -- #114: 騎手期待連対率（%）
    cyb.shiage_shisu,                  -- #115: 仕上指数（仕上がり状態）
    cyb.chokyo_hyoka,                  -- #116: 調教評価（A～E）
    
    -- E-3. 馬の適性・状態系【6カラム】
    kyi.kyakushitsu_code,              -- #117: 脚質コード（1=逃げ、2=先行、3=差し、4=追込）
    kyi.kyori_tekisei_code,            -- #118: 距離適性コード（1=短、2=マイル、3=中、4=長、5=万能）
    kyi.joshodo_code,                  -- #119: 上昇度コード（1=AA激走、2=A、3=B、4=C、5=?）
    kyi.tekisei_code_omo,              -- #120: 適性コード(重)（重馬場適性）
    kyi.hizume_code,                   -- #121: 蹄コード（蹄の状態評価）
    kyi.class_code,                    -- #122: クラスコード（馬のクラス評価）
    
    -- E-4. 展開予想系【2カラム】
    kyi.pace_yoso,                     -- #123: ペース予想（H=ハイ、M=ミドル、S=スロー）
    kyi.uma_deokure_ritsu,             -- #124: 馬出遅れ率（出遅れの頻度%）
    
    -- E-5. ランク・その他【6カラム】
    kyi.rotation,                      -- #125: ローテーション（前走からの間隔週数）
    kyi.hobokusaki_rank,               -- #126: 放牧先ランク（A～E、Aが最高）
    kyi.kyusha_rank,                   -- #127: 厩舎ランク（高い1～9低い）
    kyi.bataiju,                       -- #128: (枠確定)馬体重（枠確定時点）
    kyi.bataiju_zogen,                 -- #129: (枠確定)馬体重増減（前走からの増減）
    kyi.uma_start_shisu,               -- #130: 馬スタート指数（スタートの巧拙評価）
    
    -- ========================================================================
    -- F. jrd_joa（CID・LS指数）から選択【7カラム】
    -- ========================================================================
    joa.cid,                           -- #131: CID（コース適性指数）
    joa.ls_shisu,                      -- #132: LS指数（レイティング指数）
    joa.ls_hyoka,                      -- #133: LS評価（A～E）
    joa.em,                            -- #134: EM（展開マーク）
    joa.kyusha_bb_shirushi,            -- #135: 厩舎BB印（◎○▲△×）
    joa.kishu_bb_shirushi,             -- #136: 騎手BB印（◎○▲△×）
    joa.kyusha_bb_nijumaru_tansho_kaishuritsu,  -- #137: 厩舎BB◎単勝回収率（%）
    
    -- ========================================================================
    -- G. jrd_sed（成績データ）から過去走用に選択【7カラム】
    -- ========================================================================
    MAX(CASE WHEN pr.race_order = 1 THEN pr.pace END) AS prev1_pace,          -- #138: 前走ペース（H=ハイ、M=ミドル、S=スロー）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.deokure END) AS prev1_deokure,    -- #139: 前走出遅れ（秒数または評価）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.furi END) AS prev1_furi,          -- #140: 前走不利（総合評価）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.furi_1 END) AS prev1_furi_1,      -- #141: 前走前不利（前半の不利）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.furi_2 END) AS prev1_furi_2,      -- #142: 前走中不利（中盤の不利）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.furi_3 END) AS prev1_furi_3,      -- #143: 前走後不利（後半の不利）
    MAX(CASE WHEN pr.race_order = 1 THEN pr.batai_code END) AS prev1_batai_code  -- #144: 前走馬体コード（1=太め、2=普通、3=細め等）

FROM jrd_kyi kyi
LEFT JOIN jrd_joa joa ON (
    kyi.kaisai_nen = joa.kaisai_nen
    AND kyi.kaisai_tsukihi = joa.kaisai_tsukihi
    AND kyi.keibajo_code = joa.keibajo_code
    AND kyi.race_bango = joa.race_bango
    AND kyi.umaban = joa.umaban
)
LEFT JOIN jrd_cyb cyb ON (
    kyi.kaisai_nen = cyb.kaisai_nen
    AND kyi.kaisai_tsukihi = cyb.kaisai_tsukihi
    AND kyi.keibajo_code = cyb.keibajo_code
    AND kyi.race_bango = cyb.race_bango
    AND kyi.umaban = cyb.umaban
)
LEFT JOIN past_races_jrdb pr ON (
    kyi.ketto_toroku_bango = pr.ketto_toroku_bango
)
WHERE kyi.kaisai_nen::INTEGER BETWEEN 2016 AND 2025  -- 抽出期間: 2016～2025年（型キャスト追加）
GROUP BY 
    kyi.kaisai_nen, kyi.kaisai_tsukihi, kyi.keibajo_code, kyi.race_bango, kyi.umaban,
    kyi.ketto_toroku_bango, kyi.idm, kyi.kishu_shisu, kyi.joho_shisu, kyi.sogo_shisu,
    kyi.chokyo_shisu, kyi.kyusha_shisu, kyi.gekiso_shisu, kyi.ninki_shisu, kyi.ten_shisu,
    kyi.pace_shisu, kyi.agari_shisu, kyi.ichi_shisu, kyi.manken_shisu, kyi.chokyo_yajirushi_code,
    kyi.kyusha_hyoka_code, kyi.kishu_kitai_rentai_ritsu, cyb.shiage_shisu, cyb.chokyo_hyoka,
    kyi.kyakushitsu_code, kyi.kyori_tekisei_code, kyi.joshodo_code, kyi.tekisei_code_omo,
    kyi.hizume_code, kyi.class_code, kyi.pace_yoso, kyi.uma_deokure_ritsu, kyi.rotation,
    kyi.hobokusaki_rank, kyi.kyusha_rank, kyi.bataiju, kyi.bataiju_zogen, kyi.uma_start_shisu,
    joa.cid, joa.ls_shisu, joa.ls_hyoka, joa.em, joa.kyusha_bb_shirushi, joa.kishu_bb_shirushi,
    joa.kyusha_bb_nijumaru_tansho_kaishuritsu
ORDER BY kyi.kaisai_nen, kyi.kaisai_tsukihi, kyi.keibajo_code, kyi.race_bango, kyi.umaban;
