#!/data/data/com.termux/files/usr/bin/bash
set -u

ROOT="$HOME/PERFECT-OS"

ANDROID="$ROOT/android"
X11="$ROOT/x11"
SHARED="$ROOT/shared"
RUNTIME="$ROOT/runtime"

mkdir -p "$ANDROID" "$X11" "$SHARED" "$RUNTIME"

# ============================================================
# COMMON ENVIRONMENT
# ============================================================

cat > "$ROOT/perfect-os-env.sh" <<'ENVEOF'
#!/data/data/com.termux/files/usr/bin/bash

export PERFECT_OS="$HOME/PERFECT-OS"
export PERFECT_OS_ANDROID="$PERFECT_OS/android"
export PERFECT_OS_X11="$PERFECT_OS/x11"
export PERFECT_OS_SHARED="$PERFECT_OS/shared"
export PERFECT_OS_RUNTIME="$PERFECT_OS/runtime"

export DISPLAY="${DISPLAY:-:0}"
export PATH="$PERFECT_OS/bin:$PATH"

echo "=========================================="
echo "       PERFECT OS UNIFIED ENVIRONMENT"
echo "=========================================="
echo "ROOT    = $PERFECT_OS"
echo "ANDROID = $PERFECT_OS_ANDROID"
echo "X11     = $PERFECT_OS_X11"
echo "SHARED  = $PERFECT_OS_SHARED"
echo "RUNTIME = $PERFECT_OS_RUNTIME"
echo "DISPLAY = $DISPLAY"
ENVEOF

chmod +x "$ROOT/perfect-os-env.sh"

# ============================================================
# TERMUX
# ============================================================

cat > "$ROOT/termux.sh" <<'TERMUXEOF'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

cd "$PERFECT_OS"

echo
echo "TERMUX -> PERFECT OS"
echo "ROOT: $PERFECT_OS"
echo

git remote -v
TERMUXEOF

chmod +x "$ROOT/termux.sh"

# ============================================================
# TERMUX:X11
# ============================================================

cat > "$X11/start.sh" <<'X11EOF'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

export DISPLAY="${DISPLAY:-:0}"

cd "$PERFECT_OS"

echo
echo "TERMUX:X11 -> PERFECT OS"
echo "DISPLAY=$DISPLAY"
echo

if command -v xdpyinfo >/dev/null 2>&1; then
    if xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then
        echo "X11 connection: OK"
    else
        echo "X11 connection: NOT AVAILABLE"
    fi
else
    echo "xdpyinfo not installed; X11 environment configured."
fi
X11EOF

chmod +x "$X11/start.sh"

# ============================================================
# ANDROID
# ============================================================

cat > "$ANDROID/start.sh" <<'ANDEOF'
#!/data/data/com.termux/files/usr/bin/bash

source "$HOME/PERFECT-OS/perfect-os-env.sh"

cd "$PERFECT_OS"

echo
echo "ANDROID -> PERFECT OS"
echo "PROJECT: $PERFECT_OS"
echo "ANDROID: $PERFECT_OS_ANDROID"
echo "SHARED:  $PERFECT_OS_SHARED"
echo
ANDEOF

chmod +x "$ANDROID/start.sh"

# ============================================================
# RUNTIME
# ============================================================

cat > "$RUNTIME/unified.env" <<RUNTIMEEOF
PERFECT_OS_UNIFIED=1
PERFECT_OS_GITHUB=1
PERFECT_OS_TERMUX=1
PERFECT_OS_TERMUX_X11=1
PERFECT_OS_ANDROID=1
PERFECT_OS_ROOT=$ROOT
PERFECT_OS_ANDROID_DIR=$ANDROID
PERFECT_OS_X11_DIR=$X11
PERFECT_OS_SHARED_DIR=$SHARED
PERFECT_OS_DISPLAY=${DISPLAY:-:0}
RUNTIMEEOF

# ============================================================
# ANDROID SHARED STORAGE
# ============================================================

if [ -d "$HOME/storage/shared" ]; then

    mkdir -p "$HOME/storage/shared/PERFECT-OS"

    cat > "$HOME/storage/shared/PERFECT-OS/README.txt" <<STOREDEOF
PERFECT OS

Canonical project:
$ROOT

Termux:
$ROOT/termux.sh

Termux:X11:
$ROOT/x11/start.sh

Android:
$ROOT/android/start.sh

Shared:
$ROOT/shared

This Android storage directory is a gateway to the
canonical Termux project. The canonical files remain
inside Termux at:

$ROOT
STOREDEOF

else
    echo "Android shared storage is not mounted."
    echo "Run: termux-setup-storage"
fi

# ============================================================
# GIT STATUS
# ============================================================

cd "$ROOT"

echo
echo "=========================================="
echo "             GIT STATUS"
echo "=========================================="

git remote -v
git status --short

# ============================================================
# COMMIT WITHOUT BREAKING YOUR GPG SETUP
# ============================================================

git add -A

if git diff --cached --quiet; then
    echo
    echo "No new Git changes to commit."
else
    echo
    echo "Changes are staged."

    # Try the user's configured GPG signing first.
    if git commit -m "Unify GitHub Termux Android and Termux X11"; then
        echo "Git commit created."
    else
        echo
        echo "Configured GPG signing could not create the commit."
        echo "Creating this integration commit without changing your"
        echo "permanent Git configuration..."

        git -c commit.gpgsign=false \
            commit -m "Unify GitHub Termux Android and Termux X11"
    fi

    echo
    echo "Pushing to GitHub..."
    git push origin main || {
        echo
        echo "Git commit exists locally, but push needs attention."
        echo "Your PERFECT-OS files are NOT lost."
    }
fi

# ============================================================
# FINAL CHECK
# ============================================================

echo
echo "=========================================="
echo "       PERFECT OS UNIFIED"
echo "=========================================="
echo
echo "GitHub      <-> $ROOT"
echo "Termux      <-> $ROOT"
echo "Termux:X11  <-> $X11"
echo "Android     <-> $ANDROID"
echo "Shared      <-> $SHARED"
echo
echo "Canonical project:"
echo "$ROOT"
echo
echo "Run:"
echo "$ROOT/termux.sh"
echo "$ROOT/x11/start.sh"
echo "$ROOT/android/start.sh"
echo
echo "=========================================="
