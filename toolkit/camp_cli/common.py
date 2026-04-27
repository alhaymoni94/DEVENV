"""Shared utilities for the camp CLI."""
import os
import sys
from pathlib import Path


class Colors:
    """ANSI color helpers."""
    BOLD = "\033[1m"
    CYAN = "\033[1;36m"
    BLUE = "\033[1;34m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    RED = "\033[31m"
    DIM = "\033[2m"
    RESET = "\033[0m"


def camp_dir() -> Path:
    """Resolve the camp root directory relative to this module."""
    # toolkit/camp_cli/common.py -> camp root is ../../
    return Path(__file__).resolve().parents[2]


def toolkit_dir() -> Path:
    """Resolve the toolkit directory."""
    return camp_dir() / "toolkit"


def students_dir() -> Path:
    """Resolve the students directory."""
    return camp_dir() / "students"


def student_dir(name: str | None = None) -> Path:
    """Resolve a specific student workspace directory."""
    if name is None:
        name = os.environ.get("USER", os.environ.get("USERNAME", "student"))
    return students_dir() / name


def material_dir() -> Path:
    """Resolve the material directory."""
    return camp_dir() / "material"


def phase_dir(phase: int, student: str | None = None) -> Path:
    """Resolve a student's phase directory."""
    return student_dir(student) / f"phase-{phase}"


def material_phase_dir(phase: int) -> Path:
    """Resolve a material phase directory."""
    return material_dir() / f"phase-{phase}"


def total_phases() -> int:
    """Return the total number of phases in the curriculum."""
    return 4


def header(title: str) -> str:
    """Return a formatted header box."""
    width = 54
    line = "═" * width
    pad = " " * ((width - len(title)) // 2)
    return (
        f"{Colors.CYAN}╔{line}╗{Colors.RESET}\n"
        f"{Colors.CYAN}║{pad}{Colors.BOLD}{title}{pad}{Colors.RESET}{Colors.CYAN}║{Colors.RESET}\n"
        f"{Colors.CYAN}╚{line}╝{Colors.RESET}"
    )


def ok(msg: str, detail: str = "") -> str:
    return f"  {Colors.GREEN}✓{Colors.RESET} {msg} {Colors.DIM}{detail}{Colors.RESET}"


def warn(msg: str, detail: str = "") -> str:
    return f"  {Colors.YELLOW}!{Colors.RESET} {msg} {Colors.DIM}{detail}{Colors.RESET}"


def fail(msg: str, detail: str = "") -> str:
    return f"  {Colors.RED}✗{Colors.RESET} {msg} {Colors.DIM}{detail}{Colors.RESET}"


def info(msg: str) -> str:
    return f"  {Colors.DIM}{msg}{Colors.RESET}"
