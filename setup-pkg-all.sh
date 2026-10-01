#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "=== PERFECT OS PKG: GOOGLE / ANDROID + ALL TARGETS ==="

pkg update -y
pkg upgrade -y

# Core Termux tools
pkg install -y \
  bash \
  coreutils \
  findutils \
  grep \
  sed \
  gawk \
  git \
  curl \
  wget \
  rsync \
  tar \
  unzip \
  zip \
  file \
  which \
  procps \
  util-linux \
  openssh \
  ca-certificates

# Build/development
pkg install -y \
  clang \
  llvm \
  make \
  cmake \
  pkg-config \
  binutils \
  lld \
  python \
  python-pip \
  rust \
  golang

# Languages
pkg install -y \
  nodejs \
  openjdk-21

# Device / Android tools where available
pkg install -y \
  android-tools \
  termux-api

# Networking / system development
pkg install -y \
  openssl \
  libffi \
  sqlite \
  ncurses \
  libxml2 \
  libxslt

echo
echo "=== ARCHITECTURE ==="
uname -m

echo
echo "=== TERMUX ==="
echo "$PREFIX"

echo
echo "=== INSTALLED PERFECT OS TOOLCHAIN ==="

for cmd in \
  bash git curl wget rsync clang llvm make cmake \
  python pip rustc cargo go node java adb
do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[--] $cmd"
    fi
done

echo
echo "=== GOOGLE / ANDROID ==="
if command -v adb >/dev/null 2>&1; then
    adb version | head -2
else
    echo "ADB not available from current Termux repositories."
fi

echo
echo "=== PERFECT OS PKG SETUP COMPLETE ==="

# Networking / system development
pkg install -y \
  openssl \
  libffi \
  sqlite \
  ncurses \
  libxml2 \
  libxslt

echo
echo "=== ARCHITECTURE ==="
uname -m

echo
echo "=== OPERATING SYSTEM ==="
uname -o 2>/dev/null || uname -s

echo
echo "=== PERFECT OS TARGET ==="
bash devices/detect.sh

echo
echo "=== TOOLCHAIN CHECK ==="

for cmd in \
  bash git curl wget rsync clang llvm make cmake \
  python pip rustc cargo go node java adb
do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[--] $cmd"
    fi
done

echo
echo "=== GOOGLE / ANDROID ==="

if command -v adb >/dev/null 2>&1; then
    adb version | head -2
else
    echo "[--] adb unavailable"
fi

echo
echo "=== PERFECT OS PKG SETUP COMPLETE ==="
