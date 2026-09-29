#!/usr/bin/env bash
set -euo pipefail

REPO_URL=https://github.com/pedrodbsa/routine.git

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

# The working repo lives on the persistent files mount, not in Dokploy's deploy checkout:
# that checkout embeds a short-lived token in its origin URL, which git prefers over the
# helper, and a redeploy wipes it. An empty mount means first boot, so clone. The URL stays
# bare; the helper above supplies the token if the repo is private.
if [ ! -d /app/.git ]; then
  echo "no repo at /app — cloning ${REPO_URL}"
  if ! git clone "${REPO_URL}" /app; then
    cat <<EOF

  Clone of ${REPO_URL} into /app failed — the coach has no repo to work in.
  Check GITHUB_TOKEN (required if the repo is private) and that /app is empty, then
  restart the container.

EOF
    exec sleep infinity
  fi
fi

# A credential in the remote URL outranks the helper and goes stale, which is how pushes
# failed silently before. Nothing here writes one, so if it appears someone put it there.
if git -C /app remote get-url origin 2>/dev/null | grep -q '://[^/]*@'; then
  echo "WARNING: origin URL in /app carries credentials; pushes will fail once they expire." >&2
  echo "         Fix with: git -C /app remote set-url origin ${REPO_URL}" >&2
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

# The status TUI redraws every second and floods the container log, so stdout is dropped.
# stderr stays attached so crash messages still reach the log.
exec claude remote-control --name "${SESSION_NAME:-routine}" --spawn=same-dir >/dev/null
