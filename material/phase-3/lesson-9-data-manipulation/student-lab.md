# Lesson 9: Data Manipulation with AI — Student Lab

## Duration: 2 hours

---

## Exercise 1: Clean Messy Data (25 min)

**Task:** Use AI to clean a messy dataset.

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

```bash
# Ask AI to clean it
cat ~/data/messy-sales.csv | ai "clean this CSV: fix dates, normalize product names, handle missing values, remove $ from prices"
```

**Save the cleaned version:**
```bash
cat ~/data/messy-sales.csv | ai "clean this CSV..." > ~/data/clean-sales.csv
```

---

## Exercise 2: Format Conversion (25 min)

**Task:** Convert data between formats using AI.

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

```bash
# JSON to CSV
cat ~/data/products.json | ai "convert to CSV" > ~/data/products.csv

# CSV to SQL INSERT statements
cat ~/data/products.csv | ai "convert to SQL INSERT statements for a products table" > ~/data/products.sql

# CSV to YAML
cat ~/data/products.csv | ai "convert to YAML" > ~/data/products.yaml
```

**Verify each conversion:**
```bash
cat ~/data/products.csv
cat ~/data/products.sql
cat ~/data/products.yaml
```

---

## Exercise 3: Generate Analysis Scripts (30 min)

**Task:** Use AI to write data analysis scripts.

```bash
# Ask AI to write a Python analysis script
ai "write a Python script that reads clean-sales.csv and:
1. Shows total revenue per product
2. Finds the top customer by total spend
3. Shows daily sales trend
Save it as ~/data/analyze-sales.py"
```

**Run the script:**
```bash
e ~/data/analyze-sales.py
# Review the code
python ~/data/analyze-sales.py
```

**Ask AI to extend it:**
```bash
cat ~/data/analyze-sales.py | ai "add a function that exports results to JSON"
```

---

## Exercise 4: Natural Language to SQL (20 min)

**Task:** Generate SQL queries from natural language.

```bash
ai "write a SQL query that:
- Creates a table called employees with columns: id, name, department, salary, hire_date
- Inserts 10 sample records
- Finds the average salary per department
- Returns the top 3 earners"
```

**Save and test:**
```bash
ai "..." > ~/data/employees.sql
cat ~/data/employees.sql
```

---

## Exercise 5: Automated Data Pipeline (20 min)

**Task:** Create a script that automates a data workflow.

```bash
e ~/data/pipeline.sh
```

Ask AI to help:
```bash
ai "write a bash script that:
1. Downloads a CSV file from a URL (use a sample URL)
2. Cleans it using the commands we learned
3. Converts it to JSON
4. Runs analysis on it
5. Saves the results to a report file"
```

**Make it executable and test:**
```bash
chmod +x ~/data/pipeline.sh
bash ~/data/pipeline.sh
```

---

## Bonus Challenges

1. **Use visidata + AI together:** Open data in visidata, identify issues, ask AI to fix them
2. **Create a dashboard:** Generate a markdown report with your analysis results
3. **Schedule a pipeline:** Use `cron` to run your data pipeline daily
4. **Handle large files:** Test your pipeline with a 1000+ row CSV file

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can clean messy data with AI
- [ ] I can convert between CSV, JSON, YAML, and SQL
- [ ] I can generate analysis scripts with AI
- [ ] I can write SQL queries from natural language
- [ ] I can create an automated data pipeline

**Total: ___ / 25**

---

## Next

Lesson 10: Shell Scripting for Automation
