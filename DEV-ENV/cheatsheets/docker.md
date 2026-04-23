# Docker

> Container platform — build, run, and manage containers.

## I want to...

| Intent | Command |
|--------|---------|
| Run a container | `docker run hello-world` |
| Run interactively | `docker run -it ubuntu bash` |
| Run detached (background) | `docker run -d --name web nginx` |
| List running containers | `docker ps` |
| List all containers | `docker ps -a` |
| Stop a container | `docker stop container-name` |
| Remove a container | `docker rm container-name` |
| Force remove (running or not) | `docker rm -f container-name` |
| View container logs | `docker logs container-name` |
| Execute command inside container | `docker exec -it container-name bash` |

---

## Images

| Intent | Command |
|--------|---------|
| List local images | `docker images` |
| Pull an image | `docker pull python:3.11-slim` |
| Remove an image | `docker rmi image-name` |
| Build from Dockerfile | `docker build -t myapp .` |
| Tag an image | `docker tag myapp myapp:v1` |

---

## Volumes

| Intent | Command |
|--------|---------|
| Create a volume | `docker volume create mydata` |
| List volumes | `docker volume ls` |
| Remove a volume | `docker volume rm mydata` |
| Run with volume | `docker run -v mydata:/data postgres` |
| Run with bind mount | `docker run -v ./host:/container nginx` |

---

## Cleanup

| Intent | Command |
|--------|---------|
| Remove stopped containers | `docker container prune` |
| Remove unused images | `docker image prune` |
| Remove everything unused | `docker system prune` |
| Remove everything + volumes | `docker system prune -a --volumes` |
| Check disk usage | `docker system df` |

---

## Dockerfile Basics

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

Build and run:
```bash
docker build -t myapp .
docker run -d -p 5000:5000 myapp
```

---

## docker-compose

| Intent | Command |
|--------|---------|
| Start services | `docker compose up -d` |
| Start and build | `docker compose up -d --build` |
| Stop services | `docker compose down` |
| View logs | `docker compose logs -f service-name` |
| List services | `docker compose ps` |
| Run command in service | `docker compose exec service bash` |
| Restart a service | `docker compose restart service` |

---

## See Also
- `cheat lazydocker` — visual container management
- `cheat docker-compose` — multi-container apps
- `cheat --undo docker` — recovery guides
