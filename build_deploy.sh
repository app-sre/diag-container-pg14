#!/bin/bash
set -exv

BASE_IMG="diag-container-pg14"
QUAY_IMAGE="quay.io/app-sre/${BASE_IMG}"
IMG="${BASE_IMG}:1.3.0"


GIT_HASH=$(git rev-parse --short=7 HEAD)

# build the image
docker build  --no-cache \
              --force-rm \
              -t ${IMG}  \
              -f ./Dockerfile .

# push the image
skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${IMG}" \
    "docker://${QUAY_IMAGE}:latest"

skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${IMG}" \
    "docker://${QUAY_IMAGE}:${GIT_HASH}"


# does this script need error handling or cleanup for intermediate containers?