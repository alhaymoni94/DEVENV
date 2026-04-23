# Lesson 15: Synthetic Data Generation — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Generate realistic synthetic data with Faker
- Use AI to generate custom data scripts
- Evaluate synthetic data quality
- Understand use cases for synthetic data

## Prerequisites

- Phase 4 completed
- Python basics

## Lesson Flow

### Part 1: Faker Library (30 min)

**Cover:**
- What is Faker? (Python library for fake data)
- Providers: names, emails, addresses, companies, dates
- Generating CSV, JSON, SQL

**Demo:**
```bash
pip install faker
e generate.py
```

```python
from faker import Faker
import csv, json

fake = Faker()
with open('users.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['name', 'email', 'phone', 'city'])
    for _ in range(100):
        writer.writerow([fake.name(), fake.email(), fake.phone_number(), fake.city()])
```

### Part 2: AI-Generated Data Scripts (30 min)

**Have students ask AI:**
```bash
ai "generate a Python script that creates synthetic e-commerce data: 1000 orders, 200 customers, 50 products"
```

### Part 3: Data Quality Evaluation (30 min)

**Cover:**
- Checking for duplicates
- Validating formats (emails, dates, phone numbers)
- Analyzing distributions
- Comparing with real data statistics

### Part 4: Use Cases (30 min)

**Discuss:**
- Testing (generate test data)
- ML training (create training datasets)
- Demos (realistic data without privacy concerns)
- Privacy (replace sensitive data with synthetic)

## Assessment

- Students generate data with Faker
- Students use AI for custom data generation
- Students evaluate data quality
