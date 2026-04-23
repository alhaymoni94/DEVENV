# Lesson 7: Cheat System & Self-Documentation — Student Lab

## Duration: 1 hour

---

## Exercise 1: Full System Tour (15 min)

**Task:** Explore every part of the cheat system.

```bash
# Take the guided tour
cheat --start

# List all available cheatsheets
cheat --list

# Count how many cheatsheets exist
cheat --list | wc -l
```

**For each tool you've learned, look up:**
```bash
cheat micro
cheat yazi
cheat tmux
cheat git
cheat lazygit
cheat btop
cheat docker
```

**Check:** Can you find help for every tool in the stack?

---

## Exercise 2: Quick References (10 min)

**Task:** Use quick-reference cards for fast lookup.

```bash
# Quick refs are one-page summaries
qr micro
qr tmux
qr lazygit
qr git
qr docker
```

**Compare:** How is `qr` different from `cheat`? Which do you prefer for quick lookup?

---

## Exercise 3: Undo Guides (10 min)

**Task:** Learn how to recover from mistakes.

```bash
# Read undo guides for critical tools
cheat --undo git
cheat --undo tmux
cheat --undo micro
cheat --undo docker
cheat --undo yazi
cheat --undo chezmoi
```

**Exercise:** For each undo guide, find the solution to:
1. "I committed to the wrong branch" (git)
2. "I closed a pane by accident" (tmux)
3. "I deleted a file by accident" (yazi)
4. "I saved a file with wrong content" (micro)

---

## Exercise 4: Quizzes (10 min)

**Task:** Test your knowledge.

```bash
# Take available quizzes
cheat --quiz micro
cheat --quiz lazygit
```

**Track your scores:**
- Micro quiz: ___/___
- Lazygit quiz: ___/___

**Goal:** Score 80% or higher on each quiz.

---

## Exercise 5: Workflows (10 min)

**Task:** Read through available workflow guides.

```bash
# List workflows
cheat --list | grep workflow

# Read each one
cheat --workflow ai-assist
cheat --workflow git-branching
cheat --workflow docker-compose
cheat --workflow debugging
cheat --workflow project-setup
cheat --workflow dev-session
cheat --workflow edit-commit
cheat --workflow file-ops
```

**Pick one workflow** and follow it step by step.

---

## Exercise 6: Create Your Own Cheatsheet (15 min)

**Task:** Document a tool or workflow you use often.

```bash
# Create a new cheatsheet
e toolkit/cheatsheets/my-favorite-tool.md
```

Use this template:
```markdown
# Tool Name Cheatsheet

## Quick Start
```bash
basic-command
```

## Essential Commands
| Command | Description |
|---------|-------------|
| `cmd -a` | Does X |
| `cmd -b` | Does Y |

## Common Tasks

### Task 1
```bash
step-by-step commands
```

### Task 2
```bash
more commands
```

## Tips
- Tip 1
- Tip 2
- Tip 3

## Troubleshooting
| Problem | Solution |
|---------|----------|
| Error X | Do Y |
```

**Test it:**
```bash
cheat my-favorite-tool
```

---

## Exercise 7: Daily Tip Habit (5 min)

**Task:** Make tips part of your daily routine.

```bash
# Get a random tip
tip

# Or the daily tip
cheat --daily
```

**Challenge:** Set a reminder to check `tip` every morning. Add this to your zshrc:
```bash
# Already added! Look for _stack_reminder in ~/.zshrc
```

---

## Bonus Challenges

1. **Create a quick-ref** for a tool that doesn't have one
2. **Write an undo guide** for a mistake you made recently
3. **Create a workflow** for your personal daily routine
4. **Add a quiz** for a topic you've mastered

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-2/lesson-7-cheat-system/`:

| File | Description |
|------|-------------|
| `my-favorite-tool.md` | Custom cheatsheet (Exercise 6) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can use `cheat` to find help for any tool
- [ ] I can use `qr` for quick reference cards
- [ ] I know where to find undo guides
- [ ] I can take quizzes to test my knowledge
- [ ] I can read workflows for complex tasks
- [ ] I created my own cheatsheet
- [ ] I will use the cheat system as my first line of help

**Total: ___ / 35**

---

## Phase 2 Complete! 🎉

You now have:
- A fully customized editor
- Version-controlled dotfiles
- A personalized starship prompt
- A self-documenting workflow with the cheat system

**Next:** Phase 3 — Data Manipulation & AI
