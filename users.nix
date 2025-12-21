{ config, pkgs, ... }:

{
  # Utwórz grupy storage i plugdev
  users.groups.storage = {};
  users.groups.plugdev = {};
  
  # Użytkownicy
  users.users.draxmen = {
    isNormalUser = true;
    description = "Draxmen";
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" "plugdev" ];
    hashedPasswordFile = "/etc/nixos-secrets/draxmen-password";
    packages = with pkgs; [];
  };
}
