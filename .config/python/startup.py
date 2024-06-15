"""Executed on startup of an interactive Python session."""

from __future__ import annotations

import os
import readline
import sys

# Exported for convenience
from dataclasses import dataclass as dataclass
from datetime import datetime as datetime
from datetime import time as time
from datetime import timedelta as timedelta
from pathlib import Path as Path
from pprint import pprint as pprint

# Disable default history file
readline.write_history_file = lambda *_: None


def launch_repl() -> None:
    """Launch a better REPL (ptpython), if available."""
    if sys.version_info < (3, 7):
        # Not compatible
        return

    # HACK: inject ptpython
    prefix = Path(os.getenv("HOMEBREW_PREFIX", "/opt/homebrew"))
    libs = list(prefix.joinpath("opt/ptpython/libexec/lib").glob("python*"))
    if not libs:
        return
    sys.path.append(str(libs[0] / "site-packages"))

    try:
        from ptpython.repl import PythonRepl, embed
    except ImportError:
        return

    # Configure repl
    def configure(repl: PythonRepl) -> None:
        repl.color_depth = "DEPTH_24_BIT"
        repl.complete_while_typing = True
        repl.confirm_exit = False
        repl.highlight_matching_parenthesis = True
        repl.show_signature = True
        repl.use_code_colorscheme("one-dark")

    # Enable history
    xdg_data = Path(os.getenv("XDG_DATA_HOME", "~/.local/share")).expanduser()
    history_file = xdg_data / "python" / "history"
    history_file.parent.mkdir(parents=True, exist_ok=True)

    # Launch
    sys.exit(
        embed(
            globals=globals(),
            configure=configure,
            history_filename=str(history_file),
        ),
    )


launch_repl()
