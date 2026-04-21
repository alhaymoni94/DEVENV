# Lesson 5: Editor Mastery — Student Lab

## Duration: 2 hours

---

## Exercise 1: Open and Navigate (15 min)

**Task:** Open files and navigate efficiently.

```bash
# Open your zshrc
e ~/.zshrc
```

Practice:
1. Use arrow keys to move around
2. Use Ctrl+Left/Right to jump by word
3. Use Ctrl+Home to go to top, Ctrl+End to go to bottom
4. Find the aliases section

**Challenge:** How fast can you get from the top of the file to the `alias lg='lazygit'` line?

---

## Exercise 2: Copy, Paste, Cut (15 min)

**Task:** Practice clipboard operations.

```bash
e ~/.zshrc
```

1. Select the entire aliases section (Shift+arrow keys)
2. Copy it (Ctrl+C)
3. Go to the bottom of the file
4. Paste it (Ctrl+V)
5. Save (Ctrl+S) — but don't quit yet!
6. Undo the paste (Ctrl+Z)
7. Now quit without saving (Ctrl+Q, say "no" to save)

**Check:** Your zshrc should be unchanged.

---

## Exercise 3: Find and Replace (20 min)

**Task:** Use find and replace to modify a file.

```bash
# Create a test file
e ~/projects/replace-test.txt
```

Add this content:
```
The cat sat on the mat.
The cat looked at the hat.
The cat was fat.
```

1. Press Ctrl+F, type "cat", press Enter
2. Press Ctrl+H to open replace
3. Replace "cat" with "dog"
4. Replace all occurrences
5. Save the file

**Check:** The file should now say "The dog sat on the mat." etc.

**Challenge:** Use regex to capitalize the first letter of each sentence.

---

## Exercise 4: Multiple Files (20 min)

**Task:** Work with multiple files.

```bash
# Open two files at once
e ~/.zshrc ~/.tmux.conf
```

1. Switch between files with Ctrl+Tab
2. Copy the first 5 lines of zshrc
3. Switch to tmux.conf
4. Paste them at the bottom
5. Quit without saving

**Now try the directory browser:**
```bash
e ~/Documents/AUT-Linux-Camp/toolkit
```

Navigate the file tree with arrow keys and open files.

---

## Exercise 5: Undo and Redo (15 min)

**Task:** Practice undo/redo extensively.

```bash
e ~/projects/undo-practice.txt
```

1. Type a paragraph
2. Delete a sentence (Ctrl+K)
3. Undo (Ctrl+Z) — it's back!
4. Redo (Ctrl+Y) — it's gone again!
5. Make 5 changes, then undo all of them

**Challenge:** How many levels of undo does micro support? Test it.

---

## Exercise 6: Comment and Duplicate (15 min)

**Task:** Use Ctrl+/ and Ctrl+D.

```bash
e ~/projects/comment-test.py
```

Add:
```python
def hello():
    print("Hello")

def world():
    print("World")

def test():
    hello()
    world()
```

1. Select the `hello()` function
2. Press Ctrl+/ to comment it out
3. Press Ctrl+/ again to uncomment
4. Select the `world()` function
5. Press Ctrl+D to duplicate it
6. Save the file

---

## Exercise 7: Configure Micro (20 min)

**Task:** Customize your editor.

```bash
e ~/.config/micro/settings.json
```

Add or modify:
```json
{
    "tabsize": 4,
    "autosave": true,
    "colorcolumn": 80,
    "savecursor": true
}
```

**Try different colorschemes:**
```bash
# Available schemes are in ~/.config/micro/colorschemes/
ls ~/.config/micro/colorschemes/

# Change the colorscheme in settings.json
"colorscheme": "gruvbox"
```

**Restart micro** to see the changes.

---

## Exercise 8: Real-World Editing Challenge (20 min)

**Task:** Write a complete script using only keyboard.

```bash
e ~/projects/word-counter.py
```

Write a script that:
```python
#!/usr/bin/env python3
import sys
from collections import Counter

def count_words(filename):
    """Count word frequency in a file."""
    with open(filename) as f:
        text = f.read()
    words = text.lower().split()
    return Counter(words)

def main():
    if len(sys.argv) < 2:
        print("Usage: word-counter.py <file>")
        sys.exit(1)
    
    filename = sys.argv[1]
    counts = count_words(filename)
    
    print(f"Top 10 words in {filename}:")
    for word, count in counts.most_common(10):
        print(f"  {word}: {count}")

if __name__ == "__main__":
    main()
```

**Rules:**
- No mouse allowed
- Use Ctrl+F to find text
- Use Ctrl+H to rename variables
- Use Ctrl+/ to comment out sections
- Use Ctrl+D to duplicate lines
- Use Ctrl+Z/Y to experiment freely

**Test it:**
```bash
chmod +x ~/projects/word-counter.py
echo "the quick brown fox jumps over the lazy dog the the the" > test.txt
python ~/projects/word-counter.py test.txt
```

---

## Bonus Challenges

1. **Multi-cursor:** Place multiple cursors with Alt+Click and type simultaneously
2. **Macro:** Record a macro with Ctrl+Q, replay with Ctrl+Q
3. **Plugin:** Install a micro plugin: `micro -plugin install linter`
4. **External terminal:** Run a shell command from within micro: `Ctrl+E` then `!command`

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can navigate files efficiently with keyboard
- [ ] I can copy, paste, cut without mouse
- [ ] I can find and replace text
- [ ] I can work with multiple files
- [ ] I can use undo/redo confidently
- [ ] I can comment/uncomment code
- [ ] I can duplicate lines
- [ ] I can configure micro settings
- [ ] I can write a complete script without mouse

**Total: ___ / 45**

---

## Next

Lesson 6: Dotfiles & Config Management
