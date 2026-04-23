# Lesson 14: TUI Coding Agents — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Use opencode for complex multi-step development tasks
- Use AI for refactoring existing code
- Practice test-driven development with AI
- Use AI for thorough code reviews

## Prerequisites

- Phase 4 completed
- Comfortable with opencode and aichat

## Lesson Flow

### Part 1: opencode Advanced Patterns (30 min)

**Cover prompting strategies:**
- Be specific about requirements
- Break large tasks into steps
- Review before accepting changes
- Iterate: "now add X", "fix Y", "optimize Z"

**Demo:**
```bash
mkdir ~/agent-demo && cd ~/agent-demo
opencode
# "Create a REST API with Flask for a book library"
# "Add authentication"
# "Add rate limiting"
# "Write tests"
```

### Part 2: AI-Assisted Refactoring (25 min)

**Demo:**
```bash
# Create intentionally bad code
e messy.py
```

```python
def f(x):
    data = []
    for i in x:
        if i > 0:
            data.append(i * 2)
    return data
```

```bash
cat messy.py | ai "refactor this: descriptive names, type hints, docstrings, list comprehensions"
```

### Part 3: TDD with AI (25 min)

**Demo the TDD loop with opencode:**
```bash
opencode
# "I want to build a URL shortener. First, write the tests."
# "Now write minimal code to pass the tests."
# "Refactor."
```

### Part 4: Code Review Agent (20 min)

**Have students review their own previous work:**
```bash
cat ~/bin/backup.sh | ai "perform a thorough code review"
```

## Assessment

- Students complete a multi-step coding task with opencode
- Students refactor code using AI
- Students do TDD with AI assistance
