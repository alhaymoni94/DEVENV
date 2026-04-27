# yazi
> A fast terminal file manager with image preview and CUA keybindings.

Use the `y` wrapper (not `yazi` directly) — it drops you into the directory you navigated to when you quit:
```bash
y            # open yazi in current directory
y ~/Projects # open yazi at a specific path
```

---

## Layout
```
┌───────────────┬───────────────────────┬───────────────────┐
│  parent dir   │   current directory   │  preview          │
│               │                       │  (file contents,  │
│  Documents/   │▶ toolkit/             │   images, dirs)   │
│               │  Projects/            │                   │
│               │  Downloads/           │                   │
└───────────────┴───────────────────────┴───────────────────┘
  [status bar: path, permissions, size, selection count]
```

---

## Navigation (CUA)
| Key              | Action                              |
|------------------|-------------------------------------|
| `↑` / `↓`        | Move up/down                        |
| `←`              | Go to parent directory              |
| `→` / `Enter`    | Open file or enter directory        |
| `Home`           | Jump to top                         |
| `End`            | Jump to bottom                      |
| `PageUp`         | Scroll up half page                 |
| `PageDown`       | Scroll down half page               |
| `~`              | Go to home directory                |
| `-`              | Go to previous directory            |

---

## File operations
| Key           | Action                                            |
|---------------|---------------------------------------------------|
| `Space`       | Toggle selection on file                          |
| `v`           | Enter visual selection mode                       |
| `V`           | Select all in current directory                   |
| `Ctrl+C`      | Copy (yank) selected files                        |
| `Ctrl+X`      | Cut selected files                                |
| `Ctrl+V`      | Paste copied/cut files here                       |
| `d`           | Move selected to trash                            |
| `D`           | Delete permanently (with confirmation)            |
| `a`           | Create new file or directory (`dirname/` for dir) |
| `r`           | Rename file (opens inline)                        |
| `R`           | Bulk rename selection in `$EDITOR`                |

---

## View & Search
| Key   | Action                                  |
|-------|-----------------------------------------|
| `.`   | Toggle hidden files (dotfiles)          |
| `/`   | Search filenames in current dir         |
| `f`   | Filter — narrow visible files by name  |
| `s`   | Sort menu (name, size, modified, etc.)  |
| `z`   | Jump with zoxide (fuzzy directory jump) |

---

## Tabs
| Key         | Action                       |
|-------------|------------------------------|
| `Ctrl+T`    | Open new tab                 |
| `Ctrl+W`    | Close tab                    |
| `1`-`9`     | Switch to tab by number      |
| `[` / `]`   | Switch to previous/next tab  |

---

## Quit
| Key      | Action                                             |
|----------|----------------------------------------------------|
| `Ctrl+Q` | Quit and `cd` to current dir (via `y` wrapper)    |
| `q`      | Quit without changing directory                    |

---

## Tips
- **Image preview** works out of the box in WezTerm and most modern terminals
- **`R` bulk rename** opens all selected filenames in micro — edit them, save, quit — renames happen
- **`a` to create a directory**: type `dirname/` with a trailing slash
- **`z` for zoxide**: fuzzy-jump to any directory you've visited before
