#!/bin/bash

set -e

echo "delete remap the device serial ports of mowbot"
sudo rm -f /etc/udev/rules.d/mowbot_udev.rules
echo ""
echo "Reloading udev rules and triggering tty devices"
echo ""
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=tty
echo "finish delete"