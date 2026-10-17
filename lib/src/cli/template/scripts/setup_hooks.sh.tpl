#!/usr/bin/env bash
# Makes git run the quality checks before each commit, and checks commit messages.
set -e

chmod +x .githooks/pre-commit .githooks/commit-msg
git config core.hooksPath .githooks
echo "✅ Git hooks are on: every commit now runs scripts/quality_gate.sh."
