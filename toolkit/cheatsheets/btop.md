# btop
> A beautiful, keyboard-driven system monitor. CPU, RAM, disk, network, processes.

Open: `top` (alias) or `btop`

---

## I want to...
| Intent                          | Key                  |
|---------------------------------|----------------------|
| Sort processes by CPU           | `p`                  |
| Sort processes by memory        | `m`                  |
| Sort processes by PID           | `P`                  |
| Kill a process                  | `k` → select signal  |
| Filter processes                | `/` → type filter    |
| Clear filter                    | `Esc`                |
| Expand/collapse process tree    | `Enter`              |
| Change theme                    | `t`                  |
| Toggle disks graph              | `d`                  |
| Toggle network graph            | `n`                  |
| Show help                       | `?`                  |
| Quit                            | `q`                  |

---

## Layout
```
┌─────────────────────────────────────────┐
│  CPU [████████░░░░]  45%  │  Temp: 62°C │
├─────────────────────────────────────────┤
│  MEM [██████░░░░░░]  5.2G/16G           │
├─────────────────────────────────────────┤
│  NET ↑ 1.2 MB/s  ↓ 8.4 MB/s            │
├─────────────────────────────────────────┤
│  PID  USER    CPU%  MEM%   COMMAND      │
│  1234 user    45.2  12.3   firefox       │
│  5678 user    12.1   8.7   code          │
│  9012 root     5.4   2.1   docker        │
└─────────────────────────────────────────┘
```

---

## Navigation
| Key        | Action                        |
|------------|-------------------------------|
| `↑` / `↓`  | Move up/down in process list  |
| `←` / `→`  | Switch between graphs         |
| `Enter`    | Expand process tree           |
| `Space`    | Select/deselect process       |
| `k`        | Kill selected process         |
| `/`        | Filter processes              |
| `Esc`      | Clear filter                  |
| `q`        | Quit                          |

---

## Tips
- **Always visible** in tmux status bar (CPU, RAM, disk) — use btop for detail
- **`p`** sorts by CPU — find what's slowing you down
- **`m`** sorts by memory — find memory hogs
- **`t`** cycles themes — Tokyo Night is the default
- **`d`** toggles disk I/O graph — useful for I/O bottlenecks
