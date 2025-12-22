{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./desktop.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./packages.nix
    ./services.nix
    ./sync.nix
    # Home Manager (NixOS module)
    <home-manager/nixos>
    ./home-manager.nix
    ./gaming.nix
  ];

  nixpkgs.config.allowUnfree = true;
  
  # Sublime Text 4 (build 4200) to proprietary binary prekompilowany
  # z OpenSSL 1.1.1. Nie można go przebudować z nowszym OpenSSL.
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Wersja systemu
  system.stateVersion = "24.05";
}
