### Friday (8/21): Network Isolation & Host Firewalls [COMPLETE]
- **Socket & Port Auditing:**
  - Mapped listening network sockets using `ss -tulpn`.
  - Audited active listening interfaces for SSH and local daemons.
- **Uncomplicated Firewall (UFW) Hardening:**
  - Enforced strict default policies: `default deny incoming`, `default allow outgoing`.
  - Configured interface-specific ingress rules:
    - Allowed SSH traffic strictly over `tailscale0` interface (`sudo ufw allow in on tailscale0 to any port 22 proto tcp`).
  - Activated host firewall using `sudo ufw enable`.
- **Firewall Verification:**
  - Audited active rule set via `sudo ufw status verbose` to confirm public interface drops non-mesh ingress.

---

### Saturday (8/22): Integration & Proof-of-Work Verification [COMPLETE]
- **System & Repository Audit:**
  - Verified clean status of local Git repository `~/aiops-control-plane`.
  - Audited systemd service runtime (`aiops-telemetry.service`) and `journald` logging state.
  - Validated UFW rules, SSH key authentication policies, and directory permissions (`~/.ssh`).
- **Documentation & Version Synchronization:**
  - Finalized `week1_log.md` detailing Week 1 systems engineering work.
  - Staged, committed, and pushed final Week 1 proof-of-work documentation to GitHub remote repository (`main`).

---

## Week 1 Deliverable Status: COMPLETE
- [x] Hardened OpenSSH daemon & key-based authentication
- [x] Custom Python telemetry daemon running under systemd
- [x] Active UFW host firewall enforcing strict ingress controls
- [x] Version control repository synchronized with remote origin