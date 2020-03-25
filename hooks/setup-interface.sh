#!/usr/bin/env bash

# This script is based on the template here:
#
#     https://gist.github.com/pcrockett/8e04641f8473081c3a93de744873f787
#
# Useful links when writing a script:
#
# Shellcheck: https://github.com/koalaman/shellcheck
# vscode-shellcheck: https://github.com/timonwong/vscode-shellcheck
# https://blog.yossarian.net/2020/01/23/Anybody-can-write-good-bash-with-a-little-effort
#

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

[[ "${BASH_VERSINFO[0]}" -lt 4 ]] && echo "Bash >= 4 required" && exit 1

# This script is designed to only be run once per session. Everything gets
# reset after reboot.

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
REPO_DIR=$(dirname "$SCRIPT_DIR")

function panic {
    >&2 echo "Fatal: $*"
    exit 1
}

CONFIG_FILE="$REPO_DIR/config.sh"
test -e "$CONFIG_FILE" || panic "$CONFIG_FILE does not exist or is not executable."

# shellcheck source=/dev/null
. "$CONFIG_FILE"

sysctl --write net.ipv4.ip_forward=1

brctl addbr "$INTERFACE_NAME"
ip link set "$INTERFACE_NAME" up
ip addr add dev "$INTERFACE_NAME" "$INTERFACE_IP"

iptables --table nat \
    --append POSTROUTING \
    --source "$INTERFACE_IP" \
    --out-interface "$OUT_INTERFACE" \
    --jump MASQUERADE
