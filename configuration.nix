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
  

  # Wersja systemu
  system.stateVersion = "24.05";
}
