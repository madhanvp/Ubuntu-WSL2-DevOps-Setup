# 03 - FILESYSTEM STRUCTURE: Understanding Linux & Windows Paths

## 🗂️ Linux Directory Structure in WSL2

Your Ubuntu installation follows standard Linux filesystem organization:

```
/ (Root - Everything starts here)
│
├── bin/                    → Essential command binaries (ls, cat, grep)
├── boot/                   → Boot loader files (kernel, initramfs)
├── dev/                    → Device files (null, zero, random, etc.)
├── etc/                    → System configuration files
│   ├── apt/
│   ├── docker/
│   ├── bash.bashrc
│   └── wsl.conf           ← WSL2 specific config
│
├── home/                   → User home directories
│   └── mady24/             ← YOUR HOME DIRECTORY
│       ├── .bashrc         ← Bash configuration
│       ├── .gitconfig      ← Git configuration
│       ├── .ssh/           ← SSH keys
│       ├── .local/         ← User local data
│       ├── .cache/         ← Cache files
│       ├── Documents/      → Links to Windows
│       ├── Desktop/        → Links to Windows
│       ├── Downloads/      → Links to Windows
│       └── projects/       ← Your code projects
│
├── lib/                    → Shared libraries (libc, libpython, etc.)
├── lib64/                  → 64-bit libraries
├── media/                  → Mount points for removable media
│
├── mnt/                    → Mount points (IMPORTANT!)
│   ├── c/                  ← Windows C: drive (/mnt/c/Users/...)
│   ├── d/                  ← Windows D: drive (if exists)
│   ├── e/                  ← Windows E: drive (if exists)
│   └── wsl/                ← WSL-specific mounts
│
├── opt/                    → Optional software packages
│   └── (custom applications go here)
│
├── proc/                   → Virtual filesystem (process info)
├── root/                   → Root user's home (/root/)
├── run/                    → Runtime data
├── sbin/                   → System binaries (for root)
├── srv/                    → Service data
├── sys/                    → System kernel info
│
├── tmp/                    → Temporary files (cleared on reboot)
│   └── (build artifacts, temp scripts)
│
├── usr/                    → User programs & data
│   ├── bin/                → User command binaries
│   │   ├── git
│   │   ├── docker
│   │   ├── python3
│   │   ├── curl
│   │   ├── wget
│   │   └── ... (hundreds of tools)
│   ├── local/              → Locally installed software
│   ├── lib/                → Libraries for /usr/bin programs
│   ├── share/              → Shared data (man pages, docs)
│   └── src/                → Source code
│
└── var/                    → Variable data
    ├── log/                → System logs
    │   ├── apt/
    │   ├── docker/
    │   └── auth.log
    ├── cache/              → Cache data
    └── www/                → Web server data
```

---

## 🪟 Windows File Access from WSL2

### Understanding /mnt/c/

The key to Windows-Linux integration is the `/mnt/` directory:

```
Windows C: Drive Path          →    WSL2 Linux Path
──────────────────────────────      ──────────────────────
C:\                            →    /mnt/c/
C:\Users\                      →    /mnt/c/Users/
C:\Users\Mady\                 →    /mnt/c/Users/Mady/
C:\Users\Mady\Documents\       →    /mnt/c/Users/Mady/Documents/
C:\Users\Mady\Desktop\         →    /mnt/c/Users/Mady/Desktop/
C:\Users\Mady\Downloads\       →    /mnt/c/Users/Mady/Downloads/
C:\Program Files\              →    /mnt/c/Program Files/
C:\Windows\System32\           →    /mnt/c/Windows/System32/

(If you have D:, E:, F: drives)
D:\                            →    /mnt/d/
E:\                            →    /mnt/e/
```

### Real-World Examples

**Access your Windows Documents from Ubuntu:**

```bash
# Navigate to your Windows Documents folder
cd /mnt/c/Users/Mady/Documents

# List contents
ls -la

# Create a file in Windows Documents from Ubuntu
echo "Created from Ubuntu!" > /mnt/c/Users/Mady/Documents/test.txt

# Edit a Windows file from Ubuntu
nano /mnt/c/Users/Mady/Documents/myfile.txt
```

