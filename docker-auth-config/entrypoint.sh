# /root/.config/gh/hosts.yml
# github.com:
#     users:
#         AndrewJDawes:
#             oauth_token: gho_asdfasdfasdfasdfasdfasdfasdfasdfdasfas
#     git_protocol: https
#     user: AndrewJDawes
#     oauth_token: gho_asdfasdfasdfasdfasdfasdfasdfasdfdasfas
# Parse the token from the hosts.yml file
DOCKER_CONFIG_DIR="/root/.docker"
GITHUB_CONFIG_DIR="/root/.config/gh"
# Yes, literally USERNAME. It actually doesn't get used with GitHub PATs.
GITHUB_OAUTH_USERNAME=USERNAME
GITHUB_OAUTH_TOKEN=$(cat "${GITHUB_CONFIG_DIR}/hosts.yml" | yq '."github.com".oauth_token')
BASE64_GITHUB_OAUTH_TOKEN=$(echo -n "${GITHUB_OAUTH_USERNAME}:${GITHUB_OAUTH_TOKEN}" | base64)

test -f "${DOCKER_CONFIG_DIR}/config.json" && cp "${DOCKER_CONFIG_DIR}/config.json" "${DOCKER_CONFIG_DIR}/config.json.bak"

# If docker config file does not exist or is empty, create it
if [ ! -f "${DOCKER_CONFIG_DIR}/config.json" ] || [ ! -s "${DOCKER_CONFIG_DIR}/config.json" ]; then
    echo "{}" >"tmp/config.json"
    chown "${HOST_UID:-0}:${HOST_GID:-0}" "/tmp/config.json"
    mv "/tmp/config.json" "${DOCKER_CONFIG_DIR}/config.json"
fi

# Populate the config.json with an empty object if no object exists
jq '. + {}' "${DOCKER_CONFIG_DIR}/config.json" >"/tmp/config.json"
jq '.credsStore = ""' "${DOCKER_CONFIG_DIR}/config.json" >"/tmp/config.json"
jq ".auths = { \"ghcr.io\": { \"auth\": \"${BASE64_GITHUB_OAUTH_TOKEN}\" } }" "${DOCKER_CONFIG_DIR}/config.json" >"/tmp/config.json"
# Equivalent: gh auth token | docker login ghcr.io -u USERNAME --password-stdin
chown "${HOST_UID:-0}:${HOST_GID:-0}" "/tmp/config.json"
# If file already exists, overwrite it
mv "/tmp/config.json" "${DOCKER_CONFIG_DIR}/config.json"
