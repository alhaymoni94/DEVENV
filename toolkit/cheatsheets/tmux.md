# tmux
> A session manager and multiplexer: sessions persist after disconnect, windows are tabs, panes are splits.

**Prefix key: `Ctrl+a`** (this config changed it from the default `Ctrl+b`)

## I want to...
| Intent                                | Key                         |
|---------------------------------------|-----------------------------|
| Split pane left/right                 | `Prefix \|`                 |
| Split pane top/bottom                 | `Prefix -`                  |
| Move between panes                    | `Alt+Arrow`                 |
| Create a new window (tab)             | `Prefix c`                  |
| Go to next window                     | `Alt+n`                     |
| Go to previous window                 | `Alt+p`                     |
| Jump to window by number              | `Alt+1` … `Alt+5`           |
| Rename current window                 | `Prefix ,`                  |
| Kill current pane                     | `Prefix x`                  |
| Kill current window                   | `Prefix X`                  |
| Detach from session                   | `Prefix d`                  |
| List sessions (from shell)            | `tmux ls`                   |
| Attach to session (from shell)        | `tmux attach -t name`       |
| New named session (from shell)        | `tmux new -s name`          |
| Resize pane                           | `Prefix H/J/K/L` (5 cells)  |
| Enter copy mode                       | `Prefix Enter`              |
| Reload config                         | `Prefix r`                  |
| Swap window left/right                | `Prefix Shift+Left/Right`   |
| See all key bindings                  | `Prefix ?`                  |

---

## Core Concepts

```
Session  →  one "workspace" (survives disconnect)
 └── Window  →  like a browser tab
      └── Pane  →  a split within a window
```

You can have multiple sessions for different projects. Detach and reattach without losing state.

---

## Copy Mode (vi-style navigation)
Enter with `Prefix Enter`. This config uses emacs key mode for copy mode.

| Key      | Action                    |
|----------|---------------------------|
| `↑ ↓`   | scroll line by line       |
| `C-u`    | scroll up half page       |
| `C-d`    | scroll down half page     |
| `C-s`    | search forward            |
| `q`      | exit copy mode            |

To copy to system clipboard: hold `Shift` and drag with the mouse in your terminal.

---

## Status Bar (right side)
`CPU% | RAM used/total | Disk used/total | PREFIX indicator | date | time`

The `PREFIX` indicator lights up when you've pressed `Ctrl+a` and are waiting for a command.

---

## Common Workflows

**Start a dev session:**
```bash
tmux new -s myproject
# Prefix | to split for editor | terminal
# Prefix c to open a new window for tests
# Prefix d to detach — session keeps running
```

**Return to work:**
```bash
tmux attach -t myproject
```

**Run Emacs in one pane, terminal in another:**
```
Prefix |          split vertically
emacs -nw .       in left pane
Prefix Alt+Right  move to right pane for shell work
```
