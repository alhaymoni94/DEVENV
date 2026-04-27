# Git Undo Guide
> "I made a git mistake — how do I fix it?"

## I committed to the wrong branch

```bash
# Undo the commit, keep changes
git reset --soft HEAD~1

# Stash the changes
git stash

# Switch to correct branch
git checkout correct-branch

# Apply changes
git stash pop

# Commit on correct branch
git add -A && git commit -m "feat: my feature"
```

## I committed with wrong message

```bash
# Amend last commit message
git commit --amend -m "correct message"

# If already pushed (requires force push)
git push --force-with-lease
```

## I committed files I didn't mean to

```bash
# Undo commit, keep changes unstaged
git reset HEAD~1

# Remove unwanted files from staging
git reset path/to/unwanted-file

# Re-commit with correct files
git add -A && git commit -m "correct commit"
```

## I deleted a branch by accident

```bash
# Find the commit SHA
git reflog | grep "checkout: moving from branch-name"

# Recreate branch from that commit
git branch branch-name <sha>

# Or use the reflog directly
git checkout -b branch-name HEAD@{1}
```

## I lost uncommitted changes

```bash
# Check if git stash has them
git stash list

# If you ran git stash by accident
git stash pop

# If you didn't stash, changes are likely gone
# Check if your editor has auto-save/backup
ls ~/.local/share/micro/backup/  # micro backups
```

## I merged the wrong branch

```bash
# Undo merge, keep changes
git reset --merge HEAD~1

# Undo merge, discard changes
git reset --hard HEAD~1

# WARNING: --hard deletes all uncommitted changes!
```

## I pushed something I shouldn't have

```bash
# Fix locally first
git reset --soft HEAD~1

# Force push (only if you're sure)
git push --force-with-lease

# Better: revert the commit instead
git revert HEAD
git push
```

## I have a detached HEAD

```bash
# Create a branch from current state
git checkout -b recovery-branch

# Or go back to main
git checkout main
```

## I want to undo a git rebase

```bash
# Find pre-rebase state
git reflog

# Reset to before rebase
git reset --hard ORIG_HEAD
```

## Recovery checklist

1. `git reflog` — shows all HEAD movements
2. `git status` — current state
3. `git log --oneline -10` — recent commits
4. `git stash list` — stashed changes
5. `git branch -a` — all branches
