# Lesson 1: AI Agents in the Terminal — Student Lab

## Duration: 1.5 hours

## Setup

Before starting, verify your stack is healthy:

```bash
doctor.sh
```

You should see 40/40 checks passing.

---

## Exercise 1: Your First AI Question (10 min)

**Task:** Ask the AI a question about Linux.

```bash
ai "what is the difference between a process and a thread in Linux?"
```

**Try these too:**
```bash
ai "explain the Linux file system hierarchy"
ai "what does chmod 755 mean?"
```

**Check:** Did the answer make sense? Could you explain it to someone else?

---

## Exercise 2: Analyze a File (15 min)

**Task:** Have AI explain your shell configuration.

```bash
cat ~/.zshrc | ai "explain this file section by section"
```

**Now try:**
```bash
# Explain your tmux config
cat ~/.tmux.conf | ai "what does each line do?"

# Explain your starship prompt config
cat ~/.config/starship/starship.toml | ai "explain this config"
```

**Check:** Do you understand your own configs better now?

---

## Exercise 3: Generate a Script (20 min)

**Task:** Ask AI to write a useful bash script.

```bash
ai "write a bash script that:
1. Lists the 10 largest files in the current directory
2. Shows their sizes in human-readable format
3. Sorts them from largest to smallest"
```

**Steps:**
1. Get the script from AI
2. Open micro: `e ~/bin/largest-files.sh`
3. Paste the script
4. Make it executable: `chmod +x ~/bin/largest-files.sh`
5. Run it: `largest-files.sh`

**Check:** Does the script work? If not, paste the error back to AI:
```bash
largest-files.sh 2>&1 | ai "fix this error"
```

---

## Exercise 4: Debug an Error (15 min)

**Task:** Create a deliberate error and use AI to fix it.

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

You'll get a `SyntaxError`. Now use AI:

```bash
cat broken.py | ai "fix the syntax error and explain what was wrong"
```

**Check:** Did AI identify the missing colon? Did the explanation make sense?

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

## Exercise 6: opencode Coding Session (20 min)

**Task:** Use opencode for a multi-step coding task.

```bash
opencode
```

**Prompt:** "Create a Python script called `stats.py` that:
1. Reads a text file
2. Counts the number of words, lines, and characters
3. Prints the results in a formatted table
4. Handles the case where the file doesn't exist"

**Steps:**
1. Let opencode generate the code
2. Review the output
3. Save it: `e stats.py`
4. Test it: `python stats.py`
5. Ask opencode to add a feature: "Now add support for counting unique words"

**Check:** Does the script work with a real file?
```bash
echo "hello world\nthis is a test" > test.txt
python stats.py test.txt
```

---

## Exercise 7: AI-Assisted Learning Challenge (15 min)

**Task:** Learn something new using only AI and the terminal.

Pick ONE topic you don't know about:
- Regular expressions
- JSON processing with `jq`
- SSH key management
- Cron jobs
- Environment variables

**Rules:**
1. You can only use `ai`, `cheat`, and the terminal
2. You cannot use a web browser
3. At the end, explain what you learned to a partner

**Example:**
```bash
ai "teach me regular expressions in 5 minutes with examples"
ai "show me how to use grep with regex"
echo "hello123 world456" | grep -o '[0-9]\+'
```

---

## Bonus Challenges

1. **AI Translation:** `ai "translate this bash script to Python: [paste script]"`
2. **Code Review:** `cat ~/bin/largest-files.sh | ai "review this script for best practices"`
3. **Data Conversion:** `echo '{"name":"Alice","age":30}' | ai "convert this JSON to a CSV row"`

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can ask AI questions from the terminal
- [ ] I can pipe files to AI for analysis
- [ ] I can use AI to debug errors
- [ ] I can use AI to generate scripts
- [ ] I can use opencode for coding sessions
- [ ] I know how to use `cheat` for help
- [ ] I can find cheatsheets, quick-refs, and undo guides

**Total: ___ / 35**

---

## Next

Lesson 2: Unix Fundamentals
