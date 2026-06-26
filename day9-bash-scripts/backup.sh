#!/bin/bash
# backup.sh – Backup specific directories with a date stamp
# Usage: ./backup.sh

set -euo pipefail

# Where to store backups
BACKUP_DIR="./backups"
# Directories to back up (space-separated list)
DIRS_TO_BACKUP="projects logs"
# Today's date in YYYYMMDD-HHMMSS format
DATE_STAMP=$(date +%Y%m%d-%H%M%S)

echo "=== Starting backup at $DATE_STAMP ==="

# Create the backup root if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Created backup directory: $BACKUP_DIR"
fi

# Loop over each directory to back up
for dir in $DIRS_TO_BACKUP; do
    # Check if the source directory exists
    if [ ! -d "$dir" ]; then
        echo "⚠️  Skipping $dir – directory not found."
        continue   # jump to the next directory in the loop
    fi

    # Build the destination path: e.g., backups/projects_20260626-120000
    DEST="$BACKUP_DIR/${dir}_$DATE_STAMP"

    # If the destination already exists, skip
    if [ -d "$DEST" ]; then
        echo "✅ $DEST already exists. Skipping."
    else
        # Copy the directory (recursively)
        cp -r "$dir" "$DEST"
        echo "📁 Backed up $dir → $DEST"
    fi
done

echo "=== Backup complete ==="
