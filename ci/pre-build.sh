#!/usr/bin/env bash
set -e

echo "=== Running pre-build hook ==="

# Example checks (you can replace later)
echo "Checking required directories..."
for dir in graphs mp dml scripts; do
  if [ ! -d "$dir" ]; then
    echo "ERROR: Missing directory: $dir"
    exit 1
  fi
done

echo "Validating file naming..."
find graphs -type f ! -name "*.mp" -print && \
  echo "WARNING: Non-mp file found in graphs"

echo "Pre-build checks completed successfully"
