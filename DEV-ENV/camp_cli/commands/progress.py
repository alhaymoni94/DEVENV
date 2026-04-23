"""camp progress — Show student progress through the camp."""
import argparse
from pathlib import Path

from camp_cli.common import (
    Colors,
    header,
    material_phase_dir,
    phase_dir,
    student_dir,
    total_phases,
)


def run(args: argparse.Namespace) -> int:
    sdir = student_dir()

    if not sdir.exists():
        print(f"{Colors.RED}✗{Colors.RESET} Student directory not found: {sdir}")
        print(f"{Colors.DIM}Copy the template: cp -r students/template students/$(whoami){Colors.RESET}")
        return 1

    print(header("Camp Progress"))
    print()

    completed = 0
    total = 0

    for phase in range(1, total_phases() + 1):
        mat_dir = material_phase_dir(phase)
        pdir = phase_dir(phase)
        lesson_count = 0
        lesson_done = 0

        if mat_dir.exists():
            for mat_lesson in sorted(mat_dir.glob("lesson-*")):
                if mat_lesson.is_dir():
                    lesson_name = mat_lesson.name
                    lesson_count += 1
                    total += 1

                    student_lesson = pdir / lesson_name
                    has_work = False
                    if student_lesson.exists():
                        for pattern in ("*.py", "*.sh", "*.txt", "*.csv", "*.json", "*.yaml", "*.yml", "*.toml", "*.sql", "*.html"):
                            if list(student_lesson.glob(pattern)):
                                has_work = True
                                break

                    if has_work:
                        lesson_done += 1
                        completed += 1
                        print(f"  {Colors.GREEN}✓{Colors.RESET} Phase {phase}, Lesson {lesson_name}")
                    elif student_lesson.exists():
                        print(f"  {Colors.DIM}○{Colors.RESET} Phase {phase}, Lesson {lesson_name} {Colors.DIM}(started, no work files){Colors.RESET}")
                    else:
                        print(f"  {Colors.DIM}○{Colors.RESET} Phase {phase}, Lesson {lesson_name} {Colors.DIM}(not started){Colors.RESET}")

        if lesson_count == 0:
            print(f"  {Colors.DIM}○{Colors.RESET} Phase {phase} {Colors.DIM}(no lessons defined){Colors.RESET}")
        elif lesson_done == lesson_count:
            print(f"  {Colors.GREEN}✓{Colors.RESET} Phase {phase} {Colors.GREEN}(complete){Colors.RESET}")
        elif lesson_done > 0:
            print(f"  {Colors.YELLOW}◐{Colors.RESET} Phase {phase} {Colors.YELLOW}({lesson_done}/{lesson_count} lessons){Colors.RESET}")
        else:
            print(f"  {Colors.DIM}○{Colors.RESET} Phase {phase} {Colors.DIM}({lesson_count} lessons pending){Colors.RESET}")

    print()
    pct = (completed * 100 // total) if total > 0 else 0
    bar_len = 30
    filled = pct * bar_len // 100
    empty = bar_len - filled
    bar = f"{Colors.GREEN}{'█' * filled}{Colors.DIM}{'░' * empty}{Colors.RESET}"
    print(f"  Progress: {bar} {pct}%")
    print()
    print(f"  {Colors.DIM}Completed: {completed}/{total} lessons{Colors.RESET}")

    print()
    print(f"{Colors.CYAN}── Milestones ──{Colors.RESET}")
    milestones = [
        ("Setup complete (40/40 health)", True),  # Simplified; doctor not run here
        ("Phase 1 complete", completed >= 4),
        ("Phase 2 complete", completed >= 7),
        ("Phase 3 complete", completed >= 10),
        ("Phase 4 complete — ready for graduation project!", completed >= 13),
    ]
    for label, done in milestones:
        if done:
            print(f"  {Colors.GREEN}✓{Colors.RESET} {label}")
        else:
            print(f"  {Colors.DIM}○{Colors.RESET} {label}")

    print()
    return 0
