# opencode
> AI coding agent that reads your codebase and helps you code.

Open: `opencode`

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

## How It Differs from aichat
| Feature           | opencode          | aichat            |
|-------------------|-------------------|-------------------|
| Codebase context  | Reads your files  | Pipe input manually |
| Multi-file edits  | Yes               | No                |
| Conversational    | Yes               | Yes               |
| General questions | Limited           | Yes               |
| Best for          | Coding tasks      | General AI chat   |

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
