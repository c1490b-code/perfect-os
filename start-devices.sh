#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/PERFECT-OS"
cd "$ROOT"

echo "=== PERFECT OS DEVICE ARCHITECTURE INITIALIZER ==="

mkdir -p devices/{arch,targets,platforms,boards,boot,firmware,drivers,hal,bus,devices,discovery,config,runtime,tools}

# CPU / ISA families
mkdir -p devices/arch/{arm,arm32,arm64,aarch64,x86,x86_64,riscv,riscv32,riscv64,mips,mips64,ppc,ppc64,loongarch,s390,s390x,wasm,portable,future}

# Device classes
mkdir -p devices/targets/{phone,tablet,desktop,laptop,server,workstation,embedded,development-board,robot,vehicle,industrial,medical,iot,wearable,virtual}

# Platforms
mkdir -p devices/platforms/{android,linux,unix,baremetal,uefi,efi,hypervisor,container,virtual}

# Common hardware
mkdir -p devices/boards/{generic,qualcomm,mediatek,samsung,google,apple,broadcom,rockchip,allwinner,nvidia,intel,amd}

# Runtime/device discovery
mkdir -p devices/discovery/{cpu,memory,pci,pcie,usb,i2c,spi,uart,gpio,storage,display,audio,network,input,camera,sensors,power,thermal}

# Starter files
for arch in \
    arm arm32 arm64 aarch64 \
    x86 x86_64 \
    riscv riscv32 riscv64 \
    mips mips64 \
    ppc ppc64 \
    loongarch \
    s390 s390x \
    wasm portable future
do
    cat > "devices/arch/$arch/README.md" <<ARCH
# PERFECT OS — $arch

Architecture/device target for PERFECT OS.

This directory contains architecture-specific boot,
HAL, runtime, firmware, and device integration code.
ARCH

    cat > "devices/arch/$arch/target.env" <<ENV
PERFECT_OS_ARCH=$arch
PERFECT_OS_DEVICE_TARGET=$arch
ENV
done

cat > devices/README.md <<'DOC'
# PERFECT OS Devices

Universal device architecture and hardware layer.

Supported architecture families include:

- ARM
- ARM32
- ARM64
- AArch64
- x86
- x86_64
- RISC-V
- RISC-V32
- RISC-V64
- MIPS
- MIPS64
- PowerPC
- PowerPC64
- LoongArch
- IBM s390/s390x
- WebAssembly
- Portable
- Future architectures

The device layer is designed so new architectures can be
added without changing the higher-level PERFECT OS services.
DOC

cat > devices/detect.sh <<'DETECT'
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
DETECT

chmod +x devices/detect.sh

cat > devices/start.sh <<'START'
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
START

chmod +x devices/start.sh

echo
echo "=== CREATED ==="
find devices -maxdepth 2 -type d | sort

echo
echo "=== STARTING CURRENT DEVICE ==="
bash devices/start.sh

echo
echo "=== DONE ==="
