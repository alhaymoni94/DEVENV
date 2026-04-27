# lazydocker
> A terminal UI for Docker. Manage containers, images, volumes, networks, and logs.

Open: `lzd` (alias) or `lazydocker`

---

## I want to...
| Intent                          | Key                  |
|---------------------------------|----------------------|
| Start/stop container            | `Space`              |
| View container logs             | `Enter`              |
| Remove container                | `d`                  |
| Restart container               | `e`                  |
| View container stats            | `s`                  |
| View container config           | `c`                  |
| View all keybindings            | `?`                  |
| Quit                            | `q`                  |

---

## Panels
| Panel        | Purpose                        |
|--------------|--------------------------------|
| Containers   | Running/stopped containers     |
| Images       | Docker images                  |
| Volumes      | Persistent data volumes        |
| Networks     | Docker networks                |
| Logs         | Container logs (real-time)     |

---

## Navigation
| Key        | Action                        |
|------------|-------------------------------|
| `↑` / `↓`  | Move up/down in list          |
| `Tab`      | Switch between panels         |
| `Enter`    | Open selected item            |
| `Space`    | Toggle container (start/stop) |
| `d`        | Delete selected item          |
| `e`        | Edit/restart container        |
| `s`        | Show stats                    |
| `q`        | Quit                          |

---

## Common Workflows

**Check container health:**
```bash
lzd                    # open lazydocker
↑↓ select container    # pick one
Enter                  # view logs
q                      # quit
```

**Clean up stopped containers:**
```bash
lzd                    # open lazydocker
Tab to containers      # switch panel
d on stopped ones      # delete
```

**Quick Docker commands (no TUI):**
```bash
docker ps              # list running containers
docker ps -a           # list all containers
docker images          # list images
docker logs <container> # view logs
```
