#!/bin/bash
docker build -t gh-cli-docker:test .
# docker run --name "gh-cli-docker-container" gh-cli-docker:test "$@"
# command="$1"
# command="gh auth status || auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages"
# if ! gh auth status; then
#     gh auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages
# fi
# "gh auth status || auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages"
# docker run --name "gh-cli-docker-container" gh-cli-docker:test "$@"
# Create volume if it does not exist
docker volume ls | grep "gh-cli-docker-volume" || docker volume create "gh-cli-docker-volume"
# bash test.sh auth status
# docker run --rm -v "gh-cli-docker-volume:/root/.config/gh" gh-cli-docker:test $
docker run --rm -v "gh-cli-docker-volume:/root/.config/gh" gh-cli-docker:test auth status || docker run --rm -v "gh-cli-docker-volume:/root/.config/gh" gh-cli-docker:test auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages

