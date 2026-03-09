#!/usr/bin/env python3
"""
JRDB LZHファイル解凍スクリプト
E:\anonymous-keiba-ai-JRA\data\jrdb\raw\JRDB_weekly のLZHファイルを解凍

使用方法:
  python scripts/extract_jrdb_lzh.py
  python scripts/extract_jrdb_lzh.py --install-patool
"""
import os
import sys
import subprocess
from pathlib import Path

def install_patool():
    """patoolをインストール"""
    print("Installing patool...")
    try:
        subprocess.run(
            [sys.executable, "-m", "pip", "install", "patool"],
            check=True
        )
        print("✓ patool installed successfully")
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ Failed to install patool: {e}")
        return False

def extract_with_patool(lzh_dir: Path):
    """patoolを使用してLZHを解凍"""
    try:
        import patool
    except ImportError:
        print("ERROR: patool not installed")
        print("Run: python scripts/extract_jrdb_lzh.py --install-patool")
        return False
    
    lzh_files = sorted(lzh_dir.glob("*.lzh"))
    if not lzh_files:
        print(f"ERROR: *.lzh files not found in {lzh_dir}")
        return False
    
    print(f"✓ Using patool to extract {len(lzh_files)} files")
    
    os.chdir(lzh_dir)
    success_count = 0
    
    for lzh_file in lzh_files:
        print(f"\nExtracting: {lzh_file.name}")
        try:
            patool.extract_archive(
                str(lzh_file),
                outdir=str(lzh_dir),
                verbosity=-1
            )
            print(f"  ✓ Success: {lzh_file.name}")
            success_count += 1
        except Exception as e:
            print(f"  ✗ Failed: {lzh_file.name} - {e}")
    
    print(f"\n=== Extraction Summary ===")
    print(f"Total LZH files: {len(lzh_files)}")
    print(f"Successfully extracted: {success_count}")
    
    # 解凍されたTXTファイルを確認
    txt_files = sorted(lzh_dir.glob("*.txt"))
    print(f"\n=== Extracted TXT Files ===")
    for txt in txt_files:
        size_kb = txt.stat().st_size / 1024
        print(f"  {txt.name:30} {size_kb:>10.1f} KB")
    
    return success_count > 0

def extract_with_subprocess(lzh_dir: Path):
    """
    外部コマンドでLZH解凍を試みる
    優先順位: 7z > lha
    """
    lzh_files = sorted(lzh_dir.glob("*.lzh"))
    if not lzh_files:
        print("ERROR: *.lzh files not found in", lzh_dir)
        return False
    
    # 7-Zipの標準的なインストールパス
    seven_zip_paths = [
        r"C:\Program Files\7-Zip\7z.exe",
        r"C:\Program Files (x86)\7-Zip\7z.exe",
    ]
    
    extractor = None
    extractor_cmd = None
    
    # 7-Zipを探す
    for path in seven_zip_paths:
        if Path(path).exists():
            extractor = "7z"
            extractor_cmd = [path, "x", "-y"]
            print(f"✓ Using 7-Zip: {path}")
            break
    
    # PATH内のコマンドを試す
    if not extractor:
        commands = [
            ["7z", "x", "-y"],
            ["lha", "x"],
        ]
        
        for cmd in commands:
            try:
                result = subprocess.run(
                    [cmd[0], "--help"],
                    capture_output=True,
                    timeout=2
                )
                if result.returncode in (0, 1):
                    extractor = cmd[0]
                    extractor_cmd = cmd
                    print(f"✓ Using extractor: {cmd[0]}")
                    break
            except (FileNotFoundError, subprocess.TimeoutExpired):
                continue
    
    if not extractor:
        print("ERROR: No LZH extractor found")
        print("\nPlease install one of the following:")
        print("  1. 7-Zip: https://www.7-zip.org/")
        print("  2. patool: pip install patool")
        return False
    
    # 解凍実行
    os.chdir(lzh_dir)
    success_count = 0
    
    for lzh_file in lzh_files:
        print(f"\nExtracting: {lzh_file.name}")
        try:
            result = subprocess.run(
                extractor_cmd + [str(lzh_file)],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode == 0:
                print(f"  ✓ Success: {lzh_file.name}")
                success_count += 1
            else:
                print(f"  ✗ Failed: {lzh_file.name}")
                if result.stderr:
                    print(f"    STDERR: {result.stderr[:200]}")
        
        except subprocess.TimeoutExpired:
            print(f"  ✗ Timeout: {lzh_file.name}")
        except Exception as e:
            print(f"  ✗ Error: {e}")
    
    print(f"\n=== Extraction Summary ===")
    print(f"Total LZH files: {len(lzh_files)}")
    print(f"Successfully extracted: {success_count}")
    
    # 解凍されたTXTファイルを確認
    txt_files = sorted(lzh_dir.glob("*.txt"))
    print(f"\n=== Extracted TXT Files ===")
    for txt in txt_files:
        size_kb = txt.stat().st_size / 1024
        print(f"  {txt.name:30} {size_kb:>10.1f} KB")
    
    return success_count > 0


def main():
    # コマンドライン引数の処理
    if len(sys.argv) > 1 and sys.argv[1] == "--install-patool":
        if install_patool():
            print("\n✓ Now run: python scripts/extract_jrdb_lzh.py")
            sys.exit(0)
        else:
            sys.exit(1)
    
    # LZHファイルのディレクトリ（Eドライブを想定）
    lzh_dir = Path("E:/anonymous-keiba-ai-JRA/data/jrdb/raw/JRDB_weekly")
    
    # コマンドライン引数でパスを上書き可能
    if len(sys.argv) > 1:
        lzh_dir = Path(sys.argv[1])
    
    if not lzh_dir.exists():
        print(f"ERROR: Directory not found: {lzh_dir}")
        print("\nUsage:")
        print(f"  python {Path(__file__).name} [LZH_DIRECTORY]")
        print(f"  python {Path(__file__).name} --install-patool")
        print("\nExample:")
        print(f"  python {Path(__file__).name} E:/anonymous-keiba-ai-JRA/data/jrdb/raw/JRDB_weekly")
        sys.exit(1)
    
    print(f"=== JRDB LZH Extractor ===")
    print(f"Target directory: {lzh_dir}")
    
    # patoolを優先的に試す
    try:
        import patool
        print("✓ patool detected, using it...")
        success = extract_with_patool(lzh_dir)
    except ImportError:
        print("⚠ patool not found, trying external commands...")
        success = extract_with_subprocess(lzh_dir)
    
    if success:
        print("\n✓ Extraction completed successfully!")
        print("\nNext steps:")
        print("  1. Verify TXT files in the directory")
        print("  2. Run PostgreSQL import script")
        sys.exit(0)
    else:
        print("\n✗ Extraction failed")
        print("\nTry one of these solutions:")
        print("  1. Install patool: python scripts/extract_jrdb_lzh.py --install-patool")
        print("  2. Install 7-Zip: https://www.7-zip.org/")
        sys.exit(1)


if __name__ == "__main__":
    main()
