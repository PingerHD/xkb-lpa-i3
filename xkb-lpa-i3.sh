#!/bin/bash
#
# xkb-lpa-i3 — script to set keyboard layout per application on i3wm
# Author: Pinger
# License: MIT
# Repository: https://github.com/PingerHD/xkb-lpa-i3
# Description: Automatically switches keyboard layout based on active window in i3wm
#
FILE="$HOME/.local/share/xkb-lpa/rules.conf"
DIR=$(dirname "$FILE")

if [ ! -f "$FILE" ]; then
	mkdir -p "$DIR"
	touch "$FILE"
fi


while true; do
	i3-msg -t subscribe '[ "window" ]' | while read -r line; do
		window_class=$(xdotool getwindowfocus getwindowclassname)
		layout=$(xkb-switch)
		default_layout=$(xkb-switch -l | head -n1)
		
		rule=$(cat $FILE | grep $window_class)
	
		if [ -z $rule ]; then
			echo "$window_class=$layout" >> $FILE
			echo "Created rule for $window_class=$default_layout"
		else
			xkb-switch -s ${rule#*=}
		fi
	done

done &

while true; do
	xkb-switch -w
	window_class=$(xdotool getwindowfocus getwindowclassname)
	layout=$(xkb-switch)

	rule=$(cat $FILE | grep $window_class)

	sed -i "\|^${rule}|d" "$FILE"
	echo "$window_class=$layout" >> $FILE
	echo "Changed rule for $window_class=$layout"
	sleep 0.1

done
