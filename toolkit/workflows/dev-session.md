# Dev Session Workflow

```
┌──────────────────────────────────────────────────────────────┐
│  🚀  START A DEV SESSION                                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   $ tmux new -s project-name                                 │
│                                                              │
│   ┌──────────────────────┬─────────────────────────────────┐ │
│   │  micro (editor)      │  zsh (terminal)                 │ │
│   │                      │                                 │ │
│   │  e .                 │  run tests, git, etc            │ │
│   │                      │                                 │ │
│   │  Ctrl+S  save        │  lg     → git TUI               │ │
│   │  Ctrl+Q  quit        │  top    → system monitor        │ │
│   │  Ctrl+/  comment     │  ai     → ask AI                │ │
│   │  Ctrl+F  find        │                                 │ │
│   │  Ctrl+H  replace     │                                 │ │
│   └──────────────────────┴─────────────────────────────────┘ │
│                                                              │
│   Prefix |  → split horizontal    Prefix - → split vertical  │
│   Alt+←→  → move between panes   Prefix c → new window       │
│   Prefix d  → detach (keeps running)                         │
│   tmux attach → resume later                                 │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Step-by-Step

### 1. Create Session
```bash
tmux new -s myproject
```

### 2. Split Layout
```
Prefix |     →  split horizontally
Alt+Right →  switch to right pane
```

### 3. Open Editor
```bash
e .        # open micro with file browser
```

### 4. Work
```
Edit → Ctrl+S (save) → test in terminal → repeat
```

### 5. Commit
```bash
lg         # open lazygit
Space      # stage files
c          # commit message
P          # push
q          # quit
```

### 6. Detach & Resume
```bash
Prefix d              # detach
# ... come back later ...
tmux attach -t myproject   # resume
```
