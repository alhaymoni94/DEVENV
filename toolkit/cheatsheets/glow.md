# glow
> Render markdown files in the terminal. Beautiful, readable output.

Usage: `glow file.md` or `glow -p file.md` (pager mode)

---

## I want to...
| Intent                          | Command                        |
|---------------------------------|--------------------------------|
| Render a markdown file          | `glow file.md`                 |
| Render with pager (scrollable)  | `glow -p file.md`              |
| Render from stdin               | `cat file.md | glow`           |
| Render from URL                 | `glow https://example.com/README.md` |
| Set width                       | `glow -w 80 file.md`           |
| Show style options              | `glow style`                   |

---

## Used By
The `cheat` script uses glow to render cheatsheets:
```bash
cheat <topic>              # renders via glow in pager
cheat --quick <tool>       # one-pager via glow
```

---

## Tips
- **Default renderer** for all cheatsheets in this stack
- **`glow -p`** is used by the cheat script for scrollable output
- **Works with URLs** — render any GitHub README in your terminal
- **Style matches your terminal theme** — Tokyo Night by default
