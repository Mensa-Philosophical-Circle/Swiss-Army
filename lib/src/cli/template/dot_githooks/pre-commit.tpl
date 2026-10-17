#!/usr/bin/env bash
set -e

echo "🔍 Running the quality checks before the commit..."
bash scripts/quality_gate.sh
