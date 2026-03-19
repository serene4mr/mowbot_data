#!/bin/bash
# Creates /dev symlinks for mowbot devices based on physical USB port (sysfs path).
# Run this directly after connecting USB devices - does not depend on udev daemon state.

declare -A PORT_MAP
PORT_MAP["1-2.1.3"]="HWT905"
PORT_MAP["1-2.1.4"]="RPLIDAR-C2"
PORT_MAP["1-2.2.1"]="UM982"
PORT_MAP["1-2.2.4"]="UM982-RTCM"

# Remove stale symlinks
for name in "${PORT_MAP[@]}"; do
    rm -f "/dev/$name"
done

# Create symlinks for currently connected devices
for tty in /sys/class/tty/ttyUSB*; do
    [ -e "$tty" ] || continue
    dev=$(basename "$tty")
    syspath=$(readlink -f "$tty")
    for port in "${!PORT_MAP[@]}"; do
        if echo "$syspath" | grep -q "/${port}/"; then
            name="${PORT_MAP[$port]}"
            ln -sf "/dev/$dev" "/dev/$name"
            chmod 0666 "/dev/$dev"
            echo "  /dev/$name -> /dev/$dev"
        fi
    done
done
