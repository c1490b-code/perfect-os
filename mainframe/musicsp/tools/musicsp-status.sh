#!/data/data/com.termux/files/usr/bin/bash
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec "$ROOT/runtime/musicsp-runtime.sh" status
