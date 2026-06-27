#!/bin/bash
# disk-cleaner.sh – Remove log files older than a given age
# Usage: ./disk-cleaner.sh [directory] [age-in-days]
# Default: directory = ./logs, age = 7

set -euo pipefail

TARGET_DIR="${1:-./logs}"
MAX_DAYS="${2:-7}"

echo "=== Disk Cleaner ==="
echo "Checking directory: $TARGET_DIR"
echo "Removing files older than $MAX_DAYS days"
echo ""

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: $TARGET_DIR does not exist."
    exit 1
fi

# List files that will be deleted (dry run)
echo "--- Files older than $MAX_DAYS days ---"
find "$TARGET_DIR" -type f -mtime "+$MAX_DAYS" -print

# Ask for confirmation (optional safety)
read -p "Delete these files? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Aborted. No files deleted."
    exit 0
fi

# Delete files
find "$TARGET_DIR" -type f -mtime "+$MAX_DAYS" -delete
echo ""
echo "Old files deleted."
