#!/bin/bash
# process-check.sh – System process & resource snapshot
# Works on macOS. For Linux, adjust top commands.

set -euo pipefail

OUTPUT_FILE="${1:-/tmp/process-report-$(date +%Y%m%d-%H%M%S).log}"

echo "===== System Process Report =====" | tee "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "Hostname: $(hostname)" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 1. Total process count (subtract header line)
total_procs=$(( $(ps aux | wc -l) - 1 ))
echo "Total Processes: $total_procs" | tee -a "$OUTPUT_FILE"

# 2. Top 5 CPU‑consuming processes (macOS sort method)
echo "" | tee -a "$OUTPUT_FILE"
echo "Top 5 Processes by CPU:" | tee -a "$OUTPUT_FILE"
ps aux | sort -nrk 3 | head -5 | tee -a "$OUTPUT_FILE"

# 3. Top 5 Memory‑consuming processes
echo "" | tee -a "$OUTPUT_FILE"
echo "Top 5 Processes by Memory:" | tee -a "$OUTPUT_FILE"
ps aux | sort -nrk 4 | head -5 | tee -a "$OUTPUT_FILE"

# 4. Memory summary (macOS: PhysMem line from top)
echo "" | tee -a "$OUTPUT_FILE"
echo "Memory Summary:" | tee -a "$OUTPUT_FILE"
top -l 1 | grep PhysMem | tee -a "$OUTPUT_FILE"

# 5. CPU usage snapshot
echo "" | tee -a "$OUTPUT_FILE"
echo "CPU Usage Snapshot:" | tee -a "$OUTPUT_FILE"
top -l 1 | grep "CPU usage" | tee -a "$OUTPUT_FILE"

# 6. Zombie processes (if any)
echo "" | tee -a "$OUTPUT_FILE"
echo "Zombie Processes (if any):" | tee -a "$OUTPUT_FILE"
ps aux | awk '$8 ~ /Z/ {print $0}' | tee -a "$OUTPUT_FILE"
if [ $? -eq 0 ] && [ -z "$(ps aux | awk '$8 ~ /Z/')" ]; then
    echo "None detected." | tee -a "$OUTPUT_FILE"
fi

echo "" | tee -a "$OUTPUT_FILE"
echo "===== End of Report =====" | tee -a "$OUTPUT_FILE"
echo "Report saved to: $OUTPUT_FILE"
