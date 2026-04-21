# Lesson 7: Cheat System & Self-Documentation — Instructor Guide

## Duration: 1 hour

## Objectives

By the end of this lesson, students will:
- Use the full cheat system for self-directed learning
- Understand cheatsheets, quick-refs, undo-guides, workflows, and quizzes
- Create their own cheatsheets for new tools
- Build a personal knowledge base

## Lesson Flow

### Part 1: The Cheat System Overview (10 min)

**Cover all commands:**

| Command | Purpose |
|---------|---------|
| `cheat` | Interactive cheatsheet browser |
| `cheat --start` | Guided tour |
| `cheat tool-name` | Specific cheatsheet |
| `qr tool-name` | Quick reference card |
| `cheat --undo tool` | How to undo mistakes |
| `cheat --quiz topic` | Test your knowledge |
| `cheat --workflow name` | Step-by-step guides |
| `cheat --daily` | Daily tip |
| `tip` | Random pro tip |
| `cheat --list` | List all available sheets |

### Part 2: Guided Exploration (20 min)

**Have students run through each command:**

```bash
# Start the tour
cheat --start

# Browse all available sheets
cheat --list

# Look up specific tools
cheat micro
cheat tmux
cheat git

# Get quick references
qr micro
qr lazygit

# Learn how to undo
cheat --undo git
cheat --undo tmux

# Take quizzes
cheat --quiz micro
cheat --quiz lazygit

# Read workflows
cheat --workflow ai-assist
cheat --workflow git-branching

# Get tips
tip
cheat --daily
```

### Part 3: Creating Your Own Cheatsheet (15 min)

**Cover:**
- Where cheatsheets live: `toolkit/cheatsheets/`
- Format: Markdown with code blocks
- Structure: Quick commands, common tasks, tips

**Exercise:**
```bash
# Create a cheatsheet for a tool you use often
e toolkit/cheatsheets/my-tool.md
```

Template:
```markdown
# My Tool Cheatsheet

## Quick Start
\`\`\`bash
command --help
\`\`\`

## Common Commands
| Command | Description |
|---------|-------------|
| `cmd -a` | Do thing A |
| `cmd -b` | Do thing B |

## Tips
- Tip 1
- Tip 2
```

### Part 4: Building a Personal Knowledge Base (15 min)

**Teach students to:**
- Document solutions to problems they encounter
- Create personal workflows for their specific tasks
- Use the cheat system as their first line of help

**Exercise:**
```bash
# Create a personal workflow
e toolkit/workflows/my-daily-routine.md
```

## Assessment

- Students can navigate the cheat system
- Students create at least one personal cheatsheet
- Students understand how to add to the system

## Phase 2 Complete

Students now have:
- A personalized editor setup
- Version-controlled dotfiles
- A self-documenting workflow

**Next:** Phase 3 — Data Manipulation & AI
