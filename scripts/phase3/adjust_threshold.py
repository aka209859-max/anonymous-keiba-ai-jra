#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Phase 3 モデルの閾値調整スクリプト
見逃し率と適合率のトレードオフを確認
"""

import pandas as pd
import numpy as np
import lightgbm as lgb
from sklearn.metrics import precision_score, recall_score, f1_score, confusion_matrix

# モデル読み込み
model = lgb.Booster(model_file='models/jra_binary_model_eval.txt')

# テストデータ読み込み（2025年）
df = pd.read_csv('data/features/all_tracks_2016-2025_features.csv', dtype=str)

# （前処理は省略 - 実際にはtrain_binary_model.pyと同じ前処理が必要）

# 予測確率を取得
y_pred_proba = model.predict(X_test)
y_true = y_test

# 様々な閾値で評価
thresholds = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

print("=" * 80)
print("閾値別の性能比較")
print("=" * 80)
print(f"{'閾値':^6} {'再現率':^8} {'適合率':^8} {'F1':^8} {'見逃し率':^10}")
print("-" * 80)

for threshold in thresholds:
    y_pred = (y_pred_proba >= threshold).astype(int)
    
    precision = precision_score(y_true, y_pred)
    recall = recall_score(y_true, y_pred)
    f1 = f1_score(y_true, y_pred)
    
    cm = confusion_matrix(y_true, y_pred)
    fn = cm[1][0]  # 偽陰性
    tp = cm[1][1]  # 真陽性
    miss_rate = fn / (fn + tp) * 100  # 見逃し率
    
    print(f"{threshold:^6.1f} {recall:^8.2%} {precision:^8.2%} {f1:^8.4f} {miss_rate:^10.2f}%")

print("=" * 80)
print("\n推奨:")
print("- 本命狙い（高適合率）: 閾値 0.7")
print("- バランス型（現在）: 閾値 0.5")
print("- 穴馬拾い（低見逃し率）: 閾値 0.3")
print("- 見逃しゼロ（低適合率）: 閾値 0.1")
