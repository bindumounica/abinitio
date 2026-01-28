#!/usr/bin/env bash
set -e

echo "[PIPELINE] Starting ETL run"

# ----------------------------
# Bootstrap directories
# ----------------------------
echo "[PIPELINE] Bootstrapping directories"
mkdir -p data/curated

# ----------------------------
# Validate input
# ----------------------------
echo "[PIPELINE] Validating input"
if [ ! -f data/raw/user_events.csv ]; then
  echo "[ERROR] Input file not found"
  exit 1
fi

# ----------------------------
# Run transformation
# ----------------------------
echo "[PIPELINE] Running transformation"
go run transforms/user_aggregate.go

# ----------------------------
# Validate output
# ----------------------------
OUTPUT_FILE="data/curated/user_activity_summary.csv"

if [ ! -f "$OUTPUT_FILE" ]; then
  echo "[ERROR] Output file not generated"
  exit 1
fi

echo "[PIPELINE] Output generated:"
cat "$OUTPUT_FILE"

echo "[PIPELINE] ETL completed successfully"
