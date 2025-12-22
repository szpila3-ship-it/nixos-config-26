# Installation – NixOS 26.05 configuration

This configuration is intended to be used directly from `/etc/nixos`.

## 1. Generate hardware configuration

sudo nixos-generate-config

Keep `hardware-configuration.nix` local and untracked.

## 2. Build system

sudo nixos-rebuild build

## 3. Activate

sudo nixos-rebuild switch

## 4. Set user password

sudo passwd user
