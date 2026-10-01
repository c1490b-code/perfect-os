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
