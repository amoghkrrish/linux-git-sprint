#!/bin/bash
# disk-cleaner-auto.sh – Same as disk-cleaner but no confirmation (for cron)
TARGET_DIR="${1:-./logs}"
MAX_DAYS="${2:-7}"
set -euo pipefail
echo "$(date) - Cleaning old files in $TARGET_DIR older than $MAX_DAYS days" >> /tmp/disk-cleaner.log
find "$TARGET_DIR" -type f -mtime "+$MAX_DAYS" -delete -print >> /tmp/disk-cleaner.log
echo "Done." >> /tmp/disk-cleaner.log
