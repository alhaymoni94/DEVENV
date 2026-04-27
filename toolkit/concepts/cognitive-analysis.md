# Cognitive Load Analysis — AUT Terminal Stack

> This stack is designed for extreme accessibility. Below is a thorough analysis of visual feedback, mental model clarity, and cognitive burden — with specific recommendations.

---

## 1. Visual Feedback

### What's Working

**Starship Prompt** — Immediate context at every keystroke:
```
~/project/src  main ⇡2 !3  via  v3.11  took 5s
❯
```
- Git branch + status (ahead, modified, untracked) — no need to run `git status`
- Language/runtime version — auto-detected, no thinking
- Command duration — only shows when >2s, signals "that was slow"
- Color-coded: blue=dir, purple=branch, yellow=runtime, green=symbol

**tmux Status Bar** — System health always visible:
```
[session] [host]  CPU: 23% │ RAM: 4200M/16000M │ Disk: 45G/100G (45%)  PREFIX  Tue 21 Apr  10:45
```
- PREFIX indicator lights up purple — immediate feedback that tmux is listening
- CPU/RAM/Disk — no need to run `top` or `df`
- Session name — always know which workspace you're in

**Tokyo Night Theme Consistency** — All TUIs share the same palette:
- Background: `#1a1b26` (dark navy)
- Foreground: `#c0caf5` (soft white)
- Accent: `#7aa2f7` (blue)
- Success: `#9ece6a` (green)
- Warning: `#e0af68` (yellow)
- Error: `#f7768e` (red)

This means the user's eyes don't need to recalibrate when switching tools.

**Doctor.sh Color Code** — Universal pattern:
- `✓` green = healthy
- `⚠` yellow = needs attention
- `✗` red = broken

This pattern appears in setup.sh too — consistent mental model for "health."

### Gaps

| Gap | Impact | Recommendation |
|-----|--------|----------------|
| No visual cue that cheat system exists | Users don't know help is available | Add a startup banner or prompt segment |
| No distinction between tools that are running vs available | Hard to know what's active in tmux | Use tmux window names consistently |
| No progress feedback during long operations | User doesn't know if something is working | Add spinner or ETA for known-slow commands |

---

## 2. Mental Map

### What's Clear

**Layer Model** — The stack has a clean hierarchy:
```
Ghostty (draws pixels)
└── tmux (manages sessions)
    └── zsh (parses commands)
        ├── micro (edit files)
        ├── yazi (browse files)
        ├── lazygit (version control)
        ├── ai (ask questions)
        └── ... (everything else)
```

Each layer has one job. Users understand: "tmux keeps things alive, zsh runs commands, tools do specific tasks."

**Tool Relationships** — Documented in workflows/:
- `y` → browse → `e` → edit → `lg` → commit → `P` → push
- `tmux new -s` → `Prefix |` → edit + terminal → `Prefix d` → `tmux attach`

**Recovery Paths** — Every tool has an undo guide:
- "I committed to wrong branch" → specific commands
- "I killed wrong pane" → how to recover
- "I deleted wrong file" → trash location

This reduces the fear of mistakes — a major cognitive blocker.

### Gaps

| Gap | Impact | Recommendation |
|-----|--------|----------------|
| No "which tool for which job" decision tree | Users don't know when to use what | Add `concepts/tool-decisions.md` |
| No first-run onboarding flow | Everything available at once is overwhelming | Add `cheat --start` guided tour |
| No visual map of tool connections | Hard to see the big picture | Add an ASCII diagram to stack-overview.md |
| chezmoi is abstract | "Why do I need a dotfiles manager?" | Add a 2-line explanation in concepts/ |

---

## 3. Cognitive Load

### What's Low (Good)

**CUA Keybinding Consistency** — One mental model across all tools:
- `Ctrl+C/V/X` = copy/paste/cut (shell, micro, yazi)
- `Ctrl+S` = save (micro)
- `Ctrl+Q` = quit (micro, yazi)
- `Ctrl+Z/Y` = undo/redo (micro, shell)
- `Ctrl+A/E` = start/end of line (shell, micro)

No vim-mode switching. No "am I in insert or normal mode?" This eliminates the single biggest cognitive burden in terminal workflows.

**Aliases Reduce Keystrokes** — Common actions are 1-3 characters:
```
e      → micro (editor)
lg     → lazygit (git)
lzd    → lazydocker (docker)
ghd    → gh dash (GitHub)
top    → btop (monitor)
y      → yazi (files)
ai     → opencode wrapper (AI)
qr     → cheat --quick (quick ref)
tip    → cheat --daily (random tip)
```

