#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
ANDROID="$ROOT/android"
X11="$ROOT/x11"
SHARED="$ROOT/shared"
RUNTIME="$ROOT/runtime"

mkdir -p "$ANDROID" "$X11" "$SHARED" "$RUNTIME"

# ------------------------------------------------------------
# ONE COMMON ENVIRONMENT
# ------------------------------------------------------------

cat > "$ROOT/perfect-os-env.sh" <<'ENV'
#!/data/data/com.termux/files/usr/bin/bash

export PERFECT_OS="$HOME/PERFECT-OS"
export PERFECT_OS_ANDROID="$PERFECT_OS/android"
export PERFECT_OS_X11="$PERFECT_OS/x11"
export PERFECT_OS_SHARED="$PERFECT_OS/shared"
export PERFECT_OS_RUNTIME="$PERFECT_OS/runtime"

export DISPLAY="${DISPLAY:-:0}"
export PATH="$PERFECT_OS/bin:$PATH"

echo "PERFECT OS UNIFIED"
echo "ROOT    = $PERFECT_OS"
echo "ANDROID = $PERFECT_OS_ANDROID"
echo "X11     = $PERFECT_OS_X11"
echo "SHARED  = $PERFECT_OS_SHARED"
echo "RUNTIME = $PERFECT_OS_RUNTIME"
echo "DISPLAY = $DISPLAY"
ENV

chmod +x "$ROOT/perfect-os-env.sh"

# ------------------------------------------------------------
# TERMUX ENTRY
# ------------------------------------------------------------

cat > "$ROOT/termux.sh" <<'TERMUX'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

cd "$PERFECT_OS"

echo "TERMUX -> PERFECT OS"
echo "Git repository:"
git remote -v
TERMUX

chmod +x "$ROOT/termux.sh"

# ------------------------------------------------------------
# TERMUX:X11 ENTRY
# ------------------------------------------------------------

cat > "$ROOT/x11/start.sh" <<'X11'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

export DISPLAY="${DISPLAY:-:0}"

cd "$PERFECT_OS"

echo "TERMUX:X11 -> PERFECT OS"
echo "DISPLAY=$DISPLAY"

if command -v xdpyinfo >/dev/null 2>&1; then
    xdpyinfo -display "$DISPLAY" >/dev/null 2>&1 &&
        echo "X11 connection: OK" ||
        echo "X11 connection: NOT AVAILABLE"
fi

exec "${SHELL:-bash}"
X11

chmod +x "$ROOT/x11/start.sh"

# ------------------------------------------------------------
# ANDROID ENTRY
# ------------------------------------------------------------

cat > "$ROOT/android/start.sh" <<'ANDROID'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

cd "$PERFECT_OS"

echo "ANDROID -> PERFECT OS"
echo "Android project: $PERFECT_OS_ANDROID"
echo "Shared project:  $PERFECT_OS_SHARED"
ANDROID

chmod +x "$ROOT/android/start.sh"

# ------------------------------------------------------------
# ANDROID STORAGE: REAL DIRECTORY, NO SYMLINK
# ------------------------------------------------------------

if [ -d "$HOME/storage/shared" ]; then
    mkdir -p "$HOME/storage/shared/PERFECT-OS"
    mkdir -p "$HOME/storage/shared/PERFECT-OS/project"
else
    echo "Android shared storage is not currently mounted."
fi

# Put a pointer/readme in shared Android storage.
cat > "$HOME/storage/shared/PERFECT-OS/README.txt" <<EOF
PERFECT OS

The canonical project is:

$ROOT

Termux:
$ROOT/termux.sh

Termux:X11:
$ROOT/x11/start.sh

Android:
$ROOT/android/start.sh

Do not delete the canonical project in Termux.
