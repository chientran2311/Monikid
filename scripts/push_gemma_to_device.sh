#!/usr/bin/env bash
# push_gemma_to_device.sh
#
# Pushes local model file into a real Android device's app documents directory.
# Strategy: push to /sdcard/ (no root needed), then run-as cp into app data dir.
# Requires: debug build of app installed, USB debugging enabled.
#
# Usage:
#   bash scripts/push_gemma_to_device.sh
#
# Requirements: adb in PATH (Android SDK platform-tools)
# Works on: Git Bash / WSL / macOS / Linux

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PACKAGE="com.example.monikid"
MODEL_FILENAME="gemma-4-E2B-it.litertlm"
# Bash-style path (for file existence check)
LOCAL_CACHE="/d/Flutter/project/gemma-4-E2B-it.litertlm"
# Windows-style path passed to adb push (MSYS_NO_PATHCONV blocks bash conversion)
LOCAL_CACHE_WIN="D:/Flutter/project/gemma-4-E2B-it.litertlm"
# Staging dir on sdcard — no root needed, all apps can write here
SDCARD_STAGE="/sdcard/Download/$MODEL_FILENAME"
# Final destination inside app sandbox
DEVICE_DIR="/data/data/$PACKAGE/app_flutter"
# ─────────────────────────────────────────────────────────────────────────────

echo "=== Model → real device push script ==="
echo ""

# ── 1. Check adb ──────────────────────────────────────────────────────────────
if ! command -v adb &>/dev/null; then
  echo "ERROR: adb not found. Add Android SDK platform-tools to your PATH."
  exit 1
fi

# ── 2. Detect connected real device (non-emulator) ───────────────────────────
DEVICE=$(adb devices 2>/dev/null | awk 'NR>1 && !/emulator/ && $2=="device" {print $1; exit}')
if [[ -z "$DEVICE" ]]; then
  echo "ERROR: No real device detected."
  echo "  Enable USB debugging on phone and authorize this computer."
  echo ""
  adb devices
  exit 1
fi
echo "→ Device: $DEVICE"

# ── 3. Verify local file ─────────────────────────────────────────────────────
if [[ ! -f "$LOCAL_CACHE" ]]; then
  echo "ERROR: Model file not found at $LOCAL_CACHE"
  exit 1
fi
SIZE_BYTES=$(wc -c < "$LOCAL_CACHE")
SIZE_GB=$(awk "BEGIN {printf \"%.3f\", $SIZE_BYTES / 1000000000}")
echo "→ Model file: $LOCAL_CACHE (${SIZE_GB} GB)"

# ── 4. Check available storage on device ─────────────────────────────────────
AVAIL_KB=$(adb -s "$DEVICE" shell df /sdcard 2>/dev/null | awk 'NR==2{print $4}' || echo "unknown")
echo "→ sdcard available: ~${AVAIL_KB} KB"

# ── 5. Push to sdcard staging area ───────────────────────────────────────────
echo ""
echo "→ Pushing to sdcard staging ($SDCARD_STAGE) ..."
echo "  This will take a while for a 2.5 GB file ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" push "$LOCAL_CACHE_WIN" "$SDCARD_STAGE"
echo "→ Push to sdcard complete."

# ── 6. Copy from sdcard into app sandbox via run-as ──────────────────────────
# Strategy: sdcard files have -rw-rw---- (shell:shell) — run-as app user can't read them.
# Fix: chmod 644 (world-readable) in /data/local/tmp/ first, then run-as cp.
echo ""
echo "→ Staging to /data/local/tmp/ (shell user, readable by all) ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell cp "$SDCARD_STAGE" "/data/local/tmp/$MODEL_FILENAME"
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell chmod 644 "/data/local/tmp/$MODEL_FILENAME"

echo "→ Copying from /data/local/tmp into app documents via run-as ..."
echo "  (requires debug build — fails on release APK)"
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell run-as "$PACKAGE" \
  cp "/data/local/tmp/$MODEL_FILENAME" "$DEVICE_DIR/$MODEL_FILENAME"
echo "→ Copy complete."

echo "→ Removing /data/local/tmp staging file ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell rm "/data/local/tmp/$MODEL_FILENAME"

# ── 7. Clean up sdcard staging file ──────────────────────────────────────────
echo ""
echo "→ Removing sdcard staging file ..."
MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell rm "$SDCARD_STAGE"

# ── 8. Verify ─────────────────────────────────────────────────────────────────
echo ""
PUSHED_SIZE=$(MSYS_NO_PATHCONV=1 adb -s "$DEVICE" shell run-as "$PACKAGE" \
  ls -la "$DEVICE_DIR/$MODEL_FILENAME" 2>/dev/null | awk '{print $5}' || echo "unknown")
echo "✓ Done."
echo "  Device path  : $DEVICE_DIR/$MODEL_FILENAME"
echo "  Size on device: $PUSHED_SIZE bytes"
echo ""
echo "Hot-restart the app — choose_ai_model_screen should show model as downloaded."
