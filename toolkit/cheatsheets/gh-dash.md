# gh-dash
> GitHub dashboard in your terminal. PRs, issues, and reviews without leaving tmux.

Open with `gh dash`

```
┌─────────────────────────────────────────────────────────┐
│  My PRs  │  Needs My Review  │  All Camp PRs            │
├─────────────────────────────────────────────────────────┤
│  title            author   review    CI   updated       │
│▶ Fix login bug    alice    approved  ✓    2h ago        │
│  Add dark mode    bob      pending   ✗    4h ago        │
│  ...                                                    │
├─────────────────────────────────────────────────────────┤
│                   preview panel                         │
│  (PR description, diff summary, comments)               │
└─────────────────────────────────────────────────────────┘
```

---

## Navigation
| Key              | Action                              |
|------------------|-------------------------------------|
| `j` / `↓`        | Move down                           |
| `k` / `↑`        | Move up                             |
| `tab`            | Next section (PRs → Issues)         |
| `shift+tab`      | Previous section                    |
| `[` / `]`        | Switch between section tabs         |
| `p`              | Toggle preview panel open/closed    |
| `R`              | Refresh all sections                |
| `?`              | Show all keybindings                |
| `q`              | Quit                                |

---

## Pull Requests
| Key   | Action                                      |
|-------|---------------------------------------------|
| `enter` / `o` | Open PR in browser                  |
| `c`   | Checkout PR branch locally                  |
| `d`   | View diff in browser                        |
| `m`   | Merge PR                                    |
| `r`   | Request a review from someone               |
| `a`   | Assign PR to someone                        |
| `l`   | Add / remove labels                         |
| `C`   | Add a comment                               |
| `x`   | Close PR                                    |
| `X`   | Reopen PR                                   |
| `w`   | Watch / unwatch                             |

---

## Issues
| Key   | Action                                      |
|-------|---------------------------------------------|
| `enter` / `o` | Open issue in browser               |
| `a`   | Assign issue to someone                     |
| `l`   | Add / remove labels                         |
| `C`   | Add a comment                               |
| `x`   | Close issue                                 |
| `X`   | Reopen issue                                |

---

## Filtering
| Key   | Action                          |
|-------|---------------------------------|
| `/`   | Filter current section by text  |
| `esc` | Clear filter                    |

---

## Config
File: `~/.config/gh-dash/config.yml`

The camp repo is set in `~/Documents/toolkit/dotfiles/.chezmoi.toml.tmpl`:
```toml
[data]
    campRepo = "ORG/REPO"   ← change this when the repo is created
```

After changing, run `chezmoi apply` to regenerate the config.

---

## First-time setup
```bash
gh auth login               # authenticate with GitHub (one-time)
gh extension install dlvhdr/gh-dash
gh dash                     # open the dashboard
```
