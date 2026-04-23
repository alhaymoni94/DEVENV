#!/usr/bin/env bash
# setup.sh — Terminal stack installer + doctor
# Installs missing tools, skips already installed ones, ends with a doctor report.
# Safe to re-run at any time.

set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$TOOLKIT_DIR/dotfiles"
CONFIG_FILE="$TOOLKIT_DIR/.setup-config"

BOLD="\033[1m" CYAN="\033[1;36m" BLUE="\033[1;34m" GREEN="\033[32m" YELLOW="\033[33m" RED="\033[31m" MAGENTA="\033[1;35m" DIM="\033[2m" RESET="\033[0m"

TOTAL_PHASES=10 CURRENT_PHASE=0 INSTALLED=0 SKIPPED=0 NOTES=0

spinner_pid="" spinner_chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")

start_spinner() {
  [ -t 1 ] || return 0
  local i=0
  (while true; do printf "\r${DIM}  ${spinner_chars[$i]} installing...${RESET}"; i=$(( (i + 1) % ${#spinner_chars[@]} )); sleep 0.1; done) &
  spinner_pid=$!
}

stop_spinner() {
  [ -n "$spinner_pid" ] || return 0
  kill "$spinner_pid" 2>/dev/null; wait "$spinner_pid" 2>/dev/null
  spinner_pid=""; printf "\r${DIM}                                             ${RESET}\r"
}

step()  { CURRENT_PHASE=$(( CURRENT_PHASE + 1 )); local pct=$(( CURRENT_PHASE * 100 / TOTAL_PHASES )); local filled=$(( pct / 5 )); local empty=$(( 20 - filled )); local bar=""; for ((i=0; i<filled; i++)); do bar="${bar}█"; done; for ((i=0; i<empty; i++)); do bar="${bar}░"; done; printf "\n${CYAN}── Phase %d/%d: %s${RESET}\n" "$CURRENT_PHASE" "$TOTAL_PHASES" "$1"; printf "${DIM}   [%s] %d%%%s\n" "$bar" "$pct" "$RESET"; }
done_() { INSTALLED=$(( INSTALLED + 1 )); printf "  ${GREEN}✓${RESET} %s\n" "$1"; }
skip()  { SKIPPED=$(( SKIPPED + 1 )); printf "  ${BLUE}·${RESET} %s\n" "$1"; }
note()  { NOTES=$(( NOTES + 1 )); printf "  ${YELLOW}!${RESET} %s\n" "$1"; }
die()   { printf "  ${RED}✗${RESET} %s\n" "$1"; exit 1; }

ask() {
  local prompt="$1" default="$2" var_name="$3" answer
  [ -n "$default" ] && printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[%s]${RESET} " "$prompt" "$default" || printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} " "$prompt"
  [ -t 0 ] && read -r answer || answer="$default"
  [ -z "$answer" ] && [ -n "$default" ] && answer="$default"
  eval "$var_name='$answer'"
}

ask_secret() {
  local prompt="$1" var_name="$2" answer
  printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} " "$prompt"
  [ -t 0 ] && read -rs answer && printf "\n" || read -r answer
  eval "$var_name='$answer'"
}

ask_choice() {
  local prompt="$1" default="$2" var_name="$3"
  shift 3; local options=("$@") answer
  printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET}\n" "$prompt"
  for i in "${!options[@]}"; do
    [ "${options[$i]}" = "$default" ] && printf "    ${GREEN}%d) %s${RESET} ${DIM}(default)${RESET}\n" "$((i+1))" "${options[$i]}" || printf "    ${DIM}%d) %s${RESET}\n" "$((i+1))" "${options[$i]}"
  done
  printf "  ${CYAN}→${RESET} ${DIM}Choice${RESET} ${DIM}[%s]${RESET} " "$default"
  [ -t 0 ] && read -r answer || answer=""
  [ -z "$answer" ] && answer="$default"
  [[ "$answer" =~ ^[0-9]+$ ]] && [ "$answer" -ge 1 ] && [ "$answer" -le "${#options[@]}" ] && answer="${options[$((answer-1))]}"
  eval "$var_name='$answer'"
}

ask_confirm() {
  local prompt="$1" default="${2:-Y}" answer
  [ "$default" = "Y" ] && printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[Y/n]${RESET} " "$prompt" || printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[y/N]${RESET} " "$prompt"
  [ -t 0 ] && read -r answer || answer="$default"
  [ -z "$answer" ] && answer="$default"
  [[ "$answer" =~ ^[Yy]$ ]]; return $?
}

save_config() {
  cat > "$CONFIG_FILE" << EOF
# AUT Linux Camp — Setup Configuration
# Generated: $(date '+%Y-%m-%d %H:%M')
# Edit this file directly or re-run setup.sh to change values

STUDENT_NAME="$STUDENT_NAME"
STUDENT_EMAIL="$STUDENT_EMAIL"
GITHUB_USERNAME="$GITHUB_USERNAME"
GIT_EDITOR="$GIT_EDITOR"
AI_PROVIDER="$AI_PROVIDER"
AI_MODEL="$AI_MODEL"
ENABLE_DOCKER="$ENABLE_DOCKER"
ENABLE_AI="$ENABLE_AI"
COLORSCHEME="$COLORSCHEME"
TAB_SIZE="$TAB_SIZE"
TIMEZONE="$TIMEZONE"
EOF
  printf "\n  ${GREEN}✓${RESET} Configuration saved to ${BOLD}.setup-config${RESET}\n"
  printf "  ${DIM}Edit this file directly to change settings later.${RESET}\n"
}

load_config() { [ -f "$CONFIG_FILE" ] && { source "$CONFIG_FILE"; return 0; }; return 1; }

OS="$(uname -s)" ARCH="$(uname -m)"
if [[ "$OS" == "Darwin" ]]; then BREW_PREFIX="/opt/homebrew"; FONT_DIR="$HOME/Library/Fonts"
else BREW_PREFIX="/home/linuxbrew/.linuxbrew"; FONT_DIR="$HOME/.local/share/fonts"; fi
BREW="$BREW_PREFIX/bin/brew"
export PATH="$HOME/.local/bin:$BREW_PREFIX/bin:$PATH"

printf "\n${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}  ${BOLD}⚡  AUT Linux Camp — Terminal Stack Setup${RESET}  ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"
printf "\n  ${DIM}OS:${RESET}      $OS ($ARCH)\n  ${DIM}Toolkit:${RESET}  $TOOLKIT_DIR\n  ${DIM}Date:${RESET}     $(date '+%Y-%m-%d %H:%M')\n\n"

step "Configuration — Tell us about yourself"

if load_config; then
  printf "\n  ${DIM}Existing configuration found.${RESET}\n"
  printf "  ${DIM}Name: ${STUDENT_NAME:-not set}${RESET}\n"
  printf "  ${DIM}Email: ${STUDENT_EMAIL:-not set}${RESET}\n"
  printf "  ${DIM}GitHub: ${GITHUB_USERNAME:-not set}${RESET}\n"
  printf "  ${DIM}AI: ${AI_PROVIDER:-not set} (${AI_MODEL:-not set})${RESET}\n\n"
  if ask_confirm "Use existing configuration?" "Y"; then
    printf "  ${GREEN}✓${RESET} Using existing configuration\n"
  else
    printf "  ${YELLOW}!${RESET} Re-configuring...\n\n"
    STUDENT_NAME="" STUDENT_EMAIL="" GITHUB_USERNAME="" AI_API_KEY=""
  fi
fi

if [ -z "${STUDENT_NAME:-}" ]; then
  printf "\n${BOLD}── Student Information ──${RESET}\n\n"
  ask "Your full name" "$(whoami)" "STUDENT_NAME"
  ask "Your email (for git commits)" "" "STUDENT_EMAIL"
  ask "GitHub username" "" "GITHUB_USERNAME"

  printf "\n${BOLD}── Editor Preferences ──${RESET}\n\n"
  ask_choice "Preferred editor colorscheme" "gruvbox" "COLORSCHEME" "gruvbox" "solarized" "monokai" "nord" "tokyonight" "default"
  ask "Tab size" "4" "TAB_SIZE"

  printf "\n${BOLD}── AI Configuration ──${RESET}\n\n"
  ask_confirm "Enable AI tools? (requires paid API key or personal subscription)" "N" && ENABLE_AI="Y" || ENABLE_AI="N"

  if [ "$ENABLE_AI" = "Y" ]; then
    ask_choice "AI Provider" "openai" "AI_PROVIDER" "openai" "anthropic" "gemini" "ollama" "custom"
    ask "AI Model" "gpt-4o" "AI_MODEL"
    ask_secret "API Key" "AI_API_KEY"
  fi

  printf "\n${BOLD}── System Preferences ──${RESET}\n\n"
  ask_confirm "Enable Docker support?" "Y" && ENABLE_DOCKER="Y" || ENABLE_DOCKER="N"

  detected_tz=""
  [ -f /etc/timezone ] && detected_tz=$(cat /etc/timezone)
  detected_tz="${detected_tz:-$(timedatectl show --property=Timezone --value 2>/dev/null || true)}"
  ask "Timezone" "${detected_tz:-UTC}" "TIMEZONE"

  printf "\n${BOLD}── Configuration Summary ──${RESET}\n\n"
  printf "  ${DIM}Name:${RESET}          ${BOLD}$STUDENT_NAME${RESET}\n"
  printf "  ${DIM}Email:${RESET}         ${BOLD}${STUDENT_EMAIL:-not set}${RESET}\n"
  printf "  ${DIM}GitHub:${RESET}        ${BOLD}${GITHUB_USERNAME:-not set}${RESET}\n"
  printf "  ${DIM}Editor theme:${RESET}  ${BOLD}$COLORSCHEME${RESET}\n"
  printf "  ${DIM}Tab size:${RESET}      ${BOLD}$TAB_SIZE${RESET}\n"
  printf "  ${DIM}AI provider:${RESET}   ${BOLD}${AI_PROVIDER:-disabled}${RESET}\n"
  printf "  ${DIM}AI model:${RESET}      ${BOLD}${AI_MODEL:-N/A}${RESET}\n"
  printf "  ${DIM}Docker:${RESET}        ${BOLD}${ENABLE_DOCKER:-Y}${RESET}\n"
  printf "  ${DIM}Timezone:${RESET}      ${BOLD}${TIMEZONE:-UTC}${RESET}\n\n"

  ask_confirm "Save and continue?" "Y" && save_config || die "Setup cancelled."
fi

[ -t 0 ] && printf "\n  ${DIM}Applying configurations...${RESET}\n"

if [ -n "${STUDENT_NAME:-}" ] && [ -n "${STUDENT_EMAIL:-}" ]; then
  [ -t 0 ] && printf "  ${GREEN}✓${RESET} Configuring git: ${STUDENT_NAME} <${STUDENT_EMAIL}>\n"
  git config --global user.name "$STUDENT_NAME" 2>/dev/null || true
  git config --global user.email "$STUDENT_EMAIL" 2>/dev/null || true
fi

[ -n "${GITHUB_USERNAME:-}" ] && [ -t 0 ] && printf "  ${GREEN}✓${RESET} GitHub username: ${GITHUB_USERNAME}\n"

if [ "${ENABLE_AI:-N}" = "Y" ] && [ -n "${AI_API_KEY:-}" ]; then
  mkdir -p "$HOME/.config/opencode"
  cat > "$HOME/.config/opencode/config.json" << EOF
{
  "providers": { "${AI_PROVIDER}": { "model": "${AI_MODEL}", "apiKey": "${AI_API_KEY}" } }
}
EOF
  [ -t 0 ] && printf "  ${GREEN}✓${RESET} AI configured: ${AI_PROVIDER} (${AI_MODEL})\n"
fi

if [ -n "${COLORSCHEME:-}" ]; then
  MICRO_CONFIG="$HOME/.config/micro"
  mkdir -p "$MICRO_CONFIG"
  cat > "$MICRO_CONFIG/settings.json" << EOF
{
    "colorscheme": "${COLORSCHEME}",
    "tabsize": ${TAB_SIZE:-4},
    "autosave": true
}
EOF
  [ -t 0 ] && printf "  ${GREEN}✓${RESET} Editor theme: ${COLORSCHEME}, tab size: ${TAB_SIZE:-4}\n"
fi

step "Homebrew"
command -v "$BREW" &>/dev/null && skip "homebrew" || die "Homebrew not found at $BREW_PREFIX. Install from https://brew.sh first."

brew_install() {
  local pkg="$1" cmd="${2:-$1}"
  if command -v "$cmd" &>/dev/null || "$BREW" list "$pkg" &>/dev/null 2>&1; then skip "$pkg"
  else start_spinner; "$BREW" install "$pkg" >/dev/null 2>&1 && done_ "$pkg" || { stop_spinner; note "Failed to install $pkg — run: brew install $pkg"; }; stop_spinner
  fi
}

uv_tool_install() {
  local pkg="$1" cmd="${2:-$1}"
  if command -v "$cmd" &>/dev/null; then skip "$pkg (uv tool)"
  else start_spinner; uv tool install "$pkg" >/dev/null 2>&1 && done_ "$pkg" || { stop_spinner; note "Failed to install $pkg via uv"; }; stop_spinner
  fi
}

step "Shell — zsh + zinit + starship"

command -v zsh &>/dev/null && skip "zsh" || {
  [[ "$OS" == "Darwin" ]] && brew_install zsh || { note "zsh not found. Install with: sudo apt install -y zsh"; note "Then re-run this script."; brew_install zsh; }
}

ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[ -d "$ZINIT_DIR" ] && skip "zinit" || { git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR" >/dev/null 2>&1 && done_ "zinit"; }
brew_install starship

step "Terminal — WezTerm + Nerd Fonts"

command -v wezterm &>/dev/null && skip "wezterm" || {
  [[ "$OS" == "Darwin" ]] && brew install --cask wezterm >/dev/null 2>&1 && done_ "wezterm" || { WEZTERM_DEB_URL="https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu24.04.deb"; note "WezTerm: cannot install without sudo."; note "Run manually: curl -LO $WEZTERM_DEB_URL && sudo apt install ./wezterm-nightly.Ubuntu24.04.deb"; }
}

(set +o pipefail; fc-list 2>/dev/null | grep -qi "jetbrainsmono nerd\|jetbrainsmono nf") && skip "JetBrainsMono Nerd Font" || { bash "$TOOLKIT_DIR/scripts/install-fonts.sh" >/dev/null 2>&1 && done_ "JetBrainsMono Nerd Font"; }

step "Editor — micro"
brew_install micro

step "Chezmoi — dotfiles manager"
brew_install chezmoi
if chezmoi status &>/dev/null 2>&1; then
  skip "chezmoi already initialized"
else
  chezmoi init --source "$DOTFILES_DIR" >/dev/null 2>&1 && done_ "chezmoi init"
fi

absorb() { local file="$1"; [ -f "$file" ] && ! chezmoi managed "$file" &>/dev/null 2>&1 && chezmoi add "$file" >/dev/null 2>&1 && done_ "absorbed $file"; }
absorb "$HOME/.tmux.conf"
absorb "$HOME/.zshrc"
chezmoi apply --force --no-pager 2>/dev/null && done_ "chezmoi apply"

step "Runtimes + Dev Tools"
for pkg in mise fzf glow lazygit lazydocker btop yazi "dlvhdr/formulae/diffnav" treemd d2; do brew_install "$pkg"; done

step "Data, Notebooks & AI"
brew_install opencode
uv_tool_install visidata vd
uv_tool_install euporie
brew_install llmfit

[ -x "$TOOLKIT_DIR/scripts/ai" ] && done_ "ai wrapper (opencode)" || note "ai wrapper script not found"
brew_install intelli-shell

command -v mmdc &>/dev/null && skip "mmdc" || {
  if command -v npm &>/dev/null; then
    start_spinner; npm install -g @mermaid-js/mermaid-cli >/dev/null 2>&1 && done_ "mmdc" || { stop_spinner; note "mmdc installation failed"; }; stop_spinner
  else note "mmdc requires npm — run: mise use node@lts"; fi
}

step "GitHub CLI + gh-dash + gh-enhance"
brew_install gh
gh extension list 2>/dev/null | grep -q "dlvhdr/gh-dash" && skip "gh-dash extension" || { gh auth status &>/dev/null 2>&1 && gh extension install dlvhdr/gh-dash >/dev/null 2>&1 && done_ "gh-dash extension" || note "gh not authenticated — run 'gh auth login' then: gh extension install dlvhdr/gh-dash"; }
gh extension list 2>/dev/null | grep -q "dlvhdr/gh-enhance" && skip "gh-enhance extension" || { gh auth status &>/dev/null 2>&1 && gh extension install dlvhdr/gh-enhance >/dev/null 2>&1 && done_ "gh-enhance extension" || note "gh not authenticated — run 'gh auth login' then: gh extension install dlvhdr/gh-enhance"; }

if [ "${ENABLE_DOCKER:-Y}" = "Y" ]; then
  step "Docker"
  command -v docker &>/dev/null && skip "docker" || { note "Docker: install from https://docs.docker.com/engine/install/"; note "Then re-run this script."; }
  brew_install lazydocker lzd
else
  step "Docker"
  skip "docker (disabled)"
fi

step "Intelli-Shell — Command Index"
command -v intelli-shell &>/dev/null && {
  CMD_FILE="$DOTFILES_DIR/private_dot_config/intelli-shell/commands.yml"
  [ -f "$CMD_FILE" ] && {
    [ -t 0 ] && read -rp "  60+ stack commands ready. Prepopulate intelli-shell? [Y/n] " ans || ans="y"
    [[ "$ans" != "n" && "$ans" != "N" ]] && intelli-shell import "$CMD_FILE" 2>/dev/null && done_ "intelli-shell commands imported" || note "import failed — run manually: intelli-shell import $CMD_FILE"
  }
} || note "intelli-shell not installed — skipping command index"

[ -t 0 ] && printf "\n  ${DIM}Setting up your student workspace...${RESET}\n"

CAMP_DIR="$(cd "$TOOLKIT_DIR/.." && pwd)"
STUDENT_WORKSPACE="$CAMP_DIR/students/${STUDENT_NAME:-$(whoami)}"
if [ ! -d "$STUDENT_WORKSPACE" ]; then
  cp -r "$CAMP_DIR/students/template" "$STUDENT_WORKSPACE"
  [ -t 0 ] && printf "  ${GREEN}✓${RESET} Student workspace created: ${BOLD}students/${STUDENT_NAME:-$(whoami)}${RESET}\n"
else
  [ -t 0 ] && printf "  ${BLUE}·${RESET} Student workspace already exists\n"
fi

printf "\n${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}  ${BOLD}${GREEN}✓  Setup Complete${RESET}                        ${CYAN}║${RESET}\n"
printf "${CYAN}║${RESET}                                              ${CYAN}║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"
printf "\n  ${DIM}Installed:${RESET}  ${GREEN}${INSTALLED} packages${RESET}\n  ${DIM}Skipped:${RESET}    ${BLUE}${SKIPPED} already present${RESET}\n"
[ "$NOTES" -gt 0 ] && printf "  ${DIM}Notes:${RESET}      ${YELLOW}${NOTES} items need attention${RESET}\n"
printf "\n  ${DIM}Your config:${RESET}\n  ${DIM}Name:${RESET}          ${STUDENT_NAME:-not set}\n  ${DIM}Email:${RESET}         ${STUDENT_EMAIL:-not set}\n  ${DIM}GitHub:${RESET}        ${GITHUB_USERNAME:-not set}\n  ${DIM}Editor:${RESET}        ${COLORSCHEME:-default} (tab=${TAB_SIZE:-4})\n  ${DIM}AI:${RESET}            ${AI_PROVIDER:-disabled} (${AI_MODEL:-N/A})\n"
printf "\n  ${DIM}Next steps:${RESET}\n  ${GREEN}→${RESET} Open a new terminal to activate your stack\n  ${GREEN}→${RESET} Run ${BOLD}camp next${RESET} to see your first lesson\n  ${GREEN}→${RESET} Run ${BOLD}camp progress${RESET} to track your progress\n  ${GREEN}→${RESET} Run ${BOLD}cheat --start${RESET} for the interactive tour\n  ${GREEN}→${RESET} Run ${BOLD}doctor.sh${RESET} to verify 40/40 health\n\n"

printf "${DIM}── Running health check...${RESET}\n\n"
bash "$TOOLKIT_DIR/doctor.sh"