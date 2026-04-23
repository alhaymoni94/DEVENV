# Starship

> Minimal, fast, cross-shell prompt. Shows git status, language versions, and more.

## Configuration

File: `~/.config/starship/starship.toml`

```toml
# Disable the line break between prompts
add_newline = true

# Customize the directory display
[directory]
truncation_length = 3
truncate_to_repo = true

# Git status icons
[git_status]
conflicted = "🏳"
ahead = "🏎💨"
behind = "😰"
diverged = "😵"
untracked = "🤷"
stashed = "📦"
modified = "📝"
staged = "✅"
renamed = "👅"
deleted = "🗑"

# Show Python version in Python projects
[python]
pyenv_version_name = true

# Don't show unless in a Node project
[nodejs]
detect_extensions = ["js", "mjs", "cjs", "ts"]
```

---

## Common Customizations

**Add a custom command segment:**
```toml
[custom.memory]
command = "free -m | awk '/Mem:/{printf \"%.1fG\", $3/1024}'"
when = true
style = "bold red"
format = "[$symbol$output]($style) "
symbol = "🧠 "
```

**Add timestamp:**
```toml
[time]
disabled = false
format = '🕙[[$time]]($style) '
style = "bold yellow"
```

**Change git branch color:**
```toml
[git_branch]
style = "cyan"
```

---

## I want to...

| Intent | Command |
|--------|---------|
| Edit config | `e ~/.config/starship/starship.toml` |
| Test config | `starship explain` |
| Print prompt manually | `starship prompt` |
| Enable in current shell | `eval "$(starship init zsh)"` |
| Disable a module | Set `disabled = true` in its config block |

---

## See Also
- `cheat shell` — zsh configuration where starship is initialized
- `cheat chezmoi` — managing starship.toml across machines
