#!/usr/bin/env bash
# organize.sh — Organize files by extension
set -euo pipefail

target_dir="${1:-.}"

echo "Organizing files in: $target_dir"

for file in "$target_dir"/*; do
    [ -f "$file" ] || continue
    ext="${file##*.}"
    ext_dir="$target_dir/$ext"
    mkdir -p "$ext_dir"
    mv "$file" "$ext_dir/"
    echo "Moved: $(basename "$file") → $ext_dir/"
done

echo "Done!"
