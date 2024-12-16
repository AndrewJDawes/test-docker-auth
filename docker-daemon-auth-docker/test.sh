#!/bin/bash
docker build -t docker-daemon-auth-docker:test .
# docker run --name "docker-daemon-auth-docker-container" docker-daemon-auth-docker:test "$@"
# command="$1"
# command="gh auth status || auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages"
# if ! gh auth status; then
#     gh auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages
# fi
# "gh auth status || auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages"
# docker run --name "docker-daemon-auth-docker-container" docker-daemon-auth-docker:test "$@"
(docker container inspect "docker-daemon-auth-docker-container" && docker start "docker-daemon-auth-docker-container" && docker exec "docker-daemon-auth-docker-container" gh auth status || gh auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages) || docker run --name "docker-daemon-auth-docker-container" docker-daemon-auth-docker:test gh auth status || gh auth login --scopes=read:packages,gist,read:org,repo,workflow,read:packages
