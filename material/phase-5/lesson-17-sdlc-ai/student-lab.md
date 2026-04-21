# Lesson 17: SDLC Using AI Agents — Student Lab

## Duration: 2 hours

---

## Exercise 1: AI-Assisted Planning (20 min)

**Task:** Use AI to plan a project.

```bash
ai "I want to build a personal task management CLI tool in Python.
Help me plan the project:
1. Requirements gathering
2. Architecture design
3. Technology choices
4. Development milestones
5. Testing strategy

Output as a structured project plan."
```

**Save the plan:**
```bash
ai "..." > ~/projects/task-cli/PLAN.md
glow ~/projects/task-cli/PLAN.md
```

---

## Exercise 2: AI-Assisted Development (30 min)

```bash
mkdir ~/projects/task-cli && cd ~/projects/task-cli
opencode
```

**Follow your plan and build:**
1. "Create the project structure with src/, tests/, docs/"
2. "Implement the core Task class with CRUD operations"
3. "Add CLI interface with argparse"
4. "Add file-based storage (JSON)"
5. "Write unit tests for all operations"

---

## Exercise 3: AI-Assisted Testing (20 min)

```bash
opencode
```

**Prompt:** "Review all tests for the task-cli project:
1. Are all edge cases covered?
2. Add tests for error handling
3. Add integration tests
4. Generate a test coverage report"

---

## Exercise 4: AI-Assisted CI/CD (20 min)

```bash
ai "create a GitHub Actions workflow for this Python project that:
1. Runs tests on push and PR
2. Checks code style with ruff
3. Generates coverage report
4. Builds and publishes to PyPI on release"
```

```bash
mkdir -p .github/workflows
# Save the generated workflow
e .github/workflows/ci.yml
```

---

## Exercise 5: Full SDLC Demo (30 min)

**Task:** Complete a mini project from planning to deployment.

```bash
# 1. Plan
ai "plan a simple URL bookmark manager CLI"

# 2. Build
opencode "build the bookmark manager based on the plan"

# 3. Test
opencode "write comprehensive tests"

# 4. Document
opencode "write a README with usage examples"

# 5. Package
ai "create a pyproject.toml for this project"

# 6. Deploy (simulate)
git init
git add -A
git commit -m "feat: initial release"
```

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can use AI for project planning
- [ ] I can build projects with AI assistance
- [ ] I can write tests with AI help
- [ ] I can set up CI/CD with AI
- [ ] I can complete a full SDLC cycle with AI

**Total: ___ / 25**

---

## Phase 5 Complete! 🎉

You can now:
- Use TUI coding agents for complex development
- Generate and evaluate synthetic data
- Manage local AI models
- Run AI-assisted SDLC

**Next:** Phase 6 — Workspace Automation
