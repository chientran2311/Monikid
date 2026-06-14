#!/usr/bin/env bash
# push_gemma_to_emulator.sh
#
# Pushes local model file into the running Android emulator's app documents directory.
# Uses `adb root` (works on emulators) for a reliable direct push — avoids run-as
# cp which silently fails on some emulator configs.
#
# Usage:
#   bash scripts/push_gemma_to_emulator.sh
#
# Requirements: adb in PATH (Android SDK platform-tools)
# Works on: Git Bash / WSL / macOS / Linux

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PACKAGE="com.example.monikid"
APP_USER="u0_a141"
MODEL_FILENAME="gemma-4-E2B-it.litertlm"
# Bash-style path (for file existence check, wc, etc.)
LOCAL_CACHE="/d/Flutter/project/gemma-4-E2B-it.litertlm"
# Windows-style path passed to adb push (MSYS_NO_PATHCONV blocks bash conversion)
LOCAL_CACHE_WIN="D:/Flutter/project/gemma-4-E2B-it.litertlm"
# Flutter path_provider getApplicationDocumentsDirectory() on Android = app_flutter/
# Verified from device logs: /data/data/<package>/app_flutter/
DEVICE_DIR="/data/data/$PACKAGE/app_flutter"
# ─────────────────────────────────────────────────────────────────────────────

echo "=== Model → emulator push script ==="
echo ""

# ── 1. Check adb ──────────────────────────────────────────────────────────────
if ! command -v adb &>/dev/null; then
  echo "ERROR: adb not found. Add Android SDK platform-tools to your PATH."
  echo "  Windows example: export PATH=\$PATH:\$HOME/AppData/Local/Android/Sdk/platform-tools"
  exit 1
fi

# ── 2. Detect running emulator ────────────────────────────────────────────────
DEVICE=$(adb devices 2>/dev/null | awk 'NR>1 && /emulator/ && $2=="device" {print $1; exit}')
if [[ -z "$DEVICE" ]]; then
  echo "ERROR: No running emulator detected."
  echo "  Start an emulator first (Android Studio → Device Manager → Play)."
  adb devices
  exit 1
fi
echo "→ Emulator: $DEVICE"

# ── 3. Verify local file exists ───────────────────────────────────────────────
if [[ ! -f "$LOCAL_CACHE" ]]; then
  echo "ERROR: Model file not found at $LOCAL_CACHE"
  echo "  Expected: D:\\Flutter\\project\\gemma-4-E2B-it.litertlm"
  exit 1
fi
SIZE_BYTES=$(wc -c < "$LOCAL_CACHE")
SIZE_GB=$(awk "BEGIN {printf \"%.3f\", $SIZE_BYTES / 1000000000}")
echo "→ Model file: $LOCAL_CACHE (${SIZE_GB} GB)"

# ── 4. Root adb (emulator only) + push directly ───────────────────────────────
# run-as cp silently fails on many emulator configs — root push is reliable.
echo ""
echo "→ Restarting adb as root ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" root
sleep 2

echo "→ Pushing directly to $DEVICE_DIR/$MODEL_FILENAME ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" push "$LOCAL_CACHE_WIN" "$DEVICE_DIR/$MODEL_FILENAME"

echo "→ Setting ownership and permissions ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell chown "$APP_USER:$APP_USER" "$DEVICE_DIR/$MODEL_FILENAME"
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell chmod 644 "$DEVICE_DIR/$MODEL_FILENAME"

# ── 5. Verify ─────────────────────────────────────────────────────────────────
echo ""
PUSHED_SIZE=$(MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell ls -la "$DEVICE_DIR/$MODEL_FILENAME" 2>/dev/null | awk '{print $5}' || echo "unknown")
echo "✓ Done."
echo "  Device path  : $DEVICE_DIR/$MODEL_FILENAME"
echo "  Size on device: $PUSHED_SIZE bytes"
echo ""
echo "Hot-restart the app — choose_ai_model_screen should show model as downloaded."
