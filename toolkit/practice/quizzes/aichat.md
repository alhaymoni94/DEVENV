# Aichat Quiz

Q: How do you start an interactive AI chat session?
A: aichat

Q: How do you ask a one-shot question without entering a session?
A: aichat "your question"

Q: How do you pipe file contents to aichat?
A: cat file.py | aichat "your prompt"

Q: How do you specify a different model?
A: aichat -m ollama:llama3

Q: How do you save a conversation to a file?
A: /save <filename> inside the session

Q: How do you change the AI's role/persona?
A: /role <name> inside the session

Q: How do you exit an aichat session?
A: Ctrl+D or /exit

Q: How do you see all available slash commands?
A: /help

Q: Where is the aichat configuration stored?
A: ~/.config/aichat/config.yaml

Q: How would you ask aichat to explain a Python script?
A: cat script.py | aichat "explain this code"
