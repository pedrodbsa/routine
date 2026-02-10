"""Sleep data exporter."""

from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path
import sys
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, log_progress, read_existing_column, ts_to_iso
from .base import DatasetExporter


class SleepExporter(DatasetExporter):
    name = "sleep"
    help = "Export daily sleep summaries"
    default_csv = Path("data/sleep.csv")
    lookback_days = 1
    fieldnames = [
        "date",
        "sleep_start_utc",
        "sleep_end_utc",
        "sleep_time_seconds",
        "nap_time_seconds",
        "deep_sleep_seconds",
        "light_sleep_seconds",
        "rem_sleep_seconds",
        "awake_sleep_seconds",
        "awake_count",
        "restless_count",
        "avg_sleep_stress",
        "avg_hr",
        "resting_hr",
        "sleep_score",
        "sleep_score_qualifier",
        "sleep_score_feedback",
        "body_battery_change",
        "avg_respiration",
        "lowest_respiration",
        "highest_respiration",
        "sleep_need_minutes",
        "hrv_avg",
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
        log_progress(self.name, f"requesting {args.start} -> {args.end}")
        start_date = dt.date.fromisoformat(args.start)
        end_date = dt.date.fromisoformat(args.end)
        if end_date < start_date:
            raise ValueError("End date must be on or after start date")

        rows: List[Dict[str, Any]] = []
        for day in daterange(start_date, end_date):
            date_str = day.isoformat()
            if date_str in existing_keys:
                log_progress(self.name, f"skip {date_str} (already stored)")
                continue
            try:
                log_progress(self.name, f"fetch {date_str}")
                sleep_data = client.get_sleep_data(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch sleep data for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_sleep(sleep_data)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_sleep(record: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    daily = record.get("dailySleepDTO") or {}
    if not daily:
        return None
    date = daily.get("calendarDate")
    if not date:
        return None

    scores = (daily.get("sleepScores") or {}).get("overall") or {}
    sleep_need = daily.get("sleepNeed") or {}

    return {
        "date": date,
        "sleep_start_utc": ts_to_iso(daily.get("sleepStartTimestampGMT")),
        "sleep_end_utc": ts_to_iso(daily.get("sleepEndTimestampGMT")),
        "sleep_time_seconds": daily.get("sleepTimeSeconds"),
        "nap_time_seconds": daily.get("napTimeSeconds"),
        "deep_sleep_seconds": daily.get("deepSleepSeconds"),
        "light_sleep_seconds": daily.get("lightSleepSeconds"),
        "rem_sleep_seconds": daily.get("remSleepSeconds"),
        "awake_sleep_seconds": daily.get("awakeSleepSeconds"),
        "awake_count": daily.get("awakeCount"),
        "restless_count": daily.get("restlessMomentsCount"),
        "avg_sleep_stress": daily.get("avgSleepStress"),
        "avg_hr": daily.get("avgHeartRate"),
        "resting_hr": daily.get("restingHeartRate"),
        "sleep_score": scores.get("value"),
        "sleep_score_qualifier": scores.get("qualifierKey"),
        "sleep_score_feedback": daily.get("sleepScoreFeedback"),
        "body_battery_change": record.get("bodyBatteryChange"),
        "avg_respiration": daily.get("averageRespirationValue"),
        "lowest_respiration": daily.get("lowestRespirationValue"),
        "highest_respiration": daily.get("highestRespirationValue"),
        "sleep_need_minutes": sleep_need.get("actual"),
        "hrv_avg": record.get("avgOvernightHrv"),
    }
