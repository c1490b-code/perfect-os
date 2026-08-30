#!/bin/sh

ROOT="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
    ai)
        "$ROOT/apps/ai/perfect-ai.sh"
        ;;
    dev)
        "$ROOT/apps/developer/perfect-dev.sh"
        ;;
    files)
        "$ROOT/apps/files/perfect-files.sh"
        ;;
    hardware)
        "$ROOT/apps/hardware/perfect-hardware.sh"
        ;;
    settings)
        "$ROOT/apps/settings/perfect-settings.sh"
        ;;
    security)
        "$ROOT/apps/security/perfect-security.sh"
        ;;
    medical)
        "$ROOT/apps/medical/perfect-medical.sh"
        ;;
    automation)
        "$ROOT/apps/automation/perfect-automation.sh"
        ;;
    python-ai)
        python3 "$ROOT/ai/runtime/perfect_ai.py"
        ;;
    *)
        echo "PERFECT OS Application Launcher"
        echo
        echo "Usage:"
        echo "  ./perfect-app.sh ai"
        echo "  ./perfect-app.sh dev"
        echo "  ./perfect-app.sh files"
        echo "  ./perfect-app.sh hardware"
        echo "  ./perfect-app.sh settings"
        echo "  ./perfect-app.sh security"
        echo "  ./perfect-app.sh medical"
        echo "  ./perfect-app.sh automation"
        echo "  ./perfect-app.sh python-ai"
        ;;
esac
