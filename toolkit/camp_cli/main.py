#!/usr/bin/env python3
"""camp — AUT Linux Camp CLI entry point."""
import argparse
import sys

from camp_cli.common import Colors, header
from camp_cli.commands import next as next_cmd
from camp_cli.commands import progress as progress_cmd
from camp_cli.commands import submit as submit_cmd
from camp_cli.commands import evaluate as evaluate_cmd


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="camp",
        description="AUT Linux Camp — Terminal training management CLI",
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    # next
    p_next = subparsers.add_parser("next", help="Show what to work on next")
    p_next.set_defaults(func=next_cmd.run)

    # progress
    p_progress = subparsers.add_parser("progress", help="View student progress")
    p_progress.set_defaults(func=progress_cmd.run)

    # submit
    p_submit = subparsers.add_parser("submit", help="Submit a phase for review")
    p_submit.add_argument("phase", type=int, help="Phase number to submit")
    p_submit.set_defaults(func=submit_cmd.run)

    # evaluate
    p_eval = subparsers.add_parser("evaluate", help="Evaluate student work (supervisor)")
    p_eval.add_argument("student", nargs="?", help="Student name (default: all)")
    p_eval.add_argument("phase", nargs="?", type=int, help="Phase number (default: all)")
    p_eval.set_defaults(func=evaluate_cmd.run)

    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
