# Which Tool When?

> Decision tree for every tool in the stack. When you're not sure which tool to use, look here.

---

## File Operations

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Browse files visually           | `y` (yazi) | Preview, copy/paste, search, tabs   |
| Quick file listing              | `ls`       | Faster than opening yazi            |
| Find a file by name             | `y` → `/`  | Visual search with preview          |
| Find files in terminal          | `find . -name pattern` | Scriptable, pipeable      |
| Jump to a directory             | `z` (in yazi) | Zoxide — fuzzy jump to visited dirs |
| Quick directory change          | `cd` or `..` | Built-in, no tool needed           |
| Create a file                   | `a` (in yazi) or `touch` | Depends on context       |
| Create a directory              | `a` (in yazi, type `name/`) or `mkdir` | Context-dependent |
| Bulk rename files               | `R` (in yazi) | Opens all names in micro          |
| Move/copy files                 | `Ctrl+C/V` (in yazi) | Visual, undoable via trash  |
| Delete files                    | `d` (in yazi) | Goes to trash, recoverable      |
| View file contents              | Preview pane (in yazi) | No need to open the file   |

## Editing

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Edit a file                     | `e` (micro) | CUA bindings, simple, fast         |
| Edit with file browser          | `e .`      | Micro's built-in file browser       |
| Quick text edit in terminal     | `nano`     | Already available, zero setup       |
| Edit a config file              | `e ~/.config/app/config` | Standard workflow        |
| Multi-cursor editing            | `Alt+Click` (in micro) | Edit multiple places at once |
| Find and replace in a file      | `Ctrl+H` (in micro) | Built-in, works well         |
| Edit in a GUI                   | Open with your GUI editor | Outside terminal scope    |

## Git & Version Control

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Stage and commit code           | `lg` (lazygit) | Visual diff, easy staging, branching |
| Quick git status                | `git status` | One command, no TUI needed     |
| View recent commits             | `lg` or `git log --oneline` | Depends on depth needed |
| Create a new branch             | `n` (in lazygit) | Visual, shows existing branches |
| Switch branches                 | `Space` on branch (in lazygit) | Visual selection       |
| Undo a git mistake              | `z` (in lazygit) or `cheat --undo git` | Safety net     |
| Amend last commit               | `A` (in lazygit, after staging) | One key           |
| Squash commits                  | `s` (in lazygit commits panel) | Interactive rebase UI |
| Create a PR                     | `gh pr create --fill` | CLI, fast, fill from commits |
| View PRs and issues             | `ghd` (gh-dash) | Dashboard view, keyboard-driven |
| Check PR CI status              | `gh pr checks` | Quick, no TUI needed          |
| View git diff                   | `diffnav`  | Navigate diffs with keyboard       |

## AI Assistance

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Ask a general question          | `ai` (aichat) | Conversational, remembers context |
| Analyze a file                  | `cat file | ai "explain"` | Pipe input directly    |
| Debug an error message          | `echo "error" | ai "what's wrong?"` | Paste and ask     |
| Generate a script               | `ai "write a bash script that..."` | Get code back        |
| Convert between formats         | `cat data.json | ai "convert to CSV"` | Pipe and transform |
| Get coding help in context      | `opencode` | Reads your codebase, understands project |
| Change AI persona               | `/role coder` (in aichat) | Switch to coding mode  |
| Save a conversation             | `/save file.md` (in aichat) | Reference later        |

## System & Docker

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Monitor system resources        | `top` (btop) | Beautiful, detailed, keyboard-driven |
| Quick process check             | `ps aux`   | One-liner, no TUI needed            |
| Quick CPU/RAM check             | Status bar (in tmux) | Always visible, no command  |
| Manage Docker containers        | `lzd` (lazydocker) | Visual, easy navigation, logs   |
| Quick Docker command            | `docker ps`  | One-liner, no TUI needed           |
| View container logs             | `lzd` or `docker logs <container>` | Depends on depth |

## Data & Notebooks

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| View/edit a CSV                 | `vd file.csv` (visidata) | TUI spreadsheet, keyboard-driven |
| View/edit a JSON file           | `vd file.json` (visidata) | Auto-parses, explore interactively |
| Run a Jupyter notebook          | `euporie`  | TUI notebooks, no browser needed    |
| Evaluate LLM performance        | `llmfit`   | Benchmarking and fitting            |

## Diagrams

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Create a diagram from text      | `d2 diagram.d2 output.png` | D2 markup language    |
| Render a Mermaid diagram        | `mmdc -i diagram.mmd -o diagram.png` | Mermaid CLI       |

## Help & Reference

| I want to...                    | Use this | Why                                  |
|---------------------------------|----------|--------------------------------------|
| Look up how to use a tool       | `cheat <topic>` | Full cheatsheet with examples  |
| Quick reference for a tool      | `qr <tool>` | One-pager, top 10 actions         |
| Get a random tip                | `tip`      | Learn something new, 55+ tips      |
| Test my knowledge               | `cheat --quiz <topic>` | Interactive self-test       |
| Recover from a mistake          | `cheat --undo <tool>` | "I messed up" recovery guides |
| See a multi-tool workflow       | `cheat --workflow <name>` | Step-by-step guides       |
| Find a command I used before    | `Ctrl+Space` (intelli-shell) | 69 preloaded commands    |
| Search command history          | `Ctrl+R`   | Built-in, fuzzy search              |
| Start the first-run tour        | `cheat --start` | 2-minute guided walkthrough    |

---

## Tool Relationships

### The Edit → Commit Loop
```
y (browse) → Enter (open in micro) → edit → Ctrl+S (save) → Ctrl+Q (quit)
→ lg (lazygit) → Space (stage) → c (commit) → P (push) → q (quit)
```

### The Dev Session
```
tmux new -s project → Prefix | (split) → e . (editor) → Alt+Right (terminal)
→ work → Prefix d (detach) → tmux attach (resume later)
```

### The AI-Assisted Debug
```
cat error.log | ai "what's wrong?" → read answer → e config (fix) → lg (commit fix)
```

### The File Management Flow
```
y (browse) → Space (select) → Ctrl+C (copy) → navigate → Ctrl+V (paste)
→ d (trash unwanted) → . (toggle hidden) → / (search for specific file)
```
