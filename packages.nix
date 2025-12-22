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
    git

    # Sprawdzanie pisowni
    hunspell
    hunspellDicts.pl-pl

    # Edytory i narzędzia deweloperskie
    poedit

    # Ikony i motywy
    papirus-icon-theme

    # Narzędzia systemowe
    rustdesk
    qdirstat
    tealdeer
    fastfetch
    qpwgraph
    mesa-demos        # zawiera glxgears
    nh

    # Narzedzia Programistów
    vscodium
    nano
    neovim

    # Komunikatory
    discord
    signal-desktop
    telegram-desktop

    # Narzędzia dla trybu desktop/docking
    autorandr
    ddcutil
    brightnessctl
    powertop

    # Czcionki
    google-fonts

    # KDE i multimedia
    kdePackages.kdenlive
    avidemux
    haruna

    # Narzędzia KDE
    kdePackages.kate
    kdePackages.plasma-browser-integration

    # Dla KDE Plasma 6
    kdePackages.kconfig
    kdePackages.kservice

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
