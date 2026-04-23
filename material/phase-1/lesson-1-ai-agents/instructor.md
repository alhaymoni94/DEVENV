# Lesson 1: AI Agents in the Terminal — Instructor Guide

## Duration: 1.5 hours

## Objectives

By the end of this lesson, students will:
- Understand how AI agents work in the terminal
- Use `ai` for quick questions, pipe input, and code analysis
- Use `opencode` for full coding sessions
- Navigate the `cheat` system for self-directed learning
- Use AI as a learning assistant throughout the camp

## Prerequisites

- `setup.sh` completed with 40/40 health
- AI API key configured in ~/.opencode.json (OpenAI, Anthropic, Gemini, or local)

## Lesson Flow

### Part 1: Introduction (15 min)

**Talk through:**
- Why AI in the terminal? (Context awareness, no context switching, pipe data directly)
- The two AI tools in our stack:
  - `ai` — Quick questions, one-shot answers, pipe-friendly
  - `opencode` — Full coding agent that understands your codebase

**Demo:**
```bash
# Quick question
ai "what is the difference between grep and ack?"

# Analyze a file
cat ~/.zshrc | ai "explain this file section by section"
```

### Part 2: AI One-Shot Mode (25 min)

**Cover these use cases:**

| Use Case | Command |
|----------|---------|
| Quick question | `ai "your question"` |
| Analyze code | `cat file.py \| ai "explain this"` |
| Debug errors | `cat error.log \| ai "what's wrong?"` |
| Generate scripts | `ai "write a bash script that..."` |
| Convert data | `cat data.json \| ai "convert to CSV"` |
| Interactive session | `ai` (opens opencode TUI) |

**Have students practice:**
1. Ask AI to explain a concept they don't understand
2. Pipe a file to AI and ask for an explanation
3. Ask AI to write a simple script
4. Use AI to debug a deliberate error

### Part 3: opencode Deep Dive (20 min)

**Cover:**
- How opencode differs from `ai` (reads your codebase, suggests changes, Plan vs Build mode)
- When to use each tool

**Have students practice:**
```bash
opencode
# "Create a Python script that reads a CSV file and prints statistics"
# "Add error handling to the script"
# "Write tests for this function"
```

### Part 4: The Cheat System (15 min)

**Cover all cheat commands:**

| Command | Purpose |
|---------|---------|
| `cheat` | Interactive cheatsheet browser |
| `cheat --start` | Guided tour |
| `cheat tool-name` | Specific cheatsheet |
| `qr tool-name` | Quick reference card |
| `cheat --undo tool` | How to undo mistakes |
| `cheat --quiz topic` | Test your knowledge |
| `cheat --workflow name` | Step-by-step guides |
| `tip` | Random pro tip |

**Have students:**
1. Run `cheat --start` for the tour
2. Look up `cheat micro`
3. Try `cheat --quiz micro`
4. Get a random tip with `tip`

### Part 5: AI-Assisted Learning Strategy (15 min)

**Teach students to:**
- Use AI as a tutor, not a crutch
- Ask "why" not just "how"
- Verify AI answers with `cheat` and documentation
- Use AI to explain error messages before asking the instructor

**Exercise:**
Give students a broken command and have them use AI + cheat to fix it:
```bash
# Deliberately broken:
git comit -m "test"

# Students should:
# 1. See the error
# 2. Ask AI: "git comit: command not found"
# 3. Or use: cheat git
# 4. Fix it: git commit -m "test"
```

## Common Issues

| Issue | Solution |
|-------|----------|
| `ai` returns nothing | Check API key: `cat ~/.opencode.json` |
| `opencode` won't start | Run `opencode --version` to diagnose |
| AI gives wrong answers | Cross-reference with `cheat` and docs |
| Rate limiting | Wait a moment, then retry |

## Assessment

- Students complete the lab exercises
- Students run `cheat --quiz ai` (if available)
- Students demonstrate asking AI a question and applying the answer

## Next Lesson

Lesson 2: Unix Fundamentals — navigation, files, permissions, shell basics
