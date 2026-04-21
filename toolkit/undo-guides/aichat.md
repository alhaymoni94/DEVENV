# Aichat Undo Guide
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
# To save: /save conversation.md before exiting
```

## I used the wrong model
```
In session:
  /set model ollama:llama3
  
# Or restart with specific model:
  ai -m ollama:llama3
```

## I accidentally cleared the conversation
```
/clear                     # clears context (intentional)
# Can't undo — start fresh with full context:
  ai "here's what we were working on: [paste context]"
```

## I saved a conversation to the wrong file
```bash
mv wrong-file.md correct-file.md
```

## I piped the wrong file to aichat
```
# Just re-run with the correct file:
cat correct-file.py | ai "explain this"
```
