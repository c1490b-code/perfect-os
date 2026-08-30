#!/bin/sh

ROOT="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
    ai-gov)
        "$ROOT/ai-gov/core/ai-gov.sh"
        ;;
    gov)
        "$ROOT/gov/core/gov.sh"
        ;;
    *)
        echo "PERFECT Government Platform"
        echo
        echo "  ./apps/government.sh ai-gov"
        echo "  ./apps/government.sh gov"
        ;;
esac
