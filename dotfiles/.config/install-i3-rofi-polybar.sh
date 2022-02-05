#!/usr/bin/env bash
su -c "xargs -a i3wm_packages.txt apt-get install -y"
systemctl reboot