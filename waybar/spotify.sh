#!/bin/bash
class=$(playerctl -p spotify metadata --format '{{lc(status)}}')

if [[ $class == "playing" ]]; then
  info=$(playerctl -p spotify metadata --format '{{artist}} - {{title}}')
  if [[ ${#info} > 40 ]]; then
    info=$(echo $info | cut -c1-40)"..."
  fi
  text=$info
elif [[ $class == "paused" ]]; then
  text=" $(playerctl -p spotify metadata --format '{{artist}} - {{title}}')"
elif [[ $class == "stopped" ]]; then
  text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
