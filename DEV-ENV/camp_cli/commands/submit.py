"""camp submit — Submit a phase for supervisor review."""
import argparse
import subprocess
from pathlib import Path

from camp_cli.common import Colors, header, phase_dir, student_dir


def run(args: argparse.Namespace) -> int:
    phase = args.phase
    sdir = student_dir()
    pdir = phase_dir(phase)

    print(header(f"Submitting Phase {phase}"))
    print()

    if not sdir.exists():
        print(f"{Colors.RED}✗{Colors.RESET} Student directory not found: {sdir}")
        print(f"{Colors.DIM}Copy the template first: cp -r students/template students/$(whoami){Colors.RESET}")
        return 1

    if not pdir.exists():
        print(f"{Colors.RED}✗{Colors.RESET} Phase {phase} directory not found")
        return 1

    # Check for work files
    work_count = sum(1 for _ in pdir.rglob("*") if _.suffix in {".py", ".sh", ".csv", ".json"})
    if work_count == 0:
        print(f"{Colors.YELLOW}!{Colors.RESET} No work files found in phase {phase}")
        ans = input("Submit anyway? [y/N] ").strip().lower()
        if ans != "y":
            print(f"{Colors.DIM}Submission cancelled.{Colors.RESET}")
            return 0

    # Initialize git if needed
    git_dir = sdir / ".git"
    if not git_dir.exists():
        print(f"{Colors.DIM}Initializing git repository...{Colors.RESET}")
        subprocess.run(["git", "init", str(sdir)], check=True, capture_output=True)

    # Stage all changes first
    subprocess.run(["git", "-C", str(sdir), "add", "-A"], check=True, capture_output=True)

    # Check if there are staged changes to commit
    result = subprocess.run(
        ["git", "-C", str(sdir), "diff", "--cached", "--quiet"],
        capture_output=True,
    )
    if result.returncode == 0:
        print(f"{Colors.YELLOW}!{Colors.RESET} No changes to submit for phase {phase}")
        print(f"{Colors.DIM}Add your work files first, then re-run camp submit.{Colors.RESET}")
        return 0

    subprocess.run(
        ["git", "-C", str(sdir), "commit", "-m", f"submit: phase-{phase} complete"],
        check=True,
        capture_output=True,
    )

    # Push to remote if configured
    remote_result = subprocess.run(
        ["git", "-C", str(sdir), "remote", "get-url", "origin"],
        capture_output=True,
    )
    if remote_result.returncode == 0:
        push_result = subprocess.run(
            ["git", "-C", str(sdir), "push", "origin", "HEAD"],
            capture_output=True,
            text=True,
        )
        if push_result.returncode == 0:
            print(f"{Colors.GREEN}✓{Colors.RESET} Pushed to remote.")
        else:
            print(f"{Colors.YELLOW}!{Colors.RESET} Push failed (local commit still saved).")
            print(f"{Colors.DIM}{push_result.stderr.strip()}{Colors.RESET}")
    else:
        hint_file = sdir / ".git" / ".camp_remote_hint_shown"
        if not hint_file.exists():
            hint_file.touch()
            print()
            print(f"{Colors.YELLOW}!{Colors.RESET} No remote configured. Work saved locally only.")
            print(f"{Colors.DIM}To share with your supervisor:{Colors.RESET}")
            print(f"  git -C {sdir} remote add origin <your-repo-url>")
            print(f"  git -C {sdir} push -u origin HEAD")

    print()
    print(f"{Colors.GREEN}✓{Colors.RESET} Phase {phase} submitted!")
    print(f"{Colors.DIM}Run 'camp progress' to check status.{Colors.RESET}")
    return 0
