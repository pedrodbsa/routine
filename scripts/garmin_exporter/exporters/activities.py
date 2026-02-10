"""Activity summaries exporter."""

from __future__ import annotations

import argparse
import datetime as dt
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Set

from ..utils import log_progress, read_existing_column
from .base import DatasetExporter


class ActivitiesExporter(DatasetExporter):
    name = "activities"
    help = "Export activity summaries"
    default_csv = Path("data/activities.csv")
    lookback_days = 1
    fieldnames = [
        "activity_id",
        "name",
        "type",
        "start_time_local",
        "start_time_gmt",
        "distance_m",
        "duration_s",
        "average_speed_mps",
        "max_speed_mps",
        "average_hr",
        "max_hr",
        "average_cadence_spm",
        "steps",
        "calories",
        "elevation_gain_m",
        "elevation_loss_m",
        "training_load",
        "training_effect",
        "vo2_max",
        "device_name",
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
            "--activity-type",
            type=str,
            default="",
            help="Optional activity type filter (e.g. running)",
        )
        parser.add_argument(
            "--csv",
            type=Path,
            default=self.default_csv,
            help="Output CSV path",
        )

    def load_existing_keys(self, csv_path: Path) -> Set[str]:
        return read_existing_column(csv_path, "activity_id")

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
            activities = client.get_activities_by_date(start, end, args.activity_type or "")
        except Exception as exc:  # noqa: BLE001
            print(f"Failed to fetch activities between {start} and {end}: {exc}", file=sys.stderr)
            return []

        rows: List[Dict[str, Any]] = []
        for activity in activities or []:
            activity_id = activity.get("activityId")
            if activity_id is None:
                continue
            key = str(activity_id)
            if key in existing_keys:
                log_progress(self.name, f"skip activity {key} (already stored)")
                continue
            log_progress(self.name, f"fetch activity {key}")
            row = _flatten_activity(activity)
            if row:
                rows.append(row)
                existing_keys.add(key)
        return rows

    def default_args(self) -> Dict[str, Any]:
        return {"activity_type": ""}


def _flatten_activity(activity: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    summary = activity.get("summaryDTO") or {}
    metadata = activity.get("metadataDTO") or {}

    activity_id = activity.get("activityId")
    if activity_id is None:
        return None

    def pick(*paths: Sequence[str]) -> Optional[Any]:
        for path in paths:
            value: Any = activity
            for key in path:
                if isinstance(value, dict):
                    value = value.get(key)
                else:
                    value = None
                    break
            if value is not None:
                return value
        return None

    avg_speed = pick(("averageSpeed",), ("summaryDTO", "averageSpeed")) or summary.get("averageSpeed")
    max_speed = pick(("maxSpeed",), ("summaryDTO", "maxSpeed")) or summary.get("maxSpeed")
    avg_hr = pick(("averageHR",), ("summaryDTO", "averageHR")) or summary.get("averageHR")
    max_hr = pick(("maxHR",), ("summaryDTO", "maxHR")) or summary.get("maxHR")

    return {
        "activity_id": str(activity_id),
        "name": activity.get("activityName") or summary.get("activityName"),
        "type": (activity.get("activityType") or {}).get("typeKey") or activity.get("activityTypeKey"),
        "start_time_local": activity.get("startTimeLocal") or summary.get("startTimeLocal"),
        "start_time_gmt": activity.get("startTimeGMT") or summary.get("startTimeGMT"),
        "distance_m": pick(("distance",), ("summaryDTO", "distance")) or summary.get("distance"),
        "duration_s": pick(("duration",), ("summaryDTO", "duration")) or summary.get("duration"),
        "average_speed_mps": avg_speed,
        "max_speed_mps": max_speed,
        "average_hr": avg_hr,
        "max_hr": max_hr,
        "average_cadence_spm": (
            activity.get("averageRunningCadenceInStepsPerMinute")
            or activity.get("avgRunCadence")
            or summary.get("averageRunCadence")
            or summary.get("averageCadence")
        ),
        "steps": activity.get("steps") or summary.get("steps"),
        "calories": pick(("calories",), ("summaryDTO", "calories")) or summary.get("calories"),
        "elevation_gain_m": (
            activity.get("elevationGain")
            or activity.get("totalElevationGain")
            or summary.get("totalElevationGain")
            or summary.get("elevationGain")
        ),
        "elevation_loss_m": (
            activity.get("elevationLoss")
            or activity.get("totalElevationLoss")
            or summary.get("totalElevationLoss")
            or summary.get("elevationLoss")
        ),
        "training_load": (
            activity.get("activityTrainingLoad")
            or activity.get("trainingLoad")
            or summary.get("activityTrainingLoad")
            or summary.get("trainingLoad")
        ),
        "training_effect": (
            activity.get("aerobicTrainingEffect")
            or summary.get("aerobicTrainingEffect")
        ),
        "vo2_max": (
            activity.get("vO2MaxValue")
            or activity.get("vo2MaxValue")
            or summary.get("vO2MaxValue")
            or summary.get("vo2MaxValue")
        ),
        "device_name": (
            activity.get("deviceId")
            or metadata.get("deviceName")
            or (activity.get("metadataDTO") or {}).get("deviceName")
        ),
    }
