#!/usr/bin/env python3

import os
import platform
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def detect():
    result = {
        "host": platform.machine(),
        "system": platform.system(),
        "musicsp_root": str(ROOT),
        "qemu_s390x": False,
        "hercules": False,
        "assets": []
    }

    result["qemu_s390x"] = subprocess.call(
        ["bash", "-lc", "command -v qemu-system-s390x >/dev/null 2>&1"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    ) == 0

    result["hercules"] = subprocess.call(
        ["bash", "-lc", "command -v hercules >/dev/null 2>&1"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    ) == 0

    manifest = ROOT / "runtime/assets/manifest.txt"

    if manifest.exists():
        result["assets"] = [
            x.strip()
            for x in manifest.read_text().splitlines()
            if x.strip()
        ]

    return result


def answer(command):
    data = detect()

    c = command.lower().strip()

    if c in ("status", "scan", "detect"):
        return data

    if "qemu" in c:
        return {
            "qemu_s390x": data["qemu_s390x"],
            "message":
                "QEMU S/390x is available."
                if data["qemu_s390x"]
                else "QEMU S/390x is not currently installed."
        }

    if "asset" in c:
        return {
            "assets": data["assets"],
            "count": len(data["assets"])
        }

    if "hercules" in c:
        return {
            "hercules": data["hercules"],
            "message":
                "Hercules is available."
                if data["hercules"]
                else "Hercules is not currently installed."
        }

    return {
        "message": "MUSIC/SP AI command received.",
        "command": command,
        "available_commands": [
            "status",
            "qemu status",
            "hercules status",
            "assets"
        ]
    }


if __name__ == "__main__":
    import json
    import sys

    command = " ".join(sys.argv[1:]) or "status"
    print(json.dumps(answer(command), indent=2))
