#!/usr/bin/env python3
"""word-counter.py — Count word frequency in a text file."""
import sys
from collections import Counter
from pathlib import Path


def count_words(filename):
    """Count word frequency in a file."""
    path = Path(filename)
    if not path.exists():
        print(f"Error: {filename} not found", file=sys.stderr)
        sys.exit(1)
    text = path.read_text()
    words = text.lower().split()
    return Counter(words)


def main():
    if len(sys.argv) < 2:
        print("Usage: word-counter.py <file>", file=sys.stderr)
        sys.exit(1)
    filename = sys.argv[1]
    counts = count_words(filename)
    print(f"Top 10 words in {filename}:")
    for word, count in counts.most_common(10):
        print(f"  {word}: {count}")


if __name__ == "__main__":
    main()
