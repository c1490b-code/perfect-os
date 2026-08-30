#!/bin/sh

echo "PERFECT Developer Environment"
echo
echo "Project: PERFECT OS"
echo "Architecture: $(uname -m)"
echo
echo "Build:"
echo "  make"
echo
echo "Test:"
echo "  make test"
echo
echo "Git:"
git status --short 2>/dev/null || true
