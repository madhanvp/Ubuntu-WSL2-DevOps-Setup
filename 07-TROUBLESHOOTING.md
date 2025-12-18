# 07 - TROUBLESHOOTING: Common Issues & Solutions

## 🚨 Problem-Solving Guide

Encountered an issue with your WSL2 setup? Find your problem here and solve it quickly!

---

## 🔄 WSL2 Won't Start

### Problem: WSL2 Ubuntu doesn't launch

**Symptoms:**
- Clicking Ubuntu in Start Menu does nothing
- PowerShell shows error: "WSL2 distro not found"
- Black screen, then closes

**Solutions:**

```powershell
# Check WSL2 status
wsl --status

# List installed distros
wsl --list --verbose

# Try to launch explicitly
wsl -d Ubuntu-24.04

# If that fails, reinitialize the distro
wsl --set-default-version 2
wsl --install -d Ubuntu-24.04
```

**If completely broken:**
```powershell
# Shutdown all WSL instances
wsl --shutdown

# Then restart Ubuntu from Start Menu
```

---

## 🔐 Permission Denied Errors

### Problem: "Permission denied" when running commands

**Example:**
```bash
sudo apt update
# Permission denied
```

**Solutions:**

```bash
# Check if sudo works
sudo whoami
# Should output: root

# If sudo is broken, reset it
sudo apt install --reinstall sudo

# Check user is in sudoers group
groups $USER

# If not, add yourself:
sudo usermod -aG sudo mady24

# Apply changes (restart terminal)
```

### Permission Denied on Files

```bash
# Check file permissions
ls -la /etc/docker/daemon.json

# Fix ownership
sudo chown $USER:$USER /etc/docker/daemon.json

# Fix permissions for script
chmod +x script.sh
chmod +x /home/mady24/setup.sh
```

---

## 🐳 Docker Not Working

### Problem: "Docker daemon is not running"

**Symptoms:**
```bash
docker ps
# Error response from daemon: cannot connect to Docker daemon
```

**Solutions:**

```bash
# Start Docker daemon
sudo service docker start

# Check Docker status
sudo service docker status

# Enable auto-start (recommended)
sudo systemctl enable docker

# Verify Docker works
docker run hello-world
```

### Docker Command Requires Sudo

```bash
# Add current user to docker group
sudo usermod -aG docker $USER

# Apply group membership (without logout)
newgrp docker

# Verify
docker ps
# Should work without sudo now
```

### Docker Disk Space Issues

```bash
# Check Docker disk usage
docker system df

# Clean up images
docker image prune -a

# Clean up containers
docker container prune

# Clean up volumes
docker volume prune

# Remove everything
docker system prune -a
```

---

## 📦 Package/APT Issues

### Problem: "Unable to locate package"

**Error:**
```bash
sudo apt install package-name
# Unable to locate package package-name
```

**Solutions:**

```bash
# Update package lists first
sudo apt update

# Try again
sudo apt install package-name

# If still fails, check spelling
apt search keyword

# Use full name
apt search docker | grep docker.io
```

### Broken Package Dependencies

**Error:**
```bash
# apt returns dependency errors
```

**Solutions:**

```bash
# Fix broken packages
sudo apt --fix-broken install

# Or
sudo apt install -f

# Check for held packages
apt-mark showhold

# Unhold if needed
sudo apt-mark unhold package-name
```

### Package Lock File Issues

```bash
# If apt is locked
# E: Could not acquire lock for /var/cache/apt/archives/lock

# Check what's running
ps aux | grep apt

# Wait for background updates to finish
sudo lsof /var/lib/apt/lists/lock

# Force release (if safe)
sudo rm /var/lib/apt/lists/lock
sudo apt update
```

---

## 🐍 Python Issues

### Python Package Install Fails

```bash
# Install pip first
sudo apt install python3-pip

# Try pip install
pip install package-name

# Or use system pip
python3 -m pip install package-name

# Use --user flag to avoid sudo
pip install --user package-name
```

### Virtual Environment Issues

```bash
# Create virtual environment
python3 -m venv ~/venv

# Activate it
source ~/venv/bin/activate

# If activation fails, recreate
rm -rf ~/venv
python3 -m venv ~/venv
source ~/venv/bin/activate

# Deactivate
deactivate
```

---

## 🌐 Network/Internet Issues

### Can't Access Internet

```bash
# Check DNS
cat /etc/resolv.conf

# Try ping
ping 8.8.8.8

# Check network interface
ip addr

# Restart network (if needed)
sudo systemctl restart networking
```

### Can't Reach Windows Services

**Trying to access Windows app running on localhost:**

```bash
# WSL2 localhost IS Windows localhost
# This should work:
curl localhost:8000

# If not, the service might not be listening on 0.0.0.0
# Or the port is blocked

# Check Windows Firewall
# Settings → Firewall & Network Protection
# Check if your port is allowed
```

---

## 📁 File System Issues

### Can't Access Windows Files

