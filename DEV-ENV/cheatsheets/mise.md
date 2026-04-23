# mise

> Runtime version manager — replaces nvm, rbenv, pyenv, etc. with one tool.

## I want to...

| Intent | Command |
|--------|---------|
| Install a runtime | `mise use node@lts` |
| Install specific version | `mise use python@3.12` |
| List installed versions | `mise list` |
| List available versions | `mise list-remote node` |
| Set global default | `mise use -g node@20` |
| Run with specific version | `mise exec node@18 -- node script.js` |
| Check current versions | `mise current` |
| Update all plugins | `mise plugin update --all` |
| Self-update mise | `mise self-update` |

---

## Project-Level Runtimes

In your project root:
```bash
mise use node@20 python@3.12
```

This creates `.mise.toml`:
```toml
[tools]
node = "20"
python = "3.12"
```

Anyone with mise who `cd`s into the project gets those versions automatically.

---

## Activation

mise is activated in `~/.zshrc`:
```bash
eval "$(mise activate zsh)"
```

---

## See Also
- `cheat shell` — where mise is activated in zshrc
- `cheat uv` — Python environment management (complements mise)
