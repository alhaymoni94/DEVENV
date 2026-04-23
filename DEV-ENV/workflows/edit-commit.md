# Edit → Commit Workflow

```
┌──────────────────────────────────────────────────────────────┐
│  ✏️  EDIT → COMMIT → PUSH                                    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   ┌─────────┐      ┌─────────┐      ┌─────────┐             │
│   │  BROWSE │ ────▶│  EDIT   │ ────▶│  COMMIT │             │
│   │         │      │         │      │         │             │
│   │  y      │      │  e file │      │  lg     │             │
│   │  ↑↓ nav │      │  edit   │      │  Space  │             │
│   │  → open │      │  Ctrl+S │      │  c      │             │
│   │         │      │  Ctrl+Q │      │  P      │             │
│   └─────────┘      └─────────┘      └─────────┘             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Step 1: Browse
```bash
y              # open yazi file manager
↑↓ navigate    # find your file
Enter          # open in micro (or q to cd, then e file)
```

## Step 2: Edit
```
Ctrl+S         # save
Ctrl+/         # toggle comment
Ctrl+D         # duplicate line
Ctrl+F         # find
Ctrl+H         # find and replace
Ctrl+Q         # quit back to shell
```

## Step 3: Commit
```bash
lg             # open lazygit

# Stage:
Space          # toggle stage on file
a              # stage all files

# Commit:
c              # write commit message
Enter          # confirm

# Push:
P              # push to remote

# Quit:
q              # back to shell
```

## Quick Alternative (no TUI)
```bash
git add -A
git commit -m "message"
git push
```
