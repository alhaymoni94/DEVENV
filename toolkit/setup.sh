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
DIM="\033[2m"
RESET="\033[0m"

TOTAL_PHASES=9
CURRENT_PHASE=0

step()  {
  ((CURRENT_PHASE++))
  local pct=$(( CURRENT_PHASE * 100 / TOTAL_PHASES ))
  local bar=""
  for i in $(seq 1 20); do
    if [ $(( i * 5 )) -le "$pct" ]; then
      bar="${bar}█"
    else
      bar="${bar}░"
    fi
  done
  printf "\n${CYAN}▶ %s${DIM} [%s] %d%%%s\n" "$1" "$bar" "$pct" "$RESET"
}
done_() { printf "  ${GREEN}✓ %s${RESET}\n" "$1"; }
skip()  { printf "  ${BLUE}· %s${RESET}\n" "$1"; }
note()  { printf "  ${YELLOW}! %s${RESET}\n" "$1"; }
die()   { printf "  ${RED}✗ %s${RESET}\n" "$1"; exit 1; }

need_sudo() { note "This step needs sudo. Run: sudo $*"; }

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

printf "${CYAN}╔══════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║   Terminal Stack Setup                   ║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════╝${RESET}\n"
echo "   OS: $OS ($ARCH)"
echo "   Toolkit: $TOOLKIT_DIR"

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
    "$BREW" install "$pkg" && done_ "$pkg"
  fi
}

uv_tool_install() {
  local pkg="$1"
  local cmd="${2:-$1}"
  if command -v "$cmd" &>/dev/null; then
    skip "$pkg (uv tool)"
  else
    uv tool install "$pkg" && done_ "$pkg"
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
    # Try brew zsh as fallback
    brew_install zsh
  fi
fi

# zinit
ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ -d "$ZINIT_DIR" ]; then
  skip "zinit"
else
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR" \
    && done_ "zinit"
fi

brew_install starship

# ── Phase 3: Terminal ─────────────────────────────────────────────────────────
step "Terminal — WezTerm + Nerd Fonts"

if command -v wezterm &>/dev/null; then
  skip "wezterm"
else
  if [[ "$OS" == "Darwin" ]]; then
    brew install --cask wezterm && done_ "wezterm"
  else
    # Linux: download latest stable .deb
    WEZTERM_DEB_URL="https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu24.04.deb"
    note "WezTerm: cannot install without sudo."
    note "Run manually: curl -LO $WEZTERM_DEB_URL && sudo apt install ./wezterm-nightly.Ubuntu24.04.deb"
  fi
fi

# Nerd Fonts
if (set +o pipefail; fc-list 2>/dev/null | grep -qi "jetbrainsmono nerd\|jetbrainsmono nf"); then
  skip "JetBrainsMono Nerd Font"
else
  bash "$TOOLKIT_DIR/scripts/install-fonts.sh" && done_ "JetBrainsMono Nerd Font"
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
  chezmoi init --source "$DOTFILES_DIR" && done_ "chezmoi init"
fi

# Absorb existing configs if not yet managed
absorb() {
  local file="$1"
  if [ -f "$file" ] && ! chezmoi managed "$file" &>/dev/null 2>&1; then
    chezmoi add "$file" && done_ "absorbed $file"
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

# aichat
if command -v aichat &>/dev/null; then
  skip "aichat"
else
  if command -v cargo &>/dev/null; then
    cargo install aichat && done_ "aichat"
  else
    note "aichat requires Rust — run: mise use rust@stable"
  fi
fi

# intelli-shell
brew_install intelli-shell

# mmdc (mermaid-cli)
if command -v mmdc &>/dev/null; then
  skip "mmdc"
else
  if command -v npm &>/dev/null; then
    npm install -g @mermaid-js/mermaid-cli && done_ "mmdc"
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
    gh extension install dlvhdr/gh-dash && done_ "gh-dash extension"
  else
    note "gh not authenticated — run 'gh auth login' then: gh extension install dlvhdr/gh-dash"
  fi
fi

if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-enhance"; then
  skip "gh-enhance extension"
else
  if gh auth status &>/dev/null 2>&1; then
    gh extension install dlvhdr/gh-enhance && done_ "gh-enhance extension"
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
      # Interactive: ask the user
      read -rp "  60+ stack commands ready. Prepopulate intelli-shell? [Y/n] " ans
    else
      # Non-interactive (piped/scripted): default to yes
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

# ── Done — run doctor ─────────────────────────────────────────────────────────
echo
printf "\033[1;36m── Setup complete. Running doctor...\033[0m\n"
bash "$TOOLKIT_DIR/doctor.sh"
