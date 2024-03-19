#!/bin/bash
set -exv
IMAGE_NAME := quay.io/app-sre/diag-container-pg14
IMAGE_TAG := $(shell git rev-parse --short=7 HEAD) 

docker build  --no-cache \
              --force-rm \
              -t ${IMAGE_NAME}:${IMAGE_TAG}  \
              -f ./Dockerfile .
