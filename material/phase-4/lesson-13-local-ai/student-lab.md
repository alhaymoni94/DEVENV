# Lesson 13: Local AI Development — Student Lab

## Duration: 2 hours

---

## Exercise 1: AI Tools Overview (20 min)

```bash
# Check what AI tools are available
aichat --version
opencode --version

# Test aichat
ai "what is the difference between supervised and unsupervised learning?"

# Test opencode
opencode --version
```

---

## Exercise 2: AI-Assisted Development (30 min)

**Task:** Build a complete project using AI.

```bash
mkdir ~/ai-project && cd ~/ai-project
opencode
```

**Prompt:** "Create a Python CLI tool that:
1. Takes a text file as input
2. Summarizes it using basic extractive summarization
3. Shows the top 5 most important sentences
4. Has a nice CLI interface with click"

**Steps:**
1. Let opencode generate the code
2. Review and save files
3. Test the tool
4. Ask opencode to add features

---

## Exercise 3: AI for Code Review (20 min)

```bash
# Take one of your previous scripts
cat ~/bin/backup.sh | ai "review this script for:
1. Security issues
2. Best practices
3. Error handling
4. Performance improvements"

# Apply the suggestions
e ~/bin/backup.sh
# Make improvements
```

---

## Exercise 4: AI for Data Science (20 min)

```bash
# Ask AI to create a data analysis pipeline
ai "write a Python script that:
1. Generates synthetic customer data (1000 rows)
2. Saves it as CSV
3. Performs clustering analysis
4. Visualizes the results
Save it as ~/ai-project/customer-analysis.py"
```

```bash
# Run it
cd ~/ai-project
python customer-analysis.py
```

---

## Exercise 5: AI for DevOps (20 min)

```bash
# Ask AI to write Docker configurations
ai "write a Dockerfile and docker-compose.yml for a Python Flask app with:
1. PostgreSQL database
2. Redis cache
3. Nginx reverse proxy
4. Health checks
Save them as ~/ai-project/Dockerfile and ~/ai-project/docker-compose.yml"
```

---

## Self-Assessment

Rate yourself (1-5):

- [ ] I can use aichat for quick questions
- [ ] I can use opencode for coding sessions
- [ ] I can use AI for code review
- [ ] I can use AI for data science tasks
- [ ] I can use AI for DevOps configurations

**Total: ___ / 25**

---

## Phase 4 Complete! 🎉

You can now:
- Build and run Docker containers
- Manage multi-container apps with Docker Compose
- Use AI agents for development, review, and DevOps

**Next:** Phase 5 — Advanced Topics
