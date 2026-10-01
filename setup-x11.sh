#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"

echo "=== PERFECT OS -> TERMUX:X11 ==="

pkg update -y

pkg install -y \
  termux-x11-nightly \
  x11-repo \
  pulseaudio \
  dbus \
  proot \
  proot-distro \
  git \
  python \
  clang \
  make \
  cmake \
  pkg-config \
  mesa \
  mesa-demos \
  xorg-xhost

mkdir -p "$ROOT/x11"/{bin,apps,desktop,config,runtime,logs,share}

cat > "$ROOT/x11/config/environment.sh" <<ENV
export PERFECT_OS_ROOT="$ROOT"
export PERFECT_OS_X11=1
export DISPLAY=:0
export XDG_RUNTIME_DIR="\$PREFIX/tmp/runtime"
export LIBGL_ALWAYS_SOFTWARE=1
ENV

mkdir -p "$PREFIX/tmp/runtime"
chmod 700 "$PREFIX/tmp/runtime"

cat > "$ROOT/x11/bin/start-perfect-os-x11" <<'START'
#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"

export PERFECT_OS_ROOT="$ROOT"
export PERFECT_OS_X11=1
export DISPLAY=:0
export XDG_RUNTIME_DIR="$PREFIX/tmp/runtime"

mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

echo "=== PERFECT OS X11 SESSION ==="
echo "ROOT    : $PERFECT_OS_ROOT"
echo "DISPLAY : $DISPLAY"
echo "ARCH    : $(uname -m)"
echo "OS      : $(uname -o 2>/dev/null || uname -s)"

if command -v termux-x11 >/dev/null 2>&1; then
    echo "Termux:X11 command: OK"
else
    echo "Termux:X11 command not found"
fi

echo
echo "Starting PERFECT OS X11 environment..."

if command -v xclock >/dev/null 2>&1; then
    xclock >/dev/null 2>&1 &
fi

echo
echo "=== X11 READY ==="
echo "PERFECT OS workspace: $ROOT"
START

chmod +x "$ROOT/x11/bin/start-perfect-os-x11"

cat > "$ROOT/x11/README.md" <<'DOC'
# PERFECT OS — Termux:X11

Graphical user-space layer for PERFECT OS running through
Termux:X11 on Android.

The underlying device in the current environment is ARM64/AArch64.

Layers:

Android
  -> Termux
  -> Termux:X11
  -> PERFECT OS user space
  -> devices/
  -> electronics/
  -> AI/
  -> applications/
DOC

echo
echo "=== X11 INSTALLATION COMPLETE ==="
echo
echo "Start Termux:X11 with:"
echo
echo "  termux-x11 :0 &"
echo
echo "Then start PERFECT OS:"
echo
echo "  $ROOT/x11/bin/start-perfect-os-x11"
