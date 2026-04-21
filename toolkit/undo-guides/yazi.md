# Yazi Undo Guide
> "I messed up, how do I fix it?"

## I trashed a file I didn't mean to
```bash
ls ~/.local/share/Trash/files/
mv ~/.local/share/Trash/files/<filename> ./destination/
```

## I permanently deleted a file
No undo available. Check git if tracked:
```bash
git checkout -- <file>
```

## I'm lost in the directory tree
```bash
~                          # go home
-                          # go to previous directory
/                          # search for a filename
```

## I pasted files to the wrong location
```bash
# Navigate to wrong location, select the pasted files:
Space → select files
Ctrl+X → cut
Navigate to correct location
Ctrl+V → paste
```

## I can't find a hidden file
```bash
.                          # toggle hidden files visibility
```

## I renamed a file incorrectly
```bash
r                          # rename it back
# Or in shell:
mv wrong-name correct-name
```
