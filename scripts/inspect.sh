#!/bin/bash
clear
echo
echo "###################################################"
echo "# Splunk environment tester script for GNU/Linux  #"
echo "# Built to check for any obvious problems in your #"
echo "# environment and provide remedial guidance.      #"
echo "###################################################"
echo

# Enable logging
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>../logging/jt.log 2>&1

# Check for OS versions
if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
elif type lsb_release > /dev/null 2>&1; then
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
        OS=Debian
        VER=$(cat /etc/debian_version)
fi
printf "This is $OS Linux, version $VER\n"

# Check for memory amounts
memory_kb=$(cat /proc/meminfo | grep MemTotal: | awk '{print $2; }')
printf "This machine has $memory_kb KB of memory\n"
if [ "$memory_kb" -lt 16777216 ]; then
    echo "At 16GB or less, you're not likely to have a good time with Splunk"
elif
   [ "$memory_kb" -gt 33554432 ]; then
    echo "At leat 32GB, now we're talking"
else
    echo "Seems you're all good on memory dude"
fi

# Check for cpu cores count
cpu_cores=$(cat /proc/cpuinfo | grep -c "^processor")

# Check for a minimum of 16
if [ "$cpu_cores" -gt 16 ]; then
    echo "At least 16 cores - this is good news"
else
    echo "Fewer than 16 cores - you are going to have a bad time"
fi
printf "This machine has $cpu_cores cores available.\n"


# test for presence of ethtool for network speed checks

# test for firewall blockages on Splunk's ports

# test for ulimits & THP

# test for disk IO

# test for CPU utilisation levels

# check for presence of UF and Splunk on same box

# check for presence of Spartacus

# check for permissions on Splunk

# check splunk version

# Check for ES

# Check for ITSI

# Check for skipped searches by reason - may call out to Python script
# that executes using creds from configparser or just scan splunkd.log
