#!/usr/bin/env bash
# SemiBold (FontWeight.w600) is the heaviest weight the app uses.
set -euo pipefail

FOUND=$(grep -rnE "FontWeight\.(bold|w700|w800|w900)" lib/ || true)
if [ -n "$FOUND" ]; then
  echo "❌ Font weights heavier than w600:"
  echo "$FOUND"
  exit 1
fi
echo "✅ Font weights are w600 or lighter."
