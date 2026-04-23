# Shell (zsh + zinit + Starship)
> zsh is bash with better completion and plugins. Starship is a fast cross-platform prompt. zinit manages plugins.

## I want to...
| Intent                                | Key / Command                        |
|---------------------------------------|--------------------------------------|
| Search command history                | `Ctrl+R`                             |
| Go to beginning of line               | `Ctrl+A`                             |
| Go to end of line                     | `Ctrl+E`                             |
| Delete word before cursor             | `Ctrl+W`                             |
| Delete to end of line                 | `Ctrl+K`                             |
| Delete to start of line               | `Ctrl+U`                             |
| Clear screen                          | `Ctrl+L`                             |
| Autocomplete                          | `TAB`                                |
| Cycle through completions             | `TAB TAB` or arrow keys              |
| Run previous command as sudo          | `sudo !!`                            |
| Open cheatsheet                       | `cheat <tool>`                       |
| List available cheatsheets            | `cheat`                              |
| Open micro editor                     | `e` or `micro <file>`                |
| Open lazygit                          | `lg`                                 |
| Open lazydocker                       | `lzd`                                |
| Check stack health                    | `bash toolkit/doctor.sh` (from camp root) |

---

## Zsh Keybindings (Emacs mode)

This config uses `bindkey -e` (Emacs mode for line editing):

| Key        | Action                                     |
|------------|--------------------------------------------|
| `Ctrl+A`   | Go to start of line                        |
| `Ctrl+E`   | Go to end of line                          |
| `Ctrl+F`   | Move forward one character                 |
| `Ctrl+B`   | Move backward one character                |
| `Alt+F`    | Move forward one word                      |
| `Alt+B`    | Move backward one word                     |
| `Ctrl+W`   | Delete word backward                       |
| `Alt+D`    | Delete word forward                        |
| `Ctrl+U`   | Delete to start of line                    |
| `Ctrl+K`   | Delete to end of line                      |
| `Ctrl+R`   | Reverse history search                     |
| `Ctrl+P`   | Previous command                           |
| `Ctrl+N`   | Next command                               |
| `Ctrl+L`   | Clear screen                               |
| `Ctrl+Z`   | Suspend process (fg to resume)             |
| `Ctrl+C`   | Cancel current command                     |

---

## Starship Prompt

The prompt shows (from left to right):
```
~/Documents/myproject  main ⇡2 !3  via  3.11.0  took 5s
❯
```
- Directory (truncated to 3 levels)
- Git branch + status (`⇡` ahead, `⇣` behind, `!` modified, `?` untracked)
- Python version (when in a Python project)
- Command duration (if >2 seconds)

Config file: `~/.config/starship/starship.toml`

---

## zinit Plugin Commands

| Command                                 | Action                           |
|-----------------------------------------|----------------------------------|
| `zinit update`                          | Update all plugins               |
| `zinit update plugin-name`              | Update one plugin                |
| `zinit light user/repo`                 | Install & load plugin            |
| `zinit status`                          | Show plugin status               |

Installed plugins:
- `zsh-autosuggestions` — ghost text suggestions as you type (→ to accept)
- `zsh-syntax-highlighting` — color codes valid/invalid commands
- `zsh-completions` — extra completion definitions
- `fzf-tab` — fuzzy-search TAB completions

---

## Useful Shell Patterns

**Search command history interactively:**
```bash
Ctrl+R  →  type partial command  →  Ctrl+R to cycle matches  →  Enter
```

**Run last command with sudo:**
```bash
sudo !!
```

**Edit last command in your editor:**
```bash
fc        # opens last command in $EDITOR (micro)
```

**Set up a Python virtualenv:**
```bash
uv venv .venv
source .venv/bin/activate
uv pip install pandas
```

**Quick directory navigation:**
```bash
..       # cd ..  (auto-cd is enabled)
...      # cd ../..
mydir/   # cd mydir/ (auto-cd: just type dir name + TAB)
```
