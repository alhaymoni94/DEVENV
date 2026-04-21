# Lesson 9: Data Manipulation with AI — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Use AI to clean and transform data
- Convert between data formats using AI
- Generate data analysis scripts with AI
- Automate repetitive data tasks

## Lesson Flow

### Part 1: AI-Powered Data Cleaning (30 min)

**Demo:**
```bash
# Create messy data
e ~/data/messy.csv
```

```csv
name,age,city
 Alice ,30, NYC
Bob, twenty-five,LA
Charlie,35, Chicago 
,40,NYC
Eve,28,
```

```bash
# Ask AI to clean it
cat ~/data/messy.csv | ai "clean this CSV data: fix whitespace, handle missing values, normalize age format"
```

### Part 2: Format Conversion (30 min)

**Cover:**
- JSON ↔ CSV
- XML ↔ JSON
- SQL queries from natural language

**Demo:**
```bash
# JSON to CSV
cat data.json | ai "convert this JSON to CSV"

# CSV to SQL INSERT statements
cat data.csv | ai "convert this CSV to SQL INSERT statements"

# Natural language to SQL
ai "write a SQL query that finds the top 3 earners per department"
```

### Part 3: Data Analysis Scripts (30 min)

**Have students practice:**
```bash
ai "write a Python script that reads employees.csv and:
1. Calculates average salary per department
2. Finds the highest paid employee
3. Creates a bar chart of salaries by city"
```

### Part 4: Automation (30 min)

**Cover:**
- Writing scripts that process data automatically
- Scheduling with cron
- Logging and error handling

## Assessment

- Students clean messy data with AI
- Students convert between formats
- Students generate and run an analysis script
