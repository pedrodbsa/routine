"""Daily activity stats exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class StatsExporter(DatasetExporter):
    name = "stats"
    help = "Export daily activity stats"
    default_csv = Path("data/stats.csv")
    lookback_days = 1
    fieldnames = [
        "date",
        "total_kilocalories",
        "active_kilocalories",
        "bmr_kilocalories",
        "wellness_kilocalories",
        "burned_kilocalories",
        "total_steps",
        "daily_step_goal",
        "wellness_distance_m",
        "wellness_active_kilocalories",
        "average_stress_level",
        "max_stress_level",
        "resting_hr",
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
                stats = client.get_stats(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch stats for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_stats(date_str, stats)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_stats(date: str, stats: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    if not stats:
        return None
    return {
        "date": date,
        "total_kilocalories": stats.get("totalKilocalories"),
        "active_kilocalories": stats.get("activeKilocalories"),
        "bmr_kilocalories": stats.get("bmrKilocalories"),
        "wellness_kilocalories": stats.get("wellnessKilocalories"),
        "burned_kilocalories": stats.get("burnedKilocalories"),
        "total_steps": stats.get("totalSteps"),
        "daily_step_goal": stats.get("dailyStepGoal"),
        "wellness_distance_m": stats.get("wellnessDistanceMeters"),
        "wellness_active_kilocalories": stats.get("wellnessActiveKilocalories"),
        "average_stress_level": stats.get("averageStressLevel"),
        "max_stress_level": stats.get("maxStressLevel"),
        "resting_hr": stats.get("restingHeartRate"),
    }
