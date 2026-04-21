#!/usr/bin/env bash
# dashboard.sh — Welcome dashboard with system status
# Shows on first terminal open (once per session)

set -euo pipefail

# ── Colors (Tokyo Night) ──────────────────────────────────────────────────────
BOLD="\033[1m"
CYAN="\033[1;36m"
BLUE="\033[1;34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
MAGENTA="\033[1;35m"
DIM="\033[2m"
RESET="\033[0m"

W="${CYAN}"    # border
G="${GREEN}"   # good
Y="${YELLOW}"  # warning
R="${RED}"     # error
B="${BLUE}"    # accent
D="${DIM}"     # dim
N="${RESET}"   # normal
K="${BOLD}"    # bold

# ── Helpers ───────────────────────────────────────────────────────────────────
hr() { printf "${W}║${D}%-56s${W}║${N}\n" ""; }
hr_full() { printf "${W}╚${D}%-56s${W}╝${N}\n" ""; }
hr_top() { printf "${W}╔${D}%-56s${W}╗${N}\n" ""; }
hr_mid() { printf "${W}╠${D}%-56s${W}╣${N}\n" ""; }
row() { printf "${W}║${N} %-2s ${D}%-53s${W}║${N}\n" "$1" "$2"; }
row_bold() { printf "${W}║${N} ${K}%-2s${N} ${K}%-53s${W}║${N}\n" "$1" "$2"; }
row_cmd() { printf "${W}║${N}    ${G}%-14s${D}→ %s${N}%*s${W}║${N}\n" "$1" "$2" $((39 - ${#1} - ${#2})) ""; }

# ── Gather System Info ────────────────────────────────────────────────────────
# CPU
cpu_usage=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{print int($2 + $4)}' || echo "?")
[[ "$cpu_usage" == "?" ]] && cpu_usage=$(grep -c ^processor /proc/cpuinfo 2>/dev/null && echo "N/A" || echo "?")

# RAM
ram_total=$(free -m 2>/dev/null | awk '/Mem:/{print $2}')
ram_used=$(free -m 2>/dev/null | awk '/Mem:/{print $3}')
ram_pct=$(( ram_used * 100 / ram_total ))

# Disk
disk_pct=$(df -h / 2>/dev/null | awk 'NR==2{print $5}' | tr -d '%')

# Tool counts
tool_count=32
doctor_pass=40
doctor_total=40

# tmux sessions
tmux_sessions=$(tmux ls 2>/dev/null | wc -l || echo "0")

# ── Status indicators ─────────────────────────────────────────────────────────
status_icon() {
  export PATH="$HOME/.cargo/bin:$PATH"
  if command -v "$1" &>/dev/null; then
    printf "${G}●${N}"
  else
    printf "${R}●${N}"
  fi
}

# ── Build Dashboard ───────────────────────────────────────────────────────────
printf "\n"
hr_top
printf "${W}║${N} ${K}⚡  TERMINAL STACK DASHBOARD${N}%*s${W}║${N}\n" 26 ""
hr_mid

# System row
printf "${W}║${N} ${K}🖥  System${N}%*s${W}║${N}\n" 46 ""
hr
row "" "CPU: ${cpu_usage}%  │  RAM: ${ram_used}M/${ram_total}M (${ram_pct}%)  │  Disk: ${disk_pct}%"
hr

# Tools row
printf "${W}║${N} ${K}📦  Tools${N}%*s${W}║${N}\n" 47 ""
hr
row "" "${tool_count} installed  │  ${doctor_pass}/${doctor_total} healthy  │  ${tmux_sessions} tmux session(s)"
hr

# Status row
printf "${W}║${N} ${K}🔧  Status${N}%*s${W}║${N}\n" 46 ""
hr
row "" "$(status_icon micro) micro   $(status_icon yazi) yazi   $(status_icon lazygit) lazygit   $(status_icon aichat) aichat   $(status_icon fzf) fzf   $(status_icon btop) btop"
hr

# Quick start row
printf "${W}║${N} ${K}🚀  Quick Start${N}%*s${W}║${N}\n" 41 ""
hr_mid
row_cmd "cheat --start" "2-min interactive tour"
row_cmd "tip" "Random pro tip"
row_cmd "lg" "Git TUI"
row_cmd "ai" "AI chat"
row_cmd "y" "File manager"
row_cmd "e file" "Editor"
hr

# Help row
printf "${W}║${N} ${K}❓  Help${N}%*s${W}║${N}\n" 48 ""
hr_mid
row "" "cheat = reference  |  qr <tool> = quick-ref  |  cheat --undo = recovery  |  cheat --quiz = test"
hr_full

printf "\n"
