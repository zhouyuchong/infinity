#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
WORKSPACE=$(cd "${SCRIPT_DIR}/.." && pwd)
IMAGE_TAG=${1:-infinity:v0.7.0-dev-fix}
OUTPUT_TAR=${2:-}

if ! command -v docker >/dev/null 2>&1; then
    echo "docker is required but was not found" >&2
    exit 1
fi

echo "Building ${IMAGE_TAG} from ${WORKSPACE}"
docker build \
    --progress=plain \
    --file "${SCRIPT_DIR}/Dockerfile_infinity_ubuntu2404" \
    --tag "${IMAGE_TAG}" \
    "${WORKSPACE}"

if [[ -n "${OUTPUT_TAR}" ]]; then
    echo "Exporting ${IMAGE_TAG} to ${OUTPUT_TAR}"
    docker save "${IMAGE_TAG}" --output "${OUTPUT_TAR}"
fi

echo "Image ready: ${IMAGE_TAG}"
