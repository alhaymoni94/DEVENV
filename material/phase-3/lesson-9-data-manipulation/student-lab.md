# Lesson 9: Data Manipulation — Student Lab

## Duration: 2 hours

> **AI optional:** Every exercise has a non-AI path using visidata, jq, Python, and manual techniques.

---

## Exercise 1: Clean Messy Data (25 min)

**Task:** Clean a messy dataset.

First, create the data:
```bash
e ~/data/messy-sales.csv
```

Add:
```csv
date,product,quantity,price,customer
2024-01-15 , Widget A , 10, $25.00 ,Alice Smith
 2024-01-16,widget b,5,$30.00,Bob Jones
2024/01/17, Widget A ,20, 25.00,Charlie Brown
, Widget C , 8,$45.00,
2024-01-19,Widget A,, $25.00 ,Eve Wilson
2024-01-20, widget b ,15,$30.00,Frank Miller
```

**With AI:**
```bash
cat ~/data/messy-sales.csv | ai "clean this CSV: fix dates, normalize product names, handle missing values, remove $ from prices"
```

**Without AI 🧠:**
```bash
# Open in visidata and clean interactively
vd ~/data/messy-sales.csv
# In visidata:
#   - Strip whitespace: select column, press `|`, type strip formula
#   - Normalize case: press `~` to lower/upper case
#   - Handle missing: press `gz` to set nulls
#   - Save: press `Ctrl+S`

# Or use command-line tools:
# Remove $ signs and spaces, normalize dates
sed 's/[$ ]//g' ~/data/messy-sales.csv | \
  sed 's/widget b/Widget B/gi' | \
  sed 's/^2024\//2024-/' > ~/data/clean-sales.csv
```

**Save the cleaned version** as `~/data/clean-sales.csv`.

---

## Exercise 2: Format Conversion (25 min)

**Task:** Convert data between formats.

```bash
# Create a JSON file
e ~/data/products.json
```

Add:
```json
[
  {"id": 1, "name": "Widget A", "price": 25, "category": "widgets"},
  {"id": 2, "name": "Widget B", "price": 30, "category": "widgets"},
  {"id": 3, "name": "Gadget C", "price": 45, "category": "gadgets"}
]
```

**With AI:**
```bash
cat ~/data/products.json | ai "convert to CSV" > ~/data/products.csv
cat ~/data/products.csv | ai "convert to SQL INSERT statements" > ~/data/products.sql
cat ~/data/products.csv | ai "convert to YAML" > ~/data/products.yaml
```

**Without AI 🧠:**
```bash
# JSON to CSV using jq
cat ~/data/products.json | jq -r '.[] | [.id, .name, .price, .category] | @csv' > ~/data/products.csv

# Add header
echo "id,name,price,category" | cat - ~/data/products.csv > /tmp/products.csv
mv /tmp/products.csv ~/data/products.csv

# CSV to SQL manually (or with a small Python script)
cat > ~/data/products.sql << 'EOF'
CREATE TABLE products (id INT, name VARCHAR(50), price INT, category VARCHAR(50));
INSERT INTO products (id, name, price, category) VALUES
  (1, 'Widget A', 25, 'widgets'),
  (2, 'Widget B', 30, 'widgets'),
  (3, 'Gadget C', 45, 'gadgets');
EOF

# YAML conversion with Python
python3 -c "
import json, yaml
with open('~/data/products.json') as f:
    data = json.load(f)
with open('~/data/products.yaml', 'w') as f:
    yaml.dump(data, f)
"
```

**Verify each conversion:**
```bash
cat ~/data/products.csv
cat ~/data/products.sql
cat ~/data/products.yaml
```

---

## Exercise 3: Analysis Scripts (30 min)

**Task:** Write a data analysis script.

**With AI:**
```bash
ai "write a Python script that reads clean-sales.csv and:
1. Shows total revenue per product
2. Finds the top customer by total spend
3. Shows daily sales trend
Save it as ~/data/analyze-sales.py"
```

