#!/bin/bash
# port-check.sh – Scan a range of ports on localhost
# Usage: ./port-check.sh [start_port] [end_port]
# Example: ./port-check.sh 8000 8010

set -euo pipefail

# If no arguments, default to scanning ports 8000-8010
START="${1:-8000}"
END="${2:-8010}"

echo "Scanning ports $START to $END on localhost..."
echo ""

# Loop through each port number from START to END
for port in $(seq $START $END); do
    # nc -z = just scan (no data)
    # nc -w1 = timeout after 1 second
    # 2>/dev/null hides any error messages
    if nc -z -w1 localhost $port 2>/dev/null; then
        echo "✅ Port $port is open"
    else
        echo "❌ Port $port is closed"
    fi
done
