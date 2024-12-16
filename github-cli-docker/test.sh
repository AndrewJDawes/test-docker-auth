#!/bin/bash
DOCKER_SOCK="${DOCKER_SOCK:-/var/run/docker.sock}"
DOCKER_CONFIG="${DOCKER_CONFIG:-$HOME/.docker/}"
mkdir -p "$DOCKER_CONFIG"
docker build -t github-cli-docker:test .
docker run --volumes-from "docker-daemon-auth-docker-container" -v "$DOCKER_SOCK:/var/run/docker.sock" -v "$DOCKER_CONFIG:/root/.docker/" github-cli-docker:test
