#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:1
export PULSE_SERVER=127.0.0.1

echo "========================================"
echo "       PERFECT-OS & AI → TERMUX:X11"
echo "========================================"

# Start X11 server
pkill -f 'termux-x11 :1' 2>/dev/null || true
sleep 1

termux-x11 :1 >/tmp/perfect-x11.log 2>&1 &

# Open the Android Termux:X11 application
sleep 3
am start -n com.termux.x11/.MainActivity >/dev/null 2>&1 || true

# Start Debian graphical desktop
sleep 2

proot-distro login debian --shared-tmp -- bash -lc '
    export DISPLAY=:1
    export PULSE_SERVER=127.0.0.1
    export XDG_CURRENT_DESKTOP=XFCE
    export XDG_SESSION_DESKTOP=xfce
    export XDG_RUNTIME_DIR=/tmp/perfect-x11-runtime

    mkdir -p "$XDG_RUNTIME_DIR"
    chmod 700 "$XDG_RUNTIME_DIR"

    dbus-launch --exit-with-session startxfce4
'
