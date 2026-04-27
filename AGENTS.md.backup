# AGENTS.md — AUT Linux Camp

## What This Repo Is

A self-paced Linux terminal training camp. Students learn via 4 phases (13 lessons) with automated evaluation. Single instructor (supervisor) manages multiple students.

**Target OS**: Linux (Ubuntu 24.04+) or macOS. Homebrew is required.

## Key Commands

```bash
bash toolkit/setup.sh        # One-command installer (idempotent, safe to re-run)
bash toolkit/doctor.sh       # Health check — target is 40/40 passing
camp next                    # Show next lesson to work on
camp progress                # View student progress
camp submit <phase-number>   # Submit a phase for review
cheat <topic>                # Browse cheatsheets (uses fzf TUI)
cheat --start                # Interactive first-run tour
camp evaluate [student] [phase]  # Supervisor grading (auto-checks syntax, structure, git)
```

## Architecture

```
toolkit/           # Core infrastructure
├── setup.sh       # Installer — 10 phases, installs 32+ tools via brew/uv/cargo
├── doctor.sh      # 40 health checks across all tool categories
├── scripts/       # Executable scripts (cheat, camp CLI wrapper, etc.)
│   └── camp       # Python CLI entry point
├── camp_cli/      # Python CLI package (next, progress, submit, evaluate)
│   ├── common.py  # Shared utilities (paths, colors)
│   └── commands/
├── dotfiles/      # Chezmoi-managed configs (zshrc, tmux.conf, etc.)
├── cheatsheets/   # Tool reference guides (.md files)
├── quick-ref/     # One-page summaries
├── undo-guides/   # Recovery guides
├── workflows/     # Multi-step workflow guides
└── practice/      # Quizzes and daily tips

material/          # Course content (4 phases, 13 lessons pilot)
├── phase-1/       # Foundations (AI agents, Unix, tmux, git)
├── phase-2/       # Dev Environment (editor, dotfiles, cheat system)
├── phase-3/       # Data & AI (CSV/JSON, visidata, scripting)
├── phase-4/       # Containers & AI (Docker, compose, local AI)
└── SELF_PACED_GUIDE.md  # Student handbook

students/          # Student workspaces
├── template/      # Copied for each new student
└── <name>/        # Individual work (phase-X/lesson-Y/ directories)

tests/             # pytest suite for Python CLI tools
.github/workflows/ # CI: shellcheck + pytest
```

## Student Onboarding Flow

1. `bash toolkit/setup.sh` — installs tools, collects config (name, email, AI provider)
2. `bash toolkit/doctor.sh` — verify 40/40 health
3. `cp -r students/template students/<name>` — create workspace
4. `camp next` — start first lesson

## Evaluation System

`camp evaluate` scores each phase out of 100:
- **Automated (80pts)**: directory structure, work files, executable scripts, Python/bash syntax, git commits, self-assessment, code quality
- **Manual (20pts)**: code correctness + understanding (supervisor judgment)
- ≥80% = PASS, 60-79% = REVIEW, <60% = FAIL

## Toolchain Quirks

- **Homebrew is hard-required** — setup.sh dies if brew is missing
- **chezmoi** manages dotfiles; source dir is `toolkit/dotfiles/`
- **setup.sh** saves config to `toolkit/.setup-config` — re-running reuses it. API keys are stored separately in `~/.opencode.json`, never in the repo.
- **`cheat` script** resolves its toolkit dir relative to its own path — works from anywhere in PATH
- **Camp CLI** is Python 3 + stdlib only. Entry point is `toolkit/scripts/camp`. Old bash wrappers (`camp-next`, `camp-progress`, `camp-submit`, `evaluate.sh`) delegate to Python for backward compatibility.
- Rust tools need `~/.cargo/bin` in PATH; mise manages runtimes
- WezTerm on Linux cannot be installed without sudo — setup.sh prints manual instructions
- Git repo for evaluation is initialized in the student's workspace dir (not the camp root)

## Conventions

- Each lesson has `student-lab.md` (exercises) and optionally `instructor.md`
- Student work goes in `students/<name>/phase-X/lesson-Y/`
- Scripts should have shebangs and comments (checked by evaluation)
- All toolkit bash scripts use `set -euo pipefail` (or `set -uo pipefail` for non-fatal doctor)
- Color output uses ANSI escape codes; helpers defined inline per script
- Python CLI uses `camp_cli/common.py` for shared colors and path resolution

## Files Ignored by Git

`toolkit/dotfiles/.git/`, `.opencode/`, `claude-code-latest.txt`, `scanned_document.pdf`, `appsRepo.md`, `mise.toml`, `toolkit/.setup-config`, `__pycache__/`, `*.pyc`, `.pytest_cache/`

## Testing

```bash
python3 -m pytest tests/ -v    # Run Python CLI tests
```

## CI

GitHub Actions runs `shellcheck` on all bash scripts and `pytest` on `tests/` for every push/PR.
