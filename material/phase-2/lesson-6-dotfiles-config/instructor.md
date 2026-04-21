# Lesson 6: Dotfiles & Config Management — Instructor Guide

## Duration: 1.5 hours

## Objectives

By the end of this lesson, students will:
- Understand what dotfiles are and why they matter
- Use chezmoi to version-control their configurations
- Customize their starship prompt
- Understand tmux configuration
- Sync configs across machines

## Lesson Flow

### Part 1: What Are Dotfiles? (15 min)

**Cover:**
- Files starting with `.` are hidden in Unix
- `~/.zshrc`, `~/.tmux.conf`, `~/.gitconfig` — these control your environment
- Why manage them? (backup, sync, reproduce your setup)

**Demo:**
```bash
# Show hidden files
ls -la ~

# Show what's managed by chezmoi
chezmoi managed
```

### Part 2: Chezmoi Basics (25 min)

**Cover:**
- `chezmoi status` — what's out of sync
- `chezmoi diff` — what will change
- `chezmoi apply` — apply configs
- `chezmoi add` — add a new file to management
- `chezmoi edit` — edit a managed file

**Demo:**
```bash
# Check status
chezmoi status

# See what would change
chezmoi diff

# Edit a managed file
chezmoi edit dot_zshrc

# Apply changes
chezmoi apply
```

**Have students practice:**
1. Check their chezmoi status
2. View the diff
3. Edit their zshrc through chezmoi

### Part 3: Starship Prompt (25 min)

**Cover:**
- What is starship? (fast, customizable prompt)
- Config file: `~/.config/starship/starship.toml`
- Segments: git, directory, languages, time
- Custom segments

**Demo:**
```bash
e ~/.config/starship/starship.toml
# Show the structure
# Modify a segment
# Add a custom segment
```

**Have students practice:**
1. Open their starship config
2. Change the git segment color
3. Add a timestamp segment
4. Apply and see the changes

### Part 4: Tmux Configuration (20 min)

**Cover:**
- `~/.tmux.conf` — tmux settings
- Keybindings, status bar, colors
- Reloading config: `tmux source-file ~/.tmux.conf`

**Demo:**
```bash
e ~/.tmux.conf
# Show keybindings
# Show status bar config
# Reload: tmux source-file ~/.tmux.conf
```

**Have students practice:**
1. Change the prefix key (optional)
2. Customize the status bar
3. Reload the config

### Part 5: Syncing Across Machines (15 min)

**Cover:**
- Why chezmoi is better than git for dotfiles
- Templates and variables
- Machine-specific overrides

**Demo:**
```bash
# Show the chezmoi source directory
chezmoi cd

# Show templates
cat .chezmoi.toml.tmpl

# Add a new config
chezmoi add ~/.config/app/config
```

## Common Issues

| Issue | Solution |
|-------|----------|
| chezmoi status shows changes | Run `chezmoi apply` |
| Starship not loading | Check `eval "$(starship init zsh)"` in zshrc |
| Tmux config not applying | Run `tmux source-file ~/.tmux.conf` |

## Assessment

- Students understand dotfiles concept
- Students can use chezmoi to manage configs
- Students customize their starship prompt

## Next Lesson

Lesson 7: Cheat System & Self-Documentation
