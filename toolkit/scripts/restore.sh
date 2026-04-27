#!/usr/bin/env bash
# restore.sh — Restore stack state from backup
# Lists available backups, restores the selected one

set -euo pipefail

BACKUP_DIR="$HOME/.local/share/stack-backups"

printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║   Stack Restore                      ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n\n"

# List available backups
BACKUPS=()
while IFS= read -r f; do
  BACKUPS+=("$f")
done < <(ls -1t "$BACKUP_DIR"/stack-backup-*.tar.gz 2>/dev/null)

if [ "${#BACKUPS[@]}" -eq 0 ]; then
  printf "  \033[31m✗ No backups found.\033[0m\n"
  printf "  Run: backup.sh first\n\n"
  exit 1
fi

printf "  Available backups:\n"
for i in "${!BACKUPS[@]}"; do
  b="${BACKUPS[$i]}"
  name="$(basename "$b")"
  size="$(du -h "$b" | cut -f1)"
  date="$(echo "$name" | sed 's/stack-backup-//;s/\.tar\.gz//')"
  printf "  %d) \033[33m%s\033[0m (%s) — %s\n" "$((i+1))" "$date" "$size" "$b"
done

printf "\n"
read -rp "  Restore which backup? [1]: " choice
choice="${choice:-1}"

if [ "$choice" -lt 1 ] || [ "$choice" -gt "${#BACKUPS[@]}" ]; then
  printf "  \033[31m✗ Invalid selection.\033[0m\n"
  exit 1
fi

SELECTED="${BACKUPS[$((choice-1))]}"
printf "\n  Restoring from: \033[33m%s\033[0m\n\n" "$(basename "$SELECTED")"

# Warn about overwriting
printf "  \033[33m⚠ This will overwrite existing configs.\033[0m\n"
read -rp "  Continue? [y/N]: " ans
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
  printf "  Cancelled.\n\n"
  exit 0
fi

tar -xzf "$SELECTED" -C / 2>/dev/null

printf "  \033[32m✓ Restore complete.\033[0m\n"
printf "  Run: source ~/.zshrc  (to reload shell config)\n\n"
