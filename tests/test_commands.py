"""Tests for camp CLI commands."""
import sys
from pathlib import Path
from unittest.mock import MagicMock

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "toolkit"))

from camp_cli.commands import next as next_cmd
from camp_cli.commands import progress as progress_cmd
from camp_cli.commands import evaluate as evaluate_cmd


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
