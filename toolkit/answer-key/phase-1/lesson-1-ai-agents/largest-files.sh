#!/usr/bin/env bash
# largest-files.sh — List the 10 largest files in a directory
set -euo pipefail

dir="${1:-.}"

# Find files, sort by size descending, show top 10 with human-readable sizes
find "$dir" -maxdepth 1 -type f -exec ls -lh {} + 2>/dev/null | \
    awk '{print $5, $9}' | \
    sort -rh | \
    head -10
