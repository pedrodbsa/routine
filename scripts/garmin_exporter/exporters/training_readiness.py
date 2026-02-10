"""Training readiness exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class TrainingReadinessExporter(DatasetExporter):
    name = "training-readiness"
    help = "Export daily training readiness"
    default_csv = Path("data/training_readiness.csv")
    lookback_days = 1
    fieldnames = [
        "date",
        "level",
        "level_key",
        "sleep_score",
        "hrv_status",
        "body_battery_level",
        "resting_hr",
        "recent_exercise_load",
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
        start_date, end_date = ensure_date_range(args.start, args.end)
        log_progress(self.name, f"requesting {args.start} -> {args.end}")
        rows: List[Dict[str, Any]] = []
        for day in daterange(start_date, end_date):
            date_str = day.isoformat()
            if date_str in existing_keys:
                log_progress(self.name, f"skip {date_str} (already stored)")
                continue
            try:
                log_progress(self.name, f"fetch {date_str}")
                readiness = client.get_training_readiness(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch training readiness for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_training_readiness(date_str, readiness)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_training_readiness(
    date: str,
    payload: Optional[Dict[str, Any]],
) -> Optional[Dict[str, Any]]:
    if not payload:
        return None
    return {
        "date": date,
        "level": payload.get("trainingReadinessLevel"),
        "level_key": payload.get("trainingReadinessLevelKey"),
        "sleep_score": payload.get("sleepScore"),
        "hrv_status": payload.get("hrvStatus"),
        "body_battery_level": payload.get("bodyBatteryLevel"),
        "resting_hr": payload.get("restingHeartRate"),
        "recent_exercise_load": payload.get("recentExerciseLoad"),
    }
