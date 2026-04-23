#!/usr/bin/env bash
# log-analyzer.sh — Analyze log files for errors and warnings
set -euo pipefail

log_file="${1:?Usage: log-analyzer.sh <log-file>}"

if [ ! -f "$log_file" ]; then
    echo "Error: $log_file not found" >&2
    exit 1
fi

echo "=== Log Analysis: $log_file ==="
echo ""
echo "Total lines: $(wc -l < "$log_file")"
echo "Error count: $(grep -ci "error" "$log_file" || echo 0)"
echo "Warning count: $(grep -ci "warning" "$log_file" || echo 0)"
echo ""
echo "Top 5 errors:"
grep -i "error" "$log_file" | sort | uniq -c | sort -rn | head -5
echo ""
echo "Errors by hour:"
grep -i "error" "$log_file" | awk -F'[: ]' '{print $2":00"}' | sort | uniq -c | sort -rn
