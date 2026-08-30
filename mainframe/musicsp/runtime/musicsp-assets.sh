#!/data/data/com.termux/files/usr/bin/bash

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

[ -f "$ROOT/config/assets.env" ] && . "$ROOT/config/assets.env"

echo "=========================================="
echo " MUSIC/SP S/390 ASSET MANAGER"
echo "=========================================="

echo
echo "Manifest:"
cat "$ROOT/runtime/assets/manifest.txt" 2>/dev/null || true

echo
echo "Boot asset:"
if [ -n "${S390_BOOT_ASSET:-}" ] && [ -f "$S390_BOOT_ASSET" ]; then
    echo "$S390_BOOT_ASSET"
    file "$S390_BOOT_ASSET" 2>/dev/null || true
else
    echo "Unavailable"
fi

echo
echo "Firmware:"
if [ -n "${S390_FIRMWARE_ASSET:-}" ] && [ -f "$S390_FIRMWARE_ASSET" ]; then
    echo "$S390_FIRMWARE_ASSET"
    file "$S390_FIRMWARE_ASSET" 2>/dev/null || true
else
    echo "Unavailable"
fi

echo
echo "Guest OS:"
echo "MUSIC/SP media is supplied separately."
echo "Firmware/ROM assets are not MUSIC/SP itself."
