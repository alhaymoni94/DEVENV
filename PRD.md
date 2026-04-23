# PRD: AUT Linux Camp — Terminal-First Learning Platform

## Document Info

| Field | Value |
|-------|-------|
| **Project** | AUT Linux Camp |
| **Version** | 1.0 |
| **Date** | April 21, 2026 |
| **Author** | Sleman Alhaymoni |
| **Status** | In Development |
| **Supervisor** | Sleman Alhaymoni (sole instructor) |

---

## 1. Problem Statement

Traditional Linux/terminal training relies on:
- Instructor-led sessions that don't scale
- Students getting stuck without immediate help
- No standardized way to track progress
- No automated evaluation of student work
- Students waiting for instructor feedback

**This project solves that** by creating a self-paced, terminal-first learning environment with automated evaluation, where a single supervisor can manage multiple students efficiently.

---

## 2. Vision

A complete Linux terminal training camp where:
- Students learn entirely from the terminal
- AI agents serve as first-line teaching assistants
- Progress is tracked automatically
- Evaluation is semi-automated (automated checks + supervisor review)
- The environment is reproducible on any machine with one command

---

## 3. Target Users

### Primary: Students
- University students with basic computer literacy
- No prior Linux/terminal experience required
- Self-motivated learners who can work independently

### Secondary: Supervisor (You)
- Single instructor managing multiple students
- Needs automated evaluation to reduce grading time
- Needs visibility into student progress at a glance

---

## 4. Goals

| # | Goal | Metric |
|---|------|--------|
| G1 | Students can set up their environment in < 15 min | `setup.sh` completes, `doctor.sh` shows 40/40 |
| G2 | Students complete all 4 phases | 13/13 lessons completed |
| G3 | Students pass automated evaluation | Score ≥ 80% per phase |
| G4 | Supervisor can evaluate a phase in < 5 min | `evaluate.sh` runs automatically |
| G5 | Students use self-help before asking humans | `cheat`, `ai`, `qr` used first |
| G6 | Students build a graduation project | Meets minimum requirements |

---

## 5. Non-Goals

- GUI-based learning materials
- Web-based LMS (Learning Management System)
- Real-time collaboration tools
- Video lectures
- Automated grading of code quality (supervisor reviews this)

---

## 6. System Architecture

### 6.1 Components

```
┌─────────────────────────────────────────────────────────┐
│                    AUT Linux Camp                        │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │  setup.sh    │  │  doctor.sh   │  │  dashboard.sh │  │
│  │  (install)   │  │  (health)    │  │  (welcome)    │  │
│  └──────────────┘  └──────────────┘  └───────────────┘  │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │  camp-       │  │  camp-       │  │  camp-        │  │
│  │  progress    │  │  next        │  │  submit       │  │
│  │  (track)     │  │  (guide)     │  │  (submit)     │  │
│  └──────────────┘  └──────────────┘  └───────────────┘  │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │  evaluate.sh │  │  cheat       │  │  tip          │  │
│  │  (grade)     │  │  (help)      │  │  (tips)       │  │
│  └──────────────┘  └──────────────┘  └───────────────┘  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │              32+ Terminal Tools                   │   │
│  │  micro, yazi, lazygit, tmux, btop, docker, etc.  │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  AI Agents                            │   │
│  │  ai (quick Q&A + pipe), opencode (coding agent)     │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │              Documentation System                 │   │
│  │  cheatsheets, quick-refs, undo-guides, quizzes,  │   │
│  │  workflows, instructor guides, student labs       │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 6.2 Directory Structure

```
AUT-Linux-Camp/
├── toolkit/                    # Core infrastructure
│   ├── setup.sh               # One-command installer
│   ├── doctor.sh              # Health check (40 checks)
│   ├── scripts/               # All executable scripts
│   │   ├── cheat              # Interactive help system
│   │   ├── dashboard.sh       # Welcome dashboard
│   │   ├── camp-progress      # Student progress tracker
│   │   ├── camp-next          # Next lesson guide
│   │   ├── camp-submit        # Phase submission
│   │   ├── evaluate.sh        # Supervisor evaluation
│   │   ├── backup.sh          # Backup configs
│   │   ├── restore.sh         # Restore configs
│   │   └── update.sh          # Update stack
│   ├── dotfiles/              # Chezmoi-managed configs
│   ├── cheatsheets/           # Tool reference guides
│   ├── quick-ref/             # One-page summaries
│   ├── undo-guides/           # Recovery guides
│   ├── workflows/             # Step-by-step guides
│   └── practice/              # Quizzes
├── material/                   # Course content
│   ├── SELF_PACED_GUIDE.md    # Student handbook
│   ├── GRADUATION_PROJECT.md  # Final project spec
│   ├── phase-1/               # Foundations (4 lessons)
│   ├── phase-2/               # Dev Environment (3 lessons)
│   ├── phase-3/               # Data & AI (3 lessons)
│   ├── phase-4/               # Containers & AI (3 lessons)
│   (phases 5-6 archived for future v1.1)
└── students/                   # Student workspaces
    ├── template/              # Copy for each student
    └── <student-name>/        # Individual work
