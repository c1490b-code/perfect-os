#!/data/data/com.termux/files/usr/bin/bash

set -u

HOME_DIR="$HOME"
BIN="$PREFIX/bin"

echo "========================================"
echo " LONGblade / AI COMPANY APP INSTALLER"
echo "========================================"
echo

pkg update -y
pkg upgrade -y

pkg install -y \
  git \
  curl \
  wget \
  python \
  nodejs \
  npm \
  clang \
  make \
  openssh \
  jq \
  unzip \
  tar

mkdir -p "$BIN"

echo
echo "[1/5] Installing discovered Termux commands..."

install_cmd() {
    local src="$1"
    local name="$2"

    if [ -f "$src" ]; then
        chmod +x "$src" 2>/dev/null || true
        ln -sf "$src" "$BIN/$name"
        echo "  installed: $name"
    fi
}

install_cmd "$HOME/electronics-ai-company/bin/company-doctor" company-doctor
install_cmd "$HOME/electronics-ai-company/bin/company-ai" company-ai
install_cmd "$HOME/electronics-ai-company/bin/company-start" company-start
install_cmd "$HOME/electronics-ai-company/bin/company-stop" company-stop
install_cmd "$HOME/electronics-ai-company/bin/cube" cube
install_cmd "$HOME/electronics-ai-company/bin/ai" company-ai-core

install_cmd "$HOME/bin/cocoa-main" cocoa-main
install_cmd "$HOME/bin/cube" cube-global

install_cmd "$HOME/masteros/os-manager/masteros" masteros

echo
echo "[2/5] Preparing Python environments..."

for dir in \
    "$HOME/electronics-ai-company" \
    "$HOME/cocoa"
do
    if [ -d "$dir" ]; then
        echo "  Python project: $dir"

        if [ -f "$dir/requirements.txt" ]; then
            python -m pip install --user -r "$dir/requirements.txt" || true
        fi
    fi
done

echo
echo "[3/5] Preparing Node/web applications..."

if [ -d "$HOME/rivpsy-event-server" ]; then
    cd "$HOME/rivpsy-event-server"

    if [ -f package.json ]; then
        echo "  npm install: rivpsy-event-server"
        npm install
    fi
fi

echo
echo "[4/5] Making project launchers..."

cat > "$BIN/rivpsy-server" <<'LAUNCH'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/rivpsy-event-server" || exit 1
exec node server.js
LAUNCH

chmod +x "$BIN/rivpsy-server"

cat > "$BIN/cocoa-server" <<'LAUNCH'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/cocoa" || exit 1
exec python main.py
LAUNCH

chmod +x "$BIN/cocoa-server"

cat > "$BIN/electronics-company" <<'LAUNCH'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/electronics-ai-company" || exit 1

if [ -x "./bin/company-start" ]; then
    exec ./bin/company-start "$@"
elif [ -x "./bin/company-ai" ]; then
    exec ./bin/company-ai "$@"
else
    echo "Electronics AI Company launcher not found."
    exit 1
fi
LAUNCH

chmod +x "$BIN/electronics-company"

echo
echo "[5/5] Checking installations..."

for cmd in \
    company-doctor \
    company-ai \
    company-start \
    company-stop \
    cube \
    masteros \
    rivpsy-server \
    cocoa-server \
    electronics-company
do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  OK  $cmd"
    else
        echo "  --  $cmd"
    fi
done

echo
echo "========================================"
echo " INSTALLATION COMPLETE"
echo "========================================"
echo
echo "Available commands:"
echo
echo "  company-doctor"
echo "  company-ai"
echo "  electronics-company"
echo "  company-start"
echo "  company-stop"
echo "  cube"
echo "  masteros"
echo "  cocoa-server"
echo "  rivpsy-server"
echo
echo "Web application:"
echo "  rivpsy-server"
echo
echo "Then open:"
echo "  http://127.0.0.1:3000"
echo
