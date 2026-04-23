# Chezmoi

> Manage your dotfiles across multiple machines with a single source of truth.

## I want to...

| Intent | Command |
|--------|---------|
| Check status | `chezmoi status` |
| See pending changes | `chezmoi diff` |
| Apply changes | `chezmoi apply` |
| Force apply (overwrite local) | `chezmoi apply --force` |
| Add a file to management | `chezmoi add ~/.config/app/settings.yaml` |
| Edit a managed file | `chezmoi edit ~/.zshrc` |
| Open source directory | `chezmoi cd` |
| List managed files | `chezmoi managed` |
| Update from source | `chezmoi update` |

---

## Templates

Chezmoi supports templates for machine-specific values:

```toml
# In .chezmoi.toml.tmpl
[data]
    email = "you@example.com"
```

Use in templates:
```toml
# In dot_gitconfig.tmpl
[user]
    email = {{ .email }}
```

---

## Common Patterns

**Add your entire `.config` directory:**
```bash
chezmoi add ~/.config/
```

**See what would change before applying:**
```bash
chezmoi diff
chezmoi apply --dry-run
```

**Re-add after editing the real file:**
```bash
chezmoi re-add ~/.zshrc
```

---

## File Naming

| Real path | Source path |
|-----------|-------------|
| `~/.zshrc` | `dot_zshrc` |
| `~/.config/micro` | `dot_config/micro` |
| `~/.ssh/id_rsa` | `private_dot_ssh/id_rsa` |
| `~/.local/bin` | `dot_local/bin` |

`private_` prefix makes the file readable only by owner.

---

## See Also
- `cheat --undo chezmoi` — recovery guides
- `cheat shell` — zsh configuration managed by chezmoi
