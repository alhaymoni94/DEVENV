# Lesson 2: Unix Fundamentals — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Navigate the file system efficiently without a mouse
- Understand file permissions and ownership
- Use core Unix commands: `ls`, `cd`, `grep`, `awk`, `sed`, `find`
- Use `micro` for editing and `yazi` for file management
- Use `fzf` for fuzzy finding

## Prerequisites

- Lesson 1 completed (AI agents)
- `setup.sh` completed

## Lesson Flow

### Part 1: File System Navigation (25 min)

**Cover:**
- Absolute vs relative paths
- `cd`, `pwd`, `ls` variations
- `cd -` (go back), `cd ..` (go up), `~` (home)
- Auto-completion with `Tab`

**Demo:**
```bash
pwd
ls -lah
cd /etc
cd -
cd ~
cd Documents/AUT-Linux-Camp
```

**Have students practice:**
1. Navigate from home to `/etc` and back
2. Use `Tab` completion for long paths
3. Create nested directories: `mkdir -p a/b/c/d`

### Part 2: File Operations (25 min)

**Cover:**
- `touch`, `cp`, `mv`, `rm`, `mkdir`
- Wildcards: `*`, `?`, `[abc]`
- `yazi` as a visual file manager

**Demo:**
```bash
touch test.txt
cp test.txt test2.txt
mv test2.txt renamed.txt
rm renamed.txt
mkdir -p project/{src,tests,docs}
```

**Have students practice:**
1. Create a project structure with one command
2. Copy, rename, and delete files
3. Open yazi with `y` and navigate

### Part 3: File Permissions (20 min)

**Cover:**
- Read (r), Write (w), Execute (x)
- Owner, Group, Other
- Numeric: 755, 644, 600
- `chmod`, `chown`

**Demo:**
```bash
ls -l
chmod +x script.sh
chmod 755 script.sh
chmod 644 config.txt
```

**Have students practice:**
1. Create a script and make it executable
2. Check permissions with `ls -l`
3. Change permissions and observe the difference

### Part 4: Text Processing (30 min)

**Cover:**
- `grep` — search text
- `awk` — process columns
- `sed` — stream editor
- Pipes: `|`

**Demo:**
```bash
# Search for "export" in zshrc
grep "export" ~/.zshrc

# Get column 1 from ls
ls -l | awk '{print $1, $9}'

# Replace "old" with "new"
echo "hello old world" | sed 's/old/new/'
```

**Have students practice:**
1. Find all aliases in their zshrc
2. Extract file names from `ls -l`
3. Use sed to modify text

### Part 5: Finding Files (15 min)

**Cover:**
- `find` — search by name, type, size, date
- `fzf` — fuzzy finder

**Demo:**
```bash
find . -name "*.py"
find . -type d -name "src"
find . -size +1M
# Fuzzy find
Ctrl+R  # history search
```

**Have students practice:**
1. Find all markdown files in the toolkit
2. Find all directories named "scripts"
3. Use Ctrl+R to search command history

### Part 6: Shell Scripting Basics (15 min)

**Cover:**
- Shebang: `#!/usr/bin/env bash`
- Variables: `name="value"`
- Conditionals: `if [ condition ]; then`
- Loops: `for`, `while`

**Demo:**
```bash
#!/usr/bin/env bash
name="World"
echo "Hello, $name!"

for file in *.txt; do
  echo "Found: $file"
done
```

**Have students practice:**
1. Write a script that lists all `.md` files
2. Write a script that counts files in a directory

## Common Issues

| Issue | Solution |
|-------|----------|
| Permission denied | Check with `ls -l`, use `chmod` |
| Command not found | Check PATH, use `which` |
| Can't find a file | Use `find` or `yazi` |
| Tab completion not working | Check zsh-autosuggestions |

## Assessment

- Students complete the lab exercises
- Students create a working bash script
- Students demonstrate file navigation without a mouse

## Next Lesson

Lesson 3: Tmux Mastery
