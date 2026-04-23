# Lesson 14: TUI Coding Agents — Student Lab

## Duration: 2 hours

---

## Exercise 1: opencode Deep Dive (30 min)

```bash
mkdir ~/agent-practice && cd ~/agent-practice
opencode
```

**Prompts to try:**
1. "Create a REST API with Flask that manages a todo list with CRUD operations"
2. "Add authentication with JWT to the API"
3. "Write unit tests for all endpoints"
4. "Add rate limiting and error handling"

---

## Exercise 2: AI-Assisted Refactoring (30 min)

```bash
# Create a messy codebase
e ~/agent-practice/messy_app.py
```

Add intentionally bad code:
```python
def f(x):
    data = []
    for i in x:
        if i > 0:
            data.append(i * 2)
    return data

def g(data):
    result = {}
    for d in data:
        if d not in result:
            result[d] = 0
        result[d] += 1
    return result
```

```bash
opencode
```

**Prompt:** "Refactor this code to:
1. Use descriptive function names
2. Add type hints and docstrings
3. Use list comprehensions where appropriate
4. Add error handling
5. Follow PEP 8"

---

## Exercise 3: Test-Driven Development with AI (30 min)

```bash
opencode
```

**Prompt:** "I want to build a URL shortener. Help me do it TDD-style:
1. First, write the tests
2. Then write the minimal code to pass the tests
3. Refactor"

---

## Exercise 4: Code Review Agent (30 min)

```bash
# Find one of your previous scripts
cat ~/bin/organize.sh | ai "perform a thorough code review:
1. Security vulnerabilities
2. Edge cases not handled
3. Performance improvements
4. Code style and readability
5. Suggest specific improvements"
```

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can use opencode for multi-step coding tasks
- [ ] I can use AI for refactoring
- [ ] I can do TDD with AI assistance
- [ ] I can use AI for code review

**Total: ___ / 20**

---

## Next

Lesson 15: Synthetic Data Generation
