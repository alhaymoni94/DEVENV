# opencode

> AI coding agent that reads your codebase and helps you code.

Open: `opencode` or `ai` (for one-shot/pipe mode)

---

## I want to...
| Intent                          | Key / Command                    |
|---------------------------------|----------------------------------|
| Start coding session            | `opencode`                       |
| Ask about current project       | Type your question in session    |
| Generate code                   | "write a function that..."       |
| Debug an issue                  | "why is this failing..."         |
| Refactor code                   | "refactor this to..."            |
| Exit session                    | `Ctrl+D` or `/exit`              |

---

## One-Shot Mode (via `ai` wrapper)

| Feature           | opencode TUI      | ai (one-shot)     |
|-------------------|-------------------|-------------------|
| Codebase context  | Reads your files  | Pipe input manually |
| Multi-file edits  | Yes               | No                |
| Conversational    | Yes               | No (single prompt) |
| General questions | Yes               | Yes               |
| Best for          | Coding tasks      | Quick answers     |

**Examples:**
```bash
ai "explain recursion in Python"
cat file.py | ai "explain this code"
ai --system "you are a shell expert" "how do I find large files?"
```

---

## Common Workflows

**Debug a failing test:**
```bash
opencode
# "why is test_xyz failing?"
# Agent reads the test file and suggests fixes
```

**Generate a new feature:**
```bash
opencode
# "add a function that validates email addresses"
# Agent writes the code, you review and accept
```

**Refactor existing code:**
```bash
opencode
# "refactor this module to use async/await"
# Agent suggests changes, you apply them
```
