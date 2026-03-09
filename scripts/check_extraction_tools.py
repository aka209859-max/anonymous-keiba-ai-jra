#!/usr/bin/env python3
"""
利用可能な解凍ツール・ライブラリのチェック
"""
import subprocess
import sys

print("=== Checking Extraction Tools ===\n")

# 1. External commands
commands = ["7z", "lha", "lzma", "unlha"]
print("External Commands:")
for cmd in commands:
    try:
        result = subprocess.run(
            [cmd, "--help"],
            capture_output=True,
            timeout=2,
            shell=False
        )
        print(f"  ✓ {cmd}: Available")
    except FileNotFoundError:
        print(f"  ✗ {cmd}: Not found")
    except Exception as e:
        print(f"  ? {cmd}: {e}")

print("\nPython Modules:")
# 2. Python modules
modules = ["patool", "pylzma", "lzma", "zipfile", "tarfile"]
for mod in modules:
    try:
        __import__(mod)
        print(f"  ✓ {mod}: Installed")
    except ImportError:
        print(f"  ✗ {mod}: Not installed")

print("\n=== Recommendation ===")
print("Run: pip install patool")
print("Or install 7-Zip from: https://www.7-zip.org/")
