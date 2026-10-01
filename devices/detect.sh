#!/data/data/com.termux/files/usr/bin/bash

echo "=== PERFECT OS DEVICE DETECTION ==="
echo

ARCH="$(uname -m 2>/dev/null || echo unknown)"
OS="$(uname -o 2>/dev/null || uname -s 2>/dev/null || echo unknown)"

echo "Kernel architecture : $ARCH"
echo "Operating system     : $OS"

case "$ARCH" in
    aarch64|arm64)
        TARGET="arm64"
        ;;
    armv7*|armv8*|arm)
        TARGET="arm"
        ;;
    x86_64|amd64)
        TARGET="x86_64"
        ;;
    i386|i486|i586|i686|x86)
        TARGET="x86"
        ;;
    riscv64)
        TARGET="riscv64"
        ;;
    riscv32)
        TARGET="riscv32"
        ;;
    mips64*)
        TARGET="mips64"
        ;;
    mips*)
        TARGET="mips"
        ;;
    ppc64*)
        TARGET="ppc64"
        ;;
    ppc*)
        TARGET="ppc"
        ;;
    s390x)
        TARGET="s390x"
        ;;
    *)
        TARGET="future"
        ;;
esac

echo "PERFECT OS target    : $TARGET"
echo
echo "Device layer ready."
