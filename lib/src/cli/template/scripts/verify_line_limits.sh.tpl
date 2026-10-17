#!/usr/bin/env bash
# No Dart file in lib/ is longer than 200 lines: split it into focused files.
set -euo pipefail

VIOLATIONS=0
while IFS= read -r file; do
  lines=$(wc -l < "$file")
  if [ "$lines" -gt 200 ]; then
    echo "❌ $file has $lines lines (the limit is 200)."
    VIOLATIONS=$((VIOLATIONS + 1))
  fi
done < <(find lib -name "*.dart" ! -name "app_localizations*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart")

if [ "$VIOLATIONS" -gt 0 ]; then
  echo "$VIOLATIONS file(s) are too long."
  exit 1
fi
echo "✅ Every file in lib/ is 200 lines or fewer."
