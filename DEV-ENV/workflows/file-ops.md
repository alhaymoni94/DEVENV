# File Operations Workflow

```
┌──────────────────────────────────────────────────────────────┐
│  📁  FILE MANAGEMENT                                         │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   ┌──────────────────────────────────────────────────────┐   │
│   │  yazi File Manager (y)                               │   │
│   │                                                      │   │
│   │  ┌──────────┐  ┌──────────────┐  ┌───────────────┐  │   │
│   │  │ Parent   │  │ Current      │  │ Preview       │  │   │
│   │  │ dir      │  │ directory    │  │ (file content)│  │   │
│   │  │          │  │              │  │               │  │   │
│   │  │  Docs/   │  │▶ toolkit/    │  │  README.md    │  │   │
│   │  │  Proj/   │  │  setup/      │  │  # Title      │  │   │
│   │  │  Dwnld/  │  │  students/   │  │  ...          │  │   │
│   │  └──────────┘  └──────────────┘  └───────────────┘  │   │
│   └──────────────────────────────────────────────────────┘   │
│                                                              │
│   ↑↓ navigate  → enter  ← parent  / search  . hidden         │
│   Space select  Ctrl+C copy  Ctrl+X cut  Ctrl+V paste        │
│   d trash  a create  r rename  Ctrl+Q quit+cd                │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Browse & Open
```bash
y              # open yazi in current directory
y ~/path       # open at specific path
/              # search filenames
.              # toggle hidden files
z              # zoxide jump (fuzzy directory)
```

## Copy / Move
```
Space          # select file(s)
Ctrl+C         # copy (or Ctrl+X to cut)
↑↓←→ navigate  # go to destination
Ctrl+V         # paste
```

## Bulk Rename
```
v              # enter visual mode
↑↓ select      # pick multiple files
R              # open all names in micro
# Edit names, save, quit → renames happen
```

## Create
```
a              # create
filename       # for a file
dirname/       # trailing slash = directory
```

## Trash & Restore
```
d              # trash selected files

# Restore:
ls ~/.local/share/Trash/files/
mv ~/.local/share/Trash/files/<file> ./
```
