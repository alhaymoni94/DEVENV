# Project Status

## Overview

**Project**: AUT Linux Camp
**Version**: 1.0
**Last Updated**: 2026-04-27
**Status**: In Development

## Current State

### Completed Features

| Feature | Status | Notes |
|---------|--------|-------|
| Terminal stack (32+ tools) | ✅ Done | Full setup via setup.sh |
| Health check (40/40) | ✅ Done | doctor.sh validates all |
| Cheat system | ✅ Done | cheatsheets, quick-refs, undo-guides, workflows |
| 13 lessons (4 phases) | ✅ Done | Phases 1-4 complete |
| Student labs | ✅ Done | All lessons have exercises |
| Progress tracking | ✅ Done | camp progress |
| Next lesson guide | ✅ Done | camp next |
| Phase submission | ✅ Done | camp submit |
| Supervisor evaluation | ✅ Done | camp evaluate |
| Python CLI | ✅ Done | camp_cli with argparse |
| Dotfile management | ✅ Done | chezmoi integration |

### In Progress

| Feature | Status | Notes |
|---------|--------|-------|
| Instructor guides | 🔄 Partial | Phases 1-3 done, 4 pending |
| Complete testing | 🔄 Partial | Basic CLI tests exist |

### Known Issues

| Issue | Severity | Status |
|-------|----------|--------|
| Empty student directories not tracked | Low | Documented in template README |
| Archived phases 5-6 | Low | Kept for future v1.1 |

## Technical Health

| Metric | Value | Target |
|--------|-------|--------|
| Setup script | ✅ Working | 100% |
| Doctor checks | 40/40 | 40/40 |
| CLI commands | 4/4 working | 4/4 |
| Test coverage | 35 tests | Expand |
| Documentation | Good | Keep updated |
| Pytest suite | ✅ 35/35 passing | Maintain |

## Test Suite

Run tests with:
```bash
python3 -m pytest tests/ -v
```

### Test Files

| File | Tests | Coverage |
|------|-------|----------|
| test_common.py | 5 | Path utilities, total_phases() |
| test_commands.py | 5 | Error paths for next, progress, evaluate, submit |
| test_evaluate.py | 13 | Scoring logic (full, empty, syntax, git, etc.) |
| test_submit.py | 8 | Git workflow (init, commit, push, remote) |
| test_progress.py | 4 | Progress display (header, milestones, 0%) |

**Total: 35 tests passing**

## Active Students

_(To be updated by supervisor)_

| Student | Phase | Last Active | Status |
|---------|-------|-------------|--------|
| (none yet) | - | - | - |

## Recent Changes

- 2026-04-27: Phase 6 complete - security docs and .gitignore cleanup
- 2026-04-27: Added SECURITY.md with API key best practices
- 2026-04-27: Enhanced .gitignore with IDE/OS entries
- 2026-04-27: Phase 5 complete - expanded test suite to 35 tests
- 2026-04-27: Added evaluate scoring tests (13 cases)
- 2026-04-27: Added submit git workflow tests (8 cases)
- 2026-04-27: Added progress command tests (4 cases)
- 2026-04-27: Added conftest.py with shared test fixtures
- 2026-04-27: Directory cleanup - renamed DEV-ENV to toolkit/
- 2026-04-27: Updated student template README with all 4 phases
- 2026-04-27: Created docs/ directory structure

## Next Steps

See [TASKS.md](TASKS.md) for current implementation tasks.