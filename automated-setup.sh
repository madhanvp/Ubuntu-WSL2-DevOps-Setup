#!/bin/bash

# Ubuntu-WSL2-DevOps-Setup Automated Installer
# This script automates the setup process

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Start
clear
echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════╗"
echo "║  Ubuntu-WSL2-DevOps-Setup Automated Install  ║"
echo "║          Setting up your environment         ║"
echo "╚═══════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running in WSL2
print_header "Checking System Requirements"

if ! grep -qi microsoft /proc/version; then
    print_error "Not running in WSL2 Ubuntu"
    print_warning "This script is designed for WSL2 Ubuntu 24.04.3 LTS"
    exit 1
fi

print_success "WSL2 Ubuntu environment detected"

# Check if running as user (not root)
if [ "$EUID" -eq 0 ]; then
   print_error "Don't run this script as root. Run as regular user."
   exit 1
fi

print_success "Running as user: $(whoami)"

# Update system
print_header "Updating System Packages"

sudo apt update
sudo apt upgrade -y -qq
print_success "System packages updated"

# Install essential tools
print_header "Installing Essential Tools"

ESSENTIAL_PACKAGES=(
    "build-essential"
    "curl"
    "wget"
    "git"
    "nano"
    "vim"
    "htop"
    "net-tools"
    "openssh-client"
    "ca-certificates"
)

for package in "${ESSENTIAL_PACKAGES[@]}"; do
    if dpkg -l | grep -q "^ii  $package"; then
        print_success "$package already installed"
    else
        print_warning "Installing $package..."
        sudo apt install -y -qq "$package"
        print_success "$package installed"
    fi
done

# Create development directories
print_header "Creating Development Directories"

mkdir -p ~/projects/{devops,docker,kubernetes}
mkdir -p ~/backups

print_success "Development directories created:"
print_success "  ~/projects/devops"
print_success "  ~/projects/docker"
print_success "  ~/projects/kubernetes"
print_success "  ~/backups"

# Configure Git (prompt for input)
print_header "Configuring Git"

read -p "Enter your name (for Git config): " git_name
read -p "Enter your email (for Git config): " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "nano"
git config --global init.defaultBranch "main"

print_success "Git configured:"
git config --list | grep user
git config --list | grep core.editor

# Backup existing bashrc
print_header "Backing Up Configuration Files"

if [ -f ~/.bashrc ]; then
    cp ~/.bashrc ~/backups/bashrc.backup.$(date +%Y%m%d-%H%M%S)
    print_success "Existing .bashrc backed up"
fi

if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig ~/backups/gitconfig.backup.$(date +%Y%m%d-%H%M%S)
    print_success "Existing .gitconfig backed up"
fi

# Add DevOps aliases to bashrc
print_header "Adding Custom Aliases"

cat >> ~/.bashrc << 'EOF'

# ============================================
# Custom DevOps Aliases
# ============================================
alias d='docker'
alias dc='docker-compose'
alias k='kubectl'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'

# Directory navigation
alias cddev='cd ~/projects/devops'
alias cddk='cd ~/projects/docker'
alias cdk8s='cd ~/projects/kubernetes'
alias cdproj='cd ~/projects'

# System utilities
alias ll='ls -lah'
alias la='ls -A'
alias cls='clear'
alias apt-update='sudo apt update && sudo apt upgrade -y'

# Docker utilities
alias docker-clean='docker container prune -f && docker image prune -f'
alias docker-logs='docker logs -f'
alias docker-ps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'

# ============================================
# DevOps Environment Variables
# ============================================
export DOCKER_BUILDKIT=1
export PYTHONUNBUFFERED=1
export PIP_NO_CACHE_DIR=1

# ============================================
# END Custom Configuration
# ============================================
EOF

print_success "Custom aliases added to ~/.bashrc"

# Reload bashrc
source ~/.bashrc
print_success ".bashrc reloaded"

# Verify key tools
print_header "Verifying Installation"

echo "Docker version:"
docker --version

echo -e "\nGit version:"
git --version

echo -e "\nPython version:"
python3 --version

echo -e "\nTotal packages installed:"
apt list --installed 2>/dev/null | wc -l

# Summary
print_header "Installation Complete!"

echo -e "${GREEN}✓ System updated"
echo "✓ Essential tools installed"
echo "✓ Development directories created"
echo "✓ Git configured"
echo "✓ Custom aliases added"
echo "✓ DevOps environment ready${NC}"

echo -e "\n${BLUE}Next Steps:${NC}"
echo "1. Run 'source ~/.bashrc' to load aliases (or open new terminal)"
echo "2. Verify setup: bash scripts/verify-setup.sh"
echo "3. Read: docs/02-INSTALLATION-GUIDE.md"
echo "4. Start learning: docs/08-NEXT-STEPS.md"

echo -e "\n${YELLOW}Helpful commands:${NC}"
echo "  cd ~/projects        - Go to projects directory"
echo "  docker ps           - List running containers"
echo "  git status          - Check git status"
echo "  python3 -m venv env - Create virtual environment"

echo -e "\n${GREEN}Happy DevOps Learning! 🚀${NC}\n"
