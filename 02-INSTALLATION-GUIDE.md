# 02 - INSTALLATION GUIDE: Your Complete Setup Journey

## 📖 Your Step-by-Step Setup

Welcome! This is YOUR personal installation journey documented here. Follow these exact steps to replicate your setup.

---

## 🎯 Installation Overview

| Step | Task | Time | Status |
|------|------|------|--------|
| 1 | Enable WSL2 on Windows 11 | 5 min | ✅ |
| 2 | Install Ubuntu 24.04.3 from Store | 15 min | ✅ |
| 3 | Initial Ubuntu Setup | 10 min | ✅ |
| 4 | System Updates | 10 min | ✅ |
| 5 | Verification | 5 min | ✅ |
| **Total** | | **45-60 min** | **✅ COMPLETE** |

---

## 📝 STEP 1: Enable WSL2 on Windows 11

### Method 1: Quick Install (Recommended)

**Open PowerShell as Administrator:**

1. Right-click Start Menu → "Windows Terminal (Admin)"
2. Or: Press `Win + X` → Select "Terminal (Admin)"
3. Paste this command:

```powershell
wsl --install
```

**What this does:**
- ✅ Enables Windows Subsystem for Linux feature
- ✅ Enables Virtual Machine Platform
- ✅ Downloads latest WSL2 kernel
- ✅ Sets WSL2 as default version

**Expected Output:**
```
Installing, this may take a few minutes...
WSL is already installed. Updating WSL.
Checking for the latest components...
Installing the WSL2 kernel.
Installation complete!
Please restart your computer to finish installing the required components for WSL.
```

### After `wsl --install`

**Restart your Windows 11 computer**

```powershell
# Or use:
Restart-Computer
```

---

## 📝 STEP 2: Install Ubuntu 24.04.3 LTS from Microsoft Store

### Using Microsoft Store (Easiest)

**After your computer restarts:**

1. **Open Microsoft Store**
   - Click Start Menu
   - Type "Microsoft Store"
   - Open it

2. **Search for Ubuntu**
   - In search box, type: `Ubuntu 24.04 LTS`
   - Look for official Canonical logo

3. **Install Ubuntu 24.04.3 LTS**
   - Click the Ubuntu 24.04.3 LTS listing
   - Click "Get" or "Install" button
   - Wait for download to complete (~300-400 MB)
   - Installation will start automatically

**Download Progress:**
```
Downloading Ubuntu 24.04.3 LTS...
[████████░░░░░░░░░░░] 50%
[██████████████░░░░░] 80%
[████████████████████] 100% ✓ Download complete
Installing...
[████████████████████] 100% ✓ Installation complete
```

### Alternative: Command Line Install

If Microsoft Store doesn't work:

```powershell
# Download from Microsoft directly
Invoke-WebRequest -Uri "https://aka.ms/wslubuntu2404" -OutFile "Ubuntu-24.04.lts.AppxBundle"

# Install the bundle
Add-AppxPackage .\Ubuntu-24.04.lts.AppxBundle
```

---

## 📝 STEP 3: Launch Ubuntu & Initial Setup

### First Launch

**From Microsoft Store or Start Menu:**

1. Search for "Ubuntu 24.04.3 LTS" in Start Menu
2. Click to launch
3. Ubuntu terminal will open

**First-Time Setup Dialog:**
```
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
For more information visit: https://aka.ms/wslusers

Enter new UNIX username: mady24
New password: **
Retype new password: **
passwd: password updated successfully
Installation successful!
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mady24@Mady24:~$
```

### What You Entered:

