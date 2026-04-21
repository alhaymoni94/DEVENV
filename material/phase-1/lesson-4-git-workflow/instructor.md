# Lesson 4: Git Workflow — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Initialize a git repository and make commits
- Use lazygit for all git operations
- Create branches, merge, and resolve conflicts
- Use `gh` CLI for PRs and GitHub integration
- Understand the git branching workflow

## Prerequisites

- Lessons 1-3 completed
- GitHub account
- `gh auth login` completed

## Lesson Flow

### Part 1: Git Basics (20 min)

**Cover:**
- What is git? (version control, history, collaboration)
- `git init`, `git add`, `git commit`
- `git status`, `git log`, `git diff`
- The three areas: working directory, staging, repository

**Demo:**
```bash
mkdir myproject && cd myproject
git init
echo "# My Project" > README.md
git add README.md
git commit -m "feat: initial commit"
git log --oneline
```

**Have students practice:**
1. Initialize a repo
2. Create files, stage, commit
3. View history with `git log`

### Part 2: lazygit (25 min)

**Cover:**
- `lg` — open lazygit
- Stage files with `Space`
- Commit with `c`
- Push with `P`
- View diffs, blame, log

**Demo:**
```bash
lg
# Navigate with arrow keys
# Space to stage
# c to commit
# P to push
# q to quit
```

**Have students practice:**
1. Make changes to files
2. Open lazygit and review changes
3. Stage and commit from lazygit
4. View commit history

### Part 3: Branching (25 min)

**Cover:**
- Why branch? (isolate work, parallel development)
- `git branch`, `git checkout`, `git checkout -b`
- `git merge`, `git rebase`
- Branch naming conventions

**Demo:**
```bash
# Create and switch to a branch
git checkout -b feature/add-header

# Make changes
e index.html
git add -A && git commit -m "feat: add header"

# Switch back to main
git checkout main

# Merge the feature
git merge feature/add-header
```

**Have students practice:**
1. Create a feature branch
2. Make commits on it
3. Switch to main
4. Merge the branch

### Part 4: GitHub CLI (20 min)

**Cover:**
- `gh pr create` — create a PR
- `gh pr list` — list PRs
- `gh pr view` — view PR details
- `gh pr merge` — merge a PR

**Demo:**
```bash
# Create a PR
gh pr create --fill

# Check status
gh pr list
gh pr checks

# Merge
gh pr merge --squash
```

**Have students practice:**
1. Push a branch to GitHub
2. Create a PR
3. Check CI status
4. Merge the PR

### Part 5: Conflict Resolution (20 min)

**Cover:**
- What causes conflicts?
- How to resolve them
- `git merge --abort`, `git rebase --abort`

**Demo:**
```bash
# Create a conflict
git checkout -b branch-a
e file.txt  # add line A
git commit -am "branch A"

git checkout main
e file.txt  # modify same line
git commit -am "main change"

git merge branch-a  # conflict!

# Resolve in micro
e file.txt
git add file.txt
git commit -m "merge: resolve conflict"
```

**Have students practice:**
1. Create a deliberate conflict
2. Resolve it in micro
3. Complete the merge

### Part 6: Undo Operations (15 min)

**Cover:**
- `git reset --soft` — undo commit, keep staged
- `git reset` — undo commit, keep unstaged
- `git reset --hard` — undo commit, destroy changes
- `git revert` — undo a commit safely
- `git stash` — save work temporarily

**Demo:**
```bash
# Undo last commit, keep changes staged
git reset --soft HEAD~1

# Undo last commit, keep changes unstaged
git reset HEAD~1

# Stash current changes
git stash

# Apply stashed changes
git stash pop
```

**Have students practice:**
1. Make a commit, then undo it
2. Stash changes, switch branches, pop stash

### Part 7: Full Workflow (15 min)

**Demo the complete cycle:**
```bash
# 1. Start from main
git checkout main && git pull

# 2. Create feature branch
git checkout -b feat/new-feature

# 3. Work and commit
e . → work → lg → stage → commit → push

# 4. Create PR
gh pr create --fill

# 5. Review, fix, push more commits

# 6. Merge
gh pr merge --squash

# 7. Clean up
git checkout main && git pull
git branch -d feat/new-feature
```

## Common Issues

| Issue | Solution |
|-------|----------|
| Detached HEAD | `git checkout -b recovery-branch` |
| Merge conflict | Edit files, `git add`, `git commit` |
| Wrong branch | `git reset --soft HEAD~1`, stash, switch |
| Lost commits | `git reflog` to find them |

## Assessment

- Students create a repo with 3+ commits
- Students create a feature branch and merge it
- Students resolve a merge conflict
- Students create a PR on GitHub

## Next

Phase 2: Development Environment
