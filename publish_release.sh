#!/usr/bin/env bash
set -e # Exit immediately if any command fails

# 1. Configuration variables
VERSION_TAG="v1.0.0" # Change this for future updates
RELEASE_TITLE="Perfect OS Release - Build ${VERSION_TAG}"
NOTES="Automated bare-metal build generated natively via i686-elf-gcc on mobile Termux."

echo "[*] Cleaning and compiling code tree..."
make clean
make

# 2. Check for output build targets to attach as release binaries
if [ -f "kernel.bin" ]; then
    TARGET_ASSET="kernel.bin"
elif [ -f "perfect-os.iso" ]; then
    TARGET_ASSET="perfect-os.iso"
elif [ -f "perfect-os.img" ]; then
    TARGET_ASSET="perfect-os.img"
else
    echo "[-] Critical Error: No compiled machine binary found to publish!"
    exit 1
fi

echo "[+] Found build asset: ${TARGET_ASSET}"

# 3. Synchronize local Git state
echo "[*] Pushing latest code state to remote repository..."
git add .
git commit -m "Build and release preparation for ${VERSION_TAG}" --allow-empty
git push origin main

# 4. Generate local tag framework
if git rev-parse "$VERSION_TAG" >/dev/null 2>&1; then
    echo "[!] Warning: Tag ${VERSION_TAG} already exists. Deleting local and remote copy..."
    git tag -d "$VERSION_TAG"
    git push --delete origin "$VERSION_TAG" || true
fi

git tag -a "$VERSION_TAG" -m "${RELEASE_TITLE}"
git push origin "$VERSION_TAG"

# 5. Create GitHub Release and attach the cross-compiled binary asset
echo "[*] Deploying release matrix to GitHub..."
gh release create "$VERSION_TAG" "$TARGET_ASSET" \
    --title "$RELEASE_TITLE" \
    --notes "$NOTES"

echo "[++] Deployment complete! Version ${VERSION_TAG} is live."

chmod +x ~/PERFECT-OS/publish_release.sh
~/PERFECT-OS/publish_release.sh

