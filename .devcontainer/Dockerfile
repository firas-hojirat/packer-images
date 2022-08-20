# syntax=docker/dockerfile:1.4
FROM buildpack-deps:bullseye

ENV ASDF_DIR="${HOME}/.asdf"

RUN <<EOT bash
    set -euxo pipefail
    git clone https://github.com/asdf-vm/asdf.git "${ASDF_DIR}"
    . "${ASDF_DIR}"
EOT

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
