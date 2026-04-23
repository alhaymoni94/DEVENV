# Lesson 12: Docker Compose — Student Lab

## Duration: 2 hours

---

## Exercise 1: Your First Compose File (30 min)

```bash
mkdir ~/compose-practice && cd ~/compose-practice
e docker-compose.yml
```

Add:
```yaml
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

```bash
mkdir html
echo "<h1>Hello from Docker Compose!</h1>" > html/index.html

# Start all services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f web

# Test
curl localhost:8080

# Stop
docker compose down
```

---

## Exercise 2: Full Stack App (40 min)

```bash
mkdir ~/fullstack && cd ~/fullstack
e docker-compose.yml
```

Add:
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

  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:alpine

volumes:
  postgres_data:
```

```bash
e Dockerfile
```

Add:
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```

```bash
e requirements.txt
```

Add:
```
flask
psycopg2-binary
redis
```

```bash
e app.py
```

Add:
```python
from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Full stack app running!"

@app.route("/health")
def health():
    return {"status": "healthy"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

```bash
# Build and start
docker compose up -d --build

# Check all services
docker compose ps

# View logs
docker compose logs -f app

# Test
curl localhost:5000
curl localhost:5000/health

# Stop
docker compose down
```

---

## Exercise 3: Database Operations (20 min)

```bash
# Start just the database
docker compose up -d db

# Run a command inside the container
docker compose exec db psql -U postgres -c "\l"

# Backup
docker compose exec db pg_dump -U postgres mydb > backup.sql

# Restore
cat backup.sql | docker compose exec -T db psql -U postgres mydb

# Stop
docker compose down
```

---

## Exercise 4: Lazydocker with Compose (10 min)

```bash
docker compose up -d
lzd
```

Inside lazydocker:
1. View all compose services
2. Check logs for each service
3. Restart a service
4. View the docker-compose.yml

```bash
docker compose down
```

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-4/lesson-12-docker-compose/`:

| File | Description |
|------|-------------|
| `docker-compose.yml` | Multi-service compose file (Exercise 2) |
| `Dockerfile` | App image build (Exercise 2) |
| `requirements.txt` | Python dependencies (Exercise 2) |
| `app.py` | Flask app (Exercise 2) |
| `backup.sql` | Database backup (Exercise 3) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can write a docker-compose.yml
- [ ] I can build and run multi-container apps
- [ ] I can manage databases with compose
- [ ] I can backup and restore databases
- [ ] I can use lazydocker with compose

**Total: ___ / 25**

---

## Next

Lesson 13: Local AI Development
