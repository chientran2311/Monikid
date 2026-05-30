#!/usr/bin/env bash
# push_gemma_to_emulator.sh
#
# Downloads the Gemma model once to ~/.gemma_models/ (local cache),
# then pushes it into the running Android emulator's app documents directory.
#
# Usage:
#   bash scripts/push_gemma_to_emulator.sh
#
# Requirements: adb in PATH (Android SDK platform-tools)
# Works on: Git Bash / WSL / macOS / Linux

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PACKAGE="com.example.monikid"
MODEL_FILENAME="Qwen2.5-1.5B-Instruct_seq128_q8_ekv1280.task"
# Bash-style path (for file existence check, wc, etc.)
LOCAL_CACHE="/d/Flutter/project/Qwen2.5-1.5B-Instruct_seq128_q8_ekv1280.task"
# Windows-style path passed to adb push (MSYS_NO_PATHCONV blocks bash conversion)
LOCAL_CACHE_WIN="D:/Flutter/project/Qwen2.5-1.5B-Instruct_seq128_q8_ekv1280.task"
# Flutter path_provider getApplicationDocumentsDirectory() on Android = app_flutter/
# NOT files/ — verified from device logs: /data/user/0/<package>/app_flutter/
DEVICE_DIR="/data/data/$PACKAGE/app_flutter"
# ─────────────────────────────────────────────────────────────────────────────

echo "=== Gemma model → emulator push script ==="
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
  echo "  Expected: D:\\Flutter\\project\\gemma3-1b-it-int4.task"
  exit 1
fi
SIZE_BYTES=$(wc -c < "$LOCAL_CACHE")
SIZE_GB=$(awk "BEGIN {printf \"%.3f\", $SIZE_BYTES / 1000000000}")
echo "→ Model file: $LOCAL_CACHE (${SIZE_GB} GB)"

# ── 4. Push via /sdcard/ staging (works on non-rooted emulators) ──────────────
# MSYS_NO_PATHCONV=1 prevents Git Bash from converting /sdcard/ → Windows path
# /data/local/tmp is world-readable → run-as can copy from it (unlike /sdcard/ on Android 10+)
TMP_STAGING="/data/local/tmp/$MODEL_FILENAME"

echo ""
echo "→ Pushing to emulator (staging via /data/local/tmp/) ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" push "$LOCAL_CACHE_WIN" "$TMP_STAGING"

echo "→ Moving into app documents directory: $DEVICE_DIR/$MODEL_FILENAME"
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell run-as "$PACKAGE" mkdir -p app_flutter
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell run-as "$PACKAGE" cp "$TMP_STAGING" "app_flutter/$MODEL_FILENAME"

echo "→ Cleaning up staging file ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell rm "$TMP_STAGING"

# ── 5. Verify ─────────────────────────────────────────────────────────────────
echo ""
PUSHED_SIZE=$(MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell run-as "$PACKAGE" \
  sh -c "ls -l app_flutter/$MODEL_FILENAME 2>/dev/null | awk '{print \$5}'" || echo "unknown")
echo "✓ Done."
echo "  Device path : $DEVICE_DIR/$MODEL_FILENAME"
echo "  Size on device: $PUSHED_SIZE bytes"
echo ""
echo "Hot-restart the app — choose_ai_model_screen should show model as downloaded."
