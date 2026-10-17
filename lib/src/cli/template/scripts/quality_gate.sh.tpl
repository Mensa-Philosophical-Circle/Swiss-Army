#!/usr/bin/env bash
# Runs every check a change must pass before it is committed: the rules in AGENTS.md, then analysis and tests.
set -euo pipefail

echo "▶ Font weights (w600 is the heaviest)"
bash scripts/verify_font_weights.sh

echo "▶ File length (200 lines at most)"
bash scripts/verify_line_limits.sh

echo "▶ Text goes through swiss_army_component"
bash scripts/verify_swiss_text.sh

echo "▶ No hard-coded words in screens"
dart run scripts/verify_no_magic_strings.dart

echo "▶ Widgets live with their screen"
dart run scripts/verify_widget_locality.dart

echo "▶ Static analysis"
dart analyze --fatal-infos

echo "▶ Tests"
flutter test

echo "✅ All checks passed."
