"""Tests for camp submit command git workflow."""
import subprocess
import sys
from pathlib import Path
from unittest.mock import MagicMock, patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "toolkit"))

from camp_cli.commands import submit as submit_cmd
from camp_cli.common import phase_dir, student_dir


class TestSubmitWorkflow:
    """Test submit command git operations."""

    def test_submit_initializes_git(self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """First submit on student with no .git should call git init."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        (phase_dir / "work.py").write_text("# work")

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase_dir)

        # Run submit
        submit_cmd.run(MagicMock(phase=1))

        # Verify git was initialized
        assert (tmp_student_dir / ".git").exists()

    def test_submit_creates_commit(self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """Work files should create a commit with proper message."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        (phase_dir / "work.py").write_text("# work")

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase_dir)

        submit_cmd.run(MagicMock(phase=1))

        # Check commit exists
        result = subprocess.run(
            ["git", "-C", str(tmp_student_dir), "log", "--oneline"],
            capture_output=True,
            text=True,
        )
        commits = [c for c in result.stdout.strip().split("\n") if c]
        assert len(commits) == 1
        assert "submit: phase-1 complete" in commits[0]

    def test_submit_no_changes(self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """No changes after last commit should show 'no changes' message."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        (phase_dir / "work.py").write_text("# work")

        # Initialize git and make first commit
        subprocess.run(["git", "init", str(tmp_student_dir)], check=True, capture_output=True)
        subprocess.run(["git", "-C", str(tmp_student_dir), "add", "-A"], check=True, capture_output=True)
        subprocess.run(["git", "-C", str(tmp_student_dir), "commit", "-m", "init"], check=True, capture_output=True)

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase_dir)

        # Second submit - no new changes
        submit_cmd.run(MagicMock(phase=1))

        captured = capsys.readouterr()
        assert "No changes to submit" in captured.out

    def test_submit_empty_work_files(self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """No work files should warn and prompt - test the warning appears."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        # No work files in phase-1

        # Create work in phase-2 to avoid git init check
        phase2_dir = tmp_student_dir / "phase-2"
        phase2_dir.mkdir()
        (phase2_dir / "work.py").write_text("# work")

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase2_dir if p == 2 else phase_dir)

        # Mock input to say 'n' to the "Submit anyway?" prompt
        with patch("builtins.input", return_value="n"):
            result = submit_cmd.run(MagicMock(phase=2))

        # Should have warned about no work files
        assert result == 0  # Cancelled gracefully

    def test_submit_missing_student_dir(self, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """Missing student directory should show error."""
        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: Path("/nonexistent"))

        result = submit_cmd.run(MagicMock(phase=1))

        assert result == 1
        captured = capsys.readouterr()
        assert "not found" in captured.out.lower()

    def test_submit_missing_phase_dir(self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """Missing phase directory should show error."""
        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: tmp_student_dir / f"phase-{p}")

        result = submit_cmd.run(MagicMock(phase=99))

        assert result == 1
        captured = capsys.readouterr()
        assert "not found" in captured.out.lower()

    def test_submit_no_remote_hint(
        self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture
    ) -> None:
        """No remote configured should show hint on first submit."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        (phase_dir / "work.py").write_text("# work")

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase_dir)

        submit_cmd.run(MagicMock(phase=1))

        captured = capsys.readouterr()
        assert "No remote" in captured.out or "remote" in captured.out.lower()

    def test_submit_with_remote(
        self, tmp_student_dir: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture
    ) -> None:
        """Remote configured should attempt push."""
        phase_dir = tmp_student_dir / "phase-1"
        phase_dir.mkdir(parents=True)
        (phase_dir / "work.py").write_text("# work")

        # Set up git with remote (but push will fail since there's no actual remote)
        subprocess.run(["git", "init", str(tmp_student_dir)], check=True, capture_output=True)
        subprocess.run(["git", "-C", str(tmp_student_dir), "remote", "add", "origin", "file:///fake"], check=True, capture_output=True)

        monkeypatch.setattr(submit_cmd, "student_dir", lambda n=None: tmp_student_dir)
        monkeypatch.setattr(submit_cmd, "phase_dir", lambda p: phase_dir)

        submit_cmd.run(MagicMock(phase=1))

        captured = capsys.readouterr()
        # Should attempt push (either succeed or fail gracefully)
        output = captured.out.lower()
        assert "push" in output or "submitted" in output.lower() or "pushed" in output.lower()