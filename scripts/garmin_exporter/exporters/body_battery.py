"""Body battery summaries exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import ensure_date_range, log_progress, read_existing_column, ts_to_iso
from .base import DatasetExporter


class BodyBatteryExporter(DatasetExporter):
    name = "body-battery"
    help = "Export body battery summaries"
    default_csv = Path("data/body_battery.csv")
    default_start_static = None
    default_start_days_back = 7
    lookback_days = 1
    fieldnames = [
        "start_timestamp_utc",
        "end_timestamp_utc",
        "charged_value",
        "drained_value",
        "most_recent_value",
        "last_value_timestamp_utc",
        "last_value",
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
        return read_existing_column(csv_path, "start_timestamp_utc")

    def fetch_rows(
        self,
        client: Any,
        args: argparse.Namespace,
        existing_keys: Set[str],
    ) -> List[Dict[str, Any]]:
        ensure_date_range(args.start, args.end)
        log_progress(self.name, f"requesting {args.start} -> {args.end}")
        try:
            records = client.get_body_battery(args.start, args.end)
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to fetch body battery between {args.start} and {args.end}: {exc}", file=sys.stderr)
            return []

        rows: List[Dict[str, Any]] = []
        for record in records or []:
            row = _flatten_body_battery(record)
            if not row:
                continue
            key = row.get("start_timestamp_utc")
            if not key or key in existing_keys:
                log_progress(self.name, f"skip session {key} (already stored)")
                continue
            log_progress(self.name, f"fetch session {key}")
            rows.append(row)
            existing_keys.add(key)
        return rows


def _flatten_body_battery(record: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    if not record:
        return None
    # bodyBatteryValuesArray is a 2D array: [[timestamp, value], ...]
    values = record.get("bodyBatteryValuesArray") or []
    last_value = values[-1] if values else None
    charged = record.get("charged")
    drained = record.get("drained")
    # Skip if no actual data (feature not available or disabled)
    if charged is None and drained is None and not values:
        return None
    return {
        "start_timestamp_utc": ts_to_iso(record.get("startTimestampGMT")),
        "end_timestamp_utc": ts_to_iso(record.get("endTimestampGMT")),
        "charged_value": charged,
        "drained_value": drained,
        "most_recent_value": last_value[1] if last_value and len(last_value) > 1 else None,
        "last_value_timestamp_utc": ts_to_iso(last_value[0]) if last_value and len(last_value) > 0 else None,
        "last_value": last_value[1] if last_value and len(last_value) > 1 else None,
    }
