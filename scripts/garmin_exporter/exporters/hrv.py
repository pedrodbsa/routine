"""HRV (Heart Rate Variability) exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class HrvExporter(DatasetExporter):
    name = "hrv"
    help = "Export daily HRV (heart rate variability) data"
    default_csv = Path("data/hrv.csv")
    lookback_days = 1
    fieldnames = [
        "date",
        "last_night_avg_hrv_ms",
        "last_night_5min_high_hrv_ms",
        "weekly_avg_hrv_ms",
        "baseline_balanced_low_ms",
        "baseline_balanced_upper_ms",
        "status",
        "feedback",
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
                data = client.get_hrv_data(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch HRV for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_hrv(date_str, data)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_hrv(
    date: str,
    payload: Optional[Dict[str, Any]],
) -> Optional[Dict[str, Any]]:
    if not payload:
        return None

    hrv_summary = payload.get("hrvSummary") or {}
    baseline = hrv_summary.get("baseline") or {}

    return {
        "date": date,
        "last_night_avg_hrv_ms": hrv_summary.get("lastNightAvg") or payload.get("lastNightAvg"),
        "last_night_5min_high_hrv_ms": hrv_summary.get("lastNight5MinHigh") or payload.get("lastNight5MinHigh"),
        "weekly_avg_hrv_ms": hrv_summary.get("weeklyAvg") or payload.get("weeklyAvg"),
        "baseline_balanced_low_ms": baseline.get("balancedLow") or payload.get("baselineBalancedLow"),
        "baseline_balanced_upper_ms": baseline.get("balancedUpper") or payload.get("baselineBalancedUpper"),
        "status": hrv_summary.get("status") or payload.get("status"),
        "feedback": hrv_summary.get("feedbackPhrase") or payload.get("feedbackPhrase"),
    }
