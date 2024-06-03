#!/bin/bash

# Create user 'educhain' with appropriate privileges
USER_NAME="educhain"
GROUPS=("sudo", "docker")

# Define the log file
LOGFILE="/etc/ansible/logs/ansible.log"

# Function to write to the log file
log_msg() {
	local msg=$1
	local log_level=$2
	echo "$(date '+%Y-%m-%d %H:%M;%S') [$log_level] - $msg" >> $LOGFILE
}

# Check if the user already exists
if id -u "$USER_NAME" >/dev/null 2>&1; then
    log_msg "User $USER_NAME already exists. No action taken." "INFO"
    exit 0
else
    # Create the user
    if sudo useradd -m "$USER_NAME"; then
        log_msg "User $USER_NAME created successfully." "INFO"

        # Add the user to the groups
        for GROUP in "${GROUPS[@]}"; do
            if sudo usermod -aG "$GROUP" "$USER_NAME"; then
                log_msg "User $USER_NAME added to $GROUP successfully." "INFO"
            else
                log_msg "Failed to add user $USER_NAME to $GROUP. Exiting with error code 1..."
                exit 1
            fi
        done
    else
        log_msg "Failed to create user $USER_NAME. EXiting with error code 1..." "ERROR"
        exit 1
    fi
fi