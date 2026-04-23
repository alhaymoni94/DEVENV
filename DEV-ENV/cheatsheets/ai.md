# ai (opencode)
> Terminal-native AI chat powered by opencode. Supports OpenAI, Anthropic, Gemini, and more.

Start a session: `ai`  
One-shot: `ai "your question"`

---

## I want to...
| Intent                          | Key / Command                      |
|---------------------------------|------------------------------------|
| Start interactive session       | `ai`                               |
| Ask a one-shot question         | `ai "your question"`               |
| Pipe input to AI                | `cat file.py \| ai "explain"`      |
| Set system prompt               | `ai --system "you are..." "question"` |
| Save output to file             | `ai "question" > answer.md`        |
| Show help                       | `ai --help`                        |

---

## In-Session Commands
When running `ai` interactively (opencode TUI):
| Command       | Action                                  |
|---------------|-----------------------------------------|
| `/help`       | Show all commands                       |
| `/connect`    | Configure AI provider                   |
| `/undo`       | Undo last changes                       |
| `/redo`       | Redo changes                            |
| `/share`      | Share conversation                      |
| `/exit`       | Exit session                            |
| `Ctrl+D`      | Exit session (EOF)                      |

---

## Model Configuration
Config file: `~/.opencode.json`

```json
{
  "providers": {
    "openai": {
      "apiKey": "your-api-key"
    },
    "anthropic": {
      "apiKey": "your-api-key"
    }
  },
  "agents": {
    "coder": {
      "model": "claude-3.7-sonnet"
    }
  }
}
```

Or use environment variables:
- `OPENAI_API_KEY` — OpenAI models
- `ANTHROPIC_API_KEY` — Claude models
- `GEMINI_API_KEY` — Google Gemini
- `LOCAL_ENDPOINT` — Self-hosted (Ollama, etc.)

---

## Common Workflows

**Explain a codebase:**
```bash
cat main.py | ai "explain this code step by step"
```

**Generate a script:**
```bash
ai "write a bash script that finds and deletes files older than 30 days"
```

**Debug with context:**
```bash
ai  # enter interactive session
# paste error message, ask for help
# iterate with follow-up questions
```

**Convert between formats:**
```bash
cat data.json | ai "convert this to CSV format"
```

**Use a system prompt:**
```bash
ai --system "you are a shell expert" "how do I find large files?"
```
