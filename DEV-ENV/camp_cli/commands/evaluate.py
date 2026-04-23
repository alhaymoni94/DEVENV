"""camp evaluate — Supervisor evaluation tool."""
import argparse
import subprocess
from pathlib import Path

from camp_cli.common import (
    Colors,
    header,
    ok,
    warn,
    fail,
    info,
    phase_dir,
    students_dir,
    student_dir,
    total_phases,
)


def evaluate_phase(student: str, phase: int) -> tuple[int, int, list[str]]:
    """Evaluate a single student's phase. Returns (score, max_score, issues)."""
    pdir = phase_dir(phase, student)
    score = 0
    max_score = 0
    issues = []

    print()
    print(f"{Colors.CYAN}── Phase {phase}: {student} ──{Colors.RESET}")

    if not pdir.exists():
        print(fail("Phase directory", "not found"))
        return score, max_score, ["Directory missing"]

    # Check 1: Directory structure (10 pts)
    max_score += 10
    if pdir.exists():
        print(ok("Directory structure", "exists"))
        score += 10
    else:
        print(fail("Directory structure", "missing"))

    # Check 2: Student work files exist (10 pts)
    max_score += 10
    work_files = [
        f for f in pdir.rglob("*")
        if f.suffix in {".py", ".sh", ".csv", ".json", ".yaml", ".yml", ".toml", ".md"}
        and f.name not in {"student-lab.md", "instructor.md"}
    ]
    if work_files:
        print(ok("Student work files", f"{len(work_files)} files"))
        score += 10
    else:
        print(fail("Student work files", "none found"))
        issues.append("No work files in phase")

    # Check 3: Scripts are executable (10 pts)
    max_score += 10
    sh_files = list(pdir.rglob("*.sh"))
    if sh_files:
        exec_files = [f for f in sh_files if f.stat().st_mode & 0o111]
        if len(exec_files) == len(sh_files):
            print(ok("Scripts executable", f"{len(exec_files)}/{len(sh_files)}"))
            score += 10
        else:
            print(warn("Scripts executable", f"{len(exec_files)}/{len(sh_files)} (some not executable)"))
            score += 5
            issues.append("Some scripts not executable")
    else:
        print(ok("Scripts executable", "no scripts to check"))
        score += 10

    # Check 4: Python syntax (15 pts)
    max_score += 15
    py_files = list(pdir.rglob("*.py"))
    if py_files:
        py_errors = 0
        for pyfile in py_files:
            result = subprocess.run(
                ["python3", "-m", "py_compile", str(pyfile)],
                capture_output=True,
            )
            if result.returncode != 0:
                py_errors += 1
        if py_errors == 0:
            print(ok("Python syntax", f"all {len(py_files)} files valid"))
            score += 15
        else:
            print(fail("Python syntax", f"{py_errors}/{len(py_files)} files have errors"))
            issues.append(f"{py_errors} Python files with syntax errors")
    else:
        print(ok("Python syntax", "no Python files to check"))
        score += 15

    # Check 5: Bash syntax (15 pts)
    max_score += 15
    if sh_files:
        sh_errors = 0
        for shfile in sh_files:
            result = subprocess.run(
                ["bash", "-n", str(shfile)],
                capture_output=True,
            )
            if result.returncode != 0:
                sh_errors += 1
        if sh_errors == 0:
            print(ok("Bash syntax", f"all {len(sh_files)} files valid"))
            score += 15
        else:
            print(fail("Bash syntax", f"{sh_errors}/{len(sh_files)} files have errors"))
            issues.append(f"{sh_errors} bash files with syntax errors")
    else:
        print(ok("Bash syntax", "no bash files to check"))
        score += 15

    # Check 6: Functional execution (10 pts)
    max_score += 10
    func_passed = 0
    func_total = 0
    func_skipped = 0

    def _requires_args(path: Path) -> bool:
        """Heuristic: skip scripts that likely need arguments."""
        text = path.read_text()
        return "${1:?" in text or "${1-" in text or "$1" in text or "read -r" in text

    for pyfile in py_files:
        if _requires_args(pyfile):
            func_skipped += 1
            continue
        func_total += 1
        try:
            result = subprocess.run(
                ["python3", str(pyfile)],
                capture_output=True,
                timeout=5,
            )
            if result.returncode == 0:
                func_passed += 1
        except subprocess.TimeoutExpired:
            issues.append(f"{pyfile.name} timed out")

    for shfile in sh_files:
        if _requires_args(shfile):
            func_skipped += 1
            continue
        func_total += 1
        try:
            result = subprocess.run(
                ["bash", str(shfile)],
                capture_output=True,
                timeout=5,
            )
            if result.returncode == 0:
                func_passed += 1
        except subprocess.TimeoutExpired:
            issues.append(f"{shfile.name} timed out")

    if func_total > 0:
        if func_passed == func_total:
            print(ok("Functional execution", f"all {func_total} passed"))
            score += 10
        else:
            print(warn("Functional execution", f"{func_passed}/{func_total} passed"))
            score += func_passed * 10 // func_total
            issues.append(f"{func_total - func_passed} scripts failed at runtime")
    else:
        note = f"no runnable files"
        if func_skipped > 0:
            note += f" ({func_skipped} skipped — need args)"
        print(ok("Functional execution", note))
        score += 10

    # Check 8: Git commits (10 pts)
    max_score += 10
    git_dir = student_dir(student) / ".git"
    if git_dir.exists():
        result = subprocess.run(
            ["git", "-C", str(student_dir(student)), "log", "--oneline"],
            capture_output=True,
            text=True,
        )
        commits = [c for c in result.stdout.strip().split("\n") if c]
        if commits:
            print(ok("Git commits", f"{len(commits)} commits"))
            score += 10
        else:
            print(fail("Git commits", "no commits"))
            issues.append("No git commits")
    else:
        print(warn("Git commits", "no git repo in student directory"))
        score += 5
        issues.append("No git repository")

    # Check 9: Self-assessment filled (10 pts)
    max_score += 10
    self_assess = 0
    for f in pdir.rglob("*.md"):
        text = f.read_text()
        if "Total:" in text and any(ch.isdigit() for ch in text.split("Total:")[1].split("\n")[0]):
            self_assess += 1
    if self_assess > 0:
        print(ok("Self-assessment", "filled"))
        score += 10
    else:
        print(warn("Self-assessment", "not filled"))
        issues.append("Self-assessment not completed")

    # Check 10: Code quality (10 pts)
    max_score += 10
    has_shebang = False
    has_comments = False
    for shfile in sh_files:
        lines = shfile.read_text().splitlines()
        if lines and lines[0].startswith("#!"):
            has_shebang = True
        if any(l.strip().startswith("#") for l in lines):
            has_comments = True
    for pyfile in py_files:
        text = pyfile.read_text()
        if "#" in text or '"""' in text:
            has_comments = True

    if has_shebang and has_comments:
        print(ok("Code quality", "shebangs + comments"))
        score += 10
    elif has_comments:
        print(ok("Code quality", "has comments"))
        score += 7
    else:
        print(warn("Code quality", "no comments found"))
        score += 3

    # Summary
    print()
    pct = (score * 100 // max_score) if max_score > 0 else 0
    if pct >= 80:
        grade = f"{Colors.GREEN}PASS{Colors.RESET}"
    elif pct >= 60:
        grade = f"{Colors.YELLOW}REVIEW{Colors.RESET}"
    else:
        grade = f"{Colors.RED}FAIL{Colors.RESET}"

    print(f"  {Colors.BOLD}Score: {score}/{max_score} ({pct}%) — {grade}{Colors.RESET}")

    if issues:
        print()
        print(f"  {Colors.YELLOW}Issues:{Colors.RESET}")
        for issue in issues:
            print(info(issue))

    print()
    return score, max_score, issues


def run(args: argparse.Namespace) -> int:
    print(header("AUT Linux Camp — Supervisor Evaluation"))
    print()
    print(f"  {Colors.DIM}Camp: {student_dir().parent}{Colors.RESET}")
    print()

    if args.student and args.phase:
        evaluate_phase(args.student, args.phase)
    elif args.student:
        for phase in range(1, total_phases() + 1):
            try:
                evaluate_phase(args.student, phase)
            except Exception as e:
                print(fail(f"Phase {phase}", str(e)))
    else:
        sdir = students_dir()
        if not sdir.exists():
            print(fail("Students directory", "not found"))
            return 1

        for student_path in sorted(sdir.iterdir()):
            if not student_path.is_dir() or student_path.name == "template":
                continue
            student = student_path.name
            print(header(f"Student: {student}"))
            for phase in range(1, total_phases() + 1):
                try:
                    evaluate_phase(student, phase)
                except Exception as e:
                    print(fail(f"Phase {phase}", str(e)))

    print(f"{Colors.DIM}── Evaluation complete ──{Colors.RESET}")
    print()
    return 0