**Access Ubuntu files from Windows Explorer:**

```
File Explorer → This PC → Linux → Ubuntu-24.04
  ↓
Automatically mounts at: \\wsl$\Ubuntu\

So Ubuntu /home/mady24/ is accessible as:
\\wsl$\Ubuntu\home\mady24\

You can:
• View files in File Explorer
• Edit with Windows VS Code
• Copy files between Windows and Linux
• Create shortcuts to Linux folders
```

---

## 🔐 WSL2 Distro Location (on Windows Side)

### Where is Ubuntu stored?

Ubuntu 24.04.3 LTS files are located in your Windows AppData:

```
%USERPROFILE%\AppData\Local\Packages\
  CanonicalGroupLimited.Ubuntu-24.04_79rhkp1fndgsc\
```

**Full Path Example:**
```
C:\Users\Mady\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu-24.04_79rhkp1fndgsc\LocalState\
```

### Contents of Distro Location

```
LocalState/
├── rootfs/                  ← Complete Ubuntu filesystem
│   ├── bin/, boot/, dev/, etc/, home/, usr/, var/ (all directories above)
│   └── home/mady24/ (your files)
│
├── ext4.vhdx                ← Virtual hard disk (expandable, ~100-300 MB currently)
├── metadata.json            ← Distribution metadata
└── ...
```

### Accessing Distro Files from Windows

**From PowerShell:**
```powershell
# Navigate to distro location
cd "$env:USERPROFILE\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu-24.04_79rhkp1fndgsc\LocalState"

# List Ubuntu files
dir rootfs

# Access your Ubuntu files
dir rootfs\home\mady24
```

**From File Explorer:**
```
1. Open File Explorer
2. Navigate to: C:\Users\[YourUsername]\AppData\Local\Packages\
3. Look for: CanonicalGroupLimited.Ubuntu-24.04_*
4. Open: LocalState\rootfs\
5. Browse Ubuntu filesystem
```

---

## 📍 Your Home Directory Explained

### Linux Side: /home/mady24/

```
/home/mady24/
├── .bashrc              ← Bash shell configuration
├── .bash_history        ← Command history
├── .bash_logout         ← Logout script
├── .profile             ← Login script
├── .gitconfig           ← Git configuration (user, email)
├── .git-credentials     ← Git stored credentials
├── .ssh/                ← SSH keys and config
│   ├── id_rsa          ← Private key
│   ├── id_rsa.pub      ← Public key
│   ├── authorized_keys ← Remote access keys
│   └── config          ← SSH client config
│
├── .local/              ← User-specific data
│   ├── bin/             ← User scripts
│   ├── share/           ← User data
│   └── lib/             ← User libraries
│
├── .cache/              ← Temporary cache
├── .config/             ← Application configs
│
├── Documents/           → Symlink to /mnt/c/Users/Mady/Documents
├── Desktop/             → Symlink to /mnt/c/Users/Mady/Desktop
├── Downloads/           → Symlink to /mnt/c/Users/Mady/Downloads
├── Music/               → Symlink to /mnt/c/Users/Mady/Music
├── Pictures/            → Symlink to /mnt/c/Users/Mady/Pictures
│
└── projects/            ← Your development projects
    ├── devops/
    ├── docker/
    ├── kubernetes/
    └── ...
```

### Windows Side: C:\Users\Mady\

```
C:\Users\Mady\
├── Documents/
├── Desktop/
├── Downloads/
├── Pictures/
├── Music/
├── Videos/
├── AppData/
│   ├── Local/
│   │   └── Packages/
│   │       └── CanonicalGroupLimited.Ubuntu-24.04_*/
│   │           └── LocalState/rootfs/home/mady24/ ← Ubuntu home
│   ├── Roaming/
│   └── LocalLow/
├── .bashrc              ← If you create files in Ubuntu home
└── .gitconfig
```

