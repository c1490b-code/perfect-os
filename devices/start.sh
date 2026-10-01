#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
cd "$ROOT"

echo "=== STARTING PERFECT OS DEVICE LAYER ==="

bash devices/detect.sh

ARCH="$(uname -m 2>/dev/null || echo unknown)"

case "$ARCH" in
    aarch64|arm64)
        TARGET="arm64"
        ;;
    arm*)
        TARGET="arm"
        ;;
    x86_64|amd64)
        TARGET="x86_64"
        ;;
    x86*)
        TARGET="x86"
        ;;
    riscv64)
        TARGET="riscv64"
        ;;
    riscv32)
        TARGET="riscv32"
        ;;
    *)
        TARGET="future"
        ;;
esac

mkdir -p "devices/runtime/$TARGET"

cat > "devices/runtime/$TARGET/device.env" <<ENV
PERFECT_OS_DEVICE_ARCH=$ARCH
PERFECT_OS_DEVICE_TARGET=$TARGET
PERFECT_OS_DEVICE_ROOT=$ROOT/devices
PERFECT_OS_DEVICE_STARTED=1
ENV

echo
echo "Device architecture : $ARCH"
echo "PERFECT OS target   : $TARGET"
echo "Runtime             : devices/runtime/$TARGET"
echo
echo "=== DEVICE LAYER STARTED ==="
