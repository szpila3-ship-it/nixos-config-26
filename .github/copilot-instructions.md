# AI Coding Guidelines for NixOS Legion Go Configuration

## Project Overview
This is a modular NixOS 26.05 configuration for Lenovo Legion Go handheld gaming device, optimized for AMD GPU, KDE Plasma 6, and gaming stack (GameMode, Gamescope, MangoHud).

## Architecture
- **Modular structure**: Main `configuration.nix` imports specialized modules (`packages.nix`, `services.nix`, `gaming.nix`, etc.)
- **Home Manager integration**: User-specific config via NixOS module in `home-manager.nix`
- **No flake**: Traditional `/etc/nixos` setup, not using flakes

## Key Files
- `configuration.nix`: Core config with imports and global settings
- `packages.nix`: System packages (browsers, tools, gaming software)
- `services.nix`: System services (handheld-daemon, Bluetooth, UDisks)
- `gaming.nix`: Gaming optimizations (GameMode, Gamescope, AMD GPU config)
- `desktop.nix`: KDE Plasma 6, Wayland, touch input, audio (Pipewire)

## Developer Workflows
- **Build**: `sudo nixos-rebuild build` (dry-run test)
- **Deploy**: `sudo nixos-rebuild switch` (apply changes)
- **Hardware config**: Generate with `sudo nixos-generate-config` (keep local, untracked)

## Conventions
- **Packages**: List in `environment.systemPackages` with overrides for Wayland (e.g., Google Chrome flags)
- **Services**: Enable via `services.*.enable = true`
- **Gaming**: Use `programs.gamemode` and `programs.gamescope` for handheld optimizations
- **Polish localization**: Keyboard layout `pl`, spellcheck `hunspellDicts.pl-pl`
- **Comments**: Polish language comments for clarity

## Patterns
- **AMD GPU**: Enable 32-bit graphics, RADV Vulkan, OpenCL via `hardware.graphics`
- **Handheld features**: `services.handheld-daemon` for device-specific controls
- **Environment variables**: Set scaling for 8.8" screen (`GDK_SCALE = "1.5"`)
- **Security**: Polkit rules for disk mounting in `services.nix`

## Examples
- Package override: `(google-chrome.override { commandLineArgs = ["--ozone-platform=wayland"]; })`
- Service config: `services.handheld-daemon = { enable = true; user = "draxmen"; }`
- Home Manager: `home-manager.users.draxmen.programs.git.enable = true;`

Focus on modular additions to existing files rather than rewriting. Test builds with `nixos-rebuild build` before switching.