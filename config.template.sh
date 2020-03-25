#!/usr/bin/env bash

# Copy this script to a file called config.sh and modify it according to your
# needs. For most people, all you'll need to modify is the OUT_INTERFACE
# variable.
#
# IMPORTANT: Don't forget to run `chmod u+x config.sh`
#

set -Eeuo pipefail

export INTERFACE_NAME="fjsb0"
export INTERFACE_IP="10.192.72.1/24"
export OUT_INTERFACE="wg0"
