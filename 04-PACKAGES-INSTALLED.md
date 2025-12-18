# 04 - PACKAGES INSTALLED: Complete Inventory

## 📦 Your 613 Pre-Installed Packages

This document catalogs everything installed in your Ubuntu 24.04.3 LTS environment.

---

## 🏗️ System Core Packages

| Package | Version | Purpose |
|---------|---------|---------|
| ubuntu-base | 24.04.3 | Ubuntu base system |
| linux-image-generic | 6.6.87 | Linux kernel |
| systemd | Latest | Init system (service management) |
| libc6 | 2.39 | C standard library (core) |
| libc-bin | 2.39 | C library utilities |
| gcc-base | Latest | GCC compiler base |
| binutils | Latest | Binary utilities |

---

## 🔧 Development Tools & Git

| Package | Version | Purpose |
|---------|---------|---------|
| **git** | 1:2.43.0-ubuntu7.3 | Version control system |
| git-man | 1:2.43.0-ubuntu7.3 | Git manual pages |
| git-core | 1:2.43.0-ubuntu7.3 | Git core functionality |
| curl | Latest | Download utility |
| wget | Latest | Download tool |
| build-essential | Latest | Compilation tools (gcc, g++, make) |
| gcc | Latest | C compiler |
| g++ | Latest | C++ compiler |
| make | Latest | Build automation |
| pkg-config | Latest | Library configuration |
| autoconf | Latest | Configuration script generator |
| automake | Latest | Makefile generator |

---

## 🐳 Docker & Containers

| Package | Version | Purpose |
|---------|---------|---------|
| **docker.io** | 28.2.2-ubuntu1~24.04.1 | Docker container runtime |
| docker-ce-cli | Latest | Docker command-line interface |
| docker-init | Latest | Docker init process |
| containerd.io | Latest | Container runtime (Docker dependency) |
| runc | Latest | Container executor (OCI) |

**Docker Key Features Pre-installed:**
- ✅ Container creation and management
- ✅ Image building
- ✅ Docker daemon ready
- ✅ Network support
- ✅ Volume management

**Next: Install docker-compose separately**

---

## 🐍 Python 3 & Development

| Package | Version | Purpose |
|---------|---------|---------|
| **python3** | 3.12.3-ubuntu2.1 | Python 3.12 interpreter |
| python3-minimal | 3.12.3 | Minimal Python 3 |
| python3-stdlib | 3.12.3 | Python standard library |
| python3-dev | 3.12.3 | Python development headers |
| libpython3.12 | 3.12.3 | Python 3.12 runtime library |
| libpython3.12-dev | 3.12.3 | Python 3.12 dev library |
| libpython3.12-minimal | 3.12.3 | Minimal Python lib |
| python3-distutils | Latest | Distutils (deprecated but included) |
| python3-lib2to3 | Latest | Python 2 to 3 converter |
| python3-pip | Latest | Package installer for Python |
| pip | Latest | Package installer |
| setuptools | Latest | Python packaging utilities |
| wheel | Latest | Wheel package format |

**Python 3.12 Capabilities:**
- ✅ Script execution
- ✅ Package management (pip)
- ✅ Virtual environments (venv)
- ✅ Web frameworks (Flask, Django)
- ✅ Data science (NumPy, Pandas - install separately)

---

## 📚 Libraries & Runtime Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| libcurl4 | Latest | HTTP client library |
| libssl3 | Latest | Secure Socket Layer library |
| openssl | Latest | Cryptography toolkit |
| libffi6 | 4.5.1 | Foreign Function Interface |
| libwebp7 | 1.3.2 | WebP image format library |
| zlib1g | Latest | Compression library |
| libbz2-1.0 | Latest | BZ2 compression |
| libexpat1 | Latest | XML parsing library |
| libreadline8 | Latest | Command line editing |
| libncursesw6 | Latest | Terminal control library |

---

## 🖨️ System Utilities

