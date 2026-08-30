#!/data/data/com.termux/files/usr/bin/bash

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

case "$1" in
    build)
        "$ROOT/scripts/build.sh"
        ;;
    test)
        "$ROOT/scripts/test.sh"
        ;;
    shell)
        "$ROOT/shell/perfect-shell.sh"
        ;;
    kernel)
        "$ROOT/build/perfect-kernel"
        ;;
    info)
        "$ROOT/build/perfect-info"
        ;;
    *)
        echo "PERFECT-OS development tool"
        echo
        echo "Usage:"
        echo "  ./tools/perfect-os.sh build"
        echo "  ./tools/perfect-os.sh test"
        echo "  ./tools/perfect-os.sh shell"
        echo "  ./tools/perfect-os.sh kernel"
        echo "  ./tools/perfect-os.sh info"
        ;;
esac
