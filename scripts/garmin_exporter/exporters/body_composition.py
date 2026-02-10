"""Body composition exporter."""

from __future__ import annotations

import argparse
import datetime as dt
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from ..utils import log_progress, read_existing_column, ts_to_iso
from .base import DatasetExporter


class BodyCompositionExporter(DatasetExporter):
    name = "body"
    help = "Export body composition measurements"
    default_csv = Path("data/body_composition.csv")
    lookback_days = 1
    fieldnames = [
        "timestamp_utc",
        "date",
        "weight_kg",
        "bmi",
        "body_fat_pct",
        "body_water_pct",
        "bone_mass_kg",
        "muscle_mass_kg",
        "physique_rating",
        "visceral_fat_rating",
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
        return read_existing_column(csv_path, "timestamp_utc")

    def fetch_rows(
        self,
        client: Any,
        args: argparse.Namespace,
        existing_keys: Set[str],
    ) -> List[Dict[str, Any]]:
        start = args.start
        end = args.end
        log_progress(self.name, f"requesting {start} -> {end}")
        if dt.date.fromisoformat(end) < dt.date.fromisoformat(start):
            raise ValueError("End date must be on or after start date")

        try:
            if start == end:
                payload = client.get_body_composition(start)
            else:
                payload = client.get_body_composition(start, end)
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to fetch body composition between {start} and {end}: {exc}", file=sys.stderr)
            return []

        # API returns {"dateWeightList": [...], "totalAverage": {...}}
        if isinstance(payload, dict) and "dateWeightList" in payload:
            records = payload.get("dateWeightList", [])
        elif isinstance(payload, list):
            records = payload
        elif payload:
            records = [payload]
        else:
            records = []

        rows: List[Dict[str, Any]] = []
        for record in records:
            row = _flatten_body(record)
            if not row:
                continue
            key = row.get("timestamp_utc")
            if not key or key in existing_keys:
                log_progress(self.name, f"skip measurement {key} (already stored)")
                continue
            log_progress(self.name, f"fetch measurement {key}")
            rows.append(row)
            existing_keys.add(key)
        return rows


def _flatten_body(record: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    timestamp = record.get("measurementTimeStamp") or record.get("timestampGMT")
    iso_ts = ts_to_iso(timestamp)
    if not iso_ts:
        return None

    weight = record.get("weight")
    weight_kg = round(weight / 1000, 2) if weight is not None else None

    muscle_mass = record.get("muscleMass")
    muscle_mass_kg = round(muscle_mass / 1000, 2) if muscle_mass is not None else None

    bone_mass = record.get("boneMass")
    bone_mass_kg = round(bone_mass / 1000, 2) if bone_mass is not None else None

    return {
        "timestamp_utc": iso_ts,
        "date": iso_ts.split("T")[0],
        "weight_kg": weight_kg,
        "bmi": record.get("bmi"),
        "body_fat_pct": record.get("bodyFat"),
        "body_water_pct": record.get("bodyWater"),
        "bone_mass_kg": bone_mass_kg,
        "muscle_mass_kg": muscle_mass_kg,
        "physique_rating": record.get("physiqueRating"),
        "visceral_fat_rating": record.get("visceralFat"),
    }
