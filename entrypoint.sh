#!/bin/bash
set -euo pipefail

: "${REPO:?REPO is required (e.g. owner/repo)}"
: "${TOKEN:?TOKEN (runner registration token) is required}"

cd /actions-runner

if [ ! -f .runner ]; then
    ./config.sh \
        --url "https://github.com/${REPO}" \
        --token "${TOKEN}" \
        --name "${RUNNER_NAME:-$(hostname)}" \
        --unattended \
        --replace
fi

exec ./run.sh
