# AUT Linux Camp — Project Status

## Goal
A hands-on terminal skills bootcamp focused on command-line workflows, development tools, and AI-assisted processes. No GUI. Students use AI agents as learning assistants from day one.

## Current State: v1.0 — Stable & Hardened

The installer, cheat system, camp CLI, and CI pipeline are all working and tested.

---

## Stack (installed by setup.sh)

| Layer | Tool | Alias |
|-------|------|-------|
| Terminal | WezTerm / Ghostty | — |
| Multiplexer | tmux (Ctrl+a prefix) | — |
| Shell | zsh + zinit + Starship | — |
| Editor | micro | `e` |
| File manager | yazi | `y` |
| Git TUI | lazygit | `lg` |
| GitHub | gh + gh-dash + gh-enhance | `ghd` |
| AI | opencode wrapper | `ai` |
| System monitor | btop | `top` |
| Data | visidata + euporie | `vd` |
| Diagrams | d2 + mmdc | — |
| Dotfiles | chezmoi | — |
| Runtimes | uv + mise | — |
| Help | cheat system | `cheat`, `qr`, `tip` |

---

## Phases (4 active, 2 archived)

| Phase | Topic | Status |
|-------|-------|--------|
| 1 | Foundations with AI — shell, tmux, git | Active |
| 2 | Development Environment — micro, chezmoi, dotfiles | Active |
| 3 | Data Manipulation — visidata, euporie, datasets | Active |
| 4 | Containers & AI — Docker, opencode, local LLMs | Active |
| 5 | Advanced Topics | Archived (v1.1) |
| 6 | Workspace Automation | Archived (v1.1) |

---

## Cheat System

79 topics across 6 categories:
- 26 cheatsheets · 8 workflows · 5 concepts · 20 quick-refs · 9 undo guides · 11 quizzes

Commands: `cheat`, `qr <tool>`, `tip`, `cheat --quiz`, `cheat --start`, `cheat --search`, `cheat --browse`

---

## Bugs Fixed (this session)

- `setup.sh`: `((VAR++))` with `set -euo pipefail` crashed on zero counters
- `setup.sh`: spinner functions returned non-zero in non-TTY, killing Docker runs
- `setup.sh`: `absorb()` false return triggered `set -e`
- `setup.sh`: `tmux` and `uv` never installed (doctor checked but setup skipped them)
- `setup.sh`: student workspace `cp` used wrong path; no guard for missing template
- `setup.sh`: `chezmoi apply --force` overwrote customizations on re-run → now status-gated
- `setup.sh`: TOTAL_PHASES=10 but 11 phases existed → counter overflow fixed
- `doctor.sh`: `$USER` unbound in Docker; duplicate opencode check
- `doctor.sh`: optional tools (llmfit, euporie, mmdc…) counted as hard failures → reclassified as extended
- `scripts/cheat`: quiz scoring only checked last answer; regex metachar bug in answer matching
- `scripts/cheat`: `--search` missing `concepts/` directory
- `dotfiles/dot_zshrc`: `alias cat='bat || cat'` infinite recursion → `command cat`
- `dotfiles/dot_zshrc`: PATH discovery failed if chezmoi not initialized → fallback loop
- `camp_cli/submit.py`: staged check ran before `git add -A` → always reported nothing to submit
- `camp_cli/submit.py`: local-only commit; added remote push + one-time setup hint
- `tests/Dockerfile.integration`: missing `python3` in apt-get
- `ci.yml`: ShellCheck missed extensionless scripts; no integration test job

---

## Deferred (v1.1)

- Content: quick-refs for fzf, starship, chezmoi, docker, mise
- Content: phase 5 & 6 quizzes
- Supervisor: `camp review-all` batch review command
- Doctor: distinguish WezTerm/font (GUI) from core terminal failures
