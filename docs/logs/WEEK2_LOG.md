# Week 2 Log: AIOps Control Plane

## Build State & Environment Overview
* **Phase:** Month 1, Week 2 (Networking Mechanics, Storage, & System Environment)
* **Target Host:** `lab-host` (Ubuntu 26.04 LTS / Remote Tailscale Node)
* **Repository:** `~/aiops-control-plane`

---

## Technical Progress Log

### Module 1: DNS Mechanics & Subnet Topology
* **Local Stub Resolver & Systemd-Resolved:**
  * Audited `/etc/resolv.conf` and verified local loopback stub resolver mapping to `127.0.0.53:53`.
  * Inspected `systemd-resolved` interface-specific routing and reverse DNS lookup search domains (`.in-addr.arpa`) managed by Tailscale MagicDNS.
* **Subnet Architecture & CIDR Math:**
  * Calculated IPv4 host allocations using the $2^{32-\text{CIDR}} - 2$ formula for usable host capacity.
  * Mapped local routing tables via `ip route` and `ip -4 addr show`, identifying reserved Network IDs (first address) and Broadcast IDs (last address).

---

### Module 2: Kernel Resource Control & Shell Environment Hierarchy
* **Process & File Descriptor Ceilings (`ulimits`):**
  * Audited soft and hard file descriptor limits using `ulimit -Sn` and `ulimit -Hn`.
  * Verified persistent kernel limit adjustments for maximum open file descriptors (`nofile`) within `/etc/security/limits.conf`.
* **Resource Throttling (`cgroups v2`):**
  * Inspected system unified cgroup tree hierarchy using `systemd-cgls` to verify process isolation across system slices.
* **Shell Environment Initialization Hierarchy:**
  * Audited system-wide and user-level profile loading sequences:
    1. `/etc/environment` (Global static environment variables).
    2. `/etc/profile` (Global interactive/login configurations).
    3. `~/.bashrc` (User-specific interactive shell session overrides).
  * Mapped process execution differences between **Interactive vs. Non-Interactive** and **Login vs. Non-Login** shell sessions.

---

### Module 3: Filesystem Architecture, Mounting, & Persistence
* **Target Storage Directory Preparation & Permission Hardening:**
  * Created dedicated host landing target directories on primary NVMe storage to prepare for isolated service container data paths:
    * `/mnt/media` (Designated for Jellyfin media library streaming)
    * `/mnt/sync` (Designated for Syncthing state synchronization)
  * Applied POSIX user/group ownership modifications using `sudo chown -R $USER:$USER /mnt/media /mnt/sync`, transferring directory inode ownership from `root:root` to `dkalnz:dkalnz` (`755`) to enforce the Principle of Least Privilege and enable non-root application execution.
* **Practice Loopback Sandbox Execution (Archived Target):**
  * Evaluated non-shifting Universally Unique Identifiers (UUIDs) and `/etc/fstab` automounting workflows using temporary loopback disk images (`/var/tmp/media_disk.img` and `/var/tmp/sync_disk.img`).
  * Tested live unmounting via `sudo umount`, detached loopback target nodes (`losetup -d`), and sanitized `/etc/fstab` to preserve clean native filesystem execution on primary NVMe block storage.
* **Automated Storage Validation Engine (`scripts/mount_validator.sh`):**
  * Authored an automated, idempotent Bash validation script with defensive runtime flags (`set -euo pipefail`).
  * Integrated multi-stage automated checks:
    1. **VFS Path Resolution:** Queries `/proc/self/mountinfo` via `findmnt -T` to verify path accessibility on the active kernel filesystem table.
    2. **Filesystem Superblock Audit:** Verifies the underlying disk filesystem matches expected `ext4` parameters.
    3. **I/O Read/Write Test:** Dynamically writes, evaluates, and removes a temporary test file (`.mount_test_tmp`) to confirm user write privileges and catch Read-Only (`ro`) kernel states.
  * Configured deterministic POSIX exit codes (`0` for success, non-zero for specific failure paths) for future CI/CD pipeline integration.

---

## Week 2 Deliverable Status: COMPLETE
- [x] Verified local DNS stub resolution (`127.0.0.53`) and CIDR subnet topology map
- [x] Audited kernel file descriptor limits (`ulimit`) and cgroup v2 resource hierarchies
- [x] Standardized shell environment profile loading behaviors (`/etc/environment` vs `~/.bashrc`)
- [x] Provisioned `/mnt/media` and `/mnt/sync` host landing paths with non-root ownership (`dkalnz:dkalnz`)
- [x] Engineered and validated automated storage validator script (`scripts/mount_validator.sh`)