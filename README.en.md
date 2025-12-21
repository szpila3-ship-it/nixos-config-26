# NixOS Configuration for Lenovo Legion Go

![NixOS](https://img.shields.io/badge/NixOS-25.11-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Lenovo%20Legion%20Go-red.svg)
![Desktop](https://img.shields.io/badge/Desktop-KDE%20Plasma%206-blue.svg)
![Locale](https://img.shields.io/badge/Locale-Polish-red.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

Personal NixOS configuration optimized for **Lenovo Legion Go** handheld gaming device.

**English version** | [Wersja polska (Polish)](README.pl.md)

## 🎮 Hardware

- **Device**: Lenovo Legion Go
- **CPU**: AMD Ryzen Z1 Extreme
- **GPU**: AMD Radeon Graphics (RDNA 3)
- **RAM**: 16GB
- **Display**: 8.8" 2560x1600 @ 144Hz
- **Storage**: NVMe SSD

## ✨ Features

### Gaming Optimizations
- ✅ **Handheld Daemon** - Legion Go controller support, TDP control, fan management
- ✅ **GameMode** - Automatic performance optimizations for games
- ✅ **Gamescope** - Gaming compositor (Steam Deck style)
- ✅ **MangoHud** - FPS overlay and performance monitoring
- ✅ **Vulkan (RADV)** - AMD GPU drivers with full Vulkan support
- ✅ **32-bit library support** - For older games

### Desktop Environment
- ✅ **KDE Plasma 6** on Wayland
- ✅ **Pipewire** - Modern audio system with low latency
- ✅ **Touch screen support** - Full libinput configuration
- ✅ **UI scaling** - Optimized for 8.8" high-DPI screen
- ✅ **Session restore** - Automatic session saving

### System
- ✅ **Latest kernel** - Best hardware support for handheld
- ✅ **AMD GPU optimizations** - Full ppfeaturemask, power management
- ✅ **zramSwap** - 50% RAM compression for better performance
- ✅ **Power management** - schedutil governor, battery optimization
- ✅ **Bluetooth** - Controller and accessory support

### Polish Localization
- ✅ **System language**: Polish
- ✅ **Keyboard layout**: Polish (pl)
- ✅ **Timezone**: Europe/Warsaw
- ✅ **Spell checker**: Hunspell Polish dictionary
- ✅ **Date/time format**: Polish format

### Development & Tools
- Google Chrome (Wayland-native)
- Firefox
- Sublime Text 4
- Discord, Signal, Telegram
- Git, Vim, Nano
- And more...

## 📁 Configuration Structure

```
/etc/nixos/
├── configuration.nix       # Main configuration file
├── boot.nix               # Bootloader, kernel, AMD GPU settings
├── desktop.nix            # KDE Plasma 6, Wayland, display settings
├── gaming.nix             # GameMode, Gamescope, MangoHud
├── networking.nix         # Network configuration
├── locale.nix             # Language and timezone (Polish)
├── users.nix              # User accounts
├── packages.nix           # System packages
├── services.nix           # Handheld daemon, Bluetooth, power management
├── sync.nix               # GitHub sync script
├── home-manager.nix       # User-specific configuration
└── hardware-configuration.nix  # Auto-generated hardware config
```

## 🚀 Installation

### Prerequisites
- NixOS 25.11 installed on Legion Go
- Basic NixOS knowledge

### Quick Start

1. **Clone this repository:**
```bash
git clone https://github.com/szpila3-ship-it/nixos-config.git ~/nixos-config
```

2. **Backup your current configuration:**
```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

3. **Copy configuration files:**
```bash
sudo cp ~/nixos-config/*.nix /etc/nixos/
```

4. **Generate your hardware configuration:**
```bash
sudo nixos-generate-config --show-hardware-config > /tmp/hardware.nix
sudo cp /tmp/hardware.nix /etc/nixos/hardware-configuration.nix
```

5. **Edit user settings:**
```bash
sudo nano /etc/nixos/users.nix  # Set your username/password
sudo nano /etc/nixos/home-manager.nix  # Set your Git email
```

6. **Rebuild system:**
```bash
sudo nixos-rebuild switch
```

7. **Reboot:**
```bash
reboot
```

## 🛠️ Customization

### Change UI Scaling
If text is too small/large on the 8.8" screen, edit `desktop.nix`:

```nix
environment.sessionVariables = {
  GDK_SCALE = "1.5";  # Try: 1.25, 1.5, 1.75, or 2.0
};
```

### Add More Packages
Edit `packages.nix` and add packages to `environment.systemPackages`:

```nix
environment.systemPackages = with pkgs; [
  # Your packages here
  steam
  vscode
  # etc...
];
```

### Change Power Profile
Edit `boot.nix`:

```nix
# For better performance:
powerManagement.cpuFreqGovernor = "performance";

# For better battery life:
powerManagement.cpuFreqGovernor = "powersave";

# Balanced (default):
powerManagement.cpuFreqGovernor = "schedutil";
```

## 📝 Useful Commands

### System Management
```bash
nos              # Rebuild system (alias for sudo nixos-rebuild switch)
noc              # Clean old generations (alias for sudo nix-collect-garbage -d)
nol              # List generations
nor              # Rollback to previous generation
nixsync          # Sync configuration to GitHub
```

### Gaming
```bash
gamemoderun <game>        # Run game with GameMode
mangohud <game>           # Run game with MangoHud overlay
radeontop                 # Monitor AMD GPU usage
gamemoded -s              # Check GameMode status
```

### Monitoring
```bash
htop                      # CPU/RAM monitor
radeontop                 # GPU monitor
sensors                   # Temperature monitoring
acpi                      # Battery status
powertop                  # Power consumption analysis
```

## 🎯 Gaming Setup

### Lutris
1. Install game through Lutris
2. Right-click game → Configure
3. System options → Enable GameMode ✅
4. Launch game - GameMode activates automatically!

### Heroic Games Launcher
1. Settings → Advanced
2. Enable GameMode ✅
3. Enable MangoHud for FPS overlay

### Manual Launch
```bash
gamemoderun mangohud ./your-game
```

## 🔧 Handheld Daemon Features

The `handheld-daemon` provides:
- **Controller support** - Legion Go controllers work as standard gamepads
- **TDP control** - Adjust power limits (10W-30W)
- **Fan control** - Manual or automatic fan curves
- **QAM** - Quick Access Menu (press Legion button)
- **Gyroscope support** - For motion controls

Access settings: Press **Legion button** or check system settings.

## 🐛 Troubleshooting

### Screen rotation is wrong
```bash
# For Wayland (KDE)
kscreen-doctor output.eDP-1.rotation.normal  # or: left, right, inverted
```

### Touch screen not working
```bash
# Check devices
xinput list

# Test touch
evtest
```

### GameMode not activating
```bash
# Check status
gamemoded -s

# Check logs
journalctl -u gamemode -f
```

### Battery drains too fast
```bash
# Check power consumption
powertop

# Use powersave governor
sudo nano /etc/nixos/boot.nix
# Set: cpuFreqGovernor = "powersave";
sudo nixos-rebuild switch
```

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Handheld Daemon Documentation](https://github.com/hhd-dev/hhd)
- [Legion Go on Linux](https://www.reddit.com/r/LegionGo/)
- [Arch Wiki - Legion Go](https://wiki.archlinux.org/title/Lenovo_Legion_Go)

## 🤝 Contributing

Feel free to:
- Report issues
- Suggest improvements
- Share your optimizations

## 📄 License

MIT License - feel free to use and modify!

## 🙏 Credits

- [NixOS](https://nixos.org/) - The declarative Linux distribution
- [Handheld Daemon](https://github.com/hhd-dev/hhd) - Legion Go controller support
- Legion Go community on Reddit and Discord

## 📮 Contact

- GitHub: [@szpila3-ship-it](https://github.com/szpila3-ship-it)

---

**Enjoy gaming on Legion Go with NixOS!** 🎮✨
