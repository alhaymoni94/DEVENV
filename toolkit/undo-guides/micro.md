# Micro Undo Guide
> "I messed up, how do I fix it?"

## I saved a file with wrong content
```
Ctrl+Z                     # undo last change
Ctrl+Y                     # redo if you went too far
# Or: Ctrl+Z multiple times to undo all changes
```

## I closed a file without saving
Changes are lost. Re-open and redo:
```
e filename                 # reopen the file
```

## I accidentally deleted a whole file
```bash
# If tracked by git:
git checkout -- filename

# If not tracked:
# Check trash (if deleted via yazi):
ls ~/.local/share/Trash/files/
mv ~/.local/share/Trash/files/filename ./
```

## I made a bad find/replace
```
Ctrl+Z                     # undo the replace
# Or reopen the file if you saved:
Ctrl+Z repeatedly          # undo all replacements
```

## I'm lost in the file browser
```
Ctrl+Q                     # quit micro
e .                        # reopen with file browser
# Or navigate with arrow keys in the sidebar
```

## I accidentally overwrote a file
```bash
# If tracked by git:
git checkout -- filename

# If you have a backup:
cp backup-file filename
```
