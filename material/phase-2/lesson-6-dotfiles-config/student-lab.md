# Lesson 6: Dotfiles & Config Management — Student Lab

## Duration: 1.5 hours

---

## Exercise 1: Explore Your Dotfiles (15 min)

**Task:** Find and understand your configuration files.

```bash
# List hidden files in your home directory
ls -la ~ | head -20

# List hidden files in .config
ls -la ~/.config/

# Check which files are managed by chezmoi
chezmoi managed
```

**Questions to answer:**
1. How many dotfiles do you have?
2. Which ones are managed by chezmoi?
3. Which ones are NOT managed?

---

## Exercise 2: Chezmoi Status (15 min)

**Task:** Understand chezmoi's state.

```bash
# Check what's out of sync
chezmoi status

# If there are changes, see what they are
chezmoi diff

# Apply any pending changes
chezmoi apply --force --no-pager

# Verify everything is in sync
chezmoi status  # should show nothing
```

**Check:** Your dotfiles should match the source in `toolkit/dotfiles/`.

---

## Exercise 3: Customize Starship (25 min)

**Task:** Make your prompt your own.

```bash
# Open your starship config
e ~/.config/starship/starship.toml
```

**Try these modifications:**

1. **Change the git color:**
```toml
[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "cyan"
```

2. **Add a timestamp:**
```toml
[time]
disabled = false
format = '🕙[\[ $time \]]($style) '
style = "bold yellow"
```

3. **Add a custom command:**
```toml
[custom.memory]
command = "free -m | awk '/Mem:/{printf \"%.1fG\", $3/1024}'"
when = true
style = "bold red"
format = "[$symbol$output]($style) "
symbol = "🧠 "
```

4. **Change the directory format:**
```toml
[directory]
style = "bold cyan"
truncate_to_repo = true
```

**Apply changes:**
```bash
# Starship reloads automatically, but you can force it:
exec zsh
```

**Check:** Open a new terminal or run `exec zsh` to see your new prompt.

---

## Exercise 4: Tmux Configuration (20 min)

**Task:** Customize your tmux setup.

```bash
# Open tmux config
e ~/.tmux.conf
```

**Try these modifications:**

1. **Change the status bar colors:**
```
set -g status-style "bg=colour235,fg=colour136"
```

2. **Add window labels:**
```
set -g window-status-format "#I:#W"
set -g window-status-current-format "#I:#W*"
```

3. **Increase scrollback buffer:**
```
set -g history-limit 50000
```

4. **Add a confirmation for killing sessions:**
```
bind K confirm-before -p "Kill session #S? (y/n)" kill-session
```

**Apply changes:**
```bash
# Inside tmux:
tmux source-file ~/.tmux.conf
```

**Check:** Your status bar should look different.

---

## Exercise 5: Add a New Config (15 min)

**Task:** Add a new file to chezmoi management.

```bash
# Create a custom config
mkdir -p ~/.config/myapp
e ~/.config/myapp/settings.yaml
```

Add:
```yaml
theme: dark
font_size: 14
auto_save: true
```

```bash
# Add it to chezmoi
chezmoi add ~/.config/myapp/settings.yaml

# Verify it's managed
chezmoi managed | grep myapp

# Check the source
chezmoi cd
ls private_dot_config/myapp/
```

**Check:** The file should now be tracked in the chezmoi source directory.

---

## Exercise 6: Machine-Specific Configs (15 min)

**Task:** Understand how chezmoi handles different machines.

```bash
# Go to the source directory
chezmoi cd

# Look at the template
cat .chezmoi.toml.tmpl
```

**Understand:** This template allows machine-specific variables. For example:
```toml
sourceDir = "{{ .chezmoi.homeDir }}/path/to/your/dotfiles"

[data]
    campRepo = "YOUR_ORG/YOUR_REPO"
```

**Exercise:** Add a machine-specific variable:
```bash
# Edit the template
e .chezmoi.toml.tmpl
```

Add under `[data]`:
```toml
    machineName = "{{ .chezmoi.hostname }}"
```

---

## Bonus Challenges

1. **Create a custom starship segment** that shows your battery percentage
2. **Add a tmux plugin** (research tmux plugin manager)
3. **Backup your dotfiles** to a git repository
4. **Create a setup script** that installs and configures everything on a new machine

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I understand what dotfiles are and why they matter
- [ ] I can check chezmoi status and apply changes
- [ ] I can customize my starship prompt
- [ ] I can modify my tmux configuration
- [ ] I can add new files to chezmoi management
- [ ] I understand machine-specific configs

**Total: ___ / 30**

---

## Next

Lesson 7: Cheat System & Self-Documentation
