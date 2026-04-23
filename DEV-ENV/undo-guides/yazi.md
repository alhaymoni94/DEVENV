# Yazi Undo Guide
> "I deleted/moved/renamed files by accident in yazi"

## I deleted a file by accident

Yazi moves deleted files to trash by default:

```bash
# Check trash location
ls ~/.local/share/Trash/files/

# Restore a file
mv ~/.local/share/Trash/files/filename ./

# Or use trash-cli to list and restore
trash-list
trash-restore
```

## I moved a file to the wrong location

```bash
# Move it back
mv /wrong/path/filename /correct/path/

# If you don't remember where it was:
find /home -name "filename" 2>/dev/null
```

## I renamed a file and want to revert

```bash
# Rename back
mv new-name old-name

# Or if you forgot the original name, check yazi's log
cat ~/.local/state/yazi/yazi.log | tail -50
```

## I overwrote a file by accident

```bash
# If tracked by git:
git checkout -- filename

# If you have a backup:
cp backup-file filename

# Check if yazi created a backup
ls ~/.local/share/yazi/backups/
```

## I'm lost in the file system

```bash
# Go to home directory
~

# Go to previous directory
-

# Go to project root (if in a git repo)
git rev-parse --show-toplevel
```

## I accidentally selected multiple files

```bash
# Clear selection
Escape

# Or press v to toggle visual mode off
```

## Prevention Tips

1. **Enable trash**: Yazi uses trash by default on Linux
2. **Confirm deletes**: Add to `~/.config/yazi/yazi.toml`:
   ```toml
   [manager]
   show_hidden = false
   ```
3. **Use git**: Track important files so you can always revert
4. **Backup first**: Before bulk operations, copy files to a backup folder

## Recovery checklist

1. Check `~/.local/share/Trash/files/`
2. Run `trash-list`
3. Check git status: `git status`
4. Search for file: `find ~ -name "filename"`
5. Check yazi logs: `cat ~/.local/state/yazi/yazi.log`
