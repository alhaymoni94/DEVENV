# Phase 4: Containers & AI Quiz

Q: What command runs a Docker container?
A: docker run image-name

Q: What flag runs a container in the background?
A: -d

Q: What flag maps a host port to a container port?
A: -p host:container

Q: What flag gives a container a name?
A: --name container-name

Q: What command lists running containers?
A: docker ps

Q: What command lists all containers including stopped ones?
A: docker ps -a

Q: What command stops a running container?
A: docker stop container-name

Q: What command removes a stopped container?
A: docker rm container-name

Q: What command views a container's logs?
A: docker logs container-name

Q: What command runs a command inside a running container?
A: docker exec container-name command

Q: What file defines a custom Docker image?
A: Dockerfile

Q: What Dockerfile instruction sets the base image?
A: FROM

Q: What Dockerfile instruction sets the working directory?
A: WORKDIR

Q: What Dockerfile instruction runs a command during build?
A: RUN

Q: What Dockerfile instruction sets the default command?
A: CMD

Q: What command builds a Docker image?
A: docker build -t name .

Q: What file defines multiple Docker services?
A: docker-compose.yml

Q: What command starts all compose services?
A: docker compose up -d

Q: What command stops all compose services?
A: docker compose down

Q: What command opens the Docker TUI?
A: lzd

Q: What command asks AI a quick question?
A: ai "your question"

Q: What command starts an AI coding agent session?
A: opencode

Q: How do you pipe code to AI for explanation?
A: cat file.py | ai "explain this"

Q: What file configures opencode?
A: ~/.opencode.json

Q: What Docker command creates persistent storage?
A: docker volume create name
