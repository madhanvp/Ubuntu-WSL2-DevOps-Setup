# 05 - SYSTEM CONFIGURATION: Setup Your Environment

## ⚙️ Configuration Files You'll Use

Your WSL2 Ubuntu environment is configured through several key files. Let me show you what's configured and how to customize.

---

## 📄 File 1: ~/.bashrc (Bash Shell Configuration)

This file runs every time you open a terminal. It sets up your shell environment.

### Current .bashrc Features

```bash
# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# history control
HISTCONTROL=ignoredups:ignoreerasing
HISTSIZE=999999
HISTFILESIZE=999999

# append to history, don't overwrite
shopt -s histappend

# check window size after each command
shopt -s checkwinsize

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Prompt (customize your terminal look)
PS1='\u@\h:\w\$ '

# Useful aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
```

### How to Add Custom Aliases

```bash
# Edit your .bashrc
nano ~/.bashrc

# Add at the end:
# Custom DevOps Aliases
alias d='docker'
alias dc='docker-compose'
alias k='kubectl'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline -10'
alias cddev='cd ~/projects/devops'
alias clear-docker='docker container prune -f && docker image prune -f'

# Save and exit (Ctrl+O, Enter, Ctrl+X)

# Apply changes immediately
source ~/.bashrc
```

---

## 📄 File 2: ~/.gitconfig (Git Configuration)

This file stores your Git settings globally.

### Current .gitconfig

```ini
# ~/.gitconfig

[user]
    name = Mady
    email = mady@example.com

[core]
    editor = nano
    autocrlf = false

[init]
    defaultBranch = main

[color]
    ui = true

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    log1 = log --oneline -10
    graph = log --graph --oneline --all

[push]
    default = simple
```

### How to Update Git Config

```bash
# Set username
git config --global user.name "Mady"

# Set email
git config --global user.email "mady24@example.com"

# Set default editor
git config --global core.editor "nano"

# View all settings
git config --list

# Edit directly
nano ~/.gitconfig
```

### Setting Up SSH Keys for GitHub

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "mady24@example.com"

# Press Enter for default location (~/.ssh/id_ed25519)
# Enter secure passphrase when prompted

# Add key to SSH agent
ssh-add ~/.ssh/id_ed25519

# Display public key (copy this to GitHub)
cat ~/.ssh/id_ed25519.pub

# Test SSH connection
ssh -T git@github.com
```

---

## 📄 File 3: /etc/wsl.conf (WSL2 Linux Settings)

This file configures WSL2-specific behavior.

### Current wsl.conf

```ini
# /etc/wsl.conf

[boot]
systemd=true

[interop]
enabled=true
appendWindowsPath=true

[filesystem]
umask=0022
case=off

[interop.Windows]
interopEnabled=true
appendWindowsPath=true

[wsl2]
memory=4GB
processors=4
swap=2GB
localhostForwarding=true
```

### Edit wsl.conf

```bash
# View current settings
cat /etc/wsl.conf

# Edit with sudo (requires root)
sudo nano /etc/wsl.conf

# Changes require Ubuntu restart:
# In PowerShell: wsl --shutdown
# Then relaunch Ubuntu
```

### Important Settings Explained

| Setting | Purpose | Your Value |
|---------|---------|-----------|
| `systemd=true` | Enable systemd init | Recommended (true) |
| `enabled=true` | Enable WSL2 interop | true (Windows access) |
| `appendWindowsPath=true` | Use Windows PATH | true (access Windows apps) |
| `umask=0022` | Default file permissions | 0022 (owner read/write) |
| `memory=4GB` | Max RAM for WSL2 | Adjust based on your system |
| `processors=4` | CPU cores to use | (your processor count) |
| `swap=2GB` | Virtual memory | (half your max memory) |
| `localhostForwarding=true` | Access WSL services | true (for Docker/apps) |

---

## 📄 File 4: ~/.wslconfig (Windows-Side WSL Settings)

This file is on Windows side and controls resource allocation.

### Location
```
C:\Users\[YourUsername]\.wslconfig
```

### Recommended .wslconfig

```ini
# ~/.wslconfig (On Windows side)

[interop]
enabled=true
appendWindowsPath=true

[wsl2]
# Kernel options
memory=4GB
processors=4
swap=2GB
localhostForwarding=true

# Virtual hard disk size (if needed)
# vhdSize=100GB
```

### How to Edit (From Windows)

```powershell
# Open with Notepad
notepad $env:USERPROFILE\.wslconfig

# After editing, restart WSL:
wsl --shutdown

# Then reopen Ubuntu to apply changes
```

---

## 📄 File 5: /etc/docker/daemon.json (Docker Configuration)

Configure Docker's behavior and resource usage.

### Check Current Config

```bash
# View Docker config
sudo cat /etc/docker/daemon.json

