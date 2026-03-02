# 📋 JRDB 週次登録チェックリスト

## ✅ 毎週保存するファイル（4種類のみ）

### 土曜予測用（金曜データ）
- [ ] KYI[YYMMDD].lzh
- [ ] CYB[YYMMDD].lzh
- [ ] JOA[YYMMDD].lzh
- [ ] SED[YYMMDD].lzh

### 日曜予測用（土曜データ）
- [ ] KYI[YYMMDD].lzh
- [ ] CYB[YYMMDD].lzh
- [ ] JOA[YYMMDD].lzh
- [ ] SED[YYMMDD].lzh

**合計: 8ファイル**

---

## 🔄 週次運用フロー

### 毎週金曜夜（19:00～19:15）

#### 1. 前週のファイルをクリア (10秒)
```powershell
Remove-Item "C:\JRDB_weekly\*" -Force
```

#### 2. JRDBから今週分をダウンロード (1分)
- PC-KEIBA → JRDB個別データダウンロード
- 金曜日・土曜日の KYI/CYB/JOA/SED を選択

#### 3. C:\JRDB_weekly\ にコピー (10秒)
```powershell
$source = "C:\JRDB\"  # ダウンロード先
Copy-Item "$source\KYI*.lzh" "C:\JRDB_weekly\" -Force
Copy-Item "$source\CYB*.lzh" "C:\JRDB_weekly\" -Force
Copy-Item "$source\JOA*.lzh" "C:\JRDB_weekly\" -Force
Copy-Item "$source\SED*.lzh" "C:\JRDB_weekly\" -Force
```

#### 4. PC-KEIBAで登録 (3-5分)
```
PC-KEIBA → データ(D) → 外部データ登録
→ データファイルの保存先: C:\JRDB_weekly\
→ 「開始」ボタン
```

#### 5. 登録確認 (10秒)
```sql
-- pgAdmin で確認
SELECT COUNT(*) FROM jrd_kyi WHERE race_shikonen LIKE '[YYMMDD]%';
-- 期待値: 150-200件
```

#### 6. Phase 6予測を実行 (2分 × 2)
```powershell
cd E:\anonymous-keiba-ai-JRA
.\venv\Scripts\Activate.ps1
python scripts/phase6/phase6_daily_prediction.py --target-date [YYYYMMDD]
notepad results\predictions_[YYYYMMDD].md
```

**合計所要時間: 約10分**

---

## 📅 ファイル名早見表（2026年）

| 週 | 土曜日 | 日曜日 | 金曜データ | 土曜データ |
|:---|:------|:------|:---------|:---------|
| 02/22-23 | 02/22 | 02/23 | 260221 | 260222 |
| 03/01-02 | 03/01 | 03/02 | 260228 | 260301 |
| 03/08-09 | 03/08 | 03/09 | 260307 | 260308 |
| 03/15-16 | 03/15 | 03/16 | 260314 | 260315 |
| 03/22-23 | 03/22 | 03/23 | 260321 | 260322 |
| 03/29-30 | 03/29 | 03/30 | 260328 | 260329 |

---

## ❌ 保存不要なファイル（11種類）

Phase 6では使わないため、ダウンロード・保存不要:

```
BAC*.lzh  CHA*.lzh  KAB*.lzh  OZ*.lzh   OW*.lzh
OU*.lzh   OT*.lzh   UKC*.lzh  KKA*.lzh  ZKB*.lzh  ZED*.lzh
```

---

## 🔧 トラブルシューティング

### Q: 登録に時間がかかる（5分以上）
**A**: `C:\JRDB_weekly\` に8ファイルのみあることを確認
```powershell
ls C:\JRDB_weekly\
# 期待値: 8ファイル（KYI/CYB/JOA/SED × 2日分）
```

### Q: データが登録されていない
**A**: pgAdminで確認
```sql
SELECT 
    'KYI' as table_name, 
    COUNT(*) as count 
FROM jrd_kyi 
WHERE race_shikonen LIKE '260222%';
-- 0件の場合は再度「開始」ボタン
```

### Q: Phase 6でエラー「JRDBデータが見つかりません」
**A**: 上記SQLで件数確認 → 0件なら再登録

---

**作成日**: 2026-02-23  
**対象**: 週次JRDB登録運用
