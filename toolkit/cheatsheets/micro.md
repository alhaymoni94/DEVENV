# micro
> A terminal text editor with familiar keybindings. No modes, no config required — just open and edit.

Open a file: `micro filename`  
Exit: `Ctrl+Q`

---

## I want to...
| Intent                          | Key                  |
|---------------------------------|----------------------|
| Save                            | `Ctrl+S`             |
| Quit                            | `Ctrl+Q`             |
| Undo                            | `Ctrl+Z`             |
| Redo                            | `Ctrl+Y`             |
| Find                            | `Ctrl+F`             |
| Find and replace                | `Ctrl+H`             |
| Select all                      | `Ctrl+A`             |
| Copy selection                  | `Ctrl+C`             |
| Cut selection                   | `Ctrl+X`             |
| Paste                           | `Ctrl+V`             |
| Cut entire line                 | `Ctrl+K`             |
| Duplicate line                  | `Ctrl+D`             |
| Toggle comment                  | `Ctrl+/`             |
| Indent selection                | `Tab`                |
| Unindent selection              | `Shift+Tab`          |
| Go to line number               | `Ctrl+G`             |
| Open command prompt             | `Ctrl+E`             |
| Run a shell command             | `Ctrl+B`             |
| Open a new tab                  | `Ctrl+T`             |
| Switch tabs                     | `Alt+,` / `Alt+.`    |
| Close tab                       | `Ctrl+W`             |
| Toggle file browser             | `Ctrl+E` → `tree`    |

---

## Navigation
| Key                  | Action                        |
|----------------------|-------------------------------|
| Arrow keys           | Move cursor                   |
| `Ctrl+←` / `Ctrl+→` | Jump word left / right        |
| `Home` / `End`       | Start / end of line           |
| `Ctrl+Home`          | Top of file                   |
| `Ctrl+End`           | Bottom of file                |
| `PgUp` / `PgDn`      | Scroll page                   |
| Mouse click          | Place cursor                  |

---

## Selection
| Key                        | Action                  |
|----------------------------|-------------------------|
| `Shift+arrows`             | Select character by character |
| `Shift+Ctrl+←` / `→`      | Select word by word     |
| `Shift+Home` / `Shift+End` | Select to line start/end |
| `Shift+Ctrl+Home/End`      | Select to file start/end |
| Mouse drag                 | Select region           |

---

## Command Prompt (`Ctrl+E`)
Type commands after the `>` prompt:

| Command                    | Action                            |
|----------------------------|-----------------------------------|
| `save`                     | Save file                         |
| `quit`                     | Quit                              |
| `set tabsize 4`            | Set tab width to 4                |
| `set tabstospaces on`      | Use spaces instead of tabs        |
| `set colorscheme dracula`  | Change color scheme               |
| `help keybindings`         | Show all keybindings              |
| `run git diff`             | Run shell command, show output    |
| `term`                     | Open a terminal pane inside micro |

---

## Multiple Cursors
| Key            | Action                                  |
|----------------|-----------------------------------------|
| `Alt+Click`    | Add cursor at click position            |
| `Ctrl+Up/Down` | Add cursor on line above/below          |
| `Alt+D`        | Select next occurrence of current word  |
| `Alt+L`        | Select all occurrences of current word  |
| `Escape`       | Collapse to single cursor               |

---

## Plugins
```bash
micro -plugin install lsp          # Language Server Protocol support
micro -plugin install filemanager  # sidebar file browser
micro -plugin install prettier     # auto-format on save
micro -plugin list                 # show installed plugins
micro -plugin update               # update all plugins
```

Config file: `~/.config/micro/settings.json`
