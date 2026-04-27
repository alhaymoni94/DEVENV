#!/usr/bin/env bash
# give-camp.sh — Create a clean distributable archive of AUT Linux Camp
# Usage: bash toolkit/give-camp.sh [output-name]
#
# Creates a tar.gz archive with personal data removed:
# - Student workspaces (keeps template/)
# - Setup config (contains API keys, personal info)
# - Cache files, build artifacts
# - IDE configs
#
# The recipient runs:
#   tar xzf AUT-Linux-Camp-YYYYMMDD.tar.gz
#   cd AUT-Linux-Camp
#   bash toolkit/setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CAMP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BASENAME="$(basename "$CAMP_DIR")"

# Default output name includes date
DEFAULT_OUTPUT="${BASENAME}-$(date +%Y%m%d).tar.gz"
OUTPUT="${1:-$DEFAULT_OUTPUT}"
OUTPUT="$(cd "$(dirname "$OUTPUT")" && pwd)/$(basename "$OUTPUT")"

# Create temp staging directory
TMPDIR=$(mktemp -d)
STAGE="$TMPDIR/$BASENAME"

echo ""
echo "Creating clean archive..."
echo "  Source:  $CAMP_DIR"
echo "  Output:  $OUTPUT"
echo ""

# Copy everything to staging
cp -r "$CAMP_DIR" "$STAGE"

echo "  Cleaning personal data..."

# Remove student workspaces except template
if [ -d "$STAGE/students" ]; then
  for dir in "$STAGE/students"/*; do
    if [ -d "$dir" ] && [ "$(basename "$dir")" != "template" ]; then
      rm -rf "$dir"
      echo "    Removed: students/$(basename "$dir")/"
    fi
  done
fi

# Remove personal config
if [ -f "$STAGE/toolkit/.setup-config" ]; then
  rm -f "$STAGE/toolkit/.setup-config"
  echo "    Removed: toolkit/.setup-config"
fi

# Remove git history (optional — comment out to keep)
if [ -d "$STAGE/.git" ]; then
  rm -rf "$STAGE/.git"
  echo "    Removed: .git/"
fi

# Remove cache and build artifacts
find "$STAGE" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find "$STAGE" -type f -name "*.pyc" -delete 2>/dev/null || true
find "$STAGE" -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
find "$STAGE" -type f -name ".coverage" -delete 2>/dev/null || true

# Remove IDE configs
rm -rf "$STAGE/.opencode" 2>/dev/null || true
rm -f "$STAGE/claude-code-latest.txt" 2>/dev/null || true
rm -f "$STAGE/scanned_document.pdf" 2>/dev/null || true

# Create archive from staging
cd "$TMPDIR"
tar czf "$OUTPUT" "$BASENAME"

# Cleanup
rm -rf "$TMPDIR"

# Verify
SIZE=$(du -h "$OUTPUT" | awk '{print $1}')
FILE_COUNT=$(tar tzf "$OUTPUT" | wc -l)

echo ""
echo "Archive created:"
echo "  File:  $OUTPUT"
echo "  Size:  $SIZE"
echo "  Files: $FILE_COUNT"
echo ""
echo "Excluded from archive:"
echo "  - Student workspaces (personal work)"
echo "  - toolkit/.setup-config (API keys, personal settings)"
echo "  - Git history (edit script to keep)"
echo "  - Cache/build artifacts (__pycache__, *.pyc, .pytest_cache)"
echo ""
echo "Recipient instructions:"
echo "  1. Extract:  tar xzf $(basename "$OUTPUT")"
echo "  2. Enter:    cd $BASENAME"
echo "  3. Setup:    bash toolkit/setup.sh"
echo "  4. Start:    camp next"
echo ""
