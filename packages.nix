{ config, pkgs, ... }:

{
  # Programy systemowe
  environment.systemPackages = with pkgs; [
    # Przeglądarki
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"
      ];
    })
    firefox

    # Narzędzia podstawowe
    vim
    wget
    qdirstat
    rustdesk
    tealdeer

    # Sprawdzanie pisowni
    hunspell
    hunspellDicts.pl-pl

    # Edytory i narzędzia deweloperskie
    poedit

    # Narzędzia programistyczne
    nano
    neovim
    vscodium

    # Komunikatory
    discord
    signal-desktop
    telegram-desktop

    # Narzędzia KDE
    kdePackages.kate
    kdePackages.kdenlive
    kdePackages.kconfig
    kdePackages.kservice
    kdePackages.plasma-browser-integration

    # Ikony i motywy
    papirus-icon-theme

    # Narzędzia systemowe
    autorandr
    ddcutil
    brightnessctl
    powertop
    mesa-demos        # zawiera glxgears
    nh
    fastfetch

    # Czcionki
    google-fonts

    # Multiemdia
    avidemux
    haruna

    # ═══════════════════════════════════════════════════════════
    # NARZĘDZIA SPECYFICZNE DLA LEGION GO / HANDHELDA
    # ═══════════════════════════════════════════════════════════
    
    # Monitoring i kontrola
    radeontop         # Monitoring GPU AMD
    lm_sensors        # Temperatury CPU
    htop              # Monitor procesów
    
    # Kontrola jasności i energii
    acpi              # Status baterii
    
    # Narzędzia do rotacji ekranu
    wdisplays         # GUI do konfiguracji wyświetlaczy (Wayland)
    
    # Audio tools
    pavucontrol       # Kontrola audio (GUI)
    helvum            # Patchbay dla PipeWire
    
    # Kontrolery i gamepad
    antimicrox        # Mapowanie gamepad -> klawiatura/mysz
    
    # Wsparcie dla ekranu dotykowego
    xorg.xinput       # Konfiguracja urządzeń wejściowych
  ];
}

