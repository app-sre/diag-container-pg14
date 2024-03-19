#!/bin/bash
set -exv

IMAGE_NAME=quay.io/app-sre/diag-container-pg14
IMAGE_TAG=$(git rev-parse --short=7 HEAD) 

# build the image
docker build  --no-cache \
              --force-rm \
              -t ${IMAGE_NAME}:${IMAGE_TAG}  \
              -f ./Dockerfile .

# push the image
skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${IMAGE_NAME}" \
    "docker://${IMAGE_NAME}:latest"

skopeo copy --dest-creds "${QUAY_USER}:${QUAY_TOKEN}" \
    "docker-daemon:${IMAGE_NAME}" \
    "docker://${IMAGE_NAME}:${IMAGE_TAG}"


# does this script need error handling or cleanup for intermediate containers?