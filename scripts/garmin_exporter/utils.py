"""Shared utility helpers for exporter modules."""

from __future__ import annotations

import csv
import datetime as dt
from pathlib import Path
from typing import Any, Dict, Iterable, Optional, Sequence, Set, Tuple


__all__ = [
    "append_rows",
    "daterange",
    "default_start",
    "ensure_date_range",
    "log_progress",
    "read_existing_column",
    "ts_to_iso",
]


def ts_to_iso(ts: Optional[int | str]) -> Optional[str]:
    if ts in (None, 0, "", "0"):
        return None
    # Handle string timestamps from API
    if isinstance(ts, str):
        # If already ISO format, return as-is
        if "T" in ts or "-" in ts:
            return ts
        ts = int(ts)
    return dt.datetime.fromtimestamp(ts / 1000, dt.timezone.utc).isoformat()


def default_start(days_back: int) -> str:
    return (dt.date.today() - dt.timedelta(days=days_back)).isoformat()


def ensure_date_range(start: str, end: str) -> Tuple[dt.date, dt.date]:
    start_date = dt.date.fromisoformat(start)
    end_date = dt.date.fromisoformat(end)
    if end_date < start_date:
        raise ValueError("End date must be on or after start date")
    return start_date, end_date


def daterange(start: dt.date, end: dt.date) -> Iterable[dt.date]:
    current = start
    while current <= end:
        yield current
        current += dt.timedelta(days=1)


def read_existing_column(csv_path: Path, column: str) -> Set[str]:
    if not csv_path.exists():
        return set()
    with csv_path.open("r", newline="", encoding="utf-8") as fp:
        reader = csv.DictReader(fp)
        return {row[column] for row in reader if row.get(column)}


def append_rows(
    csv_path: Path,
    fieldnames: Sequence[str],
    rows: Iterable[Dict[str, Any]],
) -> None:
    materialized = [row for row in rows if row]
    if not materialized:
        return
    csv_path.parent.mkdir(parents=True, exist_ok=True)
    file_exists = csv_path.exists()
    with csv_path.open("a", newline="", encoding="utf-8") as fp:
        writer = csv.DictWriter(fp, fieldnames=fieldnames)
        if not file_exists:
            writer.writeheader()
        for row in materialized:
            writer.writerow(row)


def log_progress(dataset: str, message: str) -> None:
    print(f"{dataset}: {message}")
