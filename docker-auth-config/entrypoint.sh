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

cp "${DOCKER_CONFIG_DIR}/config.json" "${DOCKER_CONFIG_DIR}/config.json.bak"
cp "${DOCKER_CONFIG_DIR}/config.json" "${DOCKER_CONFIG_DIR}/config.json.tmp"
jq '.credsStore = ""' "${DOCKER_CONFIG_DIR}/config.json" >"${DOCKER_CONFIG_DIR}/config.json.tmp"
jq ".auths = { \"ghcr.io\": { \"auth\": \"${BASE64_GITHUB_OAUTH_TOKEN}\" } }" "${DOCKER_CONFIG_DIR}/config.json" >"${DOCKER_CONFIG_DIR}/config.json.tmp"
# Equivalent: gh auth token | docker login ghcr.io -u USERNAME --password-stdin
cat "${DOCKER_CONFIG_DIR}/config.json.tmp" >"${DOCKER_CONFIG_DIR}/config.json"
