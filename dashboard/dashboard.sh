#!/bin/bash
# dashboard.sh – All‑in‑one system tools
set -euo pipefail

# ----- FUNCTIONS -----
system_health() {
    echo "----- System Health Report -----"
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo ""
    echo "--- Uptime ---"
    uptime
    echo ""
    echo "--- Memory (top) ---"
    top -l 1 | grep PhysMem
    echo ""
    echo "--- CPU Usage ---"
    top -l 1 | grep "CPU usage"
    echo ""
    echo "--- Disk Usage (Data volume) ---"
    df -h /System/Volumes/Data 2>/dev/null || df -h /
    echo ""
    echo "--- Top 3 CPU processes ---"
    ps aux | sort -nrk 3 | head -4
    echo ""
    echo "Report generated."
    read -p "Press Enter to return to menu..."
}

log_analysis() {
    echo "----- Log Analysis (Apache sample) -----"
    LOGFILE="apache_logs"
    if [ ! -f "$LOGFILE" ]; then
        echo "Downloading sample log file..."
        curl -s -O https://raw.githubusercontent.com/elastic/examples/master/Common%20Data%20Formats/apache_logs/apache_logs
    fi
    echo "Total requests:"
    wc -l < "$LOGFILE"
    echo ""
    echo "Top 5 IPs:"
    awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -5
    echo ""
    echo "HTTP Status Code Distribution:"
    awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -rn
    echo ""
    read -p "Press Enter to return to menu..."
}

port_scanner() {
    echo "----- Port Scanner -----"
    read -p "Start port (default 8000): " START
    START="${START:-8000}"
    read -p "End port (default 8010): " END
    END="${END:-8010}"
    echo "Scanning ports $START to $END on localhost..."
    for port in $(seq $START $END); do
        if nc -z -w1 localhost $port 2>/dev/null; then
            echo "✅ Port $port is open"
        else
            echo "❌ Port $port is closed"
        fi
    done
    read -p "Press Enter to return to menu..."
}

run_backup() {
    echo "----- Backup -----"
    BACKUP_DIR="./backups"
    DATE_STAMP=$(date +%Y%m%d-%H%M%S)
    DIRS="projects logs"
    mkdir -p "$BACKUP_DIR"
    for dir in $DIRS; do
        if [ -d "$dir" ]; then
            DEST="$BACKUP_DIR/${dir}_$DATE_STAMP"
            cp -r "$dir" "$DEST"
            echo "Backed up $dir → $DEST"
        else
            echo "Directory $dir not found, skipping."
        fi
    done
    echo "Backup complete."
    read -p "Press Enter to return to menu..."
}

disk_cleanup() {
    echo "----- Disk Cleanup -----"
    read -p "Directory to clean [./logs]: " TARGET
    TARGET="${TARGET:-./logs}"
    read -p "Delete files older than (days) [7]: " DAYS
    DAYS="${DAYS:-7}"
    if [ ! -d "$TARGET" ]; then
        echo "Directory does not exist."
        read -p "Press Enter..."
        return
    fi
    echo "Files older than $DAYS days in $TARGET:"
    find "$TARGET" -type f -mtime "+$DAYS" -print
    read -p "Delete these files? (y/n): " CONFIRM
    if [ "$CONFIRM" = "y" ]; then
        find "$TARGET" -type f -mtime "+$DAYS" -delete
        echo "Deleted."
    else
        echo "Aborted."
    fi
    read -p "Press Enter to return to menu..."
}

# ----- MAIN MENU -----
while true; do
    clear
    echo "====================================="
    echo "        SYSTEM DASHBOARD"
    echo "====================================="
    echo "1. System Health Report"
    echo "2. Log Analysis (sample Apache log)"
    echo "3. Port Scanner"
    echo "4. Run Backup"
    echo "5. Disk Cleanup"
    echo "6. Exit"
    echo "====================================="
    read -p "Enter your choice [1-6]: " choice

    case $choice in
        1) system_health ;;
        2) log_analysis ;;
        3) port_scanner ;;
        4) run_backup ;;
        5) disk_cleanup ;;
        6) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Press Enter to continue..."; read ;;
    esac
done
