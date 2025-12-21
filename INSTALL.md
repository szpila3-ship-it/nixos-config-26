# Installation Guide - NixOS on Lenovo Legion Go

This guide will help you install this NixOS configuration on your Lenovo Legion Go.

## Prerequisites

- ✅ Lenovo Legion Go
- ✅ NixOS 25.11 already installed (fresh or existing)
- ✅ Basic terminal knowledge
- ✅ Backup of important data

## Installation Steps

### Step 1: Clone Repository

```bash
cd ~
git clone https://github.com/szpila3-ship-it/nixos-config.git
cd nixos-config
```

### Step 2: Backup Current Configuration

**IMPORTANT:** Always backup before making changes!

```bash
sudo cp -r /etc/nixos /etc/nixos.backup.$(date +%Y%m%d)
```

### Step 3: Generate Hardware Configuration

Your Legion Go has unique hardware identifiers. Generate them:

```bash
sudo nixos-generate-config --show-hardware-config > /tmp/hardware-temp.nix
```

**Review the file:**
```bash
cat /tmp/hardware-temp.nix
```

It should contain:
- NVMe drive UUID
- AMD CPU settings
- Kernel modules

### Step 4: Copy Configuration Files

```bash
# Copy all .nix files EXCEPT hardware-configuration.nix
sudo cp ~/nixos-config/configuration.nix /etc/nixos/
sudo cp ~/nixos-config/boot.nix /etc/nixos/
sudo cp ~/nixos-config/desktop.nix /etc/nixos/
sudo cp ~/nixos-config/gaming.nix /etc/nixos/
sudo cp ~/nixos-config/networking.nix /etc/nixos/
sudo cp ~/nixos-config/locale.nix /etc/nixos/
sudo cp ~/nixos-config/users.nix /etc/nixos/
sudo cp ~/nixos-config/packages.nix /etc/nixos/
sudo cp ~/nixos-config/services.nix /etc/nixos/
sudo cp ~/nixos-config/sync.nix /etc/nixos/
sudo cp ~/nixos-config/home-manager.nix /etc/nixos/

# Copy YOUR hardware config
sudo cp /tmp/hardware-temp.nix /etc/nixos/hardware-configuration.nix
```

### Step 5: Customize User Settings

**Edit users.nix:**
```bash
sudo nano /etc/nixos/users.nix
```

Change:
```nix
users.users.draxmen = {  # ← Change "draxmen" to your username
  isNormalUser = true;
  description = "Your Name";  # ← Your name
  # Set password: sudo passwd yourusername
```

**Edit home-manager.nix:**
```bash
sudo nano /etc/nixos/home-manager.nix
```

Change:
```nix
home-manager.users.draxmen = {  # ← Change to your username
  # Line ~95:
  settings = {
    user.name = "Your Name";  # ← Your name
    user.email = "your@email.com";  # ← Your email
```

### Step 6: Review Configuration

Check if all imports are correct:

```bash
cat /etc/nixos/configuration.nix
```

Should contain:
```nix
imports = [
  ./hardware-configuration.nix
  ./boot.nix
  ./desktop.nix
  ./gaming.nix
  ./networking.nix
  ./locale.nix
  ./users.nix
  ./packages.nix
  ./services.nix
  ./sync.nix
  ./home-manager.nix
];
```

### Step 7: Test Configuration

**Dry-run to check for errors:**
```bash
sudo nixos-rebuild dry-build
```

If you see errors, fix them before proceeding!

### Step 8: Build System

```bash
sudo nixos-rebuild switch
```

This will:
- Download all packages
- Build the system
- Activate the new configuration

**This may take 10-30 minutes!** ☕

### Step 9: Set User Password

If you created a new user:
```bash
sudo passwd yourusername
```

### Step 10: Reboot

```bash
reboot
```

## Post-Installation

### First Boot Checklist

After reboot, verify:

- [ ] System boots successfully
- [ ] Login works
- [ ] Display is correct (orientation, resolution)
- [ ] Touch screen works
- [ ] Sound works (test speakers)
- [ ] WiFi connects
- [ ] Bluetooth works
- [ ] Controllers are recognized
- [ ] Battery indicator shows

### Test Gaming Features

```bash
# Check GameMode
gamemoded -s

# Check Handheld Daemon
systemctl --user status hhd@$(whoami)

# Test MangoHud
mangohud glxinfo

# Test GPU monitoring
radeontop
```

### Setup GitHub Sync (Optional)

If you want to sync changes back to GitHub:

```bash
# Configure git in home-manager.nix (already done in Step 5)
# Then use:
sudo nixos-sync
```

## Troubleshooting

### Build Fails with "undefined variable"

**Problem:** Missing package or typo in configuration.

**Solution:**
```bash
# Check which file has the error
sudo nixos-rebuild switch --show-trace

# Fix the file
sudo nano /etc/nixos/FILENAME.nix

# Try again
sudo nixos-rebuild switch
```

### Boot Partition Full

**Problem:** `/boot` is full after too many rebuilds.

**Solution:**
```bash
# Clean old generations
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
sudo nix-collect-garbage -d

# Try rebuild again
sudo nixos-rebuild switch
```

### System Won't Boot

**Problem:** Configuration error broke the system.

**Solution:**
1. At bootloader, select previous generation
2. Boot into working system
3. Fix configuration
4. Rebuild

Or restore backup:
```bash
sudo cp -r /etc/nixos.backup.YYYYMMDD/* /etc/nixos/
sudo nixos-rebuild switch
```

### Display Rotation Wrong

```bash
# KDE Wayland:
kscreen-doctor output.eDP-1.rotation.normal  # or: left, right, inverted

# Make permanent in desktop.nix
```

### Controllers Not Working

```bash
# Check handheld-daemon
systemctl --user status hhd@$(whoami)

# Restart if needed
systemctl --user restart hhd@$(whoami)

# Check logs
journalctl --user -u hhd@$(whoami) -f
```

## Customization After Install

### Add More Packages

```bash
sudo nano /etc/nixos/packages.nix
# Add packages to environment.systemPackages
sudo nixos-rebuild switch
```

### Change Keyboard Layout

```bash
sudo nano /etc/nixos/locale.nix
# Change layout and keyMap
sudo nixos-rebuild switch
```

### Adjust UI Scaling

```bash
sudo nano /etc/nixos/desktop.nix
# Change GDK_SCALE value (1.25, 1.5, 1.75, 2.0)
sudo nixos-rebuild switch
```

## Rollback

If anything goes wrong:

```bash
# See available generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous
sudo nixos-rebuild switch --rollback

# Or boot into specific generation from bootloader
```

## Clean Up

Remove installation files:

```bash
rm -rf ~/nixos-config
rm /tmp/hardware-temp.nix
```

## Next Steps

- Explore KDE Plasma 6 settings
- Install games via Lutris or Heroic
- Test GameMode with games
- Customize appearance
- Join Legion Go community: r/LegionGo

## Need Help?

- Check logs: `journalctl -b`
- Ask on NixOS Discourse: https://discourse.nixos.org/
- Reddit: r/NixOS, r/LegionGo
- GitHub Issues: Open an issue in this repo

---

**Happy gaming on Legion Go with NixOS!** 🎮✨
