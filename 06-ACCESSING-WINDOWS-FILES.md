# 06 - ACCESSING WINDOWS FILES: Integration Guide

## 🪟 Using Windows Files from WSL2

One of the best features of WSL2 is seamless integration with Windows. You can access, edit, and modify Windows files directly from Ubuntu.

---

## 🔗 The /mnt/ Bridge

### Understanding /mnt/

The `/mnt/` directory in WSL2 gives you access to all your Windows drives:

```bash
# Check what's mounted
mount | grep /mnt

# List available drives
ls -la /mnt/

# Output:
# total 8
# dr-xr-xr-x  4 root root 4096 Dec 17 21:45 .
# dr-xr-xr-x 21 root root 4096 Dec 17 21:45 ..
# drwxrwxrwx  1 root root 4096 Dec 17 21:45 c
# drwxrwxrwx  1 root root 53   Dec 17 21:45 d (if you have D: drive)
# drwxrwxrwx  1 root root 53   Dec 17 21:45 wsl
```

---

## 📂 Path Mapping: Windows ↔ WSL2

### Quick Reference

| Windows Path | WSL2 Path |
|--------------|-----------|
| `C:\` | `/mnt/c/` |
| `C:\Users` | `/mnt/c/Users` |
| `C:\Users\Mady` | `/mnt/c/Users/Mady` |
| `C:\Users\Mady\Documents` | `/mnt/c/Users/Mady/Documents` |
| `C:\Users\Mady\Desktop` | `/mnt/c/Users/Mady/Desktop` |
| `C:\Users\Mady\Downloads` | `/mnt/c/Users/Mady/Downloads` |
| `C:\Program Files` | `/mnt/c/Program Files` |
| `C:\Windows` | `/mnt/c/Windows` |
| `D:\` (if exists) | `/mnt/d/` |

### Accessing Windows Paths

```bash
# Navigate to Windows Documents
cd /mnt/c/Users/Mady/Documents

# List contents
ls -la

# Check current directory
pwd
# Output: /mnt/c/Users/Mady/Documents

# Go back to Ubuntu home
cd ~
pwd
# Output: /home/mady24
```

---

## 📝 Editing Windows Files from Ubuntu

### Edit Files with Nano

```bash
# Open a Windows file in nano editor
nano /mnt/c/Users/Mady/Documents/my-notes.txt

# Create new file in Windows Documents
nano /mnt/c/Users/Mady/Documents/setup-notes.md
```

### Edit Files with Vim

```bash
# If vim is installed
vim /mnt/c/Users/Mady/Documents/script.sh

# If not installed, install it:
sudo apt install vim

# Then use it
vim /mnt/c/Users/Mady/Documents/example.txt
```

### Create Files in Windows Locations

```bash
# Create a new file in Windows Documents
cat > /mnt/c/Users/Mady/Documents/hello.txt << EOF
Hello from Ubuntu!
Created from WSL2 terminal
EOF

# Create a script
cat > /mnt/c/Users/Mady/Documents/test.sh << 'EOF'
#!/bin/bash
echo "This script was created from WSL2"
date
EOF

# Make it executable
chmod +x /mnt/c/Users/Mady/Documents/test.sh
```

---

## 📋 Working with Git Repositories

### Clone Repository to Windows

```bash
# Navigate to Documents
cd /mnt/c/Users/Mady/Documents

# Clone a repository
git clone https://github.com/your-username/your-repo.git

# Navigate into it
cd your-repo

# Work normally
git status
git add .
git commit -m "Working from WSL2"
git push
```

### Clone Repository to Ubuntu Home

```bash
# Recommended: clone to Ubuntu home (faster)
cd ~/projects
git clone https://github.com/your-username/your-repo.git

# Or to Documents (for sharing with Windows)
cd /mnt/c/Users/Mady/Documents
git clone https://github.com/your-username/your-repo.git
```

### Performance Considerations

```
⚡ FASTER: Keep repos in /home/mady24/
           (native ext4 filesystem)

🐌 SLOWER: Keep repos in /mnt/c/...
          (Windows NTFS filesystem)

Recommendation:
- Development repos → /home/mady24/projects/
- Shared files → /mnt/c/Users/Mady/Documents/
```

---

## 🐳 Docker Images & Containers

### Access Docker Files from Windows

```bash
# Docker stores data in ext4 (Linux native)
# This is why Docker performance in WSL2 is excellent!

# Check Docker disk usage
docker system df

# Docker data location (not accessible from Windows directly)
# But you can export containers:
docker export container-id > /mnt/c/Users/Mady/Downloads/backup.tar
```

---

## 🔄 Clipboard Integration

### Copy From Ubuntu to Windows

```bash
# Copy directory path to clipboard
echo /mnt/c/Users/Mady/Documents | xclip -selection clipboard

# Or use Windows clipboard directly
cat /mnt/c/Users/Mady/Documents/file.txt | clip.exe
```

### Paste From Windows to Ubuntu

```bash
# Windows PowerShell → WSL2 paste
# Just use Shift+Insert or right-click paste in WSL2 terminal
```

---

## 💾 Copying Files Between Systems

### Copy from Windows to Linux

```bash
# Copy single file
cp /mnt/c/Users/Mady/Documents/file.txt ~/projects/

# Copy entire directory
cp -r /mnt/c/Users/Mady/Documents/my-project ~/projects/

