#!/data/data/com.termux/files/usr/bin/bash

clear

echo "========================================"
echo "          PERFECT-OS SHELL"
echo "========================================"
echo
echo "Type 'help' for commands."
echo

while true; do
    printf "perfect-os> "
    read -r command args

    case "$command" in
        help)
            echo
            echo "PERFECT-OS commands:"
            echo "  help       Show this help"
            echo "  info       System information"
            echo "  kernel     Start kernel test"
            echo "  ai         Open AI subsystem"
            echo "  apps       Show applications"
            echo "  hardware   Show hardware tree"
            echo "  build      Build PERFECT-OS"
            echo "  test       Run tests"
            echo "  exit       Exit shell"
            echo
            ;;

        info)
            ./build/perfect-info 2>/dev/null || echo "Run: ./scripts/build.sh"
            ;;

        kernel)
            ./build/perfect-kernel 2>/dev/null || echo "Run: ./scripts/build.sh"
            ;;

        ai)
            ./ai/ai.sh
            ;;

        apps)
            echo "Applications:"
            find apps -maxdepth 2 -type f 2>/dev/null
            ;;

        hardware)
            echo "Hardware:"
            find electronics -maxdepth 2 -type d 2>/dev/null
            ;;

        build)
            ./scripts/build.sh
            ;;

        test)
            ./scripts/test.sh
            ;;

        exit|quit)
            echo "PERFECT-OS shell stopped."
            exit 0
            ;;

        "")
            ;;

        *)
            echo "Unknown command: $command"
            echo "Type 'help'."
            ;;
    esac
done
