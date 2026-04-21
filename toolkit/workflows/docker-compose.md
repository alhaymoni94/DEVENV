# Docker Compose Workflow
> Manage multi-container applications from the terminal.

## Quick Start

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop all services
docker compose down
```

## Daily Docker Workflow

### Start Your Environment

```bash
# Navigate to project with docker-compose.yml
cd myproject/

# Start services in background
docker compose up -d

# Check what's running
docker ps
lzd                    # lazydocker TUI for visual management
```

### View Logs

```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f web
docker compose logs -f db

# Last 100 lines
docker compose logs --tail=100 web
```

### Run Commands in Containers

```bash
# Open shell in running container
docker compose exec web bash

# Run one-off command
docker compose run --rm web python manage.py migrate

# Database shell
docker compose exec db psql -U postgres
```

### Rebuild Services

```bash
# Rebuild after code changes
docker compose up -d --build

# Rebuild single service
docker compose build web
docker compose up -d web

# Force rebuild without cache
docker compose build --no-cache web
```

### Database Operations

```bash
# Backup database
docker compose exec db pg_dump -U postgres mydb > backup.sql

# Restore database
cat backup.sql | docker compose exec -T db psql -U postgres mydb

# Reset database (WARNING: deletes all data)
docker compose down -v
docker compose up -d
```

### Troubleshooting

```bash
# Check service health
docker compose ps

# View resource usage
docker stats

# Inspect container
docker inspect <container-id>

# Check container logs for errors
docker compose logs web | grep -i error

# Restart a single service
docker compose restart web
```

### Cleanup

```bash
# Stop and remove containers
docker compose down

# Stop, remove, and delete volumes
docker compose down -v

# Remove unused images
docker image prune -a

# Full cleanup
docker system prune -a --volumes
```

## Docker Compose + Lazydocker

```bash
# Open lazydocker
lzd

# Navigate with arrow keys
# Press Enter to view logs
# Press 'r' to restart container
# Press 'd' to view docker-compose.yml
# Press 'm' to view container metrics
```

## Common docker-compose.yml Patterns

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgres://postgres:password@db:5432/mydb

  db:
    image: postgres:15
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb

volumes:
  postgres_data:
```

## Quick Reference

| Command | Purpose |
|---------|---------|
| `docker compose up -d` | Start all services |
| `docker compose down` | Stop all services |
| `docker compose logs -f` | Follow logs |
| `docker compose exec <svc> bash` | Shell in container |
| `docker compose build` | Rebuild images |
| `docker compose ps` | Check service status |
| `lzd` | Open lazydocker TUI |
| `docker stats` | View resource usage |
