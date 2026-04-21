# Lesson 16: AI Models Management — Student Lab

## Duration: 2 hours

---

## Exercise 1: Understanding Local AI (20 min)

```bash
# Check what AI tools are available
which aichat
which opencode

# Check if ollama is installed
which ollama || echo "ollama not installed"

# Check mise for runtime management
mise list
```

---

## Exercise 2: Model Selection (30 min)

**Task:** Understand different model options.

```bash
# Ask AI about model options
ai "compare these local AI models for terminal use:
1. Llama 3
2. Mistral
3. Phi-3
4. CodeLlama

For each, tell me:
- Size (disk/RAM requirements)
- Best use case
- Performance characteristics"
```

---

## Exercise 3: Model Configuration (30 min)

**Task:** Configure AI tools for optimal performance.

```bash
# Check aichat config
cat ~/.config/aichat/config.yaml

# Ask AI to help optimize
ai "help me configure aichat for:
1. Faster responses
2. Better code generation
3. Lower memory usage
Show me the config changes"
```

---

## Exercise 4: Model Evaluation (20 min)

**Task:** Test different model capabilities.

```bash
# Test coding ability
ai "write a Python function that implements binary search"

# Test reasoning
ai "if a train travels at 60 mph for 2.5 hours, how far does it go?"

# Test creativity
ai "write a haiku about terminal emulators"

# Test code review
cat ~/.zshrc | ai "review this shell config for security issues"
```

**Rate each response (1-5) and track which model performs best for your needs.**

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I understand local AI model options
- [ ] I can configure AI tools for my needs
- [ ] I can evaluate model performance
- [ ] I understand trade-offs between models

**Total: ___ / 20**

---

## Next

Lesson 17: SDLC Using AI Agents
