#!/usr/bin/env bash
# onboarding-test.sh — Validate the student onboarding flow
# This simulates a student's first experience without actually installing tools.
set -euo pipefail

CAMP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
DIM="\033[2m"
RESET="\033[0m"

PASS=0
FAIL=0

pass() { echo -e "  ${GREEN}✓${RESET} $1"; PASS=$((PASS + 1)); }
fail() { echo -e "  ${RED}✗${RESET} $1"; FAIL=$((FAIL + 1)); }

header() {
    echo ""
    echo -e "${DIM}── $1 ──${RESET}"
}

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║   Student Onboarding Flow Test                       ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Step 1: Repository clone ────────────────────────────────────────────────
header "Step 1: Repository"
[ -d "$CAMP_DIR/.git" ] && pass "Git repository present" || fail "Not a git repo"
[ -f "$CAMP_DIR/README.md" ] && pass "README.md exists" || fail "README.md missing"

# ── Step 2: Setup script ────────────────────────────────────────────────────
header "Step 2: Setup Script"
[ -x "$CAMP_DIR/toolkit/setup.sh" ] && pass "setup.sh is executable" || fail "setup.sh not executable"
head -5 "$CAMP_DIR/toolkit/setup.sh" | grep -q "bash" && pass "setup.sh has bash shebang" || fail "setup.sh shebang missing"

# ── Step 3: Health check ────────────────────────────────────────────────────
header "Step 3: Health Check"
[ -x "$CAMP_DIR/toolkit/doctor.sh" ] && pass "doctor.sh is executable" || fail "doctor.sh not executable"

# ── Step 4: Student workspace creation ──────────────────────────────────────
header "Step 4: Student Workspace"
[ -d "$CAMP_DIR/students/template" ] && pass "template exists" || fail "template missing"
[ -d "$CAMP_DIR/students/template/phase-1" ] && pass "template has phase-1" || fail "template missing phase-1"

# Simulate creating a student workspace
TEST_STUDENT="$(whoami)"
TEST_DIR="$CAMP_DIR/students/$TEST_STUDENT"
rm -rf "$TEST_DIR"
cp -r "$CAMP_DIR/students/template" "$TEST_DIR"
[ -d "$TEST_DIR" ] && pass "cp -r template students/$(whoami) works" || fail "Workspace copy failed"

# ── Step 5: First commands ──────────────────────────────────────────────────
header "Step 5: First Commands"
python3 "$CAMP_DIR/toolkit/scripts/camp" next >/dev/null 2>&1 && pass "camp next works" || fail "camp next failed"
python3 "$CAMP_DIR/toolkit/scripts/camp" progress >/dev/null 2>&1 && pass "camp progress works" || fail "camp progress failed"

# ── Step 6: Material accessible ─────────────────────────────────────────────
header "Step 6: Learning Material"
[ -f "$CAMP_DIR/material/phase-1/lesson-1-ai-agents/student-lab.md" ] && pass "Lesson 1 lab exists" || fail "Lesson 1 lab missing"
[ -f "$CAMP_DIR/material/SELF_PACED_GUIDE.md" ] && pass "Self-paced guide exists" || fail "Self-paced guide missing"

# ── Step 7: First lesson deliverables ───────────────────────────────────────
header "Step 7: Deliverables"
grep -q "## Deliverables" "$CAMP_DIR/material/phase-1/lesson-1-ai-agents/student-lab.md" && pass "Lesson 1 has deliverables section" || fail "Lesson 1 missing deliverables"

# ── Step 8: Cheat system ────────────────────────────────────────────────────
header "Step 8: Help System"
[ -x "$CAMP_DIR/toolkit/scripts/cheat" ] && pass "cheat script exists" || fail "cheat script missing"
[ -d "$CAMP_DIR/toolkit/cheatsheets" ] && pass "cheatsheets dir exists" || fail "cheatsheets missing"

# ── Cleanup ─────────────────────────────────────────────────────────────────
rm -rf "$TEST_DIR"

# ── Summary ─────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║   Onboarding Flow Results                            ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${GREEN}✓ $PASS passed${RESET}   ${RED}✗ $FAIL failed${RESET}"
echo ""

if [ "$FAIL" -eq 0 ]; then
    echo -e "  ${GREEN}Onboarding flow is ready for students!${RESET}"
    exit 0
else
    echo -e "  ${RED}$FAIL issue(s) found.${RESET}"
    exit 1
fi
