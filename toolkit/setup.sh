#!/usr/bin/env bash
# setup.sh — Terminal stack installer + doctor
# Installs missing tools, skips already-installed ones, ends with a doctor report.
# Safe to re-run at any time.

set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$TOOLKIT_DIR/dotfiles"
CONFIG_FILE="$TOOLKIT_DIR/.setup-config"

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
TOTAL_PHASES=10
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

# ── Input helpers ─────────────────────────────────────────────────────────────
ask() {
  local prompt="$1"
  local default="$2"
  local var_name="$3"
  local answer

  if [ -n "$default" ]; then
    printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[%s]${RESET} " "$prompt" "$default"
  else
    printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} " "$prompt"
  fi

  if [ -t 0 ]; then
    read -r answer
  else
    answer="$default"
  fi

  if [ -z "$answer" ] && [ -n "$default" ]; then
    answer="$default"
  fi

  eval "$var_name='$answer'"
}

ask_secret() {
  local prompt="$1"
  local var_name="$2"
  local answer

  printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} " "$prompt"

  if [ -t 0 ]; then
    read -rs answer
    printf "\n"
  else
    read -r answer
  fi

  eval "$var_name='$answer'"
}

ask_choice() {
  local prompt="$1"
  local default="$2"
  local var_name="$3"
  shift 3
  local options=("$@")
  local answer

  printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET}\n" "$prompt"
  for i in "${!options[@]}"; do
    if [ "${options[$i]}" = "$default" ]; then
      printf "    ${GREEN}%d) %s${RESET} ${DIM}(default)${RESET}\n" "$((i+1))" "${options[$i]}"
    else
      printf "    ${DIM}%d) %s${RESET}\n" "$((i+1))" "${options[$i]}"
    fi
  done

  printf "  ${CYAN}→${RESET} ${DIM}Choice${RESET} ${DIM}[%s]${RESET} " "$default"

  if [ -t 0 ]; then
    read -r answer
  else
    answer=""
  fi

  if [ -z "$answer" ]; then
    answer="$default"
  elif [[ "$answer" =~ ^[0-9]+$ ]] && [ "$answer" -ge 1 ] && [ "$answer" -le "${#options[@]}" ]; then
    answer="${options[$((answer-1))]}"
  fi

  eval "$var_name='$answer'"
}