# If file doesn't exist, create it
sudo nano /etc/docker/daemon.json
```

### Recommended Docker Config

```json
{
  "bip": "172.17.0.1/16",
  "bridge": "docker0",
  "debug": false,
  "dns": ["8.8.8.8", "8.8.4.4"],
  "insecure-registries": [],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2"
}
```

### Edit Docker Config

```bash
# Edit with sudo
sudo nano /etc/docker/daemon.json

# Restart Docker for changes to take effect
sudo systemctl restart docker

# Verify Docker is running
docker ps
```

---

## 🔧 How to Make Your Custom Configuration

### Create a Personal Setup Script

```bash
# Create setup script
nano ~/setup-devops.sh
```

**Content:**
```bash
#!/bin/bash

# DevOps Setup Script for WSL2 Ubuntu

echo "Setting up DevOps environment..."

# Update system
sudo apt update
sudo apt upgrade -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Kubernetes tools
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create projects directory
mkdir -p ~/projects/{devops,docker,kubernetes}

# Configure Git (update with your details)
git config --global user.name "Mady"
git config --global user.email "mady24@example.com"

# Add custom bashrc aliases
cat >> ~/.bashrc << 'EOF'

# Custom DevOps Aliases
alias d='docker'
alias dc='docker-compose'
alias k='kubectl'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline -10'
alias cddev='cd ~/projects/devops'
alias clear-docker='docker container prune -f && docker image prune -f'
EOF

echo "DevOps environment setup complete! ✅"
```

### Run Setup Script

```bash
# Make script executable
chmod +x ~/setup-devops.sh

# Run it
./setup-devops.sh
```

---

## 📊 Environment Variables

### Check Current Environment

```bash
# Show all environment variables
env

# Show specific variables
echo $HOME
echo $PATH
echo $USER
echo $SHELL

# Add permanent variable (add to .bashrc)
echo 'export DOCKER_BUILDKIT=1' >> ~/.bashrc
source ~/.bashrc
```

### Important DevOps Variables to Set

```bash
# Add to ~/.bashrc for DevOps development

# Docker BuildKit (faster builds)
export DOCKER_BUILDKIT=1

# Kubernetes context
export KUBECONFIG=~/.kube/config

# Terraform
export TF_INPUT=false

# Python development
export PYTHONUNBUFFERED=1
export PIP_NO_CACHE_DIR=1

# Apply changes
source ~/.bashrc
```

---

## 🔐 Securing Your Configuration

### File Permissions

```bash
# Check .bashrc permissions
ls -l ~/.bashrc

# Check .gitconfig
ls -l ~/.gitconfig

# Secure SSH keys (important!)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 644 ~/.ssh/authorized_keys

# Check permission status
ls -l ~/.ssh/
```

### Hide Sensitive Data

```bash
# Create .gitconfig_local for sensitive info
nano ~/.gitconfig_local

# Add sensitive credentials (NOT pushed to Git!)
[credential]
    helper = store

# Reference in main .gitconfig
[include]
    path = ~/.gitconfig_local

# Make sure .gitconfig_local is in .gitignore (local projects)
echo ".gitconfig_local" >> ~/.gitignore
```

---

## 🔄 Backing Up Your Configuration

### Export Your Configurations

```bash
# Backup bash configuration
cp ~/.bashrc ~/backup-bashrc-$(date +%Y%m%d).txt

# Backup git config
cp ~/.gitconfig ~/backup-gitconfig-$(date +%Y%m%d).txt

# Backup SSH keys (SECURE!)
tar czf ~/backup-ssh-keys.tar.gz ~/.ssh/

# List backups
ls -la ~/ | grep backup
```

### Version Control Your Configs

```bash
# Create a dotfiles repository
mkdir -p ~/projects/dotfiles
cd ~/projects/dotfiles

git init
git config user.name "Mady"
git config user.email "mady24@example.com"

# Add your configs
cp ~/.bashrc .
cp ~/.gitconfig .

git add .
git commit -m "Initial dotfiles backup"

# Later, clone and symlink on new machine
# ln -s ~/projects/dotfiles/.bashrc ~/.bashrc
```

---

## ✅ Verify Your Configuration

```bash
# Check Git config
git config --list | grep user

# Check Docker is accessible
docker --version
docker ps

# Check Python environment
python3 --version
which python3

# Check bash configuration loaded
echo $PS1

# Check aliases available
alias | grep git
```

---

## 🚀 Next Configuration Steps

Once you've got the basics, consider:

1. **Install Docker Compose**
   ```bash
   sudo apt install docker-compose-plugin
   ```

2. **Install Kubernetes tools**
   ```bash
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   ```

3. **Setup GitHub SSH access**
   - Generate SSH key (shown above)
   - Add public key to GitHub

4. **Create Python virtual environment**
   ```bash
   python3 -m venv ~/venv
   source ~/venv/bin/activate
   ```

---
