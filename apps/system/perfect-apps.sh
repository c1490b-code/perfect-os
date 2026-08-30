#!/bin/sh

APPROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "PERFECT OS APPLICATION CENTER"
echo
echo "Installed application groups:"
find "$APPROOT" -mindepth 2 -maxdepth 2 -type f -name '*.sh' \
  -printf '%h/%f\n' 2>/dev/null || true