# Using rsync (for large files)
rsync -av /mnt/c/Users/Mady/Documents/large-folder ~/backup/
```

### Copy from Linux to Windows

```bash
# Copy single file
cp ~/projects/script.sh /mnt/c/Users/Mady/Documents/

# Copy directory
cp -r ~/projects/my-app /mnt/c/Users/Mady/Documents/

# Using tar (for large amounts)
tar czf - ~/projects | cat > /mnt/c/Users/Mady/backup.tar.gz
```

---

## 🔍 Finding Files

### Search in Windows Locations

```bash
# Find all Python files in Documents
find /mnt/c/Users/Mady/Documents -name "*.py"

# Find all modified in last 24 hours
find /mnt/c/Users/Mady/Documents -type f -mtime -1

# Search for text in files
grep -r "TODO" /mnt/c/Users/Mady/Documents

# Find large files
find /mnt/c/Users/Mady/Documents -type f -size +100M
```

---

## 🎯 Real-World Scenarios

### Scenario 1: Edit Windows Config File

```bash
# You have a config file on Windows Desktop
cd /mnt/c/Users/Mady/Desktop

# Open it in your favorite editor
nano config.yml

# Or view it
cat config.yml

# Modify it
echo "new-setting: value" >> config.yml

# File is automatically saved to Windows Desktop
```

### Scenario 2: Create Scripts in Windows, Run in Ubuntu

```bash
# Create script in Windows Documents
cat > /mnt/c/Users/Mady/Documents/deploy.sh << 'EOF'
#!/bin/bash
echo "Deploying application..."
docker build -t myapp:latest .
docker run -d -p 8000:8000 myapp:latest
echo "Deployment complete!"
EOF

# Make executable
chmod +x /mnt/c/Users/Mady/Documents/deploy.sh

# Run it from anywhere
/mnt/c/Users/Mady/Documents/deploy.sh

# Or run from Linux
~/projects/deploy.sh
```

### Scenario 3: Backup Ubuntu Data to Windows

```bash
# Backup important files to Windows
cp ~/.bashrc /mnt/c/Users/Mady/Documents/backups/
cp ~/.gitconfig /mnt/c/Users/Mady/Documents/backups/
cp ~/.ssh/id_rsa.pub /mnt/c/Users/Mady/Documents/backups/

# Or entire directory
tar czf /mnt/c/Users/Mady/Documents/ubuntu-backup-$(date +%Y%m%d).tar.gz ~/projects
```

---

## ⚠️ Important Considerations

### File Permissions

```bash
# Windows NTFS has different permission model
# All files appear as 777 (full permissions)
# Linux permission checks are less strict here

# Don't rely on permissions for security in /mnt/c/
# Sensitive files should be in /home/mady24/

# For SSH keys
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
# Store in /home/mady24/.ssh/ (not /mnt/c/)
```

### Line Endings

```bash
# Windows uses CRLF (\r\n)
# Linux uses LF (\n)

# Git can auto-convert:
git config --global core.autocrlf input

# Or handle manually:
dos2unix file.txt    # Convert CRLF → LF
unix2dos file.txt    # Convert LF → CRLF
```

### Antivirus Warnings

```bash
# If Windows antivirus slows /mnt/c/:
# 1. Add WSL exclusion to Windows Defender
# 2. Keep projects in /home/mady24/ for speed
# 3. Use /mnt/c/ only for essential shared files
```

---

## 🚀 Using VS Code

### Edit WSL2 Files with VS Code

```bash
# VS Code Remote extension (install from VS Code)
# Then open WSL2 folder directly

# From Ubuntu terminal:
code .              # Opens current dir in VS Code
code ~/projects     # Opens projects folder
code /mnt/c/Users/Mady/Documents  # Opens Windows folder

# VS Code will automatically use WSL2 as remote
```

### Recommended Extensions

- Remote - WSL
- Docker
- Python
- GitLens
- GitHub Copilot

---

## 📊 Performance Tips

### For Best Performance

```
1. Clone repos to /home/mady24/ (not /mnt/c/)
2. Run Docker operations in Ubuntu home
3. Keep build artifacts in Ubuntu home
4. Use /mnt/c/ only for:
   - Sharing files with Windows
   - Working with Windows tools
   - Long-term storage
```

### Monitor Performance

```bash
# Check filesystem speed
time dd if=/dev/zero of=/tmp/test bs=1M count=1024

# Compare with Windows files:
time dd if=/dev/zero of=/mnt/c/Users/Mady/test bs=1M count=1024

# ext4 (Ubuntu home) should be faster
```

---

## ✅ Quick Commands Reference

```bash
# Navigate to Windows Documents
cd /mnt/c/Users/Mady/Documents

# Edit Windows file
nano /mnt/c/Users/Mady/Documents/config.txt

# Create file in Windows location
echo "content" > /mnt/c/Users/Mady/Documents/file.txt

# Copy to Windows
cp ~/myfile.txt /mnt/c/Users/Mady/Documents/

# Copy from Windows
cp /mnt/c/Users/Mady/Documents/file.txt ~/

# Find files in Windows
find /mnt/c/Users/Mady -name "*.pdf" -type f

# Open Ubuntu folder in VS Code
code ~/projects

# Open Windows folder in VS Code
code /mnt/c/Users/Mady/Documents
```

---
