#!/bin/sh

if ! playerctl --player=spotify status | grep -qi "playing"
then
  echo " "
else
  echo " "
fi
