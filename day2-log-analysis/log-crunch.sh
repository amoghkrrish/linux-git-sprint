#!/bin/bash
# log-crunch.sh – Analyze Apache access logs
# Usage: ./log-crunch.sh <logfile>
# If no logfile provided, defaults to apache_logs in current directory.

set -euo pipefail

LOGFILE="${1:-apache_logs}"

# Check if file exists
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File $LOGFILE not found."
    exit 1
fi

echo "===== Log Analysis for $LOGFILE ====="
echo ""

# 1. Total number of requests
total=$(wc -l < "$LOGFILE")
echo "Total Requests: $total"

# 2. Top 5 IP addresses by request count
echo ""
echo "Top 5 IPs:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -5

# 3. Number of 404 errors
errors_404=$(grep -c " 404 " "$LOGFILE")
echo ""
echo "404 Errors: $errors_404"

# 4. Top 5 URLs that returned 404
echo ""
echo "Top 5 URLs with 404:"
awk '$9 == "404" {print $7}' "$LOGFILE" | sort | uniq -c | sort -rn | head -5

# 5. HTTP status code distribution
echo ""
echo "HTTP Status Code Distribution:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -rn

echo ""
echo "Analysis complete."#!/bin/bash
#log-crunch.sh - Analyse apache access logs
#if no logfile provided ,defaults to apache_logs in current directory

set -euo pipefail

LOGFILE="${1:-apache_logs}"

#check if file exists"
if [ ! -f "LOGFILE" ]; then
    echo "error: file $LOGFILE not found."
    exit 1
fi

echo "====== Log Analysis for $LOGFILE ==="
echo ""

total =$(wc -l < "$LOGFILE")
echo "total Requests : $total"

echo ""
echo "Top 5 IPS"
echo '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -5

errors_404=$(grep -c "404"" $LOGFILE")
echo ""
echo "404 Errors: $errors_404"

echo ""
echo "Top 5 urls with 404:"
awk '$9 == "404" {print $7}' "$LOGFILE" |sort |uniq -c |sort -rn |head -5

echo ""
echo "HTTP Status code Distribution :"
awk '{print $9}' "$LOGFILE" | sort | uniq -c |sort -rn

echo ""
echo "Analysis Complete"
