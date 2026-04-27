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

# Core vs extended tool tracking
ok_core()   { ok "$1" "${2:-}";  PASS_CORE=$((PASS_CORE+1)); }
fail_core() { fail "$1" "$2";    FAIL_CORE=$((FAIL_CORE+1)); }
ok_ext()    { ok "$1" "${2:-}";  PASS_EXT=$((PASS_EXT+1)); }
warn_ext()  { warn "$1" "$2";    FAIL_EXT=$((FAIL_EXT+1)); }

PASS=0; WARN=0; FAIL=0
PASS_CORE=0; FAIL_CORE=0
PASS_EXT=0;  FAIL_EXT=0

# ── Resolve paths relative to this script ─────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CAMP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

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
  command -v "$tool" &>/dev/null && ok_core "$tool" || fail_core "$tool" "sudo apt install $tool"
done
command -v "$BREW" &>/dev/null && ok_core "homebrew" "$($BREW --version 2>/dev/null | head -1)" \
  || fail_core "homebrew" "https://brew.sh"

# ── 2. Shell ──────────────────────────────────────────────────────────────────
section "Shell"
if command -v zsh &>/dev/null; then
  ZSH_VER="$(zsh --version 2>/dev/null | awk '{print $2}')"
  ok_core "zsh" "v$ZSH_VER"
  ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
  [ -d "$ZINIT_DIR" ] && ok "zinit" || warn "zinit" "git clone https://github.com/zdharma-continuum/zinit $ZINIT_DIR"
else
  fail_core "zsh" "$INSTALL_ZSH"
fi
if command -v starship &>/dev/null; then
  ok_core "starship" "$(starship --version | head -1)"
else
  fail_core "starship" "brew install starship"
fi
_USER="${USER:-$(whoami)}"
if [[ "$OS" == "Darwin" ]]; then
  CURRENT_SHELL="$(dscl . -read /Users/"$_USER" UserShell 2>/dev/null | awk '{print $2}')"
else
  CURRENT_SHELL="$(getent passwd "$_USER" 2>/dev/null | cut -d: -f7)"
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
  || warn "nerd font" "run: bash $CAMP_DIR/toolkit/scripts/install-fonts.sh"

# ── 4. Multiplexer ────────────────────────────────────────────────────────────
section "Multiplexer"
if command -v tmux &>/dev/null; then
  ok_core "tmux" "$(tmux -V)"
  [ -f "$HOME/.tmux.conf" ] && ok "tmux config" || warn "tmux config" "chezmoi apply"
else
  fail_core "tmux" "brew install tmux"
fi

# ── 5. Editor ─────────────────────────────────────────────────────────────────
section "Editor (micro)"
command -v micro &>/dev/null && ok_core "micro" "$(micro --version 2>/dev/null | head -1)" \
  || fail_core "micro" "brew install micro"

# ── 6. Dotfiles ───────────────────────────────────────────────────────────────
section "Dotfiles"
if command -v chezmoi &>/dev/null; then
  ok_core "chezmoi" "$(chezmoi --version | head -1)"
  SOURCE_DIR="$CAMP_DIR/toolkit/dotfiles"
  if [ -d "$SOURCE_DIR" ]; then
    ok "chezmoi source" "$SOURCE_DIR"
    STATUS="$(chezmoi status 2>/dev/null | wc -l | tr -d ' ')"
    [ "$STATUS" -eq 0 ] && ok "chezmoi status" "clean" \
      || warn "chezmoi status" "$STATUS file(s) out of sync — run: chezmoi apply"
  else
    warn "chezmoi source" "run: chezmoi init --source $CAMP_DIR/toolkit/dotfiles"
  fi
else
  fail_core "chezmoi" "brew install chezmoi"
fi

# ── 7. Runtimes ───────────────────────────────────────────────────────────────
section "Runtimes"
command -v uv &>/dev/null && ok_core "uv" "$(uv --version 2>/dev/null)" \
  || fail_core "uv" "brew install uv"
command -v mise &>/dev/null && ok_core "mise" "$(mise --version 2>/dev/null)" \
  || fail_core "mise" "brew install mise"

# ── 8. Dev Tools ──────────────────────────────────────────────────────────────
section "Dev Tools"
command -v fzf        &>/dev/null && ok_core "fzf"        || fail_core "fzf"        "brew install fzf"
command -v lazygit    &>/dev/null && ok_core "lazygit"    || fail_core "lazygit"    "brew install lazygit"
command -v lazydocker &>/dev/null && ok_ext  "lazydocker" || warn_ext  "lazydocker" "brew install lazydocker"
command -v btop       &>/dev/null && ok_core "btop"       || fail_core "btop"       "brew install btop"
command -v yazi       &>/dev/null && ok_core "yazi"       || fail_core "yazi"       "brew install yazi"
command -v glow       &>/dev/null && ok_core "glow"       || fail_core "glow"       "brew install glow"
command -v docker     &>/dev/null && ok "docker"          || warn "docker"          "install Docker Desktop or docker-ce"
command -v diffnav    &>/dev/null && ok_ext  "diffnav"    || warn_ext  "diffnav"    "brew install dlvhdr/formulae/diffnav"
command -v treemd     &>/dev/null && ok_ext  "treemd"     || warn_ext  "treemd"     "brew install treemd"
command -v d2         &>/dev/null && ok_ext  "d2"         || warn_ext  "d2"         "brew install d2"

