# Git Branching Workflow
> Standard branching strategy with lazygit and gh CLI.

## Quick Reference

```
main ────────────────────────────────────────────────
        \           \           \
         feature-a   feature-b   hotfix-c
          \           \           \
           ────────────┬───────────┬──
                       ↓           ↓
                   PR merged   PR merged
```

## Create a Feature Branch

```bash
# From main, create and switch to feature branch
git checkout main
git pull origin main
git checkout -b feature/add-user-auth

# Or with gh CLI
gh pr create --base main --head feature/add-user-auth --fill
```

## Work on the Branch

```bash
# Edit files
e src/auth.py

# Check status
lg                    # lazygit shows uncommitted changes

# Stage and commit
lg → Space → c → "feat: add user authentication" → P

# Or CLI
git add -A && git commit -m "feat: add user authentication"
git push -u origin feature/add-user-auth
```

## Create a PR

```bash
# Using gh CLI
gh pr create --fill --web

# Fill in description, request reviewers
```

## Review and Merge

```bash
# Check PR status
gh pr list
gh pr checks          # CI status
gh pr view            # PR details

# Merge when approved
gh pr merge --squash  # or --merge or --rebase
```

## Resolve Conflicts

```bash
# Fetch latest main
git fetch origin
git rebase origin/main

# Fix conflicts in micro
e conflicted_file.py

# Continue rebase
git rebase --continue

# Force push (only if needed)
git push --force-with-lease
```

## Undo Branch Operations

```bash
# Undo last commit, keep changes
git reset --soft HEAD~1

# Delete local branch
git branch -d feature/old

# Delete remote branch
git push origin --delete feature/old

# Switch back to main
git checkout main
```

## Daily Branch Workflow

```
1. git checkout main && git pull
2. git checkout -b feature/new-thing
3. e . → work → Ctrl+S
4. lg → stage → commit → push
5. gh pr create --fill
6. Wait for review → fix → push
7. gh pr merge --squash
8. git checkout main && git pull
```

## Branch Naming Conventions

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feat/` | New feature | `feat/add-login` |
| `fix/` | Bug fix | `fix/null-pointer` |
| `docs/` | Documentation | `docs/update-readme` |
| `refactor/` | Code cleanup | `refactor/auth-module` |
| `test/` | Test additions | `test/add-unit-tests` |
| `hotfix/` | Urgent production fix | `hotfix/security-patch` |
