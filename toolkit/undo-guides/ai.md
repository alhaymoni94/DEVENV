# AI Undo Guide
> "I messed up, how do I fix it?"

## I got a wrong or bad AI response
```
Just ask again with more context:
  ai "that's not what I meant. I need..."
  
# Or be more specific:
  ai "explain step by step"
  ai "show me the code only, no explanation"
```

## I accidentally exited a conversation
```
ai                         # start a new session
# Previous conversations are not saved by default
# In opencode TUI: use /share to get a link
```

## I want to use a different model
```
# Model selection is done via ~/.opencode.json config
# Or in interactive mode: /connect to switch provider
```

## I accidentally cleared the conversation
```
# Can't undo — start fresh with full context:
  ai "here's what we were working on: [paste context]"
```

## I saved AI output to the wrong file
```bash
mv wrong-file.md correct-file.md
```

## I piped the wrong file to ai
```
# Just re-run with the correct file:
cat correct-file.py | ai "explain this"
```
