#!/bin/bash

# Variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="www_backup_${TIMESTAMP}.tar.gz"
LOG_FILE="/var/log/backup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "$LOG_FILE"
}

# Ensure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log_message "ERROR: Source directory $SOURCE_DIR does not exist"
    exit 1
fi

# Perform backup
log_message "Starting backup of $SOURCE_DIR"
sudo tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR" 2>>"$LOG_FILE"

# Verify backup success
if [ $? -eq 0 ]; then
    log_message "Backup successful: $BACKUP_DIR/$BACKUP_NAME"
else
    log_message "Backup failed"
    exit 1
fi