**Without AI 🧠:**
```bash
# Use visidata to explore first:
vd ~/data/clean-sales.csv

# Then write the script manually:
e ~/data/analyze-sales.py
```

Write a script that:
1. Reads `clean-sales.csv`
2. Calculates total revenue per product
3. Finds the top customer by spend
4. Shows daily sales trend

**Hint:** Use Python's `csv` module and dictionaries to aggregate data.

**Run the script:**
```bash
python3 ~/data/analyze-sales.py
```

---

## Exercise 4: SQL Queries (20 min)

**Task:** Write SQL for an employees table.

**With AI:**
```bash
ai "write a SQL query that:
- Creates a table called employees with columns: id, name, department, salary, hire_date
- Inserts 10 sample records
- Finds the average salary per department
- Returns the top 3 earners"
```

**Without AI 🧠:**
```bash
e ~/data/employees.sql
```

Write the SQL yourself:
```sql
CREATE TABLE employees (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  department VARCHAR(50),
  salary INT,
  hire_date DATE
);

INSERT INTO employees VALUES
  (1, 'Alice', 'Engineering', 95000, '2020-01-15'),
  (2, 'Bob', 'Marketing', 65000, '2021-03-22'),
  -- add 8 more...

SELECT department, AVG(salary) FROM employees GROUP BY department;

SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
```

---

## Exercise 5: Automated Data Pipeline (20 min)

**Task:** Create a script that automates a data workflow.

```bash
e ~/data/pipeline.sh
```

**With AI:**
```bash
ai "write a bash script that:
1. Downloads a CSV file from a URL (use a sample URL)
2. Cleans it using sed/awk
3. Converts it to JSON using jq
4. Runs analysis
5. Saves results to a report file"
```

**Without AI 🧠:**
Write the pipeline yourself:
```bash
#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/datasets/iris/main/data/iris.csv"
RAW="/tmp/raw-data.csv"
CLEAN="/tmp/clean-data.csv"
REPORT="~/data/report.txt"

echo "Downloading..."
curl -s "$URL" > "$RAW"

echo "Cleaning..."
# Remove header, trim spaces, convert to lowercase
sed '1d' "$RAW" | sed 's/ //g' | tr '[:upper:]' '[:lower:]' > "$CLEAN"

echo "Analyzing..."
# Count rows, find average of first numeric column
ROWS=$(wc -l < "$CLEAN")
AVG=$(awk -F',' '{sum+=$1; count++} END {printf "%.2f", sum/count}' "$CLEAN")

echo "Report generated $(date)" > "$REPORT"
echo "Rows: $ROWS" >> "$REPORT"
echo "Average: $AVG" >> "$REPORT"

echo "Done. Report: $REPORT"
```

**Make it executable and test:**
```bash
chmod +x ~/data/pipeline.sh
bash ~/data/pipeline.sh
```

---

## Bonus Challenges

1. **Clean with visidata:** Open messy data, identify issues visually, fix them
2. **Create a dashboard:** Write a markdown report with your analysis results
3. **Schedule a pipeline:** Use `cron` to run your data pipeline daily
4. **Handle large files:** Test your pipeline with a 1000+ row CSV

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-3/lesson-9-data-manipulation/`:

| File | Description |
|------|-------------|
| `clean-sales.csv` | Cleaned sales data (Exercise 1) |
| `products.csv` | CSV conversion (Exercise 2) |
| `products.sql` | SQL INSERT statements (Exercise 2) |
| `products.yaml` | YAML conversion (Exercise 2) |
| `analyze-sales.py` | Sales analysis script (Exercise 3) |
| `employees.sql` | SQL queries (Exercise 4) |
| `pipeline.sh` | Automated data pipeline (Exercise 5) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can clean messy data (with AI or visidata/sed)
- [ ] I can convert between CSV, JSON, YAML, and SQL
- [ ] I can write analysis scripts (with AI or manually)
- [ ] I can write SQL queries
- [ ] I can create an automated data pipeline

**Total: ___ / 25**

---

## Next

Lesson 10: Shell Scripting for Automation
