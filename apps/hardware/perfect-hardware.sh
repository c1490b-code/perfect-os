#!/bin/sh

echo "PERFECT HARDWARE CENTER"
echo "======================="
echo

echo "Architecture:"
uname -m

echo
echo "Kernel:"
uname -r

echo
echo "CPU:"
grep -m1 -E 'model name|Hardware|Processor' /proc/cpuinfo 2>/dev/null || true

echo
echo "Memory:"
grep MemTotal /proc/meminfo 2>/dev/null || true

echo
echo "PERFECT Hardware Abstraction Layer:"
echo "PHAL ready"
