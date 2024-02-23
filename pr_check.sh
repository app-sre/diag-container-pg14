#!/bin/bash
set -exv
docker build  --no-cache \
              --force-rm \
              -t diag-container-pg14:1.0.0  \
              -f ./Dockerfile .
