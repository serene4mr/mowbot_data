#!/bin/bash

WORKING_DIR="$(dirname "$(readlink -f "$0")")"
cd "$WORKING_DIR"

echo "remap the device serial ports of mowbot"
echo "start copy mowbot_udev.rules to /etc/udev/rules.d/"
sudo cp "$WORKING_DIR/mowbot_udev.rules" /etc/udev/rules.d/mowbot_udev.rules
sudo cp "$WORKING_DIR/link_devices.sh" /usr/local/bin/mowbot_link.sh
sudo chmod +x /usr/local/bin/mowbot_link.sh

echo -e "\nReloading udev rules and triggering devices\n"
sudo udevadm control --reload-rules
sudo udevadm trigger --action=add --subsystem-match=usb
sudo udevadm settle --timeout=5 || true
sudo udevadm trigger --action=add --subsystem-match=usb-serial
sudo udevadm settle --timeout=5 || true
sudo udevadm trigger --action=add --subsystem-match=tty
sudo udevadm settle --timeout=5 || true

echo "finish"
echo ""
echo "--- Creating symlinks directly ---"
sudo bash "$WORKING_DIR/link_devices.sh"
echo ""
echo "--- Symlink check ---"
ls -l /dev/HWT905 /dev/RPLIDAR-C2 /dev/UM982 /dev/UM982-RTCM 2>&1 || echo "Some symlinks missing - check USB connections"