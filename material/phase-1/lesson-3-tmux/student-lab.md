# Lesson 3: Tmux Mastery — Student Lab

## Duration: 1.5 hours

---

## Exercise 1: Your First Session (10 min)

**Task:** Create, detach, and reattach to a tmux session.

```bash
# Create a new session named "practice"
tmux new -s practice

# You're now inside tmux. Notice the green bar at the bottom.

# Detach from the session (it keeps running!)
# Press: Ctrl+B, then release and press D

# You're back in your normal shell. Verify the session is still running:
tmux ls

# Reattach to the session
tmux attach -t practice

# Detach again
# Ctrl+B, D
```

**Check:** Can you see the session in `tmux ls` even after detaching?

---

## Exercise 2: Multiple Sessions (10 min)

**Task:** Create and manage multiple sessions.

```bash
# Create 3 sessions
tmux new -s work -d
tmux new -s play -d
tmux new -s learn -d

# List all sessions
tmux ls

# Attach to one
tmux attach -t work

# Switch to another (from inside tmux)
# Or detach and attach to another:
# Ctrl+B, D
tmux attach -t play
```

**Challenge:** Kill the "play" session:
```bash
tmux kill-session -t play
tmux ls  # verify it's gone
```

---

## Exercise 3: Windows (15 min)

**Task:** Use windows within a session.

```bash
# Start a fresh session
tmux new -s windows-practice
```

Inside tmux:

```
# Create 3 windows:
Ctrl+B, C    → window 0
Ctrl+B, C    → window 1
Ctrl+B, C    → window 2

# Switch between them:
Ctrl+B, 0    → go to window 0
Ctrl+B, 1    → go to window 1
Ctrl+B, 2    → go to window 2

# Rename windows:
Ctrl+B, ,    → rename to "editor"
Ctrl+B, 1    → go to window 1
Ctrl+B, ,    → rename to "terminal"

# Kill a window:
Ctrl+B, &    → confirm with y
```

**Check:** The status bar at the bottom shows all windows. Can you see the names?

---

## Exercise 4: Panes (25 min)

**Task:** Split a window into multiple panes.

```bash
# Start fresh
tmux new -s panes-practice
```

Inside tmux:

```
# Split vertically (left/right)
Ctrl+B, %

# Split horizontally (top/bottom)
Ctrl+B, "

# You should now have 3 panes. Navigate between them:
Ctrl+B, ↑    → top pane
Ctrl+B, ↓    → bottom pane
Ctrl+B, ←    → left pane
Ctrl+B, →    → right pane

# Zoom a pane (makes it full screen temporarily)
Ctrl+B, Z    → zoom
Ctrl+B, Z    → unzoom

# Kill a pane
Ctrl+B, X    → confirm with y

# Cycle layouts
Ctrl+B, Space → try it a few times
```

**Challenge:** Create this layout:
```
┌──────────────┬──────────────┐
│              │              │
│   Pane 1     │   Pane 2     │
│              │              │
├──────────────┤              │
│              │              │
│   Pane 3     │              │
│              │              │
└──────────────┴──────────────┘
```

---

## Exercise 5: Copy Mode (15 min)

**Task:** Scroll back and copy text from the terminal.

```bash
# Run a command with lots of output
ls -l /usr/bin

# Enter copy mode
Ctrl+B, [

# Scroll up with:
# - Arrow keys
# - Or vim keys: k (up), j (down)
# - Page Up / Page Down

# Start selection
Space

# Move to select text
# Press Enter to copy

# Paste the copied text
Ctrl+B, ]
```

**Tip:** If your tmux is configured with vim keys:
- `h/j/k/l` — left/down/up/right
- `w/b` — word forward/back
- `0/$` — start/end of line

---

## Exercise 6: Dev Workflow (20 min)

**Task:** Set up a real development layout.

```bash
# Create a project session
tmux new -s dev-project
```

Inside tmux:

```
# Split vertically
Ctrl+B, %

# In the left pane, open a file
e ~/.zshrc

# In the right pane, run a command
grep "alias" ~/.zshrc

# Split the right pane horizontally
Ctrl+B, "

# In the bottom-right pane, open lazygit
lg

# Now you have:
# Left: editor
# Top-right: terminal
# Bottom-right: git TUI

# Navigate between panes with Ctrl+B + arrows
# Zoom the editor pane with Ctrl+B, Z when you need more space
```

**Pro tip:** This is your daily driving layout. Memorize it.

---

## Exercise 7: Session Recovery (10 min)

**Task:** Practice recovering from common issues.

```bash
# "I closed my terminal! Is my session gone?"
# No! It's still running:
tmux ls

# Reattach:
tmux attach -t dev-project

# "I forgot the session name!"
tmux ls

# "I want to attach to the last session I used"
tmux attach

# "I want to kill all sessions and start fresh"
tmux kill-server
```

---

## Bonus Challenges

1. **Nested splits:** Create a 4-pane layout in a single window
2. **Session naming:** Create sessions for each project you're working on
3. **Window management:** Create a session with 5 named windows
4. **Pane sync:** Run the same command in multiple panes simultaneously (research `:setw synchronize-panes`)

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can create, list, and kill sessions
- [ ] I can detach and reattach to sessions
- [ ] I can create and switch between windows
- [ ] I can split panes vertically and horizontally
- [ ] I can navigate between panes
- [ ] I can zoom and unzoom panes
- [ ] I can use copy mode to scroll and copy
- [ ] I can set up a dev workflow layout

**Total: ___ / 40**

---

## Next

Lesson 4: Git Workflow
