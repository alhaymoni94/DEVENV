# Lesson 17: SDLC Using AI Agents — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Use AI for project planning
- Build projects with AI assistance
- Write tests with AI help
- Set up CI/CD with AI
- Complete a full SDLC cycle

## Prerequisites

- Phase 5 lessons 14-16 completed
- GitHub account, gh CLI authenticated

## Lesson Flow

### Part 1: AI-Assisted Planning (20 min)

**Demo:**
```bash
ai "I want to build a personal task management CLI tool in Python. Help me plan: requirements, architecture, tech choices, milestones, testing strategy."
```

### Part 2: AI-Assisted Development (30 min)

**Demo the full build:**
```bash
mkdir ~/sdlc-demo && cd ~/sdlc-demo
opencode
# "Create the project structure"
# "Implement the core Task class with CRUD"
# "Add CLI interface with argparse"
# "Add file-based storage (JSON)"
# "Write unit tests"
```

### Part 3: AI-Assisted Testing (20 min)

**Have students ask AI:**
```bash
opencode
# "Review all tests. Are edge cases covered? Add error handling tests. Add integration tests."
```

### Part 4: AI-Assisted CI/CD (20 min)

**Demo:**
```bash
ai "create a GitHub Actions workflow for this Python project: run tests, check style, generate coverage, publish to PyPI on release"
```

### Part 5: Full SDLC Demo (30 min)

**Walk through the complete cycle:**
1. Plan → 2. Build → 3. Test → 4. Document → 5. Package → 6. Deploy

## Assessment

- Students use AI for project planning
- Students build with AI assistance
- Students set up CI/CD with AI
- Students complete a full SDLC cycle
