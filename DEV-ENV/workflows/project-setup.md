# Project Setup Workflow
> Go from zero to a fully configured project in minutes.

## Quick Start

```bash
# Create new project directory
mkdir myproject && cd myproject

# Initialize git
git init

# Create README
e README.md
```

## Python Project Setup

```bash
# Create project structure
mkdir -p src tests docs

# Create virtual environment with uv
uv venv
source .venv/bin/activate

# Initialize pyproject.toml
uv init

# Add dependencies
uv add requests flask pytest

# Run tests
pytest

# Format code
uv tool install ruff
ruff check .
ruff format .
```

## Node.js Project Setup

```bash
# Initialize project
npm init -y

# Install dependencies
npm install express
npm install --save-dev jest

# Create structure
mkdir -p src test

# Run tests
npm test
```

## Docker Project Setup

```bash
# Create Dockerfile
e Dockerfile

# Create docker-compose.yml
e docker-compose.yml

# Build and run
docker compose up -d

# Check logs
docker compose logs -f
```

## Full Project Template

```bash
# Create structure
mkdir -p src tests docs scripts

# Initialize git
git init

# Create README
cat > README.md << 'EOF'
# My Project

## Setup
\`\`\`bash
uv sync
\`\`\`

## Run
\`\`\`bash
uv run python src/main.py
\`\`\`

## Test
\`\`\`bash
uv run pytest
\`\`\`
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
__pycache__/
*.pyc
.venv/
.env
*.egg-info/
dist/
build/
EOF

# Initialize uv project
uv init

# Add first dependency
uv add requests

# Run tests
uv run pytest

# First commit
git add -A
git commit -m "feat: initial project setup"
```

## Add CI/CD

```bash
# Create GitHub Actions workflow
mkdir -p .github/workflows
cat > .github/workflows/ci.yml << 'EOF'
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: astral-sh/setup-uv@v3
      - run: uv sync
      - run: uv run pytest
EOF

git add .github/workflows/ci.yml
git commit -m "ci: add GitHub Actions workflow"
```

## Project Checklist

- [ ] Initialize git repo
- [ ] Create README.md
- [ ] Set up virtual environment
- [ ] Add dependencies
- [ ] Create project structure
- [ ] Add .gitignore
- [ ] Write first test
- [ ] Set up CI/CD
- [ ] First commit

## Quick Reference

| Command | Purpose |
|---------|---------|
| `uv init` | Initialize Python project |
| `uv add <pkg>` | Add dependency |
| `uv run <cmd>` | Run command in venv |
| `uv run pytest` | Run tests |
| `npm init -y` | Initialize Node project |
| `docker compose up -d` | Start services |
| `git init` | Initialize git repo |
| `git add -A && git commit -m "msg"` | First commit |
