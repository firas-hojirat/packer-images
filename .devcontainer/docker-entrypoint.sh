#!/usr/bin/env bash
set -euxo pipefail

if [ -f .tool-versions ]; then
    cat .tool-versions | awk '{print $1}' | xargs -I '{}' asdf plugin-add '{}'
    asdf install
fi

exec "$@"