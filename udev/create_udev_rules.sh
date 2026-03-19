#!/bin/bash

set -e

WORKING_DIR="$(dirname "$(readlink -f "$0")")"
cd "$WORKING_DIR"

echo "remap the device serial ports of mowbot"
echo "start copy mowbot_udev.rules to /etc/udev/rules.d/"
sudo cp "$WORKING_DIR/mowbot_udev.rules" /etc/udev/rules.d/mowbot_udev.rules
echo -e "\nReloading udev rules and triggering tty devices\n"
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=tty
echo "finish"