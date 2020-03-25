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

TMP_MARKER_FILE="/tmp/__fjsb-netbridge-setup__"
if [ -f "$TMP_MARKER_FILE" ]; then
    exit 0
fi

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INTERFACE_SCRIPT="$SCRIPT_DIR/setup-interface.sh"
pkexec "$INTERFACE_SCRIPT"

touch "$TMP_MARKER_FILE"
