# Terminal Anatomy

## Layer model
```
┌─────────────────────────────────────────┐
│  Terminal Emulator (WezTerm)            │
│  Renders text, fonts, colors, windows   │
├─────────────────────────────────────────┤
│  Multiplexer (tmux) — optional          │
│  Sessions, windows, panes               │
│  Detach = disconnect (session lives)    │
│  Attach = reconnect                     │
├─────────────────────────────────────────┤
│  Shell (zsh)                            │
│  Parses commands, runs programs         │
│  Manages environment, history, aliases  │
├─────────────────────────────────────────┤
│  Programs (micro, lazygit, yazi, etc.)  │
│  Run in the shell                       │
│  Read/write to terminal via stdio       │
└─────────────────────────────────────────┘
```

## Process hierarchy
```
wezterm (PID 1000)
└── tmux server (PID 1001)
    └── tmux session "main"
        ├── window 1
        │   ├── pane 1: zsh (PID 1002)
        │   └── pane 2: zsh (PID 1003)
        └── window 2
            └── pane 1: micro (PID 1004)
```

## Key concepts
- **Terminal emulator** draws characters on screen. WezTerm handles fonts, colors, GPU rendering.
- **Multiplexer** sits between terminal and shell. tmux manages sessions that outlive your terminal window.
- **Shell** is your command interpreter. zsh parses input, runs programs, manages environment.
- **TUI apps** are programs that draw interactive interfaces in the terminal using escape sequences.
- **Prefix key** (Ctrl+a) tells tmux "the next key is for me, not the shell."
