# Lesson 18: Workspace Automation — Student Lab

## Duration: 2 hours

---

## Exercise 1: Environment Diagnostics (25 min)

**Task:** Create a script that checks your entire environment.

```bash
e ~/bin/env-doctor.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

echo "╔══════════════════════════════════════╗"
echo "║   Environment Doctor                  ║"
echo "╚══════════════════════════════════════╝"
echo ""

check() {
    local name="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        echo "✓ $name"
    else
        echo "✗ $name"
    fi
}

echo "── Tools ──"
check "git" "command -v git"
check "docker" "command -v docker"
check "python" "command -v python"
check "node" "command -v node"
check "micro" "command -v micro"
check "tmux" "command -v tmux"
check "lazygit" "command -v lazygit"
check "btop" "command -v btop"

echo ""
echo "── System ──"
echo "OS: $(uname -s) $(uname -m)"
echo "Shell: $SHELL"
echo "Disk: $(df -h / | awk 'NR==2{print $5 " used"}')"
echo "RAM: $(free -h | awk '/Mem:/{print $3 "/" $2}')"

echo ""
echo "── Git ──"
echo "User: $(git config user.name 2>/dev/null || echo 'not set')"
echo "Email: $(git config user.email 2>/dev/null || echo 'not set')"
```

```bash
chmod +x ~/bin/env-doctor.sh
env-doctor.sh
```

---

## Exercise 2: Daily Setup Script (25 min)

**Task:** Create a script that sets up your daily work environment.

```bash
e ~/bin/daily-setup.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Daily Setup"
echo ""

# Update package lists
echo "📦 Checking for updates..."
# brew update 2>/dev/null || true

# Check disk space
disk_usage=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
if [ "$disk_usage" -gt 90 ]; then
    echo "⚠️  Disk usage is at ${disk_usage}%"
    docker system prune -f 2>/dev/null || true
fi

# Start tmux session
session="daily-$(date +%Y%m%d)"
if ! tmux has-session -t "$session" 2>/dev/null; then
    tmux new -d -s "$session"
    echo "📋 Created tmux session: $session"
fi

# Check for running containers
containers=$(docker ps -q 2>/dev/null | wc -l)
echo "🐳 $containers containers running"

# Show today's calendar
echo ""
echo "📅 $(date '+%A, %B %d, %Y')"

echo ""
echo "✅ Setup complete!"
```

```bash
chmod +x ~/bin/daily-setup.sh
daily-setup.sh
```

---

## Exercise 3: Backup Automation (25 min)

**Task:** Create an automated backup system.

```bash
e ~/bin/auto-backup.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="$HOME/backups/$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

echo "📦 Backup started: $BACKUP_DIR"

# Backup dotfiles
echo "  Backing up dotfiles..."
chezmoi archive > "$BACKUP_DIR/dotfiles.tar.gz" 2>/dev/null || \
    tar -czf "$BACKUP_DIR/dotfiles.tar.gz" -C ~ .zshrc .tmux.conf .config 2>/dev/null || true

# Backup projects
echo "  Backing up projects..."
if [ -d "$HOME/projects" ]; then
    tar -czf "$BACKUP_DIR/projects.tar.gz" -C "$HOME" projects
fi

# Backup data
echo "  Backing up data..."
if [ -d "$HOME/data" ]; then
    tar -czf "$BACKUP_DIR/data.tar.gz" -C "$HOME" data
fi

# Show backup size
total_size=$(du -sh "$BACKUP_DIR" | awk '{print $1}')
echo ""
echo "✅ Backup complete: $total_size"

# Clean old backups (keep last 7 days)
find "$HOME/backups" -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \; 2>/dev/null || true
echo "🧹 Cleaned backups older than 7 days"
```

```bash
chmod +x ~/bin/auto-backup.sh
auto-backup.sh
```

---

## Exercise 4: Schedule Everything (20 min)

**Task:** Set up cron jobs for automation.

```bash
crontab -e
```

Add:
```
# Daily backup at 3am
0 3 * * * /home/YOUR_USER/bin/auto-backup.sh >> /home/YOUR_USER/backups/cron.log 2>&1

# Daily setup at 9am (weekdays)
0 9 * * 1-5 /home/YOUR_USER/bin/daily-setup.sh >> /home/YOUR_USER/.cache/daily-setup.log 2>&1

# Weekly environment check
0 9 * * 1 /home/YOUR_USER/bin/env-doctor.sh >> /home/YOUR_USER/.cache/env-doctor.log 2>&1
```

```bash
# Verify
crontab -l
```

---

## Exercise 5: Custom Workflow Script (25 min)

**Task:** Create a script that automates your most common workflow.

```bash
e ~/bin/start-project.sh
```

Ask AI to help:
```bash
ai "write a bash script called start-project.sh that:
1. Takes a project name as argument
2. Creates a directory structure (src, tests, docs)
3. Initializes git
4. Creates a README
5. Creates a .gitignore for Python
6. Opens the project in tmux with a 3-pane layout
7. Opens micro in the editor pane"
```

```bash
chmod +x ~/bin/start-project.sh
start-project.sh my-new-project
```

---

## Bonus Challenges

1. **Create a dashboard script** that shows system stats, running services, and recent git activity
2. **Build a sync script** that syncs your dotfiles to a remote repository
3. **Create a cleanup script** that removes old Docker images, temp files, and logs
4. **Write a notification system** that alerts you when long-running commands complete

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can write diagnostic scripts
- [ ] I can automate daily setup tasks
- [ ] I can create backup automation
- [ ] I can schedule scripts with cron
- [ ] I can build custom workflow scripts

**Total: ___ / 25**

---

## Phase 6 Complete! 🎉

Your entire workspace is now automated.

**Next:** Graduation Project
