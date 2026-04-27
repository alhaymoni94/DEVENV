# Supervisor Answer Key

This directory contains reference solutions for evaluated deliverables. Use these to verify student submissions during manual review.

## How to Use

1. Run automated evaluation first: `camp evaluate STUDENT_NAME PHASE`
2. For scripts that pass functional execution, compare against these references
3. For scripts that fail, check if the failure is expected (e.g., missing args) or a real bug

## Reference Solutions by Phase

### Phase 1
- `phase-1/lesson-1-ai-agents/largest-files.sh` — Lists 10 largest files, human-readable
- `phase-1/lesson-1-ai-agents/stats.py` — Word/line/char counter with error handling
- `phase-1/lesson-2-unix-fundamentals/dir-summary.sh` — Directory summary with top files

### Phase 2
- `phase-2/lesson-5-editor-mastery/word-counter.py` — Word frequency counter with CLI args

### Phase 3
- `phase-3/lesson-10-shell-scripting/organize.sh` — Organizes files by extension
- `phase-3/lesson-10-shell-scripting/backup.sh` — Creates timestamped tar.gz backup
- `phase-3/lesson-10-shell-scripting/log-analyzer.sh` — Analyzes log files for errors

### Phase 4
- `phase-4/lesson-11-docker-basics/Dockerfile` — Python Flask image
- `phase-4/lesson-11-docker-basics/app.py` — Minimal Flask app
- `phase-4/lesson-12-docker-compose/docker-compose.yml` — Multi-service stack
- `phase-4/lesson-12-docker-compose/app.py` — Flask app with health endpoint

## Manual Review Rubric (20 pts)

| Criterion | Points | What to Check |
|-----------|--------|---------------|
| Code correctness | 10 | Script runs, produces expected output, handles edge cases |
| Understanding | 10 | Student can explain their code, justify design choices |

### Passing Criteria
- **PASS (≥80%)**: Automated ≥80% AND manual ≥12/20
- **REVIEW (60-79%)**: Automated 60-79% OR manual 8-11/20
- **FAIL (<60%)**: Automated <60% OR manual <8/20

## Quick Verification Commands

```bash
# Phase 1
cd students/STUDENT/phase-1/lesson-1-ai-agents
bash largest-files.sh .
python3 stats.py stats.py

# Phase 2
cd students/STUDENT/phase-2/lesson-5-editor-mastery
echo "the quick brown fox jumps over the lazy dog the the the" | python3 word-counter.py /dev/stdin

# Phase 3
cd students/STUDENT/phase-3/lesson-10-shell-scripting
bash hello.sh Alice
bash organize.sh /tmp/test-organize  # after creating test files
bash backup.sh /tmp/test-backup
bash log-analyzer.sh material/phase-3/data/sample.log

# Phase 4
cd students/STUDENT/phase-4/lesson-11-docker-basics
docker build -t student-app .
docker run -d --name test-app -p 5000:5000 student-app
curl localhost:5000
docker stop test-app && docker rm test-app
```
