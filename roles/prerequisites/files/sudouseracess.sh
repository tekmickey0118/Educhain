#!/bin/bash

# Define the log file
LOGFILE="/etc/ansible/logs/ansible.log"

# Function to write to the log file

log_msg() {
	local msg=$1
	local log_level=$2
	echo "$(date '+%Y-%m-%d %H:%M;%S') [$log_level] - $msg" >> $LOGFILE
}

# Check if the user has sudo access
if sudo -n true 2>/dev/null; then
    log_msg "User $(whoami) has sudo access" "INFO"
    exit 0
else
    log_msg "User $(whoami) does not have sudo access" "ERROR"
    exit 1
fi
