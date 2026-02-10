"""Daily stress exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class StressExporter(DatasetExporter):
    name = "stress"
    help = "Export daily stress metrics"
    default_csv = Path("data/stress.csv")
    lookback_days = 1
    fieldnames = [
        "date",
        "avg_stress",
        "max_stress",
        "stress_offset",
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
                payload = client.get_stress_data(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch stress data for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_stress(date_str, payload)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_stress(date: str, payload: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    if not payload:
        return None
    return {
        "date": date,
        "avg_stress": payload.get("avgStressLevel"),
        "max_stress": payload.get("maxStressLevel"),
        "stress_offset": payload.get("stressChartValueOffset"),
    }
