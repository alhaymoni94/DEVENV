# Lesson 13: Advanced Development & Automation — Student Lab

## Duration: 2 hours

> **AI optional:** This lesson teaches advanced development skills. Use AI if you have it configured, or write everything manually using skills from previous lessons.

---

## Exercise 1: Tool Check (20 min)

**Task:** Verify your development environment.

```bash
# Check installed tools
python3 --version
docker --version
git --version

# Test Python works
python3 -c "print('Python is ready')"

# Test Docker works (daemon must be running)
docker run --rm hello-world
```

**If AI is configured, also test:**
```bash
ai "what is the difference between supervised and unsupervised learning?"
opencode --version
```

---

## Exercise 2: Build a Text Summarizer (30 min)

**Task:** Create a Python CLI tool that summarizes text files.

**With AI (opencode):**
```bash
mkdir ~/ai-project && cd ~/ai-project
opencode
```
Prompt: "Create a Python CLI tool that takes a text file and shows the top 5 most frequent sentences."

**Without AI 🧠:**
```bash
mkdir ~/dev-project && cd ~/dev-project
e summarize.py
```

Write it yourself:
```python
#!/usr/bin/env python3
"""Simple text summarizer using sentence frequency."""
import sys
import re
from collections import Counter

def summarize(filename, top_n=5):
    with open(filename) as f:
        text = f.read()

    # Split into sentences (basic regex)
    sentences = re.split(r'[.!?]+', text)
    sentences = [s.strip() for s in sentences if len(s.strip()) > 10]

    # Score sentences by word frequency
    words = re.findall(r'\b\w+\b', text.lower())
    word_freq = Counter(words)

    def score(sentence):
        words_in_sentence = re.findall(r'\b\w+\b', sentence.lower())
        return sum(word_freq[w] for w in words_in_sentence)

    ranked = sorted(sentences, key=score, reverse=True)
    return ranked[:top_n]

def main():
    if len(sys.argv) < 2:
        print("Usage: summarize.py <file>")
        sys.exit(1)

    top = summarize(sys.argv[1])
    print("Top sentences:")
    for i, sentence in enumerate(top, 1):
        print(f"  {i}. {sentence}")

if __name__ == "__main__":
    main()
```

**Test it:**
```bash
echo -e "The quick brown fox jumps over the lazy dog.\nPython is a great language for scripting.\nThe fox was very quick and very brown.\nLazy dogs sleep all day.\nScripting with Python makes automation easy." > test.txt
python3 summarize.py test.txt
```

---

## Exercise 3: Code Review (20 min)

**Task:** Review one of your previous scripts for improvements.

**With AI:**
```bash
cat ~/bin/backup.sh | ai "review this script for security, best practices, error handling, and performance"
```

**Without AI 🧠:**
Open your `~/bin/backup.sh` (or any script from Phase 3) and check for:

1. **Security:** Are paths quoted? Is user input validated?
2. **Best practices:** Does it have a shebang? Comments? Usage message?
3. **Error handling:** Does it use `set -euo pipefail`? Does it check if files exist?
4. **Performance:** Are there unnecessary commands? Can pipes be reduced?

**Use the checklist:**
```bash
cheat shell | grep -A5 "scripting"
```

**Apply improvements** and save as `backup-v2.sh`.

---

## Exercise 4: Data Analysis Pipeline (20 min)

**Task:** Build a script that generates and analyzes data.

**With AI:**
```bash
ai "write a Python script that generates 1000 rows of synthetic customer data, saves as CSV, and performs basic clustering analysis"
```

**Without AI 🧠:**
```bash
e customer-analysis.py
```

Write it step by step:
```python
#!/usr/bin/env python3
"""Generate synthetic data and analyze it."""
import csv
import random
from collections import defaultdict

def generate_data(filename, rows=1000):
    names = ["Alice", "Bob", "Charlie", "Diana", "Eve", "Frank"]
    products = ["Widget A", "Widget B", "Gadget C"]

    with open(filename, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["id", "name", "product", "quantity", "price"])
        for i in range(rows):
            writer.writerow([
                i + 1,
                random.choice(names),
                random.choice(products),
                random.randint(1, 10),
                random.randint(20, 100)
            ])

def analyze(filename):
    revenue_by_product = defaultdict(int)
    with open(filename) as f:
        reader = csv.DictReader(f)
        for row in reader:
            rev = int(row["quantity"]) * int(row["price"])
            revenue_by_product[row["product"]] += rev

    print("Revenue by product:")
    for product, revenue in sorted(revenue_by_product.items()):
        print(f"  {product}: ${revenue}")

def main():
    generate_data("customers.csv")
    print("Generated customers.csv")
    analyze("customers.csv")

if __name__ == "__main__":
    main()
```

**Run it:**
```bash
python3 customer-analysis.py
```

---

## Exercise 5: Docker Multi-Service Stack (20 min)

**Task:** Create a Dockerfile and docker-compose.yml for a Python Flask app.

**With AI:**
```bash
ai "write a Dockerfile and docker-compose.yml for a Python Flask app with PostgreSQL, Redis, Nginx, and health checks"
```

**Without AI 🧠:**
Create the files manually based on what you learned in Lessons 11-12.

**Dockerfile:**
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:5000/health || exit 1
EXPOSE 5000
CMD ["python", "app.py"]
```

**docker-compose.yml:**
```yaml
services:
  app:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/mydb
    depends_on:
      - db
      - redis
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb
    volumes:
      - pgdata:/var/lib/postgresql/data

  redis:
    image: redis:alpine

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app

volumes:
  pgdata:
```

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-4/lesson-13-local-ai/`:

| File | Description |
|------|-------------|
| `summarize.py` | Text summarization CLI (Exercise 2) |
| `customer-analysis.py` | Data analysis script (Exercise 4) |
| `Dockerfile` | Docker config (Exercise 5) |
| `docker-compose.yml` | Compose config (Exercise 5) |
| `backup-v2.sh` | Improved script from Exercise 3 (optional) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can build a Python CLI tool from scratch
- [ ] I can review and improve my own code
- [ ] I can generate and analyze data programmatically
- [ ] I can create Docker configurations manually
- [ ] I can use AI as an enhancement (if available)

**Total: ___ / 25**

---

## Phase 4 Complete! 🎉

You can now:
- Build and run Docker containers
- Manage multi-container apps with Docker Compose
- Write Python scripts for automation and analysis
- Review and improve your own code

**Next:** Graduation Project
