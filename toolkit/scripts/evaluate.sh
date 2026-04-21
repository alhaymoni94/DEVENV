#!/usr/bin/env bash
# evaluate.sh — Supervisor evaluation tool
# Usage: evaluate.sh [student-name] [phase-number]
#   evaluate.sh                    # evaluate all students
#   evaluate.sh john               # evaluate john's latest submission
#   evaluate.sh john 1             # evaluate john's phase 1

set -euo pipefail

CAMP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STUDENTS_DIR="$CAMP_DIR/students"

# Colors
GREEN="\033[32m"
CYAN="\033[1;36m"
YELLOW="\033[33m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"
BOLD="\033[1m"

# ── Helpers ───────────────────────────────────────────────────────────────────
pass()  { printf "  ${GREEN}✓${RESET} %-50s ${GREEN}%s${RESET}\n" "$1" "$2"; }
fail()  { printf "  ${RED}✗${RESET} %-50s ${RED}%s${RESET}\n" "$1" "$2"; }
warn()  { printf "  ${YELLOW}!${RESET} %-50s ${YELLOW}%s${RESET}\n" "$1" "$2"; }
info()  { printf "  ${DIM}  %s${RESET}\n" "$1"; }

# ── Evaluate a single student's phase ─────────────────────────────────────────
evaluate_phase() {
    local student="$1"
    local phase="$2"
    local student_dir="$STUDENTS_DIR/$student"
    local phase_dir="$student_dir/phase-$phase"
    local score=0
    local max_score=0
    local issues=()

    if [ ! -d "$phase_dir" ]; then
        fail "Phase $phase directory" "not found"
        return 1
    fi

    echo ""
    printf "${CYAN}── Phase %d: %s ──${RESET}\n" "$phase" "$student"

    # Check 1: Directory structure exists
    max_score=$((max_score + 10))
    if [ -d "$phase_dir" ]; then
        pass "Directory structure" "exists"
        score=$((score + 10))
    else
        fail "Directory structure" "missing"
    fi

    # Check 2: Student work files exist
    max_score=$((max_score + 20))
    local work_files
    work_files=$(find "$phase_dir" -maxdepth 2 \( -name "*.py" -o -name "*.sh" -o -name "*.csv" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml" -o -name "*.md" ! -name "student-lab.md" ! -name "instructor.md" \) 2>/dev/null | wc -l)
    if [ "$work_files" -gt 0 ]; then
        pass "Student work files" "$work_files files"
        score=$((score + 20))
    else
        fail "Student work files" "none found"
        issues+=("No work files in phase $phase")
    fi

    # Check 3: Scripts are executable
    max_score=$((max_score + 10))
    local exec_files
    exec_files=$(find "$phase_dir" -name "*.sh" -executable 2>/dev/null | wc -l)
    local total_sh
    total_sh=$(find "$phase_dir" -name "*.sh" 2>/dev/null | wc -l)
    if [ "$total_sh" -gt 0 ] && [ "$exec_files" -eq "$total_sh" ]; then
        pass "Scripts executable" "$exec_files/$total_sh"
        score=$((score + 10))
    elif [ "$total_sh" -gt 0 ]; then
        warn "Scripts executable" "$exec_files/$total_sh (some not executable)"
        score=$((score + 5))
    else
        pass "Scripts executable" "no scripts to check"
        score=$((score + 10))
    fi

    # Check 4: Python files have no syntax errors
    max_score=$((max_score + 15))
    local py_errors=0
    for pyfile in $(find "$phase_dir" -name "*.py" 2>/dev/null); do
        if ! python3 -m py_compile "$pyfile" 2>/dev/null; then
            py_errors=$((py_errors + 1))
        fi
    done
    local total_py
    total_py=$(find "$phase_dir" -name "*.py" 2>/dev/null | wc -l)
    if [ "$total_py" -gt 0 ] && [ "$py_errors" -eq 0 ]; then
        pass "Python syntax" "all $total_py files valid"
        score=$((score + 15))
    elif [ "$total_py" -gt 0 ]; then
        fail "Python syntax" "$py_errors/$total_py files have errors"
        issues+=("$py_errors Python files with syntax errors")
    else
        pass "Python syntax" "no Python files to check"
        score=$((score + 15))
    fi

    # Check 5: Bash scripts pass syntax check
    max_score=$((max_score + 15))
    local sh_errors=0
    for shfile in $(find "$phase_dir" -name "*.sh" 2>/dev/null); do
        if ! bash -n "$shfile" 2>/dev/null; then
            sh_errors=$((sh_errors + 1))
        fi
    done
    if [ "$total_sh" -gt 0 ] && [ "$sh_errors" -eq 0 ]; then
        pass "Bash syntax" "all $total_sh files valid"
        score=$((score + 15))
    elif [ "$total_sh" -gt 0 ]; then
        fail "Bash syntax" "$sh_errors/$total_sh files have errors"
        issues+=("$sh_errors bash files with syntax errors")
    else
        pass "Bash syntax" "no bash files to check"
        score=$((score + 15))
    fi

    # Check 6: Git commits exist
    max_score=$((max_score + 10))
    if command -v git &>/dev/null && [ -d "$student_dir/.git" ]; then
        local commit_count
        commit_count=$(git -C "$student_dir" log --oneline 2>/dev/null | wc -l)
        if [ "$commit_count" -gt 0 ]; then
            pass "Git commits" "$commit_count commits"
            score=$((score + 10))
        else
            fail "Git commits" "no commits"
            issues+=("No git commits")
        fi
    else
        warn "Git commits" "no git repo in student directory"
        score=$((score + 5))
    fi

    # Check 7: Self-assessment filled
    max_score=$((max_score + 10))
    local self_assess
    self_assess=$(grep -r "Total:.*[0-9]" "$phase_dir" 2>/dev/null | grep -v "___" | wc -l)
    if [ "$self_assess" -gt 0 ]; then
        pass "Self-assessment" "filled"
        score=$((score + 10))
    else
        warn "Self-assessment" "not filled"
        issues+=("Self-assessment not completed")
    fi

    # Check 8: Code quality (basic)
    max_score=$((max_score + 10))
    local has_shebang=false
    local has_comments=false
    for shfile in $(find "$phase_dir" -name "*.sh" 2>/dev/null); do
        if head -1 "$shfile" | grep -q "^#!"; then
            has_shebang=true
        fi
        if grep -q "^#" "$shfile" 2>/dev/null; then
            has_comments=true
        fi
    done
    for pyfile in $(find "$phase_dir" -name "*.py" 2>/dev/null); do
        if grep -q "^#" "$pyfile" 2>/dev/null || grep -q '^"""' "$pyfile" 2>/dev/null; then
            has_comments=true
        fi
    done
    if $has_shebang && $has_comments; then
        pass "Code quality" "shebangs + comments"
        score=$((score + 10))
    elif $has_comments; then
        pass "Code quality" "has comments"
        score=$((score + 7))
    else
        warn "Code quality" "no comments found"
        score=$((score + 3))
    fi

    # Summary
    echo ""
    local pct=$(( score * 100 / max_score ))
    local grade
    if [ "$pct" -ge 80 ]; then
        grade="${GREEN}PASS${RESET}"
    elif [ "$pct" -ge 60 ]; then
        grade="${YELLOW}REVIEW${RESET}"
    else
        grade="${RED}FAIL${RESET}"
    fi

    printf "  ${BOLD}Score: ${score}/${max_score} (${pct}%) — ${grade}${RESET}\n"

    if [ ${#issues[@]} -gt 0 ]; then
        echo ""
        printf "  ${YELLOW}Issues:${RESET}\n"
        for issue in "${issues[@]}"; do
            info "$issue"
        done
    fi

    echo ""
    return 0
}

# ── Main ──────────────────────────────────────────────────────────────────────
printf "\n"
printf "${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${CYAN}║   AUT Linux Camp — Supervisor Evaluation         ║${RESET}\n"
printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"
printf "\n"
printf "  ${DIM}Date: %s${RESET}\n" "$(date '+%Y-%m-%d %H:%M')"
printf "  ${DIM}Camp: %s${RESET}\n" "$CAMP_DIR"
printf "\n"

if [ $# -ge 2 ]; then
    # Evaluate specific student's specific phase
    evaluate_phase "$1" "$2"
elif [ $# -ge 1 ]; then
    # Evaluate specific student's all phases
    student="$1"
    for phase in $(seq 1 6); do
        evaluate_phase "$student" "$phase" 2>/dev/null || true
    done
else
    # Evaluate all students
    if [ ! -d "$STUDENTS_DIR" ]; then
        echo -e "${RED}✗${RESET} No students directory found"
        exit 1
    fi

    for student_dir in "$STUDENTS_DIR"/*/; do
        student=$(basename "$student_dir")
        [ "$student" = "template" ] && continue

        printf "${CYAN}╔══════════════════════════════════════════════════╗${RESET}\n"
        printf "${CYAN}║   Student: %-36s║${RESET}\n" "$student"
        printf "${CYAN}╚══════════════════════════════════════════════════╝${RESET}\n"

        for phase in $(seq 1 6); do
            evaluate_phase "$student" "$phase" 2>/dev/null || true
        done
    done
fi

printf "${DIM}── Evaluation complete ──${RESET}\n\n"
