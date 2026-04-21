# Lazygit Undo Guide
> "I messed up, how do I fix it?"

## I committed with the wrong message
```
In lazygit:
  A                        # amend last commit (after staging changes)
  Or:
  c → rewrite message      # if you haven't pushed yet

If already pushed:
  git commit --amend -m "correct message"
  git push --force-with-lease
```

## I staged the wrong files
```
Space on each file         # unstage individually
# Or:
git reset HEAD             # unstage everything
```

## I committed to the wrong branch
```
In lazygit:
  z                        # undo last commit (keeps changes staged)
  n                        # create correct branch
  Space on branch → enter  # switch to it
  c → commit               # commit here

# Or in shell:
git reset --soft HEAD~1
git stash
git checkout correct-branch
git stash pop
git commit -m "message"
```

## I deleted a branch I didn't mean to
```bash
git reflog                 # find the SHA before deletion
git checkout -b recovered <sha>
```

## I pushed to the wrong remote
```bash
git push --force-with-lease origin correct-branch
# Or delete the wrong push:
git push origin --delete wrong-branch
```

## I want to undo any git action
```
z                          # lazygit's universal undo
# Works for: commit, push, pull, merge, rebase, checkout
```
