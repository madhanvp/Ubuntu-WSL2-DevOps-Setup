# 00 - PREREQUISITES CHECKLIST

## ✅ Before You Start: Complete Checklist

### 🖥️ Hardware Requirements

- [ ] **Computer Type:** Windows 11 PC or Laptop
- [ ] **RAM:** Minimum 4GB (8GB+ recommended)
- [ ] **Disk Space:** At least 20GB free (SSD preferred)
- [ ] **Processor:** 64-bit processor with virtualization support
- [ ] **Motherboard BIOS:** Virtualization enabled (Intel VT-x or AMD-V)

### 🔑 Software Prerequisites

- [ ] **OS:** Windows 11 (Home, Pro, Enterprise, or Education edition)
- [ ] **Admin Access:** Administrator account available
- [ ] **Internet Connection:** Stable, working connection
- [ ] **Windows Update:** System fully updated
- [ ] **Antivirus:** Compatible with WSL2 (Windows Defender is fine)

### 🔧 System Configuration

#### Virtualization Check (Windows 11):

```powershell
# Open PowerShell as Administrator and run:
wsl --status

# Expected output:
# Default Distribution: Ubuntu
# Default Version: 2
```

#### Check Hyper-V Support:

```powershell
# Run as Administrator:
systeminfo | findstr /I "Hyper-V"

# Look for:
# Hyper-V Capable: Yes
```

#### Check Processor Virtualization:

**Intel Processors:**
- [ ] Intel VT-x (Virtualization Technology) enabled in BIOS

**AMD Processors:**
- [ ] AMD-V (Virtualization) enabled in BIOS

**How to enable (if disabled):**
1. Restart your computer
2. Enter BIOS (usually F2, Del, F10, or F12 during startup)
3. Look for "Virtualization" or "VT-x" or "AMD-V" settings
4. Enable the option
5. Save and exit BIOS
6. Restart Windows

### 📋 Windows 11 Features Required

Enable these Windows features (all usually enabled by default in Windows 11):

```powershell
# Run PowerShell as Administrator:

# Enable WSL2 (includes Hyper-V, VirtualMachinePlatform)
wsl --install

# This automatically enables:
# ✓ Windows Subsystem for Linux
# ✓ Virtual Machine Platform
# ✓ Hyper-V features
```

#### Alternative: Manual Enable

If `wsl --install` doesn't work, enable manually:

```powershell
# Run as Administrator:
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart your computer
Restart-Computer

# Set WSL2 as default
wsl --set-default-version 2
```

### 🌐 Download Requirements

You'll need to download/install during setup:

- [ ] **Ubuntu 24.04.3 LTS** from Microsoft Store (350 MB)
- [ ] **Windows Terminal** (optional but recommended) from Microsoft Store

**Total Download:** ~400-500 MB  
**Internet Speed:** At least 1-2 Mbps  
**Time to Download:** 5-10 minutes

### 📱 Alternative: Offline Installation

If you don't have Microsoft Store access:

```powershell
# Download directly from Microsoft:
# https://aka.ms/wslubuntu2404

# Then install manually:
Add-AppxPackage .\Ubuntu_24.04.lts.AppxBundle
```

### 🔐 Security Settings

- [ ] **Windows Defender:** Should NOT block WSL2
- [ ] **Firewall:** Should allow WSL2 internal networking
- [ ] **Antivirus:** No conflicts with WSL2
- [ ] **Group Policy (if on Pro/Enterprise):** No restrictive policies

**To check firewall:**
```powershell
# Check if Windows Defender Firewall is on:
Get-NetFirewallProfile | Select-Object Name, Enabled
```

### 🖥️ Your Current System (HP Victus 15)

- [ ] **Model:** HP Victus 15 Laptop
- [ ] **OS:** Windows 11 (confirmed)
- [ ] **Processor:** Intel or AMD (check via Settings)
- [ ] **RAM:** Verify 8GB+ installed
- [ ] **Storage:** 20GB+ free space verified

**Check your specs:**
```powershell
# Open PowerShell and run:
systeminfo

# Look for:
# - OS Name: Windows 11
# - System Manufacturer: HP Inc.
# - Processor: [Your CPU details]
# - Total Physical Memory: [Your RAM]
```

### 📖 Knowledge Checklist

- [ ] **Comfortable with:** Command line / Terminal basics
- [ ] **Understood:** What WSL2 is (Linux on Windows)
- [ ] **Know:** File paths (C:\Users\, /home/, etc.)
- [ ] **Ready for:** Learning container technology

### ⏱️ Time Allocation

- **Initial Setup:** 45-60 minutes (one-time)
- **Regular Usage:** No additional setup needed
- **Updates:** 10-15 minutes per Windows/Ubuntu update

### 📝 Pre-Setup Checklist

Print or bookmark this checklist:

```
BEFORE STARTING INSTALLATION:

□ Administrator access confirmed
□ Windows 11 fully updated
□ Virtualization enabled in BIOS
□ Hyper-V features enabled
□ 20GB free disk space verified
□ Internet connection stable
□ No antivirus conflicts
□ System restarted (if enabling virtualization)
□ Time allocated: 45-60 minutes
□ All prerequisites reviewed
```

### 🚨 Common Issues Before You Start

**"WSL2 not available in my Windows 11?"**
- Your Windows 11 build must be 22621 or later
- Update Windows: Settings → Update & Security → Check for updates

**"Virtualization disabled?"**
- Enable it in BIOS (different per manufacturer)
- Contact HP Victus support if unsure

**"Microsoft Store not available?"**
- Use offline installation method (see Download Requirements)

**"Not enough disk space?"**
- Free up space or use external SSD
- Minimum 20GB for comfortable use

### 🎯 You're Ready When:

✅ All prerequisites checked  
✅ Virtualization enabled  
✅ 20GB free space confirmed  
✅ Admin access available  
✅ Internet connection working  
✅ 45-60 minutes available  

---

## 🚀 Next Step

Once you've completed this checklist, proceed to:

**[→ WSL2 BASICS: Understanding WSL2](01-WSL2-BASICS.md)**
