# gaming.nix
# Steam, Gamescope, GameMode, Lutris, Bottles
# HYBRYDA: stable system + unstable gaming stack

{ config, pkgs, lib, ... }:

{
  # =====================================================
  # STEAM
  # =====================================================

  programs.steam = {
    enable = true;
    package = pkgs.unstable.steam;

    gamescopeSession.enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # =====================================================
  # GAMEMODE
  # =====================================================

  programs.gamemode = {
    enable = true;
    enableRenice = true;

    settings = {
      general = {
        renice = 10;
        reaper_freq = 5;
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };

      cpu = {
        park_cores = "no";
        pin_policy = "none";
      };
    };
  };

  # =====================================================
  # GAMING PACKAGES
  # =====================================================

  environment.systemPackages = with pkgs; [
    # Monitoring
    unstable.mangohud
    unstable.goverlay

    # Proton / Wine tools
    unstable.protonup-qt
    unstable.protontricks
    unstable.winetricks

    # Launchery
    unstable.heroic
    unstable.lutris
    unstable.bottles

    # Wine
    unstable.wineWowPackages.staging

    # Compositor / performance
    unstable.gamescope
    gamemode

    # Input
    antimicrox
  ];

  # =====================================================
  # ENVIRONMENT
  # =====================================================

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "$HOME/.steam/root/compatibilitytools.d";
  };

  # =====================================================
  # HARDWARE / CONTROLLERS
  # =====================================================

  #hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;

  security.wrappers.gamemode = {
    owner = "root";
    group = "root";
    source = "${pkgs.gamemode}/bin/gamemoderun";
    capabilities = "cap_sys_nice+ep";
  };

  # =====================================================
  # FIREWALL
  # =====================================================

  networking.firewall = {
    allowedTCPPorts = [ 27036 27037 ];
    allowedUDPPorts = [ 27031 27036 ];
  };

  # =====================================================
  # FLATPAK (opcjonalne)
  # =====================================================

  services.flatpak.enable = true;

  # =====================================================
  # XDG PORTAL (KDE)
  # =====================================================

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };
}
