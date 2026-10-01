#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
ANDROID="$ROOT/android"

echo "=== PERFECT OS ANDROID -> TERMUX:X11 ==="

mkdir -p "$ANDROID"/{sdk,platform,tools,adb,build,apps,gui,runtime,config,devices,logs}

# Android/ADB tooling
pkg update -y
pkg install -y android-tools

# X11 environment
mkdir -p "$PREFIX/tmp/runtime"
chmod 700 "$PREFIX/tmp/runtime"

cat > "$ANDROID/config/environment.sh" <<ENV
export PERFECT_OS_ROOT="$ROOT"
export PERFECT_OS_ANDROID="$ANDROID"
export PERFECT_OS_X11=1
export DISPLAY=:0
export ANDROID_HOME="$ANDROID/sdk"
export ANDROID_SDK_ROOT="$ANDROID/sdk"
export PATH="$ANDROID/tools:\$ANDROID/sdk/platform-tools:\$PATH"
ENV

cat > "$ANDROID/start.sh" <<'START'
#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
ANDROID="$ROOT/android"

export PERFECT_OS_ROOT="$ROOT"
export PERFECT_OS_ANDROID="$ANDROID"
export PERFECT_OS_X11=1
export DISPLAY=:0
export ANDROID_HOME="$ANDROID/sdk"
export ANDROID_SDK_ROOT="$ANDROID/sdk"
export PATH="$ANDROID/tools:$ANDROID/sdk/platform-tools:$PATH"

mkdir -p "$ANDROID"/{sdk,platform,tools,adb,build,apps,gui,runtime,config,devices,logs}

echo "=== PERFECT OS ANDROID/X11 ==="
echo "Android layer : READY"
echo "X11 display   : $DISPLAY"
echo "Architecture  : $(uname -m)"
echo

if command -v adb >/dev/null 2>&1; then
    echo "ADB           : READY"
    adb version | head -2
else
    echo "ADB           : NOT INSTALLED"
fi

echo
echo "Android workspace:"
echo "$ANDROID"
echo
echo "=== ANDROID/X11 LAYER READY ==="
START

chmod +x "$ANDROID/start.sh"

cat > "$ANDROID/README.md" <<'DOC'
# PERFECT OS Android + Termux:X11

Android integration layer for PERFECT OS.

Host:

Android
  -> Termux
  -> Termux:X11

PERFECT OS:

  -> Android runtime/tools
  -> ADB
  -> Android applications
  -> GUI/X11
  -> Device integration

The Android directory contains PERFECT OS integration files,
not a replacement Android operating system.
DOC

echo
echo "=== ANDROID X11 LAYER CREATED ==="

"$ANDROID/start.sh"