---

## 🔄 File Path Conversion Quick Reference

| Task | Windows Path | WSL2 Path |
|------|--------------|-----------|
| **Navigate to Documents** | `C:\Users\Mady\Documents` | `/mnt/c/Users/Mady/Documents` |
| **Current user home** | `C:\Users\Mady` | `$HOME` or `/home/mady24` |
| **Program files** | `C:\Program Files` | `/mnt/c/Program Files` |
| **Windows system** | `C:\Windows` | `/mnt/c/Windows` |
| **Your projects** | `C:\Users\Mady\projects` | `/home/mady24/projects` |
| **Temp files** | `C:\Temp` | `/tmp` |
| **Docker data** | `C:\Program Files\Docker` | `/mnt/c/Program Files/Docker` |

---

## 💾 Where Different Things Live

### Git Repositories

**Recommended location:**
```bash
# Linux native (faster)
/home/mady24/projects/repo-name

# Or Windows Documents (shared with host)
/mnt/c/Users/Mady/Documents/repos
```

### Docker Containers & Images

```bash
# Linux native (required for performance)
/var/lib/docker/

# Don't put in /mnt/c/ (performance penalty!)
```

### Python Virtual Environments

```bash
# Recommended (Linux native for speed)
/home/mady24/venv/

# Or project-specific
/home/mady24/projects/myproject/venv/
```

### Configuration Files

```bash
# Bash config
/home/mady24/.bashrc

# Git config
/home/mady24/.gitconfig

# WSL2 config
/etc/wsl.conf

# Docker config
/etc/docker/daemon.json
```

---

## 📊 Directory Ownership & Permissions

### Your User Permissions

```bash
# Check your user info
id

# Output:
# uid=1000(mady24) gid=1000(mady24) groups=1000(mady24),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev)

# What this means:
# - UID 1000: Your user ID
# - GID 1000: Your primary group
# - sudo: You can run commands as root with 'sudo'
```

### File Permissions in /home

```bash
# Check your home directory permissions
ls -ld /home/mady24

# Output: drwxr-xr-x 15 mady24 mady24 4096 Dec 17 21:45 /home/mady24

# Breakdown:
# drwxr-xr-x = owner can read/write/execute, others can read/execute
# mady24 mady24 = owned by user mady24, group mady24
```

### Important: /etc/wsl.conf

This file controls WSL2 behavior:

```ini
[interop]
enabled=true
appendWindowsPath=true

[filesystem]
umask=0022

[interop.Windows]
interopEnabled=true
appendWindowsPath=true

[wsl2]
memory=4GB
processors=4
swap=2GB
localhostForwarding=true
```

---

## 🔍 Navigating Your Filesystem

### Common Navigation Commands

```bash
# Show current directory
pwd

# List contents
ls -la

# Change directory
cd /home/mady24
cd ~/projects      # ~ = home directory
cd /mnt/c/Users    # Access Windows directory

# Go back to previous directory
cd -

# Go to home directory
cd ~
cd

# Show disk usage
du -sh /home/mady24
df -h              # Overall disk usage
```

### Finding Things

```bash
# Find files named "gitconfig"
find /home/mady24 -name ".gitconfig"

# Find all Docker-related files
find / -name "*docker*" 2>/dev/null

# Search in current directory
find . -type f -name "*.py"

# Find large files
find / -type f -size +100M 2>/dev/null
```

---

## 🎯 Summary: File System Paths You'll Use Most

```bash
# Your home
cd ~
cd /home/mady24

# Your projects
cd ~/projects

# Windows Documents
cd /mnt/c/Users/Mady/Documents

# Git repositories
cd ~/projects/myrepo

# Docker configurations
sudo nano /etc/docker/daemon.json

# System logs
tail -f /var/log/docker.log

# Temporary files
cd /tmp
```

---

**[← Back to README](../README.md)** | **[Next: PACKAGES INSTALLED →](04-PACKAGES-INSTALLED.md)**