ask_confirm() {
  local prompt="$1"
  local default="${2:-Y}"
  local answer

  if [ "$default" = "Y" ]; then
    printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[Y/n]${RESET} " "$prompt"
  else
    printf "  ${CYAN}?${RESET} ${BOLD}%s${RESET} ${DIM}[y/N]${RESET} " "$prompt"
  fi

  if [ -t 0 ]; then
    read -r answer
  else
    answer="$default"
  fi

  if [ -z "$answer" ]; then
    answer="$default"
  fi

  if [[ "$answer" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# ── Save config ───────────────────────────────────────────────────────────────
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
AI_API_KEY="$AI_API_KEY"
ENABLE_DOCKER="$ENABLE_DOCKER"
ENABLE_AI="$ENABLE_AI"
COLORSCHEME="$COLORSCHEME"
TAB_SIZE="$TAB_SIZE"
TIMEZONE="$TIMEZONE"
EOF
  printf "\n  ${GREEN}✓${RESET} Configuration saved to ${BOLD}.setup-config${RESET}\n"
  printf "  ${DIM}Edit this file directly to change settings later.${RESET}\n"
}

# ── Load existing config ──────────────────────────────────────────────────────
load_config() {
  if [ -f "$CONFIG_FILE" ]; then
    # shellcheck source=/dev/null
    source "$CONFIG_FILE"
    return 0
  fi
  return 1
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

# ── Phase 0: Configuration ────────────────────────────────────────────────────
step "Configuration — Tell us about yourself"

if load_config; then
  printf "\n  ${DIM}Existing configuration found.${RESET}\n"
  printf "  ${DIM}Name: ${STUDENT_NAME:-not set}${RESET}\n"
  printf "  ${DIM}Email: ${STUDENT_EMAIL:-not set}${RESET}\n"
  printf "  ${DIM}GitHub: ${GITHUB_USERNAME:-not set}${RESET}\n"
  printf "  ${DIM}AI: ${AI_PROVIDER:-not set} (${AI_MODEL:-not set})${RESET}\n"
  printf "\n"

  if ask_confirm "Use existing configuration?" "Y"; then
    printf "  ${GREEN}✓${RESET} Using existing configuration\n"
  else
    printf "  ${YELLOW}!${RESET} Re-configuring...\n\n"
    STUDENT_NAME=""
    STUDENT_EMAIL=""
    GITHUB_USERNAME=""
    AI_API_KEY=""
  fi
fi

if [ -z "${STUDENT_NAME:-}" ]; then
  printf "\n${BOLD}── Student Information ──${RESET}\n\n"

  ask "Your full name" "$(whoami)" "STUDENT_NAME"
  ask "Your email (for git commits)" "" "STUDENT_EMAIL"
  ask "GitHub username" "" "GITHUB_USERNAME"

  printf "\n${BOLD}── Editor Preferences ──${RESET}\n\n"

  ask_choice "Preferred editor colorscheme" "gruvbox" "COLORSCHEME" \
    "gruvbox" "solarized" "monokai" "nord" "tokyonight" "default"
  ask "Tab size" "4" "TAB_SIZE"

  printf "\n${BOLD}── AI Configuration ──${RESET}\n\n"

  ask_confirm "Enable AI tools? (requires API key)" "Y" && ENABLE_AI="Y" || ENABLE_AI="N"

  if [ "$ENABLE_AI" = "Y" ]; then
    ask_choice "AI Provider" "openai" "AI_PROVIDER" \
      "openai" "anthropic" "gemini" "ollama" "custom"
    ask "AI Model" "gpt-4o" "AI_MODEL"
    ask_secret "API Key" "AI_API_KEY"
  fi

  printf "\n${BOLD}── System Preferences ──${RESET}\n\n"

  ask_confirm "Enable Docker support?" "Y" && ENABLE_DOCKER="Y" || ENABLE_DOCKER="N"

  # Detect timezone
  detected_tz=""
  if [ -f /etc/timezone ]; then
    detected_tz=$(cat /etc/timezone)
  elif command -v timedatectl &>/dev/null; then
    detected_tz=$(timedatectl show --property=Timezone --value 2>/dev/null || true)
  fi
  ask "Timezone" "${detected_tz:-UTC}" "TIMEZONE"

  printf "\n"

  # Show summary
  printf "${BOLD}── Configuration Summary ──${RESET}\n\n"
  printf "  ${DIM}Name:${RESET}          ${BOLD}$STUDENT_NAME${RESET}\n"
  printf "  ${DIM}Email:${RESET}         ${BOLD}${STUDENT_EMAIL:-not set}${RESET}\n"
  printf "  ${DIM}GitHub:${RESET}        ${BOLD}${GITHUB_USERNAME:-not set}${RESET}\n"
  printf "  ${DIM}Editor theme:${RESET}  ${BOLD}$COLORSCHEME${RESET}\n"
  printf "  ${DIM}Tab size:${RESET}      ${BOLD}$TAB_SIZE${RESET}\n"
  printf "  ${DIM}AI provider:${RESET}   ${BOLD}${AI_PROVIDER:-disabled}${RESET}\n"
  printf "  ${DIM}AI model:${RESET}      ${BOLD}${AI_MODEL:-N/A}${RESET}\n"
  printf "  ${DIM}Docker:${RESET}        ${BOLD}${ENABLE_DOCKER:-Y}${RESET}\n"
  printf "  ${DIM}Timezone:${RESET}      ${BOLD}${TIMEZONE:-UTC}${RESET}\n"
  printf "\n"

  if ask_confirm "Save and continue?" "Y"; then
    save_config
  else
    die "Setup cancelled."
  fi
fi

# ── Apply configurations ──────────────────────────────────────────────────────
if [ -t 0 ]; then
  printf "\n  ${DIM}Applying configurations...${RESET}\n"
fi

# Configure git
if [ -n "${STUDENT_NAME:-}" ] && [ -n "${STUDENT_EMAIL:-}" ]; then
  if [ -t 0 ]; then
    printf "  ${GREEN}✓${RESET} Configuring git: ${STUDENT_NAME} <${STUDENT_EMAIL}>\n"
  fi
  git config --global user.name "$STUDENT_NAME" 2>/dev/null || true
  git config --global user.email "$STUDENT_EMAIL" 2>/dev/null || true
fi

# Configure GitHub CLI if username provided
if [ -n "${GITHUB_USERNAME:-}" ] && [ -t 0 ]; then
  printf "  ${GREEN}✓${RESET} GitHub username: ${GITHUB_USERNAME}\n"
fi

# Configure aichat if AI enabled
if [ "${ENABLE_AI:-N}" = "Y" ] && [ -n "${AI_API_KEY:-}" ]; then
  AICHAT_CONFIG="$HOME/.config/aichat"
  mkdir -p "$AICHAT_CONFIG"
  cat > "$AICHAT_CONFIG/config.yaml" << EOF
model: "${AI_PROVIDER}:${AI_MODEL}"
key: "${AI_API_KEY}"
EOF
  if [ -t 0 ]; then
    printf "  ${GREEN}✓${RESET} AI configured: ${AI_PROVIDER} (${AI_MODEL})\n"
  fi
fi

# Configure micro theme
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
  if [ -t 0 ]; then
    printf "  ${GREEN}✓${RESET} Editor theme: ${COLORSCHEME}, tab size: ${TAB_SIZE:-4}\n"
  fi
fi

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

if [ "${ENABLE_AI:-Y}" = "Y" ]; then
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
else
  skip "aichat (disabled)"
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

# ── Phase 9: Docker (optional) ────────────────────────────────────────────────
if [ "${ENABLE_DOCKER:-Y}" = "Y" ]; then
  step "Docker"
  if command -v docker &>/dev/null; then
    skip "docker"
  else
    note "Docker: install from https://docs.docker.com/engine/install/"
    note "Then re-run this script."
  fi

  brew_install lazydocker lzd
else
  step "Docker"
  skip "docker (disabled)"
fi

# ── Phase 10: Intelli-Shell Command Index ──────────────────────────────────────
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

# ── Setup student workspace ───────────────────────────────────────────────────
if [ -t 0 ]; then
  printf "\n  ${DIM}Setting up your student workspace...${RESET}\n"
fi

STUDENT_WORKSPACE="$TOOLKIT_DIR/students/${STUDENT_NAME:-$(whoami)}"
if [ ! -d "$STUDENT_WORKSPACE" ]; then
  cp -r "$TOOLKIT_DIR/students/template" "$STUDENT_WORKSPACE"
  if [ -t 0 ]; then
    printf "  ${GREEN}✓${RESET} Student workspace created: ${BOLD}students/${STUDENT_NAME:-$(whoami)}${RESET}\n"
  fi
else
  if [ -t 0 ]; then
    printf "  ${BLUE}·${RESET} Student workspace already exists\n"
  fi
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

printf "  ${DIM}Your config:${RESET}\n"
printf "  ${DIM}Name:${RESET}          ${STUDENT_NAME:-not set}\n"
printf "  ${DIM}Email:${RESET}         ${STUDENT_EMAIL:-not set}\n"
printf "  ${DIM}GitHub:${RESET}        ${GITHUB_USERNAME:-not set}\n"
printf "  ${DIM}Editor:${RESET}        ${COLORSCHEME:-default} (tab=${TAB_SIZE:-4})\n"
printf "  ${DIM}AI:${RESET}            ${AI_PROVIDER:-disabled} (${AI_MODEL:-N/A})\n"
printf "\n"

printf "  ${DIM}Next steps:${RESET}\n"
printf "  ${GREEN}→${RESET} Open a new terminal to activate your stack\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}camp-next${RESET} to see your first lesson\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}camp-progress${RESET} to track your progress\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}cheat --start${RESET} for the interactive tour\n"
printf "  ${GREEN}→${RESET} Run ${BOLD}doctor.sh${RESET} to verify 40/40 health\n"
printf "\n"

# ── Run doctor ────────────────────────────────────────────────────────────────
printf "${DIM}── Running health check...${RESET}\n\n"
bash "$TOOLKIT_DIR/doctor.sh"
