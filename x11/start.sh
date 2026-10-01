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
