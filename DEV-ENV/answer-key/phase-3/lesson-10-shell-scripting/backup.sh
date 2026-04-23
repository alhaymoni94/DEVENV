#!/usr/bin/env bash
# backup.sh — Create a timestamped backup of a directory
set -euo pipefail

source_dir="${1:?Usage: backup.sh <directory>}"
backup_dir="${2:-$HOME/backups}"
timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="$(basename "$source_dir")_$timestamp.tar.gz"

if [ ! -d "$source_dir" ]; then
    echo "Error: $source_dir does not exist" >&2
    exit 1
fi

mkdir -p "$backup_dir"
echo "Backing up $source_dir to $backup_dir/$backup_name"
tar -czf "$backup_dir/$backup_name" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"
echo "Backup complete: $backup_dir/$backup_name"
echo "Size: $(du -h "$backup_dir/$backup_name" | awk '{print $1}')"
