# Tasks - Current Work Items

## Active Tasks

### Phase 6: Security & Cleanup (Pending)

| Task | Status | Notes |
|------|--------|-------|
| Document API key best practices | ⏳ Pending | Add security note to docs/ |
| Clean up temp files | ⏳ Pending | Remove .pyc, __pycache__ |
| Verify .gitignore complete | ⏳ Pending | Review against actual files |

## Completed Tasks

### Directory Cleanup ✅
- [x] Rename DEV-ENV to toolkit/
- [x] Remove broken symlink
- [x] Update AGENTS.md references

### Critical Fixes ✅
- [x] CLI entry point (toolkit/scripts/camp)
- [x] evaluate.sh wrapper working
- [x] Student template updated

### Documentation ✅
- [x] Create docs/ directory
- [x] Move PRD.md to docs/PRODUCT.md
- [x] Create docs/README.md
- [x] Create docs/STATUS.md
- [x] Create docs/BACKLOG.md
- [x] Create docs/TASKS.md
- [x] Add test documentation to STATUS.md

### Code Quality ✅
- [x] Replace eval with nameref in setup.sh
- [x] Make total_phases() dynamic

### Testing ✅ (Phase 5)
- [x] Fix test_total_phases for dynamic behavior
- [x] Add 13 evaluate scoring tests
- [x] Add 8 submit git workflow tests
- [x] Add 4 progress command tests
- [x] Add conftest.py with shared fixtures

## How to Use

1. Check this file for current work
2. Update status as you work
3. Move completed items to STATUS.md
4. Add new items to BACKLOG.md

## Notes

- Use atomic commits
- Update docs/ after each commit
- Keep STATUS.md current
- Run tests: `python3 -m pytest tests/ -v`