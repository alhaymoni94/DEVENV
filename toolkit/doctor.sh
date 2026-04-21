#!/usr/bin/env bash
# doctor.sh — Terminal stack health check
# Safe to run anytime. Green = healthy, Yellow = config missing, Red = not installed.

set -u

# ── Color helpers ─────────────────────────────────────────────────────────────
BOLD="\033[1m"
CYAN="\033[1;36m"
BLUE="\033[1;34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"

ok()   { printf "${GREEN}✓${RESET} %-22s %s\n" "$1" "${2:-}"; PASS=$((PASS+1)); }
warn() { printf "${YELLOW}⚠${RESET} %-22s %s\n" "$1" "$2";     WARN=$((WARN+1)); }
fail() { printf "${RED}✗${RESET} %-22s → %s\n" "$1" "$2";   FAIL=$((FAIL+1)); }
info() { printf "${BLUE}·${RESET} %-22s %s\n" "$1" "$2"; }
section() { echo; printf "${BOLD}${DIM}── %s${RESET}\n" "$1"; }

PASS=0; WARN=0; FAIL=0

# ── OS detection ──────────────────────────────────────────────────────────────
OS="$(uname -s)"
ARCH="$(uname -m)"
if [[ "$OS" == "Darwin" ]]; then
  BREW_PREFIX="/opt/homebrew"
  INSTALL_ZSH="brew install zsh"
  FONT_DIR="$HOME/Library/Fonts"
  CAPS_NOTE="System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys → Caps Lock → Control"
else
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"
  INSTALL_ZSH="sudo apt install zsh  OR  brew install zsh"
  FONT_DIR="$HOME/.local/share/fonts"
  CAPS_NOTE="GNOME Settings → Keyboard → Special Character Entry → Caps Lock behavior"
fi
BREW="$BREW_PREFIX/bin/brew"
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$BREW_PREFIX/bin:$PATH"

printf "${CYAN}╔══════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║   Terminal Stack Doctor              ║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════╝${RESET}\n"
printf "   OS: %s (%s)  |  %s\n" "$OS" "$ARCH" "$(date '+%Y-%m-%d %H:%M')"

# ── 1. Prerequisites ──────────────────────────────────────────────────────────
section "Prerequisites"
for tool in git curl unzip; do
  command -v "$tool" &>/dev/null && ok "$tool" || fail "$tool" "sudo apt install $tool"
done
command -v "$BREW" &>/dev/null && ok "homebrew" "$($BREW --version 2>/dev/null | head -1)" \
  || fail "homebrew" "https://brew.sh"

# ── 2. Shell ──────────────────────────────────────────────────────────────────
section "Shell"
if command -v zsh &>/dev/null; then
  ZSH_VER="$(zsh --version 2>/dev/null | awk '{print $2}')"
  ok "zsh" "v$ZSH_VER"
  ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
  [ -d "$ZINIT_DIR" ] && ok "zinit" || warn "zinit" "git clone https://github.com/zdharma-continuum/zinit $ZINIT_DIR"
else
  fail "zsh" "$INSTALL_ZSH"
fi
if command -v starship &>/dev/null; then
  ok "starship" "$(starship --version | head -1)"
else
  fail "starship" "brew install starship"
fi
if [[ "$OS" == "Darwin" ]]; then
  CURRENT_SHELL="$(dscl . -read /Users/"$USER" UserShell 2>/dev/null | awk '{print $2}')"
else
  CURRENT_SHELL="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
fi
[[ "$CURRENT_SHELL" == *zsh* ]] && ok "default shell" "zsh" || warn "default shell" "run: chsh -s \$(which zsh)  [current: $CURRENT_SHELL]"

# ── 3. Terminal ───────────────────────────────────────────────────────────────
section "Terminal"
if command -v wezterm &>/dev/null; then
  ok "wezterm" "$(wezterm --version 2>/dev/null | head -1)"
  WEZTERM_CFG="$HOME/.config/wezterm/wezterm.lua"
  [ -f "$WEZTERM_CFG" ] && ok "wezterm config" || warn "wezterm config" "chezmoi apply (config at toolkit/dotfiles)"
else
  fail "wezterm" "download AppImage from github.com/wez/wezterm/releases"
fi
fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd\|JetBrainsMono NF" \
  && ok "nerd font" "JetBrainsMono detected" \
  || warn "nerd font" "run: bash ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/scripts/install-fonts.sh"

# ── 4. Multiplexer ────────────────────────────────────────────────────────────
section "Multiplexer"
if command -v tmux &>/dev/null; then
  ok "tmux" "$(tmux -V)"
  [ -f "$HOME/.tmux.conf" ] && ok "tmux config" || warn "tmux config" "chezmoi apply"
else
  fail "tmux" "brew install tmux"
fi

# ── 5. Editor ─────────────────────────────────────────────────────────────────
section "Editor (micro)"
command -v micro &>/dev/null && ok "micro" "$(micro --version 2>/dev/null | head -1)" \
  || fail "micro" "brew install micro"

# ── 6. Dotfiles ───────────────────────────────────────────────────────────────
section "Dotfiles"
if command -v chezmoi &>/dev/null; then
  ok "chezmoi" "$(chezmoi --version | head -1)"
  SOURCE_DIR="$HOME/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles"
  if [ -d "$SOURCE_DIR" ]; then
    ok "chezmoi source" "$SOURCE_DIR"
    STATUS="$(chezmoi status 2>/dev/null | wc -l | tr -d ' ')"
    [ "$STATUS" -eq 0 ] && ok "chezmoi status" "clean" \
      || warn "chezmoi status" "$STATUS file(s) out of sync — run: chezmoi apply"
  else
    warn "chezmoi source" "run: chezmoi init --source ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles"
  fi
