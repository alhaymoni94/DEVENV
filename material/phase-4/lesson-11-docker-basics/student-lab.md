# Lesson 11: Docker Basics — Student Lab

## Duration: 2 hours

---

## Exercise 1: Your First Container (20 min)

```bash
# Run a hello world container
docker run hello-world

# Run an interactive Ubuntu container
docker run -it ubuntu bash
# Inside the container:
ls
cat /etc/os-release
exit

# Run a container in the background
docker run -d --name webserver nginx

# Check it's running
docker ps

# Visit it
curl localhost:80

# Stop it
docker stop webserver

# Remove it
docker rm webserver
```

---

## Exercise 2: Build Your Own Image (30 min)

```bash
mkdir ~/docker-practice && cd ~/docker-practice
e Dockerfile
```

Add:
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir flask
CMD ["python", "app.py"]
```

```bash
e app.py
```

Add:
```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

```bash
# Build the image
docker build -t my-flask-app .

# Run it
docker run -d --name flask-app -p 5000:5000 my-flask-app

# Test it
curl localhost:5000

# Check logs
docker logs flask-app

# Clean up
docker stop flask-app && docker rm flask-app
```

---

## Exercise 3: Lazydocker (20 min)

```bash
# Start a few containers
docker run -d --name web1 nginx
docker run -d --name web2 nginx

# Open lazydocker
lzd
```

Inside lazydocker:
1. View all containers
2. Check logs for a container
3. Restart a container
4. View resource usage
5. Remove a container

```bash
# Clean up
docker stop web1 web2
docker rm web1 web2
```

---

## Exercise 4: Volumes and Data Persistence (20 min)

```bash
# Create a volume
docker volume create mydata

# Run a container with the volume
docker run -d --name db -v mydata:/var/lib/postgresql/data postgres:15

# The data persists even if you stop/remove the container
docker stop db
docker rm db
docker run -d --name db2 -v mydata:/var/lib/postgresql/data postgres:15

# Clean up
docker stop db2 && docker rm db2
docker volume rm mydata
```

---

## Exercise 5: Docker Cleanup (10 min)

```bash
# Check disk usage
docker system df

# Remove unused containers, images, networks
docker system prune

# Remove everything including volumes
docker system prune -a --volumes
```

---

## Deliverables

Save your work in `students/YOUR_NAME/phase-4/lesson-11-docker-basics/`:

| File | Description |
|------|-------------|
| `Dockerfile` | Custom image build (Exercise 2) |
| `app.py` | Flask app (Exercise 2) |

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can run and manage containers
- [ ] I can build Docker images
- [ ] I can use lazydocker for container management
- [ ] I understand volumes and data persistence
- [ ] I can clean up Docker resources

**Total: ___ / 25**

---

## Next

Lesson 12: Docker Compose
