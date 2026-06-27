#!/bin/bash
# health-check.sh – Check if a URL is reachable and log the result
# Usage: ./health-check.sh [url]
# Default: http://localhost:8000

set -euo pipefail

URL="${1:-http://localhost:8000}"
LOG_FILE="/tmp/health-check.log"

echo "=== Health Check ==="
echo "Checking: $URL"
echo ""

# Use curl to get the HTTP status code
# -s = silent (no progress bar), -o /dev/null = discard body, -w "%{http_code}" = print status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" 2>/dev/null || echo "000")

# Log the result with date and time
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
if [ "$STATUS" -ge 200 ] && [ "$STATUS" -lt 400 ]; then
    echo "$TIMESTAMP - SUCCESS - $URL returned $STATUS" >> "$LOG_FILE"
    echo "✅ $URL is UP (status $STATUS)"
else
    echo "$TIMESTAMP - FAILURE - $URL returned $STATUS" >> "$LOG_FILE"
    echo "❌ $URL is DOWN (status $STATUS)"
fi

echo "Result logged to $LOG_FILE"
