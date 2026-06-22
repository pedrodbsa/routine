# Spike image — Rust garmin-cli (prebuilt binary) + DuckDB CLI for the
# TrackPoint ingestion spike.
#
# Why a container: garmin-cli does not install cleanly on Windows; the
# athlete's host is Windows. This image pulls the prebuilt Linux binary and
# bundles the DuckDB CLI so the synced Parquet store can be inspected in place.
#
# The image is stateless. All state — the SSO token and the Parquet store —
# lives under $HOME (=/data), which MUST be a mounted volume so it survives
# `docker run` invocations. Nothing here is committed except this Dockerfile.
#
# Build:  docker build -t garmin-spike docs/superpowers/spikes/trackpoint
# Run:    docker run --rm -it -v garmin_spike_data:/data garmin-spike

# trixie (glibc 2.41), not bookworm (glibc 2.36): the prebuilt garmin binary needs GLIBC_2.38.
FROM debian:trixie-slim

# ca-certificates: TLS to the Garmin API. curl/unzip/tar: fetch garmin + duckdb.
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl unzip tar \
    && rm -rf /var/lib/apt/lists/*

# Prebuilt garmin-cli release binary (provided by the maintainer).
# The v2.1.0 tarball ships a platform-suffixed binary (garmin-linux-amd64), not a
# bare `garmin`, so match that exact name and install it under the expected name.
ARG GARMIN_CLI_VERSION=2.1.0
ARG GARMIN_ASSET=garmin-linux-amd64

RUN curl -fsSL -o /tmp/garmin.tar.gz \
      https://github.com/vicentereig/garmin-cli/releases/download/v${GARMIN_CLI_VERSION}/${GARMIN_ASSET}.tar.gz \
    && mkdir -p /tmp/garmin-extract \
    && tar -xzf /tmp/garmin.tar.gz -C /tmp/garmin-extract \
    && find /tmp/garmin-extract -type f -name "${GARMIN_ASSET}" -exec install -m 0755 {} /usr/local/bin/garmin \; \
    && rm -rf /tmp/garmin.tar.gz /tmp/garmin-extract \
    && garmin --version

# DuckDB CLI to query the Parquet store directly.
ARG DUCKDB_VERSION=1.1.3
RUN curl -fsSL -o /tmp/duckdb.zip \
      https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip \
    && unzip /tmp/duckdb.zip -d /usr/local/bin \
    && rm /tmp/duckdb.zip \
    && chmod +x /usr/local/bin/duckdb

# garmin-cli writes its token and Parquet store under $HOME/.local/share/garmin.
# Pointing HOME at the mounted volume persists both across container runs.
ENV HOME=/data
VOLUME /data
WORKDIR /data

ENTRYPOINT ["/bin/bash"]
