#!/usr/bin/env bash
# backup.sh — Backup entire stack state
# Creates a timestamped tarball of: dotfiles, configs, intelli-shell data

set -euo pipefail

TOOLKIT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.local/share/stack-backups"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_FILE="$BACKUP_DIR/stack-backup-$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║   Stack Backup                       ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n\n"

# What we're backing up
ITEMS=()

# 1. Dotfiles repo
if [ -d "$TOOLKIT/dotfiles" ]; then
  ITEMS+=("$TOOLKIT/dotfiles")
  printf "  ✓ dotfiles repo\n"
fi

# 2. chezmoi source (if different from dotfiles)
if command -v chezmoi &>/dev/null; then
  CM_SRC="$(chezmoi source-path 2>/dev/null || echo "")"
  if [ -n "$CM_SRC" ] && [ "$CM_SRC" != "$TOOLKIT/dotfiles" ]; then
    ITEMS+=("$CM_SRC")
    printf "  ✓ chezmoi source ($CM_SRC)\n"
  fi
fi

# 3. Home configs that might not be in chezmoi
for cfg in \
  "$HOME/.config/ghostty" \
  "$HOME/.config/intelli-shell" \
  "$HOME/.config/starship" \
  "$HOME/.config/wezterm" \
  "$HOME/.config/yazi" \
  "$HOME/.tmux.conf" \
  "$HOME/.zshrc" \
  "$HOME/.zsh_history"; do
  if [ -e "$cfg" ]; then
    ITEMS+=("$cfg")
    printf "  ✓ %s\n" "$(basename "$cfg")"
  fi
done

# 4. Intelli-shell data
if [ -d "$HOME/.local/share/intelli-shell" ]; then
  ITEMS+=("$HOME/.local/share/intelli-shell")
  printf "  ✓ intelli-shell data\n"
fi

printf "\n"
printf "  Backing up %d items to:\n" "${#ITEMS[@]}"
printf "  \033[33m%s\033[0m\n\n" "$BACKUP_FILE"

tar -czf "$BACKUP_FILE" "${ITEMS[@]}" 2>/dev/null

SIZE="$(du -h "$BACKUP_FILE" | cut -f1)"
printf "  \033[32m✓ Backup complete: %s\033[0m\n\n" "$SIZE"

# Cleanup old backups (keep last 5)
OLD_COUNT=$(ls -1 "$BACKUP_DIR"/stack-backup-*.tar.gz 2>/dev/null | wc -l)
if [ "$OLD_COUNT" -gt 5 ]; then
  ls -1t "$BACKUP_DIR"/stack-backup-*.tar.gz | tail -n +6 | xargs rm -f
  printf "  \033[34m· Cleaned up old backups (kept 5 newest)\033[0m\n\n"
fi