- **Username:** `mady24`
- **Password:** Your secure password (won't show while typing - normal!)

**Congratulations!** Ubuntu 24.04.3 is running! 🎉

---

## 📝 STEP 4: System Updates (Critical!)

### Update Package Lists

In your Ubuntu terminal, run:

```bash
sudo apt update
```

**Output:**
```
Get:1 http://archive.ubuntu.com/ubuntu noble InRelease [256 kB]
Get:2 http://archive.ubuntu.com/ubuntu noble-updates InRelease [126 kB]
...
Reading package lists... Done
```

### Upgrade All Packages

```bash
sudo apt upgrade -y
```

**Output (from your current system):**
```
Reading package lists... Done
Building dependency tree... Done
The following packages will be upgraded:
  ca-certificates curl git git-man libc6 libc6-dev libc-bin libcurl4
  ...
45 upgraded, 0 newly installed, 0 removed
Processing triggers for ca-certificates (20240311) ...
Updating certificates in /etc/ssl/certs...
Updating certificates in /etc/ssl/certs...
done.
```

**This updated 45 packages! ✅**

### Verify System Information

```bash
lsb_release -a
```

**Your Output:**
```
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.3 LTS
Release:        24.04
Codename:       noble
```

---

## 📝 STEP 5: Verify Your Setup

### Check WSL2 Distro Status

```powershell
# Run in PowerShell (on Windows):
wsl --list --verbose
```

**Expected output:**
```
  NAME                   STATE           VERSION
* Ubuntu-24.04           Running         2
```

### Check Key Components

In Ubuntu terminal:

```bash
# Check kernel
uname -a
```

**Your output:**
```
Linux Mady24 6.6.87.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Thu Jun  5 18:30:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

```bash
# Check git
git --version
```

**Your output:**
```
git version 2.43.0
```

```bash
# Check docker
docker --version
```

**Your output:**
```
Docker version 28.2.2-ubuntu1~24.04.1, build 1100f89
```

```bash
# Check python
python3 --version
```

**Your output:**
```
Python 3.12.3
```

```bash
# Count total packages
apt list --installed | wc -l
```

**Your output:**
```
613
```

---

## ✅ Configuration Setup

### Initialize Git (Important!)

```bash
git config --global user.name "Mady"
git config --global user.email "mady@example.com"
git config --global core.editor "nano"

# Verify config
git config --list | grep user
```

### Create Development Directory

```bash
# Create projects directory
mkdir -p ~/projects/devops
mkdir -p ~/projects/docker
mkdir -p ~/projects/kubernetes

# Navigate there
cd ~/projects
ls -la
```

**Output:**
```
total 12
drwxr-xr-x 3 mady24 mady24 4096 Dec 17 21:45 .
drwxrwxr-x 8 mady24 mady24 4096 Dec 17 21:45 ..
drwxr-xr-x 2 mady24 mady24 4096 Dec 17 21:45 devops
drwxr-xr-x 2 mady24 mady24 4096 Dec 17 21:45 docker
drwxr-xr-x 2 mady24 mady24 4096 Dec 17 21:45 kubernetes
```

### Check File System Access

```bash
# Access Windows C: drive from Ubuntu
cd /mnt/c/Users/Mady
ls -la

# Create a test file
echo "Hello from WSL2" > /mnt/c/Users/Mady/wsl-test.txt

# Verify Windows can see it
# Open File Explorer → C:\Users\Mady\wsl-test.txt
```

---

## 🎯 Post-Installation Checklist

- [ ] WSL2 enabled on Windows 11
- [ ] Ubuntu 24.04.3 LTS installed
- [ ] Terminal launched successfully
- [ ] Username created: `mady24`
- [ ] System updated (45 packages)
- [ ] Git configured globally
- [ ] Docker verified working
- [ ] Python 3.12 verified
- [ ] Development directories created
- [ ] Windows file access tested

---

## 📊 Your Current System State

**Captured at installation completion:**

```
System Information:
├── OS: Ubuntu 24.04.3 LTS
├── Kernel: 6.6.87.2-microsoft-standard-WSL2
├── Architecture: x86_64
├── Hostname: Mady24
├── User: mady24
│
Installed Tools:
├── Git: 1:2.43.0-ubuntu7.3
├── Docker: 28.2.2-ubuntu1~24.04.1
├── Python: 3.12.3
├── Build Tools: gcc, g++, make
└── 613 Total Packages
│
Hardware (HP Victus 15):
├── Host OS: Windows 11
├── Virtualization: Hyper-V (WSL2)
├── Kernel: Microsoft Standard
└── Status: ✅ Operational
```

---

## 🔧 Troubleshooting Installation

### Issue: "WSL 2 is not installed"

```powershell
# Check WSL status
wsl --status

# If version shows 1, upgrade:
wsl --set-default-version 2

# Restart Ubuntu:
wsl -t Ubuntu-24.04
```

### Issue: "Permission denied" in Ubuntu

```bash
# Check current user:
whoami

# Should output: mady24

# If permission issues persist:
sudo apt fix-broken-install
sudo apt autoremove
```

### Issue: "Docker won't start"

```bash
# Start docker daemon
sudo service docker start

# Check status
sudo service docker status

# Or:
docker ps
```

### Issue: "Can't access Windows files"

```bash
# Verify mount
mount | grep /mnt/c

# Should show: C: mounted at /mnt/c

# If not, restart WSL:
wsl --shutdown  # On Windows PowerShell
```

---

## 🚀 Installation Complete!

**Your Ubuntu-WSL2 setup is ready for DevOps! 🎉**

### Next Actions:

1. **Explore your setup:**
   ```bash
   tree / -L 2
   apt list --installed
   ```

2. **Continue learning:**
   - [Next: FILESYSTEM STRUCTURE](03-FILESYSTEM-STRUCTURE.md) - Understand Linux directories
   - [System CONFIGURATION](05-SYSTEM-CONFIGURATION.md) - Configure your environment

3. **Start with DevOps:**
   - [Next Steps](08-NEXT-STEPS.md) - DevOps learning roadmap

---

**⏱️ Installation Time:** 45-60 minutes  
**✅ Status:** Complete  
**🎯 Next:** Understand your filesystem structure

**[← Back to README](../README.md)** | **[Next: FILESYSTEM STRUCTURE →](03-FILESYSTEM-STRUCTURE.md)**
