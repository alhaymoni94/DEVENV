#!/usr/bin/env bash
# evaluate.sh — deprecated wrapper, use: camp evaluate [student] [phase]
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CAMP_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
python3 "$CAMP_DIR/toolkit/scripts/camp" evaluate "$@"
