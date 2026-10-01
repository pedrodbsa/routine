# syntax=docker/dockerfile:1

# Claude Code in Remote Control server mode and the coach session (Telegram channel), plus the
# Garmin MCP and the scheduled-job scripts they need.
FROM debian:bookworm-slim

ARG VERSION=0.1.1
ARG CLAUDE_CODE_CHANNEL=latest
ARG UV_VERSION=0.11.31

# Published at https://code.claude.com/docs/en/setup#binary-integrity-and-code-signing
ARG CLAUDE_KEY_FINGERPRINT=31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl git gnupg jq less procps tmux tzdata \
 && rm -rf /var/lib/apt/lists/*

# Anthropic's signed apt repository rather than npm: no Node runtime, and no background
# auto-updater, so the running version changes only when this image is rebuilt.
RUN install -d -m 0755 /etc/apt/keyrings \
 && curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
      -o /etc/apt/keyrings/claude-code.asc \
 && gpg --show-keys --with-colons /etc/apt/keyrings/claude-code.asc \
      | grep -q ":${CLAUDE_KEY_FINGERPRINT}:" \
 && echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc]" \
         "https://downloads.claude.ai/claude-code/apt/${CLAUDE_CODE_CHANNEL}" \
         "${CLAUDE_CODE_CHANNEL} main" \
      > /etc/apt/sources.list.d/claude-code.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends claude-code \
 && rm -rf /var/lib/apt/lists/*

# uv runs the Garmin MCP. Its data must sit outside /root, which the runtime mount shadows.
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python \
    UV_CACHE_DIR=/opt/uv/cache
RUN curl -LsSf "https://astral.sh/uv/${UV_VERSION}/install.sh" \
      | env UV_INSTALL_DIR=/usr/local/bin sh \
 && uv python install 3.12

# git authenticates to GitHub with GITHUB_TOKEN from the environment, read when git asks, so the
# token is never written to disk. A token in the remote URL would land in .git/config in
# cleartext and outrank this helper once it went stale.
RUN git config --system credential.https://github.com.helper \
      '!f() { echo username=x-access-token; echo "password=${GITHUB_TOKEN}"; }; f'

# Bun runs the Telegram channel plugin: one binary, copied from the official image.
COPY --from=docker.io/oven/bun:1.4.2-slim /usr/local/bin/bun /usr/local/bin/bun

COPY --chmod=0755 docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chmod=0755 docker/cron-git-sync.sh   /usr/local/bin/cron-git-sync
COPY --chmod=0755 docker/util-keep-alive.sh /usr/local/bin/util-keep-alive
COPY --chmod=0755 docker/claude-session-rc.sh /usr/local/bin/claude-session-rc
COPY --chmod=0755 docker/claude-session-coach.sh /usr/local/bin/claude-session-coach
COPY --chmod=0755 docker/cron-morning.sh /usr/local/bin/cron-morning
COPY --chmod=0755 docker/cron-recap.sh /usr/local/bin/cron-recap
COPY --chmod=0755 docker/cron-report.sh /usr/local/bin/cron-report
COPY --chmod=0755 docker/util-coach-send.sh /usr/local/bin/util-coach-send
COPY --chmod=0755 docker/util-telegram-send.sh /usr/local/bin/util-telegram-send
COPY docker/garmin-sleep-ready.py /usr/local/lib/coach/garmin-sleep-ready.py

WORKDIR /app
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
