#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
cd "$ROOT"

echo "=== PERFECT OS: ALL TOGETHER ==="

# Pull GitHub changes
git pull --rebase origin main || true

# Make the Android-visible copy point at the same project
mkdir -p "$HOME/storage/shared"
ln -sfn "$ROOT" "$HOME/storage/shared/PERFECT-OS/project"

# Record runtime state
cat > "$ROOT/runtime/unified.env" <<ENV
PERFECT_OS_ROOT=$ROOT
PERFECT_OS_SHARED=$ROOT/shared
PERFECT_OS_DISPLAY=${DISPLAY:-:0}
PERFECT_OS_UNIFIED=1
PERFECT_OS_TERMUX=1
PERFECT_OS_TERMUX_X11=1
PERFECT_OS_GITHUB=1
ENV

git add -A

if ! git diff --cached --quiet; then
    git commit -m "Unify GitHub Termux Termux-X11 Android"
    git push origin main
fi

echo
echo "=== COMPLETE ==="
echo "GitHub      -> $ROOT"
echo "Termux      -> $ROOT"
echo "Termux:X11  -> $ROOT"
echo "Android     -> $HOME/storage/shared/PERFECT-OS/project"
echo
echo "Everything is using ONE project tree."
