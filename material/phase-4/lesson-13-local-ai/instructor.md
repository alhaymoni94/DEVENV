# Lesson 13: Local AI Development — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Understand the difference between cloud AI and local AI
- Use `ai` for quick terminal questions and pipe input
- Use opencode for full coding sessions
- Configure AI tools with API keys
- Understand model selection trade-offs
- Use AI for code review, debugging, and generation

## Prerequisites

- Phase 4 completed
- AI API key configured

## Lesson Flow

### Part 1: AI in the Terminal (15 min)

**Talk through:**
- Why terminal AI? (no context switching, pipe data directly, works over SSH)
- `ai` vs opencode:
  - `ai`: quick questions, one-shot answers, pipe-friendly
  - opencode: full coding agent, reads your codebase, suggests changes
- Cost considerations (API calls vs local models)

### Part 2: AI One-Shot Mode Deep Dive (25 min)

**Cover use cases:**

| Use Case | Command |
|----------|---------|
| Quick question | `ai "what is recursion?"` |
| Explain code | `cat file.py \| ai "explain this"` |
| Debug errors | `cat error.log \| ai "what's wrong?"` |
| Generate scripts | `ai "write a bash script that..."` |
| Convert formats | `cat data.json \| ai "convert to CSV"` |
| Interactive chat | `ai` (opens session) |

**Demo:**
```bash
ai "explain the difference between TCP and UDP"
cat ~/.zshrc | ai "summarize what this config does"
echo "def greet(name): print(f'Hello {name}')" | ai "add type hints and docstring"
```

**Have students practice:**
1. Ask 3 questions about concepts they don't understand
2. Pipe a config file to AI for explanation
3. Generate a script and test it

### Part 3: opencode Deep Dive (25 min)

**Cover:**
- How opencode reads your codebase
- Multi-step development
- When to use opencode vs `ai`

**Demo:**
```bash
mkdir ~/ai-demo && cd ~/ai-demo
opencode
# "Create a Python CLI tool that manages a todo list"
# "Add a search feature"
# "Write tests for all functions"
```

**Have students practice:**
1. Start an opencode session
2. Build a small project step by step
3. Review the generated code
4. Ask for improvements

### Part 4: AI for Code Review (20 min)

**Demo:**
```bash
# Take a student's previous script
cat ~/bin/organize.sh | ai "review this script for:
1. Security issues
2. Edge cases not handled
3. Performance improvements
4. Best practices"
```

**Have students practice:**
1. Pick one of their scripts
2. Ask AI to review it
3. Apply the suggestions
4. Compare before/after

### Part 5: Model Selection & Configuration (20 min)

**Cover:**
- API key configuration: `~/.opencode.json`
- Model options (GPT-4, Claude, Gemini, etc.)
- Cost management

**Demo:**
```bash
e ~/.opencode.json
```

**Have students practice:**
1. Check their config
2. Change the model
3. Adjust temperature
4. Test the difference

### Part 6: AI-Assisted Workflow (15 min)

**Demo the full loop:**
```
1. ai "plan a project" → get a plan
2. opencode "build it" → get code
3. ai "review the code" → get feedback
4. e file → make manual tweaks
5. lg → commit
```

## Common Issues

| Issue | Solution |
|-------|----------|
| ai returns nothing | Check API key in config |
| Rate limiting | Wait and retry, or switch model |
| Wrong/bad answers | Cross-reference with cheat system |
| opencode won't start | Run `opencode --version` to diagnose |

## Assessment

- Students use `ai` for quick questions
- Students use opencode for a coding session
- Students use AI for code review
- Students configure their AI tools

## Next Step

Graduation Project
