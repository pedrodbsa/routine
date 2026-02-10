"""Body battery events exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column, ts_to_iso
from .base import DatasetExporter


class BodyBatteryEventsExporter(DatasetExporter):
    name = "body-battery-events"
    help = "Export body battery events"
    default_csv = Path("data/body_battery_events.csv")
    default_start_static = None
    default_start_days_back = 7
    lookback_days = 1
    fieldnames = [
        "date",
        "event_type",
        "impact",
        "start_timestamp_utc",
        "end_timestamp_utc",
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
        start_date, end_date = ensure_date_range(args.start, args.end)
        log_progress(self.name, f"requesting {args.start} -> {args.end}")
        rows: List[Dict[str, Any]] = []
        for day in daterange(start_date, end_date):
            date_str = day.isoformat()
            try:
                log_progress(self.name, f"fetch {date_str}")
                payload = client.get_body_battery_events(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch body battery events for {date_str}: {exc}", file=sys.stderr)
                continue
            # Handle both list response and dict with "events" key
            events = payload if isinstance(payload, list) else (payload or {}).get("events", [])
            for event in events:
                row = _flatten_body_battery_event(date_str, event)
                if not row:
                    continue
                key = row.get("start_timestamp_utc")
                if not key or key in existing_keys:
                    log_progress(self.name, f"skip event {key} (already stored)")
                    continue
                log_progress(self.name, f"store event {key}")
                rows.append(row)
                existing_keys.add(key)
        return rows


def _flatten_body_battery_event(date: str, event: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    if not event:
        return None
    start = ts_to_iso(event.get("eventStartTimeGmt"))
    end = ts_to_iso(event.get("eventEndTimeGmt"))
    if not start:
        return None
    return {
        "date": date,
        "event_type": event.get("eventType"),
        "impact": event.get("bodyBatteryImpact"),
        "start_timestamp_utc": start,
        "end_timestamp_utc": end,
    }
