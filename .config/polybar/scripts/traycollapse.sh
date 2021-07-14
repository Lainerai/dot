#!/bin/bash

if pgrep -x "tint2" > /dev/null
then
    killall tint2
else
    tint2
fi
