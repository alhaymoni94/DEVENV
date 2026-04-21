# Shell Undo Guide
> "I messed up, how do I fix it?"

## I deleted a file I didn't mean to
```bash
# If tracked by git:
git checkout -- <file>

# If in trash (yazi's d key):
ls ~/.local/share/Trash/files/
mv ~/.local/share/Trash/files/<file> ./

# If rm'd (no trash):
# Check for backups, or use recovery tools like testdisk
```

## I ran a command I didn't mean to
```bash
Ctrl+C                     # cancel running command
history -d <line-number>   # remove from history
```

## My PATH is broken (commands not found)
```bash
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Then re-run: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## Terminal is frozen (no output)
```bash
Ctrl+Q                     # unfreeze — you probably hit Ctrl+S by accident
```

## I typed a command wrong and it's half-executed
```bash
Ctrl+C                     # cancel
Ctrl+U                     # clear line to start over
```

## I want to remove something from history
```bash
history -d <line-number>   # delete specific entry
# Or edit the file directly:
e ~/.zsh_history           # remove lines, save
```
