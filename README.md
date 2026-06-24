## Day 1 – Linux Foundations & Git Setup

### What I Learned
- **Directory structure** – `mkdir -p`, `touch`, `mv` to scaffold a project.
- **Navigation & inspection** – `pwd`, `ls -la`, `ls -R`, `cat`, `head`, `tail`, `wc`.
- **Permissions** – `chmod +x` to make scripts executable, `ls -l` to verify.
- **Finding files** – `find` by name and modification time.
- **SSH keys** – generated `ed25519` key, added to GitHub, tested connection.
- **Git basics** – `init`, `config`, `add`, `commit`, `remote add`, `push`, `.gitignore`.
- **Incident response** – simulated a lost permission, fixed it, documented in `INCIDENT_LOG.md`.

### Built
- `system-report.sh` – a Bash script that collects uptime, memory, disk, and top processes, logs output, and is scheduled with cron.

### Why This Matters
Every DevOps tool runs on Linux. Permissions, scripting, and Git are the foundation. If you can’t navigate a server and version your work, you can’t build pipelines.

Run it: `./system-report.sh`

## Day 2 – Log Analysis with grep, awk, sed

### What I Learned
- **grep** – find patterns (`" 404 "`), count (`-c`), invert (`-v`), use regex (`-E`).
- **cut & awk** – extract fields from structured logs. `awk` is more powerful (whitespace‑safe, conditionals).
- **sed** – stream editing: substitution (`s/old/new/`), deletion (`/pattern/d`), line ranges.
- **Pipeline power** – chaining commands with `|` to answer real questions (top IPs, status distribution).
- **Scripting best practices** – shebang, `set -euo pipefail`, argument handling, error checking.

### Built
- `log-crunch.sh` – a reusable Apache log analyzer that shows:
  - Total requests
  - Top 5 IP addresses
  - Number of 404 errors
  - URLs hit with 404
  - HTTP status code distribution

### Why This Matters
In production, logs are the first place you look. These tools let you debug 404 storms, spot scanners, and generate quick reports without any monitoring stack.

Run it: `./log-crunch.sh apache_log##


## Day 3 – Process & System Monitoring

### What I Learned
- **ps aux** – full process list, key columns (PID, %CPU, %MEM, STAT).
- **Sorting** – `sort -nrk` to find top CPU/memory consumers.
- **grep** for process filtering and excluding self.
- **Zombie processes** – what they are, how to create and detect them (`ps aux | awk '$8 ~ /Z/'`).
- **top** in batch mode (`top -l 1`) for CPU/memory snapshots.
- **tee** – output to both screen and file simultaneously.

### Built
- `process-check.sh` – a script that captures total processes, top CPU & memory hogs, memory summary, CPU usage, and zombie detection. Scheduled with cron.

### Why This Matters
When a server slows down, the first step is `ps` and `top`. Knowing how to quickly spot resource hogs and zombies is essential for any cloud/DevOps role.

## Day 4 – Users, Groups & Permissions

### What I Learned
- `id`, `whoami`, `groups` – check identity.
- `dscl . -list /Users` – list users on macOS.
- Creating a group with `dscl . -create /Groups/...`.
- Adding a user to a group with `dscl . -append`.
- `chown :group dir` – change group ownership.
- `chmod 770` – owner and group full access, others none.
- **Sticky bit** (`chmod +t`) – prevents deletion of files by non‑owners in a shared directory.

### Built
- `user-setup.sh` – automates group creation, user addition, and shared directory setup with sticky bit.

### Why This Matters
Servers are shared. Knowing how to set up safe, collaborative folders and restrict accidental deletion is a core sysadmin skill.

## Day 5 – Disk Management & Troubleshooting

### What I Learned
- `df -h` to check space, `df -i` for inodes.
- `dd` to create large test files.
- `du -sh *` to find space‑consuming files.
- Simulated a disk‑full scenario and cleaned it up.
- Wrote a script that checks disk usage and alerts if >80%.
- Scheduled it with cron.

### Built
- `disk-check.sh` – alerts when a mount point crosses a usage threshold.

### Why This Matters
A full disk can crash databases, stop log writing, and bring down services. Checking space proactively prevents outages.

## Day 6 – Networking Essentials

### What I Learned
- `ifconfig` to view my IP address and interfaces.
- `ping` and `nslookup` to test connectivity and DNS.
- Started a real Python HTTP server and interacted with it using `curl`.
- Checked what process is listening on a port with `lsof` and `netstat`.
- Built a port scanner using `nc` to automatically check port status.

### Built
- `port-check.sh` – a reusable script that scans a range of ports and reports which are open.

### Why This Matters
In a cloud environment, every service is a port. If you can't connect to a database or an app, you check the port. These are the exact commands I'd use on a production server to debug network issues.

## Day 7 – Git Branching, Merging & Conflicts

### What I Learned
- Created feature branches with `git checkout -b`.
- Made changes on separate branches to simulate teamwork.
- Triggered a merge conflict and resolved it manually.
- Used `git stash` to temporarily save uncommitted work.
- Documented a Git cheat sheet.

### Built
- A resolved merge conflict with a cleaned `README.md`.
- A `git-cheatsheet.md` for quick reference.

### Why This Matters
Conflict resolution is the #1 fear for new engineers. By practicing deliberately, I now know how to handle it without stress.
