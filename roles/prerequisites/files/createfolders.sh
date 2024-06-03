#!/bin/bash

# Create the required directories
DIRS=("/var/www/webdocker" "/var/www/backup" "/var/www/sync")
LOGFILE="/etc/ansible/logs/ansible.log"

USER="root"
GROUP="root"

log_msg() {
    local msg=$1
	local log_level=$2
	echo "$(date '+%Y-%m-%d %H:%M;%S') [$log_level] - $msg" >> $LOGFILE
}

for DIR in "${DIRS[@]}"; do
    # Check if directory exists
    if [ -d "$DIR" ]; then
        log_msg "Directory $DIR already exists." "INFO"
    
    else
        # Attempt to create directory
        mkdir -p "$DIR"
        
        # Check if directory creation was successful
        if [ $? -eq 0 ]; then
            log_msg "Successfully created $DIR" "INFO"
            
            # Modify permissions and ownership
            chmod 755 "$DIR"
            chown root:root "$DIR"
            log_msg "Set ownership to root:root and permissions to 755 for $DIR" "INFO"
        else
            log_msg "Could not create $DIR" "ERROR"
            exit 1
        fi
    fi
done

# Exit with success code
exit 0