#!/bin/bash
DOCKER_SOCK="${DOCKER_SOCK:-/var/run/docker.sock}"
DOCKER_CONFIG_DIR="${DOCKER_CONFIG_DIR:-$HOME/.docker/}"
mkdir -p "$DOCKER_CONFIG_DIR"
docker build -t docker-auth-config:test .
docker volume ls | grep "gh_cli_docker_volume_v1" || docker volume create "gh_cli_docker_volume_v1"
docker run --rm -v gh_cli_docker_volume_v1:/root/.config/gh -v "$DOCKER_SOCK:/var/run/docker.sock" -v "$DOCKER_CONFIG_DIR:/root/.docker/" --env HOST_UID=${UID} --env HOST_GID=${GID} docker-auth-config:test
