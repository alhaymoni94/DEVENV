# Lesson 11: Docker Basics — Instructor Guide

## Duration: 2 hours

## Objectives

By the end of this lesson, students will:
- Understand what Docker is and why it matters
- Run containers from public images
- Build custom Docker images
- Manage containers (start, stop, remove)
- Use lazydocker for visual management
- Understand volumes for data persistence

## Prerequisites

- Phase 3 completed
- Docker installed (verified by doctor.sh)

## Lesson Flow

### Part 1: What is Docker? (15 min)

**Talk through:**
- "It works on my machine" problem
- Containers vs VMs (lightweight, shared kernel)
- Images (blueprint) vs Containers (running instance)
- Docker Hub (registry of public images)

**Analogy:** Images are like recipes. Containers are the cooked meals.

### Part 2: Running Your First Container (20 min)

**Demo:**
```bash
docker run hello-world
docker run -it ubuntu bash
docker run -d --name webserver -p 8080:80 nginx
```

**Key concepts to cover:**
- `-d` (detached/background)
- `-p` (port mapping)
- `--name` (container name)
- `-it` (interactive terminal)

**Have students practice:**
1. Run hello-world
2. Run an interactive Ubuntu container, explore it, exit
3. Run nginx in background, curl it, stop it

### Part 3: Building Custom Images (30 min)

**Cover:**
- Dockerfile syntax: FROM, WORKDIR, COPY, RUN, CMD
- Building: `docker build -t name .`
- Layers and caching

**Demo:**
```bash
mkdir ~/docker-demo && cd ~/docker-demo
e Dockerfile
```

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir flask
COPY . .
CMD ["python", "app.py"]
```

```bash
e requirements.txt  # flask
e app.py            # simple Flask app
docker build -t myapp .
docker run -d --name myapp -p 5000:5000 myapp
curl localhost:5000
```

**Have students practice:**
1. Create a Dockerfile for a simple app
2. Build and run it
3. Check logs with `docker logs`

### Part 4: Container Management (20 min)

**Cover:**
- `docker ps` — running containers
- `docker ps -a` — all containers
- `docker stop/start/restart`
- `docker rm` — remove
- `docker logs` — view output
- `docker exec` — run command inside

**Have students practice:**
1. Start 3 containers
2. Stop one, restart another
3. exec into a running container
4. View logs

### Part 5: Volumes and Data Persistence (20 min)

**Cover:**
- Why volumes? (containers are ephemeral)
- Named volumes: `docker volume create`
- Bind mounts: `-v ./data:/app/data`

**Demo:**
```bash
docker volume create mydata
docker run -d --name db -v mydata:/var/lib/postgresql/data postgres:15
docker stop db && docker rm db
docker run -d --name db2 -v mydata:/var/lib/postgresql/data postgres:15
# Data persists!
```

### Part 6: lazydocker (15 min)

**Demo:**
```bash
lzd
```

**Cover navigation:**
- Arrow keys to select containers/images/volumes
- Enter to view logs
- `r` to restart
- `d` to delete
- `Space` to mark for action

**Have students practice:**
1. Open lazydocker with containers running
2. View logs for each container
3. Restart a container
4. Remove a container

## Common Issues

| Issue | Solution |
|-------|----------|
| Permission denied | Add user to docker group: `sudo usermod -aG docker $USER` |
| Port already in use | Change host port: `-p 8081:80` |
| Container exits immediately | Check logs: `docker logs <name>` |
| Image pull fails | Check internet, try `docker pull <image>` first |

## Assessment

- Students run a container from a public image
- Students build a custom Dockerfile
- Students use lazydocker to manage containers
- Students demonstrate volume persistence

## Next Lesson

Lesson 12: Docker Compose
