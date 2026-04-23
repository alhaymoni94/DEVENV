#!/usr/bin/env bash
# integration-test.sh — Run integration tests for the camp setup
# Usage: bash tests/integration-test.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CAMP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
DIM="\033[2m"
RESET="\033[0m"

PASS=0
FAIL=0

test_header() {
    echo ""
    echo -e "${DIM}── $1 ──${RESET}"
}

pass() {
    echo -e "  ${GREEN}✓${RESET} $1"
    PASS=$((PASS + 1))
}

fail() {
    echo -e "  ${RED}✗${RESET} $1"
    FAIL=$((FAIL + 1))
}

warn() {
    echo -e "  ${YELLOW}!${RESET} $1"
}

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║   AUT Linux Camp — Integration Tests                 ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Test 1: Repository structure ─────────────────────────────────────────────
test_header "Repository Structure"

[ -f "$CAMP_DIR/toolkit/setup.sh" ] && pass "setup.sh exists" || fail "setup.sh missing"
[ -f "$CAMP_DIR/toolkit/doctor.sh" ] && pass "doctor.sh exists" || fail "doctor.sh missing"
[ -f "$CAMP_DIR/toolkit/scripts/camp" ] && pass "camp CLI exists" || fail "camp CLI missing"
[ -d "$CAMP_DIR/material/phase-1" ] && pass "phase-1 material exists" || fail "phase-1 missing"
[ -d "$CAMP_DIR/material/phase-4" ] && pass "phase-4 material exists" || fail "phase-4 missing"
[ ! -d "$CAMP_DIR/material/phase-5" ] && pass "phase-5 archived" || warn "phase-5 still exists"
[ -d "$CAMP_DIR/tests" ] && pass "tests/ directory exists" || fail "tests/ missing"

# ── Test 2: Python CLI ──────────────────────────────────────────────────────
test_header "Python CLI"

cd "$CAMP_DIR"
python3 toolkit/scripts/camp --help >/dev/null 2>&1 && pass "camp --help works" || fail "camp --help failed"
python3 -m pytest tests/ -q >/dev/null 2>&1 && pass "pytest suite passes" || fail "pytest suite failed"

# ── Test 3: Bash script syntax ──────────────────────────────────────────────
test_header "Bash Script Syntax"

for script in "$CAMP_DIR/toolkit"/*.sh "$CAMP_DIR/toolkit/scripts"/*; do
    [ -f "$script" ] || continue
    # Skip non-bash files (Python scripts, etc.)
    [[ "$script" == *.py ]] && continue
    head -1 "$script" | grep -q "python" && continue
    if bash -n "$script" >/dev/null 2>&1; then
        pass "$(basename "$script") syntax OK"
    else
        fail "$(basename "$script") syntax error"
    fi
done

# ── Test 4: Student template ────────────────────────────────────────────────
test_header "Student Template"

[ -d "$CAMP_DIR/students/template" ] && pass "template exists" || fail "template missing"
[ -d "$CAMP_DIR/students/template/phase-1" ] && pass "template has phase-1" || fail "template missing phase-1"
[ -f "$CAMP_DIR/students/template/README.md" ] && pass "template README exists" || fail "template README missing"

# ── Test 5: Sample datasets ─────────────────────────────────────────────────
test_header "Sample Datasets"

[ -f "$CAMP_DIR/material/phase-3/data/employees.csv" ] && pass "employees.csv exists" || fail "employees.csv missing"
[ -f "$CAMP_DIR/material/phase-3/data/users.json" ] && pass "users.json exists" || fail "users.json missing"
[ -f "$CAMP_DIR/material/phase-3/data/messy-sales.csv" ] && pass "messy-sales.csv exists" || fail "messy-sales.csv missing"
[ -f "$CAMP_DIR/material/phase-3/data/sample.log" ] && pass "sample.log exists" || fail "sample.log missing"

# ── Test 6: Answer key ──────────────────────────────────────────────────────
test_header "Supervisor Answer Key"

[ -d "$CAMP_DIR/toolkit/answer-key" ] && pass "answer-key exists" || fail "answer-key missing"
[ -f "$CAMP_DIR/toolkit/answer-key/README.md" ] && pass "answer-key README exists" || fail "answer-key README missing"

# ── Test 7: CI configuration ────────────────────────────────────────────────
test_header "CI Configuration"

[ -f "$CAMP_DIR/.github/workflows/ci.yml" ] && pass "GitHub Actions workflow exists" || fail "CI workflow missing"

# ── Test 8: Documentation ───────────────────────────────────────────────────
test_header "Documentation"

[ -f "$CAMP_DIR/AGENTS.md" ] && pass "AGENTS.md exists" || fail "AGENTS.md missing"
[ -f "$CAMP_DIR/material/SELF_PACED_GUIDE.md" ] && pass "SELF_PACED_GUIDE.md exists" || fail "SELF_PACED_GUIDE missing"
[ -f "$CAMP_DIR/PRD.md" ] && pass "PRD.md exists" || fail "PRD.md missing"

# ── Test 9: Deliverables in lessons ─────────────────────────────────────────
test_header "Lesson Deliverables"

deliverable_count=0
for lab in "$CAMP_DIR/material"/phase-*/lesson-*/student-lab.md; do
    if grep -q "## Deliverables" "$lab" 2>/dev/null; then
        deliverable_count=$((deliverable_count + 1))
    fi
done

if [ "$deliverable_count" -ge 12 ]; then
    pass "$deliverable_count/13 lessons have deliverables"
else
    fail "Only $deliverable_count/13 lessons have deliverables"
fi

# ── Summary ─────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║   Test Results                                       ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${GREEN}✓ $PASS passed${RESET}   ${RED}✗ $FAIL failed${RESET}"
echo ""

if [ "$FAIL" -eq 0 ]; then
    echo -e "  ${GREEN}All integration tests passed!${RESET}"
    exit 0
else
    echo -e "  ${RED}$FAIL test(s) failed.${RESET}"
    exit 1
fi
