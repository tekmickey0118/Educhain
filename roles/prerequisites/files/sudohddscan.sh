#!/bin/bash

# Predefined threshold variable for available HDD space
THRESHOLD=20

# Define the log file
LOGFILE="/etc/ansible/logs/ansible.log"

# Function to write to the log file
log_msg() {
	local msg=$1
	local log_level=$2
	echo "$(date '+%Y-%m-%d %H:%M;%S') [$log_level] - $msg" >> $LOGFILE
}

# Get available HDD space in gigabytes
AVAILABLE_SPACE=$(df -h --output=avail / | tail -n1 | awk '{ print $1 }' | sed 's/G//')

# Compare available space with the threshold
if (( $(echo "$AVAILABLE_SPACE < $THRESHOLD") | bc -l )); then
    log_msg "Available HDD space is less than the threshold of $THRESHOLD GB. Exiting with error code 1..." "ERROR"
    exit 1
else
    log_msg "Available HDD space is above the threshold. Currently available: $AVAILABLE_SPACE GB." "INFO"
    exit 0
fi
