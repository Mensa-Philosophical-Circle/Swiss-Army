#!/usr/bin/env bash
# Separation of concerns: views show, controllers decide, data/ talks to the server.
#   1. A view makes no network calls: it asks its controller.
#   2. A controller holds no widgets or BuildContext.
#   3. A view declares no data models: they live in lib/app/data/models/.
set -euo pipefail

VIOLATIONS=0

VIEW_API_CALLS=$(grep -rnE "(ApiClient\(\)|Dio\(|_dio\.(get|post|put|delete)|http\.(get|post))" lib/app/modules/*/views/ lib/app/modules/*/widgets/ 2>/dev/null || true)
if [ -n "$VIEW_API_CALLS" ]; then
  echo "❌ Network calls in a view. Views ask their controller:"
  echo "$VIEW_API_CALLS"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

CONTROLLER_UI_LEAKS=$(grep -rnE "(\bBuildContext\b|\bScaffold\b|\bNavigator\b)" lib/app/modules/*/controllers/ 2>/dev/null || true)
if [ -n "$CONTROLLER_UI_LEAKS" ]; then
  echo "❌ Widgets or BuildContext in a controller:"
  echo "$CONTROLLER_UI_LEAKS"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

VIEW_DTO_LEAKS=$(grep -rnE "^class [A-Z][A-Za-z0-9]+(Model|Dto|Entity|Response)\b" lib/app/modules/*/views/ 2>/dev/null || true)
if [ -n "$VIEW_DTO_LEAKS" ]; then
  echo "❌ A data model declared in a view. Put it in lib/app/data/models/:"
  echo "$VIEW_DTO_LEAKS"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

if [ "$VIOLATIONS" -gt 0 ]; then
  exit 1
fi
echo "✅ Views, controllers and data are kept apart."
