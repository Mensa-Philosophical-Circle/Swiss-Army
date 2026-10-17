#!/usr/bin/env bash
# Assets: icons and line art are SVG, pictures are WebP. A PNG or JPEG in assets/ is a mistake
# (the launcher icons in android/ and ios/ are the only PNGs, and they are not in assets/).
set -euo pipefail

if [ ! -d "assets" ]; then
  echo "✅ No assets/ folder yet."
  exit 0
fi

RASTER=$(find assets -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) || true)
if [ -n "$RASTER" ]; then
  echo "❌ PNG or JPEG in assets/:"
  echo "$RASTER" | sed 's/^/   /'
  echo "Convert pictures to .webp and icons to .svg."
  exit 1
fi

# An asset path is a constant, never typed into a widget.
INLINE=$(grep -rnE "(Image\.asset|SvgPicture\.asset|AssetImage)\(\s*['\"]" lib/app/modules lib/app/widgets 2>/dev/null || true)
if [ -n "$INLINE" ]; then
  echo "❌ An asset path typed into a widget. Declare it in lib/app/utils/constants/:"
  echo "$INLINE"
  exit 1
fi
echo "✅ Assets are SVG or WebP, and their paths are constants."
