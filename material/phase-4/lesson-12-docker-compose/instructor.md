# Lesson 12: Docker Compose — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Understand why Docker Compose exists
- Write docker-compose.yml files
- Manage multi-container applications
- Use environment variables in compose
- Handle dependencies between services
- Use lazydocker with compose projects

## Prerequisites

- Lesson 11 completed (Docker basics)

## Lesson Flow

### Part 1: Why Docker Compose? (15 min)

**Talk through:**
- Running one container is easy. Running 5 is painful.
- Docker Compose = single file, multiple containers
- `docker-compose.yml` defines services, networks, volumes
- One command: `docker compose up -d`

**Show the pain:**
```bash
# Without compose (painful):
docker network create mynet
docker volume create dbdata
docker run -d --name db --network mynet -v dbdata:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret postgres:15
docker run -d --name redis --network mynet redis:alpine
docker run -d --name app --network mynet -p 5000:5000 -e DATABASE_URL=postgresql://postgres:secret@db:5432/mydb myapp

# With compose (one file, one command):
docker compose up -d
```

### Part 2: Your First Compose File (25 min)

**Cover YAML structure:**
```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  redis:
    image: redis:alpine
```

**Key concepts:**
- `services` — containers to run
- `image` — what to run
- `ports` — host:container mapping
- `volumes` — data persistence
- `environment` — config variables
- `depends_on` — startup order

**Have students practice:**
1. Create a compose file with nginx + redis
2. Start it: `docker compose up -d`
3. Check status: `docker compose ps`
4. View logs: `docker compose logs -f`
5. Stop: `docker compose down`

### Part 3: Full Stack Application (30 min)

**Demo a 3-service app:**
```yaml
services:
  app:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://postgres:secret@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:alpine

volumes:
  postgres_data:
```

**Have students practice:**
1. Build and run the full stack
2. Test each service
3. Check database connectivity
4. View logs for all services

### Part 4: Environment Variables & Config (20 min)

**Cover:**
- Inline: `environment: - KEY=value`
- From file: `env_file: .env`
- Variable substitution: `${VAR:-default}`

**Demo:**
```bash
e .env
```

```
POSTGRES_PASSWORD=secret
POSTGRES_DB=mydb
APP_PORT=5000
```

```yaml
services:
  db:
    image: postgres:15
    env_file: .env
```

**Have students practice:**
1. Create a .env file
2. Reference it in compose
3. Change a value, restart, verify

### Part 5: Database Operations (20 min)

**Cover:**
- Running commands in containers: `docker compose exec`
- Backup: `pg_dump`
- Restore: `psql < backup.sql`
- Reset: `docker compose down -v`

**Demo:**
```bash
docker compose exec db psql -U postgres -c "\l"
docker compose exec db pg_dump -U postgres mydb > backup.sql
cat backup.sql | docker compose exec -T db psql -U postgres mydb
```

### Part 6: lazydocker with Compose (10 min)

**Demo:**
```bash
docker compose up -d
lzd
```

Show how lazydocker groups compose services and makes management visual.

## Common Issues

| Issue | Solution |
|-------|----------|
| Service won't start | `docker compose logs <service>` |
| Port conflict | Change host port in compose |
| Database connection fails | Check `depends_on` and service name |
| Volume data persists after down | Use `docker compose down -v` to remove |

## Assessment

- Students write a docker-compose.yml from scratch
- Students run a multi-container app
- Students perform database backup/restore

## Next Lesson

Lesson 13: Local AI Development
