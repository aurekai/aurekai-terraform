#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0

echo "Checking main.tf..."
if grep -q "terraform" "$ROOT/main.tf"; then
  echo "  v main.tf"; PASS=$((PASS+1))
else
  echo "  x main.tf"; FAIL=$((FAIL+1))
fi

for f in "$ROOT"/modules/*/main.tf; do
  if grep -q "terraform" "$f"; then
    echo "  v $(basename $(dirname $f))/main.tf"; PASS=$((PASS+1))
  else
    echo "  x $f"; FAIL=$((FAIL+1))
  fi
done

echo; echo "HCL files: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
