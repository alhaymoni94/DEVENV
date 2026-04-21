# Lesson 2: Unix Fundamentals — Student Lab

## Duration: 2 hours

---

## Exercise 1: Navigation Sprint (15 min)

**Task:** Navigate the file system using only the keyboard.

```bash
# Start at home
cd ~

# Go to the toolkit
cd Documents/AUT-Linux-Camp/toolkit

# Go all the way to /etc
cd /etc

# Go back to where you were before
cd -

# Go up one level
cd ..

# Go to home
cd ~
```

**Challenge:** Navigate to these locations as fast as possible (use `Tab` completion):
1. `/usr/bin`
2. `~/.config`
3. `/var/log`
4. Your project directory

**Pro tip:** Type the first few letters and press `Tab` to auto-complete.

---

## Exercise 2: Build a Project Structure (20 min)

**Task:** Create a complete project structure with minimal commands.

```bash
# Create a new project
mkdir -p ~/projects/myapp/{src,tests,docs,scripts,config}

# Navigate to it
cd ~/projects/myapp

# Create initial files
touch src/main.py src/utils.py
touch tests/test_main.py tests/test_utils.py
touch docs/README.md
touch scripts/deploy.sh
touch config/settings.yaml

# Verify structure
ls -R
```

**Challenge:** Do this in fewer commands. Can you do it in 3 lines?

---

## Exercise 3: File Operations (20 min)

**Task:** Practice copying, moving, and deleting files.

```bash
# Create test files
echo "hello" > file1.txt
echo "world" > file2.txt
echo "foo" > file3.txt

# Copy a file
cp file1.txt file1-backup.txt

# Rename a file
mv file2.txt renamed.txt

# Move to a subdirectory
mkdir backup
mv file1-backup.txt backup/

# Delete a file
rm file3.txt

# Delete a directory and its contents
rm -rf backup/
```

**Challenge:** Use `yazi` to do the same operations visually:
```bash
y
# Navigate, copy, move, delete with keyboard
```

---

## Exercise 4: Permissions Lab (20 min)

**Task:** Understand and manipulate file permissions.

```bash
# Create a script
e greet.sh
```

Add this content:
```bash
#!/usr/bin/env bash
echo "Hello from a script!"
```

```bash
# Check current permissions
ls -l greet.sh

# Try to run it (will fail)
./greet.sh

# Make it executable
chmod +x greet.sh

# Try again (should work)
./greet.sh

# Check permissions again
ls -l greet.sh
```

**Understand the output:**
```
-rwxr-xr-x  1 user  group  42  Apr 21 10:00  greet.sh
 ^^^ ^^^ ^^^
 |   |   |
 |   |   └── Other: read + execute
 |   └────── Group: read + execute
 └────────── Owner: read + write + execute
```

**Challenge:**
1. Make a file readable only by you: `chmod 600 secret.txt`
2. Make a file readable by everyone but writable only by you: `chmod 644 public.txt`
3. Make a directory accessible only by you: `chmod 700 private-dir/`

---

## Exercise 5: Text Processing (30 min)

### Part A: grep

```bash
# Find all aliases in your zshrc
grep "alias" ~/.zshrc

# Find lines containing "export"
grep "export" ~/.zshrc

# Case-insensitive search
grep -i "PATH" ~/.zshrc

# Show line numbers
grep -n "alias" ~/.zshrc

# Count matches
grep -c "alias" ~/.zshrc
```

### Part B: awk

```bash
# List files with permissions and names
ls -l | awk '{print $1, $9}'

# Get just the file sizes
ls -l | awk '{print $5, $9}'

# Filter: only show files (not directories)
ls -l | awk '/^-/ {print $9}'
```

### Part C: sed

```bash
# Replace text
echo "The quick brown fox" | sed 's/brown/red/'

# Replace all occurrences
echo "foo bar foo baz" | sed 's/foo/qux/g'

# Delete lines containing "comment"
grep -n "" ~/.zshrc | sed '/^#/d'
```

### Part D: Pipes

```bash
# Count how many aliases you have
grep "alias" ~/.zshrc | wc -l

# Find all Python files, sort them
find . -name "*.py" | sort

# Get the 5 largest files in current directory
ls -lS | head -6 | tail -5
```

**Challenge:** Write a one-liner that finds all lines in `~/.zshrc` containing "export" and replaces "PATH" with "MYPATH":
```bash
grep "export" ~/.zshrc | sed 's/PATH/MYPATH/g'
```

---

## Exercise 6: Finding Files (15 min)

```bash
# Find all markdown files in toolkit
find ~/Documents/AUT-Linux-Camp/toolkit -name "*.md"

# Find all directories named "scripts"
find ~/Documents/AUT-Linux-Camp -type d -name "scripts"

# Find files larger than 1MB
find ~ -size +1M 2>/dev/null | head -10

# Find files modified in the last 7 days
find ~ -mtime -7 -name "*.py" 2>/dev/null | head -10
```

**Fuzzy find with fzf:**
```bash
# Search command history
Ctrl+R

# Fuzzy find files
find ~ -type f 2>/dev/null | fzf
```

---

## Exercise 7: Write Your First Script (20 min)

**Task:** Create a script that summarizes a directory.

```bash
e ~/bin/dir-summary.sh
```

Add this content:
```bash
#!/usr/bin/env bash

dir="${1:-.}"

echo "=== Directory Summary: $dir ==="
echo ""
echo "Total files: $(find "$dir" -type f 2>/dev/null | wc -l)"
echo "Total directories: $(find "$dir" -type d 2>/dev/null | wc -l)"
echo "Total size: $(du -sh "$dir" 2>/dev/null | awk '{print $1}')"
echo ""
echo "Largest files:"
find "$dir" -type f -exec ls -l {} \; 2>/dev/null | sort -k5 -rn | head -5 | awk '{print "  " $5 "  " $9}'
```

```bash
chmod +x ~/bin/dir-summary.sh
dir-summary.sh ~/Documents/AUT-Linux-Camp/toolkit
```

**Challenge:** Modify the script to also show the 5 most recently modified files.

---

## Bonus Challenges

1. **Find and count:** How many `.md` files are in the entire toolkit?
2. **Permissions audit:** List all executable files in your home directory
3. **Log analysis:** `cat /var/log/syslog | grep "error" | wc -l` (may need sudo)
4. **Backup script:** Write a script that backs up a directory to a timestamped folder

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can navigate the file system without a mouse
- [ ] I understand file permissions (rwx, 755, 644)
- [ ] I can use grep to search text
- [ ] I can use awk to process columns
- [ ] I can use sed to modify text
- [ ] I can use find to locate files
- [ ] I can write a basic bash script
- [ ] I can use yazi for file management
- [ ] I can use fzf for fuzzy finding

**Total: ___ / 45**

---

## Next

Lesson 3: Tmux Mastery
