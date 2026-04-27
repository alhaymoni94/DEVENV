#!/usr/bin/env bash
# update.sh — Update the entire stack
# Updates: brew packages, uv tools, chezmoi apply, intelli-shell

set -euo pipefail

TOOLKIT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║   Stack Update                       ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n\n"

# ── 1. Homebrew ──────────────────────────────────────────────────────────────
printf "\033[1;36m▶ Homebrew\033[0m\n"
brew update --quiet 2>/dev/null
UPGRADED=$(brew upgrade 2>/dev/null | grep "Upgraded" | wc -l || echo "0")
printf "  \033[32m✓ brew updated (%s packages upgraded)\033[0m\n\n" "$UPGRADED"

# ── 2. uv tools ──────────────────────────────────────────────────────────────
printf "\033[1;36m▶ uv tools\033[0m\n"
if command -v uv &>/dev/null; then
  uv tool upgrade visidata euporie 2>/dev/null && printf "  \033[32m✓ uv tools upgraded\033[0m\n\n" \
    || printf "  \033[33m· no upgrades available\033[0m\n\n"
fi

# ── 3. chezmoi ───────────────────────────────────────────────────────────────
printf "\033[1;36m▶ chezmoi\033[0m\n"
if command -v chezmoi &>/dev/null; then
  chezmoi apply -v 2>/dev/null && printf "  \033[32m✓ dotfiles applied\033[0m\n\n" \
    || printf "  \033[33m· no changes needed\033[0m\n\n"
fi

# ── 4. intelli-shell ─────────────────────────────────────────────────────────
printf "\033[1;36m▶ intelli-shell\033[0m\n"
if command -v intelli-shell &>/dev/null; then
  intelli-shell update 2>/dev/null && printf "  \033[32m✓ intelli-shell updated\033[0m\n\n" \
    || printf "  \033[33m· already up to date\033[0m\n\n"
fi

# ── 5. gh extensions ─────────────────────────────────────────────────────────
printf "\033[1;36m▶ gh extensions\033[0m\n"
if command -v gh &>/dev/null; then
  gh extension upgrade --all 2>/dev/null && printf "  \033[32m✓ gh extensions upgraded\033[0m\n\n" \
    || printf "  \033[33m· no upgrades available\033[0m\n\n"
fi

# ── 6. zinit plugins ─────────────────────────────────────────────────────────
printf "\033[1;36m▶ zinit plugins\033[0m\n"
printf "  Run: \033[33mzinit update\033[0m (in your shell)\n\n"

printf "\033[1;36m── Update complete.\033[0m\n\n"
