"""Dataset exporter registry."""

from __future__ import annotations

from .activities import ActivitiesExporter
from .base import BASELINE_START, DatasetExporter
from .body_battery import BodyBatteryExporter
from .body_battery_events import BodyBatteryEventsExporter
from .body_composition import BodyCompositionExporter
from .fitness_age import FitnessAgeExporter
from .hrv import HrvExporter
from .hydration import HydrationExporter
from .race_predictions import RacePredictionsExporter
from .respiration import RespirationExporter
from .sleep import SleepExporter
from .spo2 import Spo2Exporter
from .stats import StatsExporter
from .steps import DailyStepsExporter
from .stress import StressExporter
from .training_readiness import TrainingReadinessExporter

EXPORTERS = [
    SleepExporter(),
    ActivitiesExporter(),
    BodyCompositionExporter(),
    StatsExporter(),
    DailyStepsExporter(),
    # TrainingReadinessExporter(),
    BodyBatteryExporter(),
    BodyBatteryEventsExporter(),
    StressExporter(),
    RespirationExporter(),
    Spo2Exporter(),
    HydrationExporter(),
    FitnessAgeExporter(),
    HrvExporter(),
    RacePredictionsExporter(),
]

__all__ = [
    "EXPORTERS",
    "BASELINE_START",
    "DatasetExporter",
]
