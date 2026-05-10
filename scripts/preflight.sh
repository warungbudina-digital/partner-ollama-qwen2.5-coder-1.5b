#!/usr/bin/env bash
set -euo pipefail

echo "== preflight =="
echo "repo: $(basename "$(pwd)")"

if command -v du >/dev/null 2>&1; then
  size_kb=$(du -sk . | awk '{print $1}')
  echo "repo_size_kb=$size_kb"
  if [ "$size_kb" -gt 25600 ]; then
    echo "warn: repo lebih besar dari target 25MB"
  fi
fi

if command -v df >/dev/null 2>&1; then
  echo "home_disk:"
  df -h "$HOME" | sed -n '1,2p'
fi

for cmd in bash git python3; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "ok: found $cmd"
  else
    echo "warn: missing $cmd"
  fi
done

echo "done"
