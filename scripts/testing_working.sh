#!/bin/bash

# This doesnt work yet, but it's alsmost there.

regex = "^([a-z0-9]+?):\s+(\d+?)"

for i in $(netstat -i | cut -f1 -d" " | tail -n+3 | grep -v "lo"); do echo "$i: $(ethtool "$i" | grep Speed | sed 's/Speed://g')"; done;
    if [[ i =~ $regex ]]
    then
        interface=${$BASH_REMATCH[1]}
        speed=${$BASH_REMATCH[2]}
    echo "$interface has speed of $speed"
    fi
