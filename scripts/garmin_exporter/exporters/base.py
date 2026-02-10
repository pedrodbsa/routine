"""Base class for dataset exporters."""

from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Set, Tuple

from ..utils import default_start


BASELINE_START = "2025-08-01"


class DatasetExporter:
    name: str
    help: str
    default_csv: Path
    fieldnames: Sequence[str]
    default_start_static: Optional[str] = BASELINE_START
    default_start_days_back: Optional[int] = 30
    lookback_days: int = 0

    def add_arguments(self, parser: argparse.ArgumentParser) -> None:
        raise NotImplementedError

    def load_existing_keys(self, csv_path: Path) -> Set[str]:
        raise NotImplementedError

    def fetch_rows(
        self,
        client: Any,
        args: argparse.Namespace,
        existing_keys: Set[str],
    ) -> List[Dict[str, Any]]:
        raise NotImplementedError

    def default_start_str(self) -> str:
        if self.default_start_static:
            return self.default_start_static
        days = self.default_start_days_back if self.default_start_days_back is not None else 30
        return default_start(days)

    def default_end_str(self) -> str:
        return dt.date.today().isoformat()

    def start_from_state(self, state_value: Optional[str]) -> str:
        if state_value:
            try:
                last_date = dt.date.fromisoformat(state_value)
                start_date = last_date - dt.timedelta(days=self.lookback_days)
                baseline_str = self.default_start_str()
                try:
                    baseline_date = dt.date.fromisoformat(baseline_str)
                    if start_date < baseline_date:
                        start_date = baseline_date
                except ValueError:
                    pass
                return start_date.isoformat()
            except ValueError:
                pass
        return self.default_start_str()

    def next_state_value(
        self,
        args: argparse.Namespace,
        rows: List[Dict[str, Any]],
    ) -> Optional[str]:
        return getattr(args, "end", None)

    def default_args(self) -> Dict[str, Any]:
        return {}
