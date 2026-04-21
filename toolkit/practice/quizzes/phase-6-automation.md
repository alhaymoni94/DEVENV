# Phase 6: Automation Quiz

Q: What does a shebang line do?
A: Tells the system which interpreter to use

Q: What does set -euo pipefail do?
A: Exit on error, undefined vars, pipe failures

Q: How do you trap errors in a bash script?
A: trap 'echo "Error on line $LINENO"' ERR

Q: How do you check if a command exists in a script?
A: command -v command-name

Q: How do you get the current disk usage percentage?
A: df -h / | awk 'NR==2{print $5}'

Q: How do you create a timestamped directory name?
A: $(date +%Y%m%d_%H%M%S)

Q: What command opens the cron editor?
A: crontab -e

Q: What cron pattern runs every hour?
A: 0 * * * *

Q: What cron pattern runs Monday at 9am?
A: 0 9 * * 1

Q: How do you list current cron jobs?
A: crontab -l

Q: How do you redirect both stdout and stderr to a log file?
A: command >> logfile 2>&1

Q: How do you find and delete files older than 7 days?
A: find /path -type f -mtime +7 -delete

Q: How do you check if a directory exists in bash?
A: if [ -d "/path" ]; then

Q: How do you check if a file exists in bash?
A: if [ -f "/path" ]; then

Q: How do you get the size of a directory?
A: du -sh /path

Q: How do you create a tar.gz archive?
A: tar -czf archive.tar.gz /path

Q: How do you extract a tar.gz archive?
A: tar -xzf archive.tar.gz

Q: What command shows running tmux sessions?
A: tmux ls

Q: How do you start a detached tmux session?
A: tmux new -d -s name

Q: How do you count running Docker containers?
A: docker ps -q | wc -l
