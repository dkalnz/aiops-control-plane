# AIOps Control Plane: 6-Month Master Curriculum
**Target Role:** Systems Operations, Automation, and Local AI Integration Specialist  
**Hardware Engine:** `lab-host` (Ubuntu 26.04 LTS / Remote Tailscale Node)  
**Weekly Commitment:** 15 Hours / Week  
**Start Date:** Tuesday, August 18, 2026  

---

## **MONTH 1: LINUX SYSTEMS ENGINEERING & CONTAINER FOUNDATIONS**
**Core Objective:** Turn `lab-host` into a hardened, production-ready headless server and master containerized execution environments.

### **Week 1: Hardening, Process Control, & Networking** *(Compressed 5-Day Schedule)*
* **Tuesday (8/18): Initial Provisioning & Mesh Control [COMPLETE]**
  * Clean install Ubuntu 26.04 LTS on dedicated hardware (`lab-host`).
  * Install and configure `openssh-server`.
  * Establish encrypted mesh networking via Tailscale.
  * Verify remote passwordless SSH connectivity from primary workstation.
* **Wednesday (8/19): Identity & File System Hardening**
  * Key-based authentication: Generate `ed25519` key pairs, deploy with `ssh-copy-id`.
  * OpenSSH daemon hardening: Edit `/etc/ssh/sshd_config` to disable password login and root login.
  * POSIX permissions model: Deep dive into Ownership (`chown`), Groups (`chgrp`), and Octal Permissions (`chmod 755`, `600`, `400`).
  * Deliverable: Remote access restricted strictly to SSH keys.
* **Thursday (8/20): Systemd Services & Process Orchestration**
  * Process auditing: Inspect system processes via `ps aux`, `top`, and `htop`.
  * Systemd daemon architecture: Manage service units using `systemctl` (`start`, `stop`, `enable`, `status`).
  * Custom Unit Creation: Write a custom `/etc/systemd/system/AIOps-telemetry.service` unit file to execute a background daemon.
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

### **Week 2: Networking Mechanics, Storage, & Environment**
* **DNS & Subnets:** Inspect `/etc/resolv.conf`, systemd-resolved, loopback routing, and CIDR blocks.
* **Kernel Resource Control:** Study process limits, cgroups v2, and system environment loading (`/etc/environment`, `~/.bashrc`).
* **Storage Mounting:** Mount secondary storage drives, inspect filesystem types (`ext4`), and edit `/etc/fstab` for persistent mounts.
* **Deliverable:** Automated storage mount script and shell environment profile setup.

### **Week 3: Core Docker Engine Architecture**
* **Docker Foundations:** Install Docker Engine & Docker CLI; add non-root user to `docker` group.
* **Image Construction:** Write production `Dockerfile` manifests (base images, layer optimization, multi-stage builds).
* **Container Mechanics:** Lifecycle management (`docker run`, `exec`, `stop`, `rm`, `logs`, `inspect`).
* **Deliverable:** Multi-stage Dockerfile packaging a low-footprint Python system application.

### **Week 4: Multi-Container Compose Orchestration**
* **Docker Compose:** Write `docker-compose.yml` for multi-service stack management.
* **Container Networking:** Configure isolated bridge networks, internal service discovery, and DNS aliases.
* **Persistent Volumes:** Bind mounts vs. Docker named volumes for state retention.
* **Deliverable:** Multi-container application stack running securely via Docker Compose.

---

## **MONTH 2: TELEMETRY ENGINE & API SERVICES**
**Core Objective:** Build a real-time system monitoring engine using Python, PostgreSQL, and FastAPI.

* **Week 5:** PostgreSQL database containerization, schemas, indices, and persistent volumes.
* **Week 6:** Python system telemetry collector using `psutil` (CPU, RAM, disk I/O, network metrics).
* **Week 7:** FastAPI REST engine development, route definitions, and Pydantic data validation schemas.
* **Week 8:** Database ORM integration (SQLAlchemy/SQLModel) and automated API endpoint testing.

---

## **MONTH 3: CACHING & ADVANCED NETWORKING**
**Core Objective:** Implement high-speed caching layers and reverse proxy traffic control.

* **Week 9:** Redis caching integration for API query response acceleration.
* **Week 10:** Reverse Proxy architecture using Caddy/Nginx for TLS termination and proxy routing.
* **Week 11:** Asynchronous task processing using Celery / Redis background workers.
* **Week 12:** System integration testing, performance profiling, and memory leak analysis.

---

## **MONTH 4: AWS CLOUD EXTENSION & IaC TEMPLATES**
**Core Objective:** Mirror the local on-premise stack to cloud infrastructure using Infrastructure as Code.

* **Week 13:** AWS Core Services Setup (VPC, Subnets, EC2, Security Groups, IAM Roles).
* **Week 14:** Terraform (IaC) provisioning scripts for declarative cloud environment deployment.
* **Week 15:** GitHub Actions CI/CD automation pipelines for automated container builds and deployments.
* **Week 16:** AWS Certified Cloud Practitioner (CCP) domain alignment and cloud architecture review.

---

## **MONTH 5: LOCAL AI ORCHESTRATION & RAG PIPELINES**
**Core Objective:** Deploy local offline AI models and inject server context using Vector Databases.

* **Week 17:** Ollama local model hosting (Llama 3 / Mistral) running natively on host hardware.
* **Week 18:** Vector Database deployment (Qdrant / ChromaDB) and text embedding workflows.
* **Week 19:** Document Parsing & Context Injection: Vectorizing system logs, markdown docs, and API specs.
* **Week 20:** Open WebUI integration + Retrieval-Augmented Generation (RAG) agent construction.

---

## **MONTH 6: CHAOS ENGINEERING, RECOVERY, & CAPSTONE SIGN-OFF**
**Core Objective:** Test platform resiliency, automate full disaster recovery, and package final portfolio.

* **Week 21:** Chaos testing: Simulating network drops, OOM crashes, container failures, and disk exhaustion.
* **Week 22:** Automated backup engine: PostgreSQL dumps, volume snapshots, and offsite automated syncing.
* **Week 23:** Complete platform dashboard integration and live operational status panel.
* **Week 24:** Final portfolio sign-off, system documentation publishing, and AWS CCP examination.
