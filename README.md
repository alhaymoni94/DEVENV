# AUT Linux Camp

A self-paced, terminal-first Linux training camp with automated evaluation.

## Quick Start

```bash
# 1. Install the terminal stack
bash toolkit/setup.sh

# 2. Verify health (target: 40/40)
bash toolkit/doctor.sh

# 3. Create your workspace
cp -r students/template students/$(whoami)

# 4. Start learning
camp next
```

## What's Inside

| Directory | Purpose |
|-----------|---------|
| `toolkit/` | Setup scripts, health checks, CLI tools, dotfiles |
| `material/` | 4 phases (13 lessons) with student labs |
| `students/` | Student workspaces |
| `tests/` | pytest + integration tests |

## Key Commands

```bash
camp next              # Show next lesson
camp progress          # View your progress
camp submit <phase>    # Submit a phase for review
camp evaluate          # Supervisor grading
cheat <topic>          # Browse cheatsheets
doctor.sh              # Health check
```

## Curriculum

| Phase | Topic | Lessons |
|-------|-------|---------|
| 1 | Foundations (AI, Unix, tmux, git) | 4 |
| 2 | Dev Environment (editor, dotfiles, cheat) | 3 |
| 3 | Data & AI (CSV/JSON, visidata, scripting) | 3 |
| 4 | Containers & AI (Docker, compose, local AI) | 3 |

## For Supervisors

```bash
# Evaluate all students
camp evaluate

# Evaluate one student
camp evaluate <student-name>

# Evaluate one phase
camp evaluate <student-name> <phase>
```

Reference solutions are in `toolkit/answer-key/`.

## Testing

```bash
python3 -m pytest tests/ -v         # Unit tests
bash tests/integration-test.sh      # Integration tests
bash tests/onboarding-test.sh       # Onboarding validation
```

## Documentation

- `material/SELF_PACED_GUIDE.md` — Student handbook
- `AGENTS.md` — Instructions for AI coding agents
- `PRD.md` — Product requirements
- `toolkit/answer-key/README.md` — Supervisor grading guide

## License

MIT
