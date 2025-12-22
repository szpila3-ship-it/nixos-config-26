{ config, pkgs, ... }:

{
  # KDE Plasma 6 - zoptymalizowane dla handhelda
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;  # Wayland dla lepszej wydajności i battery
  };
  
  services.desktopManager.plasma6.enable = true;

  # Włącz X11 (potrzebne dla niektórych gier i narzędzi)
  services.xserver = {
    enable = true;
    
    xkb = {
      layout = "pl";
      variant = "";
    };
  };


  # Session management - zapisywanie stanu sesji
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file ksmserverrc --group General --key loginMode restoreSavedSession
  '';

  # Libinput - ekran dotykowy i touchpad
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = false;
    mouse.naturalScrolling = false;
    
    # Konfiguracja dla ekranu dotykowego
    touchpad = {
      tapping = true;
      disableWhileTyping = true;
      middleEmulation = true;
      scrollMethod = "twofinger";
    };
  };

  # Dźwięk - Pipewire (najlepsze dla handhelda)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;  # Dla gier 32-bit
    pulse.enable = true;
    jack.enable = true;  # Dla profesjonalnego audio (opcjonalne)
    
    # Niska latencja dla gamingu
    wireplumber.enable = true;
  };

  # ═══════════════════════════════════════════════════════════
  # OPTYMALIZACJE DLA LEGION GO (małego ekranu 8.8")
  # ═══════════════════════════════════════════════════════════
  
  # Zmienne środowiskowe dla lepszego skalowania
  environment.sessionVariables = {
    # Skalowanie dla małego ekranu
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    GDK_SCALE = "1.5";  # Dostosuj jeśli tekst jest za mały/duży
    GDK_DPI_SCALE = "1";
    
    # Wayland
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