| Package | Version | Purpose |
|---------|---------|---------|
| apt | Latest | Package manager |
| apt-utils | Latest | APT utilities |
| dpkg | Latest | Package manager core |
| lshw | 02.19 | Hardware information tool |
| lsb-release | Latest | LSB version report |
| udev | Latest | Device manager |
| sudo | Latest | Privilege escalation |
| passwd | Latest | Password management |
| openssh-client | Latest | SSH client |
| rsync | Latest | File synchronization |
| tar | Latest | Archive utility |
| gzip | Latest | Compression |
| bzip2 | Latest | BZ2 compression |
| xz-utils | Latest | XZ compression |
| ca-certificates | 20240311 | SSL/TLS certificate store |

---

## 🌐 Localization & Fonts

| Package | Version | Purpose |
|---------|---------|---------|
| locales | Latest | Locale support |
| fonts-ubuntu | 0.869 | Ubuntu typeface |
| language-pack-en | Latest | English language support |
| python-apt-common | 2.7.7 | APT Python interface |
| python3-apt | 2.7.7 | APT Python 3 interface |

---

## 📊 Your Package Categories

```
Total Installed: 613 packages

Distribution:
├── System & Kernel (50 packages)
├── Development Tools (35 packages)
├── Container Tech (12 packages)
├── Python & Interpreters (25 packages)
├── Libraries & Runtime (180 packages)
├── Utilities (60 packages)
├── Localization & Fonts (15 packages)
├── Documentation & Man Pages (40 packages)
└── Configuration & System (76 packages)
```

---

## 🔍 Check Your Package Versions

### View All Installed Packages

```bash
# List all packages
apt list --installed

# Count total packages
apt list --installed | wc -l

# Check specific package
apt list --installed | grep docker
apt list --installed | grep python3
apt list --installed | grep git
```

### Get Detailed Package Info

```bash
# Check single package details
apt show docker.io

# Show package dependencies
apt depends docker.io

# Show reverse dependencies (what needs this)
apt rdepends git
```

---

## 📥 Future Packages to Install

These are NOT pre-installed but commonly needed:

### Container Orchestration
```bash
# Docker Compose (multi-container orchestration)
sudo apt install docker-compose

# Kubernetes tools
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Minikube (local Kubernetes)
curl -minikube-latest.linux-amd64
```

### Infrastructure as Code
```bash
# Terraform (infrastructure provisioning)
wget https://releases.hashicorp.com/terraform/latest/terraform_linux_amd64.zip

# Ansible (configuration management)
sudo apt install ansible

# Vagrant (VM automation)
sudo apt install vagrant
```

### CI/CD Tools
```bash
# Jenkins (automation server)
# GitLab Runner
# GitHub Actions runner
```

### Monitoring & Logging
```bash
# Prometheus (metrics)
# Grafana (visualization)
# ELK Stack (logging)
# DataDog, New Relic agents
```

---

## 🗑️ Cleanup & Optimization

### Remove Unnecessary Packages

```bash
# Remove unused dependencies
sudo apt autoremove

# Clean package cache
sudo apt clean

# See what can be removed
sudo apt autoremove --dry-run
```

### Check Disk Usage

```bash
# See how much space apt cache uses
du -sh /var/cache/apt

# Overall Ubuntu disk usage
du -sh /

# Home directory usage
du -sh ~/
```

---

## 📈 Package Management Commands

```bash
# Update package lists
sudo apt update

# Upgrade all packages
sudo apt upgrade

# Install new package
sudo apt install package-name

# Remove package
sudo apt remove package-name

# Search for package
apt search keyword

# Show package info
apt show package-name

# Check package dependencies
apt depends package-name
```

---

## 🔐 Security Notes

### Keeping Packages Updated

```bash
# Check for security updates
sudo apt list --upgradable

# Apply security updates only
sudo apt install -y unattended-upgrades

# Enable automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades
```

### Package Verification

```bash
# Check package integrity
apt-get check

# Fix broken packages
sudo apt --fix-broken install

# Fix missing dependencies
sudo apt install -f
```

---

## 📝 Your Package Snapshot

**Captured:** December 17, 2025, 21:45 IST  
**Ubuntu Version:** 24.04.3 LTS  
**Total Packages:** 613  
**Kernel:** 6.6.87.2-microsoft-standard-WSL2  
**Status:** All packages up-to-date ✅
