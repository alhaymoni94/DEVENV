# Lesson 1: AI Agents in the Terminal — Student Lab

## Duration: 1.5 hours

## Setup

Before starting, verify your stack is healthy:

```bash
doctor.sh
```

You should see all core checks passing (warnings for optional tools like AI are OK).

> **About AI tools:** `ai` (opencode wrapper) and `opencode` are optional enhancements. If you configured an API key during setup, use them. If not, every exercise has a non-AI alternative marked with 🧠.

---

## Exercise 1: Your First Question (10 min)

**Task:** Learn about Linux processes and threads.

**With AI:**
```bash
ai "what is the difference between a process and a thread in Linux?"
```

**Without AI 🧠:**
```bash
man ps          # Read about processes
man top         # Read about process monitoring
cheat shell     # Look for process management tips
```

**Try these too:**
- With AI: `ai "explain the Linux file system hierarchy"`
- Without AI 🧠: `man hier` or `cheat shell | grep -i filesystem`

**Check:** Can you explain what you learned to someone else?

---

## Exercise 2: Analyze a File (15 min)

**Task:** Understand your shell configuration.

**With AI:**
```bash
cat ~/.zshrc | ai "explain this file section by section"
```

**Without AI 🧠:**
```bash
# Read the comments in the file itself
cat ~/.zshrc | grep "^#"

# Look up specific sections
cheat shell     # Explains zsh, starship, keybindings
cheat tmux      # Explains tmux config
cheat starship  # Explains prompt config
```

**Now try:**
```bash
# Explain your tmux config
cat ~/.tmux.conf
# Without AI: read comments, or run `cheat tmux`

# Explain your starship prompt config
cat ~/.config/starship/starship.toml
# Without AI: run `cheat starship`
```

**Check:** Do you understand your own configs better now?

---

## Exercise 3: Generate a Script (20 min)

**Task:** Write a script that lists the 10 largest files.

**With AI:**
```bash
ai "write a bash script that:
1. Lists the 10 largest files in the current directory
2. Shows their sizes in human-readable format
3. Sorts them from largest to smallest"
```

**Without AI 🧠:**
```bash
# Research the commands yourself:
cheat shell | grep -i find
cheat shell | grep -i sort
man ls | grep -i human

# Build it step by step:
ls -lh          # human-readable sizes
ls -lS          # sort by size
ls -lSh | head  # combine them
```

**Steps:**
1. Get the script (from AI or your own research)
2. Open micro: `e ~/bin/largest-files.sh`
3. Paste the script
4. Make it executable: `chmod +x ~/bin/largest-files.sh`
5. Run it: `largest-files.sh`

**Check:** Does the script work? If not:
- With AI: `largest-files.sh 2>&1 | ai "fix this error"`
- Without AI 🧠: Read the error message, check `cheat shell`, or run `bash -n largest-files.sh`

---

## Exercise 4: Debug an Error (15 min)

**Task:** Find and fix a syntax error.

```bash
# Create a broken Python script
e broken.py
```

Add this content (with a bug):
```python
def greet(name)
    print("Hello, " + name)

greet("World")
```

Save and run:
```bash
python broken.py
```

You'll get a `SyntaxError`. Now fix it:

**With AI:**
```bash
cat broken.py | ai "fix the syntax error and explain what was wrong"
```

**Without AI 🧠:**
```bash
# Read the error message carefully:
#   File "broken.py", line 1
#     def greet(name)
#                   ^
# SyntaxError: expected ':'

# The error tells you exactly what's wrong: missing colon after parameter list
# Fix it in micro: add a colon after `(name)`
```

**Check:** Did you identify the missing colon? Can you explain why Python requires it?

---

## Exercise 5: The Cheat System (15 min)

**Task:** Explore the help system.

```bash
# Take the guided tour
cheat --start

# Look up a specific tool
cheat micro

# Get a quick reference
qr micro

# Learn how to undo
cheat --undo micro

# Test your knowledge
cheat --quiz micro

# Get a random tip
tip
```

**Check:** Can you find help for any tool using `cheat`?

---

## Exercise 6: Coding Session (20 min)

**Task:** Create a Python script that counts words, lines, and characters.

**With AI (opencode):**
```bash
opencode
```

**Prompt:** "Create a Python script called `stats.py` that reads a text file, counts words/lines/characters, and prints a formatted table. Handle missing files gracefully."

**Without AI 🧠:**
```bash
# Research Python file handling:
cheat shell | grep -i python
# Or read Python docs: python3 -c "help(open)"

# Build it yourself:
# 1. Open a file
# 2. Read its contents
# 3. Split into words
# 4. Count lines, words, characters
# 5. Print formatted output
# 6. Handle FileNotFoundError
```

**Steps:**
1. Generate or write the code
2. Save it: `e stats.py`
3. Test it:
```bash
echo -e "hello world\nthis is a test" > test.txt
python3 stats.py test.txt
```

**Check:** Does the script work with a real file?

---

## Exercise 7: Learning Challenge (15 min)

**Task:** Learn something new using terminal resources.

Pick ONE topic you don't know about:
- Regular expressions
- JSON processing with `jq`
- SSH key management
- Cron jobs
- Environment variables

**Rules:**
1. Use `cheat`, `man`, and terminal tools
2. You cannot use a web browser
3. At the end, explain what you learned

**With AI:**
```bash
ai "teach me regular expressions in 5 minutes with examples"
ai "show me how to use grep with regex"
echo "hello123 world456" | grep -o '[0-9]\+'
```

**Without AI 🧠:**
```bash
man grep          # Read about pattern matching
cheat shell       # Look for regex examples
man 7 regex       # Linux regex reference
cheat git | grep -i regex   # Real-world examples
```

---

## Bonus Challenges

1. **Script Translation:** Convert your `largest-files.sh` to Python
2. **Code Review:** Check your script for best practices using `cheat shell`
3. **Data Conversion:** Use `jq` or Python to convert JSON to CSV

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-1/lesson-1-ai-agents/`:

| File | Description |
|------|-------------|
| `largest-files.sh` | Script that lists 10 largest files (Exercise 3) |
| `broken.py` | Fixed Python script (Exercise 4) |
| `stats.py` | Word/line/character counter (Exercise 6) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can ask questions and get answers (with AI or `man`/`cheat`)
- [ ] I can analyze files using terminal tools
- [ ] I can debug errors using error messages and docs
- [ ] I can write scripts using research and experimentation
- [ ] I can use `cheat` for help
- [ ] I can find cheatsheets, quick-refs, and undo guides
- [ ] I can learn new topics using terminal resources

**Total: ___ / 35**

---

## Next

Lesson 2: Unix Fundamentals
