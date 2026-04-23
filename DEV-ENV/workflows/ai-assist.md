# AI-Assisted Development Workflow
> How to use `ai` and `opencode` together for maximum productivity.

## Quick Question → Answer
```bash
ai "how do I sort a list of dicts by key in Python?"
# Get instant answer without leaving terminal
```

## Analyze Code
```bash
cat complex_function.py | ai "explain this code step by step"
# Get a breakdown of what the code does
```

## Debug Error Messages
```bash
cat error.log | ai "what's causing this error and how do I fix it?"
# Paste error, get diagnosis and fix
```

## Generate Scripts
```bash
ai "write a bash script that finds all .log files older than 7 days and compresses them"
# Get a complete script, copy-paste to micro
```

## Convert Between Formats
```bash
cat data.json | ai "convert this to CSV format"
# Transform data without leaving terminal
```

## Full Coding Session (opencode)
```bash
opencode
# "add input validation to the user registration endpoint"
# Agent reads your codebase, understands context, suggests changes
# Review → accept → commit with lg
```

## The AI Loop
```
ai "explain the error" → read answer → e file (fix) → lg (commit)
     ↓
opencode "refactor this module" → review changes → e file (tweak) → lg (commit)
     ↓
ai "write tests for this function" → copy tests → e test_file.py → lg (commit)
```
