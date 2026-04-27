# Tasks - Current Work Items

## Active Tasks

### Phase 4: Code Quality (In Progress)

| Task | Status | Notes |
|------|--------|-------|
| Fix eval pattern in setup.sh | ⏳ Pending | Replace eval with nameref |
| Add type hints to Python commands | ⏳ Pending | Focus on evaluate.py, submit.py |
| Make total_phases() dynamic | ⏳ Pending | Scan material/ for phases |

### Phase 5: Testing (Pending)

| Task | Status | Notes |
|------|--------|-------|
| Add tests for evaluate scoring | ⏳ Pending | Test automated point calculation |
| Add tests for submit git workflow | ⏳ Pending | Test commit/push logic |
| Document test commands | ⏳ Pending | Add to docs/ |

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

## How to Use

1. Check this file for current work
2. Update status as you work
3. Move completed items to STATUS.md
4. Add new items to BACKLOG.md

## Notes

- Use atomic commits
- Update docs/ after each commit
- Keep STATUS.md current