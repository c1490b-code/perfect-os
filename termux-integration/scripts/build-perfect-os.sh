#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

ROOT="$HOME/PERFECT-OS"
IMPORT="$ROOT/source-import"
VENDOR="$ROOT/vendor"

echo "=== PERFECT OS BOOTSTRAP ==="

pkg update -y
pkg install -y git findutils rsync jq

mkdir -p "$ROOT"/{boot/{bootloader,firmware,secureboot,recovery},kernel/{phantom-inspired,nemesis-inspired,hardware},runtime/{persistent,processes,memory,devices},drivers/{x86_64,arm64,android,usb,audio,network,display},ai,apps,shell,gui,accounts,security,package-manager,electronics,medical,government,docs,tests,images,tools,.github}
mkdir -p "$IMPORT"/{archives,source,android-downloads}
mkdir -p "$VENDOR"

echo "[1/6] Importing reference projects..."

if [ ! -d "$VENDOR/phantomuserland/.git" ]; then
    git clone https://github.com/dzavalishin/phantomuserland \
        "$VENDOR/phantomuserland"
fi

if [ ! -d "$VENDOR/nemesis-release/.git" ]; then
    git clone https://github.com/OSPreservProject/nemesis-release \
        "$VENDOR/nemesis-release"
fi

echo "[2/6] Creating Android storage access..."

termux-setup-storage 2>/dev/null || true

DOWNLOAD="$HOME/storage/shared/Download"

if [ -d "$DOWNLOAD" ]; then
    echo "Scanning: $DOWNLOAD"

    find "$DOWNLOAD" -type f \
      -not -path '*/.git/*' \
      -print0 |
    while IFS= read -r -d '' f; do
        rel="${f#$DOWNLOAD/}"
        mkdir -p "$IMPORT/android-downloads/$(dirname "$rel")"
        cp -n "$f" "$IMPORT/android-downloads/$rel" 2>/dev/null || true
    done
fi

echo "[3/6] Scanning Termux home..."

find "$HOME" -maxdepth 4 -type f \
  \( -name '*.sh' -o -name '*.py' -o -name '*.c' \
  -o -name '*.cpp' -o -name '*.h' -o -name '*.rs' \
  -o -name '*.java' -o -name '*.kt' -o -name '*.lua' \
  -o -name '*.fs' -o -name '*.wasm' -o -name '*.zip' \
  -o -name '*.tar' -o -name '*.gz' -o -name '*.iso' \
  -o -name '*.img' -o -name '*.apk' \) \
  -not -path "$ROOT/*" \
  -not -path "$HOME/.cache/*" \
  -print0 |
while IFS= read -r -d '' f; do
    rel="${f#$HOME/}"
    mkdir -p "$IMPORT/source/$(dirname "$rel")"
    cp -n "$f" "$IMPORT/source/$rel" 2>/dev/null || true
done

echo "[4/6] Building inventory..."

find "$IMPORT" -type f -print0 |
while IFS= read -r -d '' f; do
    sha256sum "$f"
done > "$IMPORT/checksums.sha256"

find "$IMPORT" -type f | sort > "$IMPORT/INVENTORY.txt"

cat > "$IMPORT/IMPORTED_PROJECTS.md" <<DOC
# PERFECT OS — Imported Project Inventory

Generated: $(date -u)

This directory contains copies of files discovered in
Android Download storage and the Termux environment.

Original files were not intentionally deleted or overwritten.

## Reference Projects

- Phantom OS: vendor/phantomuserland
- Nemesis: vendor/nemesis-release

## Architecture

PERFECT OS combines compatible architectural ideas while
maintaining independent licensing and attribution for imported
third-party projects.
DOC

echo "[5/6] Creating build metadata..."

cat > "$ROOT/OS.yaml" <<'YAML'
name: PERFECT OS
version: 0.1.0
architecture:
  - x86_64
  - arm64
targets:
  - qemu
  - pc
  - arm-device
  - android-derived-device

components:
  persistent_runtime: enabled
  modular_services: enabled
  ai_runtime: enabled
  secure_boot: planned
  recovery: enabled
  package_manager: planned

principles:
  - persistent computing
  - modular operating-system services
  - hardware abstraction
  - reproducible builds
  - security by design
  - user-controlled privacy
  - defensive administration
YAML

cat > "$ROOT/README.md" <<'DOC'
# PERFECT OS

A new experimental operating system and computing platform.

PERFECT OS explores persistent computing, modular OS services,
AI-assisted computing, hardware abstraction, secure boot,
recovery, and cross-architecture operation.

Initial targets:

- x86_64
- ARM64
- QEMU
- PC hardware
- ARM development hardware

Reference implementations are maintained under `vendor/`.
DOC

cat > "$ROOT/.gitignore" <<'EOF2'
*.img
*.iso
*.qcow2
*.raw
build/
dist/
out/
.cache/
__pycache__/
EOF2

echo "[6/6] Git repository..."

cd "$ROOT"

git init
git branch -M main

git add .
git commit -m "Initial PERFECT OS architecture and imported project inventory" || true

echo
echo "======================================"
echo " PERFECT OS BOOTSTRAP COMPLETE"
echo "======================================"
echo
echo "Project: $ROOT"
echo
echo "Inventory:"
echo "  $IMPORT/INVENTORY.txt"
echo
echo "Checksums:"
echo "  $IMPORT/checksums.sha256"
echo
echo "Reference source:"
echo "  $VENDOR/phantomuserland"
echo "  $VENDOR/nemesis-release"
echo
echo "Next:"
echo "  cd ~/PERFECT-OS"
echo "  git status"
echo
