"""camp next — Show what the student should work on next."""
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

    print(header("What's Next?"))
    print()

    if not sdir.exists():
        print(f"{Colors.YELLOW}!{Colors.RESET} Student directory not found.")
        print()
        print(f"{Colors.DIM}Setup your workspace:{Colors.RESET}")
        print(f"  {Colors.GREEN}cp -r students/template students/$(whoami){Colors.RESET}")
        print()
        print(f"{Colors.DIM}Then start with:{Colors.RESET}")
        print(f"  {Colors.GREEN}bash toolkit/setup.sh{Colors.RESET}")
        return 0

    next_found = False
    for phase in range(1, total_phases() + 1):
        mat_dir = material_phase_dir(phase)
        if not mat_dir.exists():
            continue

        for lesson_material in sorted(mat_dir.glob("lesson-*")):
            lesson_name = lesson_material.name
            lesson_dir = phase_dir(phase) / lesson_name

            has_work = False
            if lesson_dir.exists():
                for pattern in ("*.py", "*.sh", "*.csv", "*.json"):
                    if list(lesson_dir.glob(pattern)):
                        has_work = True
                        break

            if not has_work and not next_found:
                print(f"{Colors.BOLD}Next: Phase {phase} — {lesson_name}{Colors.RESET}")
                print()
                print(f"{Colors.DIM}Lab file:{Colors.RESET}")
                print(f"  {Colors.GREEN}cat material/phase-{phase}/{lesson_name}/student-lab.md{Colors.RESET}")
                print()

                if phase > 1:
                    print(f"{Colors.DIM}Prerequisites:{Colors.RESET}")
                    print(f"  Complete Phase {phase - 1} first")
                    print()

                print(f"{Colors.DIM}Estimated time:{Colors.RESET}")
                estimates = {1: "1.5–2 hours", 2: "1–2 hours", 3: "2 hours", 4: "2 hours"}
                print(f"  {estimates.get(phase, '2 hours')} per lesson")
                print()

                next_found = True

    if not next_found:
        print(f"{Colors.GREEN}✓{Colors.RESET} All phases complete!")
        print()
        print(f"{Colors.BOLD}Next: Graduation Project{Colors.RESET}")
        print()
        print(f"{Colors.DIM}See:{Colors.RESET}")
        print(f"  {Colors.GREEN}cat material/GRADUATION_PROJECT.md{Colors.RESET}")

    return 0
