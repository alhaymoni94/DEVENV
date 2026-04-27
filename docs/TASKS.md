# Tasks - Current Work Items

## Active Tasks

### Phase 5: Testing (Pending)

| Task | Status | Notes |
|------|--------|-------|
| Fix eval pattern in setup.sh | ✅ Done | Replaced eval with declare -n |
| Add type hints to Python commands | ✅ Done | Already present in codebase |
| Make total_phases() dynamic | ✅ Done | Scans material/ for phase-* dirs |

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

### Code Quality ✅
- [x] Replace eval with nameref in setup.sh
- [x] Make total_phases() dynamic

## How to Use

1. Check this file for current work
2. Update status as you work
3. Move completed items to STATUS.md
4. Add new items to BACKLOG.md

## Notes

- Use atomic commits
- Update docs/ after each commit
- Keep STATUS.md current