**Cheat System as External Memory** — Users don't need to memorize:
- `cheat <tool>` → full guide
- `qr <tool>` → one-pager
- `tip` → random tip
- `cheat --quiz <tool>` → self-test
- `cheat --undo <tool>` → recovery guide

This is the key insight: **don't reduce cognitive load by teaching less — reduce it by making lookup effortless.**

**Undo Guides Reduce Fear** — Knowing there's a recovery path for every mistake means users experiment more freely.

### What's High (Needs Attention)

**32 Tools Is a Lot** — Even with aliases, the sheer number creates decision fatigue:
- "Should I use micro or ai to edit this?"
- "Do I need lazygit or just `git status`?"
- "When do I use euporie vs visidata?"

**9 Aliases to Learn** — That's 9 new muscle memories. Most are intuitive (e=edit, y=yazi), but `qr` and `ghd` are opaque.

**No Progressive Onboarding** — Everything is available from day one. A new user sees 32 tools and doesn't know where to start.

**tmux Prefix + Alt Keys** — `Ctrl+a` prefix conflicts with shell's `Ctrl+a` (go to start of line). Users must learn: "in tmux, Ctrl+a means something different."

---

## 4. Recommendations

### Immediate (High Impact, Low Effort)

1. **Add `cheat --start` first-run guide**
   - Shows the 5 most important tools first
   - One interactive walkthrough: "Open yazi, pick a file, edit it, commit it"
   - Then: "Now try tmux"

2. **Add `concepts/tool-decisions.md`**
   - "Use X when you need Y" format
   - Example: "Use yazi when browsing directories. Use `ls` when you just need a quick listing."

3. **Add prompt hint for cheat system**
   - Add to starship: a small `[?]` segment that appears on first login
   - Or add to `.zshrc`: `echo "Type 'cheat' for help, 'tip' for a random tip"` (once per day)

4. **Group aliases by frequency**
   - Daily: `e`, `lg`, `y`, `ai`
   - Weekly: `lzd`, `ghd`, `top`
   - Occasionally: `qr`, `tip`
   - Document this in quick-ref/shell.md

### Medium Term

5. **Add tmux session template**
   - `tmux new-session -s dev` auto-creates: editor pane, terminal pane, git pane
   - One command to set up the standard layout

6. **Add visual tool map**
   - ASCII diagram in `concepts/stack-overview.md` showing how tools connect
   - Color-coded by category (editor, git, system, AI, data)

7. **Create `setup.sh --interactive` mode**
   - Asks: "What do you want to do?" → "Code" / "Data" / "DevOps" / "Everything"
   - Installs only relevant tools for that path

### Long Term

8. **Add a daily warmup**
   - `cheat --warmup` → 3 quick exercises (30 seconds each)
   - Keeps muscle memory sharp between sessions

9. **Track usage patterns**
   - Log which tools are used most (anonymized, local only)
   - Use data to reorder cheatsheets and aliases by actual usage

10. **Add a "tool of the week" rotation**
    - Highlight one underused tool each week
    - `tip` command could include: "Have you tried `visidata` this week?"

---

## 5. Summary Scorecard

| Dimension | Score | Notes |
|-----------|-------|-------|
| Visual Feedback | 8/10 | Strong theme consistency, clear health indicators. Missing: cheat system visibility |
| Mental Map Clarity | 7/10 | Clean layer model, good docs. Missing: decision tree, first-run flow |
| Keybinding Consistency | 9/10 | CUA throughout. Only gap: tmux prefix vs shell Ctrl+a |
| Alias Intuitiveness | 7/10 | Most are obvious. `qr` and `ghd` are opaque |
| Recovery Safety | 9/10 | Undo guides for every tool. Excellent |
| Progressive Onboarding | 4/10 | Everything at once. Needs guided first experience |
| External Memory (cheat) | 9/10 | Comprehensive, multi-mode lookup. Just needs discoverability |
| **Overall** | **7.6/10** | Strong foundation. Main gap: first-run experience |

---

## 6. The Core Insight

This stack's greatest strength is **not** the tools — it's the **safety net**.

The cheat system, undo guides, and consistent keybindings mean users can:
1. Try anything (undo guides reduce fear)
2. Look up anything (cheat system reduces memorization)
3. Do anything consistently (CUA bindings reduce context switching)

The cognitive load isn't in *using* the tools — it's in *knowing which tool exists*. Intelli-shell prepopulation solves exactly that.
