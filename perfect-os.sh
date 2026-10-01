#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"

export PERFECT_OS="$ROOT"
export PERFECT_OS_SHARED="$ROOT/shared"
export DISPLAY="${DISPLAY:-:0}"
export PATH="$ROOT/bin:$PATH"

mkdir -p "$ROOT/shared" "$ROOT/runtime"

echo "======================================"
echo "        PERFECT OS UNIFIED"
echo "======================================"
echo "GitHub  <-> Termux <-> Termux:X11"
echo
echo "ROOT   : $ROOT"
echo "SHARED : $PERFECT_OS_SHARED"
echo "DISPLAY: $DISPLAY"
echo

cd "$ROOT"

echo "Git:"
git remote -v 2>/dev/null || true

echo
echo "Project tree:"
find "$ROOT" -maxdepth 2 -type d \
    ! -path "$ROOT/.git*" | sort | head -100

echo
echo "All systems use:"
echo "$ROOT"
