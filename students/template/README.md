# Student Workspace Template

## Directory Structure

```
students/
├── template/              ← Copy this for each student
│   ├── phase-1/           ← Foundations (4 lessons)
│   │   ├── lesson-1/      ← Lab solutions go here
│   │   ├── lesson-2/
│   │   ├── lesson-3/
│   │   └── lesson-4/
│   ├── phase-2/           ← Dev Environment (3 lessons)
│   │   ├── lesson-5/
│   │   ├── lesson-6/
│   │   └── lesson-7/
│   ├── phase-3/           ← Data & AI (3 lessons)
│   │   ├── lesson-8/
│   │   ├── lesson-9/
│   │   └── lesson-10/
│   ├── phase-4/           ← Containers & AI (3 lessons)
│   │   ├── lesson-11/
│   │   ├── lesson-12/
│   │   └── lesson-13/
│   └── projects/          ← Personal projects
├── student-name-1/
├── student-name-2/
└── ...
```

## Setup for a New Student

```bash
# Copy template
cp -r students/template students/student-name

# Initialize git
cd students/student-name
git init
git add -A
git commit -m "init: student workspace"
```

## What Students Submit

After each lesson, students should have:
1. Completed lab exercises in their workspace
2. Self-assessment scores filled in
3. Any bonus challenges attempted

## Instructor Review

```bash
# Check a student's work
cd students/student-name/phase-1/lesson-1

# Run their scripts
bash ~/bin/largest-files.sh

# Check git history
git log --oneline

# Review code quality
e greet.py
```
