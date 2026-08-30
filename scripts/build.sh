#!/data/data/com.termux/files/usr/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"

mkdir -p "$BUILD"

echo "========================================"
echo "       BUILDING PERFECT-OS"
echo "========================================"

echo "[1/3] Building kernel..."
cc -Wall -Wextra \
    "$ROOT/kernel/main.c" \
    -o "$BUILD/perfect-kernel"

echo "[2/3] Building system information..."
cc -Wall -Wextra \
    "$ROOT/tools/perfect-info.c" \
    -o "$BUILD/perfect-info"

echo "[3/3] Build complete."

echo
echo "Output:"
ls -lh "$BUILD"

echo
echo "PERFECT-OS build successful."
