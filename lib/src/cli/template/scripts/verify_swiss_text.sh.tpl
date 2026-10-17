#!/usr/bin/env bash
# Text goes through swiss_army_component (BigAppText, MedAppText, SmallAppText), never a raw Text(...),
# Text.rich or a TextStyle built from scratch, in screens or widgets.
set -euo pipefail

FOUND=$(grep -rnE "(^|[^A-Za-z_])(Text\(|Text\.rich\(|TextStyle\()" lib/app/modules lib/app/widgets || true)
if [ -n "$FOUND" ]; then
  echo "❌ Raw Text / TextStyle found. Use BigAppText, MedAppText or SmallAppText:"
  echo "$FOUND"
  exit 1
fi
echo "✅ All text goes through swiss_army_component."
