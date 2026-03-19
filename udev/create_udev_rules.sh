#!/bin/bash

WORKING_DIR="$(dirname "$(readlink -f "$0")")"
cd "$WORKING_DIR"

echo "remap the device serial ports of mowbot"
echo "start copy mowbot_udev.rules to /etc/udev/rules.d/"
sudo cp "$WORKING_DIR/mowbot_udev.rules" /etc/udev/rules.d/mowbot_udev.rules

echo -e "\nRestarting udev daemon\n"
sudo systemctl restart systemd-udevd
sleep 2

echo -e "Reloading udev rules and triggering tty devices\n"
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=tty --action=add || true
sleep 1

echo "finish"
echo ""
echo "--- Symlink check ---"
ls -l /dev/HWT905 /dev/RPLIDAR-C2 /dev/UM982 /dev/UM982-RTCM 2>&1 || echo "Some symlinks missing - try replugging USB devices"