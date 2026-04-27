# gh-enhance

> GitHub CLI enhancement extension — prettier PR/issue listings with metadata.

## Installation

```bash
gh extension install dlvhdr/gh-enhance
```

## Usage

```bash
# Enhanced PR list with labels, reviewers, CI status
gh enhance prs

# Enhanced issue list
gh enhance issues

# Filter by author
gh enhance prs --author username

# Show only your PRs
gh enhance prs --author @me
```

---

## What It Adds

Standard `gh pr list` shows:
```
#123  Fix login bug
```

`gh enhance prs` shows:
```
#123  Fix login bug  [bug] [auth]  ✅ CI  👤 2 reviews  🟢 Ready
```

---

## See Also
- `cheat gh-dash` — full TUI dashboard for PRs/issues
- `cheat lazygit` — local git operations
- `cheat git` — core git commands
