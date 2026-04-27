# Documentation Index

## Core Documents

| Document | Description |
|----------|-------------|
| [PRODUCT.md](PRODUCT.md) | Product Requirements Document - complete project specification |
| [STATUS.md](STATUS.md) | Current project status, health, active students |
| [BACKLOG.md](BACKLOG.md) | Future features, improvements, technical debt |
| [TASKS.md](TASKS.md) | Current work items and implementation tasks |

## Quick Reference

- **Project**: AUT Linux Camp - Terminal-first learning platform
- **Location**: `/home/sleman-alhaymoni/Documents/AUT-Projects/AUT-Linux-Camp`
- **Main Components**: `toolkit/`, `material/`, `students/`, `tests/`

## Quick Commands

```bash
# Setup
bash toolkit/setup.sh

# Health check
bash toolkit/doctor.sh

# Student workflow
camp next
camp progress
camp submit <phase>

# Supervisor
camp evaluate [student] [phase]
```

## Contributing

1. Check [TASKS.md](TASKS.md) for current work items
2. Check [BACKLOG.md](BACKLOG.md) for planned features
3. Make atomic commits with descriptive messages
4. Update docs/ after each significant change