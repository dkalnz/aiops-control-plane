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
* **Target Landing Directory Preparation:**
  * Created host landing target mount directories for future service container storage:
    * `/mnt/media` (Designated for Jellyfin streaming storage)
    * `/mnt/sync` (Designated for Syncthing state synchronization)
  * Audited POSIX directory ownership and security boundaries using `ls -ld /mnt/media /mnt/sync`, confirming standard `root:root` permissions (`755`).
* **Virtual Storage Image Allocation & Loopback Mechanics:**
  * Allocated two 2-Gigabyte raw storage images under `/var/tmp/` using block duplication:
    * `/var/tmp/media_disk.img`
    * `/var/tmp/sync_disk.img`
  * Attached raw images to virtual loopback block devices using `losetup -fP`, creating non-destructive practice targets (`/dev/loop25` and `/dev/loop26`) to safely evaluate filesystem formatting without risking primary OS disk partitions.
* **Filesystem Formatting (`ext4`) & UUID Extraction:**
  * Formatted loopback block devices with the standard Linux `ext4` filesystem using `mkfs.ext4`.
  * Extracted non-shifting Universally Unique Identifiers (UUIDs) via `sudo blkid`:
    * `/dev/loop25`: `UUID="ee9d4c6c-6bd4-4b68-bfe8-25c0545ce5c5"`
    * `/dev/loop26`: `UUID="8237b809-c951-4ce8-a0a8-d6586bc95dcf"`
* **Persistent Auto-Mounting Engineering (`/etc/fstab`):**
  * Created safety backup of system mount configuration (`sudo cp /etc/fstab /etc/fstab.bak`).
  * Configured reboot-safe entries in `/etc/fstab` using UUID selectors and performance mount options (`defaults,noatime`):
    ```text
    UUID=ee9d4c6c-6bd4-4b68-bfe8-25c0545ce5c5  /mnt/media  ext4  defaults,noatime  0  2
    UUID=8237b809-c951-4ce8-a0a8-d6586bc95dcf  /mnt/sync   ext4  defaults,noatime  0  2
    ```
  * Reloaded systemd in-memory mount units (`sudo systemctl daemon-reload`) and verified syntax execution safety using `sudo mount -a`.
  * Verified active mount state, metadata overhead, and filesystem capacities using `df -h /mnt/media /mnt/sync`.
* **Unmount Fallback & Sandbox Teardown:**
  * Tested live unmounting via `sudo umount /mnt/media /mnt/sync` and verified directory target fallback mechanics back to primary root partition (`/dev/nvme0n1p2`).
  * Detached loopback devices (`losetup -d`), purged temporary practice images, and sanitized `/etc/fstab` in preparation for Week 3 Docker deployment.

---

## Week 2 Deliverable Status: COMPLETE
- [x] Verified local DNS stub resolution (`127.0.0.53`) and CIDR subnet topology map
- [x] Audited kernel file descriptor limits (`ulimit`) and cgroup v2 resource hierarchies
- [x] Standardized shell environment profile loading behaviors (`/etc/environment` vs `~/.bashrc`)
- [x] Formatted `ext4` filesystems, extracted non-shifting UUIDs, and engineered safe `/etc/fstab` persistent mount rules
- [x] Validated live mount/unmount fallback behaviors on host filesystem landing targets (`/mnt/media` and `/mnt/sync`)