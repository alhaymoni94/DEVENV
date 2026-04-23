# Debugging Workflow
> Systematic approach to finding and fixing bugs using terminal tools.

## The Debug Loop

```
1. Reproduce the bug
2. Gather information
3. Form a hypothesis
4. Test the hypothesis
5. Fix the bug
6. Verify the fix
7. Commit the fix
```

## Step 1: Reproduce the Bug

```bash
# Run the failing command
python myscript.py

# Run with verbose output
python -v myscript.py

# Run with debug logging
DEBUG=1 python myscript.py
```

## Step 2: Gather Information

### Check Logs

```bash
# Application logs
cat app.log | tail -100

# System logs
journalctl -u myservice --no-pager -n 100

# Docker logs
docker compose logs --tail=100 web

# Search for errors
grep -i "error\|exception\|traceback" app.log
```

### Check System State

```bash
# Resource usage
btop

# Disk space
df -h

# Memory usage
free -h

# Network connections
ss -tulpn

# Open files
lsof -p <pid>
```

### Check Git State

```bash
# What changed recently?
lg
git log --oneline -10

# Did this work before?
git log --oneline --since="2 days ago"

# Bisect to find the breaking commit
git bisect start
git bisect bad
git bisect good <known-good-commit>
# Test, then: git bisect good/bad
```

## Step 3: Form a Hypothesis

```bash
# Ask AI for help
cat error.log | ai "what's causing this error?"

# Search documentation
glow docs/TROUBLESHOOTING.md

# Check if it's a known issue
gh issue list --label bug
```

## Step 4: Test the Hypothesis

### Isolate the Problem

```bash
# Run a single test
pytest tests/test_auth.py::test_login -v

# Run with a debugger
python -m pdb myscript.py

# Test in isolation
docker compose run --rm web python -c "import mymodule; print(mymodule.version())"
```

### Add Temporary Debug Output

```bash
# Open file in micro
e myscript.py

# Add print statements or logging
# Ctrl+S to save, Ctrl+Q to quit

# Run again
python myscript.py
```

## Step 5: Fix the Bug

```bash
# Edit the file
e myscript.py

# Make the fix
# Ctrl+S to save

# Run tests to verify
pytest tests/ -v
```

## Step 6: Verify the Fix

```bash
# Run full test suite
pytest tests/ -v

# Run integration tests
docker compose up -d
curl http://localhost:3000/health

# Check logs for errors
docker compose logs web | grep -i error
```

## Step 7: Commit the Fix

```bash
# Review changes
lg

# Stage and commit
lg → Space → c → "fix: resolve authentication timeout" → P

# Or CLI
git add -A && git commit -m "fix: resolve authentication timeout"
git push
```

## Debugging Tools Quick Reference

| Tool | Purpose | Command |
|------|---------|---------|
| **btop** | System monitoring | `btop` |
| **grep** | Search logs | `grep -i error app.log` |
| **tail** | Watch logs live | `tail -f app.log` |
| **lazygit** | Git history | `lg` |
| **ai** | AI debugging | `cat error.log \| ai "what's wrong?"` |
| **glow** | Read docs | `glow TROUBLESHOOTING.md` |
| **lazydocker** | Container logs | `lzd` |
| **visidata** | Analyze log data | `vd access.log` |

## Common Debug Scenarios

### "It works on my machine"

```bash
# Check environment differences
env | grep -i api_key
python --version
which python

# Run in Docker to match production
docker compose run --rm web python myscript.py
```

### "The service won't start"

```bash
# Check logs
docker compose logs web

# Check port conflicts
ss -tulpn | grep :3000

# Check dependencies
docker compose ps
```

### "Something is slow"

```bash
# Check system resources
btop

# Check disk I/O
iostat -x 1

# Check network latency
ping -c 5 api.example.com

# Profile Python code
python -m cProfile myscript.py
```

### "I broke something and don't know what"

```bash
# Check recent changes
git diff HEAD~5

# Revert to known-good state
git stash
git checkout main

# Or undo last commit
git reset --soft HEAD~1
```
