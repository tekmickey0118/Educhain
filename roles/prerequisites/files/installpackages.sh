#!/bin/bash

# Install packages using appropriate package manager (e.g., apt, yum, pacman)

PACKAGES=("docker" "docker-compose" "htop" "tree")

# Define the log file
LOGFILE="/etc/ansible/logs/ansible.log"

# Function to write to the log file
log_msg() {
	local msg=$1
	local log_level=$2
	echo "$(date '+%Y-%m-%d %H:%M;%S') [$log_level] - $msg" >> $LOGFILE
}

# Determine the package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
else
    log_msg "No compatible package manager found. Exiting with error code 1..."
    exit 1
fi

# Function to install package
install_package() {
    PACKAGE=$1

    log_msg "Installing $PACKAGE..." "INFO"

    if dpkg -l | grep -q $PACKAGE; then
        log_msg "$PACKAGE is already installed." "INFO"
    else
        if sudo "$PKG_MANAGER" install -y $PACKAGE; then
            log_msg "$PACKAGE has been installed successfully." "INFO"
        else
            log_msg "Failed to install $PACKAGE. Please check the error above." "ERROR"
            exit 1
        fi
    fi
}

# Update package list
log_msg "Updating package list..." "INFO"

if sudo "$PKG_MANAGER" update; then
    log_msg "Package lists updated successfully." "INFO"
else
    log_msg "Failed to update package lists. Exiting with error code 1..." "ERROR"
    exit 1
fi

# Install packages
for PACKAGE in "${PACKAGES[@]}"; do
    log_msg "Trying to install $PACKAGE..." "INFO"
    install_package $PACKAGE
done

log_msg "All packages installed successfully!" "INFO"