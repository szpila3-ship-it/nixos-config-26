# NixOS 26.05 – Lenovo Legion Go

Modular **NixOS 26.05 configuration** for an AMD-based handheld system
(Lenovo Legion Go–class hardware).

This repository contains **no secrets** and is safe to publish.

## Key points

- NixOS 26.05
- KDE Plasma 6 (Wayland)
- AMD GPU (amdgpu + RADV)
- Gaming stack: GameMode, Gamescope, MangoHud
- Handheld Daemon (hhd)
- Home Manager via NixOS module

## Notes

- `hardware-configuration.nix` is machine-specific and not tracked
- User passwords and SSH keys are configured locally
- Git uses SSH authentication