else
  fail "chezmoi" "brew install chezmoi"
fi

# ── 7. Runtimes ───────────────────────────────────────────────────────────────
section "Runtimes"
command -v uv &>/dev/null && ok "uv" "$(uv --version 2>/dev/null)" \
  || fail "uv" "curl -LsSf https://astral.sh/uv/install.sh | sh"
command -v mise &>/dev/null && ok "mise" "$(mise --version 2>/dev/null)" \
  || fail "mise" "brew install mise"

# ── 8. Dev Tools ──────────────────────────────────────────────────────────────
section "Dev Tools"
command -v fzf        &>/dev/null && ok "fzf"        || fail "fzf"        "brew install fzf"
command -v lazygit    &>/dev/null && ok "lazygit"    || fail "lazygit"    "brew install lazygit"
command -v lazydocker &>/dev/null && ok "lazydocker" || fail "lazydocker" "brew install lazydocker"
command -v btop       &>/dev/null && ok "btop"       || fail "btop"       "brew install btop"
command -v yazi       &>/dev/null && ok "yazi"       || fail "yazi"       "brew install yazi"
command -v glow       &>/dev/null && ok "glow"       || fail "glow"       "brew install glow"
command -v docker     &>/dev/null && ok "docker"     || warn "docker"     "install Docker Desktop or docker-ce"
command -v diffnav    &>/dev/null && ok "diffnav"    || fail "diffnav"    "brew install dlvhdr/formulae/diffnav"
command -v treemd     &>/dev/null && ok "treemd"     || fail "treemd"     "brew install treemd"
command -v d2         &>/dev/null && ok "d2"         || fail "d2"         "brew install d2"

# ── 9. GitHub ─────────────────────────────────────────────────────────────────
section "GitHub"
if command -v gh &>/dev/null; then
  ok "gh" "$(gh --version | head -1)"
  if gh auth status &>/dev/null 2>&1; then
    ok "gh auth" "authenticated"
  else
    warn "gh auth" "run: gh auth login"
  fi
  if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-dash"; then
    ok "gh-dash" "installed"
  else
    warn "gh-dash" "run: gh extension install dlvhdr/gh-dash"
  fi
  if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-enhance"; then
    ok "gh-enhance" "installed"
  else
    warn "gh-enhance" "run: gh extension install dlvhdr/gh-enhance"
  fi
else
  fail "gh" "brew install gh"
fi

# ── 10. Data, Notebooks & AI ────────────────────────────────────────────────
section "Data, Notebooks & AI"
command -v opencode &>/dev/null && ok "opencode" || fail "opencode" "brew install opencode"
command -v euporie  &>/dev/null && ok "euporie"  || fail "euporie"  "uv tool install euporie"
command -v visidata &>/dev/null && ok "visidata" || fail "visidata" "uv tool install visidata"
command -v llmfit   &>/dev/null && ok "llmfit"   || fail "llmfit"   "brew install llmfit"
command -v intelli-shell &>/dev/null && ok "intelli-shell" || fail "intelli-shell" "brew install intelli-shell"
command -v aichat   &>/dev/null && ok "aichat"   || warn "aichat"   "cargo install aichat  OR  mise use rust@stable"

command -v mmdc     &>/dev/null && ok "mmdc"     || fail "mmdc"     "npm install -g @mermaid-js/mermaid-cli"

# ── Keyboard note ─────────────────────────────────────────────────────────────
section "System Note"
echo "   Caps Lock → Ctrl remapping:"
echo "   $CAPS_NOTE"

# ── Summary ───────────────────────────────────────────────────────────────────
TOTAL=$((PASS + WARN + FAIL))
HEALTH_PCT=$(( PASS * 100 / TOTAL ))

# Build health bar
bar=""
for i in $(seq 1 30); do
  pct=$(( i * 100 / 30 ))
  if [ "$pct" -le "$HEALTH_PCT" ]; then
    bar="${bar}█"
  else
    bar="${bar}░"
  fi
done

echo
printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║   Stack Health Report                ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n"
echo
printf "  Health: [%s] %d%%\n" "$bar" "$HEALTH_PCT"
echo
printf "  \033[32m✓ %d passed\033[0m   \033[33m⚠ %d warnings\033[0m   \033[31m✗ %d failed\033[0m   (of %d checks)\n" \
  "$PASS" "$WARN" "$FAIL" "$TOTAL"
echo

if [ "$FAIL" -eq 0 ] && [ "$WARN" -eq 0 ]; then
  printf "\033[1;32m  ╔══════════════════════════════════════════╗\033[0m\n"
  printf "\033[1;32m  ║   ✓ Stack is fully healthy               ║\033[0m\n"
  printf "\033[1;32m  ╚══════════════════════════════════════════╝\033[0m\n"
elif [ "$FAIL" -eq 0 ]; then
  printf "\033[1;33m  ⚠ Minor issues — run setup.sh to resolve\033[0m\n"
else
  printf "\033[1;31m  ✗ Issues found — run setup.sh to resolve\033[0m\n"
fi
echo
