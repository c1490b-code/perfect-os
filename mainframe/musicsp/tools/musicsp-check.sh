#!/data/data/com.termux/files/usr/bin/bash

echo "=== PERFECT-OS MUSIC/SP CHECK ==="

echo
echo "Architecture:"
uname -m

echo
echo "QEMU:"
command -v qemu-system-s390x || echo "qemu-system-s390x: not installed"

echo
echo "Hercules:"
command -v hercules || echo "hercules: not installed"

echo
echo "MUSIC/SP media:"
find "$(dirname "$0")/../images" -type f -maxdepth 1 2>/dev/null || true

echo
echo "Configuration:"
cat "$(dirname "$0")/../config/musicsp.env"

echo
echo "=== END ==="
