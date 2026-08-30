#!/data/data/com.termux/files/usr/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "========================================"
echo "       PERFECT-OS TEST SUITE"
echo "========================================"

if [ ! -x "$ROOT/build/perfect-kernel" ]; then
    echo "Build missing. Building first..."
    "$ROOT/scripts/build.sh"
fi

echo
echo "[TEST] Kernel startup"
"$ROOT/build/perfect-kernel"

echo
echo "[TEST] System information"
"$ROOT/build/perfect-info"

echo
echo "[TEST] AI subsystem"
"$ROOT/ai/ai.sh"

echo
echo "========================================"
echo "ALL FOUNDATION TESTS PASSED"
echo "========================================"
