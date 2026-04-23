# AUT Linux Camp — Self-Paced Learning Guide

## How This Works

This camp is designed for **self-paced learning** with **supervisor evaluation**. You work through the material on your own schedule, completing exercises and submitting your work for review.

## Your Journey

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  Phase 1    │──▶│  Phase 2    │──▶│  Phase 3    │──▶│  Phase 4    │
│ Foundations │   │ Dev Env     │   │ Data & AI   │   │ Containers  │
│ 7 hours     │   │ 4.5 hours   │   │ 6 hours     │   │ 6 hours     │
└─────────────┘   └─────────────┘   └─────────────┘   └─────────────┘
                                                          │
                                                          ▼
                                              Graduation Project
                                                  (4 weeks)
```

## How to Progress

### 1. Setup (Day 1)
```bash
# Run the setup script
bash toolkit/setup.sh

# Verify your stack is healthy
doctor.sh
# Core tools must pass. Warnings for optional tools (like AI) are OK.
```

### 2. Work Through Each Phase
For each phase:
1. Read the `README.md` to understand objectives
2. Complete each lesson's `student-lab.md`
3. Fill in your self-assessment scores
4. Save your work in your student directory

### 3. Submit for Review
```bash
# When you complete a phase, submit it:
cd ~/students/YOUR_NAME
git add -A
git commit -m "submit: Phase X complete"
git push
```

### 4. Wait for Evaluation
Your supervisor will:
- Run automated checks on your submission
- Review your code quality
- Provide feedback
- Unlock the next phase

## Milestones

| Milestone | Requirement | Unlocks |
|-----------|-------------|---------|
| Setup Complete | `doctor.sh` shows 40/40 | Phase 1 |
| Phase 1 Pass | All labs completed, avg self-assessment ≥ 4 | Phase 2 |
| Phase 2 Pass | Dotfiles customized, cheat system used | Phase 3 |
| Phase 3 Pass | Data analysis script works | Phase 4 |
| Phase 4 Pass | Containerized app runs | Graduation Project |
| Graduation | Project meets requirements | Certificate |

## Rules

1. **Complete exercises in order** — each builds on the previous
2. **Fill in self-assessments honestly** — they guide your supervisor
3. **Use the cheat system** — `cheat`, `qr`, `tip` are your first line of help
4. **Use available resources** — `man`, `cheat`, `ai` (if configured), or web search
5. **Submit when ready** — don't rush, quality matters

> **About AI:** AI tools (`ai`, `opencode`) are optional enhancements. Every lesson works without them. If you have a paid API key or personal subscription, use them. If not, use `man`, `cheat`, and the terminal's built-in help.

## Getting Help

| Level | Resource | When to Use |
|-------|----------|-------------|
| 1 | `cheat tool-name` | Quick reference |
| 2 | `cheat --undo tool` | Something broke |
| 3 | `qr tool-name` | One-page summary |
| 4 | `man command` | Official documentation |
| 5 | `ai "your question"` | Conceptual help (if AI configured) |
| 6 | `cheat --workflow name` | Step-by-step guides |
| 7 | `cheat --quiz topic` | Test your knowledge |
| 8 | Supervisor | Stuck after trying everything |

## Your Workspace

```
students/YOUR_NAME/
├── phase-1/
│   ├── lesson-1/    ← Your solutions go here
│   ├── lesson-2/
│   ├── lesson-3/
│   └── lesson-4/
├── phase-2/
│   └── ...
├── phase-3/
│   └── ...
├── phase-4/
│   └── ...
└── projects/        ← Personal projects
```

## Tracking Your Progress

```bash
# Check your progress
camp progress

# See what's next
camp next

# Submit a phase
camp submit 1
```

---

**Ready? Start with Phase 1 →** `cat material/phase-1/README.md`
