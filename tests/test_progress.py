"""Tests for camp progress command."""
import sys
from pathlib import Path
from unittest.mock import MagicMock

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "toolkit"))

from camp_cli.commands import progress as progress_cmd


class TestProgressCommand:
    """Test progress command output and logic."""

    def test_progress_missing_student_dir(self, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture) -> None:
        """Missing student directory should return error."""
        monkeypatch.setattr(progress_cmd, "student_dir", lambda n=None: Path("/nonexistent"))

        result = progress_cmd.run(MagicMock())

        assert result == 1
        captured = capsys.readouterr()
        assert "not found" in captured.out.lower()

    def test_progress_shows_header(self, monkeypatch: pytest.MonkeyPatch, tmp_path: Path, capsys: pytest.CaptureFixture) -> None:
        """Progress should display header."""
        student_dir = tmp_path / "student"
        student_dir.mkdir(parents=True)

        # Create minimal material structure
        mat_p1 = tmp_path / "material/phase-1"
        mat_p1.mkdir(parents=True)
        (mat_p1 / "lesson-1").mkdir(parents=True)

        def mock_material(p: int) -> Path:
            return mat_p1 if p == 1 else tmp_path / f"material/phase-{p}"

        monkeypatch.setattr(progress_cmd, "student_dir", lambda n=None: student_dir)
        monkeypatch.setattr(progress_cmd, "material_phase_dir", mock_material)

        result = progress_cmd.run(MagicMock())

        assert result == 0
        captured = capsys.readouterr()
        assert "Camp Progress" in captured.out

    def test_progress_shows_milestones(self, monkeypatch: pytest.MonkeyPatch, tmp_path: Path, capsys: pytest.CaptureFixture) -> None:
        """Progress should display milestone list."""
        student_dir = tmp_path / "student"
        student_dir.mkdir(parents=True)

        mat_p1 = tmp_path / "material/phase-1"
        mat_p1.mkdir(parents=True)
        (mat_p1 / "lesson-1").mkdir(parents=True)

        def mock_material(p: int) -> Path:
            return mat_p1 if p == 1 else tmp_path / f"material/phase-{p}"

        monkeypatch.setattr(progress_cmd, "student_dir", lambda n=None: student_dir)
        monkeypatch.setattr(progress_cmd, "material_phase_dir", mock_material)

        result = progress_cmd.run(MagicMock())

        captured = capsys.readouterr()
        assert "Milestones" in captured.out
        assert "Phase 1 complete" in captured.out

    def test_progress_empty_shows_0_percent(self, monkeypatch: pytest.MonkeyPatch, tmp_path: Path, capsys: pytest.CaptureFixture) -> None:
        """Empty workspace should show 0% progress."""
        student_dir = tmp_path / "student"
        student_dir.mkdir(parents=True)

        mat_p1 = tmp_path / "material/phase-1"
        mat_p1.mkdir(parents=True)
        (mat_p1 / "lesson-1").mkdir(parents=True)

        def mock_material(p: int) -> Path:
            return mat_p1 if p == 1 else tmp_path / f"material/phase-{p}"

        monkeypatch.setattr(progress_cmd, "student_dir", lambda n=None: student_dir)
        monkeypatch.setattr(progress_cmd, "material_phase_dir", mock_material)

        result = progress_cmd.run(MagicMock())

        captured = capsys.readouterr()
        assert "0%" in captured.out
        assert "0/1" in captured.out