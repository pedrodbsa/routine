"""Daily steps exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class DailyStepsExporter(DatasetExporter):
    name = "steps"
    help = "Export daily steps totals"
    default_csv = Path("data/steps.csv")
    default_start_static = None
    default_start_days_back = 7
    lookback_days = 1
    fieldnames = [
        "date",
        "steps",
        "daily_step_goal",
    ]

    def add_arguments(self, parser: argparse.ArgumentParser) -> None:
        parser.add_argument(
            "--start",
            type=str,
            default=self.default_start_str(),
            help="Start date YYYY-MM-DD",
        )
        parser.add_argument(
            "--end",
            type=str,
            default=self.default_end_str(),
            help="End date YYYY-MM-DD",
        )
        parser.add_argument(
            "--csv",
            type=Path,
            default=self.default_csv,
            help="Output CSV path",
        )

    def load_existing_keys(self, csv_path: Path) -> Set[str]:
        return read_existing_column(csv_path, "date")

    def fetch_rows(
        self,
        client: Any,
        args: argparse.Namespace,
        existing_keys: Set[str],
    ) -> List[Dict[str, Any]]:
        ensure_date_range(args.start, args.end)
        log_progress(self.name, f"requesting {args.start} -> {args.end}")
        try:
            records = client.get_daily_steps(args.start, args.end)
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to fetch steps between {args.start} and {args.end}: {exc}", file=sys.stderr)
            return []

        rows: List[Dict[str, Any]] = []
        for record in records or []:
            row = _flatten_daily_steps(record)
            if not row:
                continue
            date_str = row.get("date")
            if not date_str or date_str in existing_keys:
                log_progress(self.name, f"skip {date_str} (already stored)")
                continue
            log_progress(self.name, f"fetch {date_str}")
            rows.append(row)
            existing_keys.add(date_str)
        return rows


def _flatten_daily_steps(record: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    if not record:
        return None
    date = record.get("calendarDate")
    if not date:
        return None
    steps = record.get("totalSteps")
    goal = record.get("stepGoal")
    # Skip if no actual data
    if steps is None and goal is None:
        return None
    return {
        "date": date,
        "steps": steps,
        "daily_step_goal": goal,
    }
