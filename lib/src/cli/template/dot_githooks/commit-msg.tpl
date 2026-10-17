#!/usr/bin/env bash
# Conventional Commits: "type(scope): subject", subject 100 characters at most.
set -e

subject=$(head -n1 "$1")
types="feat|fix|refactor|perf|test|docs|style|build|ci|chore|revert"

if [[ "$subject" =~ ^Merge\  ]] || [[ "$subject" =~ ^Revert\  ]]; then exit 0; fi

if ! [[ "$subject" =~ ^($types)(\([a-z0-9_-]+\))?!?:\ .+ ]]; then
  echo "❌ Use Conventional Commits: type(scope): subject"
  echo "   types: ${types//|/, }"
  echo "   got:   $subject"
  exit 1
fi
if [ ${#subject} -gt 100 ]; then
  echo "❌ Keep the subject to 100 characters (it is ${#subject})."
  exit 1
fi
