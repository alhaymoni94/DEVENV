"""Shared test fixtures for camp CLI tests."""
import subprocess
from pathlib import Path
from typing import Generator
import pytest


@pytest.fixture
def tmp_student_dir(tmp_path: Path) -> Generator[Path, None, None]:
    """Create a temporary student workspace directory."""
    student_dir = tmp_path / "test_student"
    student_dir.mkdir()
    yield student_dir


@pytest.fixture
def tmp_git_repo(tmp_student_dir: Path) -> Path:
    """Initialize a git repo in the temporary student directory."""
    subprocess.run(
        ["git", "init", str(tmp_student_dir)],
        check=True,
        capture_output=True,
    )
    subprocess.run(
        ["git", "-C", str(tmp_student_dir), "config", "user.email", "test@test.com"],
        check=True,
        capture_output=True,
    )
    subprocess.run(
        ["git", "-C", str(tmp_student_dir), "config", "user.name", "Test"],
        check=True,
        capture_output=True,
    )
    return tmp_student_dir


def create_valid_python_file(path: Path, content: str = "#!/usr/bin/env python3\n# A valid script\nprint('hello')") -> None:
    """Create a valid Python file."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content)


def create_invalid_python_file(path: Path) -> None:
    """Create an invalid Python file with syntax error."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("def broken()\n    print('missing colon')")


def create_valid_bash_file(path: Path, content: str = "#!/usr/bin/env bash\n# A valid script\necho hello") -> None:
    """Create a valid bash script."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content)
    path.chmod(0o755)


def create_invalid_bash_file(path: Path) -> None:
    """Create an invalid bash script with syntax error."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("#!/usr/bin/env bash\necho \"unclosed")


def create_self_assessment(path: Path, score: int = 8) -> None:
    """Create a self-assessment markdown file."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(f"""# Self Assessment

## Lesson 1: AI Agents

| Skill | Score (1-10) |
|-------|--------------|
| Understanding | {score} |
| Completion | {score} |

Total: {score * 2}/20
""")


def make_git_commit(student_dir: Path, message: str = "Initial commit") -> None:
    """Stage and commit all files in the student directory."""
    subprocess.run(
        ["git", "-C", str(student_dir), "add", "-A"],
        check=True,
        capture_output=True,
    )
    subprocess.run(
        ["git", "-C", str(student_dir), "commit", "-m", message],
        check=True,
        capture_output=True,
    )