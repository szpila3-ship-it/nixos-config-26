{ config, pkgs, ... }:

{
  # ═══════════════════════════════════════════════════════════
  # GAMING - LEGION GO (bez Steam)
  # ═══════════════════════════════════════════════════════════
  
  # GameMode - automatyczne optymalizacje dla gier
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        ioprio = 0;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  # Gamescope - compositor dla gier (jak Steam Deck)
  programs.gamescope = {
    enable = true;
    capSysNice = true;  # Wyższy priorytet
  };

  # Wsparcie dla 32-bitowych bibliotek (potrzebne dla wielu gier)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    # RADV jest domyślnym sterownikiem Vulkan dla AMD
    extraPackages = with pkgs; [
      rocmPackages.clr.icd  # OpenCL dla AMD
    ];
  };

  # Dodatkowe narzędzia gaming
  environment.systemPackages = with pkgs; [
    # Gaming overlays i monitoring
    mangohud      # FPS counter, monitoring
    goverlay      # GUI dla MangoHud
    
    # Launchers (jeśli potrzebujesz)
    lutris        # Multi-platform launcher
    heroic        # Epic Games / GOG launcher
    
    # Monitoring GPU/CPU
    radeontop     # Monitoring GPU AMD
    
    # Wine dla gier Windows (opcjonalne - odkomentuj jeśli potrzebujesz)
    # wine
    # winetricks
  ];

  # Zmienne środowiskowe dla AMD GPU
  environment.sessionVariables = {
    # RADV jest domyślny
    WLR_RENDERER = "vulkan";
  };
}
