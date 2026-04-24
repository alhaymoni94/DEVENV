"""Tests for camp CLI commands."""
import subprocess
import sys
from pathlib import Path
from unittest.mock import MagicMock

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "toolkit"))

from camp_cli.commands import next as next_cmd
from camp_cli.commands import progress as progress_cmd
from camp_cli.commands import evaluate as evaluate_cmd
from camp_cli.commands import submit as submit_cmd


def test_next_shows_workspace_hint_when_missing(monkeypatch, capsys):
    monkeypatch.setattr(
        "camp_cli.commands.next.student_dir",
        lambda name=None: Path("/nonexistent/student"),
    )
    args = MagicMock()
    ret = next_cmd.run(args)
    assert ret == 0
    captured = capsys.readouterr()
    assert "not found" in captured.out
    assert "cp -r students/template" in captured.out


def test_progress_shows_error_when_missing(monkeypatch, capsys):
    monkeypatch.setattr(
        "camp_cli.commands.progress.student_dir",
        lambda name=None: Path("/nonexistent/student"),
    )
    args = MagicMock()
    ret = progress_cmd.run(args)
    assert ret == 1
    captured = capsys.readouterr()
    assert "not found" in captured.out


def test_evaluate_all_students_no_dir(monkeypatch, capsys):
    monkeypatch.setattr(
        "camp_cli.commands.evaluate.students_dir",
        lambda: Path("/nonexistent/students"),
    )
    monkeypatch.setattr(
        "camp_cli.commands.evaluate.student_dir",
        lambda name=None: Path("/nonexistent/students/test"),
    )
    args = MagicMock(student=None, phase=None)
    ret = evaluate_cmd.run(args)
    assert ret == 1
    captured = capsys.readouterr()
    assert "not found" in captured.out


def test_evaluate_phase_missing_directory(monkeypatch, capsys):
    monkeypatch.setattr(
        "camp_cli.commands.evaluate.phase_dir",
        lambda phase, student: Path("/nonexistent/phase"),
    )
    score, max_score, issues = evaluate_cmd.evaluate_phase("test", 1)
    assert score == 0
    assert issues == ["Directory missing"]


def _make_git_repo(path: Path) -> None:
    """Initialize a bare git repo suitable for testing submit."""
    subprocess.run(["git", "init", str(path)], check=True, capture_output=True)
    subprocess.run(["git", "-C", str(path), "config", "user.email", "t@t.com"], check=True, capture_output=True)
    subprocess.run(["git", "-C", str(path), "config", "user.name", "T"], check=True, capture_output=True)


def test_submit_no_remote_shows_hint_once(tmp_path, monkeypatch, capsys):
    """No remote configured: hint appears on first submit, not on second."""
    sdir = tmp_path / "student"
    sdir.mkdir()
    pdir = sdir / "phase-1"
    pdir.mkdir()
    (pdir / "work.py").write_text("# work")
    _make_git_repo(sdir)

    monkeypatch.setattr("camp_cli.commands.submit.student_dir", lambda: sdir)
    monkeypatch.setattr("camp_cli.commands.submit.phase_dir", lambda p: pdir)

    # First submit — hint should appear
    submit_cmd.run(MagicMock(phase=1))
    out1 = capsys.readouterr().out
    assert "No remote configured" in out1

    # Second submit (adds another file so there are changes to commit)
    (pdir / "work2.py").write_text("# more work")
    submit_cmd.run(MagicMock(phase=1))
    out2 = capsys.readouterr().out
    assert "No remote configured" not in out2
