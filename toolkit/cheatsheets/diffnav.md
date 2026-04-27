# diffnav

> Interactive git diff navigator. Replaces the default `git diff` pager.

## Installation

```bash
brew install dlvhdr/formulae/diffnav
```

## Usage

**Set as your default git pager:**
```bash
export GIT_PAGER='diffnav'
git diff
```

**Or use one-off:**
```bash
git diff | diffnav
git log -p | diffnav
```

---

## Key Bindings

| Key | Action |
|-----|--------|
| `j/k` or `↓/↑` | Navigate hunks |
| `h/l` or `←/→` | Navigate files |
| `Space` | Stage/unstage current hunk |
| `s` | Stage file |
| `q` | Quit |
| `?` | Show help |

---

## Configuration

Add to `~/.zshrc` to make permanent:
```bash
export GIT_PAGER='diffnav'
```

---

## See Also
- `cheat lazygit` — full git TUI with diff view
- `cheat git` — core git commands
