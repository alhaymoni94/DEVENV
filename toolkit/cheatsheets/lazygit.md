# lazygit
> A terminal UI for git. Five panels, single-key commands, no memorizing flags.

Open with `lg` from any git repo.

```
┌──────────┬────────────────────────────────────────┐
│  Status  │                                        │
├──────────┤           Main panel                   │
│  Files   │        (diffs, logs, etc.)             │
├──────────┤                                        │
│ Branches │                                        │
├──────────┼────────────────────────────────────────┤
│  Commits │              Stash                     │
└──────────┴────────────────────────────────────────┘
```

---

## Navigation
| Key              | Action                              |
|------------------|-------------------------------------|
| `↑` / `↓`        | Move within a panel                 |
| `Tab`            | Cycle to next panel                 |
| `Shift+Tab`      | Cycle to previous panel             |
| `[` / `]`        | Switch between panel tabs           |
| `?`              | Show all keybindings (in-app help)  |
| `q`              | Quit lazygit                        |

---

## Files Panel — Staging & Committing
| Key   | Action                                      |
|-------|---------------------------------------------|
| `↑↓`  | Move between files                          |
| `space` | Stage / unstage file                      |
| `a`   | Stage / unstage all files                  |
| `Enter` | Open file diff in main panel             |
| `e`   | Open file in `$EDITOR`                     |
| `d`   | Discard changes in file                    |
| `D`   | Discard all changes (with confirm)         |
| `c`   | Commit staged changes                      |
| `C`   | Commit using your `$EDITOR`               |
| `A`   | Amend last commit with staged changes      |
| `z`   | Undo last git action                       |

---

## Branches Panel
| Key     | Action                              |
|---------|-------------------------------------|
| `space` | Checkout branch                     |
| `n`     | New branch                          |
| `d`     | Delete branch                       |
| `r`     | Rebase current branch onto selected |
| `M`     | Merge selected branch into current  |
| `f`     | Fetch branch                        |
| `P`     | Push current branch                 |
| `p`     | Pull current branch                 |

---

## Commits Panel
| Key   | Action                                      |
|-------|---------------------------------------------|
| `Enter` | View commit diff                          |
| `s`   | Squash commit into previous                 |
| `f`   | Fixup commit into previous (no message)     |
| `r`   | Reword commit message                       |
| `d`   | Drop commit                                 |
| `e`   | Edit commit (stops rebase for amending)     |
| `A`   | Amend commit with staged changes            |
| `p`   | Pick commit (during rebase)                 |
| `ctrl+i` | Interactive rebase from this commit      |
| `c`   | Cherry-pick commit                          |
| `t`   | Revert commit                               |

---

## Stash Panel
| Key     | Action          |
|---------|-----------------|
| `space` | Apply stash     |
| `g`     | Pop stash       |
| `d`     | Drop stash entry|
| `n`     | New stash       |

---

## Common Workflow: Feature Branch
```
n → name branch        create and checkout new branch
↑↓ in Files, space     stage changed files
a                      or stage everything at once
c → write message      commit
P                      push branch
```

## Common Workflow: Fix Last Commit
```
c → commit new changes    or stage changes first
A                         amend last commit
P (force if needed)       push --force-with-lease
```
