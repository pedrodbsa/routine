#!/usr/bin/env bash
set -euo pipefail

if [ -n "${GIT_AUTHOR_NAME:-}" ]; then
  git config --global user.name "${GIT_AUTHOR_NAME}"
  git config --global user.email "${GIT_AUTHOR_EMAIL:-}"
fi

# A helper keeps the token in the environment. Putting it in the remote URL would write it
# in cleartext to .git/config.
if [ -n "${GITHUB_TOKEN:-}" ]; then
  git config --global credential.helper \
    '!f() { echo username=x-access-token; echo "password=${GITHUB_TOKEN}"; }; f'
fi

# Remote Control needs a full-scope claude.ai login, which no environment variable can
# supply. Idling beats exiting here: under `restart: unless-stopped` an exit crash-loops
# and buries this message.
if [ ! -f /root/.claude/.credentials.json ]; then
  cat <<'EOF'

  Not signed in to claude.ai — Remote Control cannot start.
  Open a terminal on this container, run `claude`, use /login, then restart it.
  Credentials persist on the /root mount. git-sync works without this.

EOF
  exec sleep infinity
fi

exec claude remote-control --name "${SESSION_NAME:-routine}" --spawn=same-dir
