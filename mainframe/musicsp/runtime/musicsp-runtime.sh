#!/data/data/com.termux/files/usr/bin/bash
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

[ -f "$ROOT/config/musicsp.env" ] && . "$ROOT/config/musicsp.env"
[ -f "$ROOT/config/assets.env" ] && . "$ROOT/config/assets.env"

status() {
    echo "=========================================="
    echo " PERFECT-OS MUSIC/SP RUNTIME"
    echo "=========================================="
    echo "Host architecture : $(uname -m)"
    echo "Guest             : $GUEST_NAME"
    echo "Target            : $TARGET"
    echo "AI enabled        : $AI_ENABLED"
    echo

    echo "=== EMULATORS ==="

    if command -v qemu-system-s390x >/dev/null 2>&1; then
        echo "QEMU S/390x       : AVAILABLE"
        qemu-system-s390x --version 2>/dev/null | head -1
    else
        echo "QEMU S/390x       : NOT INSTALLED"
    fi

    if command -v hercules >/dev/null 2>&1; then
        echo "Hercules          : AVAILABLE"
    else
        echo "Hercules          : NOT INSTALLED"
    fi

    echo
    echo "=== S/390 ASSETS ==="

    if [ -f "$ROOT/runtime/assets/manifest.txt" ]; then
        cat "$ROOT/runtime/assets/manifest.txt"
    else
        echo "No assets found."
    fi

    echo
    echo "=== GUEST MEDIA ==="

    if [ -n "${DISK_IMAGE:-}" ] && [ -f "$DISK_IMAGE" ]; then
        echo "Disk image: $DISK_IMAGE"
    else
        echo "No MUSIC/SP guest disk configured."
    fi

    echo
    echo "=== AI ==="

    if [ -x "$ROOT/ai/bin/musicsp-ai" ]; then
        echo "MUSIC/SP AI: READY"
    else
        echo "MUSIC/SP AI: NOT BUILT"
    fi
}

assets() {
    "$ROOT/runtime/musicsp-assets.sh"
}

ai() {
    "$ROOT/ai/bin/musicsp-ai" "${@:2}"
}

run_qemu() {
    if ! command -v qemu-system-s390x >/dev/null 2>&1; then
        echo "QEMU S/390x is not installed in this Termux environment."
        return 1
    fi

    if [ -z "${DISK_IMAGE:-}" ]; then
        echo "No MUSIC/SP disk image configured."
        return 1
    fi

    exec qemu-system-s390x \
        -name "PERFECT-OS-MUSIC-SP" \
        -m "$MEMORY" \
        -drive "file=$DISK_IMAGE,format=$DISK_FORMAT" \
        -nographic
}

shell() {
    echo "PERFECT-OS MUSIC/SP SHELL"
    echo
    echo "status  - runtime status"
    echo "assets  - S/390 asset inventory"
    echo "ai      - MUSIC/SP AI"
    echo "qemu    - launch QEMU S/390x"
    echo "exit    - leave shell"
    echo

    while true; do
        printf 'MUSIC/SP> '
        read -r cmd || break

        case "$cmd" in
            status) status ;;
            assets) assets ;;
            ai) ai ;;
            qemu) run_qemu ;;
            exit|quit) break ;;
            help) echo "status | assets | ai | qemu | exit" ;;
            "") ;;
            *) echo "Unknown command: $cmd" ;;
        esac
    done
}

case "${1:-status}" in
    status) status ;;
    assets) assets ;;
    ai) ai "$@" ;;
    qemu) run_qemu ;;
    shell) shell ;;
    *)
        echo "Usage: musicsp {status|assets|ai|qemu|shell}"
        exit 2
        ;;
esac
