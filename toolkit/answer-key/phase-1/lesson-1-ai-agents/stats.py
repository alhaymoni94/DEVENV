#!/usr/bin/env python3
"""stats.py — Count words, lines, and characters in a text file."""
import sys
from pathlib import Path


def count_stats(filename):
    path = Path(filename)
    if not path.exists():
        print(f"Error: {filename} not found", file=sys.stderr)
        sys.exit(1)
    text = path.read_text()
    lines = text.splitlines()
    words = text.split()
    return len(lines), len(words), len(text)


def main():
    if len(sys.argv) < 2:
        print("Usage: stats.py <file>", file=sys.stderr)
        sys.exit(1)
    filename = sys.argv[1]
    lines, words, chars = count_stats(filename)
    print(f"Lines:   {lines:>8}")
    print(f"Words:   {words:>8}")
    print(f"Chars:   {chars:>8}")


if __name__ == "__main__":
    main()
