# Phase 3: Data & Scripting Quiz

Q: What command opens a CSV in visidata?
A: vd file.csv

Q: How do you sort by a column in visidata?
A: Move to column, press `g` (or `g` again for descending)

Q: What command pretty-prints JSON?
A: jq '.'

Q: How do you extract a specific field from JSON?
A: jq '.field_name'

Q: How do you filter JSON array elements?
A: jq '.[] | select(.age > 25)'

Q: What command renders markdown in the terminal?
A: glow file.md

Q: What does `set -euo pipefail` do in bash?
A: Exit on error, undefined vars, pipe failures

Q: How do you make a script executable?
A: chmod +x script.sh

Q: What is the shebang line for bash scripts?
A: #!/usr/bin/env bash

Q: How do you schedule a script to run daily at 2am?
A: 0 2 * * * /path/to/script.sh

Q: How do you check if a file exists in bash?
A: if [ -f "/path" ]; then

Q: How do you create a timestamped directory name?
A: $(date +%Y%m%d_%H%M%S)

Q: How do you redirect both stdout and stderr to a file?
A: command >> logfile 2>&1

Q: What command lists current cron jobs?
A: crontab -l

Q: How do you open the cron editor?
A: crontab -e