# ── 9. GitHub ─────────────────────────────────────────────────────────────────
section "GitHub"
if command -v gh &>/dev/null; then
  ok_core "gh" "$(gh --version | head -1)"
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
  fail_core "gh" "brew install gh"
fi

# ── 10. Data, Notebooks & AI ────────────────────────────────────────────────
section "Data, Notebooks & AI  (extended — optional)"
command -v opencode &>/dev/null && ok_ext "opencode" || warn_ext "opencode" "brew install opencode (optional)"
command -v euporie  &>/dev/null && ok_ext "euporie"  || warn_ext "euporie"  "uv tool install euporie"
command -v visidata &>/dev/null && ok_ext "visidata" || warn_ext "visidata" "uv tool install visidata"
command -v llmfit   &>/dev/null && ok_ext "llmfit"   || warn_ext "llmfit"   "brew install llmfit"
if command -v intelli-shell &>/dev/null; then
  ok_ext "intelli-shell" "installed"
  if grep -q "intelli-shell init zsh" "$HOME/.zshrc" 2>/dev/null; then
    ok "intelli-shell init" "shell integration loaded"
  else
    warn "intelli-shell init" "run: echo 'eval \"\$(intelli-shell init zsh)\"' >> ~/.zshrc"
  fi
else
  warn_ext "intelli-shell" "brew install intelli-shell"
fi
command -v mmdc &>/dev/null && ok_ext "mmdc" || warn_ext "mmdc" "npm install -g @mermaid-js/mermaid-cli"

# ── Keyboard note ─────────────────────────────────────────────────────────────
section "System Note"
echo "   Caps Lock → Ctrl remapping:"
echo "   $CAPS_NOTE"

# ── Summary ───────────────────────────────────────────────────────────────────
TOTAL_CORE=$((PASS_CORE + FAIL_CORE))
TOTAL_EXT=$((PASS_EXT + FAIL_EXT))
HEALTH_CORE=$(( TOTAL_CORE > 0 ? PASS_CORE * 100 / TOTAL_CORE : 100 ))
HEALTH_EXT=$(( TOTAL_EXT  > 0 ? PASS_EXT  * 100 / TOTAL_EXT  : 100 ))

build_bar() {
  local pct="$1" bar="" i pct_i
  for i in $(seq 1 30); do
    pct_i=$(( i * 100 / 30 ))
    [ "$pct_i" -le "$pct" ] && bar="${bar}█" || bar="${bar}░"
  done
  printf "%s" "$bar"
}

echo
printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║   Stack Health Report                ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n"
echo
printf "  Core    : [%s] %d%%  (%d/%d)\n" "$(build_bar "$HEALTH_CORE")" "$HEALTH_CORE" "$PASS_CORE" "$TOTAL_CORE"
printf "  Extended: [%s] %d%%  (%d/%d)\n" "$(build_bar "$HEALTH_EXT")"  "$HEALTH_EXT"  "$PASS_EXT"  "$TOTAL_EXT"
echo
printf "  \033[32m✓ %d passed\033[0m   \033[33m⚠ %d warnings\033[0m   \033[31m✗ %d failed\033[0m\n" \
  "$PASS" "$WARN" "$FAIL"
printf "  \033[2m(Extended tool failures shown as warnings, not core failures)\033[0m\n"
echo

if [ "$FAIL_CORE" -eq 0 ] && [ "$FAIL_EXT" -eq 0 ] && [ "$WARN" -eq 0 ]; then
  printf "\033[1;32m  ╔══════════════════════════════════════════╗\033[0m\n"
  printf "\033[1;32m  ║   ✓ Stack is fully healthy               ║\033[0m\n"
  printf "\033[1;32m  ╚══════════════════════════════════════════╝\033[0m\n"
elif [ "$FAIL_CORE" -gt 0 ]; then
  printf "\033[1;31m  ✗ Core tool(s) missing — run setup.sh to resolve\033[0m\n"
elif [ "$FAIL_EXT" -gt 0 ]; then
  printf "\033[1;33m  ⚠ Core stack healthy. Some extended tools missing.\033[0m\n"
  printf "\033[1;33m    Run setup.sh to install, or continue without them.\033[0m\n"
else
  printf "\033[1;33m  ⚠ Core stack healthy. Minor config items need attention (see warnings above).\033[0m\n"
fi
echo
