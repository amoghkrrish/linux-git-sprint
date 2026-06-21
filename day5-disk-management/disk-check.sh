#!/bin/bash
# disk-check.sh – Check disk usage and alert if above threshold.
# Usage: ./disk-check.sh [mount-point] [threshold-percent]
# Default: check '/' (or /System/Volumes/Data) with 80% threshold.

set -euo pipefail

# Set defaults
MOUNT="${1:-/System/Volumes/Data}"
THRESHOLD="${2:-80}"

echo "=== Disk Check ==="
echo "Mount point: $MOUNT"
echo "Threshold : ${THRESHOLD}%"
echo ""

# Get the usage percentage (macOS df format)
# df output has header, then line with device. We grab the 5th column (Use%) and remove the '%'
USAGE=$(df -H "$MOUNT" | tail -1 | awk '{print $5}' | sed 's/%//')

echo "Current usage: ${USAGE}%"

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "⚠️  WARNING: Disk usage is above ${THRESHOLD}%! Take action."
    # Optional: log the event
    echo "$(date) - ALERT: $MOUNT usage ${USAGE}% > ${THRESHOLD}%" >> /tmp/disk-alert.log
else
    echo "✅ Disk usage is within safe limits."
fi

