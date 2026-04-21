# Lesson 8: Data Formats in the Terminal — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- View and analyze CSV, JSON, YAML, and XML in the terminal
- Use visidata for interactive data exploration
- Use `jq` for JSON processing
- Render markdown with `glow`
- Understand when to use each tool

## Lesson Flow

### Part 1: CSV with Visidata (30 min)

**Demo:**
```bash
# Create a sample CSV
e ~/data/sample.csv
```

```csv
name,age,city,salary
Alice,30,NYC,70000
Bob,25,LA,60000
Charlie,35,Chicago,80000
```

```bash
# Open in visidata
vd ~/data/sample.csv
```

**Cover visidata basics:**
- Arrow keys to navigate
- `g` to sort ascending, `g` again for descending
- `|` to filter
- `Shift+F` for frequency table
- `:` to enter command mode
- `q` to quit

### Part 2: JSON with jq (30 min)

**Cover:**
- `jq '.'` — pretty print
- `jq '.key'` — extract field
- `jq '.[]'` — iterate array
- `jq 'map(.name)'` — transform

**Demo:**
```bash
echo '{"name":"Alice","age":30}' | jq '.'
echo '{"name":"Alice","age":30}' | jq '.name'
echo '[{"name":"A"},{"name":"B"}]' | jq '.[].name'
```

### Part 3: Markdown with Glow (15 min)

```bash
glow README.md
glow https://github.com/user/repo
```

### Part 4: YAML and Other Formats (15 min)

**Cover:**
- YAML: `cat config.yaml` (human-readable)
- XML: `xmllint --format file.xml`
- TOML: view directly or convert

### Part 5: Hands-On Data Exploration (30 min)

**Exercise:** Give students a real dataset and have them explore it with visidata, jq, and glow.

## Assessment

- Students open a CSV in visidata and perform analysis
- Students extract data from JSON with jq
- Students render a markdown file with glow
