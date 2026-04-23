# Lesson 18: Workspace Automation — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Write diagnostic scripts for their environment
- Automate daily setup tasks
- Create backup automation
- Schedule scripts with cron
- Build custom workflow scripts

## Prerequisites

- All previous phases completed
- Comfortable with bash scripting

## Lesson Flow

### Part 1: Environment Diagnostics (25 min)

**Demo creating an env-doctor script:**
```bash
e ~/bin/env-doctor.sh
```

Cover checking tools, disk, RAM, git config, running services.

### Part 2: Daily Setup Script (25 min)

**Demo:**
```bash
e ~/bin/daily-setup.sh
```

Cover: disk cleanup, tmux session creation, container status, calendar.

### Part 3: Backup Automation (25 min)

**Demo:**
```bash
e ~/bin/auto-backup.sh
```

Cover: dotfiles backup, project backup, data backup, cleanup old backups.

### Part 4: Cron Scheduling (20 min)

**Cover:**
- `crontab -e`
- Syntax: `* * * * * command`
- Common patterns
- Logging output

### Part 5: Custom Workflow Script (25 min)

**Have students create their most-needed automation script.**

## Assessment

- Students write diagnostic scripts
- Students automate daily tasks
- Students create backup automation
- Students schedule with cron
