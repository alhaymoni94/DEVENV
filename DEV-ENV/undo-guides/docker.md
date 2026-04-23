# Docker Undo Guide
> "I ran a docker command I shouldn't have — how do I recover?"

## I deleted a container by accident

Containers are ephemeral — if you delete one, you need to recreate it:

```bash
# Recreate from image
docker run -d --name container-name image-name

# If using docker compose:
docker compose up -d
```

## I deleted a volume (data loss!)

```bash
# Check if you have backups
ls /path/to/backups/

# Restore from backup
docker run --rm -v volume-name:/data -v $(pwd):/backup alpine \
  sh -c "cd /data && tar xzf /backup/backup.tar.gz"
```

**Prevention**: Always backup volumes before `docker compose down -v`:
```bash
docker run --rm -v volume-name:/data -v $(pwd):/backup alpine \
  sh -c "cd /data && tar czf /backup/backup.tar.gz ."
```

## I stopped a running container

```bash
# Restart it
docker start container-name

# Or with docker compose:
docker compose up -d
```

## I pulled the wrong image

```bash
# Remove the image
docker rmi image-name

# Or prune unused images
docker image prune
```

## I ran a container with wrong ports

```bash
# Stop the container
docker stop container-name

# Remove it
docker rm container-name

# Run again with correct ports
docker run -d -p 8080:80 image-name
```

## I accidentally removed all images

```bash
# Rebuild from docker-compose.yml
docker compose build

# Or pull again
docker compose pull
```

## I messed up docker-compose.yml

```bash
# Check for syntax errors
docker compose config

# Revert to last working version
git checkout docker-compose.yml

# Restart services
docker compose up -d
```

## I filled up disk space with Docker

```bash
# Check Docker disk usage
docker system df

# Remove unused containers, images, networks
docker system prune

# Remove everything (including volumes)
docker system prune -a --volumes

# WARNING: This deletes all unused data!
```

## I can't connect to a container

```bash
# Check if it's running
docker ps

# Check logs
docker logs container-name

# Check network
docker network ls
docker inspect container-name | grep -i network

# Restart the container
docker restart container-name
```

## Recovery checklist

1. `docker ps -a` — list all containers
2. `docker images` — list all images
3. `docker volume ls` — list all volumes
4. `docker compose logs` — check service logs
5. `docker system df` — check disk usage
