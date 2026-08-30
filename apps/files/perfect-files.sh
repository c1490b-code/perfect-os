#!/bin/sh

echo "PERFECT FILE MANAGER"
echo

TARGET="${1:-$HOME/PERFECT-OS}"

if [ -d "$TARGET" ]; then
    find "$TARGET" -maxdepth 2 -type f | sort
else
    echo "Directory not found: $TARGET"
fi
