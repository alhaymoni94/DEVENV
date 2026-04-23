# Lesson 8: Data Formats in the Terminal — Student Lab

## Duration: 2 hours

---

## Exercise 1: CSV with Visidata (30 min)

**Task:** Create and explore a dataset.

```bash
mkdir -p ~/data
e ~/data/employees.csv
```

Add:
```csv
name,department,salary,years,city
Alice,Engineering,95000,5,NYC
Bob,Marketing,65000,3,LA
Charlie,Engineering,105000,8,Chicago
Diana,Sales,70000,2,NYC
Eve,Marketing,72000,4,SF
Frank,Engineering,110000,10,NYC
Grace,Sales,68000,1,LA
Henry,Engineering,98000,6,Chicago
```

```bash
# Open in visidata
vd ~/data/employees.csv
```

**Tasks inside visidata:**
1. Sort by salary (descending): move to salary column, press `g`
2. Filter to Engineering only: press `|`, type `Engineering`
3. Show frequency of cities: press `Shift+F` on city column
4. Calculate average salary: press `:` then `aggregate sum salary`
5. Save as JSON: press `:` then `save employees.json`

---

## Exercise 2: JSON with jq (30 min)

**Task:** Process JSON data.

```bash
# Create a JSON file
e ~/data/users.json
```

Add:
```json
[
  {"name": "Alice", "age": 30, "city": "NYC", "skills": ["Python", "Go"]},
  {"name": "Bob", "age": 25, "city": "LA", "skills": ["JS", "React"]},
  {"name": "Charlie", "age": 35, "city": "Chicago", "skills": ["Python", "Rust"]}
]
```

```bash
# Pretty print
cat ~/data/users.json | jq '.'

# Get all names
cat ~/data/users.json | jq '.[].name'

# Get names and cities
cat ~/data/users.json | jq '.[] | {name, city}'

# Filter: age > 28
cat ~/data/users.json | jq '.[] | select(.age > 28)'

# Get all skills flattened
cat ~/data/users.json | jq '.[].skills[]'

# Count users per city
cat ~/data/users.json | jq 'group_by(.city) | map({city: .[0].city, count: length})'
```

---

## Exercise 3: Markdown with Glow (15 min)

```bash
# Render a local file
glow ~/Documents/AUT-Linux-Camp/toolkit/GETTING_STARTED.md

# Render from a URL
glow https://github.com/saulpw/visidata
```

---

## Exercise 4: Data Pipeline Challenge (30 min)

**Task:** Build a pipeline that converts CSV → JSON → analysis.

```bash
# 1. Open the employees CSV in visidata
vd ~/data/employees.csv

# 2. Save as JSON
# Press : then "save employees.json"

# 3. Process with jq
cat ~/data/employees.json | jq 'map(select(.salary > 80000)) | .[].name'

# 4. Count employees per department
cat ~/data/employees.json | jq 'group_by(.department) | map({dept: .[0].department, count: length})'

# 5. Average salary per department
cat ~/data/employees.json | jq 'group_by(.department) | map({dept: .[0].department, avg_salary: (map(.salary) | add / length)})'
```

---

## Bonus Challenges

1. **Download a real dataset** from Kaggle and explore it with visidata
2. **Convert JSON to CSV** using jq
3. **Create a markdown report** from your data analysis
4. **Use AI to generate** a jq query for a complex transformation

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-3/lesson-8-data-formats/`:

| File | Description |
|------|-------------|
| `employees.json` | JSON export from visidata (Exercise 1) |
| `data-analysis.md` | Markdown report from bonus challenge (optional) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can open and navigate CSV files in visidata
- [ ] I can sort, filter, and aggregate data in visidata
- [ ] I can extract data from JSON with jq
- [ ] I can filter and transform JSON data
- [ ] I can render markdown with glow
- [ ] I can build a data pipeline (CSV → JSON → analysis)

**Total: ___ / 30**

---

## Next

Lesson 9: Data Manipulation with AI
