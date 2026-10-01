#!/data/data/com.termux/files/usr/bin/bash

export PERFECT_OS="$HOME/PERFECT-OS"
export PERFECT_OS_SHARED="$PERFECT_OS/shared"
export DISPLAY="${DISPLAY:-:0}"

export PATH="$PERFECT_OS/bin:$PATH"

echo "PERFECT OS"
echo "Project : $PERFECT_OS"
echo "Shared  : $PERFECT_OS_SHARED"
echo "Display : $DISPLAY"
