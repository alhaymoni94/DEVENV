# llmfit

> Fine-tune and evaluate LLMs in the terminal. Track experiments, compare models.

## Installation

```bash
brew install llmfit
```

## I want to...

| Intent | Command |
|--------|---------|
| Check version | `llmfit --version` |
| List available models | `llmfit models` |
| Run evaluation | `llmfit eval --model model-name` |
| Compare two models | `llmfit compare model-a model-b` |
| Fine-tune on dataset | `llmfit train --data data.jsonl --output model-name` |
| View experiment history | `llmfit experiments` |
| Export results | `llmfit export --format csv` |

---

## Quick Start

```bash
# Evaluate a model on a benchmark
llmfit eval --model gpt-3.5-turbo --dataset benchmark.jsonl

# Fine-tune with your data
llmfit train \
  --data training-data.jsonl \
  --output my-finetuned-model \
  --epochs 3 \
  --learning-rate 1e-5
```

---

## Data Format

Training data should be JSONL with `prompt` and `completion`:
```json
{"prompt": "What is 2+2?", "completion": "4"}
{"prompt": "Capital of France?", "completion": "Paris"}
```

---

## See Also
- `cheat ai` — chat with LLMs
- `cheat opencode` — AI coding agent
