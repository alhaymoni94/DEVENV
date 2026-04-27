# Tool Map — How Everything Connects

```
┌─────────────────────────────────────────────────────────────────┐
│                    TERMINAL EMULATOR                            │
│                    (Ghostty / WezTerm)                          │
│                  Renders text, fonts, colors                    │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    MULTIPLEXER (tmux)                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐    │
│  │  Session:   │  │  Session:   │  │  Session:           │    │
│  │   dev       │  │   ops       │  │   data              │    │
│  │  ┌───┬───┐  │  │  ┌───┬───┐  │  │  ┌───┬───┐          │    │
│  │  │ e │ lg│  │  │  │lzd│top│  │  │  │ vd │eu │          │    │
│  │  └───┴───┘  │  │  └───┴───┘  │  │  └───┴───┘          │    │
│  └─────────────┘  └─────────────┘  └─────────────────────┘    │
│  Prefix: Ctrl+a  │  Detach: Prefix d  │  Attach: tmux attach  │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                        SHELL (zsh)                               │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  Starship Prompt: ~/project  main ⇡2 !3  via v3.11  ❯  │   │
│  │  Autosuggestions + Syntax Highlighting + fzf-tab        │   │
│  └─────────────────────────────────────────────────────────┘   │
└──────────────────────────┬──────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
┌────────▼───────┐ ┌──────▼──────┐ ┌────────▼────────┐
│   EDITING      │ │   FILES     │ │   GIT           │
│   micro (e)    │ │   yazi (y)  │ │   lazygit (lg)  │
│   Ctrl+S save  │ │   ↑↓ nav    │ │   Space stage   │
│   Ctrl+Q quit  │ │   → enter   │ │   c commit       │
│   Ctrl+Z undo  │ │   Ctrl+C/V  │ │   P push         │
│   Ctrl+/ comment│ │   d trash   │ │   z undo         │
└────────────────┘ └─────────────┘ └─────────────────┘
         │                 │                 │
┌────────▼───────┐ ┌──────▼──────┐ ┌────────▼────────┐
│   AI           │ │   SYSTEM    │ │   GITHUB        │
│   ai (one-shot)│ │   btop(top) │ │   gh-dash (ghd) │
│   opencode     │ │   lazydocker│ │   gh-enhance    │
│   (interactive)│ │   (lzd)     │ │   gh CLI        │
└────────────────┘ └─────────────┘ └─────────────────┘
         │                 │                 │
┌────────▼───────┐ ┌──────▼──────┐ ┌────────▼────────┐
│   DATA         │ │  DIAGRAMS   │ │   HELP          │
│   visidata(vd) │ │   d2        │ │   cheat         │
│   euporie      │ │   mmdc      │ │   qr, tip       │
│   llmfit       │ │             │ │   intelli-shell │
└────────────────┘ └─────────────┘ └─────────────────┘
```

## Common Workflows

### Edit → Commit Loop
```
y (browse) ──Enter──▶ micro (edit) ──Ctrl+S──▶ save
  ──Ctrl+Q──▶ lg (stage+commit) ──P──▶ push
```

### Dev Session
```
tmux new -s dev ──Prefix |──▶ split panes
  ──e .──▶ editor ──Alt+Right──▶ terminal
  ──Prefix d──▶ detach ──tmux attach──▶ resume
```

### AI-Assisted Debug
```
cat error.log ──|──▶ ai "what's wrong?"
  ──read answer──▶ e config (fix) ──lg──▶ commit
```

### File Management
```
y (browse) ──Space──▶ select ──Ctrl+C──▶ copy
  ──navigate──▶ Ctrl+V──▶ paste ──d──▶ trash
```

## Support Layer (Always Available)

```
┌─────────────────────────────────────────────────────┐
│  CHEAT SYSTEM (External Memory)                     │
│                                                     │
│  cheat          → Visual stack map                  │
│  cheat <topic>  → Cheatsheet + nav (1-9, m, b, q)   │
│  cheat --browse → Full fzf browser                  │
│  qr <tool>      → One-pager quick reference         │
│  tip            → Random pro tip                    │
│  cheat --start  → First-run tour                    │
│  cheat --quiz   → Self-test                         │
│  cheat --undo   → Recovery guide                    │
│  Ctrl+Space     → Intelli-shell (69 commands)       │
└─────────────────────────────────────────────────────┘
```
