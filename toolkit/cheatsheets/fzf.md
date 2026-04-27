# fzf

> Fuzzy finder for the terminal. Filters lists interactively.

## I want to...

| Intent | Command |
|--------|---------|
| Search files recursively | `find . -type f \| fzf` |
| Search command history | `Ctrl+R` (bound in zsh) |
| Select from git branches | `git branch \| fzf` |
| Kill a process | `ps aux \| fzf \| awk '{print $2}' \| xargs kill` |
| Open a file in editor | `fzf --preview 'bat {}' \| xargs micro` |
| Select multiple files | `fzf -m` |
| Search with preview | `fzf --preview 'cat {}'` |

---

## Integration with Other Tools

**With git:**
```bash
git checkout $(git branch | fzf | sed 's/^[* ]*//')
```

**With docker:**
```bash
docker stop $(docker ps -q | fzf -m)
```

**With kill:**
```bash
kill -9 $(ps aux | fzf | awk '{print $2}')
```

---

## Key Bindings in fzf

| Key | Action |
|-----|--------|
| `Ctrl+J/K` or `↓/↑` | Navigate |
| `Ctrl+P/N` | Navigate |
| `Tab` | Select multiple |
| `Ctrl+A` | Select all |
| `Ctrl+D` | Deselect all |
| `Enter` | Confirm |
| `Ctrl+C/Esc` | Cancel |
| `Ctrl+/` | Toggle preview |

---

## Environment Variables

```bash
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
```

---

## See Also
- `cheat shell` — Ctrl+R history search uses fzf
- `cheat yazi` — file manager with fzf-like navigation
