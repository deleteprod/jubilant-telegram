#!/bin/bash
clear
echo
echo "###################################################"
echo "# Splunk environment tester script for GNU/Linux  #"
echo "# Built to check for any obvious problems in your #"
echo "# environment and provide remedial guidance.      #"
echo "###################################################"
echo

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

# Check for cpu cores
cpu_cores=$(cat /proc/cpuinfo | grep -c "^processor")
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
