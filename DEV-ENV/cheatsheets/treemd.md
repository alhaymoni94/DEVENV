# treemd

> Generate tree diagrams from directory structures with markdown output.

## Installation

```bash
brew install treemd
```

## Usage

```bash
# Generate tree of current directory
treemd

# Generate tree of specific directory
treemd /path/to/project

# Save to file
treemd > structure.md

# Exclude directories
treemd --exclude node_modules,.git

# Limit depth
treemd --depth 3
```

---

## Output Example

```bash
treemd --depth 2
```

```
project/
├── src/
│   ├── main.py
│   └── utils.py
├── tests/
│   └── test_main.py
├── docs/
│   └── README.md
└── requirements.txt
```

---

## See Also
- `cheat d2` — create diagrams with text (more powerful)
- `cheat mmdc` — Mermaid diagram CLI
- `cheat eza` — `eza --tree` for simple directory trees
