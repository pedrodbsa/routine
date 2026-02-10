"""Fitness age exporter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import daterange, ensure_date_range, log_progress, read_existing_column
from .base import DatasetExporter


class FitnessAgeExporter(DatasetExporter):
    name = "fitness-age"
    help = "Export daily fitness age data"
    default_csv = Path("data/fitness_age.csv")
    lookback_days = 7
    fieldnames = [
        "date",
        "fitness_age_years",
        "chronological_age_years",
        "age_difference_years",
        "achievable_fitness_age_years",
        "rhr",
        "vigorous_days_avg",
        "vigorous_minutes_avg",
        "bmi",
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
                data = client.get_fitnessage_data(date_str)
            except Exception as exc:  # noqa: BLE001
                print(f"Failed to fetch fitness age for {date_str}: {exc}", file=sys.stderr)
                continue
            row = _flatten_fitness_age(date_str, data)
            if row:
                rows.append(row)
                existing_keys.add(date_str)
        return rows


def _flatten_fitness_age(
    date: str,
    payload: Optional[Dict[str, Any]],
) -> Optional[Dict[str, Any]]:
    if not payload:
        return None

    components = payload.get("components") or {}

    return {
        "date": date,
        "fitness_age_years": payload.get("fitnessAge"),
        "chronological_age_years": payload.get("chronologicalAge"),
        "age_difference_years": payload.get("ageDifference"),
        "achievable_fitness_age_years": payload.get("achievableFitnessAge"),
        "rhr": _get_component_value(components, "rhr"),
        "vigorous_days_avg": _get_component_value(components, "vigorousDaysAvg"),
        "vigorous_minutes_avg": _get_component_value(components, "vigorousMinutesAvg"),
        "bmi": _get_component_value(components, "bmi"),
    }


def _get_component_value(components: Dict[str, Any], key: str) -> Optional[Any]:
    component = components.get(key)
    if isinstance(component, dict):
        return component.get("value")
    return component
