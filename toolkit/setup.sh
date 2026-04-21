#!/usr/bin/env bash
# setup.sh — Terminal stack installer + doctor
# Installs missing tools, skips already-installed ones, ends with a doctor report.
# Safe to re-run at any time.

set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$TOOLKIT_DIR/dotfiles"

# ── Color helpers ─────────────────────────────────────────────────────────────
BOLD="\033[1m"
CYAN="\033[1;36m"
BLUE="\033[1;34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
MAGENTA="\033[1;35m"
DIM="\033[2m"
RESET="\033[0m"

# ── Counters ──────────────────────────────────────────────────────────────────
TOTAL_PHASES=9
CURRENT_PHASE=0
INSTALLED=0
SKIPPED=0
NOTES=0

# ── Spinner ───────────────────────────────────────────────────────────────────
spinner_pid=""
spinner_chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")

start_spinner() {
  if [ -t 1 ]; then
    local i=0
    (
      while true; do
        printf "\r${DIM}  ${spinner_chars[$i]} installing...${RESET}"
        i=$(( (i + 1) % ${#spinner_chars[@]} ))
        sleep 0.1
      done
    ) &
    spinner_pid=$!
  fi
}

stop_spinner() {
  if [ -n "$spinner_pid" ]; then
    kill "$spinner_pid" 2>/dev/null
    wait "$spinner_pid" 2>/dev/null
    spinner_pid=""
    printf "\r${DIM}                                             ${RESET}\r"
  fi
}

# ── Phase header ──────────────────────────────────────────────────────────────
step()  {
  ((CURRENT_PHASE++))
  local pct=$(( CURRENT_PHASE * 100 / TOTAL_PHASES ))
  local filled=$(( pct / 5 ))
  local empty=$(( 20 - filled ))
  local bar=""
  for ((i=0; i<filled; i++)); do bar="${bar}█"; done
  for ((i=0; i<empty; i++)); do bar="${bar}░"; done
  printf "\n${CYAN}── Phase %d/%d: %s${RESET}\n" "$CURRENT_PHASE" "$TOTAL_PHASES" "$1"
  printf "${DIM}   [%s] %d%%%s\n" "$bar" "$pct" "$RESET"
}

# ── Status helpers ────────────────────────────────────────────────────────────
done_() {
  ((INSTALLED++))
  printf "  ${GREEN}✓${RESET} %s\n" "$1"
}

skip()  {
  ((SKIPPED++))
  printf "  ${BLUE}·${RESET} %s\n" "$1"
}

note()  {
  ((NOTES++))
  printf "  ${YELLOW}!${RESET} %s\n" "$1"
}

die()   {
  printf "  ${RED}✗${RESET} %s\n" "$1"
  exit 1
}

# ── OS detection ──────────────────────────────────────────────────────────────
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" == "Darwin" ]]; then
  BREW_PREFIX="/opt/homebrew"
  FONT_DIR="$HOME/Library/Fonts"
else
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"
  FONT_DIR="$HOME/.local/share/fonts"
fi

BREW="$BREW_PREFIX/bin/brew"
export PATH="$HOME/.local/bin:$BREW_PREFIX/bin:$PATH"

# ── Header ────────────────────────────────────────────────────────────────────
printf "\n"
printf "${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}  ${BOLD}⚡  AUT Linux Camp — Terminal Stack Setup${RESET}  ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"
printf "\n"
printf "  ${DIM}OS:${RESET}      $OS ($ARCH)\n"
printf "  ${DIM}Toolkit:${RESET}  $TOOLKIT_DIR\n"
printf "  ${DIM}Date:${RESET}     $(date '+%Y-%m-%d %H:%M')\n"
printf "\n"

# ── Phase 1: Homebrew ─────────────────────────────────────────────────────────
step "Homebrew"
if command -v "$BREW" &>/dev/null; then
  skip "homebrew"
else
  die "Homebrew not found at $BREW_PREFIX. Install from https://brew.sh first."
fi

brew_install() {
  local pkg="$1"
  local cmd="${2:-$1}"
  if command -v "$cmd" &>/dev/null || "$BREW" list "$pkg" &>/dev/null 2>&1; then
    skip "$pkg"
  else
    start_spinner
    "$BREW" install "$pkg" >/dev/null 2>&1 && done_ "$pkg" || {
      stop_spinner
      die "Failed to install $pkg"
    }
    stop_spinner
  fi
}

uv_tool_install() {
  local pkg="$1"
  local cmd="${2:-$1}"
  if command -v "$cmd" &>/dev/null; then
    skip "$pkg (uv tool)"
  else
    start_spinner
    uv tool install "$pkg" >/dev/null 2>&1 && done_ "$pkg" || {
      stop_spinner
      note "Failed to install $pkg via uv"
    }
    stop_spinner
  fi
}

# ── Phase 2: Shell ────────────────────────────────────────────────────────────
step "Shell — zsh + zinit + starship"

if command -v zsh &>/dev/null; then
  skip "zsh"
else
  if [[ "$OS" == "Darwin" ]]; then
    brew_install zsh
  else
    note "zsh not found. Install with: sudo apt install -y zsh"
    note "Then re-run this script."
    brew_install zsh
  fi
fi

ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ -d "$ZINIT_DIR" ]; then
  skip "zinit"
else
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR" >/dev/null 2>&1 \
    && done_ "zinit"
fi

brew_install starship

# ── Phase 3: Terminal ─────────────────────────────────────────────────────────
step "Terminal — WezTerm + Nerd Fonts"

if command -v wezterm &>/dev/null; then
  skip "wezterm"
else
  if [[ "$OS" == "Darwin" ]]; then
    brew install --cask wezterm >/dev/null 2>&1 && done_ "wezterm"
  else
    WEZTERM_DEB_URL="https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu24.04.deb"
    note "WezTerm: cannot install without sudo."
    note "Run manually: curl -LO $WEZTERM_DEB_URL && sudo apt install ./wezterm-nightly.Ubuntu24.04.deb"
  fi
fi

if (set +o pipefail; fc-list 2>/dev/null | grep -qi "jetbrainsmono nerd\|jetbrainsmono nf"); then
  skip "JetBrainsMono Nerd Font"
else
  bash "$TOOLKIT_DIR/scripts/install-fonts.sh" >/dev/null 2>&1 && done_ "JetBrainsMono Nerd Font"
fi

# ── Phase 4: Editor (micro) ───────────────────────────────────────────────────
step "Editor — micro"
brew_install micro

# ── Phase 5: Chezmoi + Config Management ──────────────────────────────────────
step "Chezmoi — dotfiles manager"
brew_install chezmoi

if chezmoi status &>/dev/null 2>&1; then
  skip "chezmoi already initialized"
else
  chezmoi init --source "$DOTFILES_DIR" >/dev/null 2>&1 && done_ "chezmoi init"
fi

absorb() {
  local file="$1"
  if [ -f "$file" ] && ! chezmoi managed "$file" &>/dev/null 2>&1; then
    chezmoi add "$file" >/dev/null 2>&1 && done_ "absorbed $file"
  fi
}
absorb "$HOME/.tmux.conf"
absorb "$HOME/.zshrc"

chezmoi apply --force --no-pager 2>/dev/null && done_ "chezmoi apply"

# ── Phase 6: Runtimes + Tools ─────────────────────────────────────────────────
step "Runtimes + Dev Tools"
brew_install mise
brew_install fzf
brew_install glow
brew_install lazygit
brew_install lazydocker
brew_install btop
brew_install yazi
brew_install "dlvhdr/formulae/diffnav" "diffnav"
brew_install treemd
brew_install d2

# ── Phase 7: Data, Notebooks & AI ────────────────────────────────────────────
step "Data, Notebooks & AI"
brew_install opencode

uv_tool_install visidata vd
uv_tool_install euporie
brew_install llmfit

if command -v aichat &>/dev/null; then
  skip "aichat"
else
  if command -v cargo &>/dev/null; then
    start_spinner
    cargo install aichat >/dev/null 2>&1 && done_ "aichat" || {
      stop_spinner
      note "aichat installation failed"
    }
    stop_spinner
  else
    note "aichat requires Rust — run: mise use rust@stable"
  fi
fi

brew_install intelli-shell

if command -v mmdc &>/dev/null; then
  skip "mmdc"
else
  if command -v npm &>/dev/null; then
    start_spinner
    npm install -g @mermaid-js/mermaid-cli >/dev/null 2>&1 && done_ "mmdc" || {
      stop_spinner
      note "mmdc installation failed"
    }
    stop_spinner
  else
    note "mmdc requires npm — run: mise use node@lts"
  fi
fi

# ── Phase 8: GitHub CLI + gh-dash + gh-enhance ────────────────────────────────
step "GitHub CLI + gh-dash + gh-enhance"
brew_install gh
if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-dash"; then
  skip "gh-dash extension"
else
  if gh auth status &>/dev/null 2>&1; then
    gh extension install dlvhdr/gh-dash >/dev/null 2>&1 && done_ "gh-dash extension"
  else
    note "gh not authenticated — run 'gh auth login' then: gh extension install dlvhdr/gh-dash"
  fi
fi

if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-enhance"; then
  skip "gh-enhance extension"
else
  if gh auth status &>/dev/null 2>&1; then
    gh extension install dlvhdr/gh-enhance >/dev/null 2>&1 && done_ "gh-enhance extension"
  else
    note "gh not authenticated — run 'gh auth login' then: gh extension install dlvhdr/gh-enhance"
  fi
fi

# ── Phase 9: Intelli-Shell Command Index ──────────────────────────────────────
step "Intelli-Shell — Command Index"
if command -v intelli-shell &>/dev/null; then
  CMD_FILE="$DOTFILES_DIR/private_dot_config/intelli-shell/commands.yml"
  if [ -f "$CMD_FILE" ]; then
    if [ -t 0 ]; then
      read -rp "  60+ stack commands ready. Prepopulate intelli-shell? [Y/n] " ans
    else
      ans="y"
    fi
    if [[ "$ans" != "n" && "$ans" != "N" ]]; then
      intelli-shell import "$CMD_FILE" 2>/dev/null && done_ "intelli-shell commands imported" \
        || note "import failed — run manually: intelli-shell import $CMD_FILE"
    else
      skip "intelli-shell import"
    fi
  fi
else
  note "intelli-shell not installed — skipping command index"
fi

# ── Summary ───────────────────────────────────────────────────────────────────
printf "\n"
printf "${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}  ${BOLD}${GREEN}✓  Setup Complete${RESET}                        ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"
printf "\n"

printf "  ${DIM}Installed:${RESET}  ${GREEN}${INSTALLED} packages${RESET}\n"
printf "  ${DIM}Skipped:${RESET}    ${BLUE}${SKIPPED} already present${RESET}\n"
if [ "$NOTES" -gt 0 ]; then
  printf "  ${DIM}Notes:${RESET}      ${YELLOW}${NOTES} items need attention${RESET}\n"
fi
printf "\n"

printf "  ${DIM}Next steps:${RESET}\n"
printf "  ${GREEN}→${RESET} Open a new terminal to activate your stack\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}dashboard${RESET} to see your stack status\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}cheat --start${RESET} for the interactive tour\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}doctor.sh${RESET} to verify 40/40 health\n"
printf "\n"

# ── Run doctor ────────────────────────────────────────────────────────────────
printf "${DIM}── Running health check...${RESET}\n\n"
bash "$TOOLKIT_DIR/doctor.sh"
