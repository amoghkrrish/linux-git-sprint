## Scenario 1: High CPU load

**Symptom:** System slow, high CPU usage.
**Diagnosis:** `top` showed one `yes` process using 100% CPU.
**Root Cause:** Accidental background loop.
**Fix:** Killed the process with `kill <PID>`.
**Commands used:** `top`, `ps aux --sort=-%cpu`, `kill`

## Scenario 2: Disk full

**Symptom:** No space left on device.
**Diagnosis:** `df -h` showed 100% (or high) usage. `du -sh *` found a 300 MB `bigfile.tmp`.
**Root Cause:** Temporary file was not cleaned up.
**Fix:** Deleted the file with `rm`.
**Commands used:** `df -h`, `du -sh *`, `rm`

## Scenario 3: Port already in use

**Symptom:** New service failed with “Address already in use”.
**Diagnosis:** `lsof -i :9000` showed an old Python process holding the port.
**Root Cause:** Stale process from a previous run.
**Fix:** Killed the old process and restarted the service.
**Commands used:** `lsof -i`, `kill`

## Scenario 4: Permission denied on script

**Symptom:** `./myscript.sh` gave “Permission denied”.
**Diagnosis:** `ls -l` showed missing execute bit (`-rw-r--r--`).
**Root Cause:** Script was created without +x.
**Fix:** `chmod +x myscript.sh`
**Commands used:** `ls -l`, `chmod`


## Scenario 5: Memory leak

**Symptom:** Increasing memory usage over time.
**Diagnosis:** `top` showed rising memory consumption. `ps` found a Python script with high `%MEM`.
**Root Cause:** Unbounded list growth in `mem_eater.py`.
**Fix:** Killed the process.
**Commands used:** `top`, `ps aux --sort=-%mem`, `kill`

## Scenario 6: Cron job produced output in unknown location

**Symptom:** Cron job ran but the expected log file was missing from the project directory.
**Diagnosis:** Used `find` to locate `cron-output.log` in `/Users/amoghk/` (or elsewhere). Realised cron's working directory differs.
**Root Cause:** Relative path in cron script.
**Fix:** Rewrote script with absolute path to the log file.
**Commands used:** `find`, `crontab -e`, absolute paths.
