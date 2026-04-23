#!/usr/bin/env bash
# dir-summary.sh — Summarize a directory
set -euo pipefail

dir="${1:-.}"

echo "=== Directory Summary: $dir ==="
echo ""
echo "Total files: $(find "$dir" -type f 2>/dev/null | wc -l)"
echo "Total directories: $(find "$dir" -type d 2>/dev/null | wc -l)"
echo "Total size: $(du -sh "$dir" 2>/dev/null | awk '{print $1}')"
echo ""
echo "Largest files:"
find "$dir" -type f -exec ls -l {} \; 2>/dev/null | sort -k5 -rn | head -5 | awk '{print "  " $5 "  " $9}'
echo ""
echo "Most recently modified:"
ls -lt "$dir" 2>/dev/null | head -6 | tail -5 | awk '{print "  " $6 " " $7 " " $8 "  " $9}'
