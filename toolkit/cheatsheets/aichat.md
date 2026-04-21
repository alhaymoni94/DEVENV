# aichat
> Terminal-native AI chat. Supports OpenAI, Ollama, and more. No GUI needed.

Start a session: `aichat`  
One-shot: `aichat "your question"`

---

## I want to...
| Intent                          | Key / Command                      |
|---------------------------------|------------------------------------|
| Start interactive session       | `aichat`                           |
| Ask a one-shot question         | `aichat "your question"`           |
| Pipe input to AI                | `cat file.py \| aichat "explain"`  |
| Use a specific model            | `aichat -m ollama:llama3`          |
| List available models           | `aichat --list-models`             |
| Set system prompt               | `aichat --system "you are..."`     |
| Stream response (default)       | `aichat --stream "question"`       |
| Save output to file             | `aichat "question" > answer.md`    |

---

## In-Session Commands
| Command       | Action                                  |
|---------------|-----------------------------------------|
| `/help`       | Show all commands                       |
| `/role <n>`   | Switch role/persona                     |
| `/info`       | Show current model and settings         |
| `/save <f>`   | Save conversation to file               |
| `/clear`      | Clear conversation history              |
| `/set`        | View/change settings                    |
| `/exit`       | Exit session                            |
| `Ctrl+D`      | Exit session (EOF)                      |

---

## Roles
Roles define the AI's behavior. Common ones:

| Role          | Purpose                                |
|---------------|----------------------------------------|
| `coder`       | Code generation and debugging          |
| `explainer`   | Explain concepts in detail             |
| `reviewer`    | Code review and best practices         |
| `shell`       | Shell command generation               |

Define custom roles in `~/.config/aichat/config.yaml`.

---

## Model Configuration
Config file: `~/.config/aichat/config.yaml`

```yaml
model:
  provider: openai
  name: gpt-4
  api_key: env:OPENAI_API_KEY

# Or for local models:
model:
  provider: ollama
  name: llama3
  api_base: http://localhost:11434
```

---

## Common Workflows

**Explain a codebase:**
```bash
cat main.py | aichat "explain this code step by step"
```

**Generate a script:**
```bash
aichat "write a bash script that finds and deletes files older than 30 days"
```

**Debug with context:**
```bash
aichat  # enter session
# paste error message, ask for help
# iterate with follow-up questions
```

**Convert between formats:**
```bash
cat data.json | aichat "convert this to CSV format"
```
