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

if [[ ! -f "$FILE" ]]; then
	mkdir -p "$DIR"
	touch "$FILE"
fi

while true; do
	if [[ $(xkb-switch -l | wc -l) -le 1 ]]; then
		setxkbmap -layout "us,ru" -option "grp:win_space_toggle"
	fi
	i3-msg -t subscribe '[ "window" ]' | while read -r line; do
		window_class=$(xdotool getwindowfocus getwindowclassname)
		if [[ -z "$window_class" ]]; then
			continue
    		fi
		layout=$(xkb-switch)
		default_layout=$(xkb-switch -l | head -n1)
		
	    rule=$(grep -m1 -F "$window_class" "$FILE")
	
		if [[ -z "$rule" ]]; then
			echo $window_class
			echo $layout
			echo $rule
			echo "$window_class=$layout" >> $FILE
			echo "Created rule for $window_class=$default_layout"
		else
			xkb-switch -s ${rule#*=}
		fi
	done
done &

xkb-switch -W | while read -r layout; do
	window_class=$(xdotool getwindowfocus getwindowclassname)
    echo $window_class
    if [[ -n "$window_class" ]]; then
	    rule=$(grep "$window_class" "$FILE")
        echo $rule
        current_layout="${rule#*=}"

        if [[ "$layout" != "$current_layout" ]]; then
	        sed -i "\|^${rule}|d" "$FILE"
	        echo "$window_class=$layout" >> $FILE
	        echo "Changed rule for $window_class=$layout"
	        sleep 0.1
        fi
    fi
done

