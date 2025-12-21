{ config, pkgs, ... }:

{
  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Wsparcie dla Ethernet przez hub/dock
  networking.usePredictableInterfaceNames = true;

  # Firewall
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
