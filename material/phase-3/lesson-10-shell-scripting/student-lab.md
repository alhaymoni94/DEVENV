# Lesson 10: Shell Scripting for Automation — Student Lab

## Duration: 2 hours

---

## Exercise 1: Your First Script (15 min)

**Task:** Write a basic script with arguments.

```bash
e ~/bin/hello.sh
```

Add:
```bash
#!/usr/bin/env bash

name="${1:-World}"
echo "Hello, $name!"
echo "You passed $# arguments"
echo "All arguments: $@"
```

```bash
chmod +x ~/bin/hello.sh
hello.sh Alice
hello.sh Alice Bob Charlie
```

---

## Exercise 2: File Organizer Script (25 min)

**Task:** Write a script that organizes files by extension.

```bash
e ~/bin/organize.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

target_dir="${1:-.}"

echo "Organizing files in: $target_dir"

for file in "$target_dir"/*; do
    [ -f "$file" ] || continue
    
    ext="${file##*.}"
    ext_dir="$target_dir/$ext"
    
    mkdir -p "$ext_dir"
    mv "$file" "$ext_dir/"
    echo "Moved: $file → $ext_dir/"
done

echo "Done!"
```

```bash
chmod +x ~/bin/organize.sh

# Create test files
mkdir -p ~/test-organize
cd ~/test-organize
touch a.txt b.txt c.pdf d.jpg e.txt f.pdf
organize.sh .
ls -R
```

---

## Exercise 3: Backup Script (25 min)

**Task:** Write a script that backs up a directory.

```bash
e ~/bin/backup.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

source_dir="${1:?Usage: backup.sh <directory>}"
backup_dir="${2:-$HOME/backups}"
timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="$(basename "$source_dir")_$timestamp.tar.gz"

# Validate source
if [ ! -d "$source_dir" ]; then
    echo "Error: $source_dir does not exist"
    exit 1
fi

# Create backup directory
mkdir -p "$backup_dir"

# Create backup
echo "Backing up $source_dir to $backup_dir/$backup_name"
tar -czf "$backup_dir/$backup_name" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

echo "Backup complete: $backup_dir/$backup_name"
echo "Size: $(du -h "$backup_dir/$backup_name" | awk '{print $1}')"
```

```bash
chmod +x ~/bin/backup.sh
backup.sh ~/projects
ls ~/backups/
```

---

## Exercise 4: Log Analyzer Script (25 min)

**Task:** Write a script that analyzes log files.

```bash
e ~/bin/log-analyzer.sh
```

Add:
```bash
#!/usr/bin/env bash
set -euo pipefail

log_file="${1:?Usage: log-analyzer.sh <log-file>}"

if [ ! -f "$log_file" ]; then
    echo "Error: $log_file not found"
    exit 1
fi

echo "=== Log Analysis: $log_file ==="
echo ""

echo "Total lines: $(wc -l < "$log_file")"
echo "Error count: $(grep -ci "error" "$log_file" || echo 0)"
echo "Warning count: $(grep -ci "warning" "$log_file" || echo 0)"
echo ""

echo "Top 5 errors:"
grep -i "error" "$log_file" | sort | uniq -c | sort -rn | head -5
echo ""

echo "Errors by hour:"
grep -i "error" "$log_file" | awk -F'[: ]' '{print $2":00"}' | sort | uniq -c | sort -rn
```

```bash
chmod +x ~/bin/log-analyzer.sh

# Create a test log
e ~/test.log
```

Add sample log lines:
```
2024-01-15 10:00:00 INFO Server started
2024-01-15 10:05:00 ERROR Connection failed
2024-01-15 10:10:00 WARNING Low memory
2024-01-15 11:00:00 ERROR Timeout
2024-01-15 11:05:00 ERROR Connection failed
2024-01-15 12:00:00 INFO Request processed
```

```bash
log-analyzer.sh ~/test.log
```

---

## Exercise 5: Schedule with Cron (20 min)

**Task:** Schedule a script to run automatically.

```bash
# Open crontab
crontab -e

# Add a line to run backup daily at 2am:
0 2 * * * /home/YOUR_USER/bin/backup.sh /home/YOUR_USER/projects >> /home/YOUR_USER/backups/cron.log 2>&1

# List cron jobs
crontab -l
```

**Common patterns:**
```
* * * * *  → every minute
0 * * * *  → every hour
0 2 * * *  → daily at 2am
0 2 * * 1  → Monday at 2am
0 2 1 * *  → 1st of month at 2am
```

---

## Bonus Challenges

1. **AI-assisted scripting:** Ask AI to write a script, then improve it
2. **Add logging** to all your scripts with timestamps
3. **Create a script dashboard** that runs all your scripts and shows status
4. **Use `trap`** to clean up temp files on script exit

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can write scripts with arguments and variables
- [ ] I can use conditionals and loops
- [ ] I can write functions with local variables
- [ ] I can handle errors with set -euo pipefail
- [ ] I can schedule scripts with cron

**Total: ___ / 25**

---

## Phase 3 Complete! 🎉

You can now:
- Analyze data in the terminal with visidata and jq
- Use AI to clean, transform, and analyze data
- Write automation scripts and schedule them

**Next:** Phase 4 — Containerization & AI
