#!/bin/bash
docker build -t gh-cli-docker:test .
# Create volume if it does not exist
docker volume ls | grep "gh_cli_docker_volume_v1" || docker volume create "gh_cli_docker_volume_v1"
docker run --rm -v "gh_cli_docker_volume_v1:/root/.config/gh" gh-cli-docker:test auth status || docker run --rm -v "gh_cli_docker_volume_v1:/root/.config/gh" gh-cli-docker:test auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages

