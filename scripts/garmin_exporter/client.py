"""Client helpers for accessing the Garmin API."""

from __future__ import annotations

import os
from pathlib import Path
from typing import Optional

from garminconnect import Garmin, GarminConnectAuthenticationError
from garth.exc import GarthHTTPError


def _load_secret(env_key: str, file_env_key: str) -> Optional[str]:
    """Return secret value either from env var or text file referenced by env var."""
    value = os.environ.get(env_key)
    file_path = os.environ.get(file_env_key)
    if value and file_path:
        raise ValueError(f"Provide either {env_key} or {file_env_key}, not both")
    if file_path:
        return Path(file_path).expanduser().read_text(encoding="utf-8").strip()
    return value


def init_client() -> Garmin:
    """Initialise Garmin client, reusing stored tokens when possible."""
    email = _load_secret("GARMIN_EMAIL", "GARMIN_EMAIL_FILE")
    password = _load_secret("GARMIN_PASSWORD", "GARMIN_PASSWORD_FILE")
    tokenstore = os.getenv("GARMINTOKENS", "~/.garminconnect")
    tokenstore = os.path.expanduser(tokenstore)

    try:
        client = Garmin()
        client.login(tokenstore)
        return client
    except (FileNotFoundError, GarthHTTPError, GarminConnectAuthenticationError):
        if not email or not password:
            raise RuntimeError(
                "Garmin credentials missing. Set GARMIN_EMAIL(_FILE) and GARMIN_PASSWORD(_FILE)."
            ) from None
        client = Garmin(email=email, password=password, is_cn=False)
        client.login()
        store_path = Path(tokenstore).expanduser()
        store_path.parent.mkdir(parents=True, exist_ok=True)
        client.garth.dump(str(store_path))
        return client
