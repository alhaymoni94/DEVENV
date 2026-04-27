# How the Stack Fits Together

## Architecture
```
Terminal Emulator (WezTerm)
└── Multiplexer (tmux) — sessions persist across disconnects
    ├── Shell (zsh) — command entry, history, completions
    ├── Editor (micro) — file editing, CUA bindings
    ├── File Manager (yazi) — browsing, preview, operations
    ├── Git TUI (lazygit) — staging, committing, branching
    ├── Docker TUI (lazydocker) — container management
    ├── System Monitor (btop) — CPU, RAM, processes
    ├── AI Assistant (ai/opencode) — one-shot + interactive AI
    └── GitHub CLI (gh) — PRs, issues, dashboards
```

## How they work together
```
yazi → select file → e → micro → edit → Ctrl+S → Ctrl+Q
lg → stage → commit → push
tmux → detach/attach → session persists
ai "question" → get answer → apply in editor
opencode → coding session → review changes → commit
```

## The cheat system
```
cheat                    # visual stack map (default)
cheat <topic>            # open cheatsheet + interactive navigation
cheat --browse           # interactive browser (fzf)
cheat --quick <tool>     # one-pager reference
cheat --daily            # random pro tip
cheat --quiz <topic>     # self-test
cheat --workflow <name>  # multi-tool workflow guide
cheat --list             # list all topics
```

**Navigation:** After reading any cheatsheet, press a number to jump to a related topic, `m` for the stack map, `b` to browse, `s` to search, or `q` to quit.

## Dotfiles management
```
chezmoi                  # sync configs across machines
chezmoi apply            # deploy dotfiles
chezmoi add <file>       # start tracking a config
```
