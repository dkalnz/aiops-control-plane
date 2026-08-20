# Week 1 Log: AIOps Control Plane

## Build State
- **Phase:** Month 1, Week 1
- **Target Host:** lab-host (Ubuntu 26.04 LTS)
- **Repository:** `aiops-control-plane`

---

## Progress Log

### Tuesday (8/18): Initial Provisioning & Mesh Control [COMPLETE]
- Installed clean Ubuntu 26.04 LTS on dedicated hardware (`lab-host`).
- Installed and configured `openssh-server`.
- Established encrypted mesh networking via Tailscale across local nodes.
- Verified remote passwordless SSH connectivity from primary workstation using SSH host aliases (`lab`).

### Wednesday (8/19): Identity, File System Hardening, & Repository Setup [COMPLETE]
- **Cryptographic SSH Key Deployment:**
  - Generated high-entropy `ed25519` SSH key pair on primary workstation.
  - Deployed public key to `~/.ssh/authorized_keys` on `lab-host`.
- **OpenSSH Daemon Hardening:**
  - Configured drop-in security rule `/etc/ssh/sshd_config.d/50-hardening.conf`:
    - Disabled password authentication (`PasswordAuthentication no`).
    - Disabled root login (`PermitRootLogin no`).
    - Explicitly enabled public key authentication (`PubkeyAuthentication yes`).
  - Reloaded systemd daemon and restarted `sshd` service to enforce rules.
- **POSIX Permission Audit:**
  - Enforced strict octal permission model on `lab-host`:
    - Set `~/.ssh` directory to `700` (`drwx------`).
    - Set `~/.ssh/authorized_keys` to `600` (`-rw-------`).
  - Audited filesystem permissions using `ls -la ~/.ssh` to ensure no group or world access.
- **Version Control & GitHub Setup:**
  - Initialized local Git repository at `~/aiops-control-plane`.
  - Configured global Git identity (`user.name` and `user.email`).
  - Generated dedicated GitHub deploy key (`id_github`) and verified SSH connection to `git@github.com`.
  - Added root `.gitignore` rules for Python bytecode, system logs, and environment artifacts.
  - Linked remote origin and pushed initial codebase to GitHub repository.

---

### Thursday (8/20): Systemd Services & Process Orchestration [COMPLETE]
- **Process Auditing & System Inspection:**
  - Audited live process execution tree using `ps aux` and `htop`.
  - Verified process identification (PID 1) assigned to `/usr/lib/systemd/systemd`.
- **Hardware Telemetry Daemon Development:**
  - Created Python telemetry script at `/opt/aiops/telemetry.py` targeting `/proc` filesystem and system kernel interfaces.
  - Configured script to collect 1-minute CPU load averages (`os.getloadavg`), RAM usage via `/proc/meminfo`, and root partition storage via `shutil.disk_usage`.
  - Structured output stream to emit standardized JSON telemetry objects over `stdout`.
  - Set executable permissions via `chmod +x /opt/aiops/telemetry.py`.
- **Systemd Unit File Configuration:**
  - Authored system daemon specification file `/etc/systemd/system/aiops-telemetry.service`.
  - Configured unit dependency chain (`After=network.target`) and execution targets (`ExecStart=/usr/bin/python3 /opt/aiops/telemetry.py`).
  - Implemented automated fault recovery policies (`Restart=always`, `RestartSec=5`).
  - Directed process output streams (`StandardOutput=journal`, `StandardError=journal`) to `journald`.
- **Service Orchestration & Log Auditing:**
  - Triggered systemd unit reload (`systemctl daemon-reload`) to register changes.
  - Enabled and started background daemon (`systemctl enable --now aiops-telemetry.service`).
  - Verified `active (running)` state and audited real-time log ingestion via `journalctl -u aiops-telemetry.service -f`.
- **Repository Version Synchronization:**
  - Mirrored live telemetry source (`telemetry.py`) and unit configuration (`aiops-telemetry.service`) into `~/aiops-control-plane/src/`.
  - Staged, committed, and pushed Week 1 Day 3 artifacts to GitHub remote (`main`).