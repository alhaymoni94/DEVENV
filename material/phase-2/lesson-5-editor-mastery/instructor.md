# Lesson 5: Editor Mastery — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Navigate files efficiently in micro
- Use all essential keyboard shortcuts
- Work with multiple files and splits
- Use find, replace, and undo effectively
- Configure micro for their workflow

## Lesson Flow

### Part 1: Micro Basics (25 min)

**Cover:**
- Opening files: `e file`, `e .` (directory browser)
- Navigation: arrow keys, Ctrl+arrow for word jumps
- Selection: Shift+arrow, Ctrl+A (select all)
- Save/Quit: Ctrl+S, Ctrl+Q

**Demo:**
```bash
e ~/.zshrc
# Navigate with arrow keys
# Select text with Shift+arrow
# Copy with Ctrl+C, paste with Ctrl+V
# Save with Ctrl+S, quit with Ctrl+Q
```

**Have students practice:**
1. Open their zshrc, navigate to the aliases section
2. Select and copy an alias
3. Paste it at the bottom
4. Save and quit

### Part 2: Essential Shortcuts (25 min)

**Cover:**

| Shortcut | Action |
|----------|--------|
| Ctrl+C/V/X | Copy/Paste/Cut |
| Ctrl+Z/Y | Undo/Redo |
| Ctrl+F/H | Find/Replace |
| Ctrl+/ | Toggle comment |
| Ctrl+D | Duplicate line |
| Ctrl+K | Delete line |
| Ctrl+Left/Right | Jump by word |
| Ctrl+Home/End | Jump to file start/end |
| Alt+Click | Place cursor |

**Have students practice:**
1. Write a Python function, use Ctrl+/ to comment it out
2. Duplicate a line with Ctrl+D
3. Find and replace a variable name
4. Undo and redo changes

### Part 3: Multiple Files & Splits (25 min)

**Cover:**
- `e file1 file2` — open multiple files
- Ctrl+Tab — switch between files
- `e .` — directory browser
- File tree navigation

**Demo:**
```bash
e ~/.zshrc ~/.tmux.conf
# Ctrl+Tab to switch between files
```

**Have students practice:**
1. Open two config files side by side
2. Switch between them
3. Copy content from one to the other
4. Use the directory browser to find a file

### Part 4: Find & Replace (20 min)

**Cover:**
- Ctrl+F — find
- Ctrl+H — find and replace
- Regex mode
- Find in multiple files

**Have students practice:**
1. Find all occurrences of a word
2. Replace all instances
3. Use regex: find `\w+@\w+\.\w+` to match emails

### Part 5: Configuration (20 min)

**Cover:**
- `~/.config/micro/settings.json`
- Available settings: tabsize, colorscheme, autosave
- Plugins: `micro -plugin install`

**Have students practice:**
1. Open settings: `e ~/.config/micro/settings.json`
2. Change tab size to 2
3. Enable autosave
4. Try a different colorscheme

### Part 6: Real-World Editing (15 min)

**Exercise:** Edit a real project file.

```bash
# Create a Python project
mkdir -p ~/projects/editor-practice/src
e ~/projects/editor-practice/src/main.py
```

**Task:** Write a script that:
1. Reads a text file
2. Counts word frequency
3. Prints the top 10 words

**Requirements:**
- Use only keyboard shortcuts
- No mouse allowed
- Use find/replace to rename variables
- Use undo/redo to experiment

## Common Issues

| Issue | Solution |
|-------|----------|
| Can't save | Check file permissions |
| Ctrl+C not copying | That's the interrupt key in some terminals — use Ctrl+Shift+C |
| Colors look wrong | Try different colorscheme in settings |

## Assessment

- Students edit a file using only keyboard
- Students demonstrate copy/paste, find/replace, undo/redo
- Students configure micro preferences

## Next Lesson

Lesson 6: Dotfiles & Config Management
