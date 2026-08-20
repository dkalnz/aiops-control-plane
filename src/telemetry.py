import time
import sys
import datetime

print("AIOps Telemetry Daemon Initialized.", flush=True)

while True:
    now = datetime.datetime.now(datetime.timezone.utc).isoformat()
    # Outputs timestamp to stdout (captured by journalctl)
    print(f"[{now}] STATUS: OK | HOST: lab-host | TELEMETRY: operational", flush=True)
    time.sleep(10)
