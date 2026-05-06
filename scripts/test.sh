#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Find all directories that contain at least one .tftest.hcl file
mapfile -t test_dirs < <(find "$REPO_ROOT" -name "*.tftest.hcl" -exec dirname {} \; | sort -u)

if [[ ${#test_dirs[@]} -eq 0 ]]; then
  echo "No .tftest.hcl files found."
  exit 0
fi

failed=0

for dir in "${test_dirs[@]}"; do
  echo "==> Testing $dir"
  if ! (cd "$dir" && tofu init -input=false && tofu test); then
    echo "FAILED: $dir"
    failed=1
  fi
done

if [[ $failed -ne 0 ]]; then
  echo "One or more test suites failed."
  exit 1
fi

echo "All test suites passed."
