# AIOps Control Plane: Month 1 Master Curriculum

## **MONTH 1: LINUX SYSTEMS ENGINEERING & CONTAINER FOUNDATIONS**
**Core Objective:** Turn `lab-host` into a hardened, production-ready headless server and master containerized execution environments.

---

### **Week 1: Hardening, Process Control, & Networking** *(Compressed Schedule)*
* **Tuesday (8/18): Initial Provisioning & Mesh Control [COMPLETE]**
  * Clean install Ubuntu 26.04 LTS on dedicated hardware (`lab-host`).
  * Install and configure `openssh-server`.
  * Establish encrypted mesh networking via Tailscale.
  * Verify remote SSH connectivity from primary workstation.
* **Wednesday (8/19): Identity & File System Hardening [COMPLETE]**
  * Generate high-entropy `ed25519` key pair on Gaming PC and deploy via `ssh-copy-id`.
  * OpenSSH daemon hardening: Create `/etc/ssh/sshd_config.d/50-hardening.conf` to disable password login and root access.
  * POSIX permissions model: Audit ownership (`chown`) and octal permissions (`chmod 700 ~/.ssh`, `chmod 600 authorized_keys`).
  * Deliverable: Remote access restricted strictly to cryptographic SSH keys.
* **Thursday (8/20): Systemd Services & Process Orchestration**
  * Process auditing: Inspect system processes via `ps aux`, `top`, and `htop`.
  * Systemd daemon architecture: Manage service units using `systemctl` (`start`, `stop`, `enable`, `status`).
  * Custom Unit Creation: Write `/etc/systemd/system/aiops-telemetry.service` to execute a custom Python background daemon.
  * Log analysis: Audit system binaries and journal logs using `journalctl -u`.
  * Deliverable: A custom Python script running as an auto-restarting systemd background daemon.
* **Friday (8/21): Network Isolation & Host Firewalls**
  * Port auditing: Map listening sockets using `ss -tulpn` and `netstat`.
  * Uncomplicated Firewall (`ufw`) configuration: Set default `deny ingress` / `allow egress` policies.
  * Bind rules: Explicitly whitelist Tailscale interface (`tailscale0`) and SSH traffic while dropping public interface noise.
  * Deliverable: Host-level firewall active with all unneeded ingress ports locked down.
* **Saturday & Sunday (8/22 - 8/23): Integration & Proof-of-Work Verification**
  * Initialize Git repository `~/aiops-control-plane`.
  * Write `WEEK1_LOG.md` detailing SSH configs, systemd unit files, and firewall rules.
  * Push Week 1 code and documentation to GitHub repository.

---

### **Week 2: Networking Mechanics, Storage, & Environment**
* **Monday (8/24): DNS Resolution & Subnet Auditing**
  * Inspect local resolver configurations in `/etc/resolv.conf` and `systemd-resolved`.
  * Audit loopback interfaces, local routing tables (`ip route`), and subnets in CIDR notation.
  * Deliverable: Verified local and mesh DNS resolution path map.
* **Tuesday (8/25): Kernel Resource Limits & Environment Loading**
  * Study process limits (`ulimit`) and cgroups v2 resource boundaries.
  * Configure environment variable loading hierarchy across `/etc/environment`, `/etc/profile`, and `~/.bashrc`.
  * Deliverable: Standardized shell profile configuration across remote sessions.
* **Wednesday (8/26): Filesystem Architecture & Secondary Storage Mounting**
  * Identify block devices using `lsblk` and `blkid`.
  * Format secondary storage drives with `ext4` filesystems and set mount directory targets.
  * Deliverable: Mounted secondary drive ready for persistent storage allocation.
* **Thursday (8/27): Automated Storage Persistence via Fstab**
  * Edit `/etc/fstab` using UUIDs for non-breaking persistent automounting on boot.
  * Test mount execution safety using `sudo mount -a` without system reboot risks.
  * Deliverable: Persistent storage mount verified against reboot cycles.
* **Friday - Sunday (8/28 - 8/30): Storage Automation & Week 2 Capstone**
  * Write an automated storage mount validation script in Bash.
  * Update `~/aiops-control-plane/WEEK2_LOG.md` with networking maps and fstab configurations.
  * Push Week 2 updates to GitHub.

---

### **Week 3: Core Docker Engine Architecture**
* **Monday (8/31): Docker Engine Installation & Security Group Setup**
  * Install official Docker Engine and Docker CLI packages on Ubuntu 26.04.
  * Manage non-root privilege escalation by configuring the `docker` user group.
  * Deliverable: Non-root execution of `docker run hello-world`.
* **Tuesday (9/1): Container Lifecycle Operations**
  * Deep dive into container lifecycle commands: `docker run`, `exec`, `stop`, `rm`, `logs`, and `inspect`.
  * Practice interactive terminal access inside detached containers.
  * Deliverable: Operational familiarity with container management workflows.
* **Wednesday (9/2): Base Image Selection & Dockerfile Authoring**
  * Learn Docker manifest syntax: `FROM`, `WORKDIR`, `COPY`, `RUN`, `ENV`, and `CMD`.
  * Author a single-stage `Dockerfile` to containerize a basic Python environment.
  * Deliverable: Functional local container image built via `docker build`.
* **Thursday (9/3): Multi-Stage Build Optimization**
  * Refactor single-stage builds into lightweight multi-stage Dockerfiles (using Alpine/Slim bases).
  * Reduce image footprint by separating build-time dependencies from final runtime containers.
  * Deliverable: Production-ready Dockerfile under 100MB.
* **Friday - Sunday (9/4 - 9/6): Container Packaging & Week 3 Capstone**
  * Package a low-footprint Python system application into your optimized container image.
  * Write `~/aiops-control-plane/WEEK3_LOG.md` detailing container specs and image sizing benchmarks.
  * Push Dockerfiles and Week 3 documentation to GitHub.

---

### **Week 4: Multi-Container Compose Orchestration**
* **Monday (9/7): Multi-Service Declarative Specs**
  * Master `docker-compose.yml` file schema versioning, service declarations, and environment variables.
  * Write compose configurations to manage multiple interdependent services.
  * Deliverable: Single-command application bring-up using `docker compose up -d`.
* **Tuesday (9/8): Isolated Container Networking**
  * Configure custom bridge networks within Docker Compose.
  * Test service-to-service communication using internal container DNS aliases instead of IP addresses.
  * Deliverable: Isolated, non-routable internal container network stack.
* **Wednesday (9/9): Persistent Data Volumes**
  * Compare short-lived container layers, local bind mounts, and Docker named volumes.
  * Attach named volumes to retain state across container destructions (`docker compose down`).
  * Deliverable: State persistence verified after full container tearing and recreation.
* **Thursday (9/10): Operational Monitoring & Resource Constraints**
  * Enforce CPU and RAM resource caps on Compose services using `deploy.resources` limits.
  * Audit multi-container resource usage and aggregate logs using `docker compose logs -f` and `docker stats`.
  * Deliverable: Resource-bounded multi-container execution profile.
* **Friday - Sunday (9/11 - 9/13): Month 1 Capstone Integration & Sign-off**
  * Assemble a multi-container stack (Python service + Redis base) managed entirely via Docker Compose.
  * Complete `WEEK4_LOG.md` and consolidate all Month 1 assets into `~/aiops-control-plane`.
  * Push final Month 1 codebase and documentation to GitHub.