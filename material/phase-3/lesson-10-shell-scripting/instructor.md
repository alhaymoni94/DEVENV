# Lesson 10: Shell Scripting for Automation — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Write robust bash scripts with error handling
- Use variables, loops, conditionals, and functions
- Process command-line arguments
- Schedule scripts with cron
- Debug scripts effectively

## Lesson Flow

### Part 1: Script Basics (20 min)

**Cover:**
- Shebang: `#!/usr/bin/env bash`
- Variables: `name="value"`, `$name`, `${name}`
- Arguments: `$1`, `$2`, `$@`, `$#`
- Exit codes: `$?`, `exit 0`

### Part 2: Conditionals (20 min)

**Cover:**
- `if [ condition ]; then`
- `[[ ]]` vs `[ ]`
- String, number, file comparisons
- `case` statements

### Part 3: Loops (20 min)

**Cover:**
- `for item in list; do`
- `while [ condition ]; do`
- `break`, `continue`
- Reading files: `while IFS= read -r line`

### Part 4: Functions (20 min)

**Cover:**
- Defining functions: `my_func() { }`
- Parameters: `$1`, `$2` inside functions
- Return values: `echo` or `return`
- Scope: `local` variables

### Part 5: Error Handling (20 min)

**Cover:**
- `set -euo pipefail`
- Trap: `trap 'echo "Error on line $LINENO"' ERR`
- Logging functions
- Input validation

### Part 6: Cron & Scheduling (20 min)

**Cover:**
- `crontab -e`
- Cron syntax: `* * * * * command`
- Common patterns
- Logging cron output

## Assessment

- Students write a script with arguments, loops, and error handling
- Students schedule a script with cron
