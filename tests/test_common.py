"""Tests for camp CLI common utilities."""
import sys
from pathlib import Path

# Ensure camp_cli is importable
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "toolkit"))

from camp_cli import common


def test_camp_dir_exists():
    d = common.camp_dir()
    assert d.exists()
    assert (d / "toolkit").exists()


def test_toolkit_dir_exists():
    d = common.toolkit_dir()
    assert d.exists()
    assert (d / "setup.sh").exists()


def test_students_dir_exists():
    d = common.students_dir()
    assert d.exists()
    assert (d / "template").exists()


def test_total_phases():
    assert common.total_phases() == 4


def test_header_format():
    h = common.header("Test")
    assert "Test" in h
    assert common.Colors.CYAN in h
