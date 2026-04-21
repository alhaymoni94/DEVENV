# Graduation Project: Local AI-Based Application

## Overview

Build a functional AI application using the skills learned throughout the camp. The project must be entirely terminal-based and demonstrate proficiency across all phases.

## Requirements

### Minimum Requirements (Pass)
- [ ] A working application with at least 3 features
- [ ] Uses at least one AI tool (aichat or opencode)
- [ ] Containerized with Docker
- [ ] Version controlled with git
- [ ] Documented with a README

### Advanced Requirements (Distinction)
- [ ] Uses synthetic data for testing
- [ ] Has automated tests
- [ ] Has a CI/CD pipeline
- [ ] Uses tmux for development workflow
- [ ] Has a custom starship prompt segment
- [ ] Includes a custom cheatsheet

## Project Ideas

### 1. AI-Powered Code Review Tool
A CLI tool that:
- Reads a git diff
- Sends it to an AI model for review
- Returns suggestions for improvements
- Saves reports as markdown

### 2. Terminal Dashboard with AI Insights
A dashboard that:
- Shows system stats (CPU, RAM, disk)
- Shows git activity
- Uses AI to analyze logs and surface issues
- Updates in real-time

### 3. Data Analysis Pipeline
A pipeline that:
- Downloads a dataset
- Cleans it with AI assistance
- Performs analysis
- Generates a markdown report
- Runs on a schedule

### 4. AI Chat Bot for Terminal
A chatbot that:
- Runs entirely in the terminal
- Has custom commands
- Remembers conversation context
- Can execute safe shell commands

### 5. Personal Knowledge Base
A system that:
- Stores notes in markdown
- Uses AI to tag and categorize
- Supports full-text search
- Generates summaries

## Deliverables

1. **Source code** in a git repository
2. **README.md** with setup and usage instructions
3. **Dockerfile** and/or docker-compose.yml
4. **Demo video** or terminal recording
5. **Presentation** (5 minutes) explaining:
   - What you built
   - How you built it
   - What you learned
   - Challenges and solutions

## Timeline

| Week | Task |
|------|------|
| 1 | Project proposal and planning |
| 2 | Core development |
| 3 | Testing and containerization |
| 4 | Documentation and presentation prep |

## Evaluation Criteria

| Criteria | Weight |
|----------|--------|
| Functionality | 30% |
| Code quality | 20% |
| Documentation | 15% |
| Containerization | 15% |
| Presentation | 10% |
| Creativity | 10% |

## Submission

```bash
# Create your project
mkdir ~/graduation-project && cd ~/graduation-project

# Initialize git
git init

# Build your project
# ...

# Submit
git remote add origin https://github.com/YOUR_USERNAME/graduation-project.git
git push -u origin main
```

## Resources

- All cheat sheets: `cheat --list`
- All workflows: `cheat --workflow <name>`
- AI assistance: `ai "your question"` or `opencode`
- Docker help: `cheat docker`
- Git help: `cheat git`

---

**Good luck! You've earned this. 🎓**
