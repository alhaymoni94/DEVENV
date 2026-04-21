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
    ├── AI Chat (aichat) — terminal-native conversational AI
    └── GitHub CLI (gh) — PRs, issues, dashboards
```

## How they work together
```
yazi → select file → e → micro → edit → Ctrl+S → Ctrl+Q
lg → stage → commit → push
tmux → detach/attach → session persists
aichat → ask questions → get answers → apply in editor
```

## The cheat system
```
cheat                    # interactive browser (fzf)
cheat <topic>            # open specific cheatsheet
cheat --quick <tool>     # one-pager reference
cheat --daily            # random pro tip
cheat --quiz <topic>     # self-test
cheat --workflow <name>  # multi-tool workflow guide
cheat --list             # list all topics
```

## Dotfiles management
```
chezmoi                  # sync configs across machines
chezmoi apply            # deploy dotfiles
chezmoi add <file>       # start tracking a config
```
