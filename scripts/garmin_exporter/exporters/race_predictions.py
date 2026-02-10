"""Race predictions exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import log_progress, read_existing_column
from .base import DatasetExporter


class RacePredictionsExporter(DatasetExporter):
    name = "race-predictions"
    help = "Export race time predictions (5K, 10K, half marathon, marathon)"
    default_csv = Path("data/race_predictions.csv")
    lookback_days = 7
    fieldnames = [
        "date",
        "pred_5k_seconds",
        "pred_5k_time",
        "pred_10k_seconds",
        "pred_10k_time",
        "pred_half_marathon_seconds",
        "pred_half_marathon_time",
        "pred_marathon_seconds",
        "pred_marathon_time",
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
        log_progress(self.name, "fetching latest race predictions")

        try:
            data = client.get_race_predictions()
            log_progress(self.name, f"API response keys: {list(data.keys()) if data else 'None'}")
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to fetch race predictions: {exc}", file=sys.stderr)
            return []

        row = _flatten_race_predictions(data)
        if not row:
            log_progress(self.name, "no valid prediction data in response")
            return []

        date_str = row["date"]
        if date_str in existing_keys:
            log_progress(self.name, f"skip {date_str} (already stored)")
            return []

        log_progress(self.name, f"storing predictions for {date_str}")
        return [row]


def _format_seconds(seconds: Optional[float]) -> Optional[str]:
    """Format seconds as HH:MM:SS or MM:SS."""
    if seconds is None:
        return None
    total = int(seconds)
    hours, remainder = divmod(total, 3600)
    minutes, secs = divmod(remainder, 60)
    if hours:
        return f"{hours}:{minutes:02d}:{secs:02d}"
    return f"{minutes}:{secs:02d}"


def _flatten_race_predictions(
    payload: Optional[Dict[str, Any]],
) -> Optional[Dict[str, Any]]:
    if not payload:
        return None

    # Get prediction date from response
    date = payload.get("calendarDate") or payload.get("prediction_date")
    if not date:
        return None

    result: Dict[str, Any] = {"date": date}

    # Raw API format: time5K, time10K, timeHalfMarathon, timeMarathon (seconds as float)
    api_key_map = {
        "time5K": ("pred_5k_seconds", "pred_5k_time"),
        "time10K": ("pred_10k_seconds", "pred_10k_time"),
        "timeHalfMarathon": ("pred_half_marathon_seconds", "pred_half_marathon_time"),
        "timeMarathon": ("pred_marathon_seconds", "pred_marathon_time"),
    }

    has_data = False
    for api_key, (seconds_col, time_col) in api_key_map.items():
        seconds_val = payload.get(api_key)
        if seconds_val is not None:
            result[seconds_col] = int(seconds_val)
            result[time_col] = _format_seconds(seconds_val)
            has_data = True
        else:
            result[seconds_col] = None
            result[time_col] = None

    return result if has_data else None
