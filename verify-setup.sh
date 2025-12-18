#!/bin/bash

# Ubuntu-WSL2-DevOps-Setup Verification Script.
# Checks that everything is installed and working correctly.

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
PASSED=0
FAILED=0
WARNINGS=0

check_command() {
    local name=$1
    local command=$2
    
    if command -v $command &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $name (not found)"
        ((FAILED++))
    fi
}

check_service() {
    local name=$1
    local service=$2
    
    if sudo systemctl is-active --quiet $service; then
        echo -e "${GREEN}✓${NC} $name (running)"
        ((PASSED++))
    elif sudo systemctl is-enabled --quiet $service 2>/dev/null; then
        echo -e "${YELLOW}⚠${NC} $name (installed but not running)"
        ((WARNINGS++))
    else
        echo -e "${RED}✗${NC} $name (not installed)"
        ((FAILED++))
    fi
}

check_file() {
    local name=$1
    local file=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $name (not found)"
        ((FAILED++))
    fi
}

check_directory() {
    local name=$1
    local dir=$2
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} $name (doesn't exist)"
        ((WARNINGS++))
    fi
}

# Start
clear
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════╗"
echo "║   Ubuntu-WSL2-DevOps Setup Verification   ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}\n"

# System Information
echo -e "${BLUE}=== System Information ===${NC}"
echo "OS: $(lsb_release -s -d)"
echo "Kernel: $(uname -r)"
echo "User: $(whoami)"
echo "Home: $HOME"
echo ""

# Core Tools
echo -e "${BLUE}=== Core Tools ===${NC}"
check_command "Git" "git"
check_command "Docker" "docker"
check_command "Python 3" "python3"
check_command "Curl" "curl"
check_command "Wget" "wget"
echo ""

# Development Tools
echo -e "${BLUE}=== Development Tools ===${NC}"
check_command "GCC" "gcc"
check_command "Make" "make"
check_command "Nano" "nano"
check_command "Vim" "vim"
echo ""

# Configuration Files
echo -e "${BLUE}=== Configuration Files ===${NC}"
check_file ".bashrc" ~/.bashrc
check_file ".gitconfig" ~/.gitconfig
check_file ".ssh directory" ~/.ssh
echo ""

# Development Directories
echo -e "${BLUE}=== Development Directories ===${NC}"
check_directory "projects" ~/projects
check_directory "projects/devops" ~/projects/devops
check_directory "projects/docker" ~/projects/docker
check_directory "projects/kubernetes" ~/projects/kubernetes
echo ""

# Tool Versions
echo -e "${BLUE}=== Tool Versions ===${NC}"
echo "Git: $(git --version | awk '{print $3}')"
echo "Docker: $(docker --version | awk '{print $3}')"
echo "Python 3: $(python3 --version | awk '{print $2}')"
echo ""

# Git Configuration
echo -e "${BLUE}=== Git Configuration ===${NC}"
GIT_USER=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_USER" ]; then
    echo -e "${YELLOW}⚠${NC} Git user name not configured"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} Git user: $GIT_USER"
    ((PASSED++))
fi

if [ -z "$GIT_EMAIL" ]; then
    echo -e "${YELLOW}⚠${NC} Git email not configured"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} Git email: $GIT_EMAIL"
    ((PASSED++))
fi
echo ""

# Docker Status
echo -e "${BLUE}=== Docker Status ===${NC}"
if docker ps &> /dev/null; then
    echo -e "${GREEN}✓${NC} Docker is running"
    ((PASSED++))
    CONTAINER_COUNT=$(docker ps -q | wc -l)
    echo "  Running containers: $CONTAINER_COUNT"
else
    echo -e "${RED}✗${NC} Docker is not running"
    ((FAILED++))
fi
echo ""

# Packages
echo -e "${BLUE}=== Package Status ===${NC}"
PACKAGE_COUNT=$(apt list --installed 2>/dev/null | wc -l)
echo "Total packages installed: $PACKAGE_COUNT"

if [ "$PACKAGE_COUNT" -gt 500 ]; then
    echo -e "${GREEN}✓${NC} Good package count"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Lower than expected package count"
    ((WARNINGS++))
fi
echo ""

# File System
echo -e "${BLUE}=== File System ===${NC}"
if [ -d /mnt/c/Users ]; then
    echo -e "${GREEN}✓${NC} Windows C: drive accessible at /mnt/c"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Windows C: drive not accessible"
    ((FAILED++))
fi

DISK_USAGE=$(df -h ~ | awk 'NR==2 {print $5}')
echo "Home disk usage: $DISK_USAGE"
echo ""

# Final Summary
echo -e "${BLUE}=== Summary ===${NC}"
TOTAL=$((PASSED + FAILED + WARNINGS))
echo -e "Checks passed:  ${GREEN}${PASSED}${NC}"
echo -e "Checks failed:  ${RED}${FAILED}${NC}"
echo -e "Warnings:       ${YELLOW}${WARNINGS}${NC}"
echo -e "Total:          ${BLUE}${TOTAL}${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo -e "\n${BLUE}You're ready to start DevOps learning!${NC}"
    echo "Next steps:"
    echo "  1. Read: docs/08-NEXT-STEPS.md"
    echo "  2. Install Docker Compose: sudo apt install docker-compose-plugin"
    echo "  3. Run your first Docker container: docker run -it ubuntu:24.04"
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo "Review the failures above and refer to:"
    echo "  docs/07-TROUBLESHOOTING.md"
    exit 1
fi
