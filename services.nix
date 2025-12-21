{ config, pkgs, ... }:

{
  # Automatyczne montowanie dysków USB
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  # Zarządzanie energią dla dockingu
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Handheld Daemon dla kontrolera i TDP (Legion Go)
  services.handheld-daemon = {
    enable = true;
    user = "draxmen";
  };

  # Bluetooth dla akcesoriów
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  # Reguły PolicyKit dla montowania
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
          action.id == "org.freedesktop.udisks2.filesystem-mount") {
        if (subject.isInGroup("wheel") || subject.isInGroup("storage")) {
          return polkit.Result.YES;
        }
      }
    });
  '';
}
