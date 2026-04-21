# Git Undo Guide
> "I messed up, how do I fix it?"

## I committed to the wrong branch
```bash
git reset --soft HEAD~1    # undo commit, keep changes staged
git stash                  # stash the changes
git checkout correct-branch
git stash pop              # apply changes
git commit -m "message"
```

## I committed with the wrong message
```bash
git commit --amend -m "correct message"
# If already pushed:
git push --force-with-lease
```

## I staged the wrong files
```bash
git reset HEAD <file>      # unstage specific file
git reset HEAD             # unstage everything
```

## I deleted a branch I didn't mean to
```bash
git reflog                 # find the SHA before deletion
git checkout -b recovered <sha>
```

## I want to undo the last commit entirely
```bash
git reset --hard HEAD~1    # WARNING: destroys local changes
# Or keep changes:
git reset --soft HEAD~1    # keeps changes staged
git reset HEAD~1           # keeps changes unstaged
```

## I pushed to the wrong remote/branch
```bash
git push --force-with-lease origin correct-branch
# Or delete the wrong push:
git push origin --delete wrong-branch
```
