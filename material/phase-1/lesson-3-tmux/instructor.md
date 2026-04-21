# Lesson 3: Tmux Mastery — Instructor Guide

## Duration: 1.5 hours

## Objectives

By the end of this lesson, students will:
- Understand tmux sessions, windows, and panes
- Create, attach, detach, and kill sessions
- Split panes and navigate between them
- Customize tmux keybindings
- Use tmux for productive dev workflows

## Prerequisites

- Lesson 2 completed
- tmux installed (verified by doctor.sh)

## Lesson Flow

### Part 1: Why Tmux? (10 min)

**Talk through:**
- Terminal multiplexer: multiple terminals in one window
- Sessions persist — close terminal, come back later
- Panes for parallel work (editor + terminal + logs)
- Remote work: SSH into server, start tmux, disconnect, reconnect

**Demo:**
```bash
# Start a session
tmux new -s demo

# Detach (session keeps running)
Ctrl+B, D

# Reattach
tmux attach -t demo
```

### Part 2: Sessions (15 min)

**Cover:**
- `tmux new -s name` — create session
- `tmux ls` — list sessions
- `tmux attach -t name` — attach
- `tmux kill-session -t name` — kill
- `Ctrl+B, D` — detach

**Have students practice:**
1. Create 3 sessions: `work`, `play`, `learn`
2. List them with `tmux ls`
3. Switch between them
4. Kill one, reattach to another

### Part 3: Windows (15 min)

**Cover:**
- `Ctrl+B, C` — new window
- `Ctrl+B, 0-9` — switch window
- `Ctrl+B, ,` — rename window
- `Ctrl+B, &` — kill window

**Have students practice:**
1. In a session, create 3 windows
2. Name them: "editor", "terminal", "logs"
3. Switch between them
4. Kill one

### Part 4: Panes (25 min)

**Cover:**
- `Ctrl+B, %` — split vertical
- `Ctrl+B, "` — split horizontal
- `Ctrl+B, arrow` — move between panes
- `Ctrl+B, X` — kill pane
- `Ctrl+B, Z` — zoom pane
- `Ctrl+B, Space` — cycle layouts

**Have students practice:**
1. Split into 3 panes (editor, terminal, logs)
2. Move between panes
3. Zoom one pane, then unzoom
4. Kill a pane, create a new one

### Part 5: Copy Mode & Scrollback (15 min)

**Cover:**
- `Ctrl+B, [` — enter copy mode
- Arrow keys or vim keys to scroll
- `Space` to start selection
- `Enter` to copy
- `Ctrl+B, ]` — paste

**Have students practice:**
1. Run a command with lots of output
2. Enter copy mode and scroll up
3. Select and copy text
4. Paste it somewhere

### Part 6: Dev Workflow (15 min)

**Demo the standard layout:**
```
┌─────────────────┬──────────────────┐
│                 │                  │
│   micro (edit)  │   terminal       │
│                 │   (run/test)     │
│                 │                  │
├─────────────────┤                  │
│   lazygit       │                  │
│                 │                  │
└─────────────────┴──────────────────┘
```

**Have students practice:**
1. Create this layout
2. Open a file in the editor pane
3. Run a command in the terminal pane
4. Check git status in the lazygit pane

## Common Issues

| Issue | Solution |
|-------|----------|
| Prefix not working | Default is `Ctrl+B`, check `.tmux.conf` |
| Can't scroll | Enter copy mode: `Ctrl+B, [` |
| Session disappeared | `tmux ls` to find it |
| Pane frozen | `Ctrl+Q` to unfreeze |

## Assessment

- Students create a session with 3 windows
- Students split a window into 3 panes
- Students detach and reattach to a session

## Next Lesson

Lesson 4: Git Workflow
