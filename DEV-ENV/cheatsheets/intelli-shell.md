# intelli-shell

> IntelliSense for your shell — searchable command history and bookmarks.

## What It Is

intelli-shell adds smart command search and bookmarking to your terminal. Press a key combo to search 60+ pre-loaded camp commands, bookmark your own, or fix failing commands.

## Key Bindings

| Key | Action | When to Use |
|-----|--------|-------------|
| `Ctrl+Space` | Search commands | You forgot a command or want to browse |
| `Ctrl+O` | Bookmark command | You typed a useful command and want to save it |
| `Ctrl+L` | Replace variables | You want to re-run a command with different args |
| `Ctrl+X` | Fix command | The last command failed and you want suggestions |

> **Note:** `Ctrl+B` is reserved for tmux prefix. Bookmark uses `Ctrl+O` instead.

## Pre-Loaded Commands

60+ commands covering the entire stack are imported automatically during setup:

```bash
# View all imported commands
intelli-shell export

# Search interactively (same as Ctrl+Space)
intelli-shell search -i

# Bookmark a new command manually
intelli-shell new -i "your command here"
```

## Manual Import (if setup missed it)

```bash
intelli-shell import ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles/private_dot_config/intelli-shell/commands.yml
```

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Key bindings don't work | Shell integration not loaded | Restart terminal or run `exec zsh` |
| No commands shown | Import failed | Run manual import command above |
| `Ctrl+Space` does nothing | Terminal intercepts it | Try `Ctrl+@` instead, or remap in terminal settings |
| `Ctrl+O` opens file instead | Terminal emulator conflict | Use `intelli-shell new -i` manually |

## Shell Integration

The zshrc includes:

```bash
if command -v intelli-shell &>/dev/null; then
  export INTELLI_BOOKMARK_HOTKEY="^o"
  eval "$(intelli-shell init zsh)"
fi
```

To disable: comment out those lines in `~/.zshrc` and run `exec zsh`.

## See Also

- `cheat shell` — general shell tips
- `cheat zsh` — zsh-specific features
