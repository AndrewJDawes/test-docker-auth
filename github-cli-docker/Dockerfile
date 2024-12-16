FROM ubuntu:latest
ARG ARCH=arm64

RUN apt-get update && apt install -y \
  curl \
  gpg \
  ca-certificates

# Install yq
RUN apt-get update && apt-get install -y wget
RUN wget "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${ARCH}" -O /usr/bin/yq &&\
  chmod +x /usr/bin/yq

# Install jq
RUN apt-get update && apt-get install -y jq

# Install Docker
# Add Docker's official GPG key:
RUN apt-get update -y
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update

RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Entrypoint

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/usr/bin/env", "bash", "/entrypoint.sh"]
