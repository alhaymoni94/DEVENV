# Getting Started — AUT Terminal Stack

Welcome! This guide takes you from zero to a fully configured, production-grade terminal environment.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Start (5 minutes)](#quick-start-5-minutes)
3. [Your First Session](#your-first-session)
4. [Understanding the Stack](#understanding-the-stack)
5. [Daily Workflow](#daily-workflow)
6. [Essential Commands](#essential-commands)
7. [Learning Path](#learning-path)
8. [Troubleshooting](#troubleshooting)
9. [End-to-End Testing](#end-to-end-testing)

---

## Prerequisites

- **OS**: Linux (Ubuntu 24.04+ recommended) or macOS
- **Shell**: zsh (installed by setup.sh if missing)
- **Sudo access**: Required for font installation and some system packages
- **Git**: Already installed on most systems
- **Homebrew**: Install from https://brew.sh if not present

---

## Quick Start (5 minutes)

### Step 1: Run the Setup Script

```bash
cd toolkit/
bash setup.sh
```

This will:
- Install all 32+ tools (skipping what's already installed)
- Configure zsh, starship prompt, and tmux
- Set up chezmoi for dotfile management
- Import 60+ commands into intelli-shell
- Run a health check at the end

**Expected output**: A doctor report showing 40/40 checks passing.

### Step 2: Open a New Terminal

After setup, open a new terminal window. You should see:
- A colorful starship prompt with git status
- A welcome dashboard showing system stats and quick commands
- All your aliases working (`e`, `y`, `lg`, `ai`, etc.)

### Step 3: Take the Interactive Tour

```bash
cheat --start
```

This launches a 2-minute guided tour of all available tools and commands.

---

## Your First Session

### Open the File Manager

```bash
y
```

This opens **yazi**, a terminal file manager. Navigate with arrow keys, press `Enter` to open files, `q` to quit.

### Edit a File

```bash
e README.md
```

This opens **micro**, a modern terminal editor. Key bindings:
- `Ctrl+S` — Save
- `Ctrl+Q` — Quit
- `Ctrl+C / V / X` — Copy / Paste / Cut (just like GUI editors!)

### Check Git Status

```bash
lg
```

This opens **lazygit**, a beautiful git TUI. Stage files with `Space`, commit with `c`, push with `P`.

### Ask AI a Question

```bash
ai "how do I list all processes using more than 100MB of RAM?"
```

Get instant answers without leaving the terminal.

---

## Understanding the Stack

### Layer 1: Foundation
| Tool | Purpose | Alias |
|------|---------|-------|
| **zsh** | Shell with better features than bash | — |
| **starship** | Fast, customizable prompt | — |
| **tmux** | Terminal multiplexer (sessions, panes, windows) | — |
| **wezterm** | GPU-accelerated terminal emulator | — |

### Layer 2: Core Workflow
| Tool | Purpose | Alias |
|------|---------|-------|
| **yazi** | Terminal file manager | `y` |
| **micro** | Terminal text editor | `e` |
| **lazygit** | Git TUI | `lg` |
| **fzf** | Fuzzy finder | — |

### Layer 3: System & Data
| Tool | Purpose | Alias |
|------|---------|-------|
| **btop** | System monitor (CPU, RAM, disk, network) | — |
| **lazydocker** | Docker container management TUI | `lzd` |
| **visidata** | Spreadsheet-like data analysis | `vd` |
| **euporie** | Terminal Jupyter notebooks | — |

### Layer 4: AI & Automation
| Tool | Purpose | Alias |
|------|---------|-------|
| **aichat** | AI assistant for quick questions | `ai` |
| **opencode** | Full AI coding agent | `opencode` |
| **intelli-shell** | Smart command history search | — |
| **llmfit** | LLM evaluation framework | — |

### Layer 5: Documentation & Diagrams
| Tool | Purpose | Alias |
|------|---------|-------|
| **glow** | Render markdown in terminal | — |
| **d2** | Diagram-as-code | — |
| **mmdc** | Mermaid diagram renderer | — |
| **diffnav** | Navigate git diffs visually | — |
| **treemd** | Directory tree with markdown preview | — |

### Support Tools
| Tool | Purpose |
|------|---------|
| **chezmoi** | Dotfile management (version control for configs) |
| **mise** | Runtime version manager (Python, Node, Rust, etc.) |
| **uv** | Fast Python package manager |
| **gh** | GitHub CLI |
| **gh-dash** | GitHub PR/Issue dashboard |
| **cheat** | Interactive cheatsheet browser (custom-built) |

---

## Daily Workflow

### Morning: Start Your Dev Session

```bash
# Create a tmux session for your project
tmux new -s myproject

# Open the project in your editor
e .

# Open a second pane for running tests (Ctrl+B, then %)
# Open a third pane for git operations (Ctrl+B, then ")
```

### During Development

```bash
# Check what changed
lg                    # lazygit shows all modifications

# Need help with something?
cheat git             # Browse git cheatsheet
qr lazygit            # Quick reference for lazygit

# Stuck on an error?
cat error.log | ai "what's wrong here?"

# Need to visualize data?
vd results.csv        # Open in visidata

# System running slow?
btop                  # Check resource usage
```

### End of Day: Commit and Wrap Up

```bash
# Review and commit changes
lg                    # Stage, commit, push from TUI

# Or use the command line
git add -A && git commit -m "feat: add new feature"
git push

# Detach from tmux (session keeps running)
Ctrl+B, then D

# Reattach tomorrow
tmux attach -t myproject
```

---

## Essential Commands

### Navigation
```bash
y                     # File manager
cd -                  # Go back to previous directory
z pattern             # Fuzzy jump to directory (if installed)
```

### Editing
```bash
e file.py             # Open file in micro
e .                   # Open directory in micro
Ctrl+S                # Save (in micro)
Ctrl+Q                # Quit (in micro)
```

### Git
```bash
lg                    # Git TUI
ghd                   # GitHub PR dashboard
git log --oneline --graph --all   # Visual git log
```

### System
```bash
btop                  # System monitor
lzd                   # Docker TUI
docker ps             # Running containers
```

### AI
```bash
ai "your question"    # Quick AI answer
ai < file.py          # Analyze file content
opencode              # Full coding agent session
```

### Help System
```bash
cheat                 # Interactive cheatsheet browser
cheat --start         # Guided tour
cheat tool-name       # Specific cheatsheet
qr tool-name          # Quick reference card
cheat --undo tool     # How to undo mistakes
cheat --quiz topic    # Test your knowledge
tip                   # Random pro tip
```

---

## Learning Path

### Week 1: Basics
- [ ] Run `setup.sh` and verify 40/40 health with `doctor.sh`
- [ ] Take the interactive tour: `cheat --start`
- [ ] Learn micro basics: `cheat micro`
- [ ] Learn yazi basics: `cheat yazi`
- [ ] Practice: Create a file, edit it, save it

### Week 2: Git Mastery
- [ ] Learn lazygit: `cheat lazygit`
- [ ] Complete the lazygit quiz: `cheat --quiz lazygit`
- [ ] Learn the undo guide: `cheat --undo lazygit`
- [ ] Practice: Make commits, amend, reset, stash

### Week 3: Terminal Power User
- [ ] Learn tmux basics: `cheat tmux`
- [ ] Set up your first tmux session with panes
- [ ] Learn fzf: `cheat fzf`
- [ ] Practice: Navigate your system without a mouse

### Week 4: Data & AI
- [ ] Try visidata: `vd sample.csv`
- [ ] Ask aichat a question: `ai "explain recursion"`
- [ ] Render a markdown file: `glow README.md`
- [ ] Practice: Analyze a dataset entirely in the terminal

---

## Troubleshooting

### Setup Failed
```bash
# Check what's broken
bash toolkit/doctor.sh

# Re-run setup (safe to run multiple times)
bash toolkit/setup.sh
```

### Chezmoi Out of Sync
```bash
# Sync your dotfiles
chezmoi apply --force --no-pager

# Check status
chezmoi status
```

### Terminal Looks Broken
```bash
# Reset terminal state
reset

# Unfreeze (if you accidentally pressed Ctrl+S)
Ctrl+Q
```

### Can't Find a Command
```bash
# Check if it's installed
command -v toolname

# Check your PATH
echo $PATH

# Cargo tools (aichat) need ~/.cargo/bin in PATH
export PATH="$HOME/.cargo/bin:$PATH"
```

### Need Help
```bash
# Browse all available cheatsheets
cheat --list

# Get a random tip
tip

# Ask AI for help
ai "how do I do X in the terminal?"
```

---

## End-to-End Testing

This section verifies your entire stack works correctly from setup to daily use.

### Test 1: Setup Script

```bash
# Run setup (should complete without errors)
bash toolkit/setup.sh

# Verify doctor shows 40/40
bash toolkit/doctor.sh
```

**Expected**: All 40 checks pass, 100% health.

### Test 2: Core Tools

```bash
# Editor
echo "test" > /tmp/test.txt && e /tmp/test.txt && rm /tmp/test.txt

# File manager
y --help

# Git TUI
lg --version

# System monitor
btop --version
```

**Expected**: Each command runs without errors.

### Test 3: Aliases

```bash
# Test aliases work
which e
which y
which lg
which ai
```

**Expected**: All aliases resolve to their commands.

### Test 4: Help System

```bash
# Test cheat system
cheat --list
cheat micro
qr micro
cheat --undo micro
cheat --quiz micro
tip
```

**Expected**: All commands return useful information.

### Test 5: AI Tools

```bash
# Test aichat (requires API key)
ai "what is 2+2?"

# Test opencode
opencode --version
```

**Expected**: aichat returns an answer, opencode shows version.

### Test 6: Docker Tools

```bash
# Test docker
docker --version

# Test lazydocker
lzd --version
```

**Expected**: Both commands show version info.

### Test 7: Data Tools

```bash
# Test visidata
vd --version

# Test euporie
euporie --version

# Test glow
glow --version
```

**Expected**: All commands show version info.

### Test 8: Workflows

```bash
# Test workflow access
cheat --workflow ai-assist
cheat --workflow git-branching
cheat --workflow docker-compose
cheat --workflow debugging
cheat --workflow project-setup
```

**Expected**: All workflows display correctly.

### Test 9: Intelli-Shell

```bash
# Test intelli-shell
intelli-shell --version

# Verify commands are imported
intelli-shell list
```

**Expected**: Shows version and lists 60+ commands.

### Test 10: Full Session

```bash
# Create a test session
tmux new -d -s test-session

# Verify session exists
tmux ls | grep test-session

# Kill test session
tmux kill-session -t test-session
```

**Expected**: Session created and killed successfully.

---

## What's Next?

After completing this guide:

1. **Explore workflows**: `cheat --workflow ai-assist`
2. **Take quizzes**: `cheat --quiz micro`, `cheat --quiz lazygit`
3. **Practice undo operations**: `cheat --undo tmux`
4. **Customize your stack**: Edit configs with `chezmoi edit`
5. **Contribute**: Add your own cheatsheets to `toolkit/cheatsheets/`

Happy terminal hacking! ⚡
