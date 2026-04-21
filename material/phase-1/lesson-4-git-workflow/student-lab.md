# Lesson 4: Git Workflow — Student Lab

## Duration: 2 hours

---

## Exercise 1: Your First Repository (15 min)

**Task:** Create a git repo and make your first commits.

```bash
# Create a project
mkdir ~/projects/git-practice && cd ~/projects/git-practice

# Initialize git
git init

# Create a README
e README.md
```

Add:
```markdown
# Git Practice Project

This is my first git repository.
```

```bash
# Stage and commit
git add README.md
git commit -m "feat: add README"

# Check status
git status
git log --oneline

# Make more changes
e notes.txt
```

Add:
```
Day 1: Learning git basics
```

```bash
# Stage and commit
git add -A
git commit -m "feat: add notes"

# View history
git log --oneline --graph
```

**Check:** You should see 2 commits in the log.

---

## Exercise 2: lazygit (20 min)

**Task:** Use lazygit for all git operations.

```bash
# Make some changes
e README.md
# Add a new section

e config.yaml
# Create a new file with some content
```

```bash
# Open lazygit
lg
```

Inside lazygit:
```
1. Look at the "Files" panel — you should see your changes
2. Press Space on each file to stage it
3. Press c to commit
4. Type: "feat: add config and update README"
5. Press Ctrl+Enter to confirm
6. Press q to quit

# View history in lazygit
lg
# Use arrow keys to navigate commits
# Press Enter on a commit to see details
# Press q to quit
```

**Check:** Your commit should appear in the log.

---

## Exercise 3: Branching (25 min)

**Task:** Create a feature branch, make changes, and merge.

```bash
# Make sure you're on main
git branch  # should show * main (or * master)

# Create a feature branch
git checkout -b feature/add-greeting

# Create a Python script
e greet.py
```

Add:
```python
#!/usr/bin/env python3

def greet(name):
    return f"Hello, {name}!"

if __name__ == "__main__":
    print(greet("World"))
```

```bash
# Commit on the feature branch
git add -A
git commit -m "feat: add greeting function"

# Switch back to main
git checkout main

# Verify greet.py is gone (it's on the feature branch)
ls

# Merge the feature branch
git merge feature/add-greeting

# Verify it's back
ls
cat greet.py
```

**Check:** The greeting script should be on main after the merge.

---

## Exercise 4: Create a PR (20 min)

**Task:** Push a branch to GitHub and create a PR.

```bash
# Create a new feature branch
git checkout -b feature/add-farewell

e farewell.py
```

Add:
```python
#!/usr/bin/env python3

def farewell(name):
    return f"Goodbye, {name}!"

if __name__ == "__main__":
    print(farewell("World"))
```

```bash
# Commit
git add -A
git commit -m "feat: add farewell function"

# Push to GitHub (replace with your repo)
git remote add origin https://github.com/YOUR_USERNAME/git-practice.git
git push -u origin feature/add-farewell

# Create a PR
gh pr create --fill --web
```

**Check:** Open the PR in your browser. Does it show the correct changes?

---

## Exercise 5: Conflict Resolution (25 min)

**Task:** Create and resolve a merge conflict.

```bash
# Start from main
git checkout main

# Create branch A
git checkout -b branch-a
e message.txt
```

Add:
```
Hello from branch A!
```

```bash
git add -A
git commit -m "feat: add message from branch A"

# Switch to main and create branch B
git checkout main
git checkout -b branch-b
e message.txt
```

Replace the content with:
```
Hello from branch B!
```

```bash
git add -A
git commit -m "feat: add message from branch B"

# Now try to merge branch A into branch B
git merge branch-a
```

**You should see a conflict!**

```bash
# Open the conflicted file
e message.txt
```

You'll see something like:
```
<<<<<<< HEAD
Hello from branch B!
=======
Hello from branch A!
>>>>>>> branch-a
```

**Resolve it:** Replace the entire conflict marker section with:
```
Hello from both branches!
```

```bash
# Stage the resolved file
git add message.txt

# Complete the merge
git commit -m "merge: resolve conflict in message.txt"
```

**Check:** `cat message.txt` should show your resolved content.

---

## Exercise 6: Undo Operations (20 min)

**Task:** Practice undoing git operations.

```bash
# Make a commit
e temp.txt
echo "temporary" > temp.txt
git add temp.txt
git commit -m "temp: this should not exist"

# Oops! Undo the commit, keep changes staged
git reset --soft HEAD~1

# Check: commit is gone, file is still staged
git status

# Now undo the staging too
git reset HEAD~1

# Check: file is unstaged
git status

# Clean up
rm temp.txt

# Stash exercise
e work-in-progress.txt
echo "half done" > work-in-progress.txt
git add work-in-progress.txt

# Need to switch branches but don't want to commit yet
git stash

# Check: working directory is clean
git status

# Switch branches, do something, come back
git checkout main
git checkout -

# Get your work back
git stash pop
```

---

## Exercise 7: Full Workflow Challenge (20 min)

**Task:** Complete a full git workflow from start to finish.

```bash
# 1. Start from main
git checkout main

# 2. Create a feature branch
git checkout -b feat/complete-workflow

# 3. Create a complete project
mkdir -p src tests
e src/app.py
```

Add:
```python
#!/usr/bin/env python3

def main():
    print("Workflow complete!")

if __name__ == "__main__":
    main()
```

```bash
e tests/test_app.py
```

Add:
```python
from src.app import main

def test_main():
    assert main() is None
```

```bash
# 4. Commit
git add -A
git commit -m "feat: complete project structure"

# 5. Push and create PR (if you have a remote)
git push -u origin feat/complete-workflow
gh pr create --fill

# 6. Merge (or simulate it)
git checkout main
git merge feat/complete-workflow

# 7. Clean up
git branch -d feat/complete-workflow
```

**Check:** You've completed a full workflow: branch → work → commit → merge → cleanup.

---

## Bonus Challenges

1. **Interactive rebase:** `git rebase -i HEAD~3` to squash commits
2. **Cherry-pick:** `git cherry-pick <commit-sha>` to apply a specific commit
3. **Blame:** `git blame greet.py` to see who wrote each line
4. **Tags:** `git tag v1.0` and `git push origin v1.0`

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can initialize a repo and make commits
- [ ] I can use lazygit for staging, committing, and viewing history
- [ ] I can create and switch branches
- [ ] I can merge branches
- [ ] I can resolve merge conflicts
- [ ] I can create PRs with gh CLI
- [ ] I can undo commits with git reset
- [ ] I can use git stash to save work temporarily
- [ ] I can complete a full feature workflow

**Total: ___ / 45**

---

## Phase 1 Complete! 🎉

You've completed all 4 lessons in Phase 1. You can now:
- Use AI agents from the terminal
- Navigate Unix like a pro
- Manage terminal sessions with tmux
- Use git for version control

**Next:** Phase 2 — Development Environment
