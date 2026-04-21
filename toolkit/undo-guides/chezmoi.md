# Chezmoi Undo Guide
> "I messed up my dotfiles — how do I recover?"

## I applied a bad config change

```bash
# Revert the change in chezmoi source directory
cd ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles
git checkout -- path/to/bad-file

# Re-apply
chezmoi apply --force --no-pager
```

## I want to undo chezmoi apply

Chezmoi doesn't have a built-in undo, but you can:

```bash
# Check what changed
chezmoi diff

# Revert specific file
chezmoi apply --force --no-pager path/to/file

# Or restore from git history
chezmoi cd
git log --oneline -10
git checkout <commit> -- path/to/file
chezmoi apply --force --no-pager
```

## I added a file I didn't mean to

```bash
# Remove from chezmoi management
chezmoi forget path/to/file

# Or remove the source file
rm ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles/path/to/file
chezmoi apply --force --no-pager
```

## I lost my original config file

```bash
# Check chezmoi source directory
chezmoi cd
git log --oneline -10

# Restore from git
git checkout HEAD -- path/to/file

# Or check if chezmoi has a backup
ls ~/.local/share/chezmoi-backups/
```

## I want to reset all dotfiles

```bash
# Remove chezmoi state
rm -rf ~/.local/share/chezmoi/

# Re-initialize
chezmoi init --source ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles

# Apply fresh
chezmoi apply --force --no-pager
```

## I have a merge conflict in dotfiles

```bash
# Go to source directory
chezmoi cd

# Resolve conflicts
git status
git diff

# Edit the conflicted file
chezmoi edit path/to/file

# Mark as resolved
git add path/to/file
git commit -m "fix: resolve dotfile conflict"

# Apply
chezmoi apply --force --no-pager
```

## I accidentally deleted my dotfiles repo

```bash
# Clone it back (if pushed to remote)
chezmoi init https://github.com/username/dotfiles

# Or recreate from scratch
chezmoi init --source ~/Documents/AUT-Projects/AUT-Linux-Camp/toolkit/dotfiles
```

## Prevention Tips

1. **Commit often**: `git add -A && git commit -m "update config"`
2. **Use branches**: Test changes on a branch before merging
3. **Backup configs**: `chezmoi archive > backup.tar.gz`
4. **Check before applying**: `chezmoi diff` shows what will change

## Recovery checklist

1. `chezmoi status` — check what's out of sync
2. `chezmoi diff` — see pending changes
3. `chezmoi cd` — go to source directory
4. `git log --oneline -10` — check recent changes
5. `chezmoi apply --force --no-pager` — re-apply configs
