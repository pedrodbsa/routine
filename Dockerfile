# syntax=docker/dockerfile:1

# Claude Code in Remote Control server mode, plus the Garmin MCP it needs.
FROM debian:bookworm-slim

ARG CLAUDE_CODE_CHANNEL=stable
ARG UV_VERSION=0.11.31

# Published at https://code.claude.com/docs/en/setup#binary-integrity-and-code-signing
ARG CLAUDE_KEY_FINGERPRINT=31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl git gnupg less procps tzdata \
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

COPY --chmod=0755 docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chmod=0755 docker/git-sync.sh   /usr/local/bin/git-sync

WORKDIR /app
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
