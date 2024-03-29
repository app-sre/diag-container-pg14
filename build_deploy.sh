#!/bin/bash
set -exv

BASE_IMAGE="diag-container-pg14"
IMAGE_NAME="quay.io/app-sre/diag-container-pg14"
IMAGE_TAG=$(git rev-parse --short=7 HEAD) 

# build the image
docker build  --no-cache \
              --force-rm \
              -t ${BASE_IMAGE}:latest \
              -f ./Dockerfile .

# push the image
skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${BASE_IMAGE}:latest" \
    "docker://${IMAGE_NAME}:latest"


skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${BASE_IMAGE}:latest" \
    "docker://${IMAGE_NAME}:${IMAGE_TAG}"


