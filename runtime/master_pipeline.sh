#!/usr/bin/env bash
set -e

echo "[PIPELINE] Starting ETL run"

echo "[PIPELINE] Validating input"
test -f data/raw/user_events.csv

echo "[PIPELINE] Running transformation"
go run transforms/user_aggregate.go

echo "[PIPELINE] Output generated:"
cat data/curated/user_activity_summary.csv

echo "[PIPELINE] ETL completed successfully"