**Error:**
```bash
cd /mnt/c/Users/Mady
# No such file or directory
```

**Solutions:**

```bash
# Check if mount exists
mount | grep /mnt/c

# Remount if necessary
sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=22,fmask=11

# Or restart WSL2
wsl --shutdown

# Then reopen Ubuntu
```

### Disk Space Running Out

```bash
# Check disk usage
df -h

# See what's using space
du -sh ~/*

# Check Docker images
du -sh /var/lib/docker

# Clean up
docker system prune -a
sudo apt clean
sudo apt autoremove
```

### File Permissions Mismatch

```bash
# Check file permissions
ls -l file.txt

# Fix ownership
sudo chown $USER:$USER file.txt

# Fix permissions
chmod 644 file.txt      # for regular files
chmod 755 directory/    # for directories
chmod +x script.sh      # for executable

# Recursive fix
chmod -R 755 ~/projects
```

---

## 🔑 SSH/Git Issues

### SSH Key Problems

```bash
# Check if keys exist
ls -la ~/.ssh/

# Generate new key if missing
ssh-keygen -t ed25519 -C "mady24@example.com"

# Check permissions (must be 600)
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Add key to agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Test GitHub connection
ssh -T git@github.com
```

### Git Clone Fails

```bash
# Try with SSH instead of HTTPS
git clone git@github.com:username/repo.git

# Or configure credentials
git config --global credential.helper store

# Then clone with HTTPS
git clone https://github.com/username/repo.git
# Enter credentials when prompted
```

### Git Configuration Issues

```bash
# Check current config
git config --list

# Reset to defaults
git config --global --unset-all user.name
git config --global --unset-all user.email

# Set correct values
git config --global user.name "Mady"
git config --global user.email "mady24@example.com"
```

---

## 💾 WSL2 Performance Issues

### Slow Performance

```bash
# Check if running from /mnt/c/ (Windows NTFS)
# ext4 in Ubuntu home is much faster

# Move projects to Ubuntu home:
mv /mnt/c/Users/Mady/Documents/project ~/projects/

# Clone repos to Ubuntu home
cd ~/projects
git clone https://github.com/user/repo.git
```

### High CPU Usage

```bash
# Check what's running
top

# Check WSL memory usage
free -h

# Check if virus scanner is running on /mnt/c/
# Add WSL exclusion to Windows Defender if needed
```

---

## 🔄 Update & Upgrade Issues

### Update Fails

```bash
# Try again
sudo apt update

# If it fails due to locked file, wait or
sudo killall apt apt-get

# Then retry
sudo apt update
sudo apt upgrade -y
```

### Stuck During Upgrade

```bash
# Check what's stuck
ps aux | grep apt

# Kill it (careful!)
sudo kill -9 process-id

# Fix issues
sudo apt install -f

# Continue upgrade
sudo apt upgrade -y
```

---

## 🚨 System Won't Boot

### Ubuntu Distro Corrupted

```powershell
# From Windows PowerShell:

# List distros
wsl --list --verbose

# Backup distro (if possible)
wsl --export Ubuntu-24.04 ubuntu-backup.tar

# Unregister (remove) distro
wsl --unregister Ubuntu-24.04

# Reinstall
wsl --install -d Ubuntu-24.04
```

---

## ✅ Quick Diagnostic Commands

Run these to diagnose issues:

```bash
# System info
wsl --status
uname -a
lsb_release -a

# Disk space
df -h
du -sh ~/

# Running processes
ps aux | head -20

# Docker status
docker ps
docker system df

# Network
ping 8.8.8.8
curl https://google.com

# Mounts
mount | grep /mnt

# Users
id
groups

# Available packages
apt update && apt list --upgradable
```

---

## 🆘 Still Having Issues?

### Get More Help

```bash
# Check system logs
dmesg

# Check Docker logs
docker logs container-id

# Check WSL logs
# C:\Users\[YourName]\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_*/LocalState/
# Look for: DistroFS.log, docker.log

# Test connectivity
wsl --exec curl https://github.com

# Check WSL version
wsl --version
wsl --status --verbose
```

### Reinstall from Scratch

If all else fails:

```powershell
# From PowerShell (Admin):

# Shutdown WSL
wsl --shutdown

# Unregister Ubuntu
wsl --unregister Ubuntu-24.04

# Reinstall
wsl --install -d Ubuntu-24.04
```

---

## 📝 Prevention Tips

```bash
# Regular maintenance
sudo apt update
sudo apt upgrade -y
sudo apt autoremove

# Keep backups
cp ~/.bashrc ~/backup/.bashrc.$(date +%Y%m%d)
cp ~/.gitconfig ~/backup/.gitconfig.$(date +%Y%m%d)

# Monitor resources
df -h       # Disk usage
free -h     # Memory usage
ps aux      # Running processes

# Keep logs
dmesg > ~/system-log.txt
docker ps -a > ~/docker-containers.txt
```

---

