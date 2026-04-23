# Lesson 15: Synthetic Data Generation — Student Lab

## Duration: 2 hours

---

## Exercise 1: Generate Data with Faker (30 min)

```bash
# Install faker
pip install faker

e ~/data/generate-users.py
```

Add:
```python
from faker import Faker
import csv
import json

fake = Faker()

# Generate CSV
with open('users.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['name', 'email', 'phone', 'address', 'company'])
    for _ in range(100):
        writer.writerow([
            fake.name(),
            fake.email(),
            fake.phone_number(),
            fake.address().replace('\n', ', '),
            fake.company()
        ])

# Generate JSON
users = []
for _ in range(100):
    users.append({
        'name': fake.name(),
        'email': fake.email(),
        'phone': fake.phone_number(),
        'address': fake.address(),
        'company': fake.company()
    })

with open('users.json', 'w') as f:
    json.dump(users, f, indent=2)

print("Generated 100 users in CSV and JSON")
```

```bash
python ~/data/generate-users.py
vd ~/data/users.csv
```

---

## Exercise 2: AI-Generated Synthetic Data (30 min)

```bash
ai "generate a Python script that creates synthetic e-commerce data:
- 1000 orders
- 200 customers
- 50 products
- Realistic dates, prices, quantities
- Save as orders.csv, customers.csv, products.csv"
```

**Run the generated script and explore:**
```bash
vd orders.csv
vd customers.csv
```

---

## Exercise 3: Data Quality Evaluation (30 min)

**Task:** Evaluate synthetic data quality.

```bash
ai "write a Python script that evaluates synthetic data quality:
1. Check for duplicate records
2. Validate email formats
3. Check date ranges
4. Analyze value distributions
5. Compare with real data statistics (if available)
Run it on the generated e-commerce data"
```

---

## Exercise 4: Use Cases (30 min)

**Discuss and practice:**
1. **Testing:** Generate test data for your applications
2. **ML Training:** Create training datasets
3. **Demo Data:** Build realistic demos without real data
4. **Privacy:** Replace sensitive data with synthetic equivalents

```bash
ai "generate a script that takes a real CSV file and creates a synthetic version that preserves:
1. Column types and formats
2. Value distributions
3. Relationships between columns
But replaces all actual values with synthetic ones"
```

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can generate synthetic data with Faker
- [ ] I can use AI to generate custom data scripts
- [ ] I can evaluate synthetic data quality
- [ ] I understand use cases for synthetic data

**Total: ___ / 20**

---

## Next

Lesson 16: AI Models Management
