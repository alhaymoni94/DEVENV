# Stack Map — How Everything Connects
> Which tool owns which domain, and how they integrate.

## The Big Picture

```
┌─────────────────────────────────────────────────────────────────┐
│  WezTerm  (GPU-accelerated terminal, Tokyo Night, Nerd Fonts)   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  tmux  (session/window/pane manager — survives disconnect) │  │
│  │                                                           │  │
│  │   micro   lazygit  gh-dash  lazydocker  btop   yazi      │  │
│  │   (edit)  (git)    (GitHub) (docker)   (sys)  (files)    │  │
│  │                                                           │  │
│  │   visidata  llmfit  intelli-shell  mmdc                    │  │
│  │   zsh + starship  (shell + prompt)                        │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘

Chezmoi manages all dotfiles ←→ source: toolkit/dotfiles/
```

---

## Domain → Tool Map

| Domain              | Tool                          | Notes                        |
|---------------------|-------------------------------|------------------------------|
| Text editing        | micro                         | `e file` or `micro file`     |
| Git (local)         | lazygit                       | `lg` from any repo           |
| Git (GitHub)        | gh-dash + gh-enhance          | `gh dash` — PRs, issues, CI  |
| File management     | yazi                          | `y` — quits and cds to dir  |
| Docker              | lazydocker                    | `lzd`                        |
| Python env          | uv                            | `uv venv` / `uv add`         |
| Other runtimes      | mise (Node, Go, etc.)         | `mise use node@lts`          |
| Shell               | zsh + zinit + intelli-shell   | plugins auto-loaded          |
| Prompt              | Starship                      | cross-platform, git-aware    |
| Multiplexer         | tmux                          | all splitting done here      |
| Terminal emulator   | WezTerm                       | tabs only, splits via tmux   |
| Dotfiles            | Chezmoi + dotstate            | `chezmoi apply`              |
| System monitoring   | btop                          | `top` — CPU, RAM, processes  |
| Data exploration    | visidata                      | `vd data.csv`                |
| LLM fine-tuning     | llmfit                        | terminal-based               |
| Diagramming         | d2 + treemd + mmdc            | text-to-diagram              |
| Markdown viewer     | glow                          | `glow file.md` or `cheat`    |
| Cheatsheets         | `cheat` command               | `cheat <tool>`               |

---

## Data Flow: Where Things Live

```
~/Documents/
├── toolkit/          ← THIS DIRECTORY (scripts, cheatsheets, dotfiles source)
│   ├── dotfiles/     ← chezmoi source → deploys to ~/.*  and  ~/.config/
│   ├── cheatsheets/  ← tool references  (cheat <name>)
│   ├── workflows/    ← end-to-end guides (cheat <workflow>)
│   ├── concepts/     ← explanations      (cheat <concept>)
│   ├── setup.sh      ← run once to install everything
│   └── doctor.sh     ← health check
└── Projects/         ← your code projects
    └── myproject/
        ├── .git/     ← lazygit operates here
        ├── .venv/    ← uv virtualenv
        └── src/
```

---

## Key Integration Points


**micro as `$EDITOR`**: Anything that opens your editor (`git commit`, `fc`, `crontab -e`) launches micro automatically.

**lazygit + gh-dash cover the full git loop**: `lg` for local operations (stage, commit, branch), `gh dash` for the GitHub side (PRs, review requests, CI status, issues). Together they replace the browser entirely.


**Chezmoi ↔ Everything**: Edit dotfiles via `chezmoi edit ~/.zshrc`. Source of truth is `~/Documents/toolkit/dotfiles/`. `chezmoi apply` deploys changes.

**Starship ↔ Cross-machine**: Same `starship.toml` works on Linux and Mac. Shows git status, Python env, Docker context automatically.

---

## Cheatsheet Quick Reference
```
cheat micro       micro editor keys and commands
cheat lazygit     git workflow: stage, commit, push, branch
cheat gh-dash     GitHub PRs, issues, reviews in the terminal
cheat gh-enhance  enhance GitHub CLI with additional features
cheat yazi        file manager: navigation, copy, rename, preview
cheat tmux        sessions, splits, navigation
cheat shell       zsh keybindings, zinit, starship
cheat stack-map   this file
cheat chezmoi     system-wide dotfile management
cheat euporie     Jupyter notebooks in the terminal
cheat diffnav     navigate git diffs with ease
cheat treemd      generate tree diagrams from directories
cheat d2          create diagrams with text
cheat visidata    explore and manipulate data in the terminal
cheat llmfit      fine-tune LLMs in the terminal
cheat intelli-shell intelligent shell with pre-populated commands
cheat mmdc        Mermaid diagram CLI
```

---

## Keyboard Philosophy

| Tool      | Philosophy                                   | Conflict risk |
|-----------|----------------------------------------------|---------------|
| micro     | GUI-style: Ctrl+S save, Ctrl+Q quit          | None          |
| tmux      | Prefix key (Ctrl+a) then single key          | Low           |
| zsh       | Emacs-mode line editing (Ctrl+A/E/R/W/K)     | Low           |
| WezTerm   | Ctrl+Shift for terminal-level (tabs, resize) | None          |

No modal editing. No conflicting modifier layers. Ctrl is the universal prefix.