```

---

## 7. Curriculum

### Phase Breakdown

| Phase | Topic | Lessons | Hours | Key Skills |
|-------|-------|---------|-------|------------|
| 1 | Foundations with AI | 4 | 7h | AI agents, Unix, tmux, git |
| 2 | Dev Environment | 3 | 4.5h | Editor, dotfiles, cheat system |
| 3 | Data & AI | 3 | 6h | CSV/JSON, visidata, scripting |
| 4 | Containers & AI | 3 | 6h | Docker, compose, local AI |
| 5 | Advanced Topics | 4 | 8h | Coding agents, synthetic data, MLOps |
| 6 | Automation | 1 | 2h | Cron, backup, diagnostics |
| — | Graduation Project | 1 | 4 weeks | Full stack application |

**Total: 13 lessons, 25.5 hours instruction + 4-week project**

### Each Lesson Includes

- **Instructor guide** (for supervisor reference)
- **Student lab** (hands-on exercises)
- **Self-assessment** (student rates their understanding)
- **Bonus challenges** (for advanced students)

---

## 8. User Flows

### 8.1 Student Onboarding

```
1. Clone repo
2. Run: bash toolkit/setup.sh
3. Verify: doctor.sh shows 40/40
4. Copy workspace: cp -r students/template students/<name>
5. Read: material/SELF_PACED_GUIDE.md
6. Start: camp-next
```

### 8.2 Student Learning Loop

```
1. Run: camp-next          → See what to work on
2. Read: material/phase-X/lesson-Y/student-lab.md
3. Complete exercises in: students/<name>/phase-X/lesson-Y/
4. Fill self-assessment
5. Run: camp-submit X      → Submit phase for review
6. Wait for evaluation
7. Fix issues if any
8. Repeat for next phase
```

### 8.3 Supervisor Evaluation Flow

```
1. Run: evaluate <student-name> <phase>
2. Review automated score and issues
3. Manually review code quality
4. Provide feedback to student
5. Approve or request revisions
```

---

## 9. Evaluation System

### 9.1 Automated Checks (80 points)

| Check | Points | Description |
|-------|--------|-------------|
| Directory structure | 10 | Phase directory exists |
| Work files exist | 20 | Student created files |
| Scripts executable | 10 | .sh files have +x |
| Python syntax | 15 | No syntax errors |
| Bash syntax | 15 | No syntax errors |
| Git commits | 10 | Has commit history |
| Self-assessment | 10 | Filled in scores |
| Code quality | 10 | Shebangs + comments |

### 9.2 Manual Review (20 points)

| Check | Points | Description |
|-------|--------|-------------|
| Code correctness | 10 | Does the code work? |
| Understanding | 10 | Can student explain their work? |

### 9.3 Grading Scale

| Score | Grade | Action |
|-------|-------|--------|
| ≥ 80% | PASS | Unlock next phase |
| 60-79% | REVIEW | Supervisor decides |
| < 60% | FAIL | Student must revise |

---

## 10. Technical Requirements

### 10.1 System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| OS | Linux (Ubuntu 24.04+) or macOS | Ubuntu 24.04 LTS |
| RAM | 4 GB | 8 GB |
| Disk | 10 GB free | 20 GB free |
| Internet | Required for setup | Required for AI tools |
| Shell | zsh | zsh + starship |

### 10.2 Tool Dependencies

| Tool | Purpose | Install Method |
|------|---------|---------------|
| Homebrew | Package manager | brew.sh |
| chezmoi | Dotfile management | brew |
| zsh | Shell | system/brew |
| starship | Prompt | brew |
| tmux | Terminal multiplexer | brew |
| micro | Terminal editor | brew |
| git | Version control | system |
| docker | Containers | system/brew |
| uv | Python tooling | pip |
| mise | Runtime manager | brew |
| gh | GitHub CLI | brew |
| ai | AI assistant (opencode wrapper) | toolkit/scripts |
| opencode | AI coding agent | brew |
| intelli-shell | Command history | brew |

### 10.3 AI Requirements

- API key configured in ~/.opencode.json (OpenAI, Anthropic, Gemini, or compatible)
- opencode provides both one-shot and interactive modes
- Local models (ollama) optional for advanced projects

---

## 11. Success Metrics

| Metric | Target | How Measured |
|--------|--------|--------------|
| Setup success rate | ≥ 95% | `doctor.sh` 40/40 |
| Phase completion rate | ≥ 80% | `camp-progress` data |
| Average evaluation score | ≥ 75% | `evaluate.sh` output |
| Time to first phase | < 2 hours | Student self-report |
| Time to graduation | < 8 weeks | Submission timestamps |
| Supervisor time per student | < 2 hrs/week | Time tracking |
| Student satisfaction | ≥ 4/5 | End-of-camp survey |

---

## 12. Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Setup fails on some machines | High | Medium | `doctor.sh` diagnoses, `setup.sh` is idempotent |
| Students get stuck without help | High | Medium | AI agents + cheat system as first line |
| Automated evaluation misses issues | Medium | Medium | Supervisor manual review catches gaps |
| Students rush through self-assessments | Low | High | Supervisor verifies understanding |
| AI gives wrong answers | Medium | Medium | Cross-reference with cheat system |
| Students don't submit work | High | Medium | `camp-progress` shows stalled students |

---

## 13. Current Status

### Completed ✅

- [x] Full terminal stack (32+ tools)
- [x] Setup script with progress bars
- [x] Health check (40/40 checks)
- [x] Welcome dashboard
- [x] Cheat system (cheatsheets, quick-refs, undo-guides, quizzes, workflows)
- [x] 13 lessons across 4 phases (phases 5-6 archived for v1.1)
- [x] Student labs with exercises
- [x] Instructor guides (Phases 1-3)
- [x] Self-paced learning guide
- [x] Progress tracking (`camp-progress`)
- [x] Next lesson guide (`camp-next`)
- [x] Phase submission (`camp-submit`)
- [x] Supervisor evaluation (`evaluate.sh`)
- [x] Graduation project framework
- [x] Portable configs (chezmoi, no hardcoded paths)

### In Progress 🚧

- [ ] Instructor guides for Phases 4-6
- [ ] More quizzes for lessons
- [ ] Integration testing on clean machines
- [ ] Student onboarding documentation

### Planned 📋

- [ ] Video recordings of key concepts
- [ ] Peer review system
- [ ] Leaderboard for motivation
- [ ] Certificate generation
- [ ] Multi-machine sync for students

---

## 14. Future Roadmap

### v1.1 — Polish
- Complete all instructor guides
- Add more practice exercises
- Improve evaluation feedback messages

### v1.2 — Scale
- Support multiple cohorts
- Add cohort management commands
- Batch evaluation for all students

### v2.0 — Enhancements
- Web-based progress dashboard (optional)
- Automated code quality scoring
- Peer review workflow
- Certificate generation

---

## 15. Glossary

| Term | Definition |
|------|------------|
| TUI | Terminal User Interface |
| chezmoi | Dotfile management tool |
| Phase | A group of related lessons |
| Lesson | A single topic with exercises |
| Lab | Hands-on exercises for students |
| Milestone | A checkpoint that unlocks the next phase |
| Self-assessment | Student rates their own understanding |
| Evaluation | Automated + manual grading of student work |

---

## Appendix A: Command Reference

| Command | User | Purpose |
|---------|------|---------|
| `bash toolkit/setup.sh` | Student | Install entire stack |
| `doctor.sh` | Student | Check stack health |
| `camp-progress` | Student | View progress |
| `camp-next` | Student | See next lesson |
| `camp-submit <phase>` | Student | Submit phase for review |
| `evaluate <student> [phase]` | Supervisor | Grade student work |
| `cheat <tool>` | Student | View cheatsheet |
| `qr <tool>` | Student | Quick reference |
| `cheat --undo <tool>` | Student | Recovery guide |
| `cheat --quiz <topic>` | Student | Test knowledge |
| `ai "question"` | Student | Ask AI |
| `opencode` | Student | AI coding session |
| `tip` | Student | Random pro tip |
