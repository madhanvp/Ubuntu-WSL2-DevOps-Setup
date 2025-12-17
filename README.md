# Ubuntu-WSL2-DevOps-Setup

[![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04.3%20LTS-orange?style=flat-square)](https://ubuntu.com/)
[![WSL2](https://img.shields.io/badge/WSL2-Latest-blue?style=flat-square)](https://docs.microsoft.com/en-us/windows/wsl/)
[![Docker](https://img.shields.io/badge/Docker-28.2.2-important?style=flat-square)](https://www.docker.com/)
[![Git](https://img.shields.io/badge/Git-2.43.0-success?style=flat-square)](https://git-scm.com/)
[![Python](https://img.shields.io/badge/Python-3.12.3-informational?style=flat-square)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

> **Complete WSL2 Ubuntu setup documentation & automation for DevOps learning on Windows 11 HP Victus 15**

A comprehensive, production-ready guide to setting up Ubuntu 24.04.3 LTS on WSL2 with pre-installed DevOps tools. This repository showcases my development environment and serves as a reference for others starting their DevOps journey.

## 📚 Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [System Specs](#system-specs)
- [What's Included](#whats-included)
- [Documentation](#documentation)
- [Pre-installed Packages](#pre-installed-packages)
- [Getting Started](#getting-started)
- [Next Steps](#next-steps)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This repository documents my complete WSL2 Ubuntu development setup, including:

✅ **Windows 11 ↔ Ubuntu 24.04.3 LTS Integration**  
✅ **613 Pre-installed System Packages**  
✅ **Docker Container Runtime Ready**  
✅ **Git & Version Control Configured**  
✅ **Python 3.12 Development Environment**  
✅ **Windows File Access in Linux**  
✅ **Automated Setup Scripts**  
✅ **Complete Troubleshooting Guide**

## 🚀 Quick Start

### Prerequisites
- Windows 11 (any edition)
- 4GB RAM minimum (8GB+ recommended)
- 20GB free disk space
- Administrator access

### Three-Step Setup

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/Ubuntu-WSL2-DevOps-Setup.git
cd Ubuntu-WSL2-DevOps-Setup

# 2. Run the automated setup script
bash scripts/automated-setup.sh

# 3. Verify installation
bash scripts/verify-setup.sh
```

**Full instructions available in [INSTALLATION-GUIDE.md](docs/02-INSTALLATION-GUIDE.md)**

## 💻 System Specs

| Component | Details |
|-----------|---------|
| **OS** | Ubuntu 24.04.3 LTS (Noble) |
| **Kernel** | 6.6.87.2-microsoft-standard-WSL2 |
| **Architecture** | x86_64 (amd64) |
| **Hostname** | Mady24 |
| **Hardware** | Windows 11 HP Victus 15 |
| **Total Packages** | 613 |
| **Docker Version** | 28.2.2-ubuntu1~24.04.1 |
| **Git Version** | 1:2.43.0-ubuntu7.3 |
| **Python Version** | 3.12.3-ubuntu2.1 |

## 📦 What's Included

```
Ubuntu-WSL2-DevOps-Setup/
├── README.md                          # You are here!
├── MINDMAP.md                         # Visual setup journey
├── docs/                              # Complete documentation
│   ├── 00-PREREQUISITES.md            # Requirements checklist
│   ├── 01-WSL2-BASICS.md              # Why WSL2?
│   ├── 02-INSTALLATION-GUIDE.md       # Step-by-step setup
│   ├── 03-FILESYSTEM-STRUCTURE.md     # Linux & Windows paths
│   ├── 04-PACKAGES-INSTALLED.md       # Complete package list
│   ├── 05-SYSTEM-CONFIGURATION.md     # Config files (bashrc, gitconfig)
│   ├── 06-ACCESSING-WINDOWS-FILES.md  # Windows file integration
│   ├── 07-TROUBLESHOOTING.md          # Common issues & fixes
│   └── 08-NEXT-STEPS.md               # DevOps roadmap
├── scripts/                           # Automation & utilities
│   ├── automated-setup.sh             # One-command full setup
│   ├── verify-setup.sh                # Verify installation
│   ├── system-info.sh                 # Capture system state
│   ├── cleanup.sh                     # Remove unnecessary packages
│   └── wsl-commands.ps1               # PowerShell helpers
├── configs/                           # Configuration files
│   ├── .bashrc                        # Bash aliases & functions
│   ├── .gitconfig                     # Git configuration
│   ├── wsl.conf                       # WSL2 Linux settings
│   ├── .wslconfig                     # Windows WSL settings
│   └── docker-config.json             # Docker daemon config
├── images/                            # Screenshots & diagrams
│   ├── 01-mindmap/
│   ├── 02-installation/
│   ├── 03-filesystem/
│   ├── 04-packages/
│   └── 05-tools/
├── filesystem-structure.txt           # Complete directory tree
├── package-list-complete.txt          # All 613 packages
├── CHANGELOG.md                       # Version history
└── LICENSE                            # MIT License
```

## 📖 Documentation

### For Complete Setup Instructions:
→ **[START HERE: PREREQUISITES.md](docs/00-PREREQUISITES.md)** - Checklist before installation

### Understanding WSL2:
→ **[WSL2-BASICS.md](docs/01-WSL2-BASICS.md)** - Learn what WSL2 is and why it's awesome

### Step-by-Step Installation:
→ **[INSTALLATION-GUIDE.md](docs/02-INSTALLATION-GUIDE.md)** - My complete setup journey with screenshots

### Filesystem & Path Mapping:
→ **[FILESYSTEM-STRUCTURE.md](docs/03-FILESYSTEM-STRUCTURE.md)** - Windows ↔ Ubuntu paths  
→ **[ACCESSING-WINDOWS-FILES.md](docs/06-ACCESSING-WINDOWS-FILES.md)** - How to work with Windows files

### Complete Package Inventory:
→ **[PACKAGES-INSTALLED.md](docs/04-PACKAGES-INSTALLED.md)** - All 613 packages categorized

### Configuration Details:
→ **[SYSTEM-CONFIGURATION.md](docs/05-SYSTEM-CONFIGURATION.md)** - .bashrc, .gitconfig, wsl.conf

### Help & Troubleshooting:
→ **[TROUBLESHOOTING.md](docs/07-TROUBLESHOOTING.md)** - Common issues and solutions

### What's Next:
→ **[NEXT-STEPS.md](docs/08-NEXT-STEPS.md)** - DevOps learning roadmap

## 📋 Pre-installed Packages

### System Tools (Pre-installed)
- **Git** v1:2.43.0 - Version control system
- **Docker.io** v28.2.2 - Container runtime
- **Python 3.12** - Programming language with dev headers
- **CURL & Wget** - Download utilities
- **LSHW** - Hardware information tool
- **Build Tools** - gcc, make, cmake

### Development Libraries (Pre-installed)
- LibPython3.12 (stdlib, dev, minimal)
- LibFFI6 - Foreign Function Interface
- LibWebP7 - Image compression
- Various Python apt interfaces

**Full list:** [PACKAGES-INSTALLED.md](docs/04-PACKAGES-INSTALLED.md)  
**Raw output:** [package-list-complete.txt](package-list-complete.txt)

## 🚀 Getting Started

### 1. **New to WSL2?**
   ```bash
   Read: docs/01-WSL2-BASICS.md
   Then: docs/02-INSTALLATION-GUIDE.md
   ```

### 2. **Already have WSL2?**
   ```bash
   Run: bash scripts/verify-setup.sh
   Then: Review docs/04-PACKAGES-INSTALLED.md
   ```

### 3. **Ready for DevOps?**
   ```bash
   Check: docs/08-NEXT-STEPS.md
   Setup: Docker Compose, kubectl, Terraform
   ```

### 4. **Having Issues?**
   ```bash
   Consult: docs/07-TROUBLESHOOTING.md
   Or: Create an issue on GitHub
   ```

## 📊 My DevOps Learning Journey

**Current Stage:** 5th Semester BCA (Apollo Arts and Science College, Madras University)

**Technical Background:**
- 🐍 Python (1st Semester)
- 🔧 C++ (2nd Semester)
- ☕ Java (3rd Semester)
- 📚 Data Structures (4th Semester)
- 🌐 Web Technology, OS, Software Engineering, RDBMS (5th Semester)

**Current Focus:**
- DevOps fundamentals & practices
- Container orchestration (Docker, Kubernetes)
- CI/CD pipelines & automation
- Infrastructure as Code (Terraform, Ansible)

**Next:** 6th Semester (Final) → DevOps internship/junior roles

## 🛠️ Automation Scripts

All scripts are executable and documented:

```bash
# Full setup in one command
./scripts/automated-setup.sh

# Verify everything is installed correctly
./scripts/verify-setup.sh

# Export your current system info
./scripts/system-info.sh

# Remove unnecessary packages
./scripts/cleanup.sh
```

## 🔗 Quick Links

- **Windows 11 WSL2 Docs:** https://docs.microsoft.com/en-us/windows/wsl/
- **Ubuntu Documentation:** https://help.ubuntu.com/
- **Docker Getting Started:** https://docs.docker.com/get-started/
- **Git Documentation:** https://git-scm.com/doc
- **Python 3 Docs:** https://docs.python.org/3/

## 🤝 Contributing

Found an issue or have improvements? Contributions are welcome!

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

**See [CONTRIBUTING.md](CONTRIBUTING.md) for details**

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Support

- **Issues:** [GitHub Issues](../../issues)
- **Discussions:** [GitHub Discussions](../../discussions)
- **Email:** madhan.vp2005@gmail.com
- **LinkedIn:** https://www.linkedin.com/in/madhan-vp-579193350/

---

## 🙏 Acknowledgments

- Microsoft for WSL2 technology
- Canonical for Ubuntu
- Docker team for containerization
- Open source community

---

**⭐ If this repo helped you, please star it! ⭐**

**Last Updated:** December 17, 2025  
**Maintained by:** Mady (BCA Final Year - Apollo Arts and Science College)

---

*This repository is part of my DevOps learning journey. Follow along as I continue building towards my first DevOps role! 🚀*
