# syntax=docker/dockerfile:1

# Claude Code in Remote Control server mode and a Telegram channel session, plus the Garmin MCP
# and the scheduled-job scripts they need.
FROM debian:bookworm-slim

ARG VERSION=0.1.1
ARG CLAUDE_CODE_CHANNEL=latest
ARG UV_VERSION=0.11.31
ARG BUN_VERSION=1.4.2

# Published at https://code.claude.com/docs/en/setup#binary-integrity-and-code-signing
ARG CLAUDE_KEY_FINGERPRINT=31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl git gnupg jq less procps tmux tzdata unzip \
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

# Bun runs the Telegram channel plugin. The baseline x64 build avoids a hard AVX2 requirement on
# the server's CPU.
RUN case "$(dpkg --print-architecture)" in \
      amd64) target=x64-baseline ;; \
      arm64) target=aarch64 ;; \
      *) echo "unsupported architecture" >&2; exit 1 ;; \
    esac \
 && curl -fsSL -o /tmp/bun.zip \
      "https://github.com/oven-sh/bun/releases/download/bun-v${BUN_VERSION}/bun-linux-${target}.zip" \
 && unzip -j /tmp/bun.zip "bun-linux-${target}/bun" -d /usr/local/bin \
 && rm /tmp/bun.zip \
 && bun --version

COPY --chmod=0755 docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chmod=0755 docker/cron-git-sync.sh   /usr/local/bin/cron-git-sync
COPY --chmod=0755 docker/keep-alive.sh /usr/local/bin/keep-alive
COPY --chmod=0755 docker/claude-session-rc.sh /usr/local/bin/claude-session-rc
COPY --chmod=0755 docker/claude-session-telegram.sh /usr/local/bin/claude-session-telegram
COPY --chmod=0755 docker/cron-coach-tick.sh /usr/local/bin/cron-coach-tick
COPY --chmod=0755 docker/telegram-send.sh /usr/local/bin/telegram-send
COPY docker/garmin-sleep-ready.py /usr/local/lib/coach/garmin-sleep-ready.py

WORKDIR /app
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
